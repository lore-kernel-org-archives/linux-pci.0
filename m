Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751111AbeECWw4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 May 2018 18:52:56 -0400
Date: Thu, 3 May 2018 17:52:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Joerg Roedel <joro@8bytes.org>, Gil Kupfer <gilkup@gmail.com>,
        dwmw2@infradead.org, bhelgaas@google.com,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, nadav.amit@gmail.com,
        Gil Kupfer <gilkup@cs.technion.ac.il>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC/RFT] Add noats flag to boot parameters
Message-ID: <20180503225254.GC15790@bhelgaas-glaptop.roam.corp.google.com>
References: <1525025808-2365-1-git-send-email-gilkup@cs.technion.ac.il>
 <20180503133459.waawna3ebtu3udn6@8bytes.org>
 <359d736a-a7ac-f0e4-f4db-dc7bb506481c@codeaurora.org>
 <20180503135920.o2rdh3exai7qmkvu@8bytes.org>
 <5cf699f1-90c1-5ad8-07fe-a65042395d05@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5cf699f1-90c1-5ad8-07fe-a65042395d05@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2018 at 10:23:02AM -0400, Sinan Kaya wrote:
> +Bjorn,
> 
> On 5/3/2018 9:59 AM, Joerg Roedel wrote:
> > On Thu, May 03, 2018 at 09:46:34AM -0400, Sinan Kaya wrote:
> >> I also like the idea in general.
> >> Minor nit..
> >>
> >> Shouldn't this be an iommu parameter rather than a PCI kernel command line parameter?
> >> We now have an iommu.passthrough argument that prevents page translation.
> >>
> >> Doesn't this fit into the same category especially when it is the IOMMU drivers that
> >> call ATS functions for enablement not the PCI drivers.
> > 
> > ATS is a bit of a grey area between PCI and IOMMU, but since ATS is
> > PCI-specific and the code to enable/disable it is in PCI as well, I
> > think the parameter makes sense for PCI too.
> 
> OK. Bjorn was interested in having a command line driven feature enables
> in driver/pci directory with bitmasks for each optional PCI spec
> capability rather than noXYZ feature.

It's true that I try to avoid adding *any* kernel parameters as much
as possible because they're usually not practical for end-users.

I think it's unreasonable to expect users to use "pci=" parameters
based on what specific hardware they have.  That's too hard to
discover and too hard to use.  I did wonder about a "pci=safe"
parameter that would disable potentially risky features just as a
debugging feature [1].

This ATS case is a security question and the parameter is not
something that would have to be used to get certain hardware to work,
so I think it's probably reasonable to add.  I would maybe expand the
documentation so it includes the reason somebody might want it, i.e.,
to defend against malicious PCIe devices.

A parameter using bitmasks could be conceivable for developers but
sounds too unwieldy for end-users.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=196197#c53
