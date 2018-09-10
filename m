Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:38901 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbeIJSOk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Sep 2018 14:14:40 -0400
Date: Mon, 10 Sep 2018 15:20:33 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 16/20] PCI/pciehp: Implement error handling callbacks
Message-ID: <20180910132033.ei5nk4iibt7pesd5@wunner.de>
References: <20180905203546.21921-1-keith.busch@intel.com>
 <20180905203546.21921-17-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905203546.21921-17-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 05, 2018 at 02:35:42PM -0600, Keith Busch wrote:
> Error handling may trigger spurious link events, which may trigger
> hotplug handling to re-enumerate the topology. This patch temporarily
> disables notification during such error handling and checks the topology
> for changes after reset.
[...]
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -301,6 +301,43 @@ static void pciehp_remove(struct pcie_device *dev)
>  	pciehp_release_ctrl(ctrl);
>  }
>  
> +static void pciehp_error_detected(struct pcie_device *dev)
> +{
> +	struct controller *ctrl = get_service_data(dev);
> +
> +	/*
> +	 * Shutdown notification to ignore hotplug events during error
> +	 * handling. We'll recheck the status when error handling completes.
> +	 *
> +	 * It is possible link event related to this error handling may have
> +	 * triggered a the hotplug interrupt ahead of this notification, but we
> +	 * can't do anything about that race.
> +	 */
> +	pcie_shutdown_notification(ctrl);

Unfortunately this patch does not take into account my comment on
patch [13/16] in v1 of this series that pcie_shutdown_notification()
can't be used here because the sysfs user interface to enable/disable
the slot is still present but no longer functions once the IRQ is
released:
https://patchwork.ozlabs.org/patch/964715/

My suggestion was:

   "I think what you want to do instead is "down_write(&ctrl->reset_lock)",
    see commit 5b3f7b7d062b ("PCI: pciehp: Avoid slot access during reset").
    And possibly mask PDCE/DLLSCE like pciehp_reset_slot() does."


> +static void pciehp_slot_reset(struct pcie_device *dev)
> +{
> +	struct controller *ctrl = get_service_data(dev);
> +	u8 changed;
> +
> +	/*
> +	 * Cache presence detect change, but ignore other hotplug events that
> +	 * may occur during error handling. Ports that implement only in-band
> +	 * presence detection may inadvertently believe the device has changed,
> +	 * so those devices will have to be re-enumerated.
> +	 */
> +	pciehp_get_adapter_changed(ctrl->slot, &changed);
> +	pcie_clear_hotplug_events(ctrl);
> +	pcie_init_notification(ctrl);
> +
> +	if (changed) {
> +		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
> +		__pci_walk_bus(parent, pci_dev_set_disconnected, NULL);

The __pci_walk_bus() seems superfluous because the devices are also
marked disconnected when bringing down the slot as a result of the
synthesized PCI_EXP_SLTSTA_PDC event.


> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -382,6 +382,15 @@ void pciehp_get_adapter_status(struct slot *slot, u8 *status)
> +void pciehp_get_adapter_changed(struct slot *slot, u8 *changed)
> +{
> +	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
> +	u16 slot_status;
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> +	*changed = !!(slot_status & PCI_EXP_SLTSTA_PDC);
> +}

When adding new functions like this I usually let them return a bool
instead of passing a call-by-reference parameter.  The only reason
pciehp has these call-by-reference pciehp_get_*() functions is because
some of them assign a u8 value that is then directly passed to user space
via sysfs.

Thanks,

Lukas
