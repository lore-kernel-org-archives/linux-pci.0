Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7678B4EB86E
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664478; cv=none; b=ZhCzkrvABrBBwfdxX2U2KQMpdxLpFZS6XC6/+Xblt2e1oDEk/Vx8ZNu3yyYoXMh0ONMQ+mWD69gIfbbWZyt2kLNVM4TnlSkMflqO9siJ3NSl5F43DqtwEzw76WsuTkbOXVzQqlMFnlMlfg/488/7ojzeA69PWAVE4tMxXjPtxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664478; c=relaxed/simple;
	bh=NcSOim9h8kyRSm5v9QF40ACjK5sIpIrMrCWpOXGumu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDkN2V7kwPl23ocHMewz1nA54O5UNPg5Vc8JBNaUVR6GAIWVr8kPFwavBjcbmweshj8RK8P/TokO+0qVu4TsKcfh9ZhNVNAUTysBca5XmoOJuivhNxDZ/BSN6MBk0/fuoiZSR6e9jymBfElCcmkXbiZfC+ZLWzLuYE8vehwoTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V6p7IXFG; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V6p7IXFG"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cc4aa0248cfso225026a12.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 10:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664477; x=1790269277;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8rCSqMUFH3Lxxpziks2c8kLHTQuu4M+hXz5ckQbu5Xs=;
        b=SGJ7PcbIH+KmMvYYl/Z+TJUTsFZlB4wTYUYj/zVJdM6oyAWQFkZ48EF0RXUkblzWy0
         xMxmgCwxqiJkbitXsp2G9v1b9sPPIXzFT3F3YvMoTIrz7lZ/njyWBdfmVKsjXMlvgw5j
         9SDzSAseDkcs4TUbEuJcLZZf3lGoyu9FcVLSRMCZ9mJhKyYDGjnnMa+9V1CGDrzRIf4Z
         5LuY11NHUkJW1VbAxaRzxv2e9uf2gQAkUWIXgthpAaJnISZeEVoVWbYURAOxxoY1X0N+
         HMaUjHYqsWeraWLTxcR9qBs8kyBkbLGoiAB/ty4TkDiKbWJFQPZ4iQZtvspMI7USw3xE
         Yfdw==
X-Forwarded-Encrypted: i=1; AKwUvBzQ6KPkswvJVgroiJhQLKLdbeWcsdri1l9Ant7Cd4vBqErAtyvhpdk8Fxv8wt6I3plFRWETrzkrKLI=@vger.kernel.org
X-Gm-Message-State: AFuF++mTPHAKeDz0lG0cZxtRM9lP3kbIJ36HLBxj8X+igO9xlkutHttB
	UmMBMARLQ2ehrRhXPyDxvOGIrUtfYODvt7Y5l+E77UB4+jaDEXzBXLsjHAI9YPFhNpk+Yr04kgd
	nMRqjGk48CluNnXyNKL20AJSI1W/QnI/KPxezApLpRWwIuXBuiuBzj2dEWS9WM1LI4qUA5fQA+a
	caBsz8yGj88NDm6V5mKmw4Pr1d9lcTkDjmXVHrskZ9UprJ2QoqSiydZ0ajT+lKabspiGF6T4Mn7
	viWDkqwEY0bTy0TBAlm
X-Gm-Gg: AYBFou0hHicYhRSlbcR7EJXb7NNlkxnHbuK7uNIBZmefYfNpDV3zHFuRACQ08Jc2Zek
	ku4z36FX0rXjIN8hdaxlfsNyUExATT8vdnSvxl8CuwnJsRbvYOAfrbz+Z3Yifh6JRIlztH8lCuq
	8apCv1AUVhW2AclNptThqMS5nzXen9GfmfNm3KL4HFDk0Jdi+sJQAd5op9LT+vxW5tWMOLtoYIn
	AlXoE6OnEpPHJ6t0vMbMSu1MtpYEHncWS2iy/YyQ6pCFSsgGemB76yiQi0I4pINV8KjwvhHmt72
	TX2tForT2F3lRqEImQ0DTR/ZA0AtJv+uXhH0NmQsHteAYVTPbSuxdn3Xr5cuvb+3qgpC1zKOFLt
	3C9GcOvsT+Tr/tGHUDkZ+sLw043fKlzkCRwO9YGL9JgvkNjoQ556SRZiXfFFbpqu+Kt+I1bzEDw
	WBfDDMhOO9AEiu8NIuQE9fDadqtgfS2ALcDhR84vj/
X-Received: by 2002:a05:6a20:2450:b0:3bf:49c8:f7b with SMTP id adf61e73a8af0-3dd5f587d2emr17617348637.13.1789664476571;
        Thu, 17 Sep 2026 10:01:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-98.dlp.protect.broadcom.com. [144.49.247.98])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-14395d60fc4sm265449c88.6.2026.09.17.10.01.16
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:01:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-530256c61b4so20870131cf.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 10:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789664475; x=1790269275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8rCSqMUFH3Lxxpziks2c8kLHTQuu4M+hXz5ckQbu5Xs=;
        b=V6p7IXFGwJ5foD94g8A3UiNatXt4u1UHZjYk++iC1hpO4ElBNmn6cdGmqrvwJqr/fF
         Dl7/FgfHW4dE1XODCpfubnvTyQ21iNazF/ZWXGUgl79OGxyjbeLEo6YrpiaGf/VBmiBH
         sSPeLovpXXpqAZLtcXu0suBapzCPeUtWqfFss=
X-Forwarded-Encrypted: i=1; AKwUvByENN30ueQ0TvrWzeJpavm8FZK4vfmg+GMjwECOhuhfKW/XsJCsFQlpzSmvmupfFvFV2YRL2wR6D5Y=@vger.kernel.org
X-Received: by 2002:a05:622a:1214:b0:530:42e5:f3a3 with SMTP id d75a77b69052e-5327f16318cmr121319841cf.44.1789664475140;
        Thu, 17 Sep 2026 10:01:15 -0700 (PDT)
X-Received: by 2002:a05:622a:1214:b0:530:42e5:f3a3 with SMTP id d75a77b69052e-5327f16318cmr121319081cf.44.1789664474364;
        Thu, 17 Sep 2026 10:01:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53291651dabsm20372241cf.10.2026.09.17.10.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:01:13 -0700 (PDT)
Message-ID: <85444883-ab1a-49a1-a356-27dd9f6b77cb@broadcom.com>
Date: Thu, 17 Sep 2026 10:01:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] PCI: brcmstb: Declare and assign quirk
 NO_RGR1_TIMER
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
 <20260911233541.1650895-9-james.quinlan@broadcom.com>
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
In-Reply-To: <20260911233541.1650895-9-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/11/26 16:35, Jim Quinlan wrote:
> Very few SoCs do not have an internal bus timer whose timeout value may be
> adusted for L1SS operation.  Declare this as a quirk and assign it
> accordingly.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
