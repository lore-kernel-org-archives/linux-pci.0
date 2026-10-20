Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514407;
	b=lkyTlqi0r+VjbCy/B1fTmG0m1BsR1vx4VGj/r7MZ/U+68txbnO9gXl6cV9RznlXNxLAu
	 3jQoIjLEEwSL9bqoDQ63G0Yj0Pca/3/mLi2/9JaspeQyBDQBNZGgzBdOvDKDWIkNTIA+C
	 sxVJqTLSvAGyPrKGvpzm1QCpGGq9656UXUGj3MH7NtTDm+oSzuICk91FIGRVovXjxeNFk
	 +NTk8/88JspBcj6Kur5Bo7hemj3o9yoaS5ZVU9f5SUfSf8xB3wW2fr4IhkXVggPJmJXCJ
	 ljhbJJO2sYvZdI7HuIz7M9Mhlzk/SP6f5ViJC/AqJbeHRlpI2sKBD97p1Su+qzoXbtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514407;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=h4e35O9vinCVQ3Dvv8AyNcp+IPtrtbVDIcNsVfa87Fg=;
	b=5K2xL2uCA99s8uJcE8LtRnMbnIIsep8sQI+lHiz427E2CdidG4YHl6UX/B82TCdgf7se
	 owuGAUhlUAHEvoUMbRPAslX9aPTwhm41rR615YrkAkxxXnYTBXcFaSR3hiACscvOulXSJ
	 LtuU5y6/Q+R56twqoq6z5QG4p13U8+HU7jUCFRT4ya7q/Z8kHiHvc7Y2rdEO9SgleJyGN
	 YDc8CnAfWCvpONXnkKTtM8bcABf/rk9ggmq9bczi7HIFUIhrsaeq0zA+VQsbQKbRRgD4V
	 bgUSUfMRzEP0bkhtk7YNoh5YrvSOeMeEpMwSvicZNoojvjjVRtv89B0WCcxlc+Yw9Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f5ZAn2ui;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC604606A33D
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 16:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC604606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f5ZAn2ui
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so2212720a91.2
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 09:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514406; x=1793119206;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=h4e35O9vinCVQ3Dvv8AyNcp+IPtrtbVDIcNsVfa87Fg=;
        b=FgM4+G49v4zr3frrkPS4PsnbAIORmDrmMREGsRInZ9RvTxUI1xP3UvadzwyuXFv36l
         p6Qm/PQieXwqrcWxGgAQ91v78bEQhESWG1hGKalCV+TT03uhMt0uUvdrNjeKCp0IGuAt
         R04/Ov44qV9hbmPUgRqM6C0bxujU+9STImJk1tM5EP3NZhffK61Ax5DyuI4asBZCXVO5
         5yRLC3+VtdrePtC9to1mUtrq6YZreSZWkHQeQbJM8JAiQsVJJrlOOFl+ZjUiXyVEj9tv
         W4IKAKqs35qTLUDZK2B3Uq7IdgqOdhiwZ9QDWRv02M4VthDGSw1fw1lCruPN3u9fpVmi
         Ovcw==
X-Forwarded-Encrypted: i=1; AKwUvBykbe2IcZFgLPpe81D2HSiJL2y+3Ff6tzFikNUvY/WtpBeITWY508OcuQSDD0G9nW5QAhy+0f4tiB8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7WJni6MxYHTQihrgjGrcUli0xNwkRAVc/lVl2/0GuH2qAY4xL
	UJJdezJ8Sxm+nmwTnU0rkRJq9/fD/YXEHK2R1MUlFspAz3CecjGncJ5ufKJ+QJe8PL2kEzITK4j
	ugHxkAp6HAbwzzKHruNgBvPwdzaDNS3OmUATIa22HUTtW9JzARrfnnmEmzDGrlGeRuVt9mWn4+X
	WfNStNxHrxjfw4Fulj4CSzFGLCTaMp+V4SDjrT3xPAhoICPe6oJrpD0H40Ryq/UdE1TCWwFuKBG
	A3dnwOoKH6TAv76T1+Q
X-Gm-Gg: AYBFou0rb2F73c1MbcZrf24K1E27XEZPxoLhItkmMYxk/cORx0BLE7/yQ0Yv3U9OkKv
	JcQcAuxSPYLlprsKESEjSCPuvucKO5MIhoej7qMWV72CyaVieqFkVE40FECGUuOUa9eGGxLi+8o
	4dbwDzn+9U35XBsuTkOwCPzk/JE/IT+Y1FYBkfI/rZIMNrxY0Paf31KtFJFesUSpOR4fZnGTKJa
	gA+Rc5xYKsFXM0FJwTSM2AKYZypIr50JWj6jky8SiM9kmVW41iGKNGVidHm/yiGHcAy/UCTEugM
	J2YKUSuAWlvI0ag5bpKUXB3Nbq3zO8qgj1wOHF6P1KZ1Xk3SkFJuah050ic8R1rzqDtMEixM/3v
	UD3JnvsJuHZ9Aisv7f2UkbIGX0xnnw97KKQ91API74hp+L3xhAp0sFz7kddSLEri6OFGtp+k6wR
	+E5MbS9RYkLyYfHRzd6dXFfIaDV7FZo4kPZUBlrgOmn08=
X-Received: by 2002:a17:90b:3e85:b0:3a7:82ef:bcdd with SMTP id 98e67ed59e1d1-3acef519f17mr10053728a91.41.1792514405857;
        Tue, 20 Oct 2026 09:40:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ad80b83bbfsm85390a91.0.2026.10.20.09.40.05
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2026 09:40:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91bc57d4d11so74409466d6.1
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792514405; x=1793119205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h4e35O9vinCVQ3Dvv8AyNcp+IPtrtbVDIcNsVfa87Fg=;
        b=f5ZAn2uisPrO4JPbTpZIaiPAlniZ1m3q9gcugHsL9B2seyjs95OenZNxs2SH1v5lpK
         JwwESNmIE7wZUSFPrO2JYciOg20S8vnx2u08K84gP510xqGhqXaQMwGvo1AVKclmkg5n
         OfW//GcLbQK3bPZW2UAcjTaqdS4/cIWzECA/g=
X-Forwarded-Encrypted: i=1; AKwUvBxiBTwMtZuh4TGDcjfNYnxr5WAt0mPkoo6M30oRlQiak4ssF0L7CX+y6lkH4oyRSIw8y73ImV3yzgo=@vger.kernel.org
X-Received: by 2002:a05:6214:62cc:20b0:91c:5ca:801b with SMTP id 6a1803df08f44-91c05ca85ccmr31567736d6.24.1792514404552;
        Tue, 20 Oct 2026 09:40:04 -0700 (PDT)
X-Received: by 2002:a05:6214:62cc:20b0:91c:5ca:801b with SMTP id 6a1803df08f44-91c05ca85ccmr31567116d6.24.1792514403938;
        Tue, 20 Oct 2026 09:40:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10bb221fsm2310886d6.20.2026.10.20.09.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 09:40:03 -0700 (PDT)
Message-ID: <14d6f296-c117-4f72-a5a6-a4e97fa32a0f@broadcom.com>
Date: Tue, 20 Oct 2026 09:40:00 -0700
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
Subject: Re: [PATCH] PCI: iproc: Skip BCMA-attached controllers in the
 platform bus driver
To: Semih Baskan <strst.gs@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
References: <20261019065249.552-1-strst.gs@gmail.com>
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
In-Reply-To: <20261019065249.552-1-strst.gs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/18/26 23:52, Semih Baskan wrote:
> Since commit 767012397976 ("ARM: dts: BCM5301X: Describe PCIe
> controllers fully"), the Northstar PCIe nodes under the "brcm,bus-axi"
> node have compatible = "brcm,iproc-pcie". bcma_bus_register() creates
> platform devices for the children of that node before it registers its
> own cores, so pcie-iproc-platform probes these controllers before
> pcie-iproc-bcma does, as IPROC_PCIE_PAXB.
> 
> IPROC_PCIE_PAXB sets has_apb_err_disable, so the first config read on
> bus 1 reads APB_ERR_EN at offset 0xf40. The report in the Closes: link
> shows that read taking an external abort. On a BCM47081 (PCIe core
> revision 0x01) with a device behind the root port, the board does not
> boot, and it boots when has_apb_err_disable is cleared.
> 
> Return -ENODEV for a controller whose parent is "brcm,bus-axi", before
> the driver allocates or maps anything, so that the controller is left
> to pcie-iproc-bcma. The devicetree stays as it is. The check does not
> depend on CONFIG_PCIE_IPROC_BCMA, because a kernel with only
> pcie-iproc-platform does not boot on the BCM47081 either. On a BCM47094
> (core revision 0x07) pcie-iproc-platform enumerates the devices on its
> own, so there a kernel without CONFIG_PCIE_IPROC_BCMA loses PCIe, as
> before v7.1. CONFIG_PCIE_IPROC_BCMA defaults to y on ARCH_BCM_5301X.
> 
> Tested on an ASUS RT-N18U (BCM47081) on a 6.18 kernel with the
> controller/iproc-bcma changes backported. With both drivers enabled,
> pcie-iproc-bcma binds controller 0, the BCM4360 behind it enumerates
> and the platform driver logs nothing. With only pcie-iproc-platform
> enabled, the board boots without PCIe. Without this change, neither
> configuration boots on this board.
> 
> Fixes: 767012397976 ("ARM: dts: BCM5301X: Describe PCIe controllers fully")
> Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Closes: https://lore.kernel.org/r/0dcfb2db-5536-465a-bee1-afe160535748@broadcom.com
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> Signed-off-by: Semih Baskan <strst.gs@gmail.com>

On a SmartRG SR400-AC which is based upon BCM4708:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thank you Semih!
-- 
Florian
