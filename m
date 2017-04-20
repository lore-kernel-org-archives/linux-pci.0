Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S969557AbdDTMLr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Apr 2017 08:11:47 -0400
Date: Thu, 20 Apr 2017 14:11:42 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Samuel Sieb <samuel@sieb.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Message-ID: <20170420121142.GI5077@suse.de>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
 <20170408074107.GA3585@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170408074107.GA3585@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 08, 2017 at 09:41:07AM +0200, Lukas Wunner wrote:
> On Fri, Apr 07, 2017 at 04:32:18PM +0200, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > ATS is broken on this hardware and causes IOMMU stalls and
> > system failure. Disable ATS on these devices to make them
> > usable again with IOMMU enabled.
> 
> AMD Stoney Ridge is an x86 CPU + GPU combo and this quirk pertains
> to the GPU, right?
> 
> In that case the quirk should go to arch/x86.  Paul Menzel (+cc)
> has just complained on linux-pci@ that final fixups are taking half
> a second, and I think that could be reduced if more efforts were
> spent to move arch-specific quirks out of the catch-all in
> drivers/pci/quirks.c.

The affected hardware here might be x86-only, but ATS is not. If a
broken ATS-capable plug-in card appears, we need this in generic code
anyway.

Also has anyone profiled why the fixups take so long (and on what
hardware)? Maybe the fixup-device matching can be improved instead of
cluttering arch-code with pci-fixups.


	Joerg
