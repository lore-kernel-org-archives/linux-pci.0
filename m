Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:37486 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbbCFS3F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2015 13:29:05 -0500
Received: by oigi138 with SMTP id i138so19094197oig.4
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2015 10:29:05 -0800 (PST)
Date: Fri, 6 Mar 2015 12:29:02 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Scott Murray <scott@spiteful.org>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] PCI: cpcihp: missing curly braces in
 cpci_configure_slot()
Message-ID: <20150306182902.GF20077@google.com>
References: <20150225132322.GJ19745@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150225132322.GJ19745@mwanda>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 25, 2015 at 04:23:22PM +0300, Dan Carpenter wrote:
> I don't have this hardware but it looks like we weren't adding bridge
> devices as intended.  Maybe the bridge is always the last device?
> 
> Fixes: 05b125004815 ('PCI: cpcihp: Iterate over all devices in slot, not functions 0-7')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied with Yijing's ack to for-linus for v4.0, thanks!  Also marked for
stable.

I'm afraid this is probably my fault, sorry.

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
>  
>  	pci_assign_unassigned_bridge_resources(parent->self);
