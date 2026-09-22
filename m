Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA125505DA;
	Tue, 22 Sep 2026 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113503; cv=none; b=HBCaTYXeewrius3La5m2wko1SNqPCfyRiegMXS/5wDDHCieN4UDVlKT8lGnx27k6jW/gyAR7V6HedaUL5z7Kyl6WigSn0jmTKXD04g//HuRyrTKXqGmgTpddnJmvkabwKZ6A51PirPdSxdwPAA2PNy8Wm8uysusEEQWr1d4ylaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113503; c=relaxed/simple;
	bh=gBzo+EHOdn1DjkcpbuOy64VJrO4vLE5HYis65t+FVBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5XpIli5Ik11moFTu+2BvQ+HtCqCVN000MfXnJulndA5E/xyIbiblMeuqY3FW1LrpWOLPuVvH87lnjwRCn2WOHOFcJNnR65iIU493dek12uwpsJQDTp1Ueh+IbvRpB0B9HSQEWoveots4KuiVzUhsAyjOY4gK7iMlYT3lkwCVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jlpCZ2GO; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Z38xECe4; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jlpCZ2GO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Z38xECe4"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hqDCG4YdczKnVM;
	Tue, 22 Sep 2026 23:44:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790113482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8ww+W67rRm7cCVAIm1K2+Wbrr/vqPQzVhRQ6cxefDY=;
	b=jlpCZ2GO+Vw+R030eHmwqyvR16S7fYHPku7U+veks4+zFU02UDWdhjYLyu/xbr8UlGqg4v
	o+mnYiRyZiCM5bnaI/xbWwg09z1/Ij2tzY74+d0nV2vV7CZT8DCoJM2m/jFTYyqH4mIHOZ
	ACtj59KMDMs+53xfwCLxA+O/ZLZPmiJEhg4+m822cTbWEAQPpVnmJGSaQ0tGH49t4QySOb
	Bgc6fgoNdInJxQoucwjFzQJIYo6g1cYFARJv0yUkqz6owTIPc2s4+1L07UVEvykIATYZrp
	CQxnNzb9lMESmS9434WNqcO5xgaSeep8/QR3oe2eb+EpCwVqT+/JzHTyqtxgLA==
Message-ID: <4e7d7c8b-3daa-4ab3-9de1-51468975c28d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790113481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8ww+W67rRm7cCVAIm1K2+Wbrr/vqPQzVhRQ6cxefDY=;
	b=Z38xECe4k4UOQGrwVVvCwtZjheL41AgRv/0Oq3L9+YZYiQIqIthWr62+maiSMLoqhub6hR
	eFA9ETKPWTZjfAg4eOJxhZr2ek1woDTzLbi3Z4lgvkbEgK6hobTo2Ne6nE3W/b4ax3TuU5
	cjwKIWCEWvhHu09QVAL+h8diJwh1P6FK7qkBlgR864bAJ/bX6TdpUdzWHF++D4mhzMx5QT
	lI73gAia41i6S61Jb8A/lJhNI8DgBiL72olllp71Yo2W/NEXu8YeJC6l6dNQlzpctmMC4W
	6soOqnkFExAI57wVfOqxXVgWkUmKczPt7osSut0aWqaFiJIMuViNXV9A/6axZA==
Date: Tue, 22 Sep 2026 23:22:01 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 06/11] PCI: rcar-gen4: Add Root Port reset support
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-7-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260918032038.2216471-7-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4dd553cb018a63465ac
X-MBO-RS-META: ynx1fpkfbq8mzbdi7b15kteq7mj458og

On 9/18/26 5:20 AM, Koichiro Den wrote:

[...]

> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

[...]

> @@ -90,12 +91,22 @@ struct rcar_gen4_pcie_drvdata {
>   	enum dw_pcie_device_mode mode;
>   };
>   
> +enum rcar_gen4_pcie_state {
> +	/* The controller is being reset and reinitialized */
> +	RCAR_PCIE_RESETTING,
> +};
> +
>   struct rcar_gen4_pcie {
>   	struct dw_pcie dw;
>   	void __iomem *base;
>   	void __iomem *phy_base;
>   	struct platform_device *pdev;
>   	const struct rcar_gen4_pcie_drvdata *drvdata;
> +	unsigned long state;

Can we simply use boolean flags here in struct rcar_gen4_pcie, instead 
of the enum rcar_gen4_pcie_state ?

> +	/* Protects APP interrupt enable registers and their software state. */
> +	raw_spinlock_t app_lock;
> +	/* Serializes Root Port hardware reinitialization. */
> +	struct mutex reset_lock;
>   };
>   #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
>   
> @@ -344,6 +355,33 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
>   	return 0;
>   }
>   
> +/* Whether the APP interrupt sources may currently be enabled. */
> +static bool rcar_gen4_pcie_irqs_blocked(struct rcar_gen4_pcie *rcar)
> +{
> +	return !!rcar->state;
> +}
> +
> +static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
> +{
> +	bool armed = !rcar_gen4_pcie_irqs_blocked(rcar);
> +	u32 val;
> +
> +	lockdep_assert_held(&rcar->app_lock);
> +
> +	val = readl(rcar->base + PCIEINTSTS0EN);
> +	val &= ~MSI_CTRL_INT;
> +	if (armed && pci_msi_enabled())
> +		val |= MSI_CTRL_INT;

Should this function cache the state of pci_msi_enabled() in struct 
rcar_gen4_pcie , so that in case rcar_gen4_pcie_irqs_blocked() reports 
MSIs as blocked at this point ...

> +	writel(val, rcar->base + PCIEINTSTS0EN);
> +}
> +
> +static void rcar_gen4_pcie_app_irq_sync(struct rcar_gen4_pcie *rcar)
> +{
> +	guard(raw_spinlock_irqsave)(&rcar->app_lock);
> +
> +	rcar_gen4_pcie_app_irq_sync_locked(rcar);

... this function can enable MSIs once it is called and MSIs are no 
longer blocked ?

> +}
> +
>   static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
>   {
>   	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);

[...]

-- 
Best regards,
Marek Vasut
