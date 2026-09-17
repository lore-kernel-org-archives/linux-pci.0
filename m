Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2FC53F6BA
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664922; cv=none; b=i6NPT3ZfnvcAAc3FGgP+52cpsuaSE6AhiZMTunRl8CPOfm6SgebU2Dgiilq+09TREQd6Ljx21vJ93DKKqva7IdMHVv11Dvs70TFygsVWED/ULjNzYwQ7RIVYCgu/S/8aikAFVvDe5NdgD1rMTmWAEOxJLNC264tB9r5HOSIV2LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664922; c=relaxed/simple;
	bh=PNwxqdynuHqgbh1oBopswHECWVn/V9O08XqUZSdJfjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ra8QQC3YMIPh9NNGvqi/WfRQcTygoWS5TYJJu0cBArkqtfwc1UYVKGj9PUccFqxWyKx1lvMZGMrCUZse/+36XJKpL+F/NNFVynZqy1K6NVUUwMR0rek0yyeuskCvpBgmIXKcBZeum0DBeywlkzwiIx/vwMlhEaOia/IhNHqD9pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RzkYiIgh; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RzkYiIgh"
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-8009036d745so290788a34.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 10:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664919; x=1790269719;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JSZebXv4BWY0XMsVIBwkftKe1sIwcAMtAxU1OIXCMMQ=;
        b=NiJEN2x1dRfZSLoRV7+tNwczxnL9iY6rAp1E9I+hiUxEh6580k+Ulcy4veBfONLcFC
         zg91DcA6gFTGJXYbdbb94U/NljwKrWVPWT3OMU9qNB1PFQZL+fYOTjOIgZ5tx5IfhCiE
         Cmr/0JsUUCSrfKv0hT3paCHBD9SMVJZKA1Rs6d51KVWmqxMo+pzphtudc1i4WfqGtALq
         X4/s8/Uxwbu2ShfisSUADVxm53oYeX7fFHEpV/kF0V/0/eAPXD8vzHLp+nOWSvojiv1f
         YCZUK0DV/DxcLdiVCzAy8n+SiN2ajI1ZbVCjA8/V6jBDyAsimOY4ZSAtlK3L0yz0wK4J
         jmqA==
X-Forwarded-Encrypted: i=1; AKwUvBzqIasej6iIdPe/NNIEPR7dN4vKVSt7hNT3rLPPPtRIdxGLx2MHVH0P+iChEBAb6rt7tzC1gG77dek=@vger.kernel.org
X-Gm-Message-State: AFuF++k08YyNvY6wIdce20Ey+Zm3fsV5KCeCmAq3ehz4B5NUm3QLC3lc
	io6ir++Ig5umyJ7SyM3bXJIISLh1BoilDRQtA9IF9SelR+3FR96SFv1ObtegRRBt085sg9xl3B6
	Zmcgv5dsX47UrKUBM/d1FowhhoOj8sry6hxOvqdbjMKL+/luzxYNCLZeV9W5twFsVf1NAE2b8V4
	rxgsNIEjHU20R+GPzbyKQul1b0iaVnRUiWPRX5cZNGyZyHO7MJs8bn1nQNJ1/molXCZBKUrhBr7
	6TqNCZWw6sjsbj0id68
X-Gm-Gg: AYBFou1gddT+n5FHIq0DGxLm9sSsg4oQ0nWq8btQNqWOH46KAq7gwzAKb8M7jTW8vPT
	IxuWIyPrek/JkaiZ3v0foayUepoWkko3l6YJ2mDcvIJPoe6mXRPfR860Per1o5fFbE8OQ//J+5y
	5dTDiRf9XbSkgXrFc2ryemVpDColG/TtO+zH7IHk24eg4i0RcmJGdmKKAaKG9nv6g/a5bs29dG9
	RTjdJA1RpnRTCOEV4RIpApXHfCPay5iQQb7gdaGmTXNwiP4xw9XV1pnPh0IbAbNzrws/pnTRFCT
	Ld0SZlPIbYjAeAuHft3Ht8tmcnRSjkfJSQCNQh6+kt+5M9RBC+KCS/nmhqW5mGpK28DBtAmiSBv
	JDH9+27S/VXSWiz+iorGY6ehhz1m5jqAnSODZot/a4vqEpOfEMIi3LOfWGYcct0PVzppimF1j04
	Nr2k8m2zsFBNCUd6IiTSYLeCYeycCKbpZxk4pBjNhWjow=
X-Received: by 2002:a05:6830:6690:b0:7f8:4ebe:2854 with SMTP id 46e09a7af769-80b2d408d94mr11857247a34.4.1789664919469;
        Thu, 17 Sep 2026 10:08:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-80c410c9ed8sm1882327a34.0.2026.09.17.10.08.39
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:08:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90e7f98bcb9so18520936d6.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789664918; x=1790269718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JSZebXv4BWY0XMsVIBwkftKe1sIwcAMtAxU1OIXCMMQ=;
        b=RzkYiIghjJ3LhLZoDivAnJ4sD3KuS5lPljbEMx4mt3zAXoznkZWc3wouIAz4xqoWXy
         o/mfdkdW7cEZf579OtMDn2oDjqSLUBjrvQg4tTPuyOZRg7DPcb0O3bN5lvE4UpgIN3Gc
         TNbUD7/KUMg9eKdvFZK+GoCxzNhUE61y212Og=
X-Forwarded-Encrypted: i=1; AKwUvBzmrS569lLyaxturg8UWQ+hqC08/rUFIn6x8bnFgPImbu+gzudpVivGYXM/gDr2moepu7vXbKFG7T0=@vger.kernel.org
X-Received: by 2002:a05:6214:2261:b0:912:517b:856 with SMTP id 6a1803df08f44-912517b0b5dmr22214316d6.58.1789664918520;
        Thu, 17 Sep 2026 10:08:38 -0700 (PDT)
X-Received: by 2002:a05:6214:2261:b0:912:517b:856 with SMTP id 6a1803df08f44-912517b0b5dmr22213186d6.58.1789664917844;
        Thu, 17 Sep 2026 10:08:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91252cb0b52sm2227776d6.28.2026.09.17.10.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:08:36 -0700 (PDT)
Message-ID: <b8c0c201-ae33-4a0f-a145-0c20836f38a0@broadcom.com>
Date: Thu, 17 Sep 2026 10:08:33 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] PCI: brcmstb: Use order-0 indexing for inbound BAR
 window array
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
 <20260911233541.1650895-13-james.quinlan@broadcom.com>
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
In-Reply-To: <20260911233541.1650895-13-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/11/26 16:35, Jim Quinlan wrote:
> The register names for the inbound BAR registers use order-1 indexing,
> e.g. the first is BAR1.  The code followed this nomenclature by not using
> the 0th element of the inbound array.
> 
> Undo this approach and use order-0 indexing.  Also use a struct pointer
> variable in two functions instead of array indexing.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
