Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50EE3CB8FC
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476570; cv=none; b=UHP8KKHdd1DeyxoWqLSA1OZHju205gei4SL7Hwvd+TfN1qMpz9jbzd+C/ZvkroUIMXGUr766Gi1PqtMnu0/CnxN3/BHFfc7Kdn6A7NfCL1hbPTQY8doj/yMfL/cvXz0inaN0qMBlYM3+FRE+tPYSJ1SsyGr+3YxhjlcimFht6rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476570; c=relaxed/simple;
	bh=oP8ZBzl+K7e7S5kXo+GJljW1HAPBrtpilh/wSXvwTUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRH7zbwtP5xXWkiqNWIaEXLynlTOGOajXUnvtlaxN49k3WPOuKW2M0N0WZuISmffoE8oA6e82AbdZNEi0qwOKhc1t/ZMm5jnfQ6Y+Pq+hX6bb5bQ300hON2YRB7klMklwyOG9EHU92fS6enATFvvMy4nvv+CokhZ9M6cNWFLMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=vIbuqQRq; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="vIbuqQRq"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109fafd7so311672485a.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 05:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789476567; x=1790081367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/MVO12tLI/QkQzG/oUBp0JuONjh3E/nA2a8Kxx1dMI=;
        b=vIbuqQRqpczXd6NhVuGycMPthtPcbvsNNtZO4uQ6kmfDxSxiBtE85DQvhsM1jkNhyj
         hZqBTAmn5frkW+KCbKHPEz5j1L34RHguU0+v1pERN5apapGWUUh79HFVsKbX+zdTKZ0O
         /kGgEaqsYDQNs3zU6Gir+NOVX4fRCwfothrfui+ugAMzSZFKxuENL+rmgNVW0vY7yjYu
         9fYT+iujkEfUbJtmVXs0KGQrcgyU9TBacZb0dcighZ36rv61GU7sp6CzQnkGZ61RTivA
         4MHdKMZcGnwDsTjl92bt393t0vvjoy7JSmIXzJj15iomJ3Ts5yr5CVmmB4EfJCeWDFnI
         5a0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476567; x=1790081367;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J/MVO12tLI/QkQzG/oUBp0JuONjh3E/nA2a8Kxx1dMI=;
        b=zBgPtp9j/HfYI6uJxkttZn5IaeKM6twCxCNh4B7/M1Z2FqS70Qph+VhI76PZH5haeD
         6S4yxsqgzaJCVNU1//udYRcYdfZ3pOfdjNZvKv/goqf9DuFS9V+M3LGohCcoL9ivZ2kl
         My9B4hf3qorOWaLlu5ta55/dmO9P2ScS01iN5FJIU4pKmme1CLNUld1zfXpalNrReYJ3
         QMtR2N+T24OqH21XzovJu7palIgC9IcHGy5TAtpwHAYM3koXbPwG05W5N6ZDWJCaimXg
         0lwQPzmA26KeBTd6DPly12Jxf/hpAAZiTYNZ+jkPTdANDT7JRMx6S4yiQhUPn8gzYUT7
         7i/A==
X-Forwarded-Encrypted: i=1; AKwUvBwReMEGjEy6Elyk8yUAzfOrTENwG3WmweJCPOKaubqbz4Cg0Bsceo/U1OjDv4SY3Wo9XVgCTmEzZ8o=@vger.kernel.org
X-Gm-Message-State: AFuF++nWoaAs4zD82Q6hjexK7bbTFkPh0CTy2hrPf9rtJIEh/HhOyQkU
	3iJrXuh1seWWtj80nwny9w+pPwj6H33umS74mJdKidD4x7NuTSC51yufQgM9QbFkCA4=
X-Gm-Gg: AYBFou2R1U/WoxrNst9cOLuXvyZy3tNJCRwfn32pSZgx21UAZfUzeeRh1qECZUgQTn3
	Wj1ag4mN9yZMlpjBWZfeap68VYdtRZWm3DSIyiyFXWXxs4fz8DnjHiNeLDFDR8w8G5yHH8LMEv5
	06vSS/83MX/Mzv2EChzMjo1EWP+2Txj16kDDMjZwc+HvtcqttNLDU3bn3Yp+C9EkyQy3PwXgHwJ
	1kr3mCPqzIKz4CpmI9jWarUk7Uwop8AV0+qMbHW4vLiWpBuIrVkkaWsj8+MCfzExLYKNKAgSnc1
	6Nz/bseh3Q5VtoFumQ/erVbnDw6BEz0VOJePie5lYQBTVdsEjlieuHBMaDnzta1mqgZxIO2M3XL
	I9CofZdhg6ECNUZUuMrnIoOgdzBym7VTD2E3bgplfIn32dBUxnkkOZdwBcfpxSSO7L64DUpOTPH
	+i1vhsJXQk8MCmSHQeRaEzexiwLJP8CT51Nu7D/Fa/3g8drHFXR9YqO0djUknz33nE3tCNI4c=
X-Received: by 2002:a05:620a:1a29:b0:939:6ec8:6928 with SMTP id af79cd13be357-93a2985d5c8mr1045812685a.16.1789476562792;
        Tue, 15 Sep 2026 05:49:22 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a382ab7b3sm169560185a.19.2026.09.15.05.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 05:49:22 -0700 (PDT)
Message-ID: <7b85bdf3-d3d3-4e06-964a-3e5e969691da@riscstar.com>
Date: Tue, 15 Sep 2026 07:49:21 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] misc: tc9564: introduce base PCI driver
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260915031038.1087264-1-elder@riscstar.com>
 <20260915031038.1087264-3-elder@riscstar.com>
 <20260915032059.60CC61F000FF@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260915032059.60CC61F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/26 10:20 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] misc: missing of_platform_depopulate() on probe error path
> - [Low] kconfig: unused REGMAP_MMIO selection in TC9564_PCI
> --
> 
> commit 526cbf40d582cb34a1f4613745e5ca7890f929d2
> Author: Alex Elder <elder@riscstar.com>
> 
> misc: tc9564: introduce base PCI driver
> 
> This commit introduces a base PCI driver for the Toshiba TC9564 SoC, which
> implements a PCIe switch and Ethernet AVB/TSN bridge. It performs basic PCI
> initialization and uses of_platform_default_populate() to scan and probe
> child devices defined in the devicetree.
> 
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 7364931dad3a1..91950d2928f07 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -568,6 +568,16 @@ config MCHP_LAN966X_PCI
>>   	    - lan966x-miim (MDIO_MSCC_MIIM)
>>   	    - lan966x-switch (LAN966X_SWITCH)
>>   
>> +config TC9564_PCI
>> +	tristate "Toshiba TC9564 PCI function support"
>> +	depends on PCI
>> +	select REGMAP_MMIO
> 
> [Severity: Low]
> Is the REGMAP_MMIO selection required for this driver?
> 
> Looking at drivers/misc/tc9564-pci.c, it does not seem to include
> linux/regmap.h or use any regmap APIs. Could this lead to unnecessary
> kernel bloat if the regmap infrastructure isn't selected by other
> configurations?

This was an oversight when making the conversion to the endpoint
bus.  This driver no longer uses regmap, so that dependency will
be removed when version 3 is posted.

> 
> [ ... ]
>> diff --git a/drivers/misc/tc9564-pci.c b/drivers/misc/tc9564-pci.c
>> new file mode 100644
>> index 0000000000000..d7ebbd90d1584
>> --- /dev/null
>> +++ b/drivers/misc/tc9564-pci.c
> [ ... ]
>> +static int
>> +tc9564_function_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> +{
> [ ... ]
>> +	/* Scan for pci-ep-bus nodes and probe their sub-devices */
>> +	ret = of_platform_default_populate(np, NULL, dev);
>> +	if (ret)
>> +		goto err_clear_master;
>> +
>> +	return 0;
>> +
>> +err_clear_master:
>> +	pci_clear_master(pdev);
>> +
>> +	return dev_err_probe(dev, ret, "failed to populate platform bus\n");
>> +}
> 
> [Severity: High]
> Does this error path need to call of_platform_depopulate() before returning?

It looks like it does.  I now recognize that of_platform_populate()
(called by of_platform_default_populate()) does not unwind and clean
up its mess in the event of an error, so doing that is the caller's
responsibility.

I will fix this in version 3.

					-Alex

> 
> When of_platform_default_populate() fails midway, it leaves any successfully
> created child platform devices registered and sets the OF_POPULATED_BUS flag.
> If we only call pci_clear_master() and return an error here, devres will
> subsequently disable the PCI device completely via pcim_disable_device().
> 
> Since the orphaned child devices remain bound to their drivers, any later
> attempt by those drivers to perform MMIO accesses on the disabled PCI
> device could result in PCIe Unsupported Requests (UR), which can trigger a
> fatal SError/MCE on many architectures.
> 

