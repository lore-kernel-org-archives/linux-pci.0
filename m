Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35674F85B3;
	Mon, 28 Sep 2026 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632273; cv=none; b=r+TtjWUzYZu7Inyg6+bOyTa/0ZbwiCLkrFqAZTvtgKavNp20rFatE74LYg83GR9qe3CUmTTUi1bm31UrH1idcoDs8luzgtE8pLqlL0dyhW4xYmll+OGBZea38YrwYD8/F7ST07WylbPfd4ah/upHIMsGsMzKhX/pyz/Hzpk5kaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632273; c=relaxed/simple;
	bh=hLQvM51VfWe7UhmlcmiD4yUBGSetQkSqLKSCQeGkv/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=g1Amh6fHVdLk1yNUI5BRHLBgDBwJCCIIbMHrtqsf69VjnNF51vc5JQqhWZtA9jUjRGN6UVYZQ3XkUTsQEocSZgsMDRl5K8KCm5MgmWbZqYjDt73CML0TNrRXiubvAJf5LWMEEi5QJLTUjyS/R1u+EwZ12Tp0JGTLmpZU8bB/y9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6Avh3cj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6Avh3cj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E961F00898;
	Mon, 28 Sep 2026 21:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790632271;
	bh=8omIOHhw+uZwY84ggyKbDZolc6RD3clHULLyKqCQ5H4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=I6Avh3cjEKRwD9CabIrOhx9ysMlXH8SxulnHRCFe9AGF3GpLfHLPDI86yu6BE9yiK
	 xrcDpTUPHThX3Nba7GaBRLnOntDkIRZImQgFOiHMYqfRFuoPdH6LqqdLERewePmUDZ
	 VT9flbNSKsNTClvkLK5PfhZcqPDUxhH8WnKLu+5F3ZXSVc3Nj4li6GU/HxcoathddL
	 iRE0idYGJtkcPgvaVmrmjAE/ALJNWC7XhGogquYF4bYTeLBhu665rRmXY4+kcRcbCa
	 IRQI98ieNBG3SKokpLxosPgO6xP47mtQXuNR8MTbzMcu2MIzaoZz5nkl+06XTPuKnx
	 rjlan8ve1mp+w==
Date: Mon, 28 Sep 2026 16:51:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, mani@kernel.org, yue.wang@amlogic.com,
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, cassel@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Feizhou Yu <yufeizhou201@163.com>
Subject: Re: [PATCH 1/2] PCI: dwc: Align register macros with Synopsys
 documentation
Message-ID: <20260928215110.GA2266447@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928215007.GA2264960@bhelgaas>

On Mon, Sep 28, 2026 at 04:50:09PM -0500, Bjorn Helgaas wrote:
> On Sat, Sep 12, 2026 at 12:25:36AM +0800, Hans Zhang wrote:
> > The DWC PCIe register and field macros are inconsistently named and
> > often do not match the Synopsys DesignWare PCIe Controller Reference
> > Manual.  This makes it harder to cross-reference the code with the
> > documentation when debugging or maintaining the driver.
> 
> > +#define  PORT_AFAC_L0S_ELS		24		/* L0s Entrance Latency shift */
> > +#define  PORT_AFAC_L0S_ELM		GENMASK(26, 24)	/* L0s Entrance Latency mask */
> > +#define  PORT_AFAC_L1_ELS		27		/* L1 Entrance Latency shift */
> > +#define  PORT_AFAC_L1_ELM		GENMASK(29, 27)	/* L1 Entrance Latency mask */
> 
> Surely we don't need both the shift and the mask?  Maybe a separate
> patch convert to FIELD_PREP()?

Oops, sorry, didn't notice that Mani had already applied these.  This
could be material for follow-on patches.

> > +#define  GEN3_CTRL_RATE_SHADOW_SEL_SHIFT 24		/* Rate Shadow Select shift */
> > +#define  GEN3_CTRL_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)	/* Rate Shadow Select mask */
> 
> Ditto.
> 
> > +#define MSIX_DOORBELL			0x948
> > +#define  MSIX_DOORBELL_PF_SHIFT		24
> 
> Probably would be better to define a mask so we have the position
> *and* the width.
> 
> > @@ -621,15 +621,15 @@ static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
> >  	u32 val;
> >  
> >  	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
> > -				PCIE_RAS_DES_EVENT_COUNTER_CONTROL);
> > +				RAS_DES_EVENT_COUNTER_CONTROL);
> >  	val &= ~(EVENT_COUNTER_EVENT_SEL_MASK << EVENT_COUNTER_EVENT_SEL_SHIFT);
> >  	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
> >  	val |= event << EVENT_COUNTER_EVENT_SEL_SHIFT;
> >  	val |= EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
> 
> Probably a good chance to convert these to FIELD_PREP() etc. as well,
> maybe in a separate patch.
