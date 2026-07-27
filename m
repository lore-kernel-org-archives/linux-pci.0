Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2607243305C
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170917; cv=none; b=uV/4UqDXaVeGc3C35mjTJai/FcfEgU++yWFJ6/aX05B5IqjqQjVrU928BNZyJj5AvRCXsyzshO9OT6g1bZKAqGLL50vvSOP1ler2/eUkRwoa0awpeB/FRyU1ATHMiApDjtTe2V33lhK7qZlR+nB+Uw4CPP8f//WcVKXBGk5ZJcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170917; c=relaxed/simple;
	bh=zcmGT8/5/VJUdp28x5Mwie2NTL2JpsWh68Uu3M1hVOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDLB/xUCAonwbJ/9/fdq3qmeK95zcaHu9G7a5mqQ8YQLzj3MNfV3RyFV1PMe18O1uB5CYoeUL88xLJ3FIwinlD/lkXJNaIXrsh8pg5HJYUXqzV/Aenv1RUPnXCqI9ZksZMNZ11HN+Y/up5oAPhxItB4Qd2Je9W05aYL87VLLhwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KLiY7nKM; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KLiY7nKM"
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-51c149c5722so737291cf.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 09:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785170915; x=1785775715;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fuPRM2oHQdKy1nuzzj63RGBjL55V9ZOJNmKnMoykNIg=;
        b=VOLod74aYPmW33R4Ko277MXcfVGNH9vWcqJDYNzA9x06HiRgzRr8mStTsg1BGkfOHX
         I9AWJ7jWe4JusLktJZTcoSYZuUI98S+5vgQP37biK2nAWMvYhJSzIOQxoESUt8ceJMv7
         6/sVlav1oVlLitJktUYfRgokH5arEUC4FxTtP42LcL4axrujyvLSf1vHgmIUpQIkXAMj
         OgAWp2+kQqnn0D6v62PVE8fkH+21VXvUylAt0Ay3OyMnJz3n7pbGIXPJnT9JgammG5+u
         NWSM5L4yzsbadMIUI9vKebTDBGIIczDGWwYwMts+GslPmfmQrojSpHH+RDqVS2qFfrWm
         pbUw==
X-Gm-Message-State: AOJu0Yyq8i0UGugDYZmtgRMlqK//MBZxe9TQ5yYxDDuvZ05daItrTlJ8
	a2qutQz6y/km2PgD+qX8pIM3jS+WKyf4KzVeisdinub/C9B025G13odUsCWxbtgFlzbDcx008UX
	Mh5dq99wiaDUEBMGiP1WJE48FJN053qO4Vo+8NLvXh6v3R5W4suGLr71OsPIOXFLwmHRy0zcqSc
	DTMyddioKToSbYqIX1sd9olzdt3mmcmbVZLd7bJa09UWkJZO76cTckaG3R2eWu0BEOh0RWWs1W0
	HBCDOeTepX4hMDv3SE3
X-Gm-Gg: AR+sD122WhcaQD5uX2e76oOLZLXtsXP2p3S2aQadxp0UpFg8UVmVhq/bF+O73JgTBYw
	TTJMZQ6mhOQDUHNwffC1I9JxVT657Eh4wq3clMJzfDWiiNtdJpA/5wUvfGN4rQ3bqJOEh8TTzJg
	DiB/sslQfiqiZUJB6s98CEJ/D8GAfh1Wdp/I4EiQEPw1J72XUjYbmqFT5DpU2FyOTboAIW8h4WP
	Pz1ahTLnjS9/n/2lSW8mJMVsI9HqzCzDRXT/aGHlBJf+iS+F11XKJsEinkju306Wnpc52wWMTQ3
	tBAUPgegvWeegOFRkP+d4gh83v6/9P32+XpiFfOzC0bZdCu0Or9H/PCuz5oTwrh5UXwNGRPpEUp
	4sddBingXE/O/n/h/j8GOAdQUuI+5fPYnDCFXn6SDrHeyPqSvkZ5NoHatNJy58thWapESU2gX1d
	5NxWq6+JJy6fucMDCUQ3QlpOhV/BPNnZSrSO01OpZL
X-Received: by 2002:a05:622a:989:b0:517:63df:91a5 with SMTP id d75a77b69052e-529d1e70362mr2426181cf.19.1785170914720;
        Mon, 27 Jul 2026 09:48:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-529a29515c1sm1640891cf.16.2026.07.27.09.48.34
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2026 09:48:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so89899a91.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 09:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785170913; x=1785775713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuPRM2oHQdKy1nuzzj63RGBjL55V9ZOJNmKnMoykNIg=;
        b=KLiY7nKMsZ4Yaf/mXrQcSr85B48t5X6mYlDSxk9ReRIaEvDnc9je3FvpZO/L4dYQtI
         lAl4hB4Zgt/+V2TQy3OBcw6ccuw5CVJP7vwnTmqRoeDv1pYB5u1VZTdhDeJ9/BNFZKxJ
         iMrfLjWd3sO/Pm75OUqOvG9/3Z+3FDZxZi/GE=
X-Received: by 2002:a17:90b:3b45:b0:369:7491:7b24 with SMTP id 98e67ed59e1d1-38f643465e6mr262743a91.6.1785170913449;
        Mon, 27 Jul 2026 09:48:33 -0700 (PDT)
X-Received: by 2002:a17:90b:3b45:b0:369:7491:7b24 with SMTP id 98e67ed59e1d1-38f643465e6mr262686a91.6.1785170912906;
        Mon, 27 Jul 2026 09:48:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e52f0c6f2sm28019446c88.11.2026.07.27.09.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 09:48:32 -0700 (PDT)
Message-ID: <ab327dc1-f921-45cf-9e4a-fbbf0a116e27@broadcom.com>
Date: Mon, 27 Jul 2026 09:48:30 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: iproc: Use the EROM outbound window on BCMA
To: Semih Baskan <strst.gs@gmail.com>, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
 bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, rafal@milecki.pl
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, rosenp@gmail.com, rani.hod@gmail.com
References: <20260727140939.389-1-strst.gs@gmail.com>
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
In-Reply-To: <20260727140939.389-1-strst.gs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 7/27/26 07:09, Semih Baskan wrote:
> The PCIe outbound window base on Northstar depends on the PCIe Gen2 core
> revision. Revision 0x01 uses 0x08000000, 0x40000000 and 0x48000000 for
> controllers 0 to 2, while revision 0x07 (NS-B0) uses 0x08000000,
> 0x20000000 and 0x28000000. Broadcom's own driver branches on the core
> revision for exactly this reason.
> 
> bcm-ns.dtsi is shared by every Northstar SoC, so it cannot carry a value
> that is correct on both. Commit 767012397976 ("ARM: dts: BCM5301X:
> Describe PCIe controllers fully") gave the controllers a ranges property.
> The commit shipped in v7.1.
> 
> With that property present, two things go wrong with this driver:
> 
> devm_pci_alloc_host_bridge() parses those ranges and requests them, then
> this driver adds its own window and requests the whole list a second
> time, so every controller fails to probe with -EBUSY.
> 
> When the DT window is used, it is only correct on core revision 0x07. On
> revision 0x01 it points at an address the hardware does not decode, and
> the first MMIO access to a BAR takes an imprecise external abort.
> 
> The enumeration ROM reports the correct base for the revision actually
> present, and bcma already provides it as addr_s[0]. Drop any memory
> window that came from the device tree and use that instead, requesting
> only the window this driver owns. This makes the driver correct whether
> or not the DT describes a window.
> 
> The same commit also added compatible = "brcm,iproc-pcie", so these
> nodes now match pcie-iproc-platform. With CONFIG_PCIE_IPROC_PLATFORM
> enabled, which is the default on ARCH_BCM_IPROC, that driver binds them
> first and this driver's probe fails inside devm_pci_alloc_host_bridge().
> This patch fixes the configurations where the BCMA driver is the one in
> use; OpenWrt builds that way, with PCIE_IPROC_PLATFORM disabled. The
> platform path takes the DT window as-is and has the same wrong address
> on core revision 0x01, so that side needs a devicetree fix either way.
> 
> Tested on an ASUS RT-N18U (BCM47081) and a Linksys EA9200 (BCM4709),
> both core revision 0x01.
> 
> Fixes: 767012397976 ("ARM: dts: BCM5301X: Describe PCIe controllers fully")
> Tested-by: Rani Hod <rani.hod@gmail.com>
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Semih Baskan <strst.gs@gmail.com>
> ---
> Applies to v7.2-rc5. Related DT-side approach:
> https://lore.kernel.org/all/20260628231156.1254012-1-rosenp@gmail.com/

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
