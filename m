Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882C7418363
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603176; cv=none; b=B3MzNaO7YYhIQG5PBXr64yn7QdZnxKrzk2kPVUXI0w+4gs8ilfrZUnHASyKvSI8TVTJjLoXUB/lVhTKHIk/iitvPjG7nX6yUPa6w6L+kS+5hyDq7RoGG4NLESkp2stUiFes7WxwYwAz5Spa7l0uLyo23zjD/0mmagUUfJCDqaa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603176; c=relaxed/simple;
	bh=iZDTSEutdlzrNt+HsK0gMg7KCjGzgbTctzIAFcA3ZWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5NpJLSSFptXbWFTxfz5Ba3ZDwcCcStcyp5hQHnj9pfA4zPNpPq59/PlH3oVAbDwZdW0vWrt8pZSBcfcPQt1ZLjR0JjHD8bF3Pso2U3YPbGUCwt0OZrNtayFOf9KZRpEilAs8+kFiK1pBlJin87HHYbmf7pD7XhxstqxDG8dWFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LEYFL6rs; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LEYFL6rs"
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-910316a2fc9so742346d6.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 16:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789603174; x=1790207974;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=V0OARD0PLF4mIwzcACpuZC6ushW9KkulR8L/wcLq6TE=;
        b=oHS56v5Mo0t3aSKf4PgOhM2KFvlpx98qe15Npp2cbU8uxuIKq4MZRrwVPy2VeH2y6U
         We2VrJsVHDcaYjdyWLy7GNOhSkfAfIvBBklKJhIB0MKbU6iDo7eRFqOf1XCy74B64yeh
         bhtxHFDlKPRx8yVezMajLcrc7Vq1A8Aqol9xWFGbIgwN+P+o+Z7/XybhI2HTuXUSP68w
         HZplulYuS2ZLq0A+0Rq9fKx5CIRWaNWhSeX/vcEU2dVjmWkZWaRHa+LmrNSfJ1rENHBZ
         9+oS6rcAAM5oDrfz0CpEAlYYxdX0ci4+aTP6BZraGSwVZElyKZO6vIQKQSsrWG2yNXaX
         pdEw==
X-Forwarded-Encrypted: i=1; AKwUvBxiBlVYP5hJbHZMCqbXDNEQwVJWXNEZE3HCZiTdR/G0Jc+zeUur8b6eQEryd9naze/NIIlc8TxXZAA=@vger.kernel.org
X-Gm-Message-State: AFuF++maaW0A9Ezb0uiq8GTa1JrrwXa/6WpE3esCV7ce7mpoGD73aMr+
	g+7h0Bh8OqxhKqTuBFkLfIgyvdiJ2PGK9UctoldWFk0gySJMhLMyhzIXyfgqofgP/Vfo4PnPvaj
	9WEhUpPeVdtNmkenkYsBm2rUrXV1RFoqrILUe78XBq9l04JDa6f+zg+zwbcWtsP5goTbzEmYeha
	Gh3n0alPtgBrp0pFDPQbdEJnmBsTeTBDH8doDXKXSij65jBO2a4/zLV4gyHmGg4bKLPUEBabSsZ
	wATKw2h9Xst/PB8TJ0W
X-Gm-Gg: AYBFou2KCq4kkM8ZqHftThpFu7mqPsmzbEDXJnkFqCHDoxLmJ17CtyDpQOzyxuq265A
	mLn0taxOZH1ttF0b9idzqlzkzLmDloAMo+jghG1a3lnNY+7ivKXWZom4Zfm/x1l2wfncNZ+k55G
	EWw0jxHNBFIN4YiyP+yBU6FAmjQkswNBI6+f43sjlUCpoFHbDZY8LJe6Y/0vCl6odLKnwIND84X
	9NkpVJ1pV5cT1eUW/kbDSOm5aZuE8HQIZ3WMG0Eu5BkD3LmK8cxY2YG5kO2ebxKAJvbhsDx24pz
	++7DEDEAGigu9t/m9llsRPz1gnzxGvF4ry+dSjdMAu9+paeID7JjAlYT7JJY7WvPEZxaYsdkcx2
	9pnXQOHz6H1zPOIEhvCn3A3xc3UhlfvwBmEYt1QuM/kqkOKFTYpXPVF5ePwbYr1bbDnchHcq/aU
	j+YhLhdb29ZGToyena4tiJJZ5um/8LY7pwEAoU24bhP2g=
X-Received: by 2002:a05:6214:29c5:b0:912:32fa:399c with SMTP id 6a1803df08f44-9123d751f91mr82191326d6.12.1789603174189;
        Wed, 16 Sep 2026 16:59:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-9123be59af7sm862356d6.10.2026.09.16.16.59.33
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 16:59:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so226384a12.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 16:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789603173; x=1790207973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0OARD0PLF4mIwzcACpuZC6ushW9KkulR8L/wcLq6TE=;
        b=LEYFL6rsQkD1A3c7ONFpHBihET+pNZcB87/twudVGqsDB0slzUmKc61lGKQJbRqFdp
         G/jqFjY26fhX5YJgin6V30Q+9GABBtFFWPDWltD7aze0Rv/h+JWCv/6Z5kaRp/XcwgPj
         vmL++FjuuB26s6N5eGBAGwcHwoC4tmwsxDU8o=
X-Forwarded-Encrypted: i=1; AKwUvBwpiuugII+jXTSsPWvqN6Heifry9zFcsc4LMqBU+g5MjD2uKxin1Vn/xHMnYb7o/BQ2Mty/ZR5jYWU=@vger.kernel.org
X-Received: by 2002:a05:6a20:e212:b0:3cd:7ba2:e669 with SMTP id adf61e73a8af0-3dd5f45d85bmr11067013637.10.1789603172968;
        Wed, 16 Sep 2026 16:59:32 -0700 (PDT)
X-Received: by 2002:a05:6a20:e212:b0:3cd:7ba2:e669 with SMTP id adf61e73a8af0-3dd5f45d85bmr11066949637.10.1789603172424;
        Wed, 16 Sep 2026 16:59:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a6a175sm11074324eec.9.2026.09.16.16.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 16:59:31 -0700 (PDT)
Message-ID: <9a741390-503b-403d-a34d-d4919edf1d8c@broadcom.com>
Date: Wed, 16 Sep 2026 16:59:30 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] PCI: brcmstb: Remove redundant const specifier for
 struct fields
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
 <20260911233541.1650895-2-james.quinlan@broadcom.com>
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
In-Reply-To: <20260911233541.1650895-2-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/11/26 16:35, Jim Quinlan wrote:
> All of the variables using this particular structure are declared as const.
> There is no reason to declare its individual fields as being const.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
