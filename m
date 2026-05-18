Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064CD3EBF03
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101759; cv=none; b=QhqLAdq6JPoh/dIAB1U1lzxjEaffRMSS2juoug5DIEAA7/1Lqpq/26L4k3cKrZedtIw55BQHGr4NhnmXWMil0HRTRgSjzhOg/z9ez36XBQiDzeQtdAWOylGq9DeYFIEE6pYYAJcQ1GaZeF444SA8K4Mt8CK78JtmkRvAam+z58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101759; c=relaxed/simple;
	bh=hHrnrova4QOYv2M6dIOzxmlKptiDDDOXgFRyBRFswWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fks1MIRWv/3IpH1IrcprUNU3WovcZMNb4vsV4auDgL+YFBjmw106tPsIcNVdBBBQQ47FyzGT1qNqDqqDKsFg7/mhQAg6V5vetznDsZVJimtCabRz9hE/QkjxPFVZLAMCBtOQU+oF7oP6FERSskt6pplZUUsmqikWzmNDAyunUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ+peLbN; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ+peLbN"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso1745758eec.0
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779101755; x=1779706555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Fv8cUffeX0YGsV9duS8FS6XTQ7kK/O4/YLY9appo4lw=;
        b=RJ+peLbNbir3jr4971jUhuRTqRK6nzP9YseDMYD9dztemweAnGsdaqrP17cDKashmp
         o1dTpZGyShDmnba8711ZeX7QRJ7RR1YbBwI/4rH9jNM0H/Yhe/9v1oLuaF4K1coMPPdt
         1MjfkQ5qeZePNsQa2LbCuv/xZyhu0exD3HEpLYNCN9X48lnCP3QmJWnKJ/LEC44GoB64
         m0kaSz7Q0ijMCW+dB8E3/IpcAOR6VvdWIwaF6jRyHKNMdujZJ82MG7lkadZV7Tun20yh
         st0DZnwAXi4TjCrUnFaLwYzUi7HlUMP0rzZpXTGo8O/OAwaYTivMu1vFmaisdF2wbMcF
         2UzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779101755; x=1779706555;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fv8cUffeX0YGsV9duS8FS6XTQ7kK/O4/YLY9appo4lw=;
        b=W8Cc0ICOY5k9pFfVXsZ7GPX/ZwoJPilfGQ3HtugImvmHQF+rE/gN9fg4bFyuwK9lnU
         fCdxDk0BaaBJu0NLvIL0GuIGS08Tja0SumuAGkGNV9LgmHyBMBH+pOJGzb4Qr7a4N7w6
         WbTiB83QsaVECVbxaANUWoNFwsJm81/omisxnCjRhVXWyNObwSEytBLU+QVpmAaIinZm
         beJJpbizBSzkkrnnsX+nJd5YPQWHZ+ugTxYeSUtptyE+1wwvBAvDfGKM59tVVNssKagl
         9mubIy1KnlfGAxjaIgB5fCNnAmWa5DSfYExF7jlHV/9TW1Qgj7IXlEiUnW6VRRbo1MAY
         l9Iw==
X-Forwarded-Encrypted: i=1; AFNElJ8w7MHpkPz6WHS/+lJf0S/nvcCU0NSzfZW6Rbt/dMwkSgpzhjsyV+s6BDhcEW9FyvJmzvz1AXtCpxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0oNE+2vYNjIhJuTS92bhhtuaqJUg/F9/EnqB8LLQ7zAaUPrMg
	2XREug6gczuwX4zaVA+TfIGm3GgJccGXfQFPkZLHF7mTPa4e1vdgM2M2
X-Gm-Gg: Acq92OFXz+ee659CsYRzXdnH+pF1zDt64mg/S4/IN9mH1t0Evp6fnPEsmSyyPCjAfkw
	IvBgDWGh64KvK9C5DN55IWur0/RvwqVRIE0NCTdK6MZiGeCMEaVN3v7oLNtFdnfwaGF1Frh2Kbi
	4iR+gm7uKNJcNr0ApOGYe043HWi5Fq6qfpgmzXMjyQgm6nUf3P3qxqBBG7ebEUq+JX1/IFm/7s2
	CLMdQgzHAH/GTeoT7klePuTQ58JF6xMpxMeBX6EXssKd7nu5/Y/WeTc9IgboFgcrRDsh2zISNMl
	n2UYuRT95IDs7csAL/2IoRT4Lz8H/boHf4lv9QxNfJ80l+8qNuAdIaAU96pVEh9Sbxmip2dn3l1
	MijysBeoG86LmOr+KdMbYfV3iZya0zAMOCNk3lc1HcChmb7lKth3ZaQs/+lPbvmHKQSYfqMHKD4
	p0nat17ZJe2i6hrf5mBZ5GAbTFy2rTJt9omvOQ6RJ7qEvgdMDtNciN+gO/gg126ofoN0zGqrWA4
	q7QJPEqdmE=
X-Received: by 2002:a05:7300:dc8e:b0:2f2:5c68:5074 with SMTP id 5a478bee46e88-3039818af8fmr6391352eec.13.1779101754580;
        Mon, 18 May 2026 03:55:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294500a97sm15416905eec.9.2026.05.18.03.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 03:55:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f05e075d-a87e-49b5-95f8-5858d21acf64@roeck-us.net>
Date: Mon, 18 May 2026 03:55:52 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
To: Michal Pecio <michal.pecio@gmail.com>, Jihong Min <hurryman2212@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Yaroslav Isakov <yaroslav.isakov@gmail.com>
References: <20260517130407.795157-1-hurryman2212@gmail.com>
 <20260517130407.795157-2-hurryman2212@gmail.com>
 <20260517232147.34931718.michal.pecio@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260517232147.34931718.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/26 14:21, Michal Pecio wrote:
> On Sun, 17 May 2026 22:04:06 +0900, Jihong Min wrote:
>> AMD Promontory 21 (PROM21) xHCI controllers use generic xHCI
>> operation, but the PCI function also exposes optional
>> controller-specific sensor functionality. Add a small PROM21 PCI glue
>> driver for AMD 1022:43fc and 1022:43fd controllers.
>>
>> The driver delegates USB host operation to the common xhci-pci core,
>> collects the parent-provided MMIO resource data, and creates a "hwmon"
>> auxiliary device for optional child drivers. Failure to create the
>> auxiliary device is logged but does not fail the xHCI probe, since the
>> auxiliary device is only needed for sensor support.
>>
>> Make the PROM21 PCI glue a hidden Kconfig tristate that follows
>> USB_XHCI_PCI. This keeps the glue built in with a built-in xhci-pci core
>> and builds it as a module with a modular xhci-pci core. A built-in
>> xhci-pci core must not hand PROM21 controllers to a PROM21 glue driver
>> that is only available as a module, otherwise USB behind those controllers
>> can be unavailable during initramfs and PROM21 temperature sensor support
>> may not appear until the controller is rebound after the module loads.
>>
>> Assisted-by: Codex:gpt-5.5
>> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> Tested-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>
>> ---
>>   drivers/usb/host/Kconfig                      |   7 +
>>   drivers/usb/host/Makefile                     |   1 +
>>   drivers/usb/host/xhci-pci-prom21.c            | 136 ++++++++++++++++++
>>   drivers/usb/host/xhci-pci.c                   |  11 ++
>>   drivers/usb/host/xhci-pci.h                   |   3 +
>>   include/linux/platform_data/usb-xhci-prom21.h |  22 +++
>>   6 files changed, 180 insertions(+)
>>   create mode 100644 drivers/usb/host/xhci-pci-prom21.c
>>   create mode 100644 include/linux/platform_data/usb-xhci-prom21.h
>>
>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> index 0a277a07cf70..89bf262235e1 100644
>> --- a/drivers/usb/host/Kconfig
>> +++ b/drivers/usb/host/Kconfig
>> @@ -42,6 +42,13 @@ config USB_XHCI_PCI
>>   	depends on USB_PCI
>>   	default y
>>   
>> +config USB_XHCI_PCI_PROM21
>> +	tristate
>> +	depends on X86
>> +	depends on USB_XHCI_PCI
>> +	default USB_XHCI_PCI
>> +	select AUXILIARY_BUS
>> +
> 
> Instead of the X86 heuristic, would it be possible to build glue
> code if and only if SENSORS_PROM21_XHCI is enabled?
> 
> This seems to work:
> 
>   config SENSORS_PROM21_XHCI
>          tristate "AMD Promontory 21 xHCI temperature sensor"
> -       depends on USB_XHCI_PCI_PROM21
> +       depends on USB_XHCI_PCI
> 
>   config USB_XHCI_PCI_PROM21
>          tristate
> -       depends on X86
>          depends on USB_XHCI_PCI
> -       default USB_XHCI_PCI
> +       default USB_XHCI_PCI if SENSORS_PROM21_XHCI != 'n'
>          select AUXILIARY_BUS
> 
> I don't know if it's the best way, perhaps it would be preferable for
> the hwmon driver to select the glue, but then I'm not sure how to force
> glue to become 'y' when xhci-pci is 'y'.
> 

Unless I am missing something, that would disable the entire controller
if the hwmon device is not enabled. That seems a bit draconian to me.

Guenter

