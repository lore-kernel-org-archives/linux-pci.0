Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3A3AE18F
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003937; cv=none; b=pC7nCNCk+VLbbI8xRtfQgpnoMBxVzIMNAbU695+ZTv3G0Cm6qddjot3+atyedPFvGiujQtDYddixBKM6ul9kon+UDiVB6BZ8Mo6nbsIVByYryLf9PPNH/mpbOhTNvg36w59GP1AIe/aPt7CEV0gFADi3rzwuIXppaeIitnfjMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003937; c=relaxed/simple;
	bh=VwEnrsNuQe9ObBc47UVFruD/Hq5jqBRsKOXR5Bfg4Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMtkU9u/HQpoq+vG9ZF3GnkXn7JW1QOwCG6kdj0A8lKFsreCRZKXmqqutqspPq6vbzqyH7E82dtFWqzRP+KNCFR+y8LDDNcCL2Zy/P3CwmVxgD7oKVKji5pOTlidNl880CFy2G82XShfrKZKJSmy5f8geGJMwO/kuvUNy8r/EtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jy7mbVa3; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jy7mbVa3"
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-68470763896so2809221eaf.1
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2026 10:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003935; x=1778608735;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=euKFIAQCeM55RulM535j7KBn6cys8J5H/Q721o26Boo=;
        b=cbgjov6ajB9br5PX/ulj/EsABYqE42HvsGr3NEQqq0OdMoPtpHfAHDYmuh58mTZRvx
         rPFsgD51TtyC9M9HHYw/n80QsdGN7Evn7RG3hzu5DyIQlEFQuEYGm9LzxTapNcQ55yU6
         rZPxtvPnI9TNHYrn5tiu1/ZHbP+3/QZOvQ7xV+zLhYXAFR6bR0mAvd+vbh2rSk2EYG5i
         nXFq6Wi2HnWZKXZxsdjN/scv47SaM1jv9YHElwxbkQ42OEd80WrvSGRpX6M4lCa1mZRa
         O+xEJjnM9JV906SBBbHNpIJuzHRtmBO+cCm8rn4AaH5RAewYzPonFe4+68Dp1+TtTXm5
         77uA==
X-Forwarded-Encrypted: i=1; AFNElJ++s8Sdqv0Dj7F5D3P418Lp9vgwXLgQdOr0n1RzJ6e12qDCTUofyBiXAA5pdf8uu7UvnSMn1Ud/mS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Gc3EF3Thqvt+aR/AMwNpqhaekETEGA0Y/LkjnJicsUPZwPO8
	xEMw/w6c2Lm6k6usMCm8Ja5mP4AwrJeVnvb8QfdeZFQ3OdFwBhuhZI4niH1aVTkwYV24LM5PhxA
	IG4Wjw9Pwe1wR0h19xVHP9RGqj7FmQLKkhz80A08ReEjrD7yCnf4gz/gJ4snENiIN4FJicnsoxY
	CSgvkUdvjZNPVE1w2HIky62GLf4vOVIJric8tTIutRZPp2XJ2tyK7H7s1QNWnfq3PTv94+SEdrx
	DeaypGy1h9IPrIkEBUi
X-Gm-Gg: AeBDieuPImJx2O9r8sw7H6MfpYh6e74xC7g8KZVBp+7sTIrAGu0K+AUTRKl1K0U+x2C
	zz2CaUPlz/3fj5nS91eXKlgdVHa5oXkgom8w+f74xpa9PZwVfpTQKD9dh9eW0JP8Ij7/7QMt3ir
	sjtSxS1uAz0b8OUsFmBvSAdIeK/hqHpNuDZjB7Hlumt1UuKgdkDjfHYCVM22jdEtckkioCtqT5Z
	xtor8/eYRchTSJb1CldHmfD549VA+KAvuJdK3AFYeUzhe2CUodoIDfDvs5Smqk4xwFBaBPBqGEw
	1DCg6Y7FmD54GzPTLQ+SYsvhs5q/Rn7uEvLcj2Ha2Jm/LRPvPr7UUzqmAqGaw5vdUFlV+HxSW56
	RP9lMTMJBgq4aEXexGzBcp89q/JZC3LzjRRqE3/t56Ie88DL78MyboA0jFqJzqyc1FIe/Xg7EpW
	BYLbFaicYqHbUAKCRfc6ch
X-Received: by 2002:a05:6820:f034:b0:696:2cb1:9ffb with SMTP id 006d021491bc7-69697e17b24mr8449095eaf.55.1778003934943;
        Tue, 05 May 2026 10:58:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6968955f59csm934743eaf.25.2026.05.05.10.58.53
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 10:58:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso9402017eec.0
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2026 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778003933; x=1778608733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=euKFIAQCeM55RulM535j7KBn6cys8J5H/Q721o26Boo=;
        b=Jy7mbVa3N//5roee2VcT+lF6Lygqm6oATXFQ2tudn2nOzyN39sJqGnBg7yvZdihUEX
         UzfOgh0n23xeZrOKNFj+b7hM5iMcCqdcCWlRSPs7W4U9mX1d7TmXyJGDhZ1d7rsnnH14
         ngslMGPfsy5DhXoV9VATM899yQUHFJivOYU9g=
X-Forwarded-Encrypted: i=1; AFNElJ/13AEQ/0uS8m1faVqLG5Jxb4/ADVzGmR5VdW2V8g8FLlsUwUgqtJSe5qcf2OQMNvv10qeAMfqEf1Y=@vger.kernel.org
X-Received: by 2002:a05:7022:238f:b0:127:3f2a:af21 with SMTP id a92af1059eb24-131852d9084mr151524c88.15.1778003932577;
        Tue, 05 May 2026 10:58:52 -0700 (PDT)
X-Received: by 2002:a05:7022:238f:b0:127:3f2a:af21 with SMTP id a92af1059eb24-131852d9084mr151495c88.15.1778003931997;
        Tue, 05 May 2026 10:58:51 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d634sm25912919eec.3.2026.05.05.10.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 10:58:51 -0700 (PDT)
Message-ID: <d13eb4ce-a868-4b10-b044-83fa1ddea1e9@broadcom.com>
Date: Tue, 5 May 2026 10:58:49 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: brcmstb: Assign pcie->gen from pcie_get_link_speed()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans Zhang <18255117159@163.com>, linux-pci@vger.kernel.org,
 Dom Cobley <popcornmix@gmail.com>, Phil Elwell <phil@raspberrypi.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260505160144.GA732689@bhelgaas>
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
In-Reply-To: <20260505160144.GA732689@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 5/5/26 09:01, Bjorn Helgaas wrote:
> On Mon, May 04, 2026 at 04:46:03PM -0700, Florian Fainelli wrote:
>> On 5/4/26 10:26, Hans Zhang wrote:
>>> On 5/5/26 00:58, Florian Fainelli wrote:
>>>> On 5/2/26 04:40, Bjorn Helgaas wrote:
>>>>> On Fri, May 01, 2026 at 01:24:38PM -0700, Florian Fainelli wrote:
>>>>>> After commit 03f920936977 ("PCI: controller: Validate max-link-speed"),
>>>>>> pcie->gen stopped being assigned and as a result the established PCIe
>>>>>> link would stop supporting Gen3 speeds on 2712 since pcie->gen is used
>>>>>> to populate LnkCntl2 and LnkCap in brcm_pcie_set_gen().
>>>>>>
>>>>>> Link: https://github.com/raspberrypi/linux/issues/7343
>>>>>> Reported-by: Dom Cobley <popcornmix@gmail.com>
>>>>>> Reported-by: Phil Elwell <phil@raspberrypi.com>
>>>>>> Fixes: 03f920936977 ("PCI: controller: Validate max-link-speed")
>>>>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>>>> ---
>>>>>>    drivers/pci/controller/pcie-brcmstb.c | 3 +--
>>>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c
>>>>>> b/drivers/pci/ controller/pcie-brcmstb.c
>>>>>> index 714bcab97b60..6138fc4bc064 100644
>>>>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>>>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>>>>>> @@ -2072,8 +2072,7 @@ static int brcm_pcie_probe(struct
>>>>>> platform_device *pdev)
>>>>>>            return PTR_ERR(pcie->clk);
>>>>>>        ret = of_pci_get_max_link_speed(np);
>>>>>> -    if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
>>>>>> -        pcie->gen = 0;
>>>>>> +    pcie->gen = pcie_get_link_speed(ret);
>>>>>
>>>>> Take a look at https://sashiko.dev/#/
>>>>> patchset/20260501202438.376033-1-
>>>>> florian.fainelli%40broadcom.com
>>>>>
>>>>> The notes at https://github.com/raspberrypi/linux/issues/7343 assumed
>>>>> PCI_SPEED_UNKNOWN was 0, but in fact it is 0xff, which means you might
>>>>> want the more defensive patch instead.
>>>>>
>>>>> I'll be happy to replace what's on pci/for-linus if so.
>>>>
>>>> I am starting to think a revert is the simplest path forward, it's
>>>> not clear what pcie_get_link_speed() brings to the table honestly.
>>>
>>> The pcie_get_link_speed function is designed to prevent other Root Port
>>> drivers from accessing the array pcie_link_speed out of bounds.
>>
>> Yes, so that's useful in the first hunk of your commit where we were
>> printing the link speed without checking that the 'max-link-speed' would be
>> bounds check, however it is not really useful for assigning to pcie->gen in
>> our case, so I would prefer the second option:
>>
>>            ret = of_pci_get_max_link_speed(np);
>>   -       if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
>>   -               pcie->gen = 0;
>>   +       pcie->gen = (ret < 0) ? 0 : ret;
> 
> The point of this validation is to make sure we don't program the
> brcmstb hardware with something it doesn't support.
> 
> of_pci_get_max_link_speed() only returns an error (ret < 0) if DT
> didn't contain a 'max-link-speed' property.  That doesn't tell us
> anything about what brcmstb devices support.
> 
> I think this test should be something like what advk_pcie_probe() or
> rockchip_pcie_parse_dt() do.  If of_pci_get_max_link_speed() fails or
> returns something not supported by the hardware, they default to the
> fastest speed known to be supported.

Doing that could be challenging because it varies on a per-controller 
instance on some chips like 2712, this would also be a behavioral 
difference compared to today where the driver resorts to HW-defaults if 
the property is not specified.

There is also another aspect we have ignored which is that don't 
currently support anything beyond Gen3 at this point, but this is not 
enforced. Let me cook another patch.
-- 
Florian
