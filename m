Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2A73E3D9A
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913900; cv=none; b=AZeLdEkQwhEdd+vTol4WKB0OTUtJJQiAGRYY2/3apdShxnxlsudJGHPpaN3xN+sJ7QKahUR/W7Z8oELUYHjsATdCK2xdCryHWWuYHe7mGI8VpQyWy91NlFybDTeZP2bjF/5PUS6yfh9WnKDupopiCVBs7cVniSPFdQeGHNqAfv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913900; c=relaxed/simple;
	bh=WpgoaaNzosd0BxLmR2WF6+J9dkKSsdxwMIC09WBTJyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5MNWo258YSr5hrKJBtr2IbyRdI6XSuTpvrjfsIcKvOBKT/AdIm3Bd4IFLSxJO7DkE1zhbO6gZdZTox2Fb8DGXxKau8SdsghLofiSF+VP07AJWFnuC657hD/0QLkZEfwl9vz0L/wSiV67cgj7Ak1cEH0X7aTPKW2O8siSATcOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f6YLROaI; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f6YLROaI"
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-6201fc9ac0eso1541607137.0
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 09:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777913897; x=1778518697;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=faOI5W+NOaiamFpm7prjE2bXLwM58plu3qwpg+EeMUk=;
        b=cnu86rJT++C9LDcj5kkQIvLmC/hQuuTJjHlSmjfQOgOGmu7+mLHQYZ9nPWFsVB3Kcj
         pEBijEAz6wZ8EBkU2Bw8cIjQ2OAp7CLI8s/WcXn60fej56JIZtWsmo8W3KbZmTr2Lafs
         rgALRl0VqTQ9j6EevMmH9ozl0In8Ja61uTzn4ILxItwmWQwG80+mXdue+Vjy6oRDeKVh
         OqWi5sBwIkB20qAX43sTRj6kHYRlwJAWh5sWQN7T3/sk0wEpSxQWHooJs5OJR6+yVvUj
         lAKDPoAJFmiDioAeclzRtbRu5bLnKVMOTf+v1GKUuPkIbZoAaFmDew6J8P+vm2K5Cz2W
         5T1A==
X-Gm-Message-State: AOJu0Ywd013QuiDu685UrxMpdcMgAm3FPfE65j9BmW8SzAqD3LipxDIS
	U1Nu0wv4sOkpchAFcuS6sa6reqsJr5YoO19oO6PIU/Sl1C8f0t1UFDfqeEt9dmP1ZvWDSyMUwqa
	7GGFmxfWcMUeND3C3MiuRj1Yhb1/ICqwRe+ISw4FxrQQuSGuAFfBnVlbaQ03sJ/jo6XMFgJHEsf
	tFRqJSgRf3tLQGbVysX/Bv50BwyTQehkby6w8nkqMCWcBvnq5N51N4Q0oa1fM+AHtFU21qD2oSN
	m3mMtxRwzaC5mcEvcOn
X-Gm-Gg: AeBDievbm6yYkGXixWqVWZ5j3Jd7RUO79lifekc9kh635tLNWuQtVWEkmvjVHBQxkQu
	iwcJtkF/qwyEoJQFouPprEjM6yDoQhfqtpHkVJQf/xc8FAoxhel1HvbKVS1ZralGJuvEOBWPbKP
	gsrGHbOF3AwvPJEX998sN7navpOhIfP97GtNfV/cFVnGFAUDPN5M57ukWEZzueQB+nrCySFFM6o
	co/wcbjoEA5SQM1IbCgYnONmYlXl5j5Ukho8EQyEOpegyHCVTW2PISIvTw5I6rDOgAdyTHm31Kn
	RIkr1qTvilA8pofWhy4VyUuqTUSqunh3E0k1rjle5X0f5bcaeHqkjSzklIBEAjBGNTr9/+lfWJh
	ci+LZlaftMNbQ1ro3Y6fktgbTSPhR5818cUziMUuClWnWZHe9I9TCY1CK3cdU3IBO872AzRfklE
	6H2AZTaInAX6qjxFV/QjBUWohK7vVziyF9Zzc/FWaMEXcRZCblFm5yD6gmP6JPDRNh3GqTr6LXP
	eU=
X-Received: by 2002:a05:6102:c4f:b0:612:7ddc:52ee with SMTP id ada2fe7eead31-62d86a1cfc9mr4430508137.15.1777913897121;
        Mon, 04 May 2026 09:58:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-62f46bbc654sm150737137.15.2026.05.04.09.58.16
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 09:58:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ee5b73c5f2so5515061eec.0
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777913896; x=1778518696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=faOI5W+NOaiamFpm7prjE2bXLwM58plu3qwpg+EeMUk=;
        b=f6YLROaI+OxPSCYN2//MjuwxtPKhOkP7mtdcQRhCPT4FeYnMBhiPzLO6MuMBZCB+8n
         ZUHaMDXFAZe4SEBOqbVDZUaM44vLShT5irYmc8KLfOxh6fZQE82dl/3TJC6OpsVTxbHy
         VwDtacTOKpfoKs6pRzz4ZmdDf6s91ncPv4A/s=
X-Received: by 2002:a05:7300:8c28:b0:2ed:e15:c923 with SMTP id 5a478bee46e88-2efbb7718e3mr4770358eec.31.1777913895974;
        Mon, 04 May 2026 09:58:15 -0700 (PDT)
X-Received: by 2002:a05:7300:8c28:b0:2ed:e15:c923 with SMTP id 5a478bee46e88-2efbb7718e3mr4770325eec.31.1777913895339;
        Mon, 04 May 2026 09:58:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f194556795sm6594936eec.2.2026.05.04.09.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 09:58:14 -0700 (PDT)
Message-ID: <2f453b89-0ce8-4ef3-ae93-c282a2d08fd7@broadcom.com>
Date: Mon, 4 May 2026 09:58:13 -0700
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
References: <20260502114019.GA551304@bhelgaas>
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
In-Reply-To: <20260502114019.GA551304@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 5/2/26 04:40, Bjorn Helgaas wrote:
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
>> ---
>>   drivers/pci/controller/pcie-brcmstb.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>> index 714bcab97b60..6138fc4bc064 100644
>> --- a/drivers/pci/controller/pcie-brcmstb.c
>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>> @@ -2072,8 +2072,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>>   		return PTR_ERR(pcie->clk);
>>   
>>   	ret = of_pci_get_max_link_speed(np);
>> -	if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
>> -		pcie->gen = 0;
>> +	pcie->gen = pcie_get_link_speed(ret);
> 
> Take a look at https://sashiko.dev/#/patchset/20260501202438.376033-1-florian.fainelli%40broadcom.com
> 
> The notes at https://github.com/raspberrypi/linux/issues/7343 assumed
> PCI_SPEED_UNKNOWN was 0, but in fact it is 0xff, which means you might
> want the more defensive patch instead.
> 
> I'll be happy to replace what's on pci/for-linus if so.

I am starting to think a revert is the simplest path forward, it's not 
clear what pcie_get_link_speed() brings to the table honestly.
-- 
Florian
