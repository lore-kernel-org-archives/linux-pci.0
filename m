Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A52F5A08;
	Wed, 28 Jan 2026 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603409; cv=none; b=dzCKFbxcQSF5s9ch5SHiaWOTF4TZawgv9Q9fgHG+LaAS/evyfR66mtrf27R0FN4BtqNT6SNLAUU/1/JRzyZNB+qzxrw+n18K3LMPpe7hp1LGppurpfuIuimwnXEt3sX3cVEsp60wxpGgSs997gQiiFTZekNTOgUgz7JyXkvLHHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603409; c=relaxed/simple;
	bh=xp20oFk7bxDa2VMs3V2DvkFa0AuDlyaBGxKusAUOYa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3NGD0mc2rmU9hLMH53HvAYDQ/o8zU9VuUelwIgn093q3o9tBjMFYvlYEgsvFII0IMKsKVgoOoJgVk49wQb+A0D3Otrie9qinLiP6AO6OvXTPj+GFodOPOHS/Zid4Q7pF5gniyfEBGUSH+W5LOjNSCAbQEpVgIjwKPEN9C9xHS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WA/24Cga; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WA/24Cga"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769603404; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F50On8HKlI4ka25pRlURh9O9mME500DymQXKBhDiFm0=;
	b=WA/24CgaOo/q/mmeCIfLYLpqMhWcrHKhVhmWFUgNlkSOlRqYT/zNfDNXP/KImNQuJbkI9FI+KUb5n0DOIZcsfzjaC4u2hKq9GqfnEVTFIKEhyeG0LvU+1MvQhSZuUYUSp3auX9WsmjBC44AbmTO9bY60n2ou69+ibwt8tLc503A=
Received: from 30.246.162.115(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wy3NkbG_1769603403 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Jan 2026 20:30:04 +0800
Message-ID: <d23f7971-2c01-4242-b781-1378d96c130f@linux.alibaba.com>
Date: Wed, 28 Jan 2026 20:29:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, terry.bowman@amd.com, tianruidong@linux.alibaba.com,
 lukas@wunner.de
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-4-xueshuai@linux.alibaba.com>
 <20260127103643.00007991@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260127103643.00007991@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/27/26 6:36 PM, Jonathan Cameron wrote:
> On Sat, 24 Jan 2026 15:45:55 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> The AER driver has historically avoided reading the configuration space of
>> an endpoint or RCiEP that reported a fatal error, considering the link to
>> that device unreliable. Consequently, when a fatal error occurs, the AER
>> and DPC drivers do not report specific error types, resulting in logs like:
>>
>>    pcieport 0015:00:00.0: EDR: EDR event received
>>    pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
>>    pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
>>    pcieport 0015:00:00.0: AER: broadcast error_detected message
>>    pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
>>    pcieport 0015:00:00.0: AER: broadcast resume message
>>    pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
>>    pcieport 0015:00:00.0: AER: device recovery successful
>>    pcieport 0015:00:00.0: EDR: DPC port successfully recovered
>>    pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80
>>
>> AER status registers are sticky and Write-1-to-clear. If the link recovered
>> after hot reset, we can still safely access AER status and TLP header of the
>> error device. In such case, report fatal errors which helps to figure out the
>> error root case.
>>
>> After this patch, the logs like:
>>
>>    pcieport 0015:00:00.0: EDR: EDR event received
>>    pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
>>    pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
>>    pcieport 0015:00:00.0: AER: broadcast error_detected message
>> + vfio-pci 0015:01:00.0: AER: Errors reported prior to reset
>> + vfio-pci 0015:01:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>> + vfio-pci 0015:01:00.0:   device [144d:a80a] error status/mask=00001000/00400000
>> + vfio-pci 0015:01:00.0:    [12] TLP                    (First)
>> + vfio-pci 0015:01:00.0: AER:   TLP Header: 0x4a004010 0x00000040 0x01000000 0xffffffff
>>    pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
>>    pcieport 0015:00:00.0: AER: broadcast resume message
>>    pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
>>    pcieport 0015:00:00.0: AER: device recovery successful
>>    pcieport 0015:00:00.0: EDR: DPC port successfully recovered
>>    pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Hi Shuai,
> 
> With the structure zeroed below (just to make this easier to review, not because
> there is a bug as far as I can see)
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index e0bcaa896803..4c0a2bbe9197 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
> 
>> @@ -1447,17 +1450,38 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
>>   	return 1;
>>   }
>>   
>> +void aer_report_frozen_error(struct pci_dev *dev)
>> +{
>> +	struct aer_err_info info;
>> +	int type = pci_pcie_type(dev);
>> +
>> +	if (type != PCI_EXP_TYPE_ENDPOINT && type != PCI_EXP_TYPE_RC_END)
>> +		return;
>> +
> 
> struct aer_err_info has a bunch of fields. I'd just make sure it's zeroed
> to avoid us having to check that they are all filled in. = {};
> or do it with the initial values being assigned.
> 
> 	info = (struct aer_err_info) {
> 		.err_dev_num = 0,
> 		.severity = AER_FATAL,
> 		.level = KERN_ERR,
> 	};
> 	add_error_device(&info, dev);
> 
> 

Got it. Will fix it in next verison.

Thanks for valuable comments.

Best Regards,
Shuai
