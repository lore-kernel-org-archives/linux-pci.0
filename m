Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FF5187E5
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664552; cv=none; b=Mc/ENM1cBpS+i2uWy0Ccd7TBsEZTzBXLysZt9Cb1OqVO+XPbmUrTJ/jFMTyd+hOXqGI3RxxKHmLyZuMScALENQx49MAc41F/ikCIb7+4pmp2lbHtoXH9jrBZYXZQM4Cn/HJC6ZIB6uwmi7MyVJtvXsLmWvqE0ZLkpbPlZMmYoGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664552; c=relaxed/simple;
	bh=rtXiljV8uhOXpbV/UpT/8YNleU0lLMrAkZ4OSudho/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4iAlMVspXm95e6rkEN8kA1hR3uDqUh9/f4YcrSjjLtAY0O2WzwIu/GOiDNdgznTatCrww2Yh+ruzFnnUD73M6Ura3JPSaycvR5erSgmaJ5O4y4yEisU09odEG8pgUrBK7aNOskkRYzEqZU2UxK4xFrlN7rV7vpvMDlvyBx0qvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JztRO+1q; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JztRO+1q"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-8688e063cd8so381331b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 10:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664551; x=1790269351;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Qfn3wdW1gpkbyJCwfcMHDnOUrZzvlnPPmgTV0TGUklg=;
        b=R9FyPAJ9GddRqz0491Byy4aOgNsITcQrKWGIJYHnim5ZKlY5AncN3YVRJTTGu7Axi2
         aVNrjfXzgpcWBvQg+Mgza1/Yn8t/9oLm5JPzqoLMM8Xp80SAgbKKlOpznoyU+ZR9zbgV
         0VyquJxdkDtQduw5Pqv0EWzWE8PUlDy7oRfU0FhgIvMHCgW4/5ttICuxZDVjgcUEuICp
         kp4Ws5scWhty7uQ52CxEPTHtciwZw35vCAweD52+jFuq67IecXSdJuh4qoDR8jiH1uHd
         tyig2KbKvmzO0ZmXIxJJHw0f3W1+FkKzbUBksVJL75UITAf7HyBU3Q7jmxLm81/uZpT0
         OOwg==
X-Forwarded-Encrypted: i=1; AKwUvByEoyNGUWYPgsBJQwkDMeqm42EPRKjFm7pQ+uLOcn55jBjmrQ6Y79LItirJw3D1nxoR60RfPbEIiQk=@vger.kernel.org
X-Gm-Message-State: AFuF++mYq438pEw5Imf4/+J1J8q2VPXBD/rqHHxJoivHt764iru9fD0L
	o9wSfu5JJhd+f83UjPeoNEmRw0DpxFvrQrX17ReaLkbQGWQR9P5WIoa95SHtDy9GOpHRWq3l5Z6
	MAypzDUcMw1P/mzv0oiCZfz3XqBGgcZAbVHJffccFCxtNhsSDSOG0jkMOwA3Nyaw7u1Oxyz+Z+C
	leJAcuj3MeiEkZ3TtA/cDnUEuw3na0ZwCotJMPbNf9sbU/e+eoMNKrOQnaJTpmVsX0cdyr+QPvU
	BlzLEHXpMyulVcAkZ/o
X-Gm-Gg: AYBFou0fUL5ACkG98uLUyP8NjYn91JtGkI1zthGPdbeZrnI179e9P5J8A+HwjN9d13d
	gfId4ZsWtZhwBsS79Si/gQQvRIJtx0a/Kxqk9YutersB5k3/vjWNtIYq59uwunk4UnQKwxWkuxd
	Jlgi8Z0H1IKbT4za7fAtu3RgrN51d0kq7oRCTiJJ3lc/bzYKENK05k4jTZmurFv2y5UXl0zjjzc
	LoMS75KD8BQC3L7npApCMpwUPXfED/1Tgsi6Q3SDaKMRRYsPFJ43JIeUFWSvyBcz+1k0jnZ7WpP
	iFYSnmFAK7bCFxIxt1PIaIhbPxO6N6fgJ4P/Wsm0FEPNhEiWvXGj2tE/8a0u03CYqQRQeL1/eBK
	QFo5Ivi3rwKu6CF9vKXh+noH03U7EJSn8lB+AP9CqrTtwbRv3gXCS2WYNewIF3uCSfmYWBkp1HV
	4k/BBaGxeo97HKIZl7TlfzGOCuhJVDkYnnCQQlN/ekqek=
X-Received: by 2002:a05:6a21:7008:b0:3c3:b57b:627d with SMTP id adf61e73a8af0-3dd5f44a101mr19418927637.12.1789664550799;
        Thu, 17 Sep 2026 10:02:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc50abc1471sm2824980a12.4.2026.09.17.10.02.29
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:02:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c89704da8c7so1459871a12.0
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789664548; x=1790269348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qfn3wdW1gpkbyJCwfcMHDnOUrZzvlnPPmgTV0TGUklg=;
        b=JztRO+1qt1DGBQyyM4UoKhgoCw5N+uwe8ewpUeOiwJAMLwnp/T89JPaeYvEmyeciqa
         qchtAcvPSDn+o2HWyA2UBOWs3rvkABu6MFvpwhHZOkJANPmGVYMUpKcoiTsrWeYlDRZT
         ZQcO14qyOH/hlrW8jxBVG1JhqvZ/fAW3fJOkA=
X-Forwarded-Encrypted: i=1; AKwUvBy3TFLCwRVPgSAhuoXCBlR29WOn5rj67CSgXNq/CKXGKqd/gmbezdxj19/DIXN53WAh2CTD+ULnsz8=@vger.kernel.org
X-Received: by 2002:a05:6a20:72a6:b0:3c3:7179:a640 with SMTP id adf61e73a8af0-3dd5f3c0a6cmr18483886637.3.1789664547839;
        Thu, 17 Sep 2026 10:02:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a6:b0:3c3:7179:a640 with SMTP id adf61e73a8af0-3dd5f3c0a6cmr18483813637.3.1789664547377;
        Thu, 17 Sep 2026 10:02:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50aa987ccsm3699978a12.3.2026.09.17.10.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:02:26 -0700 (PDT)
Message-ID: <79467ff1-caf0-4bc5-bd5f-f6196659e690@broadcom.com>
Date: Thu, 17 Sep 2026 10:02:24 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] PCI: brcmstb: Declare and assign quirk
 PERST_PCIE_REV_CUTOFF
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
 <20260911233541.1650895-11-james.quinlan@broadcom.com>
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
In-Reply-To: <20260911233541.1650895-11-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/11/26 16:35, Jim Quinlan wrote:
> The SW behavior for asserting PERST# for some SoCs only works up to a
> specific PCIe HW version.  Declare this as a quirk and assign it
> accordingly.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
