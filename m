Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADC333A701;
	Thu, 29 Jan 2026 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769688645; cv=none; b=EBt+j8NIFDg6u2vc72NTUqJJrBQfMh3/3oQXvZreVbKQfz76bbuMLEs2Rr2JQdpUW6xrZJN7uDakNtHini0rCvi3UX7dbVnwZXTsdmn3t3IMtdARH9OJSm5m5Jw0lgCuTNK5+y4GKSv4mvX5CX26ond3aIm5ugY95uZdTaOIlcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769688645; c=relaxed/simple;
	bh=XCRz1z5qlQvwJ4R7uoserjsGfyijx8ZsPXn4z0wfEps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFOI+bfV8ZZBV3HFMSRorbggTp1XA92ZXJ42sphfEgq9zWC1IfT5qEgEBHdHGO4BEUGiRmAgJvTwPF5B/XMKrcdwB6Ojce0O6tXqeEPVUs4SCEv19KqYDXxuzmE7sS6Jt7eiIgwe2XG3Ju+P1s0jxwSty+6WyxvRS77WbJtdpq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EvaTUVx9; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EvaTUVx9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769688639; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tCSReYBhehaf4SQSg9qzdK6jY/HB57uEHPOEgOMpYJg=;
	b=EvaTUVx9CQ4AhgwZ56Qd0Az4DaS2glOaamntZhHjTGsKLntJMDJEBA+Dz4dUKNfqIhW2u6ddibJfaN4dKz2NYVsrPHRpfBWVtreNYKGURx9Q+C5HjYi95RFwbXt6Zs3jPPtj0+hvkdv6VL/QNZWtzvXBDk3J7QzZrGRDIAMIdzs=
Received: from 30.246.162.115(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wy7NtdK_1769688638 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Jan 2026 20:10:39 +0800
Message-ID: <4d1e770b-d430-452a-ab21-6eff676f87ae@linux.alibaba.com>
Date: Thu, 29 Jan 2026 20:09:57 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] PCI/AER: Only clear error bits in
 pcie_clear_device_status()
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com, tianruidong@linux.alibaba.com, lukas@wunner.de
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-6-xueshuai@linux.alibaba.com>
 <acf0a082-93b3-49a6-a02c-a0b82b83391a@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <acf0a082-93b3-49a6-a02c-a0b82b83391a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/29/26 1:01 AM, Kuppuswamy Sathyanarayanan wrote:
> 
> 
> On 1/23/2026 11:45 PM, Shuai Xue wrote:
>> Currently, pcie_clear_device_status() clears the entire PCIe Device
>> Status register (PCI_EXP_DEVSTA), which includes both error status bits
>> and other status bits such as AUX Power Detected (AUXPD) and
>> Transactions Pending (TRPND).
>>
>> Clearing non-error status bits can interfere with other drivers or
>> subsystems that may rely on these bits. To fix it, only clear the error
>> bits (0xf) while preserving other status bits.
>>
>> Fixes: ec752f5d54d7 ("PCI/AER: Clear device status bits during ERR_FATAL and ERR_NONFATAL")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> 
>>   drivers/pci/pci.c             | 2 +-
>>   include/uapi/linux/pci_regs.h | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 13dbb405dc31..0b947f90c333 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -2246,7 +2246,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>>   	u16 sta;
>>   
>>   	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>> -	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>> +	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta & PCI_EXP_DEVSTA_ERR);
>>   }
>>   #endif
>>   
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index 3add74ae2594..f4b68203bc4e 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -534,6 +534,7 @@
>>   #define  PCI_EXP_DEVSTA_NFED	0x0002	/* Non-Fatal Error Detected */
>>   #define  PCI_EXP_DEVSTA_FED	0x0004	/* Fatal Error Detected */
>>   #define  PCI_EXP_DEVSTA_URD	0x0008	/* Unsupported Request Detected */
>> +#define  PCI_EXP_DEVSTA_ERR	0xf	/* Error bits */
> 
> To align with other macros, use 0x000F?
> 
Sure, will fix it.

Thanks.

Best Regards,
Shuai
