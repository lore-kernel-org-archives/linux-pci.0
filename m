Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D41535FB2
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664526; cv=none; b=UVXrty/K9faM+Du4SIrCVCu7DrYTZHCJCuYrnsXQz+06ap4H96RreH6jkEdYLFHfP6iukY/8ZqxXMFI6QaQZpU89Ex9Amhkv+ZcM2/wAo+Hpo9zwP6UfRIODX8qw7+9F8bZUcGNYsifkMVxdkDC5DDDXbtlQfIEc596xj7oAuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664526; c=relaxed/simple;
	bh=jadr+WJrF70vnETwo0UNbvC7Se1rv6abIs/WIdU0USk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQ9GebOsnlc4UMVmGIYmOlHYmgKw2LGKAp6C8iOpOAe2bXC+akLE1H4fqMqD+ve0aledBSz8Pg6hf6CPZPzcaHjvsTFnhG79GaDlKa/Mu3d78qQpwYcLBe3GmRx0D308wPrCyhuTJ7oLJ2hbE2RicXHClSTWkcbmdCn0CtpYD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I3W47zhU; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I3W47zhU"
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-6b3671a1b20so332470eaf.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 10:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664523; x=1790269323;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gxPZVE1iSWk/YnSJluT38WV/TFUzwOd3jUqgVOgD/J4=;
        b=PdHqxcVo8Jd0rn5IyU8BqoWPLiRnorFSxHiaVhIfMtzS8rBQa+Va3Nr0fvoKUhOnYa
         s7SWJAEBB+IaB1XBEhwJDTgTYUiy06wBdzPksQvMV97YfYzFK5FgQrFyoJtOIshfJJab
         atSmsDewJ7Hr6ZT6+913h1vFuNeb0/7gD7p/c703tAGe3TsbbaIXEglHwftjHrLwaNkc
         +pJ2UCq+mGMAFAqcfzZsvWkP9ASt4MOCBhkKfjB4SzvRvkqYdqtYzI0z+8UzR6HG5MQz
         X+gRnD/a2Ivtdl0x1Xz58KADfxtA9ladhiOgxc34Mjf0tYvfwjOmGKMZRTYRsgPVVhF7
         e95A==
X-Forwarded-Encrypted: i=1; AKwUvBwPGqekFUAeUcmV83L+c3lC8y9pSHq3xpjbYA2rf9TrvXIEXSQvlUyN5A8+iJU/NBD7eudyCeSs+nI=@vger.kernel.org
X-Gm-Message-State: AFuF++naT5LmC2Qdla9WCwf/N0Ma/sjKR9QsWGb+1j6NeK77JKDVcVp5
	SsgDTng9oWlndQDsXKFt/NCBxO3Cao/7MtlqQ3IsxpbW+Brqei30alCQoxYkLn54DDL2r3iQikM
	EuYZir0gtBfL4rET7uQSb800PfpBLjskhiIY1biYMpHvFc5Y/9LRplHRuEJIBzm5laD3gZzW881
	ErEQiH6ZLHqYq8aVxpU+HKSmm9hlhG4mq+StXq+XT1/z7Hjm7qQa32v8KzyEJO4BU42OEPXW9VO
	cLnoA6kel9pV6QuFPr3
X-Gm-Gg: AYBFou21b7JXkMLavc+LfTvsFudNgrSnQ/KsQ8zQyd8/A/e9TMOtzkbm81VBF4Lvx4s
	qSdhdPJuYgf0eHuIOHy2VNihLXMeDPq3Llo6wDQ69LL4jrlSry7HEnOsxh14tT27TN+nXW2Kuj9
	jwrNAWWsoZRkVnjG3ePIxWhrzoq8V122APoTyNyXvn1bmtoN8Y/skyBn1LKIh3degpkqOD35E+W
	PlOuigh6gybYvexT4VfuS00/PWvOfH4MsnH4vuFEnHRbKJ4oRXiLhpOVDqNCHLR9KJveQTPWKR4
	YzH2Mk4DAOOf7ahf7Tb56FJqdceg8j+8q9KFbwWVpbePtKNz65a0Y8eF7qxjlugTXeE6yCz6Fyi
	75wRfriOsGvNAomTWsn9K3rZFwkjOh3DzoHJim+kMPc0GdzOGygfh4yPtpC+aiyje6FxWleGc2W
	siNUqv4C338niFCHpYZ6da4SvMaxZy9CDYWeKXRFcz
X-Received: by 2002:a05:6830:44aa:b0:7f8:4a55:cd97 with SMTP id 46e09a7af769-80b2ec5ab0dmr13260387a34.9.1789664520837;
        Thu, 17 Sep 2026 10:02:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-98.dlp.protect.broadcom.com. [144.49.247.98])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-80c468a2ea8sm1777507a34.5.2026.09.17.10.02.00
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:02:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8663802b58fso1308591b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 10:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789664519; x=1790269319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gxPZVE1iSWk/YnSJluT38WV/TFUzwOd3jUqgVOgD/J4=;
        b=I3W47zhU3ovjsLYptH78oo/XCNySKU8mp9Tq5hucFccwILN3PJbxaHhh3Ti97YeXp8
         06t9kQ6X54mcSGUTjoAamR6eZ2n9DzO/O1JjrjBvHIzUmf46eiVbvuPo4U7DoFsKfp67
         9Ar5X30Xq+5M1oGgMThRmNKdUnFzXgFtZ5tRs=
X-Forwarded-Encrypted: i=1; AKwUvBzFZsLogWAUOJdRU/oBoTLhcr7EvYBH2P7mglkNd2iOp2QzyQUsU1jp68nY7qDaySRSxh4DKDSSvhE=@vger.kernel.org
X-Received: by 2002:a05:6a00:bd0e:b0:868:e6d3:fc18 with SMTP id d2e1a72fcca58-8723878af11mr14585792b3a.15.1789664519363;
        Thu, 17 Sep 2026 10:01:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:bd0e:b0:868:e6d3:fc18 with SMTP id d2e1a72fcca58-8723878af11mr14585750b3a.15.1789664518960;
        Thu, 17 Sep 2026 10:01:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87201735415sm3213840b3a.42.2026.09.17.10.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:01:58 -0700 (PDT)
Message-ID: <e8ea945c-97a9-40ce-be06-896a701d8ac9@broadcom.com>
Date: Thu, 17 Sep 2026 10:01:55 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] PCI: brcmstb: Declare and assign quirk
 EARLY_PERST_ASSERT
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
 <20260911233541.1650895-10-james.quinlan@broadcom.com>
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
In-Reply-To: <20260911233541.1650895-10-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/11/26 16:35, Jim Quinlan wrote:
> Declare and assign a quirk where PERST# must be asserted prior to an
> internal bus being turned on.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
