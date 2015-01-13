Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54B52168.3080600@arm.com>
Date: Tue, 13 Jan 2015 13:45:12 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2 2/8] PCI/MSI: Add hooks to populate the msi_domain
 field
References: <1420736772-11088-1-git-send-email-marc.zyngier@arm.com> <1420736772-11088-3-git-send-email-marc.zyngier@arm.com> <54B510BA.7030202@huawei.com>
In-Reply-To: <54B510BA.7030202@huawei.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13/01/15 12:34, Yijing Wang wrote:
>>  static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>>  					   struct pci_dev *bridge, int busnr)
>>  {
>> @@ -713,6 +727,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>>  	bridge->subordinate = child;
>>  
>>  add_dev:
>> +	pci_set_bus_msi_domain(child);
>>  	ret = device_register(&child->dev);
>>  	WARN_ON(ret < 0);
>>  
>> @@ -1507,6 +1522,17 @@ static void pci_init_capabilities(struct pci_dev *dev)
>>  	pci_enable_acs(dev);
>>  }
>>  
>> +static void pci_set_msi_domain(struct pci_dev *dev)
>> +{
>> +	/*
>> +	 * If no domain has been set through the pcibios callback,
>> +	 * inherit the default from the bus device.
>> +	 */
>> +	if (!dev_get_msi_domain(&dev->dev))
>> +		dev_set_msi_domain(&dev->dev,
>> +				   dev_get_msi_domain(&dev->bus->dev));
>> +}
> 
> Hi Marc, now we have two ways to associate the pci_dev and msi_domain, right ?
> 
> 1. associate pci_dev and msi_domain in pcibios_add_device() like x86.
> 
> 2. Inherit msi_domain from pci_dev->bus.
> 
> My question is if all pci devices inherit msi_domain from the pci_bus,
> so all pci devices under same pci host bridge have the same msi_domain assigned by
> weak pcibios_set_phb_msi_domain(). So why not save the pci host bridge specific
> msi_domain in pci_host_bridge. Then pci devices could inherit the msi_domain from
> its pci host bridge directly, no need to involve pci bus in the assignment.

But then, you would end-up maintaining another msi_domain field inside
the pci_host bridge structure. What do you gain by doing so?

With this series, msi_domain has the nice property of always being tied
to a device (and struct pci_bus always has a device). We always have
phb->bus->dev.msi_domain within reach, and architecture code can decide
to override it on a per-device basis.

What else do you need? What am I missing from your proposal?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
