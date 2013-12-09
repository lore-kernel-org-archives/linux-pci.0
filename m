Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3764 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529Ab3LIRhA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Dec 2013 12:37:00 -0500
Message-ID: <1386610614.25738.594.camel@ul30vt.home>
Subject: Re: warn_slowpath_common in drivers/pci/search.c:44 on linux-3.4.0
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Antonio Quartulli <antonio@meshcoding.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>
Date: Mon, 09 Dec 2013 10:36:54 -0700
In-Reply-To: <CAErSpo5fzbxFuX_bqq-z1hpHyfMhLO0w+iuyii_6J3PxZn3p=A@mail.gmail.com>
References: <20120526082551.GA2723@ritirata.org>
	 <CAErSpo553_-AivRa7VbjHrFraHaO4NYoYR7A9Am5fkDP-CMvSA@mail.gmail.com>
	 <20120529083552.GN2604@amd.com> <20120529085648.GA13941@ritirata.org>
	 <52A4819A.50501@meshcoding.com>
	 <CAErSpo5fzbxFuX_bqq-z1hpHyfMhLO0w+iuyii_6J3PxZn3p=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-12-09 at 10:25 -0700, Bjorn Helgaas wrote:
> [+cc Alex]
> 
> On Sun, Dec 8, 2013 at 7:26 AM, Antonio Quartulli
> <antonio@meshcoding.com> wrote:
> > On 29/05/12 10:56, Antonio Quartulli wrote:
> >> On Tue, May 29, 2012 at 10:35:53 +0200, Joerg Roedel wrote:
> >>> Hi Antonio,
> >>>
> >>> On Sat, May 26, 2012 at 09:09:52AM -0600, Bjorn Helgaas wrote:
> >>>> On Sat, May 26, 2012 at 2:25 AM, Antonio Quartulli <ordex@autistici.org> wrote:
> >>>>> [    1.054279] WARNING: at drivers/pci/search.c:44 pci_find_upstream_pcie_bridge+0x5e/0x70()
> >>>>> [    1.054385] Hardware name: Latitude E5420
> >>>>> [    1.054457] Modules linked in:
> >>>>> [    1.054568] Pid: 1, comm: swapper/0 Not tainted 3.4.0ordex+ #3
> >>>>> [    1.054643] Call Trace:
> >>>>> [    1.054716]  [<ffffffff81033d4a>] warn_slowpath_common+0x7a/0xb0
> >>>>> [    1.054793]  [<ffffffff81033d95>] warn_slowpath_null+0x15/0x20
> >>>>> [    1.054869]  [<ffffffff8123899e>] pci_find_upstream_pcie_bridge+0x5e/0x70
> >>>>> [    1.054949]  [<ffffffff813babe7>] intel_iommu_device_group+0x77/0x100
> >>>>> [    1.055027]  [<ffffffff813b52d5>] add_iommu_group+0x35/0x60
> >>>>> [    1.055113]  [<ffffffff813b52a0>] ? bus_set_iommu+0x50/0x50
> >>>>> [    1.055191]  [<ffffffff8132c586>] bus_for_each_dev+0x56/0x90
> >>>>> [    1.055267]  [<ffffffff813b528b>] bus_set_iommu+0x3b/0x50
> >>>>> [    1.055344]  [<ffffffff818c4920>] intel_iommu_init+0xab0/0xb3f
> >>>>> [    1.055421]  [<ffffffff81120b26>] ? sys_mkdirat+0x76/0xd0
> >>>>> [    1.055499]  [<ffffffff8189b0db>] ? memblock_find_dma_reserve+0x13d/0x13d
> >>>>> [    1.055578]  [<ffffffff8189b0ee>] pci_iommu_init+0x13/0x3e
> >>>>> [    1.055655]  [<ffffffff810001ca>] do_one_initcall+0x3a/0x170
> >>>>> [    1.055732]  [<ffffffff81897c35>] kernel_init+0x148/0x1cc
> >>>>> [    1.055807]  [<ffffffff81897588>] ? do_early_param+0x86/0x86
> >>>>> [    1.055884]  [<ffffffff814fc914>] kernel_thread_helper+0x4/0x10
> >>>>> [    1.055963]  [<ffffffff8105de60>] ? finish_task_switch+0x80/0x110
> >>>>> [    1.056040]  [<ffffffff814fafdd>] ? retint_restore_args+0xe/0xe
> >>>>> [    1.056126]  [<ffffffff81897aed>] ? start_kernel+0x30b/0x30b
> >>>>> [    1.056203]  [<ffffffff814fc910>] ? gs_change+0xb/0xb
> >>>
> >>> Hmm, this looks like pci_find_upstream_pcie_bridge() found a PCIe device
> >>> in the chain which is not a bridge. Can you please post the output of
> >>> 'lspci -vvv' and 'lspci -t'?
> >>>
> >>
> >> attached!
> >> Some days ago I tried to put some printk in the code and, as far as I can
> >> understand, you are right.
> >>
> >> I hope my lspci output will help!
> >>
> >> Cheers,
> >>
> >
> > Hi guys,
> >
> > was there any progress about this?
> > Right now I am using linux-3.10.22 and the WARNING is still present.
> > The system seems to be working fine, but I don't know if this issue can
> > trigger side effects or not.
> 
> Alex and I prototyped some IOMMU and PCI restructuring [1] to avoid
> this case, but I haven't heard anything lately.
> 
> Bjorn
> 
> [1] http://lkml.kernel.org/r/20130711210326.1701.56478.stgit@bling.home

Yep, it's stalled waiting on time to work on it.  IIRC, the remaining
work is to figure out how to generalize the behavior of root complex PCI
bridges.  The behavior in the patch should probably be handled as an
Intel specific quirk.  If anyone has time to continue it, feel free to
run with the patches.  Otherwise I'll get back to it eventually.
Thanks,

Alex

