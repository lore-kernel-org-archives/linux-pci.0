Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678C62FDC20
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530693; cv=none; b=HKqqwNtb6vor61sAXbPAAzNn10jp2DLFceHfU+mLGg7OdioAxU6wY+5wLbQFtd28ywElAvRAFP0keWLqCVn18k9kvmfx6yjzJMGpsEaiZLFwk/Kssn1aBAv/HvpbQnQdGSjZy6dPUMiuDYAyBlgiW8D7IJeWX8FOjfviKM5htnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530693; c=relaxed/simple;
	bh=N0Tq3wBr4CAjFB00AM90m7/84+fWcmZngE4AWv68E3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A91G5JybVfLJpuANUEuPBgrh4iwWjKK2LqIpIE3tAQoGk5QiM/D2IAc++KPaAaCN0dA2CQt6nPotsgCIQ+Krz7iJ/XWn27War2RnaF5g8tIQ04OzKEyehW2quRGHXRB+5pp+Co5ZNFI9hjCYTUzn1aTP4SqCC6aHXv6X6nLZunw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=h8L1bjZD; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="h8L1bjZD"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c663437fe5so496194e0c.3
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788530690; x=1789135490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RgvnR/pqmrGBFs87lYL82eHWSI/zVKIkSdkMcH+Sw9w=;
        b=h8L1bjZD6M+eUf0D30HA40mFCEXvDQpxzS8zDJaY5iLOpy6Tch4LmHwY9/cjpomkbu
         1fFpaMtV7HkPeDKn2cacL2ZU6PNxbMd5S/vaGwDLLXlkMMPi8mViGwmagZS/GOi8jsUf
         kvqQrXd+Dv0IFqHz/0lbjlQGJLlwyUVy69JSt7VA9uCa93qH695zRZDoNCoZcr8TVqX9
         wz6GJvaawGrmIR3HSuweISlBb/IvwiHL0FzvqHN2+dLvB/3FiEoMWteoDIhecYAI+qpx
         bBfKv8BOE4L2ZlF8ymk767UyNPgL1EFkn1PegMdnwkoZJVZNWC6cb2anz7lT5e8Mg2Bc
         pO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788530690; x=1789135490;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RgvnR/pqmrGBFs87lYL82eHWSI/zVKIkSdkMcH+Sw9w=;
        b=ndonM/nmZAtSPBrssx7HdcKSijqr/tzPxXXjC/RGSRuKP/60u5XgF/lttMHbsDjppl
         akBCpS6fCoMjJoc6czv3WZulPv8cEb1c9CFwMPEU7Z3IHm4NvgMOH5FNTCzZZwzSYxWD
         ZSXcemuu6VEYMjPlrOXr/R6a5fwvi5sPPxT7KtaI6UKsHWiIeOkCzRiB/xvLjg6pTIwx
         a+Ln8ZbqCzLRFNSOxb+s1yO2KNRcs6ELOFGuz7AU0U4WdlElwgV/5rSZkjrQkjTKK0/l
         Rd2MimiD9CIGTR9iuPDuKlSH0BHYqCJCu7f4N/k771CXF6Tsx/i27ecfn4tqrGBByhQu
         6VkQ==
X-Gm-Message-State: AFuF++k/Q5z0AER7Rllcz5tUeuiIEmRclsFioh3yQn08wxVt90sWMIpk
	4Pv9JLPirlF9jpJQ7lmbWozwZTqmCtu0tRG9ZIo8bQRkOMbu9C+qF51CXnlpGzmMEsg=
X-Gm-Gg: AYBFou2XboNl+Dcm5gkqIqXaPMG0EcmqHmYqtAe1wWr3ijb7Bnnl66lQ9Dwfui7LQaS
	cEvBnQFVdlcQad+9Gid3acpC23ommDPXFMOShDrZZPbwjEByYTlpcCLb4TFY079JrKsaF26jsKM
	4rBwhXadwLLIgyZ5xHxVVCDRQKOTy9pjgUByNpXK1U33EFolNLY1Sk2o8Fmsb0wXkuXLOYe7nOU
	HAuJQNdRovSFEEl410wg58/d0y5FpiJsI9/668Mn4jUgHsYo4NC1KoprjLZDrYvOPVzlyV0E7GC
	ZwGecW4Z3+AZL6b9BiLrAfrodqCZWVQt6aw/dELl3IB6g1Tt+Cd2uTVpl9i7bcHx8/4BeVmKK9q
	xUyYGnmG2L2LfmvAcGIRSU586vG+9ubT9TZbld4WdV2I68V7LXNSHyEtr1VcEmtrnTGQL8NbKBG
	GO5Rp9Qi4iMxWujsn+V6DfCtZQeFCEdlQHvuB434gnR/L/NANvADbZGuxZxfjM
X-Received: by 2002:a05:6122:f18:b0:5bd:cb34:1b70 with SMTP id 71dfb90a1353d-5c7ed29d58bmr2786695e0c.1.1788530689514;
        Fri, 04 Sep 2026 07:04:49 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb62710sm221647985a.28.2026.09.04.07.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 07:04:48 -0700 (PDT)
Message-ID: <0e0b02be-a438-416e-bb0f-515b7ba80052@riscstar.com>
Date: Fri, 4 Sep 2026 09:04:47 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] PCI: of: avoid allocations in
 of_pci_prop_compatible()
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org
References: <20260904134607.1856121-1-elder@riscstar.com>
 <20260904134607.1856121-2-elder@riscstar.com>
 <20260904135954.696FA1F00A3D@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260904135954.696FA1F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/26 8:59 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The local variable `bufp` is incorrectly declared as `char` instead of `char *`. This truncates the stack array pointer `buf` to an 8-bit integer, leading to severe memory corruption and an immediate kernel panic during runtime.
> - [Low] The local variable `i` is declared but never used after the patch.

I'm very sorry about this; I'm not sure how it even happened.
I must have included the wrong patch when I prepared the series
(but I normally check builds as part of that process).  This
should not have even compiled...

I will fix this and will send out a new version tonight or
tomorrow.

					-Alex

> --
> 
> commit 0153310b625600febac7ea5aec9fbd9871d0af03
> Author: Alex Elder <elder@riscstar.com>
> 
> PCI: of: avoid allocations in of_pci_prop_compatible()
> 
> This patch replaces dynamic allocations for three compatible strings with a
> single stack-allocated buffer. This avoids subsequent kernel crashes where
> allocation failures would unconditionally trigger strlen() during device tree
> properties initialization.
> 
> Link: https://lore.kernel.org/sashiko-reviews/a647bd56-7dc8-4fec-9d96-834622054cdf@riscstar.com
> 
>> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
>> --- a/drivers/pci/of_property.c
>> +++ b/drivers/pci/of_property.c
> [ ... ]
>>   static int of_pci_prop_compatible(struct pci_dev *pdev,
>>   				  struct of_changeset *ocs,
>>   				  struct device_node *np)
>>   {
>>   	const char *compat_strs[PROP_COMPAT_NUM] = { 0 };
>> +	char buf[PROP_COMPAT_NUM * PROP_SIZE] = { };
>> +	char bufp = buf;
> 
> [Severity: High]
> Does this incorrectly declare bufp as a single char instead of a pointer?

Yes this will be:

	char *bufp = buf;

> Assigning the array address buf to an 8-bit char truncates the memory address.
> 
>>   	int i, ret;

This will be:

	int ret;

> [Severity: Low]
> Is the variable i still needed here? The loop that used it to free the
> allocated strings was removed by this patch, which will leave this as an
> unused variable and cause a compiler warning.
> 
>> -	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =
>> -		kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);
>> -	compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] =
>> -		kasprintf(GFP_KERNEL, "pciclass,%06x", pdev->class);
>> -	compat_strs[PROP_COMPAT_PCICLASS_CCSS] =
>> -		kasprintf(GFP_KERNEL, "pciclass,%04x", pdev->class >> 8);
>> +	ret = snprintf(bufp, PROP_SIZE, "pci%x,%x", pdev->vendor, pdev->device);
> 
> [Severity: High]
> Will this snprintf call trigger a kernel panic upon dereference? Because bufp
> is truncated to an 8-bit integer, passing it as the output buffer pointer to
> snprintf() will result in an out-of-bounds memory access (unmapped low-memory
> dereference) when evaluated during system boot or PCI device enumeration.

This will be fixed by using a proper type for bufp.

> 
> [ ... ]
> 

