Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbeIFAgX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 20:36:23 -0400
Date: Wed, 5 Sep 2018 15:04:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rgummal@xilinx.com
Subject: Re: [PATCH v2] PCI/AER: Enable SERR# forwarding in non ACPI flow
Message-ID: <20180905200434.GP107892@bhelgaas-glaptop.roam.corp.google.com>
References: <1533826657-24552-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1533826657-24552-1-git-send-email-bharat.kumar.gogada@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 09, 2018 at 08:27:37PM +0530, Bharat Kumar Gogada wrote:
> As per Figure 6-3 in PCIe r4.0, sec 6.2.6, ERR_ messages
> will be forwarded from the secondary interface to the primary interface,
> if the SERR# Enable bit in the Bridge Control register is set.
> Currently PCI_BRIDGE_CTL_SERR is being enabled only in
> ACPI flow.
> This patch enables PCI_BRIDGE_CTL_SERR for Type-1 PCI device.

I agree this is a problem.  We should not depend on how firmware set
PCI_BRIDGE_CTL_SERR.

I would prefer to set it in the pci_configure_device() path so we
always do it the same way for every device, independent of whether AER
is enabled.

Some platform firmware must already enable PCI_BRIDGE_CTL_SERR, even
though it can't know whether the OS will support AER, so it should be
safe for the OS to enable it unconditionally.

The code in program_hpp_type0() that sets PCI_BRIDGE_CTL_SERR is based
on 40abb96c51bb ("[PATCH] pciehp: Fix programming hotplug
parameters") [1], but I think it is incorrect.

ACPI v6.0, sec 6.2.9.1, (_HPX PCI Setting Record) says:

  If the hot plug device includes bridge(s) in the hierarchy, the
  above settings apply to the primary side (command register) of the
  hot plugged bridge(s). The settings for the secondary side of the
  bridge(s) (Bridge Control Register) are assumed to be provided by
  the bridge driver.

Sec 6.2.8 (for the old _HPP method) doesn't contain that text, but it
has the same description of the contents:

  Enable SERR    When set to 1, indicates that action must be
		 performed to enable SERR in the command register.

Both sections talk about enabling SERR in the *command* register (not
the bridge control register) and the _HPX section is explicit about
the fact that "Enable SERR" does not apply to the bridge control
register.

So I think pci_configure_device() should unconditionally set
PCI_BRIDGE_CTL_SERR for all bridge devices.  And we should remove the
corresponding code from program_hpp_type0().

[1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=40abb96c51bb

> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2e8838..4fb0d24 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -343,6 +343,20 @@ int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  	if (!dev->aer_cap)
>  		return -EIO;
>  
> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +		u16 control;
> +
> +		/*
> +		 * A Type-1 PCI bridge will not forward ERR_ messages coming
> +		 * from an endpoint if SERR# forwarding is not enabled.
> +		 */
> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
> +		if (!(control & PCI_BRIDGE_CTL_SERR)) {
> +			control |= PCI_BRIDGE_CTL_SERR;
> +			pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> +		}
> +	}
> +
>  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
>  }
>  EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
> @@ -352,6 +366,15 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
>  	if (pcie_aer_get_firmware_first(dev))
>  		return -EIO;
>  
> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +		u16 control;
> +
> +		/* Clear SERR Forwarding */
> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
> +		control &= ~PCI_BRIDGE_CTL_SERR;
> +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> +	}
> +
>  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
>  					  PCI_EXP_AER_FLAGS);
>  }
> -- 
> 1.7.1
> 
