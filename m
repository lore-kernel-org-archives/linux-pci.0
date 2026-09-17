Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E67925333F
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 00:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603430; cv=none; b=WZ40Ryn+JcCgt2Z4chUCK0d2++Z6iQ6pqGL+rjxqz535iP9iqo1iSxvZ5F9fG3tJMxi0HP/V1yVnu9uZO4FRQ1rsv+jxWSUgbNZkw2fo6swxnuNzWupr3PTQDS8ewh0lKipm2MOCvVOYE4aGlfbrQSeeGR/dqhJRgeV29qLVB70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603430; c=relaxed/simple;
	bh=0hZNfIz1ZuQ+o/BiLmL+UDToXwEhaeeHbpHh/MVO44Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anBdGMjT6hHAXHSc4jM05Uho0QoiEZHsiwmkyl0+Gf9HkFBFQYgb4Rwdz+SfywgzAXFQ8MKVNxtil68bRN2K0kBjvTWBInvGmYpIJOSkM9CBsl9Fyyn7iiU2J0k+NlbkMEQA2pDh92I+y5h0kfxwweGhIEdvHNjTpYj4ehx5LJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fu/8r9mR; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fu/8r9mR"
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-5c7991578c2so55214e0c.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 17:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789603425; x=1790208225;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AZKUQlfoC/8Hz5OWhXA97Agge1eLf/8U2Rh0h/dSQak=;
        b=IbKdP3pRe9bldxiRReghQWZhAGoZU/6CyQRBJk6yoNQHmfLkdE2IYxG64i9Gl+EXDB
         Zx+OS4oahG7Ez3dZu12I8KPOrnqxPZZlsv3pBHkDV0HRm6uLUI3FY5dsbMeXrSdoOvfm
         uSWlDiEaD1FftSLLIsi4V2YcUlId5V7w64xmiVhbhIvCTactwN5/q6uLLB3csKdRLh/m
         ER/HQROWDgUKkKJ5ufZ32qNLISdQgdPDTUxsHnvwNRejDsKIQS8xQYlB5skhqIAU926I
         CnEkBFzPEv1OngYMeF9IzwQOO5q3j4zNT6ax0RCM9CQdyzm7yFSMWV8PjzvNbdt48LDU
         O2KA==
X-Forwarded-Encrypted: i=1; AKwUvBxU/sqvrc0FD7aAZdiDJUUNSp+XoBE37oWVOO6TVostR5zUL9NftYym0O1yTdy9JlBXIquYKBDD2eE=@vger.kernel.org
X-Gm-Message-State: AFuF++nu6QfQMdSdSJx+m+Hk+LU+FN9qarbXarppBe74u63akA5OobGS
	jp0RLubx6YpmWIA7So9NUhZldabe3eQgd5iEnOiKGw1+z62HpPD9kMvkYfqyc7IhFLYXcI4btIZ
	63VEaTP1Uxuq89hhorALzlVQCbXQfrWjMp60mDCtuB4erfZDfDU2R+pOwBc4sOd5ZCfSYuPgEFm
	ZB6rWiSH/v/r5lPy9FmCt1QyX/1Yov0MeZc8WUWGPaluxuwjLm/b+Eg+vgtQJ79ZgxCU63gykQ4
	khsvUjlQsXniVnPw9eZ
X-Gm-Gg: AYBFou3LA5MtWktN3ttS6MHMpJxOtYpn5+goRWztR8dUYqWKMfxpQ6gJPBTWcsu7t1S
	6Hze8Fk3AbnZ+6NPxaC+UZr93PGtli0jpQe10OBxu9tqSV1CUXv26gq9Yb6FLLc3oAZxMDWwoue
	JYWYiW2J4aaUNb56wD05NTfIn24yErGCsGAbhRau2pnWAb3Oec9Brewh17tS3jPa5lh8qbHKz81
	QCRFu5q7pivIPNJP4mg1kH+pEZ+Ht4ZbCipM59E+rD3VEkl6xds91+AbCU/fYQUYYxZIiaxD5Z/
	1A4Rfv86eZi+5dJawA34jkNb7w6+wC1351ngXbvgYbURw7wUNe/0uHCcGrN1IFwNvak19/j6bGz
	uE+6SP7NOgzTfr1IEkOrEnEAEDhiWNE/Nt/tWMWvbwVr4fKpt9z2kXZbVByCt5FLbhQp/nkJPFk
	IMbi+vMwCbgGZpqtsfybyKOoPSjwPc929tNSvyhc7Z++M=
X-Received: by 2002:a05:6122:2202:b0:5c9:a60d:3275 with SMTP id 71dfb90a1353d-5c9a60d3a04mr1333484e0c.9.1789603425272;
        Wed, 16 Sep 2026 17:03:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-983233e9fc2sm393930241.2.2026.09.16.17.03.44
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 17:03:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so393014a91.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 17:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789603424; x=1790208224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZKUQlfoC/8Hz5OWhXA97Agge1eLf/8U2Rh0h/dSQak=;
        b=Fu/8r9mRgOoYrsv/SXlgofssUTknQJHa+6+UoZujunEoGVuJ7qGp1o+7jDPFZdFdLh
         3fuNruEdg3lryxAkUvxt9VMN7By8qaHxG+6y6tfWWgKzaTHWJUcn2/7JXp6lgIzuc2IK
         qIEM7n0qIYrPrGPvyDn5ERTRe1M7SNHyCfmQQ=
X-Forwarded-Encrypted: i=1; AKwUvByppvb8pVdYv930vIChILGEzbNG2Y6RTc/2pHUa8IZsH5wa/GpH9z48JyRKR0WhJOTtIt6tIdr1Q28=@vger.kernel.org
X-Received: by 2002:a17:90b:1c0a:b0:39d:f247:bab with SMTP id 98e67ed59e1d1-39e1e2cecb3mr9562699a91.6.1789603423966;
        Wed, 16 Sep 2026 17:03:43 -0700 (PDT)
X-Received: by 2002:a17:90b:1c0a:b0:39d:f247:bab with SMTP id 98e67ed59e1d1-39e1e2cecb3mr9562636a91.6.1789603423446;
        Wed, 16 Sep 2026 17:03:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5aee8b0sm21282976eec.23.2026.09.16.17.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 17:03:42 -0700 (PDT)
Message-ID: <073070a2-f46f-4016-95ab-1c407b0e632a@broadcom.com>
Date: Wed, 16 Sep 2026 17:03:41 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] PCI: brcmstb: Declare and assign flag IS_BMIPS
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
 <20260911233541.1650895-7-james.quinlan@broadcom.com>
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
In-Reply-To: <20260911233541.1650895-7-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/11/26 16:35, Jim Quinlan wrote:
> Eliminate a function that evaluates SoC chip IDs and instead declare and
> use a flag that indicates the SoC employs a CPU with a variant of the
> MIPS-1 ISA.

Uber nitpicking, but I think you meant MIPS32r1 ISA here, MIPS-1 dates 
back from 1985.

> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
