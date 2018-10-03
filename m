Return-Path: <SRS0=Y6U6=MP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D6C00449
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 08:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE58C2089F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 08:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x2XFg+XX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE58C2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJCPoe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:44:34 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35462 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJCPoe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Oct 2018 11:44:34 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w938v0Dq007068;
        Wed, 3 Oct 2018 03:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538557020;
        bh=JLMHPgstsItru8fhGiq7WWVBytJyVNYABdWIbulmpaw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=x2XFg+XXarbI8e0m1cAD5LPqX/arZotfRqBUnLdhQ6fcuinoc4YEKRoLtx6s/uOgJ
         cRvIr0GBkMAK7pc99YonELlvRHNdMIaSn/49vtTBHFsVwnHikMTtH3DFO3ZE21j1cC
         025sv4IUUC4C18r/an9YPxLapqia7M+lxJFoToGo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w938v0Lg026143;
        Wed, 3 Oct 2018 03:57:00 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 3 Oct
 2018 03:57:00 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 3 Oct 2018 03:57:00 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w938uvY5022885;
        Wed, 3 Oct 2018 03:56:58 -0500
Subject: Re: [PATCH] tools/pci: Change pcitest compiling process
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <corbet@lwn.net>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <f543d460ccff7891aa08c744fb675eb2c11fb2e7.1535025221.git.gustavo.pimentel@synopsys.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1130371f-8869-1ff2-d050-eeb07caf56d3@ti.com>
Date:   Wed, 3 Oct 2018 14:26:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f543d460ccff7891aa08c744fb675eb2c11fb2e7.1535025221.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On Thursday 23 August 2018 05:25 PM, Gustavo Pimentel wrote:
> Change tool compiling process in order to be build using the same
> mechanism used in other linux tools (e.g. iio, perf, etc). This will
> allow in future the buildroot tool to build and integrate this tool in
> a more expeditious way.
> 
> Update documentation accordingly.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/PCI/endpoint/pci-test-howto.txt | 19 ++++++----
>  tools/Makefile                                | 13 ++++---
>  tools/pci/Build                               |  1 +
>  tools/pci/Makefile                            | 53 +++++++++++++++++++++++++++
>  4 files changed, 72 insertions(+), 14 deletions(-)
>  create mode 100644 tools/pci/Build
>  create mode 100644 tools/pci/Makefile
> 
> diff --git a/Documentation/PCI/endpoint/pci-test-howto.txt b/Documentation/PCI/endpoint/pci-test-howto.txt
> index 75f48c3..16df733 100644
> --- a/Documentation/PCI/endpoint/pci-test-howto.txt
> +++ b/Documentation/PCI/endpoint/pci-test-howto.txt
> @@ -98,17 +98,20 @@ Note that the devices listed here correspond to the value populated in 1.4 above
>  2.2 Using Endpoint Test function Device
>  
>  pcitest.sh added in tools/pci/ can be used to run all the default PCI endpoint
> -tests. Before pcitest.sh can be used pcitest.c should be compiled using the
> -following commands.
> +tests. To compile this tool the following commands should be used:
>  
> -	cd <kernel-dir>
> -	make headers_install ARCH=arm
> -	arm-linux-gnueabihf-gcc -Iusr/include tools/pci/pcitest.c -o pcitest
> -	cp pcitest  <rootfs>/usr/sbin/
> -	cp tools/pci/pcitest.sh <rootfs>
> +	# cd <kernel-dir>
> +	# make -C tools/pci
> +
> +or if you desire to compile and install in your system:
> +
> +	# cd <kernel-dir>
> +	# make -C tools/pci install
> +
> +The tool and script will be located in <rootfs>/usr/bin/
>  
>  2.2.1 pcitest.sh Output
> -	# ./pcitest.sh
> +	# pcitest.sh
>  	BAR tests
>  
>  	BAR0:           OKAY
> diff --git a/tools/Makefile b/tools/Makefile
> index be02c8b..abb358a 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -21,6 +21,7 @@ help:
>  	@echo '  leds                   - LEDs  tools'
>  	@echo '  liblockdep             - user-space wrapper for kernel locking-validator'
>  	@echo '  bpf                    - misc BPF tools'
> +	@echo '  pci                    - PCI tools'
>  	@echo '  perf                   - Linux performance measurement and analysis tool'
>  	@echo '  selftests              - various kernel selftests'
>  	@echo '  spi                    - spi tools'
> @@ -59,7 +60,7 @@ acpi: FORCE
>  cpupower: FORCE
>  	$(call descend,power/$@)
>  
> -cgroup firewire hv guest spi usb virtio vm bpf iio gpio objtool leds wmi: FORCE
> +cgroup firewire hv guest spi usb virtio vm bpf iio gpio objtool leds wmi pci: FORCE
>  	$(call descend,$@)
>  
>  liblockdep: FORCE
> @@ -94,7 +95,7 @@ kvm_stat: FORCE
>  all: acpi cgroup cpupower gpio hv firewire liblockdep \
>  		perf selftests spi turbostat usb \
>  		virtio vm bpf x86_energy_perf_policy \
> -		tmon freefall iio objtool kvm_stat wmi
> +		tmon freefall iio objtool kvm_stat wmi pci
>  
>  acpi_install:
>  	$(call descend,power/$(@:_install=),install)
> @@ -102,7 +103,7 @@ acpi_install:
>  cpupower_install:
>  	$(call descend,power/$(@:_install=),install)
>  
> -cgroup_install firewire_install gpio_install hv_install iio_install perf_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install:
> +cgroup_install firewire_install gpio_install hv_install iio_install perf_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install:
>  	$(call descend,$(@:_install=),install)
>  
>  liblockdep_install:
> @@ -128,7 +129,7 @@ install: acpi_install cgroup_install cpupower_install gpio_install \
>  		perf_install selftests_install turbostat_install usb_install \
>  		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
>  		tmon_install freefall_install objtool_install kvm_stat_install \
> -		wmi_install
> +		wmi_install pci_install
>  
>  acpi_clean:
>  	$(call descend,power/acpi,clean)
> @@ -136,7 +137,7 @@ acpi_clean:
>  cpupower_clean:
>  	$(call descend,power/cpupower,clean)
>  
> -cgroup_clean hv_clean firewire_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean:
> +cgroup_clean hv_clean firewire_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean:
>  	$(call descend,$(@:_clean=),clean)
>  
>  liblockdep_clean:
> @@ -174,6 +175,6 @@ clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean \
>  		perf_clean selftests_clean turbostat_clean spi_clean usb_clean virtio_clean \
>  		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
>  		freefall_clean build_clean libbpf_clean libsubcmd_clean liblockdep_clean \
> -		gpio_clean objtool_clean leds_clean wmi_clean
> +		gpio_clean objtool_clean leds_clean wmi_clean pci_clean
>  
>  .PHONY: FORCE
> diff --git a/tools/pci/Build b/tools/pci/Build
> new file mode 100644
> index 0000000..c375aea
> --- /dev/null
> +++ b/tools/pci/Build
> @@ -0,0 +1 @@
> +pcitest-y += pcitest.o
> diff --git a/tools/pci/Makefile b/tools/pci/Makefile
> new file mode 100644
> index 0000000..46e4c2f
> --- /dev/null
> +++ b/tools/pci/Makefile
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0
> +include ../scripts/Makefile.include
> +
> +bindir ?= /usr/bin
> +
> +ifeq ($(srctree),)
> +srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +endif
> +
> +# Do not use make's built-in rules
> +# (this improves performance and avoids hard-to-debug behaviour);
> +MAKEFLAGS += -r
> +
> +CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> +
> +ALL_TARGETS := pcitest pcitest.sh
> +ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
> +
> +all: $(ALL_PROGRAMS)
> +
> +export srctree OUTPUT CC LD CFLAGS
> +include $(srctree)/tools/build/Makefile.include
> +
> +#
> +# We need the following to be outside of kernel tree
> +#
> +$(OUTPUT)include/linux/: ../../include/uapi/linux/
> +	mkdir -p $(OUTPUT)include/linux/ 2>&1 || true
> +	ln -sf $(CURDIR)/../../include/uapi/linux/pcitest.h $@
> +
> +prepare: $(OUTPUT)include/linux/
> +
> +PCITEST_IN := $(OUTPUT)pcitest-in.o
> +$(PCITEST_IN): prepare FORCE
> +	$(Q)$(MAKE) $(build)=pcitest
> +$(OUTPUT)pcitest: $(PCITEST_IN)
> +	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
> +
> +clean:
> +	rm -f $(ALL_PROGRAMS)
> +	rm -rf $(OUTPUT)include/
> +	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> +
> +install: $(ALL_PROGRAMS)
> +	install -d -m 755 $(DESTDIR)$(bindir);		\
> +	for program in $(ALL_PROGRAMS); do		\
> +		install $$program $(DESTDIR)$(bindir);	\
> +	done
> +
> +FORCE:
> +
> +.PHONY: all install clean FORCE prepare
> 
