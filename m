Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323442EB5B8
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 00:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603294; cv=none; b=jrDQId9fQZoKhN2nHmzc58KAffHtupItpYYL4tqIJ8mGK8KqroGbKe7aDrYdeeBEmbxZKdJVTaYOeGwIGp7Iii8HiyNNqF4Tl9G4hnd6/izB51qyJ64r3ABTodnGLmlUlGlBlT3mcAvE8R+D+ez0zuA/+pi0fl5LcmPOm/gkiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603294; c=relaxed/simple;
	bh=havp6OXbc7alV/WLx4jLw++iHS0bqicCCYO1lAy6GlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwAxcwtWXZIViGo1voK0zRP+MtjlIdlDZdAlXrBcVjzBT+84mbIzDmrdF6RZJoM4v6PXdhspKWoa0Z6RjFMfu3JkFy93A1X3dL8zuZzjHGjsotmDyYNrxEztlv6tIQfUTmEqlWMkyWQ943URJbpqoJI8Bt1Nhx4usLL1XdrG1xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eS4eVjPy; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eS4eVjPy"
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-93a14b1950cso7473585a.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 17:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789603278; x=1790208078;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=la3EFGPTmY4WhuQJZNNkENF+jYrhdOvMI5n97zyEnQ4=;
        b=fJ+UaoRtFPrs2AXL+81s0QErmeE384/xeNkEhNuf91NcmHIjqO91jMvu1pNIxC8iHU
         I0+2ILunk5pYV1HkFJ3/nnraxsoJ2HY/n3Z4T7MfpeZku6UkRUh8x3yTVYhoS8kw6oIX
         4hzyFEUHYDMzJLS1jEaGWE0GQTRfKC+Jye+n1QsXBcJVZBJuJMlZx6wiPSZbtA3tCZb/
         dE4QUKcrzVjE/09wvJ2OXdK9JnlLEOzv2ojK2m4fqgsYIx4Y9o2BlLKG5TWvIlmfvW+k
         YWDu0Etaal2rSechtlq+gVd7E47wMk+kfhmQ16JshZzBsjFmltzfq5ASJyWThaCimvi0
         Wo3Q==
X-Forwarded-Encrypted: i=1; AKwUvBw+pg6lbCqDjWpeOmfuSawpjlPiGbl49uH3iz7g2IOi9KND8Yx69bI8mlBH42UViVO8dzlrX5f+uCU=@vger.kernel.org
X-Gm-Message-State: AFuF++l9QDglv0uNGxJB9c0URazNCLxWw7zun4+JlPLw956qkOXj2FWN
	bpg3TYehYLQxYcrdxWMKqzxRUtRKmbAMaj28/4oKRfoPmK7+2xEPoq5lVhNJLURtD/RYjj/AJ8W
	e2KaaZlXuPzCEj0nlm9ujZXxdxZwjDG3oLdkUGkcTh5oMvxiok8TXhbHTv0JODKIPLGlWIlYUlh
	egf3qGhmYJ09VpJD/5A3sIpT19vYLNO0UINF4D4tldzm/u7+ZVtKl+4EMhxXcrc31JMYi6zijlS
	ehzrvRKF16Lj50njPKp
X-Gm-Gg: AYBFou0/4PjWRSPQQ6oATg4CEIMfpp7ddgX5AxFS5cySQHR7OjX+2aJ9bOdS34qByXQ
	t54tYNns1nAstIpm3ClBVTkx0qekcDkmOuif6X6LYAXJJFYik4wzqMUR+f7bQtCa2lB47ARaYpG
	AmsMeCMZiUeLKpa6HIFiKT+VzYb/lxwD/s7ksrhEuKcH6We+58h7e3OEd+F+w4wyrFX0MZosVuN
	fN7/za9DQjqW1le+ix7b9df9yYeAPg1w9sj+LQu5LfDKIuwXldsRol61/cUDd27FKry/A1UYmOU
	a5Ux8xJIrEPOkwNlnVkjNgGIiVXc/DV+s/P183wiYxWVz1JBhwbktETxBqELiD8RByW301TAr6G
	qBT2VAti0whu7qtR2Hg67xO2u99AaCq6XV6WqvfIlogbW0q1QyYj89uybvewNm/F7g7SZIaOqjP
	daCaCSgcOqZS3YztHQepSKF10pzetQVZTA/zHn9u9m
X-Received: by 2002:a05:620a:2312:10b0:93b:c07d:a6bb with SMTP id af79cd13be357-93bc07db157mr435964685a.16.1789603278118;
        Wed, 16 Sep 2026 17:01:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-98.dlp.protect.broadcom.com. [144.49.247.98])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93b7819c398sm43836385a.6.2026.09.16.17.01.17
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 17:01:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6c1538bc4c0so225058eaf.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 17:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789603276; x=1790208076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=la3EFGPTmY4WhuQJZNNkENF+jYrhdOvMI5n97zyEnQ4=;
        b=eS4eVjPyxKw/2QfKUhSBrrfLHNi3BP1ZeAVZpGMGTUPiQIU/VtnGXhIga2UqJP+lzd
         hTdt+4S2sVSPvlI/hXxv3s6Fq6rjMvaULhDT9hyyg72ECCp96K2GWZJtc9BilDqSHj6S
         mn1abzeWa7mzekKKOt/WoP/+4RCANGWdff4do=
X-Forwarded-Encrypted: i=1; AKwUvByr3rJCqQpP/j5/MoAJZNvIF+Y8lj+06s6s04Zd+yL4wWNmNKwYjlnGHvGFQ8Nu6mi2/NxoLDz84PA=@vger.kernel.org
X-Received: by 2002:a05:6820:8ca:b0:6b7:46e9:9708 with SMTP id 006d021491bc7-6c7d46e3955mr4212757eaf.56.1789603276076;
        Wed, 16 Sep 2026 17:01:16 -0700 (PDT)
X-Received: by 2002:a05:6820:8ca:b0:6b7:46e9:9708 with SMTP id 006d021491bc7-6c7d46e3955mr4212698eaf.56.1789603275627;
        Wed, 16 Sep 2026 17:01:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a6a182sm11174848eec.8.2026.09.16.17.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 17:01:15 -0700 (PDT)
Message-ID: <fbf36dfa-b3d4-4102-8573-1911814e93fa@broadcom.com>
Date: Wed, 16 Sep 2026 17:01:13 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] PCI: brcmstb: Declare and assign quirk
 OB_WIN_32BIT_ADDR
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
 <20260911233541.1650895-5-james.quinlan@broadcom.com>
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
In-Reply-To: <20260911233541.1650895-5-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/11/26 16:35, Jim Quinlan wrote:
> Even though only BMIPs chips have this quirk, it is more uniform and
> readable to define this specific quirk in which the outbound region must
> reside in the lower 4GB region.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
