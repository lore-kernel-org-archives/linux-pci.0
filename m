Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374CD30F540;
	Wed, 25 Mar 2026 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774428569; cv=none; b=jy9xJ5LdPAVM0A8Kfa7aDfa6naaK59Mjbt5g1uBNduSM9qhKe++b3a5VvTtdgF8SAd62IAVpp0fBJidQCiBSdawHt7WNCHgJFzF+NVmHbUuScquEfpanowot7Fr4dO7fxMku/mjxYKMhxprxSZcNDtSwGrVwjiK8K024rGh8/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774428569; c=relaxed/simple;
	bh=vbsDOnuRRH+yz6iNyr6GiInQ5JzUZ7epCZjm+wQHdIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFZb3UYo1Reqe9QLVpUEiu5RVHnL4mDkBPRjpJRnXLu+oGecTPIW4n7wnCeCcybUwNweKt/wAoj55XPdn8ARiJWuQEFTFW7FpjkFTrT488lIFugxtj7IQOPaNR0tj1uGOj4VK4SAqUOdG5Ipm63AOSSkj5RjmQgHXFCXPffG+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rprY/Edk; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rprY/Edk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774428563; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=L7FxpCSEgItetYVbIylj2g057qmecEqP72q04ygIl7s=;
	b=rprY/EdkQ5VQMxwNY6JVj0Oxdi8ewEE4r4XjnhwYxQYI44J1bm1DAsM/V7NxLR6hqS5SCkKGUEi01z1TGecNegi5zwULiXySqb5eRt9c2hsmppK6ezZMBeAlm0LrPkHcoVCV9naLQTNVxn4RdgS9uGy0v8YIR9hv5GIHiLmkXE8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.h2CV5_1774428561;
Received: from 30.178.66.196(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X.h2CV5_1774428561 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Mar 2026 16:49:22 +0800
Message-ID: <fe2fbe7e-b606-4ceb-a631-95e9424e5624@linux.alibaba.com>
Date: Wed, 25 Mar 2026 16:49:21 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] genirq/msi: Introduce update hwsize helper
To: Thomas Gleixner <tglx@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Inochi Amaoto <inochiama@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: Xunlei Pang <xlpang@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260324014754.4973-1-kanie@linux.alibaba.com>
 <20260324014754.4973-2-kanie@linux.alibaba.com> <87jyv0fhox.ffs@tglx>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <87jyv0fhox.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/3/25 16:15, Thomas Gleixner 写道:
> On Tue, Mar 24 2026 at 09:47, Guixin Liu wrote:
>> +int msi_domain_update_hwsize(struct device *dev, unsigned int domid,
>> +			     unsigned int hwsize_new)
>> +{
>> +	struct msi_domain_info *info;
>> +	struct irq_domain *domain;
>> +
>> +	if (hwsize_new > MSI_XA_DOMAIN_SIZE)
>> +		return -EINVAL;
>> +	if (!hwsize_new)
>> +		hwsize_new = MSI_XA_DOMAIN_SIZE;
>> +
>> +	domain = msi_get_device_domain(dev, domid);
>> +	if (!domain)
>> +		return -ENODEV;
>> +
>> +	info = domain->host_data;
>> +	if (hwsize_new != info->hwsize)
>> +		info->hwsize = hwsize_new;
> This is incorrect because the underlying irqdomain has been created with
> the original hardware size. So just fiddling with info->hwsize results
> in inconsistent state.
I found that hwsize only affects the range checking when allocating and
releasing intterrupts after the irq_domain is established,
and the kernel does not allocate related resources based on it.
Cloud you plz tell me specifically where the inconsistency is? thanks.

Best Regards,
Guixin Liu

