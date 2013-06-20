Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([85.214.48.195]:35052 "EHLO mail.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965093Ab3FTN7S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 20 Jun 2013 09:59:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.8bytes.org (Postfix) with SMTP id 46A7A12B0EE
	for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2013 15:59:16 +0200 (CEST)
Date: Thu, 20 Jun 2013 15:59:14 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org,
	stephen@networkplumber.org, linux-pci@vger.kernel.org,
	ddutile@redhat.com
Subject: Re: [PATCH v2 1/2] iommu: Quirked PCIe bridge test and search
 function
Message-ID: <20130620135914.GS2575@8bytes.org>
References: <20130528183527.3318.5365.stgit@bling.home>
 <20130528184020.3318.7800.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130528184020.3318.7800.stgit@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 28, 2013 at 12:40:20PM -0600, Alex Williamson wrote:
> +bool iommu_pci_is_pcie_bridge(struct pci_dev *pdev)
> +{
> +	if (!pdev->subordinate)
> +		return false;
> +
> +	if (pci_is_pcie(pdev))
> +		return true;
> +
> +#ifdef CONFIG_PCI_QUIRKS
> +	/*
> +	 * If we're not on the root bus, look one device upstream of the
> +	 * current device.  If that device is PCIe and is not a PCIe-to-PCI
> +	 * bridge, then the current device is effectively PCIe as it must
> +	 * be the PCIe-to-PCI bridge.  This handles several bridges that
> +	 * violate the PCIe spec by not exposing a PCIe capability:
> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=44881
> +	 */
> +	if (!pci_is_root_bus(pdev->bus)) {
> +		struct pci_dev *parent = pdev->bus->self;
> +
> +		if (pci_is_pcie(parent) &&
> +		    pci_pcie_type(parent) != PCI_EXP_TYPE_PCI_BRIDGE)
> +			return true;
> +	}

Hmm, that looks a bit dangerous. Do we have a list of PCI
vendor/device-ids of these broken bridges to match against instead of
some open-coded heuristics?

That would probably also help to bring this into the PCI code.


	Joerg


