Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11805 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798Ab2DTXRu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 20 Apr 2012 19:17:50 -0400
Date: Fri, 20 Apr 2012 16:17:48 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 3.2.11: PCI Express card cannot be re-detected withing cca 60sec
 timeframe
Message-ID: <20120420231748.GB7069@xanatos>
References: <4F8F243B.70906@fold.natur.cuni.cz>
 <CAE9FiQXx1NcGY9cHDiM5isx7NyxWN--Exb-4Gfj0arr6vf5ghQ@mail.gmail.com>
 <4F909CEB.3060407@fold.natur.cuni.cz>
 <CAE9FiQU7gnKiwazN_2ykbXSkcuDqWMZNt0CHiGvae2L+rTVGug@mail.gmail.com>
 <CAE9FiQUk8D20mEFPE0ahwfigbEOHpbRp-X0wt4DC+293msw=4Q@mail.gmail.com>
 <4F91473A.1080007@fold.natur.cuni.cz>
 <CAE9FiQUQRAfdG1J6XUVcOVkeR00vyqnCrBg1O3S_ByC3dKOUog@mail.gmail.com>
 <4F919C22.1070608@fold.natur.cuni.cz>
 <4F919CD5.7070004@fold.natur.cuni.cz>
 <CAE9FiQV_cRTDTBmQwNLJtT-N=HTAxBiphBLDmKxM-N0JKyoR-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQV_cRTDTBmQwNLJtT-N=HTAxBiphBLDmKxM-N0JKyoR-w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 20, 2012 at 11:47:14AM -0700, Yinghai Lu wrote:
> On Fri, Apr 20, 2012 at 10:28 AM, Martin Mokrejs
> <mmokrejs@fold.natur.cuni.cz> wrote:
> > [30720.175637] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 108
> > [30720.175639] pciehp 0000:00:1c.7:pcie04: LinkState change
> > [30720.175643] pciehp 0000:00:1c.7:pcie04: lnk_status = 5011
> > [30720.175644] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
> > [30720.175648] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
> > [30720.175687] pciehp 0000:00:1c.7:pcie04: Surprise Removal
> > [30720.175718] pciehp 0000:00:1c.7:pcie04: Disabling domain:bus:device=0000:11:00
> > [30720.175721] pciehp 0000:00:1c.7:pcie04: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00
> >
> 
> So the USB host control driver xhci put that 11:00.0 in strange power state.

What do you mean "strange power state"?  The only PCI power states the
xHCI driver will use is D0 or D3hot.  D3hot is entered automatically by
the USB core runtime PM system when all USB devices are disconnected or
suspended.  So what strange power state are we talking about?

> please try to boot the system with pcie_aspm=off
> 
> and don't use echo 1 before physically removing the expresscard.
> 
> Yinghai
