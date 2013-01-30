Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:44665 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755953Ab3A3WAS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 17:00:18 -0500
Received: by mail-ve0-f176.google.com with SMTP id jz10so1491518veb.21
        for <linux-pci@vger.kernel.org>; Wed, 30 Jan 2013 14:00:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130116143853.339dd89b@nehalam.linuxnetplumber.net>
References: <20130116143853.339dd89b@nehalam.linuxnetplumber.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 30 Jan 2013 14:59:56 -0700
Message-ID: <CAErSpo5eOE_=Ob2jN7ACy0eJBOa8k36XqCbHnGTCs-wfiy8tiw@mail.gmail.com>
Subject: Re: PCI warning on boot 3.8.0-rc1
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org, alex.williamson@redhat.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 16, 2013 at 3:38 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> I see this on boot in dmesg
>
> [    0.574494] DMAR: No ATSR found
> [    0.574549] IOMMU 0 0xfed90000: using Queued invalidation
> [    0.574550] IOMMU 1 0xfed91000: using Queued invalidation
> [    0.574554] IOMMU: Setting RMRR:
> [    0.574583] IOMMU: Setting identity map for device 0000:00:02.0 [0xcf000000 -
>  0xdf1fffff]
> [    0.575748] IOMMU: Setting identity map for device 0000:00:1d.0 [0xcd551000 -
>  0xcd56dfff]
> [    0.575767] IOMMU: Setting identity map for device 0000:00:1a.0 [0xcd551000 -
>  0xcd56dfff]
> [    0.575786] IOMMU: Setting identity map for device 0000:00:14.0 [0xcd551000 -
>  0xcd56dfff]
> [    0.575797] IOMMU: Prepare 0-16MiB unity mapping for LPC
> [    0.575806] IOMMU: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffff
> ff]
> [    0.576186] PCI-DMA: Intel(R) Virtualization Technology for Directed I/O
> [    0.576337] ------------[ cut here ]------------
> [    0.576342] WARNING: at drivers/pci/search.c:46 pci_find_upstream_pcie_bridge
> +0x59/0x71()
> [    0.576343] Hardware name: System Product Name
> [    0.576344] Modules linked in:
> [    0.576347] Pid: 1, comm: swapper/0 Not tainted 3.8.0-rc1-net-next+ #4
> [    0.576348] Call Trace:
> [    0.576352]  [<ffffffff81074261>] warn_slowpath_common+0x83/0x9c
> [    0.576355]  [<ffffffff813fae71>] ? bus_set_iommu+0x49/0x49
> [    0.576357]  [<ffffffff81074294>] warn_slowpath_null+0x1a/0x1c
> [    0.576360]  [<ffffffff812db618>] pci_find_upstream_pcie_bridge+0x59/0x71
> [    0.576362]  [<ffffffff813fd247>] intel_iommu_add_device+0x4d/0x17a
> [    0.576364]  [<ffffffff813faeab>] add_iommu_group+0x3a/0x48
> [    0.576368]  [<ffffffff8135d490>] bus_for_each_dev+0x57/0x89
> [    0.576370]  [<ffffffff813fae6a>] bus_set_iommu+0x42/0x49
> [    0.576374]  [<ffffffff81b1b1a5>] intel_iommu_init+0xa27/0xb44
> [    0.576377]  [<ffffffff8105dcf3>] ? free_init_pages+0xf5/0x10d
> [    0.576379]  [<ffffffff81aeb87d>] ? maybe_link.part.2+0x10b/0x10b
> [    0.576382]  [<ffffffff81aeef53>] ? memblock_find_dma_reserve+0x133/0x133
> [    0.576384]  [<ffffffff81aeef66>] pci_iommu_init+0x13/0x3e
> [    0.576387]  [<ffffffff8100023c>] do_one_initcall+0x7f/0x133
> [    0.576390]  [<ffffffff814d0c2c>] kernel_init+0x146/0x29b
> [    0.576393]  [<ffffffff81aea52f>] ? do_early_param+0x8c/0x8c
> [    0.576395]  [<ffffffff814d0ae6>] ? rest_init+0xda/0xda
> [    0.576398]  [<ffffffff814ed4dc>] ret_from_fork+0x7c/0xb0
> [    0.576400]  [<ffffffff814d0ae6>] ? rest_init+0xda/0xda
> [    0.576406] ---[ end trace f709d1eb2b66cbf5 ]---
>
> $ sudo lspci -t -vv
> -[0000:00]-+-00.0  Intel Corporation Xeon E3-1200 v2/3rd Gen Core processor DRAM Controller
>            +-01.0-[01-02]----00.0  Intel Corporation Ethernet Controller 10-Gigabit X540-AT2
>            +-02.0  Intel Corporation Xeon E3-1200 v2/3rd Gen Core processor Graphics Controller
>            +-14.0  Intel Corporation 7 Series/C210 Series Chipset Family USB xHCI Host Controller
>            +-16.0  Intel Corporation 7 Series/C210 Series Chipset Family MEI Controller #1
>            +-1a.0  Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #2
>            +-1b.0  Intel Corporation 7 Series/C210 Series Chipset Family High Definition Audio Controller
>            +-1c.0-[03]--
>            +-1c.4-[04]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller
>            +-1c.5-[05-06]----00.0-[06]--
>            +-1d.0  Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #1
>            +-1f.0  Intel Corporation Z77 Express Chipset LPC Controller
>            +-1f.2  Intel Corporation 7 Series/C210 Series Chipset Family 6-port SATA Controller [AHCI mode]
>            \-1f.3  Intel Corporation 7 Series/C210 Series Chipset Family SMBus Controller

I think drivers/pci/search.c is identical between 3.7 and 3.8-rc1.  Is
this the first time you've turned on the IOMMU on that box?

It's the same warning as in this bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=44881, and there's a patch
there at https://bugzilla.kernel.org/show_bug.cgi?id=44881#c11, but
it's just a quirk that turns off VT-d if we find certain broken
bridges.  It doesn't look like you have any of those (although I don't
know what you have at 05:00.0).

Bjorn
