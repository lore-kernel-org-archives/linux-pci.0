Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309434;
	b=Z1WrXcbK/Wi7An3qVyNOF7EYvNkHJ2FrwNhiawfIgFsbVYlco5juYHsNitZ2aQW/IG9Q
	 E0jbpiKM4DQ6Lr13bygqwO5s/3o7ak5GbfCV1BW8tFj5lbeXzfmFG/mBcMoGPdMqhsxAn
	 kf7D18H1b/FoVsogu788z1DPXB9kNsVclGvjN0fhBlUVa6a1JbNVwH3jyRrYiBlvJF/vz
	 7+LdDax/q9uZQQjUwinZtu+IFLlCWjkcRrZiaJHKEg0IkzYONLYYWli+rHRrs2DLOwkCG
	 GmY1Owy23Qar7kgRg51mxWqn/ET/OMr+xYUXj1xj3LuWdRQWft84xDsE1Z1Zr/FMfAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309434;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=0ua09dxb/+6Ms2fbyBUf/EPsfi1o/dMsdbIpjzPkg9M=;
	b=h5H7TcCJSS+kY2eOjTn+rxpISrpZIhANivNbd/5GVlVckMgmwrqz8CEgafQeVxlb7gf5
	 lXBqHpxkecHWVNo3UK20R6xMr7sP80RPJZJOZ69B6Ipz56kMTT0XvwKlLkYPHsshoqd4s
	 hvY+oFUp8vC0+BRM1y8joMlldAAdkxLAx0HlS786ZQKUaFKogI+X7nWQt8sdh+yxVEu/D
	 Yk0liSZIWOx6vUy9DA9+k/XYoqLBQMCAgIV15FLbrxlH+4WNngdyxvsjLC/sjM5YQEiy1
	 akgfiT/qTxFFY/zjOiYIgHIzJk/PTL3RDyDyqOVH8eazKvjDiUVB8Ciw4QrunHTAwKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MFuyOLLM;
	arc=none smtp.remote-ip=209.85.214.227
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40097606A325
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 21:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40097606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MFuyOLLM
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2e977109392so570205ad.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 14:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309433; x=1793914233;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0ua09dxb/+6Ms2fbyBUf/EPsfi1o/dMsdbIpjzPkg9M=;
        b=0XvW4TBuQb6J/MamhnxJd6n1qWRscX3caMu9cQ2LYbbwyV4mh9xvaVK0kEX03QER5j
         ddz6FLkT/RnFePMhLZCMXIO4fiEgobpmws2+8KpiFnOPpMy89sE/p8M/ViV1HH5nUa/c
         VyS6KCJ0lN5VDyOYeqdUc++mjwOWTrl5VltnAbnDNoQEogUX5yGkIvn2JPrMH1gQ1tj+
         XkeFlO1pDoM5pSFJKLTtu4b+tVrt9pYIhEzpVtssgdh7kRlg2XGdqTGRn0SrybAKPrrN
         UkqU30zrcHK8l8oKtltjQsmTRi9GgN2fixJm8L8RYSNgQqw1VLWOHi0xiAU08gL+fJiN
         ThGA==
X-Gm-Message-State: AFq9FYKR8j+aCJHj4qR+WJaTZiGsebGul5Zvjy5bjCqWx9IIJUm9EZXP
	MxYGlyE6v1hGOMC9P3iJmRwF1TdPC+gw1i1nK0F+okJI9pvV8ED86J/WMffq6UYA8MEh23cWiyz
	65IP+ZNm42mPrNlmk+gucgfxYt9jWMaw0iijosyK1ht+0GPMwL+Mqx9qXZLZxwNqSg4PT19ZFDD
	kv60ElMYN1MoUkFLGKYKNSHKFomJoFuyBisnB1vOyC2xaL1q9poZflL5OPq3cHzEoyC2q4dte7C
	t9Efx5VAB+C7lazjEL9kcc=
X-Gm-Gg: AYBFou0WK7YE9MEGWwKFl3zcpDJyxFEYOTgwQrfWMo2178J1PBAVbHTq/x/A/MRJNjU
	GUuDtLpUhouF6Gieippq2TFvMF0ee5JhLzGTP2VSst+Ugi1OAOuJjaVDuQITQOnx1VA27+2srUp
	MSH7PEA2TnLtJYLrCjlPddKsd/ejauVI0e99oUlZHPynYbiUgu/Q6laOEsK7xdKwRtW32hZAu98
	hA5qF+zKEHZMCuEOJkzl6Uc9FOHcOkQdm4ZpMFqU4WtzzmWN12LGOPfmNduQTWpNE/WcLc2A3Kd
	P2vVP5bHCclTXDcbTCfOpyy2QwtWmHlp9jV1WCBMa6OrUeLxczi8gvAyTcvrcjRigbvw5PVm5je
	BcVrHs5xlBTxs7POk4OFQr1PR9x7h1aWet7uIkRMmyKJ5RVGgPS5OXJnDdYtvAysJ0kioiEYaxG
	a/EeOrVJK4W9FahOWnhzfHZQZsMG6V93ZPL6wAE6v9
X-Received: by 2002:a17:903:244c:b0:2e4:b37a:d577 with SMTP id d9443c01a7336-2eb36470807mr5713935ad.43.1793309433113;
        Thu, 29 Oct 2026 14:30:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2eb3693809bsm135905ad.28.2026.10.29.14.30.31
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:30:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f322ef7d3so1997885a.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 14:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793309431; x=1793914231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ua09dxb/+6Ms2fbyBUf/EPsfi1o/dMsdbIpjzPkg9M=;
        b=MFuyOLLM5SusVpE2u3jHtsYFE3m5WEmd7nis/oGKhpairQ6BYWxwLQFReEAXhWsfpF
         5EpTwEPoQ0cj+gGPRuRYATyaHugy7oadjqS16/Ab/w+8VILlPmFMMS27sAZxjl8GVU5a
         3/KtnhxEJTOYYzbog4eYxgQfrfAgCtlZm1VMw=
X-Received: by 2002:a05:620a:2805:b0:93f:31f0:6a88 with SMTP id af79cd13be357-944217e9062mr80859285a.65.1793309430667;
        Thu, 29 Oct 2026 14:30:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2805:b0:93f:31f0:6a88 with SMTP id af79cd13be357-944217e9062mr80854485a.65.1793309430072;
        Thu, 29 Oct 2026 14:30:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944210e6a20sm47317085a.4.2026.10.29.14.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:30:29 -0700 (PDT)
Message-ID: <441fb026-c377-4327-9478-b5ff6b16ea15@broadcom.com>
Date: Thu, 29 Oct 2026 14:30:26 -0700
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: iproc-msi: Bound events handled per IRQ
To: Eugen Hristev <ehristev@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261016-iproc-irq-v1-1-ebaaf027f29e@kernel.org>
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
In-Reply-To: <20261016-iproc-irq-v1-1-ebaaf027f29e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/16/26 05:18, 'Eugen Hristev' via BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> Limit each iProc MSI parent IRQ to 16 event-queue entries.
> 
> A continuously fed queue could otherwise keep the chained handler running
> and starve other work. The budget still drains pending events and lets the
> next parent interrupt continue processing, improving fairness and bounding
> interrupt-handler latency.
> 
> Without this starvation avoidance, one CPU can stall indefinitely
> in the loop and not serve other interrupts, timers, etc.
> 
> While testing it with an Ethernet NIC,  when too many MSI interrupts
> come in, CPU might get starved:
> 
> Connecting to host 192.168.30.1, port 5201
> [  5] local 192.168.30.2 port 52586 connected to 192.168.30.1 port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec   240 MBytes  2.01 Gbits/sec    2    334 KBytes
> [  5]   1.00-2.00   sec  63.2 MBytes   531 Mbits/sec    1   1.41 KBytes
> [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  177.568497] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  177.568913] rcu:     0-...!: (1 GPs behind) idle=28ac/1/0x4000000000000002 softirq=28922/28930 fqs=1
> [  177.569457] rcu:     (detected by 1, t=5256 jiffies, g=21629, q=819 ncpus=4)
> [  177.569870] Sending NMI from CPU 1 to CPUs 0:
> 
> With this bounded approach, IRQ handler will complete and continue
> to serve MSI events on the next handler invocation.
> 
> Assisted-by: Github Copilot
> Signed-off-by: Eugen Hristev <ehristev@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
