Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59924 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503Ab2FODGz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jun 2012 23:06:55 -0400
Received: by lbbgm6 with SMTP id gm6so2547371lbb.19
        for <linux-pci@vger.kernel.org>; Thu, 14 Jun 2012 20:06:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 14 Jun 2012 21:06:33 -0600
Message-ID: <CAErSpo4v_N8MhoCyQMi6vOOipw6Cg8wbMqP2q9FXT+gXjF88iw@mail.gmail.com>
Subject: Re: [PATCH v7 00/10] PCI, x86: update MMCFG information when
 hot-plugging PCI host bridges
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 26, 2012 at 3:53 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
> This patchset enhance pci_root driver to update MMCFG information when
> hot-plugging PCI root bridges. It applies to
> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/next-3.5
>
> -v2: split into smaller patches and skip updating MMCFG information when
>     MMCFG is disabled
> -v3: add mmconf_added to simply free path, also make pci_mmconfig_insert()
>     to process extra exist case --- By Yinghai
> -v4: tune arch_acpi_pci_root_add() to handle a corner case raised by Kenji
> -v5: address review comments from Bjorn and Taku, also better handle corner
>     cases in arch_acpi_pci_root_add()
> -v6: get rid of arch_acpi_pci_root_xxx() by using existing hooks
>     add MCFG information for host bridges on demand
>     more corner cases clear up
>     correctly handle condition compilation
>     fix section mismatch issues
>     fix a issue reported by Taku about a BIOS bug
> -v7: unify log messages
>     remove redundant host bridge resource related log messages
>     fix a issue reported by Taku which breaks pnp resource allocation
>
> Jiang Liu (10):
>  PCI, x86: split out pci_mmcfg_check_reserved() for code reuse
>  PCI, x86: split out pci_mmconfig_alloc() for code reuse
>  PCI, x86: use RCU list to protect mmconfig list
>  PCI, x86: introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap()
>  PCI, x86: introduce pci_mmconfig_insert()/delete() for PCI root
>    bridge hotplug
>  PCI, ACPI: provide MCFG address for PCI host bridges
>  PCI, x86: update MMCFG information when hot-plugging PCI host bridges
>  PCI, x86: add MMCFG information on demand
>  PCI, x86: simplify pci_mmcfg_late_insert_resources()
>  PCI, x86: get rid of redundant log messages

I applied this to a topic/jiang-mmconfig-v7 branch with minor changes:

- I changed uint8_t and uint16_t to the more common u8 and u16.
- I changed the "not reserved in ACPI motherboard resources" message
from KERN_ERR to KERN_INFO.

Previously, we typically would not see "motherboard resources"
warnings at all because we didn't check for them during early init,
and late init returned before checking because MMCONFIG was already
enabled.  Now, the pci_mmconfig_insert() does the checking that we
skipped before.

Using KERN_ERR would break the graphical boot experience and users
would complain, we can't do anything to fix it, and MMCONFIG actually
works fine anyway.  So I don't think there's any point in having them
be errors.

I have to say I'm still ambivalent about this.  I really like the fact
that we track MMCONFIG space on a per-host bridge basis.  But the code
in the init path is ridiculously, embarrassingly complicated
(obviously this is not your fault at all).  It took me a couple hours
to trace through and figure out why my box emits the "motherboard
resources" warnings when it didn't before.

I'm going to apply the series because I do think it's a net win.  So
just consider this as encouragement to simplify the design when you
can, even if you're not adding functionality.

I'll merge this to my "next" branch tomorrow unless you see any issues
with the tweaks I made.

Bjorn
