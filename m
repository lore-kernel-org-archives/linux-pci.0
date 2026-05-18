Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FAD478E3A
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108994; cv=none; b=fkOGvXi8K/oovoPS9DBZQAHO4lzyilsACwMU+4d4MN+zKqcnt5GAr2//m7XrGKy90pRSxJGrKOybuwieHY1JHVqW7KrkmmatPU1qNIOZJIb/z2nmua0APs4OLsDiS5pKlc2mUB/DAY9wR1pgnXF4pDw5PI7EmJfTZmgu5CqZ0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108994; c=relaxed/simple;
	bh=kco9FgaHAutdRiTPkddUHa9bLHZ0mO6w8WIhDAQ6930=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QcczNyRnTfIG9MNoYxzs7beofEK0FKZk0TklQ+gEjTYpfz/osnwqgeSA3zwiv5GY+p4aMRA+RTCgDWHpejyXgVp/oaTQIh3ulOWYCeyYo0pKcg28V1uoZRdQ8A601lfN1XBZmDM+yXYnguQX4F5XY3gOox8PXs0MLU5v1Jn/U7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YWvpbK4c; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YWvpbK4c"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d77f6092eso1164197f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 05:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779108991; x=1779713791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wG5JigRzl+8hFDlaIdzHX8LNfceobFw3oJ/CoEjhnh4=;
        b=YWvpbK4ctR/tjezU8WDv++zsPtkmnAKG+/b1TNZIaAhuwemh1ZWabyRz8xY1mJ44Jp
         dla290t4cRYfiuxf9woSIjyxfBl0Ef1JBP/PaiO5p1sC/e1F+IbXOyM9JoJdzJmWKh+t
         zyVbKe0L9R4fxXqypwxYKdVNp8WoJXzS4T5dhucZf37OPmripz/BLXshXkVCLhbP4fg+
         BJ7BDgjJCNP6MPeiqy22kLWI8AoY7eAG9VtYnfkbsNHHxIZWYYS8mgCu4evsbHyHNPCW
         SAh4eyFKVsBE3KqPzP23/KY7Q5ohEXsglQ7V6Wa+ULLXMBp5Ucg8di5oXrgXj/z/Lb0a
         zLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108991; x=1779713791;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wG5JigRzl+8hFDlaIdzHX8LNfceobFw3oJ/CoEjhnh4=;
        b=USAez3nSYcpGA5tnGzy+WtL1PT0U/Ukkw6cgQFSrkPLCZjUDiELvXMc33iYubiOr+0
         VirUZv1Etc2QVxvxwUEbKuOP3aQ/jiLC2AJGEhKjD161l20KocmUjrSnrGwkXak+1dIa
         hR0LQ6ZGsPuLppjaucIX4FlGSIXCjxKHk9BpNkanDrd4wCW+HcasCaRvai/dOHBarPZ9
         UwG05K1tEr0CydumsO/S4NDRZ6Q8O0RprLi5/afDrdxUrNv26pGufWVPK3iCZ6ylSRCy
         l+q/ePcWmnH+fPhGk1JsA9Wp1KLC5oW8sil3sAZDbZGODlQXiIuT6OSLlJrMIIHIDN2d
         YHLg==
X-Forwarded-Encrypted: i=1; AFNElJ+032PAFZrbRyA+Y6Hi+vOXthVrqlasuGW1g9DF4H5nlGdniqMS58+actupVRPgQ8jcZdS2xJl3Xxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp45eToPSir2oZjcTDFPuVCP1ILoqNU/Um9qAwMmTWBqCI7Eux
	CEwIfjuUzwbk1DfZgz97TWjdNKQjL9EnTipdm0jBceMxUZtsHgL+FmUhSQifxezz2Ao=
X-Gm-Gg: Acq92OH04Q3GTdjkVCPjUNXLz0xMViPN+PKKAPk9YjXX4cPfHAuO/JJcaU08jQVZuOq
	xE/vwytvnHVUsjWlG9LYbDSqxI2regLOgAu3ky2eZBj5JYFiT56VgEPnX8eKp10kuPObHsbqN/g
	TPGkFBR9HA8FNaBSZlfwHzAWlnHXGjyzAhnMpWFEGKTMqQCkMeZv86RYPNbc6xKDHWbe8lHHhpT
	FBj7xC1R3JlvLnO3x9EySsAcroj1pIT7xwFXDvn4+UVx3b98ktJh5x+LGBB5FXkuib1511x4Snc
	cHoC2Lwz5RSGMAb8vmCiYzg0RTZUdEXE9q8dJ937mm5v1NIlu8ywDBOT8STywDmhQcKMULysOwJ
	b5GeuKpnFwXb3cJ/Qvrd3svBM9kq5A9BbXetVde6SsPpxjewkaVRJqHddnC5zXQy9iET0Ix5jlq
	aaC+d98lUcLN6faJ59SqCH1RM8h0dJclO4xwLbMAMwEEENWHhoF/yZLVIJo601YeKkiWJl9zyrG
	aUzqM0=
X-Received: by 2002:a05:6000:603:b0:45d:3aa3:7f76 with SMTP id ffacd0b85a97d-45e5c5ebd5amr24498434f8f.33.1779108990553;
        Mon, 18 May 2026 05:56:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250? ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1aeafsm38940230f8f.23.2026.05.18.05.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 05:56:30 -0700 (PDT)
Message-ID: <940d7714-4303-4e82-a006-3066d2165844@linaro.org>
Date: Mon, 18 May 2026 14:56:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] PCI: meson: Propagate devm_add_action_or_reset() failure
To: sashiko-reviews@lists.linux.dev, Shuvam Pandey <shuvampandey1@gmail.com>
Cc: linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org
References: <177909148011.9588.6639767953842842291@gmail.com>
 <20260518082022.F4229C2BCB7@smtp.kernel.org>
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
In-Reply-To: <20260518082022.F4229C2BCB7@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/26 10:20, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing `.remove` callback or `.suppress_bind_attrs = true` leaves PCI subsystem and PHY active after driver unbind.
> --
> 
> commit fde9e1cd9d05730f72b074fa8edf3a1233d11384
> Author: Shuvam Pandey <shuvampandey1@gmail.com>
> 
> PCI: meson: Propagate devm_add_action_or_reset() failure
> 
> This commit updates meson_pcie_probe_clock() to check the return value
> of devm_add_action_or_reset(). If it fails, the error is returned so
> that the probe error path can unwind normally.
> 
>> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
>> index 0694084f612b7..8d495bcc3a41a 100644
>> --- a/drivers/pci/controller/dwc/pci-meson.c
>> +++ b/drivers/pci/controller/dwc/pci-meson.c
>> @@ -204,7 +204,9 @@ static inline struct clk *meson_pcie_probe_clock(struct device *dev,
>>   		return ERR_PTR(ret);
>>   	}
>>   
>> -	devm_add_action_or_reset(dev, meson_pcie_disable_clock, clk);
>> +	ret = devm_add_action_or_reset(dev, meson_pcie_disable_clock, clk);
>> +	if (ret)
>> +		return ERR_PTR(ret);
> 
> This isn't a bug introduced by this patch, but could this driver be unbound
> via sysfs, triggering a use-after-free?
> 
> The meson_pcie_probe() function registers the PCI host controller via
> dw_pcie_host_init(&pci->pp) and powers on the PHY via meson_pcie_power_on().
> 
> However, the driver does not implement a .remove callback to call
> dw_pcie_host_deinit() and meson_pcie_power_off(), nor does it set
> .suppress_bind_attrs = true in its platform_driver struct.
> 
> If the driver is unbound via /sys/bus/platform/drivers/meson-pcie/unbind,
> the device core will trigger devres cleanup. This frees the mp structure,
> unmaps IO memory, disables clocks, and releases resets.
> 
> Because the PCI subsystem is never explicitly unregistered via
> dw_pcie_host_deinit(), the PCI core retains references to the destroyed root
> bus and freed structures.
> 
> Can a subsequent access by the PCI subsystem or userspace cause a
> use-after-free and system crash?

This probably a bug to fix, but totally unrelated to this change

> 
> Additionally, the PHY is left permanently powered on without its required
> clocks. Should the driver either implement a proper teardown in a .remove
> hook or prevent unbinding by setting .suppress_bind_attrs = true?
> 
>>   
>>   	return clk;
>>   }
> 

