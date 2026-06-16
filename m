Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825331A567
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 07:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593866; cv=none; b=NAz+4YA/YIS5rLqiXrmAnjJiG4gZPsPxryw9nyeKrZSjgzYnj+gXWpRSsFq/DEoLsuL4Sed/dBhEFOhuJ3xL9JpeXM04gZPTutyCuGg3KYuaMXy8FDQKljhvPfYN3ae3N02VnRUE4X0vIw+DTlic8K9pvPT9ELbLRrqeSkKrAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593866; c=relaxed/simple;
	bh=qaHJN2aQLHRWAFjIYzho9gDPhGnbVfWkmdf36loSm2c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nxphZ9q83l4DLEUirehzadGJ3K2UtTfNDwd8Gjg/WeE+BU75DEw0iPooRY7LXSX5bppK9nGPTV3SoqUpagivUzDfRxj0rqTjHU5VG/aviBPjQKspfJBAsQoHW+0QVjtFblIhgsbofdVOfP6J/q2E86QEmxxbxqSHIOe+yNfe+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n8Q2NrKT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n8Q2NrKT"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so3286082f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 00:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781593862; x=1782198662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpWtGQUMO6w+AqepPhMZrIYR/+GHp+ISWGwYizWvLWs=;
        b=n8Q2NrKTPkdmPmRZxqq0V5fZVZMaRcaEu+qldpJ6wOSf8c4lyJS2bmspWq0mKu5ow0
         WXpX8DiVMNFSbxUsxy1gRJyu3ft8ldeGWjdG6VJtDrXtHdL95Kb5l7ta+m5DXXEL+Joo
         z4u789CGTPF/TMwB84BnplRcY5MRWkaJFyYR1KqsCacpSexdPy6XBX5Huy5O/yLUUtik
         G2Sxl29aBdkUFMxHOKniqvQUIerjtTVLQPmNhrrLql+5dK7GqSvSR0NFcV/DDSK8NnJ1
         sD+JyziI45lad9ax+7mIAW7vH1zdhemQoH72Ks0da9KaotwTryh1uZEwzEcxkml1ZAVy
         IEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781593862; x=1782198662;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpWtGQUMO6w+AqepPhMZrIYR/+GHp+ISWGwYizWvLWs=;
        b=CnioSNYghURZ34FamYx2tQiy1JPCuMHrvog0SkSSUs7tKgcIED0ucw2esnT8Zjl6Dp
         qjprxKPnflA71Lj+z0pye6NSuTQljoyMkn2m8jxHsO2IT1avqg7hWzNcoVQyvED+Efcu
         /qq/GvR9xbusOidILEeTPQiMAFATob9IvQwl/xT3unhxqaMEpR03qnKd9zqbFmW5x4cq
         tTDjoM2D27PeynO+0QEm4G+4UzKrWzIxTM0LuylYbIgEnEAmBnOPAZv/FYVN39W1ObY7
         GqDKlaPPXewdPkvBfme4UsZb8gK42QEPj0TWHfVw/h0tPIXVNePRkEYJTyc02w1eoke/
         77mA==
X-Gm-Message-State: AOJu0YxlrAYj1LG1GC/DgbprvW9zUdJMBPqDgfVLWr863l8X3uKXZCxH
	1uKelggi6YXVl7t3eIDLj1e7hJk1WCFPSFFWjQu0pbfcoPiNqK6kWeXSWDLnIGBMyBY=
X-Gm-Gg: Acq92OGnia+I+OUij80EuNGTJlHwt+xD21v35+iBcGuo1FyRU6gCQ1vTvR0/Y4i4pS8
	JcB1+uZkIdT05Cz1i3taQQ1ZVhZ3+OHbURVurnRKQIuepyjTX5wY/ayRntXGommdoxHkOym7tPy
	qR8VCmkwxdNbx9uQlDUIN6a7GIRMnsTHaWI6LkganekAFOx5Gp1WpCOzY31lZcdaY7YrqwnCR8M
	Pn/ATfMJaIINe4CdUms7XPpnCEKCAhpp2Kg9IcD/iv2cpcIkY83oJhik+3Bb6lJ+4lGED6pcux2
	boj0hLTtUdGy7KKw4UVDHxdEKD5B5nVFgnjp/2M3aAoIDMD3ewUPq1xCsTzZSZTj7CLu6qW78a5
	I+AO9JdAKWt8uQaFAFGKwevuqTNpLbn74SCMWcVFVR9CRaRkCvfqU/6FHhEquyZLeRLjDB6H8Ue
	bAkEnwdpJ7qVtFbNl/Tzr8BCYxVUUscA==
X-Received: by 2002:a5d:5d01:0:b0:45e:ec18:f20a with SMTP id ffacd0b85a97d-4606dbeff08mr26112789f8f.32.1781593861537;
        Tue, 16 Jun 2026 00:11:01 -0700 (PDT)
Received: from [10.3.4.22] ([212.133.41.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c4240sm38392203f8f.27.2026.06.16.00.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 00:11:01 -0700 (PDT)
Message-ID: <870a2721-5fad-42fc-b8f7-40a87d5a277e@linaro.org>
Date: Tue, 16 Jun 2026 09:10:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] PCI: dwc: meson: Fix reset GPIO initial state
To: linux-kernel-dev@aliel.fr, Yue Wang <yue.wang@Amlogic.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Remi Pommarel <repk@triplefau.lt>
Cc: linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260616-fix-meson-pcie-reset-gpio-v1-1-fca404b4c8be@aliel.fr>
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
In-Reply-To: <20260616-fix-meson-pcie-reset-gpio-v1-1-fca404b4c8be@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/26 09:07, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Commit 4d3186a525b3 ("PCI: amlogic: Fix reset assertion via gpio
> descriptor") inverted the reset assertion logic to use proper gpio
> descriptor semantics, and moved the polarity configuration to the
> device tree as GPIO_ACTIVE_LOW. However, the initial GPIO state
> "GPIOD_OUT_LOW" was not updated accordingly.
> 
> Change GPIOD_OUT_LOW to GPIOD_OUT_HIGH to get the right behaviour.
> 
> With GPIOD_OUT_LOW:
> 
>      ahci 0000:01:00.0: enabling device (0000 -> 0002)
>      ahci 0000:01:00.0: SSS flag set, parallel bus scan disabled
>      ahci 0000:01:00.0: Controller reset failed (0xffffffff)
>      ahci 0000:01:00.0: probe with driver ahci failed with error -5
> 
> With this fix:
> 
>      ahci 0000:01:00.0: enabling device (0000 -> 0002)
>      ahci 0000:01:00.0: AHCI vers 0001.0300, 32 command slots, 6 Gbps,
>                         SATA mode
>      ahci 0000:01:00.0: 1/1 ports implemented (port mask 0x1)
>      ahci 0000:01:00.0: flags: 64bit ncq led clo only pio ccc
> 
> Fixes: 4d3186a525b3 ("PCI: amlogic: Fix reset assertion via gpio descriptor")
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   drivers/pci/controller/dwc/pci-meson.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 0694084f612b7..15ed59b8764fb 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -400,7 +400,7 @@ static int meson_pcie_probe(struct platform_device *pdev)
>   		return PTR_ERR(mp->phy);
>   	}
>   
> -	mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>   	if (IS_ERR(mp->reset_gpio)) {
>   		dev_err(dev, "get reset gpio failed\n");
>   		return PTR_ERR(mp->reset_gpio);
> 
> ---
> base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
> change-id: 20260616-fix-meson-pcie-reset-gpio-2b9e188668c5
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
