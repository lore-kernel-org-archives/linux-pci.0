Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <559D0342.2040805@arm.com>
Date: Wed, 08 Jul 2015 12:02:26 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [PATCH v3 09/15] irqchip: gicv3-its: Split PCI/MSI code from
 the core ITS driver
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com> <1436289485-28230-10-git-send-email-marc.zyngier@arm.com> <alpine.DEB.2.11.1507081245120.5134@nanos>
In-Reply-To: <alpine.DEB.2.11.1507081245120.5134@nanos>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/07/15 11:48, Thomas Gleixner wrote:
> On Tue, 7 Jul 2015, Marc Zyngier wrote:
>> +static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>> +			       int nvec, msi_alloc_info_t *info)
>> +{
>> +	struct pci_dev *pdev;
>> +	struct its_pci_alias dev_alias;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return -EINVAL;
>> +
>> +	pdev = to_pci_dev(dev);
>> +	dev_alias.pdev = pdev;
>> +	dev_alias.count = nvec;
>> +
>> +	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
>> +
>> +	return its_msi_prepare(domain, dev_alias.dev_id, dev_alias.count, info);
> 
> I don't think you need its_msi_prepare() exposed to child
> drivers. Something like
> 
>   domain->parent->ops->msi_prepare()
> 
> should do the trick.

Good point.

I've so far conveniently avoided having an extra set of msi_domain_ops
at the ITS level itself, but that is starting to look like a mistake.

I'll work something out.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
