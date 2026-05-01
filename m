Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357AE287503
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2026 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673110; cv=none; b=mdcVY1iiiZ6hDVb6eKW32LQnLduINW2rkveQ63NxcGrFawpUh8gfpGnHMoaekWZShAG+XiQJZuR/lvO0CoalMXS37zGl+fAE7TKgJRKgp14RwJ9UlQF3bUp1N3EuQgQF5TB1rUbhDvhzN2mmvmoLWgarFyIon+SkhaV9oxlwDnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673110; c=relaxed/simple;
	bh=0qSOFdNT6dR0KSqAHacMYC+aznjSOX25Xn2HUv4F0p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g814ZStPVV7NIKBymR8I4hgBF0gk3a1QcuV4wXyd15xjTaSaEBGAU5RCaEzqe08QElViMnw/RKJrBtmB0mv+F443eKaFxyUuN6ZrUWsmmNppABJ8jK5r2pjQB6nlndrbf54kPtMi28u0n6PF8OyzDI+hK4gBO0HFYMV1lRAZSFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WFay63yA; arc=none smtp.client-ip=74.125.82.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WFay63yA"
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-12dcdcd54adso3602601c88.1
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 15:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777673108; x=1778277908;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0JiJdMx+KJquXdLD9tyzm4VKNrHA4z52kt6wPCreDaY=;
        b=Ry7gQM2z9sngIcDhHcDr3S6oLByT+A32deo9bUWXNRoc32JYe5FSa8X+fTHvJAB8F8
         Jia5/SpP0VDLFdOFQNHF24Ybf1/S45rlFBwIetAOJaMQiMfKenYPvMegRaVKzAwd2PJb
         FgECCTzCbodVJtwPPRnpBUom1vS2tJAR7hYOJnN5t0cCQlzCM+OHG9NEDiuwOKRuUbgp
         oAFZWS6ltz+WgDUBYLF+8RQxPWw0m7ntB5aM6UTxNCYjHCFQPEKqN1dqGMQB0sdHWaZJ
         LjBPFJUtrWi2/UlRMpkFL2cmc+q1Ww4D2kZxK8Pc4Cbfltyq+EzUxJDzUiXTHKFrDUsF
         mXvg==
X-Gm-Message-State: AOJu0YyMMu6TcoZhTCPO+RCRSfN4NONlZTObSwTpQXNe77pCvjQo+7UU
	ewhmpHiD6etEvgGMDAUdXZsOcWNWINbo/DMfmvVdDtkIFQvQCPUJE5YHIYyA57eykKb80Nb2QR7
	xIIksbppsMzWrlSrwp1mMjuvnRbHVVga+TOEAw/1HTxdQQ/F/VWu8RXBV+dFP/UUQrDWsTiSJ5x
	tA6Cyxy1KvdbJG8ltoBrFm676QugxtN7QHTBdLXeEchxiHkpbnyGoYfFh5vAEBhY/cjUTxE3zU6
	FqYhhtlu04kC+Kr8wkH
X-Gm-Gg: AeBDieunHwAN9nLiCfvqYy86JGi/A4+3wJRJFsygfxZGOIchfHbmicZPImeJJB0UApI
	lyo1Bo9ds/Av+WTnXPPJhDZ9Y0qDo7eWuNwqdWZ7eskiv13mitD+YcpOfGVg2Mz4P+3WLc5MTbA
	SqBbeIymRliQFZKuBGmDFohERziM9ojtqHyeYK7cByBs6WkrTVDXWyvLjnRjNjjtW8cFqaCmcie
	H+PLHZfP9IE/QbiFh+jKAE7CODQjMbiIkvgLShURh/n1F9oNOvtu6MnfrhRKlnZb+/rB8QUmT9E
	p+sknMIoKJiDXJzwl6jWXM/CQLZ70lK8KZ/NI9iECzvv+0gZ7ui+0FUxSQIxaO8Nh2Eymy4+Cy/
	djXltWA88aEAg/7IQfvPBdrf4tqWAMYPHwBRDVwzkIHWxdwfDkf0DiWXy1CdKydW6lwCdLyj1eG
	T2fFZmaqiYPkJ8xfAIHZKtZq09e47vM3U0QJ9osN8S7Hb3L4Wub4csbJBUDqJ7QajVRIO1IQpo3
	8A=
X-Received: by 2002:a05:7022:4391:b0:12a:713b:8958 with SMTP id a92af1059eb24-12dfd7bbc2dmr474444c88.10.1777673107954;
        Fri, 01 May 2026 15:05:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12df843d895sm260939c88.8.2026.05.01.15.05.07
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2026 15:05:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d5d1c2289so56423711cf.2
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 15:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777673106; x=1778277906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0JiJdMx+KJquXdLD9tyzm4VKNrHA4z52kt6wPCreDaY=;
        b=WFay63yAPRoQkcnSe97zBV6MZynaDpVMMcKII1G3vL+y2qh/pxRHDMiEZrfC7xwYqJ
         x9A/KEwr37otSGJlJjI8KB329N4SvBHwtHS4slbO2XFe3tyYMafQ5ul6boQRcP5Pb8ZU
         12pC7HQuflku/R0f688EJH2P4jMCjjPkS7C98=
X-Received: by 2002:ac8:57c9:0:b0:50f:b17d:7e53 with SMTP id d75a77b69052e-5104bf6baeamr15609351cf.47.1777673106367;
        Fri, 01 May 2026 15:05:06 -0700 (PDT)
X-Received: by 2002:ac8:57c9:0:b0:50f:b17d:7e53 with SMTP id d75a77b69052e-5104bf6baeamr15608871cf.47.1777673105862;
        Fri, 01 May 2026 15:05:05 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b5e8b4sm29282711cf.23.2026.05.01.15.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 15:05:04 -0700 (PDT)
Message-ID: <ef1c9256-7fed-4476-bf84-9dc46bca2232@broadcom.com>
Date: Fri, 1 May 2026 15:05:02 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: brcmstb: Assign pcie->gen from pcie_get_link_speed()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>,
 Phil Elwell <phil@raspberrypi.com>, Jim Quinlan <jim2101024@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Hans Zhang <18255117159@163.com>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260501220359.GA522578@bhelgaas>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260501220359.GA522578@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 5/1/26 15:03, Bjorn Helgaas wrote:
> On Fri, May 01, 2026 at 01:24:38PM -0700, Florian Fainelli wrote:
>> After commit 03f920936977 ("PCI: controller: Validate max-link-speed"),
>> pcie->gen stopped being assigned and as a result the established PCIe
>> link would stop supporting Gen3 speeds on 2712 since pcie->gen is used
>> to populate LnkCntl2 and LnkCap in brcm_pcie_set_gen().
>>
>> Link: https://github.com/raspberrypi/linux/issues/7343
>> Reported-by: Dom Cobley <popcornmix@gmail.com>
>> Reported-by: Phil Elwell <phil@raspberrypi.com>
>> Fixes: 03f920936977 ("PCI: controller: Validate max-link-speed")
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> Applied to pci/for-linus for v7.1, thanks, and sorry for the breakage.

I reviewed the original change and completely missed that, so no 
worries, the fault is mine to have missed it in the first place. Thanks 
for fast tracking this!
-- 
Florian
