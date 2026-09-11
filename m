Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4335DA6A
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136697; cv=none; b=RGjCOTPCjSIs8gDuK7gGI9NAowUlLbhYf163QiJtNhOg/2LF8WY62CKsAyac8jPBjav3dsVEyr3tgxI0g0jV2QbDXWuahdXgAr82OfyWRJWHANoBaXvPJHQHp0DFrkfLBlU32dHZhsgAeUUhCVbrl/xYT7axjZxsZvUVCzku0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136697; c=relaxed/simple;
	bh=0BnFyfpHxaN7X8M6MZfoZRsJTH8vdE5rSC5tlArxTuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McRfekbfDg+U59Ekl+MZNt5y7cpkwNuClgYxZ7RhD1/VoIPbyiF61MwrkW1gLRStKV+9LFRvzUPJvykMciaWrvAv6eWQJTZhpW6M9jdMwPXLIejsR6E+bqsAugKPabzi/wSPTEXPC0MbkKxA4cy4FKKQ0DtkcxbHkocs/yC8gLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=op1WeirU; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="op1WeirU"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-855c26cf490so5922827b3.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 07:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789136694; x=1789741494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYsFM9rsy1NhxpJuuAZTc7GVdXZGCbrElo639f3wOAM=;
        b=op1WeirU66fVo4Y4YOcG3jbmpi2sasOdg8+flx7Kct6RmsGggHlhqM6qNHNk9BPwLq
         oBvJdpYMUA6XJITQDn2rh6a+MU0Z1IUpAJ/wwFHOM4YXX7GTG+AwGlFFtZidvbg/Nxcf
         jjrEs+x2POUUlYILHIJFM5Tk3ik8Ym4NAbFweZWOi9EaCqD0sbb6/4Gg5yZUZpTAwNWa
         Ql/tqhmGqTmBUo1MCREzJGXUWfHjac8FinLLR0HETYnaSelBuzlxISgtqd0BPXrtt2dv
         AIiC+crOl0ESqQCuPhvEiF9HCguy88gpCgIv+PXvH31iyABxX1at9ZhsZKrOosNFdAiT
         hRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789136694; x=1789741494;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bYsFM9rsy1NhxpJuuAZTc7GVdXZGCbrElo639f3wOAM=;
        b=RH5nXP1T8/qWmB/q4kq9I2RYX10AMHl8VWAE6bknqYIs73Mk9vUne9/nNhJzqOk9vp
         B6+GFAjLtIqFgmLmirwbgv4y9quACufh6KlPL/FAvacU0azA3FoSLCGqMFIkKersCBnm
         vSlThLMM9Y7RMhiA60CdVXVSFCdUPu+PfH4J/eC44gm5CVv89Kb9WiVL3MSDUDNpbupt
         Njg9FhqVzsWu9X+6RigkGJ8PPnzoHORvlXTFLWDfR0e1Vn3l3tetz7OoBdauZBtqb7S5
         kgbNaQjwmWZR59Y1jKY3Em0ptaCI9p3U4e7vzIuCYOSSGjIj7clRuMC6YFxeQX6rfC2j
         GBrg==
X-Forwarded-Encrypted: i=1; AKwUvBy5Qy2DYknrtF7b6uz8c1Ng6JTRChLpWoEyKA8NU9cSMhuJEaD4PGmdpLRZzeS5OghF8nQ9d8O1qAs=@vger.kernel.org
X-Gm-Message-State: AFuF++nE/2hIU9bjAcQofkaPQGnJtDwhsxGvcFOclG1R96Ba/oeTaSoZ
	DOHf2SzSHPcOJzqQO2RnlFiO6MIPiYIJkfEHfPKZKX0xHBoVtInbImq05npyrf8i
X-Gm-Gg: AYBFou2vWEHzZ1OC7hNvqjqsley5vaXswffmdRBnXvEBF2nGA+Z8ILt6IfS2+65W9qo
	A/B26ATh0mRWxNzBXMYV5vUgPfEBuJDXIogt6CfewySWmp186QoREUwHMIjx/0suI//5Y6WdCpY
	U7+k305fGu7Jj1CLI4oFRCuPVtUcEhf7H46Llvb5lMYzLQ01hQEkZdXsbdrgWenFNRd9czQJ7WH
	qjhjx4ztprjVvDnEhRiAxjd1tDiW4KOW1is/zVLy8vcyfrTuKKgTXI5YEITUY41JYyh5fi2/vyE
	kpbyidvVxRgPFGiOInwL1JvwbLHUihda3jrPozLWdiP1rOIR26hsi7L99+7hCzP1QlwAqKcybQN
	h7iTAEdrFHskHofBTa/XXClOmqexCxIsgZy28m6oDkDVuLTvrCWhou2EobgI+y7O5RXWX1ubNF5
	LarqNh8EFsn465x7e+8RaabtZne+guhC6UbGHHk4JIeYxWZTrxWnxhYKjSWsuY1zHKOgb53TJ1M
	gBumCfA0LgmsjKbjt0irbS6f3kSnFNznK7xXNejyvAAzjOG
X-Received: by 2002:a05:690c:385:b0:873:5ddf:d85d with SMTP id 00721157ae682-884b2bcf9d2mr14489137b3.40.1789136694108;
        Fri, 11 Sep 2026 07:24:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88488c3ab26sm10799867b3.40.2026.09.11.07.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 07:24:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <091d3bdd-f9f5-4f67-a9be-ff9e49ecaee1@roeck-us.net>
Date: Fri, 11 Sep 2026 07:24:51 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (k10temp): Add PCI IDs for 1ah/80h
To: Mario Limonciello <mario.limonciello@amd.com>, clemens@ladisch.de,
 bhelgaas@google.com
Cc: linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260911134304.226286-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260911134304.226286-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 06:43, Mario Limonciello wrote:
> 1ah/80h uses same base as other programs.  It only supports Tctl.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/hwmon/k10temp.c | 1 +
>   include/linux/pci_ids.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 3e7e63edc6a30..b00081deb2e86 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -582,6 +582,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
>   	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>   	{}
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 63774ae2bf71d..57a4ad9984798 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -585,6 +585,7 @@
>   #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
>   #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
>   #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
> +#define PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3 0x1243

Please define locally in drivers/hwmon/k10temp.c. I can not touch
this file, and additions for single-use defines are usually rejected
by the maintainers.

Also, it would be nice to list the chip family in the commit message
and add it to Documentation/hwmon/k10temp.rst. But then I see that
all chips from family 1ah are missing from there, so maybe that should
be a separate patch.

Thanks,
Guenter

