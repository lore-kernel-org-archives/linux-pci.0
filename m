Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B08332ECF
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342815; cv=none; b=DLr7Q2122fEqqfy1HzMBLNtEDe7lf9CuRtpg+XfGSo0EmosD+PVIudY5dMsgd+qsZVTZrp3tEOVkIn/CBtqUoNnHv2PdHNWclKeMhFvPox0TnusUVST88YWMauQoNKUZO+jzjcnqgf6IVeKLYjeNgh+igSmduUlnL6HacFtKyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342815; c=relaxed/simple;
	bh=s70PzdSc3Ao+4XNUlHdv9TJh2ewm61rZ/huM10n9mVQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XmMVn0fR3wc2HYTM4z2pp2sT5CN1rwsVh3T3hxwYCiQ3/Rxps1LtR2B1KuFvhDFj3L/EcslNmg2rRFHl8hBvcF+z4CYEo/rvGhnfUNhRBe/NrZisxRCi7ZcQxdz1Ft0xNn5zWl31P9ntgZ7l7K5sS/lHlh3+4enUSzXEFRTt/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JmmoOooQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JmmoOooQ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43638a33157so4220557f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 07:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771342812; x=1771947612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppRI04Iu3sbbEiHUrACiv+HFyJ+09EOEv1pAadTo60c=;
        b=JmmoOooQGFcPVsjOJ+lx/igi/h3lwi+mIJc5UHRTdtzjegU42q0wpLRc5NG2v5BtLp
         s9Om3CyMqdzmTWdoQ2YzGQ4MonexPosH9jovS1MIEunQ6VURad09lZr8lJ6VQ+/W4h0S
         cl9P9SEp8DyxSHyzk5ZHtNp+MLWqRqKnKS5X4rBr+N+AHabEIdPi630VaAJcsbNWvomn
         Tqb+h/BbjaLvOYP0mOMPe3ZWmWrhQyDI7Gbd4r0s2tcldRJ59jH5NrbpthOBXHk8am0S
         UPtTuNvy9ds307HeIojY6dLmBlgO/fMnHQTmWp1U/+ZYfOysxPPy2BLF3c1tu499mZN/
         UWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771342812; x=1771947612;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppRI04Iu3sbbEiHUrACiv+HFyJ+09EOEv1pAadTo60c=;
        b=ensEdlce67yfnPVGQsh/Du44YgDYnOhwF4UAPJB3ZoLMCDBMGSpGHDGe7LATJhE8Kt
         dhJNQZjyYy+8LyeNix9ct/vxZxqIE3nvG+bjf3dFRH/x5mKXm11+YEo6MPLKbUBH2lT/
         IGlWNBdn7O71pejss0FC5sOfSZsvLeBgkOhtQqHk420TUvTCgZZeGUb1NaIBQY9O4XHd
         xTP+51LjmMzH3+CMwsGgLKF+ctoEfrarY86PECVjT0nbKqPVfN3gxNV6U0reHM3VO7PU
         WBSFAkNsycdP6LdIjbt6/YM5KJZazAhD66JeiQO23w7pFvWxtRG+5T2EUd1N4J5pmezw
         qz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVapMtWTqc4l2xa2/bogTVSz+bHaUeCKsQSU+DZxcQxYVF6siP6qjryU2jbe8gCkKY7kHuILIbLrkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsOOwAyP8PuebAB0CFd3GL2Ewx3RxBtfg3fnQkh8b8bWa/bEbc
	LG0JDyl2IeEBw/Y2ugFu74TGTPk6JPd61ug3ctxIVLtqx8ZtsUyoap8xQkd0aw5RWQ8=
X-Gm-Gg: AZuq6aIGliI6K6wlj43YHaKX4zECpLI3d8rYWO+hDkoif9WVadi4nEyH+PMkbOme92I
	QMhmSIEo3DWsfYiYltjeLuLTigXZXmHf+tZK7z4FnTvOZCuNgJ/Hg7LkEdIrMvQfuWx/U50vp7+
	VOa93ourRatanfLFdCkaZXy8GMYiWbp4NX1sbehd7bdAS+n4vxhKqLPzdE/eK5QAZSmLl22vNYU
	4jc2LaWIOV1fV5ovpKvZt+Dw2WLyCbW1rq8VGdCIIvJ+LlUHBP/p5YZhZfKFuv7+bAM5e+g1e/k
	ArrRl0Iuu8JIMTbxiNEnivyKET1Oh8pBAieDjsexUbwDhfKnCZSMyvuskbNm4Hr2QJOUuOMPS+O
	bvqp4IwgtWO/A+7kNBWlaYTMuHOHR5LH/qgF/ly0VHTsAMT1TLxLhI2Gtxd+S2TVa6sA3jK5HmZ
	QcXVaJ5DUFEwJJQI4lNS0haYFRphvnmwO4vCMprQ1y2hc/7DICAPF7my+pNII1tmOatRLkL9K4F
	fSySg==
X-Received: by 2002:a5d:5d11:0:b0:436:34e8:e665 with SMTP id ffacd0b85a97d-43797943442mr28768881f8f.54.1771342811730;
        Tue, 17 Feb 2026 07:40:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:72a2:f5f2:e023:2a2e? ([2a01:e0a:106d:1080:72a2:f5f2:e023:2a2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad009bsm34212046f8f.39.2026.02.17.07.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 07:40:11 -0800 (PST)
Message-ID: <66da94f1-7016-4fe6-bab0-693b55adc05d@linaro.org>
Date: Tue, 17 Feb 2026 16:40:10 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] PCI: dwc: Proceed with system suspend even if the
 endpoint doesn't respond with PME_TO_Ack message
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260217113142.9140-1-manivannan.sadhasivam@oss.qualcomm.com>
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
In-Reply-To: <20260217113142.9140-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/26 12:31, Manivannan Sadhasivam wrote:
> PCIe spec r7.0, sec 5.3.3.2.1, recommends proceeding with L2/L3 sequence
> even if one or devices do not respond with PME_TO_Ack message after 10ms
> timeout.
> 
> So just print a warning if the timeout happens and proceed with the system
> suspend.
> 
> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> 
> Changes in v2:
> 
> * Added 'ret = 0' to avoid failing callers
> 
>   drivers/pci/controller/dwc/pcie-designware-host.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 6ae6189e9b8a..ba183fc3e77c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1256,9 +1256,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>   				PCIE_PME_TO_L2_TIMEOUT_US/10,
>   				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
>   	if (ret) {
> -		/* Only log message when LTSSM isn't in DETECT or POLL */
> -		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -		return ret;
> +		/*
> +		 * Failure is non-fatal since spec r7.0, sec 5.3.3.2.1,
> +		 * recommends proceeding with L2/L3 sequence even if one or more
> +		 * devices do not respond with PME_TO_Ack after 10ms timeout.
> +		 */
> +		dev_warn(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +		ret = 0;
>   	}
>   
>   	/*

Allows ath12k to go ind3cold with [1]:

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

[1] https://lore.kernel.org/all/20260217-d3cold-v2-0-89b322864043@oss.qualcomm.com/
