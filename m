Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6B364EA6;
	Thu, 29 Jan 2026 05:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665847; cv=none; b=kEkWw2xOfu9mSL37SWZh3ekqYI9jE3NGLby2LqimNPOEeRzQEKl/OKbQ4OtUnE27V7/uEr4/mXNZaySY9/g+wdGrT6jEBmslDOMVZrup7uYBR1e0se+hxXI8N95IbNytNXyeLGS0PCG/EfnmZtuagJHmRf1+EZFBVolRXy9nBAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665847; c=relaxed/simple;
	bh=/YgiqNLLojuo5+joBzu1WbnPc+KwfsVaQn4nYQDCk/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzxUwgMF8HyAbdEESTAGheuYjMEjccIXkhUYCqT/R8a78KQj9cyxBkGYOycn0a7Nr1nBt+mI2IDAilh7iZOND/FXfd/1blFP2bHLlYc2H6m2VRp7TX8VbvCGIlrhy/eFWvbnGqfyPL2Ls7mjvZC2JJY++2LQxAZfrompjP1pSDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MjCL+UQn; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MjCL+UQn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769665840; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=47L8+0gFyYpLebjc0X12jOfbcSPJ3pEN7OCUUjygrzE=;
	b=MjCL+UQnon6wXV/CmqVbtAPjkQcFiV+rA0QkZipJ3A1Ws0LwrnRONwKN72jyKfCluQD8vLpOVr29DAWa6pzbj6cG8CwU/5itHT283lx3ruGePYx+yvj/2Inbf4oU5GdhyIPdP24qPFIMzDNpREuw7SSG6EyRIgtLHq2fb1FSxpw=
Received: from 30.246.162.115(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wy6D9kt_1769665838 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Jan 2026 13:50:39 +0800
Message-ID: <40cb885e-278a-43ee-a2ac-18c529256c45@linux.alibaba.com>
Date: Thu, 29 Jan 2026 13:49:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] PCI/DPC: Run recovery on device that detected the
 error
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, terry.bowman@amd.com, tianruidong@linux.alibaba.com,
 lukas@wunner.de
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-3-xueshuai@linux.alibaba.com>
 <20260127102402.00004da2@huawei.com>
 <09cf1319-619d-4a6b-97f7-188c1a73aea0@linux.alibaba.com>
 <20260128150243.000012d8@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260128150243.000012d8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/28/26 11:02 PM, Jonathan Cameron wrote:
> On Wed, 28 Jan 2026 20:27:31 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> On 1/27/26 6:24 PM, Jonathan Cameron wrote:
>>> On Sat, 24 Jan 2026 15:45:54 +0800
>>> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>>    
>>>> The current implementation of pcie_do_recovery() assumes that the
>>>> recovery process is executed for the device that detected the error.
>>>> However, the DPC driver currently passes the error port that experienced
>>>> the DPC event to pcie_do_recovery().
>>>>
>>>> Use the SOURCE ID register to correctly identify the device that
>>>> detected the error. When passing the error device, the
>>>> pcie_do_recovery() will find the upstream bridge and walk bridges
>>>> potentially AER affected. And subsequent commits will be able to
>>>> accurately access AER status of the error device.
>>>>
>>>> Should not observe any functional changes.
>>>>
>>>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Hi Shuai,
> 
>>>> ---
>>>>    drivers/pci/pci.h      |  2 +-
>>>>    drivers/pci/pcie/dpc.c | 25 +++++++++++++++++++++----
>>>>    drivers/pci/pcie/edr.c |  7 ++++---
>>>>    3 files changed, 26 insertions(+), 8 deletions(-)
>>>>
> ...
> 
>>>> -void dpc_process_error(struct pci_dev *pdev)
>>>> +/**
>>>> + * dpc_process_error - handle the DPC error status
>>>> + * @pdev: the port that experienced the containment event
>>>> + *
>>>> + * Return: the device that detected the error.
>>>> + *
>>>> + * NOTE: The device reference count is increased, the caller must decrement
>>>> + * the reference count by calling pci_dev_put().
>>>> + */
>>>> +struct pci_dev *dpc_process_error(struct pci_dev *pdev)
>>>
>>> Maybe it makes sense to carry the err_port naming for the pci_dev
>>> in here as well?  Seems stronger than just relying on people
>>> reading the documentation you've added.
>>
>> Good point. I think renaming the parameter would improve clarity. However,
>> I'd prefer to handle it in a separate patch to keep this change focused on
>> the functional modification. Would that work for you?
>>
> Sure. Ideal would be a precursor patch, but if it's much easier to
> do on top of this I'm fine with that.
> 
> You are absolutely correct that it should be a separate patch!

Got it.

>>>      
>>>>    {
>>>>    	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
>>>>    	struct aer_err_info info = {};
>>>> +	struct pci_dev *err_dev;
>>>>    
>>>>    	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>>>>    
>>>> @@ -279,6 +289,7 @@ void dpc_process_error(struct pci_dev *pdev)
>>>>    			pci_aer_clear_nonfatal_status(pdev);
>>>>    			pci_aer_clear_fatal_status(pdev);
>>>>    		}
>>>> +		err_dev = pci_dev_get(pdev);
>>>>    		break;
>>>>    	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE:
>>>>    	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE:
>>>> @@ -290,6 +301,8 @@ void dpc_process_error(struct pci_dev *pdev)
>>>>    				"ERR_FATAL" : "ERR_NONFATAL",
>>>>    			 pci_domain_nr(pdev->bus), PCI_BUS_NUM(source),
>>>>    			 PCI_SLOT(source), PCI_FUNC(source));
>>>> +		err_dev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
>>>> +					    PCI_BUS_NUM(source), source & 0xff);
>>>
>>> Bunch of replication in her with the pci_warn(). Maybe some local variables?
>>> Maybe even rebuild the final parameter from PCI_DEVFN(slot, func) just to make the
>>> association with the print really obvious?
>>
>> Agreed. Here's the improved version:
>>
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -293,17 +293,28 @@ struct pci_dev *dpc_process_error(struct pci_dev *pdev)
>>                   break;
>>           case PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE:
>>           case PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE:
>> -               pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID,
>> -                                    &source);
>> +       {
>> +               int domain, bus;
>> +               u8 slot, func, devfn;
>> +               const char *err_type;
>> +
>> +               pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
>> +
>> +               /* Extract source device location */
>> +               domain = pci_domain_nr(pdev->bus);
>> +               bus = PCI_BUS_NUM(source);
>> +               slot = PCI_SLOT(source);
>> +               func = PCI_FUNC(source);
>> +               devfn = PCI_DEVFN(slot, func);
>> +
>> +               err_type = (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
>> +                          "ERR_FATAL" : "ERR_NONFATAL";
>> +
>>                   pci_warn(pdev, "containment event, status:%#06x, %s received from %04x:%02x:%02x.%d\n",
>> -                        status,
>> -                        (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
>> -                               "ERR_FATAL" : "ERR_NONFATAL",
>> -                        pci_domain_nr(pdev->bus), PCI_BUS_NUM(source),
>> -                        PCI_SLOT(source), PCI_FUNC(source));
>> -               err_dev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
>> -                                           PCI_BUS_NUM(source), source & 0xff);
>> +                        status, err_type, domain, bus, slot, func);
>> +               err_dev = pci_get_domain_bus_and_slot(domain, bus, devfn);
> Maybe don't bother with local variables for the things only used once.
> e.g.
> 
> 		err_dev = pci_get_domain_bus_and_slot(domain, bus, PCI_DEVFN(slot, func));
> 
> and possibly the same for err_type.
> 
> I don't mind though if you prefer to use locals for everything.

Sure, will remove local devfn and err_type.

> 
> 
> 
>>                   break;
>> +       }
>>           case PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT:
>>                   ext_reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT;
>>                   pci_warn(pdev, "containment event, status:%#06x: %s detected\n",
>>
>>>
>>> Is there any chance that this might return NULL?   Feels like maybe that's
>>> only a possibility on a broken setup, but I'm not sure of all the wonderful
>>> races around hotplug and DPC occurring before the OS has caught up.
>>
>> Surprise Down events are handled separately in
>> dpc_handle_surprise_removal() and won't reach dpc_process_error().
>> Please correct me if I missed anything.
> 
> Probably fine. I just didn't check particularly closely.
> 
> Jonathan


Thanks for valuable comments.

Best Regards,
Shuai

