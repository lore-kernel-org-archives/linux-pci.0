Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70094311954;
	Wed,  8 Jul 2026 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505396; cv=none; b=hteZyjhK9Lqkiyl0456sm+Axc+JFJwbEefyfo631+plNvrdF93xBvTINCYxlGyg1WUA02fCRIwoYZw92qfMx7+ECLKTymXnWlUojtRNikVf+xOGOwRZf1Jv5VBbyFd4uuHJ/J3OLnQ2hMa+dGqVVxpGsDwG34BZW9BRlhzj2Y/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505396; c=relaxed/simple;
	bh=VCqMrWVpzLN4ULobgBXDmz9gzPZylXlc6bKaX0qbsB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcyzvycbgZcc2MIwlcIn8jv/FvTbyLMZJFYxV8tJOhRtIxUcLFUs/KAuyVevztb6KvILxPfU2YVhzI8xCZaWFMJT0wrW2EVnYKNpuo/rpEqmImk4Wwl6sCZ1jfpq+Zr79AQS6YOpd52yDvm9UaQ676Q79wwbrrSmtb3G0QOZD18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLWCjEWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLWCjEWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905831F000E9;
	Wed,  8 Jul 2026 10:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783505395;
	bh=FrBA4BqnhQIcvIXhknUCkrcHupCw+C7sk4gSFCE1r2A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FLWCjEWGURFhZPd7vfPb/33+F8wtxlPZJl2tqPCjYXb9dM1KJUafwJKEvGTDuRYTA
	 to4U96JyzrGkkBO9j8fYBx8c7wMkF/7txzg27kCwcGP4FHG1sP301WbpVBvojzHNLh
	 f9u+yIwCirr9vBGC6ax0qpy8Qjs0MSTYNGT892PtMql3+0fhSdIXFAKFOQM2rUtVp8
	 BZNvErUD5Rq5Tarn7lNu/N504TmyjQ9VDLL60pxDR6bhCqx+AgYrWGOZtV4x42CnUk
	 Fdpe5WUEDLPOm5JhxkjgQ3M/tNV/uQZXvVgu/hA7cuIzxNrv+e8JguXzM8NE2Z3yPW
	 WGcAeJy1u4wZA==
Message-ID: <bf103637-67ee-4821-ac77-60d8cb997027@kernel.org>
Date: Wed, 8 Jul 2026 12:09:52 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: aspeed: Switch to irq_domain_create_linear()
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260708095814.385480-1-jirislaby@kernel.org>
 <20260708100454.00A621F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260708100454.00A621F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08. 07. 26, 12:04, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The commit message claims to use `of_fwnode_handle()`, but the code actually uses `dev_fwnode()`.
> --
> 
> --- Patch [1]: [PATCH] PCI: aspeed: Switch to irq_domain_create_linear() ---
> commit aee46b37ad2da511a238368770cbd10115b36171
> Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> 
> PCI: aspeed: Switch to irq_domain_create_linear()
> 
> This commit updates the driver to use the modern irq_domain_create_linear()
> function instead of the obsolete irq_domain_add_linear(). It adjusts the
> first parameter to pass a fwnode_handle rather than a device_node.
> 
>> irq_domain_add_linear() is going away as being obsolete now. Switch to
>> the preferred irq_domain_create_linear(). That differs in the first
>> parameter: It takes more generic struct fwnode_handle instead of struct
>> device_node. Therefore, of_fwnode_handle() is added around the
>> parameter.
>>
>> Note some of the users can likely use dev->fwnode directly instead of
>> indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
>> guaranteed to be set for all, so this has to be investigated on case to
>> case basis (by people who can actually test with the HW).
> 
>> diff --git a/drivers/pci/controller/pcie-aspeed.c b/drivers/pci/controller/pcie-aspeed.c
>> index 9aa9e14c61484..74b03a55643fa 100644
>> --- a/drivers/pci/controller/pcie-aspeed.c
>> +++ b/drivers/pci/controller/pcie-aspeed.c
>> @@ -725,10 +725,10 @@ static int aspeed_pcie_init_irq_domain(struct aspeed_pcie *pcie)
>>   {
>>   	int ret;
>>   
>> -	pcie->intx_domain = irq_domain_add_linear(pcie->dev->of_node,
>> -						  PCI_NUM_INTX,
>> -						  &aspeed_intx_domain_ops,
>> -						  pcie);
>> +	pcie->intx_domain = irq_domain_create_linear(dev_fwnode(pcie->dev),
>> +						     PCI_NUM_INTX,
>> +						     &aspeed_intx_domain_ops,
>> +						     pcie);
> 
> [Severity: Medium]
> Does this code change contradict the commit message?
> 
> The commit message explicitly mentions adding of_fwnode_handle() around the
> parameter and warns against using dev->fwnode directly since it is not
> guaranteed to be set.

Sashiko is right, I used a template for more patches...

> The patch uses dev_fwnode(pcie->dev) here, which fetches dev->fwnode, rather
> than using of_fwnode_handle(pcie->dev->of_node) as described. Should the
> implementation be updated to use of_fwnode_handle(), or does the commit
> message need to be revised to match this dev_fwnode() approach?

In this very case, dev_fwnode(pcie->dev) is used in 
aspeed_pcie_msi_init(), called few lines below, so this is all right. 
The commit log is obsolete in this case though. Do you want me to resubmit?

thanks,
-- 
js
suse labs
