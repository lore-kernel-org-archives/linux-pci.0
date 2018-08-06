Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:44219 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbeHFLjA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2018 07:39:00 -0400
Date: Mon, 6 Aug 2018 11:30:46 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v7 1/1] PCI: pciehp: Ignore link events when there is a
 fatal error pending
Message-ID: <20180806093046.GB28462@wunner.de>
References: <20180805225136.5800-1-okaya@kernel.org>
 <20180805225136.5800-2-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180805225136.5800-2-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 05, 2018 at 03:51:36PM -0700, Sinan Kaya wrote:
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -222,9 +222,28 @@ void pciehp_handle_disable_request(struct slot *slot)
>  void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
>  {
>  	struct controller *ctrl = slot->ctrl;
> +	struct pci_dev *pdev = ctrl->pcie->port;
>  	bool link_active;
>  	u8 present;
>  
> +	/* If a fatal error is pending, wait for AER or DPC to handle it. */
> +	if (pcie_fatal_error_pending(pdev, PCI_ERR_UNC_SURPDN)) {
> +		bool recovered;
> +
> +		recovered = pcie_wait_fatal_error_clear(pdev,
> +						PCI_ERR_UNC_SURPDN);
> +
> +		/* If the fatal error is gone and the link is up, return */
> +		if (recovered && pcie_wait_for_link(pdev, true)) {
> +			ctrl_info(ctrl, "Slot(%s): Ignoring Link event due to successful fatal error recovery\n",
> +				  slot_name(slot));
> +			return;
> +		}
> +
> +		ctrl_info(ctrl, "Slot(%s): Fatal error recovery failed for Link event, tryig hotplug reset\n",

Typo tryig -> trying.  Otherwise this is

Reviewed-by: Lukas Wunner <lukas@wunner.de>
