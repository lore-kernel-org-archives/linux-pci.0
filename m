Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCFA25B0A3
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603317; cv=none; b=ixiKx3Wd9TEJXgFPoF/BHdmmRVfCOoN2H2voJ9asHiHbLgcSTuMl41HnyEGELfhy5VJX7yWlx94CcuJRYrDEvd+EOjo9Z11doUfALaoh86sSb1yku1rh6V6n0aIOynLsaVGfDp3uuiVyPHz46Ee3YpEXfTQ6Y4z+Ypho9oMyL+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603317; c=relaxed/simple;
	bh=PaYeIeJNkwqQArq4jZQh28blkZiGmBp2NdxGhuzFrwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXIix0i6brYd4UlSuFbqkrC4AdasBxjOjmMnRctgWLrqcs5tR0TwMGF0IDYCSlfMTVn8GCXQ/OzTk6gfDTphp+Xl/RtT9WVMhZy3CEvj6oJZJUf0/AldrX+AxbAwlfPNz2yE1bRX/dMOlhTAGWfzoP3VapLruN8t5Y23kkJFSCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VKPDqIyQ; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VKPDqIyQ"
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-470416d7a86so29803fac.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 17:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789603309; x=1790208109;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QRPSaO5+XQixGFbnKMRKXwxYFIVhldNMoYMkzm/WB5M=;
        b=px3ps8Ii02/iPta6JNKisQII7ROi61xYMsRYAHRirjqb9jabU11Gi0V6MG+3077CG+
         35NNBNl0i2h6yjmhAhkOazTR52n7KvJb/lmsgDzfZhmPSw6US34PztVpmFgrHB3hZN8q
         6TAsHoieA6qgQrRuLl8PJhIpXfTU/nbxzZeaj7bo9e+z4TF0aVr7ibT20PgyKdW2UhJn
         9ioM+aJ3aKpVZzBTIKGPzYtgTu18QKMnUgquRtOBRNd+Dr2CaA6XEVHRL8OsxOAbT5cc
         AmPu/jYcJijo3iMytm4+AAwgIeuIZSzLJvWikoG2FImvElVFx7BTPV3mN/1m3y9Vd3Xs
         HKsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwnsuTwe16RDTc4gxWvnonZyqL4OhANjaKiaY2PqT08MjtQ99NzqeeKGUZtWP1rxTVCeslCeHsi/s=@vger.kernel.org
X-Gm-Message-State: AFuF++kJUyESELOWyS5l/kkdO0GHuEPGRofKWis1knW6NRocmrMmZrXm
	6Zd2qWpZy6k3//D9HySsxqFJzxDnio68Nq/mWpQxO8hGmbhv/qnskmVOCVWRs7qw7umsTx6vk7L
	tfe2bkUDNZFKm3gFzTHy4iqROD/5WeQQ0wWNUasxoMbtzU02ggSMUo1WciJjrV5A9QpdIZHh6qd
	VV8dYx4Zx8WgO7zleD+/jZhan5BwTo24WcYe4DMQflpsqj+yvs3/C9gnlvD7myl+HCu9mPTrHM2
	cbIERj5hhIDzae3KZFu
X-Gm-Gg: AYBFou2fNoqIHquVI0/EP7rnqT+ejUemjeTnZpPGAVnAVo2QWCCW6WbeR92giW1iZhe
	1XSVcHKkouQDaI0YhvA8ovA7HS/GFmbABqWLgJ8HTSUbbIxCXVTf4q9wa2z2R9oMjAgEXvIorLJ
	MN1ZEvWH0u5ZJVX1YitW5BZbyzp7MEpKq0G7PTAMCIlb5tDBafe79dSO6Xni6SNynS7yLrw1nLg
	T7A33a18oKmrPlY/GZCRGqGX8PACOgk2dOwUhgBIZHMBdTkaHHfwFPFBSwobRNoSGUeAOvCCkdk
	NORpMihN3pd3TuZIZ5qWKiDQ5gMiGvm6j0vvP3vWvu3VGKk9Wuy6pc+2N4j6MyQRiXsMFoPgs52
	g5xcfTmN7Dl/fN3LAEcIepyN4LHw0fQeEIC1Cfc0GofmO/sBb7NqcAPvs6/MvFY/NY5ilgQJKzD
	D+Un7Y+/vHcoQJnztkyf8puIAV+z1HJtKrYoeTre8e8rE=
X-Received: by 2002:a05:6808:6d97:b0:4c1:760:e5d6 with SMTP id 5614622812f47-4ca4a3fbdf8mr8422463b6e.5.1789603308534;
        Wed, 16 Sep 2026 17:01:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc50ab186desm1822800a12.2.2026.09.16.17.01.48
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 17:01:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6a313ec13ceso426294eaf.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 17:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789603307; x=1790208107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRPSaO5+XQixGFbnKMRKXwxYFIVhldNMoYMkzm/WB5M=;
        b=VKPDqIyQZ1SmF01kS/rwO5fSFOSoR0GmQPS2emrF1KwAJe7IArgLJlO4bT2pzAd2dU
         OTUaonv8oRWJ9gM6phLZqOFUS92A3oD8X1cv8qZzYAYGW6pI3PxLm09v7NX0RK0xZe1q
         TVdaSk+pL3x1P/AZFMwooGygq9iG+jwxJa8dA=
X-Forwarded-Encrypted: i=1; AKwUvBxK4AzcSkBdE3JMxCrztrlrutukbpaxMxaug4W8MjYLOPl5LlvHEGQQlPQCWMc+cvTlUYEJZ9Vl/Mo=@vger.kernel.org
X-Received: by 2002:a05:6820:1c86:b0:6b3:b9d1:f629 with SMTP id 006d021491bc7-6c7d46e699amr6935899eaf.31.1789603306387;
        Wed, 16 Sep 2026 17:01:46 -0700 (PDT)
X-Received: by 2002:a05:6820:1c86:b0:6b3:b9d1:f629 with SMTP id 006d021491bc7-6c7d46e699amr6935845eaf.31.1789603305914;
        Wed, 16 Sep 2026 17:01:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5aee8b0sm21269531eec.23.2026.09.16.17.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 17:01:45 -0700 (PDT)
Message-ID: <5c9e48d7-7f6e-44d3-bf0d-e23df1329621@broadcom.com>
Date: Wed, 16 Sep 2026 17:01:44 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] PCI: brcmstb: Declare and assign quirk
 OB_WIN_MAXSZ_128MB
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-6-james.quinlan@broadcom.com>
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
In-Reply-To: <20260911233541.1650895-6-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/11/26 16:35, Jim Quinlan wrote:
> Even though only BMIPs chips have this quirk, it is more uniform and
> readable to define this specific quirk where each outbound window is must
> be <= SZ_128M.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
