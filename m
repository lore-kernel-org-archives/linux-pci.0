Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED9E3A9615
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726534; cv=none; b=H9EvSOzR2KIqCnnagIU8jI9cqL+IrlsEPHH7ED35ymRD+TrhzmVIPoFj5RTGc+VSdL16rPgmKZ1dYh3gGzec8rlIyS4X/2zUamRwkWY8ak7d1QKigzKLJpgQgcIFb6pbYlvfz195rP/1Xsqt2kbE25xXEahhyG3Qtflck08GEWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726534; c=relaxed/simple;
	bh=k5EloMOSTVAa9CzBTiI/tnt1aw0B//WUVChQ0e1YpDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipWhKFgbQ6YSYLdNZSB2RlYZBNVUCMPM4CSHHgpoRZSi1+ZI74Le+ZNi58srNjQKJk/ClT2xyzEf0zcg0YkGGbk9pWtQgBe9uDt8f7MYlsBghQS70FWAe0Dtaf8MirzKgNvYd/nBvg5tuevLUZoDQ74+3wADTwsAxUKH6VWUuqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=CTmaAcJl; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="CTmaAcJl"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51bfe810293so6490361cf.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786726532; x=1787331332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PTW05gzNIpG2NVGNH+SKktP5f5MLzIfsgAEdY/wEjzU=;
        b=CTmaAcJleqxEnKYz3WBrXorkx+ByXEpbjMMbQNZelj6TbqSPWjUqYtFmrI1qpJgGkv
         TKPAMRNNLIQWw3ekDT2Im+6WGAPPhFJCQrnT7ZhkD+DAsIbvnaXr3o+TuFpT7gBO745P
         gnTYG4A4Y7lpYRZmD9kfITzxPc36zTgHlPh4K8m3bZ6bw94SH3hv9buYgUjx0KVjmf6Q
         DrRO9SvcDwi8mBg/ioggEWW0fIYiluhZbOJTQQLuh9VgHxj9i5z2XHXn+JfwKmFsDoNC
         sZgGE3x9MvH5SCVaLs4RRCiTunSKA+6YsU5POJ5tD7sijsUjozid50Or0xFU4rwaLBi+
         a35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786726532; x=1787331332;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PTW05gzNIpG2NVGNH+SKktP5f5MLzIfsgAEdY/wEjzU=;
        b=dB0G2oH5N/OKT5PRePxftHMPsBsqQ8ntJe3Bufum26sdmC2DXx/ELYewX5U5V0WpC7
         P5bJOCighJFJdOe9MHjhVwzPl5lCoyoPtdlKl2fxtVGWiy8yl9FkM20C1nKUnsRvQX1y
         w1UqzMfUkkmy+QHFW0kb4C6HyXcdJwerL4sJYEvWXFEQgbtIyp1VEKeih2KnYtFW+4HC
         tLmOvlp/kgf18Yc183GsimhqLm7TUwj5O+wTM7RNrkCmMXae8+hXJmjX+DNaH1lde5Ij
         IArXcjkW4o9NxXagGWrJnt9P6z4egBQDngmM3PMhpgcpboECGfP+ncc8rC0T6nUniH1H
         dZSw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9JKfbSUAW0heYJO3bm2tfzF6fTTm7OkagD3nsagFvmqtzwQKBClo0oBV/Kzm2KJLv1QYVf68senE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1uSiPa71LyxkDH8OdY8Bdn54+Mw1fCOfiljkXmcfmOluDsSpr
	XqzHh9GR5wS8TEzTSRWam38d5JuX7LlgJAmn3Z4W+OqZVn1/jhP6/BOxwzb9ZBsoutE=
X-Gm-Gg: AR+sD10YNlIpYVmwRuobl4Nz0OOFhrvrIiArikxrpxLaMHju3gZoO4cNuMD+6cdQpWi
	W4l3yKWBqJstGGdr62mGgIckiqPzbiQ9x1D5LbLfzXAoYFwmFjReXC+jvdJHAQoNg4Agb3tm7dC
	KSLz6zN9w2CJC7XG3lkZIRXbzv/uUMmTAg9FlN38OZVl1hQKq7/Z6wxJjrwgFaSJx3LkwUEDzjP
	XUzmrrF3iLiSQ5AoV8mUZXdSB3pQDb5sWHoTgcA5gDnaNGFFBt+VPno6+SX5aIFQkMcNWyjJZsP
	wcHjirp3phpGLPPpkoXnWikBR3OXkKTlGxNxMUCHHf6XqMRJpwwAGfjElUAFWtql8uJRLVURhOg
	sFCEiBr82GyDmkBNbqY64oCkpGkg7GSA0gYiyF+V751Hgw4E/eyerq1xV9IbVZd0rvnNOillIVR
	7YR5fvTPK8LkXXdkSW+DsqtHiAJEF6J3Kp0e2rKU8MeRsOO5TkzXI1H9vlmI0m
X-Received: by 2002:a05:622a:608a:b0:52d:8257:666d with SMTP id d75a77b69052e-52d8541dcd5mr85954931cf.11.1786726532365;
        Fri, 14 Aug 2026 09:55:32 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d84071799sm24476161cf.20.2026.08.14.09.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 09:55:31 -0700 (PDT)
Message-ID: <4bb8bd0a-3e33-4fe4-903a-69b2c708a017@riscstar.com>
Date: Fri, 14 Aug 2026 11:55:31 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] misc: tc9564: introduce base PCI driver
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, krzk+dt@kernel.org,
 Conor Dooley <conor+dt@kernel.org>, bhelgaas@google.com,
 daniel@riscstar.com, mohdayaa@qti.qualcomm.com, lbiancon@qti.qualcomm.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-3-elder@riscstar.com>
 <2026081455-eternity-douche-900b@gregkh>
 <56aef294-8d1d-40f2-a371-ea3f5ede2ccf@app.fastmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <56aef294-8d1d-40f2-a371-ea3f5ede2ccf@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/26 2:31 AM, Arnd Bergmann wrote:
> On Fri, Aug 14, 2026, at 03:11, Greg KH wrote:
>> On Thu, Aug 13, 2026 at 05:29:42PM -0500, Alex Elder wrote:
>>> +#define DRIVER_NAME "tc9564-pci"
>>
>> What about just using KBUILD_MODNAME?
>>
>>> +static int
>>> +tc9564_function_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>
>> But wow, this is a tiny driver, feels odd to have it in misc/ but ok, if
>> you think it should be here...
> 
> We have drivers/misc/rp1/ and drivers/misc/lan966x_pci*.c with similar
> functionality, so at least there is precedence for putting them here.

Yes, exactly.

>  From the old days, we still have drivers/mfd/sm501.c, drivers/mfd/cs5535-mfd.c,
> and a few others that open-code the on-chip components as mfd cels
> instead of using devicetree description.
> 
> At some point, we should think about grouping them into a separate
> subdirectory.

You mean for systems modeled with PCI endpoint bus, right?

If there is consensus that now is a good time to do that I
don't mind doing that work, but won't unless it's clearly
requested.

					-Alex
> 
>       Arnd

