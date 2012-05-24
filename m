Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f74.google.com ([74.125.82.74]:37443 "EHLO
	mail-wg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630Ab2EXScI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 May 2012 14:32:08 -0400
Received: by wgbdt11 with SMTP id dt11so4478wgb.1
        for <linux-pci@vger.kernel.org>; Thu, 24 May 2012 11:32:07 -0700 (PDT)
Date: Thu, 24 May 2012 12:26:01 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>, Jiang Liu <liuj97@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/9] PCI, x86: update MMCFG information when
 hot-plugging PCI host bridges
Message-ID: <20120524182601.GA7551@google.com>
References: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2012 at 11:50:17AM +0800, Jiang Liu wrote:
> From: Jiang Liu <liuj97@gmail.com>
> 
> From: Jiang Liu <jiang.liu@huawei.com>
> 
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
> 
> The first 4 patches in series is the same with v5.

I tried this on one of my machines.  Before your patches:

    ACPI: bus type pci registered
    PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
    PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
    ...
    ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])

After:

    ACPI: bus type pci registered
1)  PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
    PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
    ...
    ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
2)  PCI: MMCONFIG for domain 0000 [bus 00-7e] at [mem 0x80000000-0x87efffff] (base 0x80000000)
3)  [Firmware Bug]: PCI: MMCONFIG at [mem 0x80000000-0x87efffff] not reserved in ACPI motherboard resources
4)  PCI: MMCONFIG at [mem 0x80000000-0x87efffff] reserved in E820

I really like the MMCONFIG info being associated with the host bridge in
dmesg, and I really like it being split out in /proc/iomem.  That's much
cleaner than it used to be.  MMCONFIG is defined by the PCIe spec, and
there are non-x86 architectures that use the same mechanism, so I can
imagine someday (not now!) making it more generic.

1): Do we really need this early MCFG scan?  Conceptually it seems like we
don't need to look at MCFG until we add a host bridge or do a blind probe.

2) and 4): These should be dev_info() with the host bridge device, e.g.,

    pci_root PNP0A08:00: MMCONFIG at [mem 0x80000000-0x87efffff]

Now that we can associate it with the bridge, the bus number range is
redundant.  It might be useful to know whether the MMCONFIG range came from
_CBA or MCFG, if that's easy to do.

Here's I'm thinking: right now we have some message confusion -- the arch
prints window info, e.g., "pci_root PNP0A08:00: host bridge window [io
0x0000-0x03af]", and then the PCI core prints the same thing but associated
with the bus: "pci_bus 0000:00: root bus resource [io  0x0000-0x03af]".
I'd like this to become more uniform, and have only the core print it, but
using the host bridge device, not the bus.

3): Something seems wrong here -- this "bug" message didn't appear before,
so I don't think it should now.  I haven't tried to chase this down.

Bjorn
