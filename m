Received: from mail-m32102.qiye.163.com (mail-m32102.qiye.163.com [220.197.32.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD5A339844
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412089; cv=none; b=IEDg8BhnOwcdiQ85RoIeXbIcVQHQvt9/BYj7IzT4PvYrfiAII/FQLffC3cXDmU5Q144r5gy0sJ5g3UNwzVuN+3rkP0xEzyMMNQb4NNy9t6wL40unmBpQiE1mzon7lSa32a8NJGn5AjVb/L+LGYPq1qrzRd5pDnfa9LaXr6ENXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412089; c=relaxed/simple;
	bh=UHMEUIW+jh05lb5eza5TT3MgxQCo16NqiMJS/Eo8ifg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bEFZEpITZmoQcRQ+L+p4QRbhUCnVVwyAWX7YisQ11DupW9xuqpaejWZ+fO+WVkIbjd9lm7P+Zf6b77FSxoBD5XyIZ6NVRivR3T67tUXxkoNKjiXJtgToWb7ObUI9QSvcHm5SfkRhjvrQgPcBEs0zIIa/QxwPQS2c6VxUYdhtENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=C7DQVASJ; arc=none smtp.client-ip=220.197.32.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="C7DQVASJ"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3b19f2c60;
	Fri, 17 Apr 2026 14:32:16 +0800 (GMT+08:00)
Message-ID: <9cafe1d5-1105-cfbe-2ef4-3f018ef7025d@rock-chips.com>
Date: Fri, 17 Apr 2026 14:32:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>, Philipp Stanner <phasta@kernel.org>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI/MSI: Add Devres managed IRQ vectors allocation
To: Frank Li <Frank.li@nxp.com>
References: <1776392767-83668-1-git-send-email-shawn.lin@rock-chips.com>
 <1776392767-83668-2-git-send-email-shawn.lin@rock-chips.com>
 <aeHOyYJR2GRRP4fY@lizhi-Precision-Tower-5810>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aeHOyYJR2GRRP4fY@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d9a23e25809cckunmb867f1f8346007
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxoaH1YeSENJGEhDGU4aGk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=C7DQVASJ/YUwbZBhp4b02j3GnpstuVTrofhcWEgDz7sR8qvSM+7Nlu0pE1hc+UphNWEVa0Lb2XPuHpWFLLY9ntZnOX3gW9nJUXVNtNvL6N1zY/uLyN8ChruFXN+q6xepI5PoFv9Yns1c4PLYRMFnUQstfjZ/upQkn1uCYBNpYMo=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=KoYhaGYwqJWwSEpHtu2ExjmIs9RJzVAemt5tG5n9Xuw=;
	h=date:mime-version:subject:message-id:from;

Hi Frank

在 2026/04/17 星期五 14:10, Frank Li 写道:
> On Fri, Apr 17, 2026 at 10:26:05AM +0800, Shawn Lin wrote:
>> pcim_alloc_irq_vectors() and pcim_alloc_irq_vectors_affinity() are created for
>> pci device drivers which rely on the devres machinery to help cleanup the IRQ
>> vectors.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v2: None
>>
>>   drivers/pci/msi/api.c | 26 ++++++++++++++++++++++++++
>>   include/linux/pci.h   | 22 ++++++++++++++++++++++
>>   2 files changed, 48 insertions(+)
>>
> ...
>> +/**
>> + * pcim_alloc_irq_vectors_affinity() - devres managed pci_alloc_irq_vectors_affinity()
>> + * Interrupt vectors are automatically freed by the devres machinery
>> + */
>> +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>> +				   unsigned int max_vecs, unsigned int flags,
>> +				   struct irq_affinity *affd)
>> +{
>> +	dev->is_msi_managed = true;
>> +	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
>> +					      flags, affd);
> 
> any side effect if pci_alloc_irq_vectors_affinity() return fail and
> is_msi_managed keep true.

Thanks for the review! This is a good point.

You're absolutely right that in the current implementation, if
pci_alloc_irq_vectors_affinity() fails, is_msi_managed remains true
while no vectors are actually allocated.

This replicates the behavior of pcim_enable_device() +
pci_alloc_irq_vectors_affinity() , which also sets
is_msi_managed unconditionally, but that doesn't make it ideal.

I think we should fix this for better self-contained behavior. The
pcim_* APIs should be robust on their own.

I'll move the is_msi_managed assignment to after successful allocation
in v3, if the general apporach looks feasible.


> 
> Frank
>>
> 
> 
