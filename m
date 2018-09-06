Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:56904 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIFXKT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Sep 2018 19:10:19 -0400
Subject: Re: [PATCHv2 16/20] PCI/pciehp: Implement error handling callbacks
To: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>
References: <20180905203546.21921-1-keith.busch@intel.com>
 <20180905203546.21921-17-keith.busch@intel.com>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <367ae8b0-1a42-0b26-7865-e7398c62e403@oracle.com>
Date: Thu, 6 Sep 2018 14:23:19 -0400
MIME-Version: 1.0
In-Reply-To: <20180905203546.21921-17-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 09/05/2018 04:35 PM, Keith Busch wrote:
> Error handling may trigger spurious link events, which may trigger
> hotplug handling to re-enumerate the topology. This patch temporarily
> disables notification during such error handling and checks the topology
> for changes after reset.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>   drivers/pci/hotplug/pciehp.h      |  1 +
>   drivers/pci/hotplug/pciehp_core.c | 39 +++++++++++++++++++++++++++++++++++++++
>   drivers/pci/hotplug/pciehp_hpc.c  |  9 +++++++++
>   3 files changed, 49 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 3a53a24f22f0..f43bcf291c4e 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -194,6 +194,7 @@ void pciehp_get_attention_status(struct slot *slot, u8 *status);
>   void pciehp_set_attention_status(struct slot *slot, u8 status);
>   void pciehp_get_latch_status(struct slot *slot, u8 *status);
>   void pciehp_get_adapter_status(struct slot *slot, u8 *status);
> +void pciehp_get_adapter_changed(struct slot *slot, u8 *changed);
>   int pciehp_query_power_fault(struct slot *slot);
>   void pciehp_green_led_on(struct slot *slot);
>   void pciehp_green_led_off(struct slot *slot);
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index ec48c9433ae5..7181fd991068 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -301,6 +301,43 @@ static void pciehp_remove(struct pcie_device *dev)
>   	pciehp_release_ctrl(ctrl);
>   }
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
> +}
> +
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

error: ‘parent’ undeclared.

Shouldn't it be __pci_walk_bus(dev->port->bus, 
pci_dev_set_disconnected, NULL);

Thanks,
Thomas

> +	} else if (atomic_read(&ctrl->pending_events) && !pciehp_poll_mode)
> +		irq_wake_thread(ctrl->pcie->irq, ctrl);
> +}
> +
>   #ifdef CONFIG_PM
>   static int pciehp_suspend(struct pcie_device *dev)
>   {
> @@ -340,6 +377,8 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
>   
>   	.probe		= pciehp_probe,
>   	.remove		= pciehp_remove,
> +	.error_detected	= pciehp_error_detected,
> +	.slot_reset	= pciehp_slot_reset,
>   
>   #ifdef	CONFIG_PM
>   	.suspend	= pciehp_suspend,
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 52a18a7ec2a2..5ec2bc871a9c 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -382,6 +382,15 @@ void pciehp_get_adapter_status(struct slot *slot, u8 *status)
>   	*status = !!(slot_status & PCI_EXP_SLTSTA_PDS);
>   }
>   
> +void pciehp_get_adapter_changed(struct slot *slot, u8 *changed)
> +{
> +	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
> +	u16 slot_status;
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> +	*changed = !!(slot_status & PCI_EXP_SLTSTA_PDC);
> +}
> +
>   int pciehp_query_power_fault(struct slot *slot)
>   {
>   	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
> 
