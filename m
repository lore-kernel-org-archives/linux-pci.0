Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49453 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754876AbcEBUZm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 May 2016 16:25:42 -0400
Date: Mon, 2 May 2016 15:25:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCHv4] pcie: Add driver for Downstream Port Containment
Message-ID: <20160502202538.GK24851@localhost>
References: <1461882288-31506-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461882288-31506-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 28, 2016 at 04:24:48PM -0600, Keith Busch wrote:
> This adds driver support for root and downstream ports that implement
> the PCI-Express Downstream Port Containment extended capability. DPC is
> an optional capability to contain uncorrectable errors below a port.
> 
> For more information on DPC, please see PCI Express Base Specification
> Revision 4, section 7.31, or view the PCI-SIG DPC ECN here:
> 
>   https://pcisig.com/sites/default/files/specification_documents/ECN_DPC_2012-02-09_finalized.pdf
> 
> When a DPC event is triggered, the h/w disables downstream links, so
> the DPC driver schedules removal for all devices below this port. This
> may happen concurrently with a PCI-e hotplug driver if enabled. When all
> downstream devices are removed and the link state transitions to disabled,
> the DPC driver clears the DPC status and interrupt bits so the link may
> retrain for a newly connected device.
> 
> The pcie device naming is updated to accomodate the additional service
> driver. From Lukas Wunner <lukas@wunner.de>:
> 
> The names of port service devices previously used one nibble to encode
> the port type and another nibble to encode the service type. Since this
> commit introduces a fifth service type, it changes device names to use
> one *byte* to encode the service type. E.g. a hotplug port service on a
> downstream bridge was previously called pcie24 and is now called pcie204.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Cc: Lukas Wunner <lukas@wunner.de>

Applied to pci/dpc for v4.7, thanks, Keith.

> +static void dpc_remove(struct pcie_device *dev)
> +{
> +	struct dpc_dev *dpc = get_service_data(dev);
> +	struct pci_dev *pdev = dev->port;
> +	u16 ctl;
> +
> +	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
> +	ctl |= ~(PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN);

This looks like a typo; I assume you meant:

  ctl &= ~(PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN);

so we *clear* (not set) these bits on removal.  I made this change on
my branch.

I also split the portdrv changes to a separate commit to make the
history more obvious when we merge Lukas' similar Thunderbolt portdrv
changes.
