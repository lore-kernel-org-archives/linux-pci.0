Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754210AbdDES5g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Apr 2017 14:57:36 -0400
Date: Wed, 5 Apr 2017 12:57:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC] PCI ACS Flags Clarification
Message-ID: <20170405125733.2235e6e6@t450s.home>
In-Reply-To: <615834cc-37d2-afd4-d093-23fc9e33f5d7@codeaurora.org>
References: <49257b71-6fa1-5870-fba6-1b8c5179b8ec@codeaurora.org>
        <20170404133923.5232e424@t450s.home>
        <615834cc-37d2-afd4-d093-23fc9e33f5d7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 5 Apr 2017 09:51:06 -0400
Sinan Kaya <okaya@codeaurora.org> wrote:

> Hi Alex,
> 
> Thank you very much for the detailed explanation.
> 
> On 4/4/2017 3:39 PM, Alex Williamson wrote:
> > On Tue, 4 Apr 2017 14:47:58 -0400
> > Sinan Kaya <okaya@codeaurora.org> wrote:
> >   
> [cut]
> 
> >> The requirement is to have an 
> >> 1. ACS capability with PCI_ACS_SV if p2p is not supported
> >> 2. ACS capability with PCI_ACS_SV|PCI_ACS_RR | PCI_ACS_CR |
> >>   PCI_ACS_UF if p2p is supported.
> >>
> >> Did I get this right?  
> >   
> 
> I'm looking for sanity check on OS requirements. According to the PCIE spec,
> ACS itself is optional. However, Linux requires ACS capability. I want to
> make sure that we are satisfying the Linux requirements here.

This is like saying Linux requires ACPI, it's simply not true.  ACS is
a PCIe spec defined feature which gives us a standard mechanism of
determining if a device is DMA isolated within a PCIe topology.  For
those that do not implement the standard, we have numerous quirks
implementing platform specific mechanism to provide the equivalent
behavior.  Even this device isolation is not required by Linux, except
for the use case of userspace drivers, where we make the incredibly
reasonable requirement (IMO) that we cannot mix devices which are not
isolated from one another between kernel and user or one user and
another.
 
> I also agree that spec should be the guide. Maybe, a combination of spec+linux
> is the right answer.
> 
> > I'd suggest following the spec, not the code, that way you always have a
> > case for how you interpret the spec and the behavior of your hardware.
> > The code is an attempt to validate the device against the spec, but more
> > thorough implementations may follow.  REQ_ACS_FLAGS defines the set of
> > ACS capabilities we think are relevant to device isolation.  In
> > particular, UF seems like a key feature and our current test for it may
> > not be fully correct.  Note how RR and CR only specify p2p with other
> > root ports while UF requires transaction towards to the RC.  Section
> > 6.12.2 further defines Redirected Request Validation as a feature
> > within the context of RR and CR.  So rather than look at the code,
> > discuss section 6.12 with the hardware engineers and understand how it
> > behaves relative to each device and transaction type.  Implement the
> > capabilities that best match.  Attempting a minimal implementation
> > based on the current software interpretation may bite later, for
> > instance if we re-interpret how UF works.  Thanks,  
> 
> I read your reply multiple times. Here is what I got from it.
> 
> The summary below is for the root ports only.
> 
> - P2P on root ports is optional. 

And unless told otherwise (by ACS or ACS-equivalent quirks), Linux
assumes p2p is possible.

> - If P2P is there source validation, translation blocking, upstream forwarding,
> p2p request redirection and p2p completion redirection ACS capabilities need to be
> there for spec+linux compliance.

Again, this is not a Linux requirement.  If you want Linux to recognize
the isolation of devices downstream of the root port using standard
mechanism, this would be the way to do so.
 
> - If P2P is not there source validation, translation blocking and upstream forwarding
> needs to be there for spec+linux compliance.

This is interpretation of a rather confusing section of the spec where
we currently take a fairly liberal approach.  The spec says RR must be
implemented by RPs that support p2p traffic _with_other_root_ports_.
That doesn't necessarily say anything about p2p "reflected" back
downstream, however enabling RR clearly states that p2p request must be
redirected upstream.  Thus supporting RR is clearly the safer choice
here for long term compliance if your device uses the RR behavior
already.  Supporting CR also falls out of that since RR necessitates
CR.  UF also references RR and CR behavior when enabled, so as per the
footnote in 6.12.1.1, it's not entirely clear that we can assume what
happens if a RP supports UF but not RR/CR.  The safe bet is to
implement each capability that matches your hardware behavior.

> - The code is relaxed to allow any combination of these today based on the ACS
> capability but it can change tomorrow. 

Yes, we somewhat assume that if a device supports ACS at all, it's
probably doing the "right thing".  I don't know that the current
behavior of assuming p2p is not possible when the capability is not
present is actually used by any existing hardware.  It seems
questionable on a strict reading of the spec.  Thanks,

Alex
