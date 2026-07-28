Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1213CBE7C
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243497; cv=none; b=PTatEgZiVwJvSLQl+gPW7SoJharYgFnvZDITE2E7D5xCQavq/qZ/XdvnZi+lX/F04fmjZ5O92Htekb5gFywcHvhJj90nYlrb7ROpQeurBLJwiM0lWoSe0l54l/qRoTAFpUUAQSBbyRzG4sFcrJfhVfXsSKL3/35ysWHyDlbn5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243497; c=relaxed/simple;
	bh=tGxFwd4Yde0qH9xNAfdWNzz5M/Wc1+ewUYouZUkWJP8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tsUL4zl3AClOvOuVb0LTkpxRIY7UnwCEjHEjc3IVzNCX9UF1pNw8LWK80/wEllaqbQcXwHgk56gdd7BVQB3MTu2J/KN7s7EukQ+0Go2Reevje/kHA7PILnWDywUJDJaiALLxcETE3Bq5BOMG3oGIV6Ei0FRI1iJY61Q0fZbQQ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RZ6cO+oT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZ6cO+oT"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4955de8797cso24503655e9.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 05:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785243494; x=1785848294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hC8sRjnafAE4kvTJxwUbBr2JgmCMzJbZTFX3udFXll0=;
        b=RZ6cO+oTfFFNZbbXqYn9goJyDh0MqTxXP9PhoV/cvlca0CoHHULwO3jTMQzhoecyiK
         XWD+Arjtn80Xcls4JUOFkDAT0hCDDKYZY4rKzHHeuf0adUeGeN9tSvhbFC0+koXfhPay
         Wt76n0ULCMpDeYb3C+qSBaOQI+pH0oXYuDHCKMs3sAmF4pnzCnaqccQrk7KFPTCnNhAp
         ocirvuu9GrtVEG/f73ja1k3E7gMA0177nnG6hfkMP8ooGJBTYmG4ykH5DkSm8S6jHJdA
         e1SK9le2xtsokDNtPVLTGOPh9V3ObiiYa0rRC+zpF3Nelnw6AGDGHk+rdfv9zVO+A6NO
         i+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243494; x=1785848294;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hC8sRjnafAE4kvTJxwUbBr2JgmCMzJbZTFX3udFXll0=;
        b=gkvtWJoj0+w3BtJlsIN2YsLN3RCwff+dpc4I1FgIWhJt+vsf3su8nT8UgMzCvQhqqL
         cGwukEuPMzKcd+usgHhHdKvAn1xoLn+slfLVZPsOTYnEEbD19khVB1sQ7wnxZlrq1bLc
         jI68D6s4Tx0UH28ENtqLla3jfQbCQRCRrJhnY6XmB9UXr0P7rqo9Uk98qTLDKUTTtgpm
         ChV01qPU/KR68XGU/QhIWKOVQFB6iWw+SUK35t65SYYZ+M2y4e6dwSZllVTZ2bbpaEC2
         4EhQEuNzsOr8yVzdYGAmmw/TCkl1oWTCXMaqKHzAcTIHJagEC+7zL6xVYGMxaCMR4qln
         oxAQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXG8teANeoJCnYOSE7yG/Mlok0Wgg/E1mhvL4mkSJJxsVpmiLWYXzRb5CYgsFG60es18BYgrxoDUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Yy8DR8YaggIn/AU4b0GqF9ZBtb8M7jlvLhbgc0Tq5YGidIXu
	8kaimdmlvB2egHsMlfdYNnsy3NcgDdXG6wtssyZ1yocHyMf8YQ4bbR3aHl+4ugoQ5Qo=
X-Gm-Gg: AR+sD13riZmSLU74SaHEvsJGBDhDm+KrC3X6s2J1XJ7X9fATd3+v/XPVrZJ1RUbi1T/
	x83xOai8ZIcCQdpSkRHgiX2zb7U0wPklFZBZ4yVBKkU65FD4t8HXcZ5589clk8GqAIQGiaZxdn/
	Bar3q7nXRA53WEckvxn/c5RCb5PJ22sVF6V2Yi2BTkir8r04Zezr/h246EnSxAo43H36y4XVXNs
	RbG+Qy66HOlsGAhGltY+E4//iPAfpdVdH94THo4oskaUivo11X7DXigAa0zl5mxj6f6mFi9qj/A
	QIzSdGAR1YmtKFXoPbwiUEaZM0XB3EwZbiSn7tHHWFXT2Ja1EzRZl5wb0su6ePI0P4/1eAJwu45
	KHua1D3EomGlNR6Y1j2WhHJtUSJ+UaHX6adPztU01sjJ+eOpH3g0JUQeLEa6AM8wqs1PFzGqZLn
	smjZ20ELI+lfmq7dBujbq1ueow4tK8JXZlK/CCcrm1uUN9UjEDsxFh369m0rJXCArpF87+
X-Received: by 2002:a05:600c:3b1e:b0:493:bd2a:93bb with SMTP id 5b1f17b1804b1-496c653d055mr24700215e9.3.1785243493668;
        Tue, 28 Jul 2026 05:58:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:5788:c4e1:cf35:7211? ([2a01:e0a:106d:1080:5788:c4e1:cf35:7211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c4615681sm77642695e9.11.2026.07.28.05.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 05:58:13 -0700 (PDT)
Message-ID: <df81c03b-6d2b-4c5d-8818-1aa42c146d44@linaro.org>
Date: Tue, 28 Jul 2026 14:58:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v16 3/3] of: Respect #{iommu,msi}-cells in maps
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev,
 xen-devel@lists.xenproject.org,
 Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260603-parse_iommu_cells-v16-0-dc509dacb19a@oss.qualcomm.com>
 <20260603-parse_iommu_cells-v16-3-dc509dacb19a@oss.qualcomm.com>
 <3f5c974f-425d-47a5-9fda-e05de1f39d79@linaro.org>
 <fuqnxdknkajqotzmmlknwnthqpku7as5kpvmgogexl5bi7x6y4@tthbasf5lqvc>
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
In-Reply-To: <fuqnxdknkajqotzmmlknwnthqpku7as5kpvmgogexl5bi7x6y4@tthbasf5lqvc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/28/26 13:34, Dmitry Baryshkov wrote:
> On Thu, Jul 23, 2026 at 03:17:24PM +0200, Neil Armstrong wrote:
>> Hi,
>>
>> On 6/3/26 09:13, Vijayanand Jitta wrote:
>>> From: Robin Murphy <robin.murphy@arm.com>
>>>
>>> So far our parsing of {iommu,msi}-map properties has always blindly
>>> assumed that the output specifiers will always have exactly 1 cell.
>>> This typically does happen to be the case, but is not actually enforced
>>> (and the PCI msi-map binding even explicitly states support for 0 or 1
>>> cells) - as a result we've now ended up with dodgy DTs out in the field
>>> which depend on this behaviour to map a 1-cell specifier for a 2-cell
>>> provider, despite that being bogus per the bindings themselves.
>>>
>>> Since there is some potential use in being able to map at least single
>>> input IDs to multi-cell output specifiers (and properly support 0-cell
>>> outputs as well), add support for properly parsing and using the target
>>> nodes' #cells values, albeit with the unfortunate complication of still
>>> having to work around expectations of the old behaviour too.
>>>
>>> Since there are multi-cell output specifiers, the callers of of_map_id()
>>> may need to get the exact cell output value for further processing.
>>> Update of_map_id() to set args_count in the output to reflect the actual
>>> number of output specifier cells.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>>> ---
>>>    drivers/of/base.c  | 168 +++++++++++++++++++++++++++++++++++++++++------------
>>>    include/linux/of.h |   6 +-
>>>    2 files changed, 135 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>> index d658c2620135..ac7961cbab94 100644
>>> --- a/drivers/of/base.c
>>> +++ b/drivers/of/base.c
>>> @@ -2116,19 +2116,49 @@ int of_find_last_cache_level(unsigned int cpu)
>>>    	return cache_level;
>>>    }
>>> +/*
>>> + * Some DTs have an iommu-map targeting a 2-cell IOMMU node while
>>> + * specifying only 1 cell. Fortunately they all consist of value '1'
>>> + * as the 2nd cell entry with the same target, so check for that pattern.
>>> + *
>>> + * Example:
>>> + *	IOMMU node:
>>> + *		#iommu-cells = <2>;
>>> + *
>>> + *	Device node:
>>> + *		iommu-map = <0x0000 &smmu 0x0000 0x1>,
>>> + *			    <0x0100 &smmu 0x0100 0x1>;
>>
>> So the sm8650 PCIe controllers has:
>>
>> pcie@1c08000:
>> 			iommu-map = <0     &apps_smmu 0x1480 0x1>,
>> 				    <0x100 &apps_smmu 0x1481 0x1>;
> 
> To silence the warning, update the iommu maps to:
> 
> 			iommu-map = <0     &apps_smmu 0x1480 0x0 0x1>,
> 				    <0x100 &apps_smmu 0x1481 0x0 0x1>;
> 
> 

Will do, I was surprised none of the DT were fixed.

Thanks,
Neil
