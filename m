Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7681E59B672
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661220; cv=none; b=pD9YTOD8yVynEkeG8jWJcrHwmCqnkKh4D1PhKEi79De1elhFk8cppVZyaKuygK7j+rx8OrkgG5lxC846ZFJP+U7v+SFP6KFhWd78YaOTRuBTnD8Qfb7sv4z+k7GSKxle/Esxu1P41dra06YtRLJdp/qHqVwjMC1YnLdpOVVFnsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661220; c=relaxed/simple;
	bh=zu99EUyKu04qHSXSnN2pGp746UHvgDIIaYO80aLOXlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bW1ERxT2O6+inr4vH8/L2TUEwfOa2X3OrFcN4ikzX+FHiMCErJsnXelLDvEWIkdzwN9UV6NUU9SXD2UIarzFUIkYrouSlZC5in8yYDuEHiHwkjKoBeEGsBIa/Hii0PsKthuc2+RN7JBzSXGk0eJHR0EDz0X38UncUq7/ySANJ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FkHwAoiJ; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FkHwAoiJ"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2dcff8f44f2so5819575ad.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 09:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661219; x=1790266019;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5vgy7pM/Q+yzgmJx8Y4gFH5AEXLaNEKRG3IPtSFZXZg=;
        b=2R6KhwnS9DGwC1cI0bubVYa7a/utnPuy4kCtA6vQZwFSzSr8+i+BTyDDu8Ta0oRXMF
         CN4ZpZ/YCxWtJkjEYfIaqOYpm0KjlZLkeWIw3Ifh9KtBO7hKiiAX7OtG3TPHZ4yk/L7p
         yWMcrApWEFGubxl7MFzyr+hSEjjTrUN2H1U/002kEBqU5mqCaYX3YNBaYNOmPLBa3wSR
         HEYIe8kYjydCbKPRRbrzWu5VBACwb5bh8TTk8naRUNoy8AKWo1eDruJbxWMdtwat1iqZ
         LNVrUra1CtOhZBcF/YjvQF48Z4DXzSJ+dTmJ/bNkJl0lvEtiKnqrfQJKEymsuW88NplJ
         DGlg==
X-Forwarded-Encrypted: i=1; AKwUvBwyt5PQp1bm94B1sU169vIbMab7Jj7SAlrmDT2jYqiDlLzI0iJ87HQXJ2fWf2SUWoaM5EN/CQuLlf0=@vger.kernel.org
X-Gm-Message-State: AFuF++lpxCfRChZz0Kpr/8JPbLQHzg6H1vSsgFojJJBjNhO5nL1hZCMu
	qbgszZDraqRvbbG7qMHttSFz0ITMBvGaqhPh35HZNWLAYsmkx1wviWHGu+5Oc+2GQODMkbZMRUK
	BCwx4kmPGxkIT5AbFJ4m/JEx74jybehMd9gkEFEnHKrzk2qmbFeIDrnyK6E4qbsGEd7DXTYf9uw
	/o+rRViBxP8kNSO6tlpl2HsBs67y0rg9X+L0orPzQ+kZ1NQset++sQxCoSkmyRDEwoqfWIfP/IX
	oEQF7JANX3bMEKRFGhg
X-Gm-Gg: AYBFou00F7HwnUruVMps5zXH/qFtJxj1Rs7QE3zo2BxalvGSN1SN80C81cOk0czoQlG
	ctdA+u2lf0QqdayavRkb4xtNQ1HkjUFNQRhfBg6It6PTItvwy8QkSoAhPGmalGBNcZ5PwWu00XP
	2s/0eN4/1crsJjYlte/tXkNV7vcl0Mt96/XuvjMDxGmrKrfvUvzsSb+dOTkHnjfdDzziECUWg13
	Qwcnc+FTQtJD5AHkrJEHOxPBaXwTHUH/c31LvqZ6fJrtnukZdvHznBJemSIbKde8voSffCYbF0I
	3yxf9cXdyyaFeE3+iC0tapQP1/+kBpcemWgFVhIuXHOUrd32hb3fb94WtHAmpV6bfc52YV13QJb
	vm1O42Ewbf9P9yC99ZOoFfm+vAzpg/b9SJ0IzKdxJHkhh9SsXPDsdk7NalF+YK60EqlyhaPT8iB
	9AU7ndUkfnYfUVcnHQb5RBUbrpskT9XHLHmqRm9xUA
X-Received: by 2002:a17:903:1ac7:b0:2dd:60d:8b7c with SMTP id d9443c01a7336-2dd8e3f57f8mr170889395ad.13.1789661218820;
        Thu, 17 Sep 2026 09:06:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-98.dlp.protect.broadcom.com. [144.49.247.98])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2dd89eb8a58sm2639075ad.26.2026.09.17.09.06.58
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2026 09:06:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6f75c1219so19816635ad.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789661217; x=1790266017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vgy7pM/Q+yzgmJx8Y4gFH5AEXLaNEKRG3IPtSFZXZg=;
        b=FkHwAoiJ9CLPePd/Llx683SDkGTuDQtqaJ6TMv493sevpdoHO90d0wB0t099vvgyTC
         NCvZp0MWU4coKOGDn15YxqBcTul3iU6x96hMJSvplanct+iBPrrEdCsJtibgBjrxH/bW
         RiL+w0F34HfRtmOLbk5oDVFRvdwliT1A+eZe8=
X-Forwarded-Encrypted: i=1; AKwUvByk2DZWo8v/dY7t73wraapfZh5JcKqe3SrYU1ZEy393UjqQflad8YtxQ2UvLN7FiI5eKuLZ0Np/Po8=@vger.kernel.org
X-Received: by 2002:a17:902:d2c8:b0:2dd:278c:5eb with SMTP id d9443c01a7336-2dd8e3f5a13mr153455115ad.14.1789661216895;
        Thu, 17 Sep 2026 09:06:56 -0700 (PDT)
X-Received: by 2002:a17:902:d2c8:b0:2dd:278c:5eb with SMTP id d9443c01a7336-2dd8e3f5a13mr153454615ad.14.1789661216485;
        Thu, 17 Sep 2026 09:06:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d8ed77sm28778555ad.4.2026.09.17.09.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 09:06:55 -0700 (PDT)
Message-ID: <d0611a8b-e7a5-4ffb-aa7a-86b14196b6d7@broadcom.com>
Date: Thu, 17 Sep 2026 09:06:53 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] PCI: brcmstb: Declare and assign quirk
 32BIT_PCI_OPS
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
 <20260911233541.1650895-8-james.quinlan@broadcom.com>
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
In-Reply-To: <20260911233541.1650895-8-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/11/26 16:35, Jim Quinlan wrote:
> Declare a new quirk that indicates SoCs where the config-space accesses are
> restricted to 32bit R/W.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
