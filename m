Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <52F886ED.7040603@huawei.com>
Date: Mon, 10 Feb 2014 15:59:41 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Oliver Neukum <oneukum@suse.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH part1 v5 5/7] PCI: Add pci_dummy_ops to isolate pci device
 temporarily
References: <1392005051-54508-1-git-send-email-wangyijing@huawei.com>	 <1392005051-54508-6-git-send-email-wangyijing@huawei.com> <1392015399.21271.9.camel@linux-fkkt.site>
In-Reply-To: <1392015399.21271.9.camel@linux-fkkt.site>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Oliver,
   Thanks for your review and comments!

>> +static DEFINE_SPINLOCK(pci_freeze_lock);
> 
> The lock is used only here.

Also be used in pci_bus_unfreeze_device();

> 
>> +/**
>> + * pci_bus_freeze_device - freeze pci bus to access pci device
>> + * @bus: the pci bus to freeze
>> + *
>> + * Replace pci bus ops by pci_dummy_ops, protect system from
>> + * accessing pci devices.
>> + */
>> +void pci_bus_freeze_device(struct pci_bus *bus)
>> +{
>> +	struct pci_ops *ops;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&pci_freeze_lock, flags);
>> +	ops = pci_bus_set_ops(bus, &pci_dummy_ops);
>> +	bus->save_ops = ops;
>> +	spin_unlock_irqrestore(&pci_freeze_lock, flags);
> 
> Against what exactly are you locking here?

I want to use this spin lock to serialize freeze device and unfreeze device.

Thanks!
Yijing.
> 
> 
> 
> 


-- 
Thanks!
Yijing

