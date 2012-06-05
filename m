Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:58915 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757733Ab2FEC7r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jun 2012 22:59:47 -0400
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 90EB13EE0BC
	for <linux-pci@vger.kernel.org>; Tue,  5 Jun 2012 11:59:45 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 759E945DE50
	for <linux-pci@vger.kernel.org>; Tue,  5 Jun 2012 11:59:45 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5339445DD78
	for <linux-pci@vger.kernel.org>; Tue,  5 Jun 2012 11:59:45 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 408801DB803A
	for <linux-pci@vger.kernel.org>; Tue,  5 Jun 2012 11:59:45 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.240.81.146])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id EEF291DB8038
	for <linux-pci@vger.kernel.org>; Tue,  5 Jun 2012 11:59:44 +0900 (JST)
Date: Tue, 5 Jun 2012 11:59:31 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 00/10] PCI, x86: update MMCFG information when
 hot-plugging PCI host bridges
Message-Id: <20120605115931.4cddc8d5.izumi.taku@jp.fujitsu.com>
In-Reply-To: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jiang,

 Looks good, and works as expected.

 Best regards,
 Taku Izumi

On Sat, 26 May 2012 17:53:53 +0800
Jiang Liu <jiang.liu@huawei.com> wrote:

> This patchset enhance pci_root driver to update MMCFG information when
> hot-plugging PCI root bridges. It applies to 
> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/next-3.5
> 
> -v2: split into smaller patches and skip updating MMCFG information when
>      MMCFG is disabled
> -v3: add mmconf_added to simply free path, also make pci_mmconfig_insert()
>      to process extra exist case --- By Yinghai
> -v4: tune arch_acpi_pci_root_add() to handle a corner case raised by Kenji
> -v5: address review comments from Bjorn and Taku, also better handle corner
>      cases in arch_acpi_pci_root_add()
> -v6: get rid of arch_acpi_pci_root_xxx() by using existing hooks
>      add MCFG information for host bridges on demand
>      more corner cases clear up
>      correctly handle condition compilation
>      fix section mismatch issues
>      fix a issue reported by Taku about a BIOS bug
> -v7: unify log messages
>      remove redundant host bridge resource related log messages
>      fix a issue reported by Taku which breaks pnp resource allocation
> 
> Jiang Liu (10):
>   PCI, x86: split out pci_mmcfg_check_reserved() for code reuse
>   PCI, x86: split out pci_mmconfig_alloc() for code reuse
>   PCI, x86: use RCU list to protect mmconfig list
>   PCI, x86: introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap()
>   PCI, x86: introduce pci_mmconfig_insert()/delete() for PCI root
>     bridge hotplug
>   PCI, ACPI: provide MCFG address for PCI host bridges
>   PCI, x86: update MMCFG information when hot-plugging PCI host bridges
>   PCI, x86: add MMCFG information on demand
>   PCI, x86: simplify pci_mmcfg_late_insert_resources()
>   PCI, x86: get rid of redundant log messages
> 
>  arch/x86/include/asm/pci_x86.h |   12 ++
>  arch/x86/pci/acpi.c            |   76 ++++++++-
>  arch/x86/pci/legacy.c          |    1 +
>  arch/x86/pci/mmconfig-shared.c |  364 +++++++++++++++++++++++++++++-----------
>  arch/x86/pci/mmconfig_32.c     |   30 +++-
>  arch/x86/pci/mmconfig_64.c     |   37 ++++-
>  drivers/acpi/pci_root.c        |   12 ++
>  drivers/pci/pci-acpi.c         |   34 ++++
>  include/acpi/acnames.h         |    1 +
>  include/acpi/acpi_bus.h        |    3 +
>  include/linux/pci-acpi.h       |    5 +
>  11 files changed, 465 insertions(+), 110 deletions(-)
> 
> 
> 



