Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799B435514
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 02:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788230583; cv=none; b=ZCgcWp9Bq17DrScAH4gI3p6eHLRZCnL/Sxcu3RHqOpyUlDGT5+eE5/lvlzDUO6EW3OfHan5/wTJ94a4LN+U0qIitbg3L35wyyhfBolUxXBqp/3ueo4flL3BjTn4FhRYOFgVIf6YVQuoieVyiAHIpoI53nzmKd/KyHJfj4DdDMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788230583; c=relaxed/simple;
	bh=cavPLdZ3EM365UmMDeiKEQPWG/ZtK6GBzxNXSfWmPAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHvqf7uIzjA0OB6i7ELdXNOTliiTMD1KqaXFSMEA/l9VXGTTwR826EwsRRDBXbjgxVQSW1sF7SsUXEc0gnXRtfMMLniomxvRvcowLYP4bbdzd/XRQlKDm9zezsX3YIioe1BPVh3ErnMIwMAuW2lchF1Wb1uG6jPtKGWN+ya7wPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=AjnFI1dR; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="AjnFI1dR"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e85499ffbso40804385a.0
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 19:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788230571; x=1788835371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CPbdamFgACK5fDGcrO4A3g8qwBFcMj5srbjsH4obLc4=;
        b=AjnFI1dRZTU6NfhEL6iIRCQkgMOhdJZU9gXIHtJ8ZPK/4IvP4wXRmGq9Ktr+X9CeiL
         +dLZgmq52u8NziYnAFozt8Nrzj32+KXEtncXr0uMzhEBwUR53aN7qWCMDCpc0/47WEPb
         iKoeqYi8twNIuYYNgYAP6Ub05XzXqWCpDj0g18Hb7VZsche5WTD38yVCQUR//c8EjV3o
         k6AJd7yVygfZ99Fny5SslOcpWADuQPUxopD5OExJri1D+23sT10mt2453LxrkiiXkI0x
         zWiweRIsr3hG4aepMBIm1eI3DidWPP3Fd+GFM9ASxwwmyoSVgkaj1iDAlQAyD8vmL8el
         naRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788230571; x=1788835371;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CPbdamFgACK5fDGcrO4A3g8qwBFcMj5srbjsH4obLc4=;
        b=s/T2kas3W0uwDwjEmR6FJSh8oe1Isld4N2QcgY14mi8UYHsV/QEC+qFcsivPjmCKA0
         e/74CP90T17gMb2bbDQuB1mdicZqCcot9cAWWZRdR1D7eeo06273E1zb2rlyQhwtE+0V
         RCvpxywZ3pf8hEohdAQvtLro/SmPA4vvxCqJWmoxV0P8kwAG/kqN2oW+UIlhXtD2RucE
         OuyHiBR12ucdPWuhtDqLSciiy2LLtqfo4lG8nTykWQb7Pe9A9teRchBxGmyZq5G8noa/
         sj1JM2wA9XCQBcWoFQ7nQRrcD13oOJQ123ZGGIS3le2Elyjacpo590ErjBd0HTzPqojY
         WvOw==
X-Gm-Message-State: AFuF++mo/0MtSOHq41r3NeLsZ55SltQe04mdZJN6mbpI+EWixZlehSyh
	BDv9jk6LnfeQfha26ZcRBDxkY2vMkqAOqzJPKr1hYL2ysfT6V6ntDv7O3uAxQjSo2Ug=
X-Gm-Gg: AR+sD11s9mjyGizkKZzuA0OGI32gG+A12uT1Ob4gCRTwnJSV2+qKvCAdV9WXazbcC+E
	TvXVMvKOjeG0eulyoxiP+ec7Bepd8tHvZUqU8diLveA8hsg7VxomyiXDgEy4eq/ixVFHKDCtoxi
	Vqq1yf3Ivj5uYzpWmebVlGePfoPr12jZChOBe4GHeWmIGL+ha8HR32W6z6n5b11KLLzjlLDMvoX
	VHm+fjOLOj3Uo2UpxlryjMn2ZEmVk1UkNvIJlAt+WhEJurxhffPBTIZYv9WbAmDqquay8eh2uZZ
	XfRuxPIkttbwT05zAMNGJa7MKcml/mwUzXK6Ub2Yp2142Y6hBH6x892aV3Z3k7zXvVoRF0SBOtE
	sRLivthOKRtD1M2TqnHflJSwkxLtQxS+XN0vKAHSFU1Pf09chNx7avfLJADsjySpHuq2Qljf/oM
	ShDJ7mgukmTQ7ojkr8gi04GE33I/rDJp4qhuIrqslOoej8bgb9pIx+3AHAAJVX
X-Received: by 2002:a05:620a:a0cc:10b0:930:a26a:fb2a with SMTP id af79cd13be357-939137af782mr2704459585a.2.1788230571171;
        Mon, 31 Aug 2026 19:42:51 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917016ed4sm929269085a.9.2026.08.31.19.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 19:42:50 -0700 (PDT)
Message-ID: <d95aebf1-8319-4307-9d62-f1f3dc7ace61@riscstar.com>
Date: Mon, 31 Aug 2026 21:42:48 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] PCI: of: don't zero flags in
 of_pci_get_addr_flags()
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org
References: <20260901011338.1323243-1-elder@riscstar.com>
 <20260901011338.1323243-3-elder@riscstar.com>
 <20260901012046.1BF371F000E9@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260901012046.1BF371F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 8:20 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Potential NULL pointer dereference in of_pci_prop_compatible if kasprintf fails.

This issue was reported before, and I responded that I would fix it.
I *do* have a fix, but I have not yet posted it for review (waiting
for the end of the merge window).  I will post it soon.

					-Alex

> --
> 
> commit 036872e87dc6e9201c6f86349afb91815a638d1e
> Author: Alex Elder <elder@riscstar.com>
> 
> PCI: of: don't zero flags in of_pci_get_addr_flags()
> 
> The flags variable whose address is passed to of_pci_get_addr_flags()
> is zeroed before assigning a value to it.  Skip the zeroing and just
> assign it instead.
> 
>> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
>> index 505226b876c56..22fea1905a080 100644
>> --- a/drivers/pci/of_property.c
>> +++ b/drivers/pci/of_property.c
>> @@ -82,12 +82,10 @@ static int of_pci_get_addr_flags(const struct resource *res, u32 *flags)
>>   	else
>>   		return -EINVAL;
>>   
>> -	*flags = 0;
>> +	*flags = FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
>>   	if (res->flags & IORESOURCE_PREFETCH)
>>   		*flags |= OF_PCI_ADDR_FIELD_PREFETCH;
>>   
>> -	*flags |= FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
>> -
>>   	return 0;
>>   }
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential null pointer
> dereference in this file under low memory conditions.
> 
> Looking at of_pci_prop_compatible(), kasprintf() can fail and return a null
> pointer:
> 
> drivers/pci/of_property.c:of_pci_prop_compatible() {
> 	...
> 	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =
> 		kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);
> 	...
> 	ret = of_changeset_add_prop_string_array(ocs, np, "compatible",
> 						 compat_strs, PROP_COMPAT_NUM);
> 	...
> }
> 
> If kasprintf() fails, the compat_strs array will contain a null pointer.
> When this array is passed to of_changeset_add_prop_string_array(), it
> unconditionally dereferences the strings to calculate their lengths:
> 
> drivers/of/dynamic.c:of_changeset_add_prop_string_array() {
> 	...
> 	prop.length = 0;
> 	for (i = 0; i < sz; i++)
> 		prop.length += strlen(str_array[i]) + 1;
> 	...
> }
> 
> Would it be better to add a check for allocation failures in
> of_pci_prop_compatible() before passing the array to
> of_changeset_add_prop_string_array() to prevent this?
> 

