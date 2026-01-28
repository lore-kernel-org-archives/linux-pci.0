Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9BA33A701
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590311; cv=none; b=uUDYo1Js2QbIg68taw1yo8B07MAC3dVp86I8b3beovqC+2+P8v4mshyu9Qh/3fJluW2DD9u9PO46WRjL4663rsLioR0Py/BPVqbPgwC5Oetg9+//7zT+3bM4cQHizxVT20mYbwY0tukq99mp1HCdjUpQQQbc0vSRkdAUJXuacWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590311; c=relaxed/simple;
	bh=X2AzdKeGMu19tO1ypR/VJC5WRPHhh7DKhZdB6XQSJHI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ae4QEMvWaMiBsFd2I1/bH5zJI/MjtrLTgXTNvlE+C0edEU3UOX/mhZ6+qpZMLhsxZvbM9hzdiyyu60U9g5qouyIhPYFzMR505mXrQujC/ueIgwUVIuUsjZH0u8xMlNBDjrJ+6lfRjpnYF5w+GpV9KsoArg8BCUL4paa5WpN/8jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t+v46eqb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+v46eqb"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee2715254so34094285e9.3
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 00:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769590306; x=1770195106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkssKX9UZLI3a5TYO9ENZYAnlkONRgQSKBvfWG/TLA4=;
        b=t+v46eqbTW5XM6obyBEMzkqYgESFckHAk/whgKXQvrxkoub0siR5k34gc8CSoCGwWk
         6vwr2IqLsIYvaZRUUwSEOv0c0vtILiQbwoddqzQwNU1gRDPgIadRC+/+GR+h4BZyg/Te
         4+yXlRsQ6kukqHeW5f1cmzCIUDDp/HPCqSUcsCR2+OX2VmM1rVF3+HlY06ojyKCaZY0N
         aoHDVPJ4AZsLUWWrqF02/sEjyFGF2PsCzi9EtAxmqFzks3krk0vXZimCUufDsr3ILJJT
         CQ+d+J3+3ApFtJO3JrVC9GLEyhDmCfS3ySkb0ud9KWQiUZrqv+z9EQu/Tzt/Umk7LudR
         OaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769590306; x=1770195106;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkssKX9UZLI3a5TYO9ENZYAnlkONRgQSKBvfWG/TLA4=;
        b=ktIr559vdex17tha1Fp+2T0prh+VZB4TTPXGRKNRNZgDLx2VUO6pDB+9b+fXMRKFzp
         8nKiEmLGwDpnuCPW7Yst6m2n0qW+4S9AiJbtiOderTNoOES6KFUvzK2lai3qU3vPajSA
         Tdq6tb/iMeoc6mPNSC2B9fTiIdUo1fQ9nkJvnfbHmzDVTX6jq8UcLLp5YzE1TWBjb3E3
         YXGsT1NS4RPDz+BvNdR9MHCZrA0XPZUiwssib4R0MS4Q1HX0MK2Uf+hB/kWo2dAB/NVt
         Bwp5izVjY6QGPolF+4uoo5FDUEakS0SO9lNtccnsDOInG6hZfyOXM1jQTo5ngA+8vLlv
         M/zA==
X-Forwarded-Encrypted: i=1; AJvYcCWa8xmaZQApMCOSvfWmhSdTdTXXtx3QcpDfI+J8UCC9Sz+3VsmAHkwy9W8tw8fQYFKZB+qOrUB3QUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrhLCeOeBk6YDzRax5HYPAOTqOK+2hR/i/ReTWhsUcLJ8DEJIQ
	HwaiM0lWplJP1Pom2rlJ5DpOjzmrCNNNBwdb0qf781QZuXBnJebHLiaiIaIYrtQ2Qzw=
X-Gm-Gg: AZuq6aIYqzdl13LG4PvJAs4qyEe46ubS2d2IMvykrmRIaF9Ry+8k1PwLoWSh4jQoLVC
	+MsQEQ/ygnSYUsDPOND0rrau46SyX5cY3wUj9foWRPGZoK7+MgJj5LUTWkR6aNuZ0/5KhwtqcBD
	50a20rTwb7pnC5cOX7QB538y42/QF1eVIotiKKf5Y2rwpNLMcpTLqc1u9HBnce3hmElr4o//aMn
	HwZlzqEEdyEJsBXdUY3G4MbMHBVtVNyaI+1sFJMjcTVUkZb79pcBFXT26vmZXXLDj5IoTTj0/4F
	XCSzjhjCsuk7FVLQoOJtT2kh+rbtaHw2BlITD0YqqdfAmuQVQS38Y3FBfVlKdkHY4kqirQWndXh
	S8DbjktRImKcJQUWYR+yC08JlCT2g7egPZydhCWzjZ4DX4xa9ruUEn9EgHStV017pdpMwqscO6f
	LXg5Yixf7Y+CRQVyzcxQak4jnL17+a0CqgTq3COU5A2nz5r5xXXHsbQP6vECeoRL0=
X-Received: by 2002:a05:600c:4592:b0:477:1af2:f40a with SMTP id 5b1f17b1804b1-48069c5b97cmr56776605e9.17.1769590305903;
        Wed, 28 Jan 2026 00:51:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:7745:d752:5f0b:2b68? ([2a01:e0a:3d9:2080:7745:d752:5f0b:2b68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffe9sm66744915e9.4.2026.01.28.00.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 00:51:45 -0800 (PST)
Message-ID: <c3b678ea-fca2-47ff-bc39-72ad498c8641@linaro.org>
Date: Wed, 28 Jan 2026 09:51:44 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/7] pci: pwrctrl: add PCI pwrctrl driver for the
 UPD720201/UPD720202 USB 3.0 xHCI Host Controller
To: Manivannan Sadhasivam <mani@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
 Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-0-c55ec1b5d8bf@linaro.org>
 <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-2-c55ec1b5d8bf@linaro.org>
 <llbnkm72mgcsrucnp7pdkwbgyzenvhe4kudxkdixplgaoirdem@3q3me34o5drf>
 <0104896e-44d0-485a-a44e-694864c819b7@linaro.org>
 <33bbb3ec-5659-4d50-a5ff-dafa44e291dd@rock-chips.com>
 <ppe6w2h32vx2jh73bcv7ip7ubr2wgwjsz4ooruplpx7gx5s4rv@qfasjbocku4r>
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
In-Reply-To: <ppe6w2h32vx2jh73bcv7ip7ubr2wgwjsz4ooruplpx7gx5s4rv@qfasjbocku4r>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/28/26 08:57, Manivannan Sadhasivam wrote:
> On Wed, Jan 28, 2026 at 02:22:50PM +0800, Shawn Lin wrote:
>> 在 2026/01/28 星期三 5:53, Neil Armstrong 写道:
>>> On 1/27/26 16:53, Manivannan Sadhasivam wrote:
>>>> On Tue, Jan 27, 2026 at 10:57:29AM +0100, Neil Armstrong wrote:
>>>>> Add support fo the Renesas UPD720201/UPD720202 USB 3.0 xHCI Host
>>>>> Controller
>>>>> power control which connects over PCIe and requires specific
>>>>> power supplies
>>>>> to start up.
>>>>>
>>>>
>>>> This driver only handles the supplies. So why can't you use the existing
>>>> pwrctrl-slot driver as a fallback?
>>>
>>> It would fit with no change, but the name "slot" doesn't match the goal
>>> here,
>>> it's not a slot at all, it's an actual pcie IC.
>>>
>>
>> How about renaming slot.cto something like pci-pwrctrl-simple.c, especially
>> if most power sequences fit into this category? This would follow the naming
>> example seen in other subsystems, such as drivers/mmc/core/pwrseq_simple.c.
>>
> 
> Yes. There is no point in duplicating the drivers just for a different name.
> Slot driver is relatively new. So I don't think there would be issues in
> renaming the module name.
> 
> I'd prefer for 'pci-pwrctrl-generic.ko' for module name and 'generic.c' for
> driver name.

Will do

Thanks,
Neil

> 
> - Mani
> 

