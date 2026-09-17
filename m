Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B79350390B
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664984; cv=none; b=VS8PoYHVbhHwOR4NBuOB/OvXq+EItlYZHqTZTtiPZB+wGBMs02BB8wgmlY19WPBWt1yeCFlqildZjKPV6CSPE+62/xymXtqvJMC38SLwvLIu0PQ7i5QneEpId3zJ/4PdC1h6LqT4x4xihL8zgp2XTCUQn+06MjU6uw0QNvXd7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664984; c=relaxed/simple;
	bh=iERYCGZnUZkW2UKFoxm1TNZ+omkMIA/wVgi32lNR6UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsxx3NLiAvy/1DxmAgH1BlI8gyYngDe5qWhpcvIDX03bQFlylMtuFsB4nvCAPqyFatsKzLqrd4znvwy28WAlFR5gjRe2mkqyw+qYt83jbLHud/fCsFcbqos/In4GXaK0PACZ2EJd9BaSfJXtecK+ych1mZiGvKUvJ9NnfJaVD1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b1tq5QHR; arc=none smtp.client-ip=209.85.222.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b1tq5QHR"
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-98076bb236eso244605241.0
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 10:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664982; x=1790269782;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6ZBcYFlUWh2QD/UxUu1L+haLQxP28ejhx5/K8jLq5F0=;
        b=y7eEJOXpxSBVfR7QH1osy8F52HgsFUVJblhzK4SQeNWmE6Tw95a4rHV28Xe1Pwp58N
         z2lIqXp1Cj6clXhkLI0sW87GFfiHsrA0pzU2A68bWf0f5CpF/uk0zJ46FOlJSP6Lq//I
         kTycEB8ZGN1rSIVtn/uj9FGuQjkqmQIjmRsTAfV2chXHPIKELP2PW3QSIlMoEOXeLCBf
         q+C6v/RcNsXDdb9OHoyQwkga+TX/EoznUbQ2GJQxJkDQAoXa2oCbG5UJWJg4L4H6MKD6
         5eMv0XRr8JQBKJ2/ytrb8G4J1R2LEeGP+LzMl4iZsxzeYW/jeFKnqJNkdJkxEF4J8m57
         tZ+g==
X-Forwarded-Encrypted: i=1; AKwUvByzfrlGWODlUNuwc6fwLtShiabGuDsneqnWynU7WUNUh+m9c0FBk4sES7l0Uio2q5516Ts/zINb+eA=@vger.kernel.org
X-Gm-Message-State: AFuF++nXx2mLTC1F1bttfUah2wcmge50hUxwx8StLFIL/E4CH7BwMt76
	ah6LiI/2v0vHNjG0B2yR3yOIuQ6khAh/Hx4S6y6yqXdFKEOLhj6LJud1AGn6ozFJalQpW+cUjiN
	K83m0t5fcNqfTGZ4edStg+37CyybsKnqUOgCk50I5jAZl19/5W3u8lRXewSI/5KyByLWXpuym3F
	1DIIOeObmICAjq/YB/tyrq6Nwsg0FYhljrIL9NTgE+UnFESn0fEuchKjf5cceI2mjFFkcyN8z2m
	SIbd5oKB+asrortPkR2
X-Gm-Gg: AYBFou2+pG+74vgL+m0zYpTZV2RQRCEaWCWDCiQ6mONWibdK06kAKcxuvhCZ8ittDRR
	iOW2iAnmIdTEx5PfyJEuf1rXiDa7rK4NXrJmQkPhB/suq4iZO//7Nj8iY6hsvaWdrVJWA0u8LsD
	71xUklaNL94YRJIYEcPbHm5ZE4CMsz6iaPA/wmZX7xfBZPm+H2CM3D9UG7ldg8/swBZ7RrwKSLL
	gyyHrSScOIdjXH5dMISVw54PxNfqYMP5rtp44QiJmrn/fxEVdcRebr1jmy36VNKeUAm2MMSu8T8
	Y6O5xwf/rc0zivsBOgUnOgHFGEYB6vb5xqWWDHnKhfD0TRaQifeopILNNnS4b3sHFC6IDmsO5pn
	Xo+KfBzJe+9L1iZgQyzfY4/Iw/8AQOowt0qXyFgKnnydd+EH4eMnhMNjfGz/9VZDRaC2i2jTORH
	s9XYwV+YLbfT/2+XoM0VOmppklp1QLNlqka78WL0sB8bY=
X-Received: by 2002:a05:6102:149c:b0:7a1:f7d2:e828 with SMTP id ada2fe7eead31-7a204eb4c2dmr1435363137.33.1789664981809;
        Thu, 17 Sep 2026 10:09:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-9832326cf49sm1114090241.0.2026.09.17.10.09.41
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:09:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9394ad7f64aso156403585a.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789664981; x=1790269781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ZBcYFlUWh2QD/UxUu1L+haLQxP28ejhx5/K8jLq5F0=;
        b=b1tq5QHRuV3j//BzmwBtVIWmsqpeLM/4pI1wVMmxhx4cO8v01oxAxS7IR+ol6mNHDr
         ueQqWdPnbkeSsVhVMLYIfqyCqhrFstpSC4gZ3UndnK5d0GBxp7Vdc+adpdw7JuklCCPz
         tqbTj4lRdVy0FMDWQ0qK+hYelomDzBWVhGqyY=
X-Forwarded-Encrypted: i=1; AKwUvByyXTGgd0/OubBY1LB8vZj9pLt/1ScaGDd4c7XX7kF34pP+8ndILKEYincBPM+IuqI5GRQsn7iqFyA=@vger.kernel.org
X-Received: by 2002:a05:620a:a18d:10b0:93b:b849:d11e with SMTP id af79cd13be357-93bb849d318mr1128742785a.49.1789664981284;
        Thu, 17 Sep 2026 10:09:41 -0700 (PDT)
X-Received: by 2002:a05:620a:a18d:10b0:93b:b849:d11e with SMTP id af79cd13be357-93bb849d318mr1128738285a.49.1789664980874;
        Thu, 17 Sep 2026 10:09:40 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91252cc7ce2sm2236776d6.34.2026.09.17.10.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:09:40 -0700 (PDT)
Message-ID: <34743ec6-9f95-4be3-b941-a1873beea3ee@broadcom.com>
Date: Thu, 17 Sep 2026 10:09:37 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] PCI: brcmstb: Split up complicated function into
 two variants
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
 <20260911233541.1650895-14-james.quinlan@broadcom.com>
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
In-Reply-To: <20260911233541.1650895-14-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/11/26 16:35, Jim Quinlan wrote:
> The function brcm_pcie_get_inbound_wins() is abstruse.  Most of
> its code is used exclusively by older chips, where the PCIe HW employed a
> baroque internal inbound window mapping scheme which was an artifact for
> when the PCIe would be configured as an endpoint.
> 
> Create two variants of this function, one for the newer chips and one for
> the older chips, and assign them using the config_data structures.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
