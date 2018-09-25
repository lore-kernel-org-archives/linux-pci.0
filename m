Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449E0C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 21:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D045220896
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 21:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDdOL4JE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D045220896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbeIZDZY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeIZDZX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 23:25:23 -0400
Received: from [10.80.45.152] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 512F720877;
        Tue, 25 Sep 2018 21:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537910154;
        bh=T+9fWDPyeM8YwENeKeLTSuDFdBNKMJyZrNWvrwVtiNM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DDdOL4JEkmJ07/ClqYEsHlcqm2dcknae4PVTj8L01abQY90xm+HLJOu5BkdIbafca
         E1LY9jcenSqVD1iJpC9ubtiwRUG38lUD2lRo/aOO0Ix2noTb9l6rnoJVR0WpgXyFzx
         egC1/h7De3LpDhNIQhiSeB2NrmgF13wtms16aMLM=
Subject: Re: [PATCH v4 6/6] PCI: Expose reset type to users of pci_reset_bus()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20180919163037.13497-1-okaya@kernel.org>
 <20180919163037.13497-7-okaya@kernel.org>
 <20180925205408.GD80129@bhelgaas-glaptop.roam.corp.google.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <e89e160b-74dc-d912-5999-685069262b30@kernel.org>
Date:   Tue, 25 Sep 2018 17:15:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925205408.GD80129@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/25/2018 4:54 PM, Bjorn Helgaas wrote:
> On Wed, Sep 19, 2018 at 04:30:37PM +0000, Sinan Kaya wrote:
>> Looking to have more control between the users of the API vs. what the API
>> can do internally. The new reset_type tells the PCI core about the bounds
>> of the request.
>>
>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>> ---
>>   drivers/pci/pci.c           | 18 +++++++++++++++---
>>   drivers/vfio/pci/vfio_pci.c |  6 ++++--
>>   include/linux/pci.h         |  2 +-
>>   3 files changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b4f14419bd51..f11d29f32119 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5232,13 +5232,25 @@ static int __pci_reset_bus(struct pci_bus *bus)
>>   /**
>>    * pci_reset_bus - Try to reset a PCI bus
>>    * @pdev: top level PCI device to reset via slot/bus
>> + * @reset_type: resets to try
>>    *
>>    * Same as above except return -EAGAIN if the bus cannot be locked
>>    */
>> -int pci_reset_bus(struct pci_dev *pdev)
>> +int pci_reset_bus(struct pci_dev *pdev, u32 reset_type)
>>   {
>> -	return (!pci_probe_reset_slot(pdev->slot)) ?
>> -	    __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
>> +	if (reset_type & PCI_RESET_LINK) {
>> +		return (!pci_probe_reset_slot(pdev->slot)) ?
>> +				__pci_reset_slot(pdev->slot) :
>> +				__pci_reset_bus(pdev->bus);
>> +	}
>> +
>> +	if (reset_type & PCI_RESET_BUS)
>> +		return __pci_reset_bus(pdev->bus);
>> +
>> +	if (reset_type & PCI_RESET_SLOT)
>> +		return __pci_reset_slot(pdev->slot);
> 
> I don't understand this code.  We have
> 
>    #define PCI_RESET_LINK         (PCI_RESET_SLOT | PCI_RESET_BUS)
> 
> so if either PCI_RESET_BUS or PCI_RESET_SLOT is set, we should take
> the first "if" above, which always returns, and the last two should
> never be reached.  What am I missing?

Yup, this is broken. I need to follow up with another patchset.

I was trying to cover the case where user said,

"I need a link reset. I don't care whether it is a slot reset or bus reset
as long as we achieve a reset."

That's when PCI_RESET_LINK is used. We expect most drivers to PCI_RESET_LINK
if they are interested in a link reset and doesn't need to know about the
hotplug capability of a particular slot.

> 
>> +
>> +	return -EINVAL;
>>   }
>>   EXPORT_SYMBOL_GPL(pci_reset_bus);
>>   
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> index fe7ada997c51..0e80c72b1eaa 100644
>> --- a/drivers/vfio/pci/vfio_pci.c
>> +++ b/drivers/vfio/pci/vfio_pci.c
>> @@ -1015,7 +1015,8 @@ static long vfio_pci_ioctl(void *device_data,
>>   						    &info, slot);
>>   		if (!ret)
>>   			/* User has access, do the reset */
>> -			ret = pci_reset_bus(vdev->pdev);
>> +			ret = pci_reset_bus(vdev->pdev,
>> +				slot ? PCI_RESET_SLOT :	PCI_RESET_BUS);
> 
> This is the only place in the whole series where a caller uses
> something other than PCI_RESET_ANY.  Inquiring minds want to know why.
> I'm sure it's the right thing to do, it's just that we'll need to know
> how to choose in future cases.

Use PCI_RESET_ANY for the existing behavior where you want one type of
reset and don't care if it is PM/function/slot/bus/specific.

Use PCI_RESET_LINK when you need link to retrain.

Use PCI_RESET_SLOT when you know that this system is hotplug capable
by calling probe functions.

Use PCI_RESET_BUS when you know that this system is not hotplug capable
and this endpoint will never be used in such a system.

I can capture this into the commit message.

> 
>>   
>>   hot_reset_release:
>>   		for (i--; i >= 0; i--)
>> @@ -1390,7 +1391,8 @@ static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
>>   	}
>>   
>>   	if (needs_reset)
>> -		ret = pci_reset_bus(vdev->pdev);
>> +		ret = pci_reset_bus(vdev->pdev,
>> +				slot ? PCI_RESET_SLOT :	PCI_RESET_BUS);
>>   
>>   put_devs:
>>   	for (i = 0; i < devs.cur_index; i++) {
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 4fdddcb85066..85f48e156753 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1128,7 +1128,7 @@ int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
>>   int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
>>   int pci_probe_reset_slot(struct pci_slot *slot);
>>   int pci_probe_reset_bus(struct pci_bus *bus);
>> -int pci_reset_bus(struct pci_dev *dev);
>> +int pci_reset_bus(struct pci_dev *dev, u32 reset_type);
>>   void pci_reset_secondary_bus(struct pci_dev *dev);
>>   void pcibios_reset_secondary_bus(struct pci_dev *dev);
>>   void pci_update_resource(struct pci_dev *dev, int resno);
>> -- 
>> 2.18.0
>>
> 

