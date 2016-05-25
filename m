Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59290 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753973AbcEYFyk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2016 01:54:40 -0400
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u4P5sQaf014842
	for <linux-pci@vger.kernel.org>; Wed, 25 May 2016 01:54:40 -0400
Message-Id: <201605250554.u4P5sQaf014842@mx0a-001b2d01.pphosted.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
	by mx0a-001b2d01.pphosted.com with ESMTP id 234qhw7sm8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 25 May 2016 01:54:39 -0400
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Wed, 25 May 2016 11:24:34 +0530
Subject: Re: [PATCH 2/5] iommu: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have
 capability of IRQ remapping
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-3-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160524211149.GC16463@localhost>
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
Date: Wed, 25 May 2016 13:54:23 +0800
MIME-Version: 1.0
In-Reply-To: <20160524211149.GC16463@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/5/25 5:11, Bjorn Helgaas wrote:

> On Wed, Apr 27, 2016 at 08:43:27PM +0800, Yongji Xie wrote:
>> The capability of IRQ remapping is abstracted on IOMMU side on
>> some archs. There is a existing flag IOMMU_CAP_INTR_REMAP for this.
>>
>> To have a universal flag to test this capability for different
>> archs on PCI side, we set PCI_BUS_FLAGS_MSI_REMAP for PCI buses
>> when IOMMU_CAP_INTR_REMAP is set.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   drivers/iommu/iommu.c |   15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 0e3b009..5d2b6f6 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -813,6 +813,16 @@ struct iommu_group *pci_device_group(struct device *dev)
>>   	return group;
>>   }
>>   
>> +static void pci_check_msi_remapping(struct pci_dev *pdev,
>> +					const struct iommu_ops *ops)
>> +{
>> +	struct pci_bus *bus = pdev->bus;
>> +
>> +	if (ops->capable(IOMMU_CAP_INTR_REMAP) &&
>> +		!(bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP))
>> +		bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
>> +}
> This looks an awful lot like the pci_bus_check_msi_remapping() you add
> elsewhere.  Why do we need both?

I will modify this function as you suggested.  And we add this function
here because some iommu drivers would be initialed after PCI probing.

>>   /**
>>    * iommu_group_get_for_dev - Find or create the IOMMU group for a device
>>    * @dev: target device
>> @@ -871,6 +881,9 @@ static int add_iommu_group(struct device *dev, void *data)
>>   	const struct iommu_ops *ops = cb->ops;
>>   	int ret;
>>   
>> +	if (dev_is_pci(dev) && ops->capable)
>> +		pci_check_msi_remapping(to_pci_dev(dev), ops);
>> +
>>   	if (!ops->add_device)
>>   		return 0;
>>   
>> @@ -913,6 +926,8 @@ static int iommu_bus_notifier(struct notifier_block *nb,
>>   	 * result in ADD/DEL notifiers to group->notifier
>>   	 */
>>   	if (action == BUS_NOTIFY_ADD_DEVICE) {
>> +		if (dev_is_pci(dev) && ops->capable)
>> +			pci_check_msi_remapping(to_pci_dev(dev), ops);
> These calls don't smell right either.  Why do we need dev_is_pci()
> checks here?

Some platform devices may also call this.

> Can't this be done in the PCI probe path somehow, e.g.,
> in pci_set_bus_msi_domain() or something?
>

Yes, this can be done in pci_create_root_bus(). But it could only
handle the case that iommu drivers are initialed before PCI probing.

Regards,
Yongji

