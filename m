Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:19862 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdJCAOS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2017 20:14:18 -0400
Date: Mon, 2 Oct 2017 17:14:09 -0700
From: Govindarajulu Varadarajan <gvaradar@cisco.com>
To: Christoph Hellwig <hch@lst.de>
CC: <benve@cisco.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jlbec@evilplan.org>, <mingo@redhat.com>, <peterz@infradead.org>,
        <okaya@codeaurora.org>
Subject: Re: [PATCH V2] PCI: AER: fix deadlock in do_recovery
In-Reply-To: <20171001075514.GA11554@lst.de>
Message-ID: <alpine.LNX.2.20.1710021606440.30867@cae-iprp-alln-lb.cisco.com>
References: <20170930054938.43271-1-gvaradar@cisco.com> <20171001075514.GA11554@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 1 Oct 2017, Christoph Hellwig wrote:

>> +struct aer_device_list {
>> +	struct device *dev;
>> +	struct hlist_node node;
>> +};
>> +
>>  extern struct bus_type pcie_port_bus_type;
>>  void aer_isr(struct work_struct *work);
>>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
>> index 890efcc574cb..d524f2c2c288 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_core.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
>> @@ -346,6 +346,47 @@ static int report_resume(struct pci_dev *dev, void *data)
>>  	return 0;
>>  }
>>
>> +int aer_get_pci_dev(struct pci_dev *pdev, void *data)
>> +{
>> +	struct hlist_head *hhead = (struct hlist_head *)data;
>> +	struct device *dev = &pdev->dev;
>> +	struct aer_device_list *entry;
>> +
>> +	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
>> +	if (!entry)
>> +		/* continue with other devices, lets not return error */
>> +		return 0;
>> +
>> +	entry->dev = get_device(dev);
>> +	hlist_add_head(&entry->node, hhead);
>> +
>> +	return 0;
>
> Can we just embedded the list_head in the pci_dev?  Or is there a way
> we can have multiple chains like this pending at the same time?
>

I would avoid increasing the size of pci_dev. The list_head would be empty after
we call aer_pci_walk_bus(). We already have pci_bus *subordinate to link all the
'device's. Making list_head available to others would require a lock. I would
avoid that.

>> +static void aer_pci_walk_bus(struct pci_bus *top,
>> +			     int (*cb)(struct pci_dev *, void *),
>> +			     struct aer_broadcast_data *result)
>> +{
>> +	HLIST_HEAD(dev_hlist);
>> +	struct hlist_node *tmp;
>> +	struct aer_device_list *entry;
>
> Do we want to offer this as generic PCIe functionality?  If not we can
> probably hardcode the callback and callback data to simplify this a lot.
>

I could not find any other code which aquires device_lock in pci_walk_bus cb
function. Can you tell me how we can hardcore callback and callback data here?
