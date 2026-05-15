Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A12741A0
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809794; cv=none; b=N2886FBbaetyDO+ZdQoa5AmENWU5rR43FpVbshKhOtm+gXVOjsw5L8s/q6m4w/zFm9TzZBP9V/QouSZAAN2lsbTsjvSIaewUXvLSMRg7j0hdltKTDbg+8H4IB9DAMVmjyfLGyBdpkyyq23WkV7XQM0lH++vDcw1m8ck4E/FyGtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809794; c=relaxed/simple;
	bh=SIkgv8WQ93LCQ71jhhL3Di/xP8TbuCuowvj1KosLZko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0AxvKiABWjVPeOpJhoi3iAagUOvuztEQBF5W9dq/n6pndV9fkzYobpvh5l3U7/JJ1K7a3LQMvvJIUvqiKra4P0sj4Prz6gqoCCn9ij6lIUzKuQ6Kai6B86E6Ee10y3DfRiPky1kNa29MITdg4VQ2xJmShtEWO3fkGeF13BbErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWBhPXr0; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWBhPXr0"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c1a170a50so12195286c88.0
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 18:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778809792; x=1779414592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zrNDITa07PIrUrnI0P0l/esE24/KQSx6Tox+P9NMGxo=;
        b=oWBhPXr0SycOWAmTPteIs17tKJBKkiUQxpVoUCn7ddRMGeMbZSgoaVGcRJ/OeFEntF
         TnJgPbe1AdXoUBSPoJR51y/8dY5QUn1n9VIaY5Omuj7au3txbRX3fifNKE8B751aZd6Q
         UzYZbKuwPdyKS6z7BsARsIjXuvVP9nBU+1mlwQadJyKT4XeaJG5FvliDHSDacX0hbahi
         4wz/vyQNg4vCsg6EKP0yQypUz1HB/gA3C71EJFuemGN1ZnjH+KqAG6oPpZ2FOde5SaIW
         bIpa+fuhGLYa1zmVQCgVxjY7rbxx4IP3FypX88VKVK2Zp9ONFaz8b9NNmkqFwukoC/wp
         yyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778809792; x=1779414592;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrNDITa07PIrUrnI0P0l/esE24/KQSx6Tox+P9NMGxo=;
        b=DCY14I/6GanRahDMdwWmhjK0dIAalXre68bbj59o4+G357miPKdt0FGJYdK/pVoaSB
         fXdJVT/kXWp2yNGx4VQ9ockBi4DunUS/2uDN2Vr7tiuSMvosu44mWByBHnTIeTLGZNaR
         VpKlg9rdW9gPQoaCnkovzdlOA13gxaUGKc/kN6l4D0d/FomK1f1lLMo5JVi4iD6LiFZi
         S8DNde4L3kjXfXZDkxxMi83tULF1myXsY/ScmyI5myDqlH+mBrldLM0gHvX19muVPf/Q
         NlI8uuRsDtsC0/WU8tCprVkPObOyeaVS+FCigqS45NUjhJU4MQIjwV03Jtny4zmToJYZ
         +uiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/h9+N1TYyBnfdzpRliirb3e+kkqrQNvRk0yrI3Q4kD5PKzSwb4HVoGHgaYlfx4DsEaVq6gj5Pl6O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfbR8jX4AtqcIM1rzNx20glLzMKUqNu5AVV14Pi83Rw6JvN3yS
	BFGDC0RJ3q/rXoYqJgCo3G8NWeBwRk4g8+jJ2H+4HLaXvZquq+Bq3KbY
X-Gm-Gg: Acq92OHGj7mBtbzW6IEiJGfdtAHybOiI7Q3Y7ZcZe+RwsUY2sxxX1xaOFd1ebqmUs8J
	i0v780AB8wUZWdNKvRLNpGj6eYpOG/SHGrgFwZ+g9bPqpS6JKh4bIJn9vPDGh7ml578OtpxcwEm
	B+Tk2aaUp8avS4AqPFE966jQ0ucQz40c9NHWNY38xr1rQhZfRFgZ7kL1ucNcy2yxgMjoeHcg4qy
	Of+FRDtxo0aOBpEb7zXHLCs3nKMkKQUbnUjX0b46Kb9qDN/PZ7VmaB2Y47bZz4hb87Y+XTU2zXB
	nprhm355M1cctVM3SVqAfiPUWlpBbFUwBW9qwE0GJPTX8P+boG6pHBp5hVWyCRLINpgNkjMTTr4
	qmwEo05HsXhRAketsvWiiqot1RDCP4hUyaHOAjFLvzDHpP89RWq4oNnacgYtsM1VR1aFbZwm1KU
	Ye5PG5ahEg3zIEv3ma4gz5v19VfX0vpMgqvSP4cPQ8QVlX2iLlQdkBSwsaoEKUsZdTYJ6KGJkR8
	khmtg4yPbU=
X-Received: by 2002:a05:7022:311:b0:12d:b396:eaed with SMTP id a92af1059eb24-1350440ae04mr818420c88.9.1778809792003;
        Thu, 14 May 2026 18:49:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed2232sm7676638c88.7.2026.05.14.18.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 18:49:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a1ada282-ecc4-4b9f-a479-c5bddf25e641@roeck-us.net>
Date: Thu, 14 May 2026 18:49:50 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
To: Jihong Min <hurryman2212@icloud.com>, sashiko-reviews@lists.linux.dev,
 Jihong Min <hurryman2212@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260512213910.871859-2-hurryman2212@gmail.com>
 <20260514004055.1BBCAC19425@smtp.kernel.org>
 <110e9a0d-bc91-4959-8a7b-1a055d0b49f7@roeck-us.net>
 <1f296d29-3d43-4dd3-b751-8a0892b4095a@icloud.com>
 <a90ab332-9f86-4486-8243-07c98e3f7578@icloud.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <a90ab332-9f86-4486-8243-07c98e3f7578@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/14/26 06:44, Jihong Min wrote:
> 
> On 5/14/26 22:38, Jihong Min wrote:
>>
>> On 5/14/26 10:20, Guenter Roeck wrote:
>>> On 5/13/26 17:40, sashiko-bot@kernel.org wrote:
>>>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>>> - [High] The Kconfig dependency `depends on USB_XHCI_PCI=y` completely disables PROM21 support for systems where the core driver is built as a module.
>>>> - [Low] Signed integer overflow when calculating the auxiliary device ID.
>>>> -- 
>>>>
>>>> commit 20f4e35b2f88ebe2b8988b4f07fe7cc28199096b
>>>> Author: Jihong Min <hurryman2212@gmail.com>
>>>> Subject: usb: xhci-pci: add AMD Promontory 21 PCI glue
>>>>
>>>> This commit adds a small PCI glue driver for AMD Promontory 21 xHCI
>>>> controllers. It binds the controllers, delegates USB host operation to
>>>> the common xHCI PCI core, and creates an auxiliary device for optional
>>>> temperature sensor support.
>>>>
>>>>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>>>>> --- a/drivers/usb/host/Kconfig
>>>>> +++ b/drivers/usb/host/Kconfig
>>>>
>>>> [ ... ]
>>>>
>>>>> @@ -42,6 +42,26 @@ config USB_XHCI_PCI
>>>>>       depends on USB_PCI
>>>>>       default y
>>>>>   +config USB_XHCI_PCI_PROM21
>>>>> +    bool "AMD Promontory 21 xHCI PCI support"
>>>>> +    depends on X86
>>>>> +    depends on USB_XHCI_PCI=y
>>>>
>>>> Does depending strictly on USB_XHCI_PCI=y cause a configuration regression
>>>> for most distributions where the core driver is configured as a module?
>>>>
>>>> The driver source appears fully capable of being built as a module, using
>>>> module-related macros and module_pci_driver().
>>>>
>>>> If the intent is to prevent an early boot mismatch where xhci-pci is
>>>> built-in but the PROM21 glue is a module, could this instead be a tristate
>>>> option using depends on USB_XHCI_PCI and depends on !(USB_XHCI_PCI=y && m)?
>>>> This would enforce the boot constraint while preserving support for modular
>>>> kernel builds.
>>>>
>>>
>>> That makes sense to me. That would be stronger than using default (which
>>> was my idea of dealing with the problem). Restricting the code to USB_XHCI_PCI=y
>>> seems to be a bit extreme.
>>
>> Hi Guenter,
>>
>> I looked more closely at the Kconfig part of the Sashiko suggestion.
>>
>> The concern itself is valid: the v5 dependency on USB_XHCI_PCI=y is too
>> strict because it prevents the PROM21 PCI glue from being built when
>> USB_XHCI_PCI=m.
>>
>> However, I do not think the suggested expression works as intended:
>>
>>   depends on !(USB_XHCI_PCI=y && m)
>>
>> With Kconfig tristate logic, `m` is a tristate literal, not "this symbol is
>> being built as a module". If USB_XHCI_PCI=y, then:
>>
>>   USB_XHCI_PCI=y && m  => m
>>   !(USB_XHCI_PCI=y && m) => m
>>
>> So the dependency becomes `m`, which limits USB_XHCI_PCI_PROM21 to `m` instead
>> of allowing `y`. That is the opposite of what we need for the built-in
>> xhci-pci case.
>>
>> The combinations I think we want are:
>>
>>   USB_XHCI_PCI=y  -> USB_XHCI_PCI_PROM21=y or n, but not m
>>   USB_XHCI_PCI=m  -> USB_XHCI_PCI_PROM21=m or n
>>   USB_XHCI_PCI=n  -> USB_XHCI_PCI_PROM21=n
>>
>> I see a few possible ways to handle this:
>>
>> 1. Keep USB_XHCI_PCI_PROM21 as a visible tristate:
>>
>>      config USB_XHCI_PCI_PROM21
>>        tristate "AMD Promontory 21 xHCI PCI support"
>>        depends on X86
>>        depends on USB_XHCI_PCI
>>        default USB_XHCI_PCI
>>        select AUXILIARY_BUS
>>
>>    This supports USB_XHCI_PCI=m, but it still lets a user select the unsafe
>>    USB_XHCI_PCI=y / USB_XHCI_PCI_PROM21=m combination.
>>
>> 2. Keep it visible and rely on help text to warn users not to select `m` when
>>    USB_XHCI_PCI=y.
>>
>>    This is simple, but it does not actually prevent the bad combination.
>>
>> 3. Use IS_REACHABLE() in xhci-pci.c instead of IS_ENABLED().
>>
>>    That would prevent built-in xhci-pci from rejecting PROM21 devices when the
>>    PROM21 glue is only available as a module. However, it also means the
>>    PROM21 glue/hwmon path would not be used in that configuration unless the
>>    PCI device is rebound later, so I do not think it is ideal.
>>
>> 4. Make USB_XHCI_PCI_PROM21 a hidden tristate that follows USB_XHCI_PCI:
>>
>>      config USB_XHCI_PCI_PROM21
>>        tristate
>>        depends on X86
>>        depends on USB_XHCI_PCI
>>        default USB_XHCI_PCI
>>        select AUXILIARY_BUS
>>
>>    Then the value follows the common xhci-pci driver:
>>
>>      USB_XHCI_PCI=y  -> USB_XHCI_PCI_PROM21=y
>>      USB_XHCI_PCI=m  -> USB_XHCI_PCI_PROM21=m
>>      USB_XHCI_PCI=n  -> USB_XHCI_PCI_PROM21=n
>>
>>    This prevents the unsafe y/m split while still supporting modular
>>    USB_XHCI_PCI builds. The actual user-visible sensor option remains
>>    SENSORS_PROM21_XHCI.
>>
>> My current preference is option 4, because the PROM21 PCI glue is not really a
>> user-facing feature by itself. It exists so the common xhci-pci driver can hand
>> PROM21 devices to the PROM21-specific glue and so the optional hwmon driver can
>> bind through the auxiliary device. The user-visible part remains the hwmon
>> sensor driver.
>>
>> Does that sound reasonable to you, or would you prefer one of the other
>> approaches?
>>
>> Thanks,
>> Jihong
>>
> One follow-up to my previous mail:
> 
> If we go with option 4 and make USB_XHCI_PCI_PROM21 a hidden tristate
> symbol, I think its help text should probably be removed as well, since the
> symbol would no longer have a user-visible prompt.
> 
Agreed.

> The user-visible option would remain SENSORS_PROM21_XHCI, where the hwmon
> sensor help text can stay.
> 
> Does that sound right?
> 
Yes.

Thanks,
Guenter

