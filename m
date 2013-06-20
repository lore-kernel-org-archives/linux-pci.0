Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47034 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757731Ab3FTPpX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 20 Jun 2013 11:45:23 -0400
Message-ID: <1371743091.32709.52.camel@ul30vt.home>
Subject: Re: [PATCH v2 1/2] iommu: Quirked PCIe bridge test and search
 function
From: Alex Williamson <alex.williamson@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org,
	stephen@networkplumber.org, linux-pci@vger.kernel.org,
	ddutile@redhat.com, Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Jun 2013 09:44:51 -0600
In-Reply-To: <20130620135914.GS2575@8bytes.org>
References: <20130528183527.3318.5365.stgit@bling.home>
	 <20130528184020.3318.7800.stgit@bling.home>
	 <20130620135914.GS2575@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-06-20 at 15:59 +0200, Joerg Roedel wrote:
> On Tue, May 28, 2013 at 12:40:20PM -0600, Alex Williamson wrote:
> > +bool iommu_pci_is_pcie_bridge(struct pci_dev *pdev)
> > +{
> > +	if (!pdev->subordinate)
> > +		return false;
> > +
> > +	if (pci_is_pcie(pdev))
> > +		return true;
> > +
> > +#ifdef CONFIG_PCI_QUIRKS
> > +	/*
> > +	 * If we're not on the root bus, look one device upstream of the
> > +	 * current device.  If that device is PCIe and is not a PCIe-to-PCI
> > +	 * bridge, then the current device is effectively PCIe as it must
> > +	 * be the PCIe-to-PCI bridge.  This handles several bridges that
> > +	 * violate the PCIe spec by not exposing a PCIe capability:
> > +	 * https://bugzilla.kernel.org/show_bug.cgi?id=44881
> > +	 */
> > +	if (!pci_is_root_bus(pdev->bus)) {
> > +		struct pci_dev *parent = pdev->bus->self;
> > +
> > +		if (pci_is_pcie(parent) &&
> > +		    pci_pcie_type(parent) != PCI_EXP_TYPE_PCI_BRIDGE)
> > +			return true;
> > +	}
> 
> Hmm, that looks a bit dangerous.

How so?  The algorithm seems pretty simple and logical.

>  Do we have a list of PCI
> vendor/device-ids of these broken bridges to match against instead of
> some open-coded heuristics?
> 
> That would probably also help to bring this into the PCI code.

Actually, I believe Bjorn rejected the idea of a fixed list because this
problem is detectable.  He also doesn't want me messing with quirks to
pci_is_pcie() in PCI because he wants a 1:1 relation between that and
having a PCIe capability.  So, I'm stuck and this is where it's ended
up.  Thanks,

Alex

