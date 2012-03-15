Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:44836 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab2COGk3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Mar 2012 02:40:29 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8C93E3EE0BC
	for <linux-pci@vger.kernel.org>; Thu, 15 Mar 2012 15:40:27 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7776C45DE50
	for <linux-pci@vger.kernel.org>; Thu, 15 Mar 2012 15:40:27 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 606F045DE4F
	for <linux-pci@vger.kernel.org>; Thu, 15 Mar 2012 15:40:27 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5246F1DB802F
	for <linux-pci@vger.kernel.org>; Thu, 15 Mar 2012 15:40:27 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id F3526E08001
	for <linux-pci@vger.kernel.org>; Thu, 15 Mar 2012 15:40:26 +0900 (JST)
From: "Taku Izumi" <izumi.taku@jp.fujitsu.com>
To: "'Yinghai Lu'" <yinghai@kernel.org>
Cc: <linux-pci@vger.kernel.org>
References: <1330570837-26638-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330570837-26638-1-git-send-email-yinghai@kernel.org>
Subject: RE: [PATCH -v2 00/36] PCI: pci_host_bridge related cleanup and busn_alloc
Date: Thu, 15 Mar 2012 15:40:14 +0900
Message-ID: <0bb101cd0276$7aa36ee0$6fea4ca0$@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> 
> The first 13 patches are hostbridge clean up.
> will add struct device dev into host_bridge struct.
> also will add release support to make sure allocated resource get
> freed during root bus removal including hostbridge and pci_sysdata.
> 
> others 23 patches are busn_alloc related.
> Set up iobusn_resource tree, and register bus number range to it.
> Later when need to find bus range, will try to allocate from the tree
> Need to test on arches other than x86. esp for ia64 and powerpc that support
>   more than on peer root buses.
> 
> The patches need to apply to pci/for-linus and pci/linux-next
> because one patch that is needed only is only in pci/for-linus

 I can't apply your patchset to pci/linux-next.
 I reckon your patchset needs refresh, or did I do something wrong?

 My impression is you should split your patchset between hostbridge part and
 bus-allocation part.

 Taku Izumi

> 
> could get from
>         git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-next
> 
> please put them into pci/linux-next branch for more testing.
> 
> -v2: dropped the patch that is with x86 pcibios_bus_to_resource that Bjorn objected.
>      reorder the patchesset to mold one appended patch into previous patch.
> 
> Thanks
> 
> Yinghai
> 
> Yinghai Lu (36):
>   PCI: Separate host_bridge code out from probe.c
>   x86, PCI: Fix memleak with get_current_resources
>   PCI: rename pci_host_bridge() to find_pci_root_bridge()
>   PCI: add generic device into pci_host_bridge struct
>   PCI: add host bridge release support
>   x86, PCI: break down get_current_resource()
>   x86, PCI: add host bridge resource release for using _CRS
>   x86, PCI: embed name acpi version pci_root_info struct
>   x86, PCI: embed pci_sysdata into pci_root_info on acpi path
>   x86, PCI: Allocating pci_root_info for not using _CRS path
>   x86, PCI: Merge root info printing for nocrs path
>   x86, PCI: add print all root info for nocrs path
>   x86, PCI: allocate temp range array in amd_bus pci_root_info probing
>   x86, PCI: Merge pcibios_scan_root and pci_scan_bus_on_node
>   PCI: Add busn_res into struct pci_bus.
>   PCI: Add busn_res operation functions
>   PCI: release busn when removing bus
>   PCI: insert busn_res in pci_create_root_bus
>   PCI: checking busn_res in pci_scan_root_bus
>   PCI: default busn_resource
>   PCI: add default res for pci_scan_bus
>   x86, PCI: add busn into resources list for acpi path
>   x86, PCI: put busn resource in pci_root_info for no_crs path
>   PCI, ia64: Register busn_res for root buses
>   PCI, sparc: Register busn_res for root buses
>   PCI, powerpc: Register busn_res for root buses
>   PCI, parisc: Register busn_res for root buses
>   PCI: Add pci_bus_extend/shrink_top()
>   PCI: Probe safe range that we can use for unassigned bridge.
>   PCI: Strict checking of valid range for bridge
>   PCI: Allocate bus range instead of use max blindly
>   PCI: kill pci_fixup_parent_subordinate_busnr()
>   PCI: Seperate child bus scanning to two passes overall
>   pcmcia: remove workaround for fixing pci parent bus subordinate
>   PCI: Double checking setting for bus register and bus struct.
>   PCI, pciehp: Remove not needed bus number range checking
> 
>  arch/ia64/pci/pci.c                   |    2 +
>  arch/powerpc/include/asm/pci-bridge.h |    1 +
>  arch/powerpc/kernel/pci-common.c      |   10 +-
>  arch/sparc/kernel/pci.c               |    4 +
>  arch/sparc/kernel/pci_impl.h          |    1 +
>  arch/x86/pci/acpi.c                   |  121 ++++---
>  arch/x86/pci/amd_bus.c                |   88 ++----
>  arch/x86/pci/broadcom_bus.c           |   17 +-
>  arch/x86/pci/bus_numa.c               |  100 +++++--
>  arch/x86/pci/bus_numa.h               |   23 +-
>  arch/x86/pci/common.c                 |   27 +--
>  drivers/parisc/dino.c                 |    5 +
>  drivers/parisc/lba_pci.c              |    3 +
>  drivers/pci/Makefile                  |    2 +-
>  drivers/pci/host-bridge.c             |   96 ++++++
>  drivers/pci/hotplug/pciehp_pci.c      |   12 +-
>  drivers/pci/probe.c                   |  601 ++++++++++++++++++++++-----------
>  drivers/pci/remove.c                  |    1 +
>  drivers/pcmcia/yenta_socket.c         |   75 ----
>  include/linux/pci.h                   |   15 +-
>  20 files changed, 752 insertions(+), 452 deletions(-)
>  create mode 100644 drivers/pci/host-bridge.c
> 
> --
> 1.7.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


