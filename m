Received: from mail-qv2-f25.google.com (mail-qv2-f25.google.com [74.125.230.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD549F122
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262712; cv=none; b=Xi4tgdWNYoEjETsrIQPLDacihmFiYJPeauJTKqX9ugJU9D/JXXBLiKdGByQ47f3WUJZg+McmhvkTKRnXQ0i2z0wyi10rjpZ3k7fvJO5mIxlFNgj5FUuzAmzUY4x3ZJ13arDW+uDziiGgtcYZpCFqcBzBGDS5k268LGLRc7iH5kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262712; c=relaxed/simple;
	bh=rLyOMd/NUGEseSBxyocA0bYOEejNiG1JtJseUmRTyhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjU1D/ht21tU8u539b55GuPwts1XIzYxG4FW7yObG2XpYQQrIcOP2VmNA/Bs5HCZTKDhrZzCVnYX92sYExsTA3TMKRT6Ns0+LKj1OT1QDH5jCNfeHGZZNGEPthSuv/+TWiBmogeh3PE2Gck6qMaaKeRCWCsvQxj8Wr4Phghr7/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=RGYpLLMq; arc=none smtp.client-ip=74.125.230.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="RGYpLLMq"
Received: by mail-qv2-f25.google.com with SMTP id 6a1803df08f44-90cdfcb5cb3so18806406d6.3
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790262709; x=1790867509; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=coMqpZSLbYua79ODlaLf8ibI9ASN8s+y7pCadqkcxT0=;
        b=RGYpLLMq9WViukKYYcrS7yWs3gLGpBOBNXu9ZiQ9G9b/p9uvy/3DdHdWcgmKRRKNIh
         pOVoSEOQ37Gp60VV/V7k7qSX6LoHzotEnxK9fHmZGQj3KlF+R/+Gz9QWy7JHdph3W4Kd
         43W3kt8aMOlbivlNr/5ghF83Q0zhDXIcDhFk7c6fC1r1rzCgGdjnVgoY0UWzWt6K2P2E
         6/GqfIdG3bEhdrSHWCKCFZbJXXZ8moGMjHOAJTbJzzyUGLw5l1zoyFCdjsEB2lpE59Ba
         U7iVLgB9JR47ntSvwcjE3GtqkxX9bq59XkVMiC4Tm/IMMOD6LD/XpsLymqpel0qsw4k0
         A6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262709; x=1790867509;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=coMqpZSLbYua79ODlaLf8ibI9ASN8s+y7pCadqkcxT0=;
        b=L9hanm/7zggyVf/c8FMIE8Pa6/HOd6N3H7XjRpv+l2b22wOcMzVEj2YVICcRYyodQe
         US3ELUV2itHUB2Rg3ziXGbJXlmo+buQAT2nnhUWQDgDDdYFTv5c+75dPsaGZftlXpW3f
         WCi3c6sqMkzVG3zB5+FThXCvkyCy0bAIvNRSNrai/fjTdDX77pOdTn4mbXDbdPQ9Mqcr
         3A1YtsNqdoN5sOz6XD1a7uaecpwZwm121vjtmm+rwJmzNMZp+vapQZoHhGPVXDuUxS5O
         +EqwOLvl5TfxNJMBloi3FcmluZ3XL6h/GZWq8SA5RuqYH3JzXjTVytGRM/Bglh5QnJ54
         nzkg==
X-Forwarded-Encrypted: i=1; AKwUvBw+S/FTbjoCFSe42RGTKzqLQVmWSlF6mR8lkK7fk/3UhKEKcluvwgmUQEpt1SsBijVpSf6orZp8Zio=@vger.kernel.org
X-Gm-Message-State: AFuF++m++1dyVXhjdko5KTUlv5BphBRFH4yrGHQ9Myz1ekYgump6wayb
	tg/BfIZ6uTpWJ8zhO+bA/oz7Heww3LMecpi44L3yoipqqp0TNKIhW1rN7Tsc9UCCWjpFleKrYzd
	jQXBUnOo=
X-Gm-Gg: AYBFou36wV5kOlRVGtvLcppHZGdVat/LHihyJuP9lsLo3foAVUXD8EGwxcITvwGLFHG
	0beyAJBJGXMGFUMLB7mErmjvlY6YLPGGb/0E3bpdBxRv9Qfa43RJ7JpTwfn6mrx7euAyjtLhDK4
	V4v9M9EIsvBh4cg+NAkyHD2l2YRpH4pR4EevqwB9zlXGWm4CTVcQpC2cPGDEBQBmv03rcqRzdgl
	imc5JB10Yz2v/MVUkIX0CU0upOMaIBydcY4uoSW6Cd+UuCoWQRGFoXlK7U1zWffo7XY4FC3Z7Y/
	y4952uhmhHCtzfeUEmKD3WQyOtGNFO0Ap78mtqrCcYGWyB1y4xo415KPGJ6OoJiSMjvLQNK7gyQ
	IdtdSbYuaiRC02dYydi/3Tw/956jqUi3eK2dyRXRJKd1jQKyKHprhkLQhqId0hLnj+iyLenMeR0
	P3oXnKcPLkUO1opzLH8+2Kp9hKD33il/dJd3PzNIJOKg3aUJmTZTAMUwCklkJCcnVPNUmpjGNzJ
	JGNE+xinA==
X-Received: by 2002:a05:6214:3d01:b0:912:599c:a278 with SMTP id 6a1803df08f44-91421ef6d3amr30758496d6.37.1790262708730;
        Thu, 24 Sep 2026 08:11:48 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e27b698sm18523826d6.31.2026.09.24.08.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 08:11:48 -0700 (PDT)
Message-ID: <5a150b72-e2f9-462c-aabd-103659e3bf62@riscstar.com>
Date: Thu, 24 Sep 2026 10:11:47 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] PCI: of: introduce of_pci_verify_node()
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org
References: <20260924150222.1179235-1-elder@riscstar.com>
 <20260924150222.1179235-5-elder@riscstar.com>
 <20260924150934.B4CE31F000FF@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260924150934.B4CE31F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 10:09 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] pci: of: unintended error-level logging in of_pci_verify_node()
> --
> 
> commit 0e8b20efbbe63f895449027a5712b691b9eeaa56
> Author: Alex Elder <elder@riscstar.com>
> 
> PCI: of: introduce of_pci_verify_node()
> 
> This commit introduces of_pci_verify_node() to verify the device_type property
> for PCI devices. It adds a runtime check during device enumeration to warn if a
> bridge lacks a "pci" or "pciex" device type or if an endpoint improperly
> includes one.
> 
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index a51dff91b196d..5a040ed836744 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
> 
> [ ... ]
> 
>> +void of_pci_verify_node(struct pci_dev *pdev)
>> +{
>> +	struct device_node *np = pci_device_to_OF_node(pdev);
>> +	bool device_is_bridge;
>> +	bool device_type_pci;
>> +
>> +	/* Nothing to check if there's no pre-existing devicetree node */
>> +	if (!np)
>> +		return;
>> +
>> +	device_is_bridge = pci_is_bridge(pdev);
>> +	device_type_pci = of_node_is_type(np, "pci") ||
>> +			  of_node_is_type(np, "pciex");
>> +
>> +	/* Bridges should have device type "pci"; endpoints should not */
>> +	if (device_is_bridge == device_type_pci)
>> +		return;
>> +
>> +	dev_err(&pdev->dev, "PCI %s have \"pci\" device_type property\n",
>> +		device_is_bridge ? "bridge should" : "endpoint should not");
> 
> [Severity: Medium]
> The commit message states that these warnings are "meant to help developers;
> users should never see them."

I suppose I should have said "error messages" rather than "warnings"
here.  I think dev_err() is appropriate, and unless a human objects
to this, I do not plan to update the series to address this.

					-Alex


> However, dev_err() logs unconditionally at the error level in
> of_pci_verify_node(), making it prominently visible to end users and
> potentially failing automated test suites on boards with legacy devicetree
> nodes.
> 
> Should dev_dbg() or dev_info() be used here instead to match the stated
> developer-only intent?
> 
>> +}
> 

