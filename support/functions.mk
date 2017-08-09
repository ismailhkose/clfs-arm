define check_source
	@if ! [ -f $(1) ] ; then \
		wget $(3) -c -P $(SOURCES_DIR) 2>&1 >/dev/null; true ; \
	else \
		if ! [ `md5sum $(1)  | cut -d ' ' -f 1` = $(2) ] ; then \
			wget $(3) -c -P $(SOURCES_DIR) 2>&1 >/dev/null; true ; \
		fi; \
	fi;
endef

define dependency_libs_patch
	for lib in $(SYSROOT_DIR)/usr/lib/*.la ; do \
		dependency_libs_line=`grep -n "dependency_libs=" $${lib} | cut -d':' -f1` ; \
		sed -i "s@ /usr/lib/\(.*\).la@ $(SYSROOT_DIR)/usr/lib/\1.la@g" $${lib} ; \
	done;
endef
