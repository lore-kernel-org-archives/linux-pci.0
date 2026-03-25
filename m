Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC123A6B9F
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433961; cv=none; b=T4SUaSXjcrcJmgwmnQ6ap78YmrSvdBdDPsb3yVnrVwsrnKtuMGxT/t189B0q0AR1X2QHNH0iDXb8xL9Tnbperighv96rslEuJG9SGzeIl3O8LPF4YMagebgfQWmidLkkJhs6icrfGqzauTiWGmXMPqhuqBcvV77NoahWdeZdbZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433961; c=relaxed/simple;
	bh=8GOOH1oj1RLl1iyMb1b33WJjS/mkbepPmhqd8Urwd4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sf85jsACoRqP5CUa/sdDATY5vMqqAyTseStWFgy4Xn+zX2qsS6d5VhFmEI4+TZ76ZZqfPfa73/OxqzZQRgEXB93mGAuWMPcxgBGw5LWNP31lizIAHcOmudct2VG5z54But8/9E+y/ITiEUK+I2Ggbn0vA8StfFCK+Dn0ailOD68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=B9LzHTlY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="B9LzHTlY"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so46783475e9.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 03:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1774433958; x=1775038758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+f07CFi59zJysxikJ3eCqXzT8HRAuTSO1UGqdwQtCY=;
        b=B9LzHTlY5t/ShvGMdy8+6Fv70cOx9w7uHEvbtU5QtVCNgOta4jzG/KQ9ji+JOM/TNL
         2jTUDwW02/aTMNU0YFzu2mMXG5C9POT2l1WiRbdgqiIuJHIt6y0kc+9fz1LsKL5rGNfc
         8niHZUi9Yto6/Ij2TgML8yvfK0zNKaw583vmGakrxqYCM7nurNM1Ek08F/oBGVP/xgf2
         4+EgXgrl710ZggGCVJlBOl8RsDy7c7FCOooYQYZXp6tqwr+tyP5xT1AOkxQhxvNOCTVp
         RFRWavT899uRrM8K9gCM5bnUSBkAuMWngd5fgi2lOMPDBHwjdNAAMJE/FibJFPDEd265
         2x5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774433958; x=1775038758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+f07CFi59zJysxikJ3eCqXzT8HRAuTSO1UGqdwQtCY=;
        b=FjqMrRcLhl/MKeRjlZ/5QXnQjwAG/6PX26JvVxxY5L2bpJrF9XOgCBx6t4fOXgJhhd
         DMDmDmlFLtH2d3IHPk1PrIeKwzxaQP7SRck08B1gORvPZYYkpNSZZt3MmqkkEr8Be5Z3
         xOiGVra/at5MyxvfT2RULS8HQymDaXSNMulxLz5fZp5tVV535IKuyiArdsrtm35+s4oI
         CqshYsZdycve1yifZo7fDC/do4CpywtDch6vCUxVN6XW2/el/wN3jiVeoxKlysMXTM4C
         aCAu8zfOHWk4Q0lBEgplj/+1xEKLcIq3oqRG3EppW1RGV8kTV7HfashAAlslB12i7pAM
         5gWA==
X-Forwarded-Encrypted: i=1; AJvYcCWDF8yJDBeKkXYvcekmCajm25WzuaOkPvHDbbJjBQ6mCv+HWpS772FWKQJ2EGCPwardIgGC7sV1f9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdhEVLoRZVPmhmp/tj7pbyNmsdfIfu7zPy26nX/yJyGENhXniF
	9xPtMcYdvQssqDaCgNfdeZxw6wPcbIrFKw9yneaKRTOuCjlsZH+u4P8vFM4JPsPa37s=
X-Gm-Gg: ATEYQzyYwILOE/JByyTN+h7Wf1ntzjP9EYGlmgYkqlc/shntZkHqNyRakadxqKbRikb
	ySXzxXbREB5XmLSZHSUsOMDlywE9lAUV+1QlyiLmrUtnfER/HFrGhkYRi6UIIooHoy/2aJ5gbd/
	6Y+nsiYLFMIgY7COcnui3fjtEMyi30nEWmJZgC4tWucMF0GN05kn3uIMCnYsrqSpdgNOjoCoYtS
	3dfygu/6vHVN/R2rzRbvV+iIAP1JKTY1/xYpOKK7/uK8XjA9sE3hedc9D8H2ZcBFCX65iMyzHkz
	meNqfWOL/qOna2AJV8RiTRIOMPweF/WOp4gUG2H9wgCSbHKWXW1qBRiuxF1k1ShCvtfpV4QvKhl
	yuR4LovdWV/yCAlkOw0ovo+fU5jegU2ctZcJZFoHVCPtLtRSYmFbOUy29MmzKDSu7HSaLDMzDWB
	sxMrnWDKHeGYu4dNhHtEr2+2Se25IB+MVSXNq5fvDTuQ==
X-Received: by 2002:a05:600c:83c6:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-48715fcc5acmr41628225e9.8.1774433957560;
        Wed, 25 Mar 2026 03:19:17 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871176391fsm109820675e9.12.2026.03.25.03.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 03:19:17 -0700 (PDT)
Message-ID: <c2c56940-e14d-44fb-9b9a-9aff70998bd7@tuxon.dev>
Date: Wed, 25 Mar 2026 12:19:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] PCI: rzg3s-host: Prepare System Controller handling
 for multiple PCIe channels
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260318124450.163471-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260318124450.163471-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Prabhakar,

On 3/18/26 14:44, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Prepare the driver to handle multiple PCIe channels with distinct System
> Controller register sets, as required by RZ/V2H(P). The current design
> stores a single sysc_info structure per SoC, which is insufficient for
> multi-channel configurations.
> 
> Introduce channel identifiers and extend struct rzg3s_pcie_soc_data to
> hold a sysc_info array indexed per PCIe channel. Add a channel field to
> struct rzg3s_pcie_host and select the appropriate System Controller
> information during probe based on the channel.
> 
> Keep existing single-channel SoCs functionally unchanged while
> preparing the driver for RZ/V2H(P) multi-channel support.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   drivers/pci/controller/pcie-rzg3s-host.c | 48 ++++++++++++++++--------
>   1 file changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index c61e011f8302..a629e861bbd0 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -241,6 +241,18 @@ struct rzg3s_pcie_msi {
>   	int irq;
>   };
>   
> +/**
> + * enum rzg3s_pcie_channel_id - RZ/G3S PCIe channel IDs
> + * @RZG3S_PCIE_CHANNEL_ID_0: PCIe channel 0
> + * @RZG3S_PCIE_CHANNEL_ID_1: PCIe channel 1
> + * @RZG3S_PCIE_CHANNEL_ID_MAX: Max PCIe channels
> + */
> +enum rzg3s_pcie_channel_id {
> +	RZG3S_PCIE_CHANNEL_ID_0,
> +	RZG3S_PCIE_CHANNEL_ID_1,

Just saying... based on Bjorn feedback on patch 3/5 the names used here would 
have to be adjusted accordingly. Maybe controller_id? Same for the other patches.

Thank you,
Claudiu
