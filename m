Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429966;
	b=G2NKH8jjwlaJCjaxsnbsys5zhG1clT4KdlXwAbASJyadNhLuYqC/4BN5bXnw2iEomLwS
	 XoF62PwRKYIm+44V7YQWswoQeGMsUTdU0Gf40zJV3CS09AA9SiiW6DWW7JiiORE5bO1CD
	 W8bdtjCu9176nVJqOQxgVfFZWdEoMfY/c7724dioruyoqDW5PBflcwaN98Ue0L6Xkccz7
	 Gc8IG3KA41QSDN29zmF6zyHJt6839+WTZjJwR2+cTqOOfz1Osz8jgqs2ReBQDofsgaGU1
	 WhtDMQd2O1dXSzSVAfjIkP5fVtQ4DxTIx6Mna+PLp8Q2zLOCKBm7jJK2kJ0kSFOyw3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429966;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=V1Xc7iFkjzCGIRQo4LcSGwHFG6PPZbZiVEOAPMlCxWw=;
	b=3kdTh2zyuxLmbmy4cGvrqBMkuAawi91RQTUxjQ6v7tx8TJyWvIrl2Vz5JgYAG43tQfJn
	 WJ7NrNdCUHCxvPXx75e2tPXiFMH0QFwgSF5dL3mFWXjx8pV6Xe8zAXE1xRJzjbHaa9Eoj
	 Ku+c8RpHLKI0sN0BsxwzYPGKuMscB0lw2ALecQJFT6hIyHkJWHGsksTiJPDx+NyoP3IGs
	 tn6F9TA1X2vRvQr4X7I1AA6xWPnsk9qkyDZV+yjyptzVWH2HfRoUdDR2Wc995rBC+LNrZ
	 8iEyyhCJv6UJ47q7zenvra531J2MI4Vwj1hMOmg/N70aHmTx3ke7mep9dEDvj+jb1/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0ZePHWa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C9F606A31A;
	Mon, 19 Oct 2026 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0ZePHWa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163EC1F000C4;
	Mon, 19 Oct 2026 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792429966;
	bh=V1Xc7iFkjzCGIRQo4LcSGwHFG6PPZbZiVEOAPMlCxWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=c0ZePHWa3M6dIet7q2dQ2VOCog+19zipEh/A1MtLxqwDgXu7AwpdGZSuuEa1OKQDu
	 noBxmOaVYR3zUmYc+3qO+aC3UcnTut9a+zpDvwFx+36DR4ONheRq+a5NhEv77zC2JB
	 +B+twNFnal89vOZUlBwyM/S2I51vIr/I9EQM7yLYLVtGJmPjUZ60E0BNUYlqkhAS9f
	 zQ2gcJ6whPjtgNfNxIkMm/5pDWu5krac+dEJMuY9ScZZLfcJ2sPzwdXMqUODC0UIvS
	 abM1t1/mLZYT5Y6f9UYU330Gjd3sg3CcRCll5AQllq7pnZIslrTL57EvpK0aaIvMKx
	 xQt1qHrO0uQFQ==
Date: Mon, 19 Oct 2026 12:12:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, jingoohan1@gmail.com, robh@kernel.org,
	a-garg7@ti.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Describe DWC PCIe fields with full masks and
 FIELD_PREP()
Message-ID: <20261019171244.GA2200874@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930013842.82476-1-18255117159@163.com>

On Wed, Sep 30, 2026 at 09:38:42AM +0800, Hans Zhang wrote:
> Several DWC PCIe register fields are described with a shift macro next
> to their mask, or with only a shift and the field width implied by the
> value written.  Document the field position and width in a single full
> mask and use FIELD_PREP() to encode it.
> 
> No functional change intended.

> @@ -278,15 +275,14 @@
>  #define RAS_DES_EVENT_COUNTER_CONTROL	0x8
>  #define EVENT_COUNTER_ALL_CLEAR		0x3
>  #define EVENT_COUNTER_ENABLE_ALL	0x7
> -#define EVENT_COUNTER_ENABLE_SHIFT	2
> -#define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(7, 0)
> -#define EVENT_COUNTER_EVENT_SEL_SHIFT	16
> +#define EVENT_COUNTER_ENABLE_MASK	GENMASK(4, 2)
> +#define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(23, 16)
> +#define EVENT_COUNTER_GROUP_SEL_MASK	GENMASK(27, 24)
>  #define EVENT_COUNTER_EVENT_Tx_L0S	0x2
>  #define EVENT_COUNTER_EVENT_Rx_L0S	0x3
>  #define EVENT_COUNTER_EVENT_L1		0x5
>  #define EVENT_COUNTER_EVENT_L1_1	0x7
>  #define EVENT_COUNTER_EVENT_L1_2	0x8
> -#define EVENT_COUNTER_GROUP_SEL_SHIFT	24
>  #define EVENT_COUNTER_GROUP_5		0x5
>  
>  #define RAS_DES_EVENT_COUNTER_DATA	0xc
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 8c610212a180..285a38178da8 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -622,10 +622,10 @@ static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
>  
>  	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
>  				RAS_DES_EVENT_COUNTER_CONTROL);
> -	val &= ~(EVENT_COUNTER_EVENT_SEL_MASK << EVENT_COUNTER_EVENT_SEL_SHIFT);
> -	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
> -	val |= event << EVENT_COUNTER_EVENT_SEL_SHIFT;
> -	val |= EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
> +	val &= ~EVENT_COUNTER_EVENT_SEL_MASK;
> +	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SEL_MASK, EVENT_COUNTER_GROUP_5);

Should EVENT_COUNTER_GROUP_SEL_MASK be cleared out before ORing
EVENT_COUNTER_GROUP_5 into it?

I see the previous code didn't clear it either, but I'm wondering if
this is a latent bug that should be fixed, probably with a separate
patch if so.

> +	val |= FIELD_PREP(EVENT_COUNTER_EVENT_SEL_MASK, event);
> +	val |= FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, EVENT_COUNTER_ENABLE_ALL);
>  	dw_pcie_writel_dbi(&pcie->pci, pcie->ras_des_cap +
>  			   RAS_DES_EVENT_COUNTER_CONTROL, val);
>  	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
