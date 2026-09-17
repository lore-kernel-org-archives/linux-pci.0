Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEDB2459CF
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 00:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603263; cv=none; b=YqV2hPoe/ou58m2uWpDIIxPgXYOmIG1CLH6Mnk3QXzFvWgkaE8X9ToSabIyFMVJy5+zP8WqE7pvSSh9y7OXoe1grrmRY9N/x7xf7jEHWe5tBePsHhIHnzziIQUtghPRYY0GVWB80Yopv33FmUWOSeraJwHbMdvfW11MsDvFSTNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603263; c=relaxed/simple;
	bh=IdWYhX7fUEenQ8Jfb3hg51Dx3Sy7F5AHXQddTv3Adeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOl7WHr+ztUJRK/FGvvoyxn5Ne0rvgYMyW7aVqN4LjTAx7xo2NjfMLPFUcmSThHcmvg0XcaPpWjFHQSgTjP9Ly+13BDI0WhDblaqDS+FP6yMR/QZbiorn9MRgJWxIJXtaK952oi7M/mclTPuUpFCSJir2sV/35265o/bjDuDxKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=csCSYJmU; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="csCSYJmU"
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-806a2a27a4bso110946a34.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 17:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789603256; x=1790208056;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rnYsw47RhsCpAUpS/1U4sBUyj70+B1dKJy3nD1W6Sig=;
        b=R80Myk7aP8VwJi/nputQm4I4nnvGTCylxVVKGsJXsW0lqeXFGdUUWwTSsRi+w63tnt
         kHE84qWSDtWWb8hRBrvE3zHmZROP1c6fOg6GhSm+epYMqcLsjFcD0Rv5JWysmh/qGkA8
         j0EI20lF17WfRObnXhXuKqAclw5hHTJ4Kd3xz8Q1O/vZOvRDEh3Q0+A6xL85+WBEi4qZ
         uAU9wv8cn40ANrY/YtQxD5c7uPjK7jKeeac3r8dOAVDcy/sGWS945lG4yOXFxAdheNlG
         dC6WYX16kGgmhk/Wan9TYpzfMH9vwjxk2WlhtLBXdOrhsVBc+RiViN+E4gD/BWLrDFvY
         qslg==
X-Forwarded-Encrypted: i=1; AKwUvBzfdTKvPdVKi32H5JNSbH3lSz6eoqfohHHxPT6owIYc0ZPiJ6RvbHdbUppZwPQYu5kCnd7XDYlaVKM=@vger.kernel.org
X-Gm-Message-State: AFuF++kHarba/rL1380ItkNnjCy6zfPoJXZNFmhhUR/N3KidOYtUGbaX
	0LH76ibB58fPGQDXabvyJYGMY1CxpExPD3xHk1QSZeoAZODdSgOJnYyQUgGOVNzK6pgn1rMvTpH
	6XaH0yfmh8eEqS1KJk5JlzW3WI5qd80Js6TJNQf5B5O9nSOfAt53WR8NvKOO8cv+ZluCjg/p4At
	VfeWgC3/umC2PDYyYq3hsCLN4kBGahjgYpbRkkB0f2pgtSfiLfflUu1azh9h+Is2WQLLhJ/IRmZ
	C4xNlK4xZWSuVDndvhH
X-Gm-Gg: AYBFou3Kx3Qpb0Wd3LeAutpOkM9MFYmlmPuP/vGnpe2R7F1jxeCu4FP4oPnN6j/wH+R
	35sJllbKpg+29MtT649Y2tLkj4c1dEMVUnLsZ09J0uciuF7B4i4Id5TGmvBOYOilZSSQTVwe9ft
	XZZyHndV47fzYzyQVfjGRU7/u/g3rjOulj2EIq1ePdSGvVO9+RP1dLu0WkIA6KaW2U06bJsBs4h
	qfUnt1HnOF0OAN+to4l6D3w6/Qfso7y8R5WeQTSXGzD6awEcyOiw0swieIg9n5Ln3pvMjKSsXy6
	CT3kRecbI4ADhIuCmy7VSzGk43zqUO1EVVlACQREY/JD/6WkxE+IE24DU64WLkTx7AL6Lhg5tCp
	gkp3Fgo0P2reTZtlDJwZ+BVmnx8ZUQzpUXKvgHKEL6pjFkfm4LvIylCXG+am6EEi5i1o/NVrrKu
	OOBX2qmV41maI/l4LBnONxbr77A8fiSJjoNM2cK1T4IqQ=
X-Received: by 2002:a05:6830:81cc:b0:7f6:705b:ffe7 with SMTP id 46e09a7af769-80b2e8600c2mr8949777a34.14.1789603255642;
        Wed, 16 Sep 2026 17:00:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-80c4629f89asm631527a34.4.2026.09.16.17.00.54
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 17:00:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so443570a91.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 17:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789603253; x=1790208053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rnYsw47RhsCpAUpS/1U4sBUyj70+B1dKJy3nD1W6Sig=;
        b=csCSYJmUSAD4KZ4z7qC7RSiXsYs1Trhft/ZmruAk7tejF5SiZ1vEzVj5N1R+N2g4DC
         NpXY42H8aO3mTf9sTYnNuhN7YM5cV7H872sw57/yFW+d0jc//tmDUVXjuu9hIKiiLbHZ
         CVZfwN6G8BLdIPGKywsYDAPMwWzDb8U+WjrrI=
X-Forwarded-Encrypted: i=1; AKwUvBzKvgTUPvy60mWzC3jCS28VCKnWjmtjcH7UIkncwhQiGACejTQaPyFPZk6UxFn6aNSHPJ8Dp/IAM4M=@vger.kernel.org
X-Received: by 2002:a17:90b:510a:b0:39e:423:bb8f with SMTP id 98e67ed59e1d1-39e1e24fa7amr14368869a91.1.1789603253360;
        Wed, 16 Sep 2026 17:00:53 -0700 (PDT)
X-Received: by 2002:a17:90b:510a:b0:39e:423:bb8f with SMTP id 98e67ed59e1d1-39e1e24fa7amr14368771a91.1.1789603252848;
        Wed, 16 Sep 2026 17:00:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5aee8b0sm21263234eec.23.2026.09.16.17.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 17:00:52 -0700 (PDT)
Message-ID: <f93d3063-956b-432d-a106-7b0e092d8ef5@broadcom.com>
Date: Wed, 16 Sep 2026 17:00:50 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] PCI: brcmstb: Add Broadcom quirks macro
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
 <20260911233541.1650895-4-james.quinlan@broadcom.com>
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
In-Reply-To: <20260911233541.1650895-4-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/11/26 16:35, Jim Quinlan wrote:
> Introduce a 'BQUIRK()' macro to shorten the calculation of a specific
> quirk's value.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
