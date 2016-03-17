Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:60815 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932832AbcCQLbP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2016 07:31:15 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Thu, 17 Mar 2016 21:31:12 +1000
Subject: Re: [RFC PATCH v4 5/7] vfio-pci: Allow to mmap sub-page MMIO BARs if
 the mmio page is exclusive
To: Alex Williamson <alex.williamson@redhat.com>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1457336918-3893-6-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160316103034.48666ae0@t450s.home>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
	aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org,
	mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <56EA9532.2050902@linux.vnet.ibm.com>
Date: Thu, 17 Mar 2016 19:29:54 +0800
MIME-Version: 1.0
In-Reply-To: <20160316103034.48666ae0@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/3/17 0:30, Alex Williamson wrote:
> On Mon,  7 Mar 2016 15:48:36 +0800
> Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:
>
>> Current vfio-pci implementation disallows to mmap
>> sub-page(size < PAGE_SIZE) MMIO BARs because these BARs' mmio
>> page may be shared with other BARs.
>>
>> But we should allow to mmap these sub-page MMIO BARs if PCI
>> resource allocator can make sure these BARs' mmio page will
>> not be shared with other BARs.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   drivers/vfio/pci/vfio_pci.c |    7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> index 1ce1d36..49d7a69 100644
>> --- a/drivers/vfio/pci/vfio_pci.c
>> +++ b/drivers/vfio/pci/vfio_pci.c
>> @@ -589,7 +589,8 @@ static long vfio_pci_ioctl(void *device_data,
>>   				     VFIO_REGION_INFO_FLAG_WRITE;
>>   			if (IS_ENABLED(CONFIG_VFIO_PCI_MMAP) &&
>>   			    pci_resource_flags(pdev, info.index) &
>> -			    IORESOURCE_MEM && info.size >= PAGE_SIZE) {
>> +			    IORESOURCE_MEM && !pci_resources_share_page(pdev,
>> +			    info.index)) {
> this would be a preferable line wrap:
>
>                              IORESOURCE_MEM &&
>                              !pci_resources_share_page(pdev, info.index)) {

OK. I'll fix it.

Thanks,
Yongji Xie

