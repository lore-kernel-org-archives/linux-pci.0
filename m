Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755419AbdLOSSK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Dec 2017 13:18:10 -0500
Date: Fri, 15 Dec 2017 12:18:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Govinda Tatti <Govinda.Tatti@Oracle.COM>
Cc: Christoph Hellwig <hch@infradead.org>, jgross@suse.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        JBeulich@suse.com, bhelgaas@google.com,
        xen-devel@lists.xenproject.org, boris.ostrovsky@Oracle.COM,
        roger.pau@citrix.com, Russell Currey <ruscur@russell.cc>,
        Sinan Kaya <okaya@codeaurora.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Srikanth Jampala <Jampala.Srikanth@cavium.com>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>
Subject: Re: [Xen-devel] [PATCH V3 1/2] Drivers/PCI: Export pcie_has_flr()
 interface
Message-ID: <20171215181801.GU30595@bhelgaas-glaptop.roam.corp.google.com>
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-2-Govinda.Tatti@Oracle.COM>
 <20171208202424.GC12367@bhelgaas-glaptop.roam.corp.google.com>
 <426eeeab-0dcd-8de3-9c5f-a166acf2c130@Oracle.COM>
 <20171212005919.GB30595@bhelgaas-glaptop.roam.corp.google.com>
 <49956aaf-5fd5-939d-5fc7-231ffdb98b70@Oracle.COM>
 <20171213212420.GH30595@bhelgaas-glaptop.roam.corp.google.com>
 <fea075cf-fe6f-0d0b-11e4-4279fbfc280a@Oracle.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fea075cf-fe6f-0d0b-11e4-4279fbfc280a@Oracle.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Russell, Sinan, Herbert, Srikanth, Derek, Satanand, Felix, Raghu]

On Fri, Dec 15, 2017 at 09:48:02AM -0600, Govinda Tatti wrote:
> On 12/13/2017 3:24 PM, Bjorn Helgaas wrote:
> >On Wed, Dec 13, 2017 at 02:46:57PM -0600, Govinda Tatti wrote:

> >>>>>>-static bool pcie_has_flr(struct pci_dev *dev)
> >>>>>>+bool pcie_has_flr(struct pci_dev *dev)
> >>>>>>  {
> >>>>>>  	u32 cap;
> >>>>>>@@ -3882,6 +3882,7 @@ static bool pcie_has_flr(struct pci_dev *dev)
> >>>>>>  	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> >>>>>>  	return cap & PCI_EXP_DEVCAP_FLR;
> >>>>>>  }
> >>>>>>+EXPORT_SYMBOL_GPL(pcie_has_flr);

> >>>>>I'd rather change pcie_flr() so you could *always* call it, and
> >>>>>it would return 0, -ENOTTY, or whatever, based on whether FLR
> >>>>>is supported.  Is that feasible?

> >>>>Sure, I will add pcie_has_flr() logic inside pcie_flr() and
> >>>>return appropriate values as suggested by you. Do we still want
> >>>>to retain pcie_has_flr() and its usage inside pci.c?.Otherwise,
> >>>>I will remove it and do required cleanup.

> >>>If you can restructure the code and remove pcie_has_flr() while
> >>>retaining the existing behavior of its callers, that would be
> >>>great.

> >>I checked the current usage of pcie_has_flr() and pcie_flr(). I
> >>have a couple of questions or need some clarification.
> >>
> >>1. pcie_has_flr() usage inside pci_probe_reset_function().
> >>
> >>    This function is only calling pcie_has_flr() but not pcie_flr().
> >>    Rest of the code is trying to do specific type of reset except
> >>    pcie_flr().
> >>
> >>         rc = pci_dev_specific_reset(dev, 1);
> >>         if (rc != -ENOTTY)
> >>                 return rc;
> >>         if (pcie_has_flr(dev))
> >>                 return 0;
> >>         rc = pci_af_flr(dev, 1);
> >>         if (rc != -ENOTTY)
> >>                 return rc;
> >>
> >>    In other-words, I can remove usage of pcie_has_flr() in all
> >>    other places in pci.c except in above function.

> >I think we should keep the EXPORT_SYMBOL_GPL() part of a60a2b73ba69
> >("PCI: Export pcie_flr()"), but revert the restructuring part.
> >
> >Prior to a60a2b73ba69, we had
> >
> >   int pcie_flr(struct pci_dev *dev, int probe);
> >
> >like all the other reset methods.  AFAICT, the addition of
> >pcie_has_flr() was to optimize the path slightly because when
> >drivers call pcie_flr(), they should already know that their
> >hardware supports FLR.  But I don't think that optimization is
> >worth the extra code complexity.  If we do need to optimize it, we
> >can check this in the core during enumeration and set
> >PCI_DEV_FLAGS_NO_FLR_RESET accordingly.

> Not all code paths are aware of FLR capability and also, not
> using pcie_flr().  For example,
> 
> arch/powerpc/platforms/powernv/eeh-powernv.c

I assume you're referring to pnv_eeh_do_flr() (which contains code similar
to pcie_flr()) and pnv_eeh_do_af_flr() (which has code similar to
pci_af_flr()).  I agree that those are problematic and would ideally be
unified with the PCI core implementations.

Powerpc has quite a bit of this sort of special-case code for several
reasons, some just historical and some more concrete, so I don't know how
feasible this is.

> drivers/crypto/cavium/nitrox/nitrox_main.c

This has nitrox_reset_device(), which should definitely be replaced with a
core interface.

> drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c

And this has octeon_mbox_process_cmd() which also does a home-grown
PCI_EXP_DEVCTL_BCR_FLR request and also should definitely use a core
interface.

> So, we should consider one of these options.
> 
> - set PCI_DEV_FLAGS_NO_FLR_RESET if it is not supported.
> - pcie_flr() should return if it is not supported
> 
> If we modify pcie_flr() to return error codes, then we need to modify
> all existing modules that are calling this function.

Yes, of course.

> Please let me know your preference, so that I can move accordingly. Thanks.

I think Christoph volunteered to do some restructuring, but I don't
know his timeframe.  If you can, I would probably wait for that
because there's so much overlap here.

The other paths that use PCI_EXP_DEVCTL_BCR_FLR are definitely issues
and should be fixed, but again should wait for the revised pcie_flr()
interface.  And if they're not actually required for your Xen issue,
they sound like "nice to have" cleanups that will not gate your Xen
fixes.  I added this to my ever-growing list of cleanups to do.

Bjorn
