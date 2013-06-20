Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([85.214.48.195]:35425 "EHLO mail.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756318Ab3FTQPn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 20 Jun 2013 12:15:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.8bytes.org (Postfix) with SMTP id 6BC7112B0EE
	for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2013 18:15:41 +0200 (CEST)
Date: Thu, 20 Jun 2013 18:15:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org,
	stephen@networkplumber.org, linux-pci@vger.kernel.org,
	ddutile@redhat.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/2] iommu: Quirked PCIe bridge test and search
 function
Message-ID: <20130620161538.GH3589@8bytes.org>
References: <20130528183527.3318.5365.stgit@bling.home>
 <20130528184020.3318.7800.stgit@bling.home>
 <20130620135914.GS2575@8bytes.org>
 <1371743091.32709.52.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371743091.32709.52.camel@ul30vt.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 20, 2013 at 09:44:51AM -0600, Alex Williamson wrote:
> On Thu, 2013-06-20 at 15:59 +0200, Joerg Roedel wrote:
> > On Tue, May 28, 2013 at 12:40:20PM -0600, Alex Williamson wrote:
> > > +	if (!pci_is_root_bus(pdev->bus)) {
> > > +		struct pci_dev *parent = pdev->bus->self;
> > > +
> > > +		if (pci_is_pcie(parent) &&
> > > +		    pci_pcie_type(parent) != PCI_EXP_TYPE_PCI_BRIDGE)
> > > +			return true;
> > > +	}
> > 
> > Hmm, that looks a bit dangerous.
> 
> How so?  The algorithm seems pretty simple and logical.

It is simple, but it is still a heuristic that may fail at some point,
no?

> Actually, I believe Bjorn rejected the idea of a fixed list because this
> problem is detectable.  He also doesn't want me messing with quirks to
> pci_is_pcie() in PCI because he wants a 1:1 relation between that and
> having a PCIe capability.  So, I'm stuck and this is where it's ended
> up.  Thanks,

I think implementing such a list is much safer.

Bjorn, why didn't you like that idea?


	Joerg


