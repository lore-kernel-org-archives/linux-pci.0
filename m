Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [119.145.14.66] ([119.145.14.66]:12190 "EHLO
	szxga03-in.huawei.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbbBZBBx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Feb 2015 20:01:53 -0500
Message-ID: <54EE704D.5060401@huawei.com>
Date: Thu, 26 Feb 2015 09:01:01 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>,
	Scott Murray <scott@spiteful.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [patch] PCI: cpcihp: missing curly braces in cpci_configure_slot()
References: <20150225132322.GJ19745@mwanda>
In-Reply-To: <20150225132322.GJ19745@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/2/25 21:23, Dan Carpenter wrote:
> I don't have this hardware but it looks like we weren't adding bridge
> devices as intended.  Maybe the bridge is always the last device?
> 
> Fixes: 05b125004815 ('PCI: cpcihp: Iterate over all devices in slot, not functions 0-7')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
> index 7d48eca..788db48 100644
> --- a/drivers/pci/hotplug/cpci_hotplug_pci.c
> +++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
> @@ -286,11 +286,12 @@ int cpci_configure_slot(struct slot *slot)
>  	}
>  	parent = slot->dev->bus;
>  
> -	list_for_each_entry(dev, &parent->devices, bus_list)
> +	list_for_each_entry(dev, &parent->devices, bus_list) {
>  		if (PCI_SLOT(dev->devfn) != PCI_SLOT(slot->devfn))
>  			continue;
>  		if (pci_is_bridge(dev))
>  			pci_hp_add_bridge(dev);
> +	}
>  

Good fix.

Acked-by: Yijing Wang <wangyijing@huawei.com>

Thanks!
Yijing.

>  
>  	pci_assign_unassigned_bridge_resources(parent->self);
> 
> 


-- 
Thanks!
Yijing

