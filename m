Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbdFORMM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jun 2017 13:12:12 -0400
Date: Thu, 15 Jun 2017 12:12:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Lukas Wunner <lukas@wunner.de>, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Samuel Sieb <samuel@sieb.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Message-ID: <20170615171210.GA12735@bhelgaas-glaptop.roam.corp.google.com>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
 <20170408074107.GA3585@wunner.de>
 <20170420121142.GI5077@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170420121142.GI5077@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 20, 2017 at 02:11:42PM +0200, Joerg Roedel wrote:
> On Sat, Apr 08, 2017 at 09:41:07AM +0200, Lukas Wunner wrote:
> > On Fri, Apr 07, 2017 at 04:32:18PM +0200, Joerg Roedel wrote:
> > > From: Joerg Roedel <jroedel@suse.de>
> > > 
> > > ATS is broken on this hardware and causes IOMMU stalls and
> > > system failure. Disable ATS on these devices to make them
> > > usable again with IOMMU enabled.
> > 
> > AMD Stoney Ridge is an x86 CPU + GPU combo and this quirk pertains
> > to the GPU, right?
> > 
> > In that case the quirk should go to arch/x86.  Paul Menzel (+cc)
> > has just complained on linux-pci@ that final fixups are taking half
> > a second, and I think that could be reduced if more efforts were
> > spent to move arch-specific quirks out of the catch-all in
> > drivers/pci/quirks.c.
> 
> The affected hardware here might be x86-only, but ATS is not. If a
> broken ATS-capable plug-in card appears, we need this in generic code
> anyway.

It could go in either arch/x86/pci/fixup.c or drivers/pci/quirks.c.

It's not clear to me exactly what the hardware defect is or where it
is.  If it's in the CPU or in a GPU that can only be found on x86, I
think arch/x86/pci/fixup.c is the appropriate place.

If it's in a GPU that could be found on other arches,
drivers/pci/quirks.c would be the appropriate place.

I don't personally think the possibility of a plugin card with broken
ATS is a real reason to put this quirk in drivers/pci/quirks.c.  It's
a trivial patch and easy to copy or move later if we need to.

Bjorn
