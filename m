Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BF1FF5E3
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 00:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603250; cv=none; b=qsODGwwRTZIBenjN+6ax3hbATeOky0so8ico63HzEUVrZB+FYLRz69frpb9rxmkrsazzEFm4ePwldSMKO4GqBpOgd0itUif8uY6+irGU9GHa1Q6MXoS++oM3AVTwiyxMlxn6jLIj1MrkmdHskDdbKludkzVEIZipEn/+GLyCXLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603250; c=relaxed/simple;
	bh=oiZ6XktFqna/JhScVbDnl8dP8MMvhZCdpQNkz5Hg1pE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoE8Mm6sL6Wam3pyt053pq1EDx40lWPdXb6RYIn2byEO5MWaDEbrpuMnNVyRGCz5gsF/1fnzujib40+PqizbMUy7D5bzQLDoTBBZJhTLVpnt1z3aeobpFILR2y2Fe8rE0LcOWP0RyYsvQZrkQIuam0NqnYX+EM0ArKEEn/rp50g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FmmTRUgI; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FmmTRUgI"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so90075a91.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 17:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789603248; x=1790208048;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=J4imMswxUbVr42K3g5BOsJ0pmPAyLAHU01ncoNcfWeU=;
        b=O1oRZU2V9gHUuWMGlobZqcVEQeINJkzGpbN/v6Qh37Se/vG1IlY0u3j/0UD5KIHD6s
         8l8WCuCXQeBjEM3NyiiMnjjvunbc1hm71uOFu/mtuhjINTYF93mxBsVPfJkiBKixYLn/
         eGxbCsyIQ8K0MrhqlYuE4NzaP2ZSxGojiNNVgcCbit7pX/RR5hUcRp3p1CoqnGN8U9Ge
         vhtPUOWrJLYKrU/JgbxmYuzmzSuDK95t9BQbR7PxOUVgIpxv0THhOny4OX0QpM7SKDYm
         aFC0tMDBR7ECTFUg/tEklyyblJRDt+udhUkwAsm4qmcTlFTzA1NDX90p2Xt3gL1ScSoW
         HlhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQ8Ho1rjmjwywUK91EHdNytkpA3SdCNBggdlw6X7OwiUvumvSe8SE/truhmU11eU0bcZ8l+iCPjWk=@vger.kernel.org
X-Gm-Message-State: AFuF++n0tjYyKKudUval8UAQHrMotKKzcsomoBPOgCbaAVfVck/swAUe
	TM5c1miBxtFvYrZLeYbBeOeD8Z6SoI4wo1EadxoCvhXuh2R2079BXRFlTrlz3TIcum42OyI08ac
	+4Pkp53OhMqeda/m67W4411c1eFdnMoIUHPOkR2ioyzCJIOz5bC2EyoJqreCbCk0fNFX2D52sZ3
	FB7YV5jmy5cuned0eqnL1o7aW88o2X3Xz/t04JKXAPLvvdz6b+Dj6M+trLO29mJyRv+DGzbmfs2
	da7TzGLriskuv4X+5Ca
X-Gm-Gg: AYBFou2n+7EYZVN4v6f9UebMQic6zY2nRC42wf0batclOJzolCCdx5momHFpKNrBEio
	bPtgMCm1ielhOEiDhUREaoKraLfMyv3OKDiiTkH3F0GqgflwaS8TDFyv89kr2kjeBkqkZ5HWtdg
	1ZOdRwek3Z86KTFCojJhq4AcXTyq4IPkVCs1WKHjSNbTAyoq7on55lnOH9dGT/Jyu6bfw3776hO
	tTnnW0jUzODKE8ZEiJYQngXJWBB4n6Ci1mOKcD8ihuNXVS38tcQtm3lehR1vbcB6U+YlryVH3X6
	sr02DNywm9WWbhTz6/ro89I5dYjPfOMive1sl1kGo6hFFe7jRtXFZ56akoO3yoogbjxZQeXKK1r
	KrWBhemIpccH67tZRxwedKOoExpC9JWWDWxh+qDP69768mUJQYiN/TBk6DN68y8tx6v41UguNat
	PhyvKeclyFdgNC/XRBnIEVAhyvdNrYFQ5aNVnOjPx8Bvw=
X-Received: by 2002:a17:90b:440c:b0:39d:fea0:c17 with SMTP id 98e67ed59e1d1-39e1e309c21mr9846589a91.8.1789603239758;
        Wed, 16 Sep 2026 17:00:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39e361470b3sm545389a91.3.2026.09.16.17.00.38
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 17:00:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8699b293a80so265972b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789603237; x=1790208037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J4imMswxUbVr42K3g5BOsJ0pmPAyLAHU01ncoNcfWeU=;
        b=FmmTRUgIvtL8EKDjsmP3yGspxuRPd8lkQGO2AUALzq8CTUoSmUeT8BT1K3e/a/DSzT
         1O+P7VST1oAtLFBHh6sKmZk+p++vOU28kgxdtd5AhLp6QHfG9q17EGEJ+yTFgR7tEupf
         xCiTgz7neYl7gPbz5Q/ufy7BACEFHCLGfW1pc=
X-Forwarded-Encrypted: i=1; AKwUvBxxgHx5OM2T1f1ZZBh2M6MyBXjDpOgnDLmCjgTWiyaHyxr/eLGkAKpPp63dxv/0KRs3MCSL42ZjnfY=@vger.kernel.org
X-Received: by 2002:a05:6a00:300c:b0:864:cbc5:b8c1 with SMTP id d2e1a72fcca58-872372c3f26mr10397837b3a.2.1789603233644;
        Wed, 16 Sep 2026 17:00:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:300c:b0:864:cbc5:b8c1 with SMTP id d2e1a72fcca58-872372c3f26mr10397425b3a.2.1789603231228;
        Wed, 16 Sep 2026 17:00:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-871febde2e1sm1973248b3a.7.2026.09.16.17.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 17:00:30 -0700 (PDT)
Message-ID: <5ecf4562-3333-4b6b-9a19-bedc56750022@broadcom.com>
Date: Wed, 16 Sep 2026 17:00:28 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] PCI: brcmstb: Use flags u32 instead of bools
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
 <20260911233541.1650895-3-james.quinlan@broadcom.com>
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
In-Reply-To: <20260911233541.1650895-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/11/26 16:35, Jim Quinlan wrote:
> Instead of having separate 'bool' fields for each SoC configuration, use a
> small bitvector (u32).  Doing this uses less memory and provides a uniform
> method to assign flags for a specific SoC.  The expectation is that more
> flags will be added as we replace conditions like "if (chipA || chipB)"
> with "if (behavior_X)".
> 
> A helper macro "BFLAG()" is used to shorten the determination of the flag
> value.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
