Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <201605250548.u4P5i1tA003562@mx0a-001b2d01.pphosted.com>
Subject: Re: [PATCH 3/5] PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller
 supports IRQ remapping
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-4-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160524210434.GB16463@localhost>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org, alex.williamson@redhat.com,
	bhelgaas@google.com, aik@ozlabs.ru, benh@kernel.crashing.org,
	paulus@samba.org, mpe@ellerman.id.au, joro@8bytes.org,
	warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
	nikunj@linux.vnet.ibm.com, eric.auger@linaro.org,
	will.deacon@arm.com, gwshan@linux.vnet.ibm.com,
	David.Laight@ACULAB.COM, alistair@popple.id.au, ruscur@russell.cc
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Wed, 25 May 2016 13:48:00 +0800
MIME-Version: 1.0
In-Reply-To: <20160524210434.GB16463@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/5/25 5:04, Bjorn Helgaas wrote:

> On Wed, Apr 27, 2016 at 08:43:28PM +0800, Yongji Xie wrote:
>> On ARM HW the capability of IRQ remapping is abstracted on
>> MSI controller side. MSI_FLAG_IRQ_REMAPPING is used to advertise
>> this [1].
>>
>> To have a universal flag to test this capability for different
>> archs on PCI side, we set PCI_BUS_FLAGS_MSI_REMAP for PCI buses
>> when MSI_FLAG_IRQ_REMAPPING is set.
>>
>> [1] http://www.spinics.net/lists/kvm/msg130256.html
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   drivers/pci/msi.c   |   12 ++++++++++++
>>   drivers/pci/probe.c |    3 +++
>>   include/linux/msi.h |    6 +++++-
>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index a080f44..1661cdf 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -1134,6 +1134,18 @@ void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
>>   }
>>   EXPORT_SYMBOL_GPL(msi_desc_to_pci_sysdata);
>>   
>> +void pci_bus_check_msi_remapping(struct pci_bus *bus,
>> +				 struct irq_domain *domain)
>> +{
>> +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
>> +	struct msi_domain_info *info;
>> +
>> +	info = msi_get_domain_info(domain);
>> +	if (info->flags & MSI_FLAG_IRQ_REMAPPING)
>> +		bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
>> +#endif
>> +}
> Functions named "check_foo" are a pet peeve of mine because the name
> doesn't tell us anything about what the function *does*.  In this
> case, we know it checks something about MSI remapping, but we don't
> know whether we're checking whether it's enabled, disabled, or some
> other property.
>
> I'd prefer something like:
>
>    int pci_bus_msi_isolated(struct pci_bus *bus, struct irq_domain *domain)
>    {
>      struct msi_domain_info *info;
>
>      if (!domain)
>        return 0;
>
>      info = msi_get_domain_info(domain);
>      if (info->flags & MSI_FLAG_IRQ_REMAPPING)
>        return 1;
>
>      return 0;
>    }
>
>    void pci_set_bus_msi_domain(struct pci_bus *bus)
>    {
>      ...
>      if (b == bus && pci_bus_msi_isolated(bus, d))
>        bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;

Yes. This looks more reasonable. Thank you!

Regards,
Yongji
