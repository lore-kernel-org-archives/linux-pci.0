Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6177D3BB9F7;
	Sat, 17 Oct 2026 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258402; cv=none; b=aAt6KKIMVTmf7sVBqDhPS1VVpFgjO7/jN5EiHnuZTExyCQU7ZWrFlqp735YK5MHM1rfS9D9UQXiJoGzUx23laWdYDJ/QoKF5C20TsWqf6LEeHVxv1HmZPQyfgM/cph0sqP1KR3BmRf1cYyNfG3Vh1/rrS0ScDKUErCSLwJQkwj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258402; c=relaxed/simple;
	bh=76yaNjZQUSh4WsPA4LA2b4uQJkmo4ebi0LP8pCdcmGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9TjBzlWk5YTtFx7vOem8Z8JGFipzdpRHoCQiII207dEEP4aW1EHKGf+8wPS2KNybWwTynJ7zMENNmXpr6u5rEewVqZVYHXdilIDgiGrH6VzeS8DSFjbQhNn2ox9JAsuax3sl7I6GRpMb+S2SJkDc7GiQ4QPri0VgRUxL2D2Dfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oee/gpMB; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oee/gpMB"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j6TRc5rTYzKnjj;
	Sat, 17 Oct 2026 19:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792258396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyOa76SG6y7SnZwUT9FEaC3XDtaClcrIC9Exo0pyRdA=;
	b=oee/gpMB5v/dKqyKmG+A+O6JxF6XRaj7I0rfquwjtjIDMt0qvP5aZ9dBtci8NF9DBpFqIw
	fFTsc85B3VtPWQfBa+2XJdTPk5qXcT/KQqzHgh6KEnT+D8rXiGD2V2Qk1EFIpIQWklyUXk
	IzLe4xO3gIKAbKO8lG+tzrtEznVUOqFXvNg2tOeA+6kupyHw7tw0iyQiRibym3SH4XKujB
	D8fRJ7VAXz/rkOIiMBepra9/IR8VSrTmtVZqKRdFbaoioSa+pIYfR6uC/aJRJR0HtPMiLo
	pRjWJduP8Ls1Uesu9CJgPp++NpWSyQh2ux2xaSLhI4TQ0PDeaz0HN3U6COgTkw==
Message-ID: <072cccd1-8fd4-41e5-a64c-3cc4dc0dee07@mailbox.org>
Date: Sat, 17 Oct 2026 14:46:32 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/18] PCI: rcar-gen4: Add Root Port reset support
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-10-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261015033103.3076869-10-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 43426674ca38631ce2e
X-MBO-RS-META: 9ongchh49kiyay61i8fktoggcdu47sbw

On 10/15/26 5:30 AM, Koichiro Den wrote:

[...]

> +static void rcar_gen4_pcie_app_irq_sync(struct rcar_gen4_pcie *rcar)
> +{
> +	guard(raw_spinlock_irqsave)(&rcar->app_lock);
> +
> +	rcar_gen4_pcie_app_irq_sync_locked(rcar);
> +}
> +
>   static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
>   {
>   	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
>   	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +	unsigned long flags;
>   	u32 val;
>   	int ret;
>   
> @@ -543,12 +589,7 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
>   	}
>   
>   	/* Configure MSI interrupt signal */
> -	val = readl(rcar->base + PCIEINTSTS0EN);
> -	if (pci_msi_enabled())
> -		val |= MSI_CTRL_INT;
> -	else
> -		val &= ~MSI_CTRL_INT;
> -	writel(val, rcar->base + PCIEINTSTS0EN);
> +	rcar_gen4_pcie_app_irq_sync(rcar);
>   
>   	return 0;
>   
> @@ -563,9 +604,11 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
>   	writel(0, rcar->base + AXIINTCCONT);
>   
>   	/* Deconfigure MSI interrupt signal */
> +	raw_spin_lock_irqsave(&rcar->app_lock, flags);

This is only a small nitpick. I wonder if you could use the same 
scoped_guard() {} call here instead of the raw_spin_lock_irqsave() and 
raw_spin_unlock_irqrestore() pair?

scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {

>   	val = readl(rcar->base + PCIEINTSTS0EN);
>   	val &= ~MSI_CTRL_INT;
>   	writel(val, rcar->base + PCIEINTSTS0EN);

}

> +	raw_spin_unlock_irqrestore(&rcar->app_lock, flags);
>   
>   	return ret;
>   }

Either way, this patch is

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you !
