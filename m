Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:11345 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756622AbaIDGNC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 02:13:02 -0400
Message-ID: <540802D9.6000903@huawei.com>
Date: Thu, 4 Sep 2014 14:12:41 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <Jordan_Hargrave@Dell.com>,
	<keith.busch@intel.com>, <jon.mason@intel.com>,
	Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug
References: <1406621877-12022-1-git-send-email-wangyijing@huawei.com> <20140903224201.GD26073@google.com>
In-Reply-To: <20140903224201.GD26073@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> + * pcie_bus_update_set - update device mps when device doing hot-add
>> + * @dev: PCI device to set
>> + * 
>> + * After device hot add, mps will be set to default(128B), But the 
>> + * upstream port device's mps may be larger than 128B which was set 
>> + * by firmware during system bootup. Then we should update the device
>> + * mps to equal to its parent mps, Or the device can not work normally.
>> + */
>> +static void pcie_bus_update_set(struct pci_dev *dev)
>> +{
>> +	int mps, p_mps, mpss;
>> +	struct pci_dev *parent;
>> +
>> +	if (!pci_is_pcie(dev) || !dev->bus->self 
>> +			|| !dev->bus->self->is_hotplug_bridge)
> 
> Part of this looks redundant because pcie_bus_configure_set() already
> checks pci_is_pcie().  And I don't know why we need to test
> is_hotplug_bridge here; MPS settings need to be consistent regardless of
> whether the upstream bridge supports hotplug.

Hi Bjorn, I added is_hotplug_bridge() here is mainly to touch the hotplug case only.
It was more like a temporary solution and not perfect one.

> 
>> +		return;
>> +	
>> +	parent = dev->bus->self;
>> +	mps = pcie_get_mps(dev);
>> +	p_mps = pcie_get_mps(parent);
>> +
>> +	if (mps >= p_mps)
>> +		return;
>> +
>> +	mpss = 128 << dev->pcie_mpss;
>> +	if (mpss < p_mps) {
>> +		dev_warn(&dev->dev, "MPSS %d smaller than upstream MPS %d\n"
>> +				"If necessary, use \"pci=pcie_bus_safe\" boot parameter to avoid this problem\n",
>> +				mpss, p_mps);
>> +		return;
> 
> Since we can't configure the new device correctly, we really shouldn't
> allow a driver to bind to it.  The current design doesn't have much
> provision for doing that, so warning is probably all we can do.

Yes, bind a driver to the device which mps is not correctly set will cause another problem.

> 
>> +	}
>> +
>> +	pcie_write_mps(dev, p_mps);
>> +	dev_info(&dev->dev, "Max Payload Size set to %4d/%4d (was %4d)\n", 
>> +			pcie_get_mps(dev), 128 << dev->pcie_mpss, mps);
>> +}
>> +
>>  static void pcie_bus_detect_mps(struct pci_dev *dev)
>>  {
>>  	struct pci_dev *bridge = dev->bus->self;
>> @@ -1637,6 +1675,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
>>  		return 0;
>>  
>>  	if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
>> +		pcie_bus_update_set(dev);
> 
> You're only adding this to the PCIE_BUS_TUNE_OFF path.  Can't the same
> problem occur for other pcie_bus_config settings?

We only found the problem during PCIE_BUS_TUNE_OFF set. Other mode like PCIE_BUS_SAFE and PCIE_BUS_PEER2PEER.
This issue won't happen.

> 
>>  		pcie_bus_detect_mps(dev);
>>  		return 0;
>>  	}
> 
> I have some long-term ideas here (below), but to make progress in the short
> term, I think we just need to make sure this handles all pcie_bus_config
> settings.
> 
> Bjorn
> 
> 
> 
> Stepping back a long ways, I think the current design is hard to use.
> It's set up with the idea that we (1) enumerate all the devices in the
> system, and then (2) configure MPS for everything all at once.
> 
> That's not a very good fit when we start hotplugging devices, and it's
> part of the reason MPS configuration is not well integrated into the PCI
> core and doesn't get done at all for most architectures.

Agree, arch code should not be involved the MPS setting. It's arch independent.

> 
> What I'd prefer is something that could be done in the core as each device
> is enumerated, e.g., in or near pci_device_add().  I know there's tension
> between the need to do this before drivers bind to the device and the
> desire to enumerate the whole hierarchy before committing to MPS settings.
> But we need to handle that tension anyway for hot-added devices, so we
> might as well deal with it at boot-time and use the same code path for
> both boot-time and hot-add time.
> 
> I have in mind something like this:
> 
>   pcie_configure_mps(struct pci_dev *dev)
>   {
>     int ret;
> 
>     if (!pci_is_pci(dev))
>       return;
> 
>     if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
>       /* set my MPS to dev->pcie_mpss (max supported size) */
>       return;
>     }
> 
>     if (dev->pcie_mpss >= upstream bridge MPS) {
>       /* set my MPS to upstream bridge MPS */
>       return;
>     }
> 
>     ret = pcie_set_hierarchy_mps(pcie_root_port(dev), dev->mpss);
>     if (ret == failure)
>       /* emit warning, can't enable this device */

If got failure here, should roll back ? What about set hierarchy mps in reverse order(down to top).

>   }
> 
>   struct pci_dev *pcie_root_port(struct pci_dev *dev)
>   {
>     if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>       return dev;
> 
>     return pcie_root_port(dev->bus->self);
>   }
> 
>   pcie_set_hierarchy_mps(struct pci_dev *root, int mpss)
>   {
>     struct pci_bus *secondary;
>     struct pci_dev *dev;
>     int ret;
> 
>     if (root->driver)
>       return -EINVAL;

Maybe it's not safe enough, change device's mps has risk unless all its children devices have no driver bound(disabled).
A root port may has no pcieport driver bound, if pcieport driver probe failed. But its children device can work normally.

> 
>     secondary = root->subordinate;
>     if (secondary) {
>       list_for_each_entry(dev, &secondary->devices, bus_list) {
> 	ret = pcie_set_hierarchy(dev, mpss);
> 	if (ret)
> 	  return ret;
>       }
>     }
> 
>     /* set my MPS to mpss */
>     return 0;
>   }





> 
> .
> 


-- 
Thanks!
Yijing

