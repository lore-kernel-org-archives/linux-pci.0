Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:50282 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab3HVB1k (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2013 21:27:40 -0400
Message-ID: <521568F1.7050302@huawei.com>
Date: Thu, 22 Aug 2013 09:27:13 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>
Subject: Re: [PATCH v6 2/2] PCI: update device mps when doing pci hotplug
References: <1377051937-5712-1-git-send-email-wangyijing@huawei.com> <1377051937-5712-3-git-send-email-wangyijing@huawei.com> <20130821233106.GA31379@google.com>
In-Reply-To: <20130821233106.GA31379@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> +	mpss = 128 << dev->pcie_mpss;
>> +	if (mpss >= p_mps) {
>> +		pcie_write_mps(dev, p_mps);
>> +	} else if (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT &&
>> +			pci_only_one_slot(dev->bus)) {
> 
> Good grief.  You apparently didn't even compile this, because
> pci_only_one_slot() doesn't exist.

I wanna shoot myself, :(, so sorry.

> 
> I reworked a couple of your previous patches and added a cleanup or two
> of my own.  I'll post those as v7, and you can fix this one and post it
> as a v8.  That way you and Jon can fix errors in my comments and changelogs
> at the same time.

OK, I will update this patch and try to test all this series in my machine.


Thanks!
Yijing.

> 
>> +		pcie_write_mps(parent, mpss);
>> +		pcie_write_mps(dev, mpss);
>> +	} else
>> +		dev_warn(&dev->dev, "MPS %d MPSS %d both smaller than upstream MPS %d\n"
>> +				"If necessary, use \"pci=pcie_bus_peer2peer\" boot parameter to avoid this problem\n",
>> +				mps, 128 << dev->pcie_mpss, p_mps);
>> +	return 0;
>> +}
>> +
>> +static void pcie_bus_update_setting(struct pci_bus *bus)
>> +{
>> +	if (bus->self->is_hotplug_bridge)
>> +		pci_walk_bus(bus, pcie_bus_update_set, NULL);
>> +}
>> +
>>  /* pcie_bus_configure_settings requires that pci_walk_bus work in a top-down,
>>   * parents then children fashion.  If this changes, then this code will not
>>   * work as designed.
>> @@ -1611,8 +1649,17 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
>>  	if (!pci_is_pcie(bus->self))
>>  		return;
>>  
>> -	if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
>> +	if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
>> +		/* Sometimes we should update device mps here,
>> +		 * eg. after hot add, device mps value will be
>> +		 * set to default(128B), but the upstream port
>> +		 * mps value may be larger than 128B, if we do
>> +		 * not update the device mps, it maybe can not
>> +		 * work normally.
>> +		 */
>> +		pcie_bus_update_setting(bus);
>>  		return;
>> +	}
>>  
>>  	/* FIXME - Peer to peer DMA is possible, though the endpoint would need
>>  	 * to be aware to the MPS of the destination.  To work around this,
>> -- 
>> 1.7.1
>>
>>
> 
> .
> 


-- 
Thanks!
Yijing

