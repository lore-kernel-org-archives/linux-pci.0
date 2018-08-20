Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 20 Aug 2018 11:22:38 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] PCI: pciehp: Ignore link events when there is a
 fatal error pending
Message-ID: <20180820092238.kvktwlovc64oa66e@wunner.de>
References: <20180818065126.77912-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180818065126.77912-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2018 at 11:51:09PM -0700, Sinan Kaya wrote:
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -222,9 +222,27 @@ void pciehp_handle_disable_request(struct slot *slot)
>  void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
>  {
>  	struct controller *ctrl = slot->ctrl;
> +	struct pci_dev *pdev = ctrl->pcie->port;
>  	bool link_active;
>  	u8 present;
>  
> +	/* If a fatal error is pending, wait for AER or DPC to handle it. */
> +	if (pcie_fatal_error_pending(pdev)) {
> +		bool recovered;
> +
> +		recovered = pcie_wait_fatal_error_clear(pdev);
> +
> +		/* If the fatal error is gone and the link is up, return */
> +		if (recovered && pcie_wait_for_link(pdev, true)) {
> +			ctrl_info(ctrl, "Slot(%s): Ignoring Link event due to successful fatal error recovery\n",
> +				  slot_name(slot));
> +			return;
> +		}
> +
> +		ctrl_info(ctrl, "Slot(%s): Fatal error recovery failed for Link event, trying hotplug reset\n",
> +			  slot_name(slot));
> +	}
> +

This differs from v7 of the patch in that *any* fatal error, not just
a Surprise Link Down, results in pciehp waiting for the error to clear.

I'm wondering if that's safe:  Theoretically, the user might quickly
swap the card in the slot during, say, a Completion Timeout Error,
and with this patch pciehp would carry on as if nothing happened.

Thanks,

Lukas
