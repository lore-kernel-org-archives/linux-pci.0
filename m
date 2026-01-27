Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D304B36074A
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524928; cv=none; b=VRp/ZS1CDiiZXMoxFt7aCdQxO9C/cWGxYxMtYqBYYA8w9maVA0M3yYFpNAzs3nprj8eYD0T5+6efWlS4qr9efgV1grDNr+P9LabuHbQrWu/uCJyvVtR9jh1NXq59EesVAvkKFbqJiXiKK+6BvGmWNsvHru3DgHi3Wkd9o1bO4yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524928; c=relaxed/simple;
	bh=1CaflWjkNhcQDANOir4hWMeC+w06SKx7wZJtD8EFIbE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WqS8nUJwKXfMR+5DtvMMYQLXK6iM6rk7RUNw52nDyDdM7w+lM+xljFpkZszfnoMxHCM3JusdNXuzrU2v7zifoCexh3A33XTZxKRxJfPcsqcDZz4K4W62mR0ILVjIolIiyuBlAXtERvxCDGbI0oLk9kfXRB/gmQ3Vjqr+nxkS1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PHukeZO1; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHukeZO1"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so45058335e9.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 06:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769524924; x=1770129724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljVMpWRKvY2+1qzoFSak0+AlpoDAqSEsFhtFylZkNe0=;
        b=PHukeZO1WoDCeoTJrWV4I6B/BObVkQT9MR22i9od8OD0fh2mrMrrTv0wQhmcZbqpfO
         52OwUVQluRkampP8I59oJYWZP2gcnp4hM6B21TBoA5GQTeYZXLCdcMLOnqIJ4jzpaVD0
         iA2fT4AQhA4g79+pEMFlPRZZZXLNDk8HB+TfrWXLJbKBVoDPdr/dMOZakT5GEBZxS6gS
         DsmdxGYngBNViZ1+Lhm17nwoBndjzT2xj6zUYeGj0aVVnfLPpIXyWeNdOHSwfU5EePIT
         xzOjCrLKJOUmH3pah9e0NnPZGZn+zhkA6kSpy5dNfyEI4+eNIcmr1KAIYUBvFBl7MxV/
         Bong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769524924; x=1770129724;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljVMpWRKvY2+1qzoFSak0+AlpoDAqSEsFhtFylZkNe0=;
        b=W78TyQb57qvrwbkGX4Psth9RA6RZFBIck2enaIa1mWYebMdUjxZmcs8Turxl70pXWO
         0HCeQQ8Y6ZtP35wQTs2h+YUvXyY/TM6ar7CtVDIRomyqWE0dz6KIxoEgDnv8hb7Fgx4t
         ozSCZumTCReHsAzBCs2juuzfbWW0vkX+B5q4bhXAWY+C0HgRlidBDEogjzRYaJCNd8KS
         3SxajQLivUiPFvL/IA5Muilf6pHLvGDXpgZcX/Igef1WRvsd0M+FVzD9i3jpNoNXJKSH
         lRsI6rH1d/VBm5H/VzNhn7t9Xf+bViUXGXcNZObpsTvcSJpBJ0SeE3vOURcgamkzELjv
         zV4w==
X-Forwarded-Encrypted: i=1; AJvYcCVTBXmM+pBBowx++atCG6kXXhWRuPu3LhcCmiQd6fgAJZBZUJh95GKwnvPvOuHcEoxrnNdKvcy51Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVC8TsX8g8FUdniCgfkL7HGLR4vk57c7T4Y2V63Di+6sxbLle4
	6UniEPLQJITKcq19DQb0pVw/yr0HpqHpVXyMr7YdaiNz9BLkDFZIr5Lwfv10bt7pTmo=
X-Gm-Gg: AZuq6aIxiQtaogwJkWcPhoFqr0A1UVUnqJNXlTyzdaAKESVRky8rEitCYJr5xTq0JXt
	FFZ7O2/JciCtd9hG9reJDV654MUof/9WsFy91+rKH7L9evJ9H7q58/i896rB9zvpoaV4i/CkCQN
	OHtOGjLl7LeRRs/lX9AylvE0sHO55yIvEgYdjzZPMFgYDZPYed9TX0eKtzwDoUZiqzpbVxj+FGf
	OSndFLLi/JMDq0TM+7mT+s2KClTg91dKi4wsv9kBhOhlIkpX4/SVGEn6JMfOxcuDBdvUDKKDmAF
	dMykF54FssqbdPgOeOx62BGwWtNnjnULv+dz/gGJkKfr2+XPnRxYaPy0PeuS8f6/YfmK2Suv4TO
	4yJXFoQDXJK0UvH67igLiEdB9ZeJf1Esv076y5i9m0JwmrczHe2AdBfvsESsTBMqdSOiSuUPAb/
	kRo6YBWLIR78FuqqhA68isNx31Wggk2+vijYLxrEOM9T1inTV1hZ1s7v2MiyInmPQ=
X-Received: by 2002:a05:600c:8b16:b0:480:1a9a:e571 with SMTP id 5b1f17b1804b1-48069c8c109mr22743065e9.22.1769524924086;
        Tue, 27 Jan 2026 06:42:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:53a6:bd3c:8e65:509d? ([2a01:e0a:3d9:2080:53a6:bd3c:8e65:509d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c4f3edsm63317125e9.15.2026.01.27.06.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 06:42:03 -0800 (PST)
Message-ID: <d66687d5-cd11-47ae-9f6b-090feaf8761a@linaro.org>
Date: Tue, 27 Jan 2026 15:42:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 4/7] dt-binding: vendor-prefixes: document the Ayaneo
 brand
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-0-c55ec1b5d8bf@linaro.org>
 <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-4-c55ec1b5d8bf@linaro.org>
 <20260127142729.GA1622953-robh@kernel.org>
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
In-Reply-To: <20260127142729.GA1622953-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/26 15:27, Rob Herring wrote:
> On Tue, Jan 27, 2026 at 10:57:31AM +0100, Neil Armstrong wrote:
>> Document the Ayaneo from the Anyun Intelligent Technology
>> (Hong Kong) Co., Ltd company.
>> Website: https://www.ayaneo.com/product/ayaneobrand.html
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> index c7591b2aec2a..1f83979e0d09 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -216,6 +216,8 @@ patternProperties:
>>     "^axiado,.*":
>>       description: Axiado Corporation
>>     "^axis,.*":
>> +    description: Anyun Intelligent Technology (Hong Kong) Co., Ltd
>> +  "^ayaneo,.*":
>>       description: Axis Communications AB
> 
> description is in the wrong place. Bad rebase?

Ok wow thanks I just missed it, somehow it looks good for me...

Neil

> 
>>     "^azoteq,.*":
>>       description: Azoteq (Pty) Ltd
>>
>> -- 
>> 2.34.1
>>

