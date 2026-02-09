Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E9D3793AD
	for <linux-pci@vger.kernel.org>; Mon,  9 Feb 2026 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645470; cv=none; b=rNez+DrvIAqCHgjAj3jskeuI9BI0lLjbeQlQxWqv5r8P6BoDLTmGlnpngq7TosPPiMEnTl/gj2sq3kW3O0yJ87Y0bNhhHEA6Ko4YOcgb/GCcthipnp5aKr7wAI1mKuTjtC954MfkJuOFSYLasp10+mpOMdF8uAWnkBe3xEMU6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645470; c=relaxed/simple;
	bh=/9aq1p8UbEf2VUn1zwT4iVhjwpc7m1ndmxfHYDI2bFo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mmy3aXDrB9vq4ls7/J7wgORi/JZGHfxLAtxw7rVMLGKUc4j7cBwIA8BzoVW/an1rUhQoFVshDiFCXKJAKZxhBDAZvMg6N1FnuIdvUUbEg27RbaqAswDQX4P1qzzlAmHYi2t99OfbOmpZv1/47q9Iq3GC9/J9ImsUI16ZleED688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GYZeRuy3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GYZeRuy3"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4376c0bffc1so944711f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Feb 2026 05:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770645469; x=1771250269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aD232HJcM07JIzXMrc+K1B/ldfdtVNWLSvSBE7P0itI=;
        b=GYZeRuy3bs3956BZYcWWInLwX37zsf0NTTT9fCnk4qS1sra7/MLdKaLsj4QrhKU7d5
         D/BRTAaN3lJFkJmk2kg54OZnDrknvounQsMpBaGusJNtcX22yvTxrX1QjFrUbV67WqdH
         uVBOiQJ7sDxXq3NKD+VH1UvY6XrxsaWHfa2aLRd6EQIzAI10Yf2M6sAI2LwyMabxS0Pc
         KHNh6/84Hln5LHgVCj5NrjKVcedQpa6tLL28kEfngjNaH2lW2gyqUA12gcLnPf+DIiyM
         2fIoEg+b1W0zZrkYGPfOGi1RUmKP0sEnNglNsolHmvEfCfULz/tMw8ClC7pyHIgsBtFd
         RQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770645469; x=1771250269;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aD232HJcM07JIzXMrc+K1B/ldfdtVNWLSvSBE7P0itI=;
        b=iNAcGIOb8mGCQEblDATIoeVQnd8RkiVAqO8NXlZe+AeiIbUmS3+TRSmt00eJpghHav
         10bpxkGqLhiMMDeOhb8zj4saLgEeEMvmCQQ+/KtBo0cKGmZ1BtOAbC/HTZ8hryOucaXM
         8+uGEJ/7waIOUE9Ruw+EwUbKsHvzWIR4o9Rgz17hYCAZJDitFtpZ8pyvFandooGCEn/I
         q0UH6QSZUI7cjboT5rMdX/giOzPdbEriY+NKenaOOyG54lemuGWXMVx5a6mitJYW3TUK
         m3PhIVV0kO1OYvC9PN4ejsFSkmKRsvnuIOiErYsegM7lpUz/lgpCjBaj1znTUVhuYIhi
         yNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWobRJ2NvyOzLJ8vH98R6QB4QtYws2FSIOChiRKF6a+DJ3FKFeiNe7rGcU7WyywbQQ5VQ3uKzVe0JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIaftRvHq+7IE2QlTD5+gWz5U0MZvcP2hUWLVd1f5Rr9wEqis
	f67QS/BQMpyPKgtQrVb4fF+Js9pZfmFi5IF5FKdO+4E03sqggNxmgRSryQQUvaVQG94=
X-Gm-Gg: AZuq6aIHen//zGo+N4Swrw5sRnHAqHWV8mRxLIf/VKcTa1cp+fv2lKgLJS5lwxZ/hL3
	M1qZ4g4fDcTlCIO4fD/cEUEgTN+29LYhXaQV7e6nwh+Ku5nRNRWWuN1uJ7il1twM0oChQxWWq10
	hKNC4nun2X+joNjX3grl+R27nosjzbCNmiM1ddsXRzhzN40WuUX0+JnOTMAZt4vnVMVE7booPS9
	LUt2ewohSAbRPomU0tJzhn4Kk+vYgVqiaiVlAp27hPOBVpGvL4ece6lv8cbYN62OeouLnVounP9
	VPDpF4RWhH0EONsfVvyvvb82fN1x4VFYOQ0hcHO70pZo5UsvHAnsPzY8XVnpWPgl3ZJITRC9A5U
	1eZsRbKetlJeEBV67qqLDKKj14efCHoojwf9sN76XyxcoGOTjPnevrP53krnbbiFOjLHTrV3jbd
	kbH8xJa0Ae9xdVcXAkqRjQO6rT/gGkYPzmMni9lnmvo6kY7s0gdkpmzq5FBF2/Q24=
X-Received: by 2002:a05:6000:1ac7:b0:437:70d3:44ec with SMTP id ffacd0b85a97d-43770d346bfmr3864732f8f.43.1770645468533;
        Mon, 09 Feb 2026 05:57:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:44e3:9198:bd5d:a3f? ([2a01:e0a:106d:1080:44e3:9198:bd5d:a3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376d3a32basm10077384f8f.14.2026.02.09.05.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 05:57:48 -0800 (PST)
Message-ID: <fd446018-3006-4c59-bc92-ae3929b8d402@linaro.org>
Date: Mon, 9 Feb 2026 14:57:47 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 3/9] pci: pwrctrl: rename pci-pwrctrl-slot as generic
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-0-5b79c5d61a03@linaro.org>
 <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-3-5b79c5d61a03@linaro.org>
 <ygvljxho4dh4zlkxcropjdczbyh45sexntosz2rvxdsxigmgmi@aeqhi4qit5ct>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <ygvljxho4dh4zlkxcropjdczbyh45sexntosz2rvxdsxigmgmi@aeqhi4qit5ct>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/9/26 12:33, Manivannan Sadhasivam wrote:
> On Fri, Feb 06, 2026 at 03:50:31PM +0100, Neil Armstrong wrote:
>> The driver is pretty generic and would fit for either
>> PCI Slots or PCI devices connected to PCI ports, so rename
>> the driver and module as pci-pwrctrl-generic.
>>
>> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/pci/pwrctrl/Kconfig               | 8 ++++----
>>   drivers/pci/pwrctrl/Makefile              | 4 ++--
>>   drivers/pci/pwrctrl/{slot.c => generic.c} | 0
> 
> I was expecting the rename inside the driver too :)

Oh yeah, will do in v4

Neil

> 
> - Mani
> 
>>   3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
>> index e0f999f299bb..0a93ac4cd11b 100644
>> --- a/drivers/pci/pwrctrl/Kconfig
>> +++ b/drivers/pci/pwrctrl/Kconfig
>> @@ -11,12 +11,12 @@ config PCI_PWRCTRL_PWRSEQ
>>   	select POWER_SEQUENCING
>>   	select PCI_PWRCTRL
>>   
>> -config PCI_PWRCTRL_SLOT
>> -	tristate "PCI Power Control driver for PCI slots"
>> +config PCI_PWRCTRL_GENERIC
>> +	tristate "Generic PCI Power Control driver for PCI slots"
>>   	select PCI_PWRCTRL
>>   	help
>> -	  Say Y here to enable the PCI Power Control driver to control the power
>> -	  state of PCI slots.
>> +	  Say Y here to enable the generic PCI Power Control driver to control
>> +	  the power state of PCI slots.
>>   
>>   	  This is a generic driver that controls the power state of different
>>   	  PCI slots. The voltage regulators powering the rails of the PCI slots
>> diff --git a/drivers/pci/pwrctrl/Makefile b/drivers/pci/pwrctrl/Makefile
>> index 13b02282106c..f6bb4fb9a410 100644
>> --- a/drivers/pci/pwrctrl/Makefile
>> +++ b/drivers/pci/pwrctrl/Makefile
>> @@ -5,7 +5,7 @@ pci-pwrctrl-core-y			:= core.o
>>   
>>   obj-$(CONFIG_PCI_PWRCTRL_PWRSEQ)	+= pci-pwrctrl-pwrseq.o
>>   
>> -obj-$(CONFIG_PCI_PWRCTRL_SLOT)		+= pci-pwrctrl-slot.o
>> -pci-pwrctrl-slot-y			:= slot.o
>> +obj-$(CONFIG_PCI_PWRCTRL_GENERIC)	+= pci-pwrctrl-generic.o
>> +pci-pwrctrl-generic-y			:= generic.o
>>   
>>   obj-$(CONFIG_PCI_PWRCTRL_TC9563)	+= pci-pwrctrl-tc9563.o
>> diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/generic.c
>> similarity index 100%
>> rename from drivers/pci/pwrctrl/slot.c
>> rename to drivers/pci/pwrctrl/generic.c
>>
>> -- 
>> 2.34.1
>>
> 

