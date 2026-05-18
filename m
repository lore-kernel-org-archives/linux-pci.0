Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF3947CC79
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109002; cv=none; b=uYv+G9lbvmYMbmuN6kXCnCBvbbZ79Qq4PJq84aV8yZbKHFmJo66BbaoovV7WaEZcqExcORrT/ruMv8bn6eLJFwQ4wKcZjeN8Qu6+nynYGkhCE2uYdgbRcmPQJYo3+o7ClFH+7P0V1kjZqT7IFt4C07lwxVtaaqVBU9+IUJxkhKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109002; c=relaxed/simple;
	bh=dzIg7kNVi7MkJMwhoMoGEZ8pVxyubd9pLC0fL8/grVA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TkWql5OjsP9t+J8xUnHTBzzYaX2umf8Xx4iQqqRSiTfXE94Pzd6NRmLIlEK9b7VSKEa5EznDcv82FWKexhIqj9I5hzh9qMOHf0HXwfedQXPUNTjzYrhQ8NAE9jTVCypkktl3NQGwOLW9iSL9cVVXDDPBxeE7Q0+HZIrq7rUuaKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xMF5m3HU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xMF5m3HU"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso15733245e9.2
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 05:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779108998; x=1779713798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTzZu6PNEHK5eJaUTG9yj4SnM6fDyLlKBKNjBkf8mjE=;
        b=xMF5m3HU75h9Z2d2ZNZ+E103DgQDjdYCGfqJlHfWZSfJ5Lh0cS3QB8bUmmhTdF3feR
         +nLBwU6WKK05H37ewE8CKtH9ay02TtzHlk1SSNBhxjJFkvHLj2S4KKmNPwLyYMjaiYai
         tSvgdOvmCSmOIMLc+MoYI7MsgCmGvryNZSJkRiYvYr+ewZMcItTsCxgDQ1B/ruNlIu0U
         0eECc6km1ZcQX3jNpfCiHzxvAO9eExG9IfzYgD3t8m+U/hv7YRu6CFHlCtEwJ8Xj+tRq
         7O8iKAaVM9njgQrWbg9VXLzvF2xJ5NWndwAxzjeJwncouDJeNhaKF1MVFHNT69tS1Hcm
         RRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108998; x=1779713798;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTzZu6PNEHK5eJaUTG9yj4SnM6fDyLlKBKNjBkf8mjE=;
        b=biIYwQYtsXaaAAOdzvgJDCdRasRDKh2P6/h8mOq8+Okya0U4yUbn0WKA7jNu5Bnxy3
         WjtNQo/PYWjsWMyWQNwl3/6a82HAE8cLeueb5pFYI5+PP/qbM9xGDdbDf2rxGDEzrvzK
         CZGhodQP1x6RswXhDYhoRqXlWgnwBrSqkwhHNO9lXafU0JuRSu/mcJhzfWh5hC29zFHX
         Z1FYbT4hOLFX9Vb+usfgefBH/qhHnL+3vdtuQ0WeBnUkUU7VCeOiEQ5pZFdJGF9s7dDX
         ma5ZXEf/aQc/aIz/GFzuOenJ0BD1GC2FlVKtYSo1GYA1Z31pi5LwFGA/WDwZxiNIhtFr
         02rA==
X-Gm-Message-State: AOJu0YyBgakT0Ud72D1I3ABxTCD3A7CWJWGjxzMqvhcYUE9G8eLZTm2I
	/l0L03kRvhbYLyLLov5LKUGHDPzTyV0JjvoFHld798W2XOO9f9//wVcXGR0i0vLgnOE=
X-Gm-Gg: Acq92OEaoonvAh7GcJ4nB4/Rds6jRe2nygOk1NCqmoqmBL1IDQm6FKf3kIG9Y90Pc10
	VksumJrrpfa/e6Au2WIL8/m9+fsyBqy70Erfb03NuIxV6xO96VG021y64vLQ4dxZrD5ZAe4bbOh
	6cXesTFAXweVXcfJScrBqo7ehwARdfrmAUYznCshNDBk8m12elySXcUrYd/iMqmiqn2Xo00YQbA
	u4dRbwHGdGj9FR5If3gEcTS0nulJkCq1SFptGSY7Vc2uqGRsVWxgSSlUhf6Z3lZT4wTe2T5rD9L
	fyCCLzGk2SFygZa53vz12DIzjF3IvpPb/Lf/cnm/8dk5cPzYOPj2u7Mqigs2/QQFFed/Nrd5/Oz
	uj/nl0nhhSsH697rGAoHi//fjixF8Qdf5AAnZSULW4EKqgFoIlPnc8uOTWmrXRaW5QgyQaiiPSR
	aAVe01TpyWq+jFr+uscFbVO+30Q7u3Issp52GxreBsJB7BE8KBtkuBkktmRSqvm6OjAEoHhWj+U
	UX5iIxS4fV/ggWMyg==
X-Received: by 2002:a05:600c:34cc:b0:48e:60a3:220a with SMTP id 5b1f17b1804b1-48fe59af1cemr249848065e9.0.1779108997664;
        Mon, 18 May 2026 05:56:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250? ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c516sm276340275e9.13.2026.05.18.05.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 05:56:37 -0700 (PDT)
Message-ID: <08de1873-d2d8-4387-8521-7161ad71ee46@linaro.org>
Date: Mon, 18 May 2026 14:56:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] PCI: meson: Propagate devm_add_action_or_reset() failure
To: Shuvam Pandey <shuvampandey1@gmail.com>, Yue Wang <yue.wang@Amlogic.com>,
 "Lorenzo Pieralisi <lpieralisi@kernel.org>" <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <177909148011.9588.6639767953842842291@gmail.com>
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
In-Reply-To: <177909148011.9588.6639767953842842291@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/26 10:04, Shuvam Pandey wrote:
> meson_pcie_probe_clock() enables a clock and then registers a devres
> action to disable it during teardown. If devm_add_action_or_reset()
> fails, it runs the action immediately, disabling the clock.
> 
> The return value is currently ignored, so on that failure path
> meson_pcie_probe_clock() returns the disabled clock and probe continues.
> Return the error so the existing probe error path unwinds normally.
> 
> Fixes: 9c0ef6d34fdbf ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
> ---
>   drivers/pci/controller/dwc/pci-meson.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 0694084f612b..8d495bcc3a41 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -204,7 +204,9 @@ static inline struct clk *meson_pcie_probe_clock(struct device *dev,
>   		return ERR_PTR(ret);
>   	}
>   
> -	devm_add_action_or_reset(dev, meson_pcie_disable_clock, clk);
> +	ret = devm_add_action_or_reset(dev, meson_pcie_disable_clock, clk);
> +	if (ret)
> +		return ERR_PTR(ret);
>   
>   	return clk;
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
