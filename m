Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:5430 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab3GXCBo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2013 22:01:44 -0400
Message-ID: <51EF3570.7030608@huawei.com>
Date: Wed, 24 Jul 2013 10:01:20 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix hotplug remove with sriov again
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai,
   It seems to have the the same problem in acpiphp,

diable_device(..):

	while ((pdev = dev_in_slot(slot))) {
		pci_stop_and_remove_bus_device(pdev);
		pci_dev_put(pdev);
	}


static struct pci_dev *dev_in_slot(struct acpiphp_slot *slot)
{
	struct pci_bus *bus = slot->bridge->pci_bus;
	struct pci_dev *dev;
	struct pci_dev *ret = NULL;

	down_read(&pci_bus_sem);
	list_for_each_entry(dev, &bus->devices, bus_list)
		if (PCI_SLOT(dev->devfn) == slot->device) {
			ret = pci_dev_get(dev);
			break;
		}
	up_read(&pci_bus_sem);


Thanks!
Yijing.

On 2013/7/20 3:14, Yinghai Lu wrote:
> Found hot-remove pcie card with sriov enabled cause crash in v3.10.
> 
> It is regression caused by commit ba518e3c177547dfebf7fa7252cea0c850e7ce25
> (PCI: pciehp: Iterate over all devices in slot, not functions 0-7)
> 
> That commit change to use bus->devices to iterate devices under
> bus to run pci_stop_and_remove_bus_device().
> Actually it duplicates the problem with those bus->devices iteratation
> that we try to fix in commit ac205b7bb72fa4227d2e79979bbe2b4687cdf44d
> (PCI: make sriov work with hotplug remove)
> 
> Change to iterate reversely as we did last time.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Yijing Wang <wangyijing@huawei.com>
> Cc: <stable@vger.kernel.org> v3.9+
> 
> ---
>  drivers/pci/hotplug/pciehp_pci.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/pci/hotplug/pciehp_pci.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/hotplug/pciehp_pci.c
> +++ linux-2.6/drivers/pci/hotplug/pciehp_pci.c
> @@ -92,7 +92,13 @@ int pciehp_unconfigure_device(struct slo
>  	if (ret)
>  		presence = 0;
>  
> -	list_for_each_entry_safe(dev, temp, &parent->devices, bus_list) {
> +	/*
> +	 * Need to iterate device reversely, as during
> +	 * stop PF driver, VF will be removed, the list_for_each
> +	 * could point to removed VF with temp.
> +	 */
> +	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
> +					 bus_list) {
>  		pci_dev_get(dev);
>  		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE && presence) {
>  			pci_read_config_byte(dev, PCI_BRIDGE_CONTROL, &bctl);
> 
> 


-- 
Thanks!
Yijing

