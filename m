Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EEF3E2768;
	Fri,  2 Oct 2026 23:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983020; cv=none; b=VEiEAG+4hAGdp0d0iLc0IqZicohBnB1YV/S89D23UBavpbaq6PgoXRKolqZEiyloTi4slyEFYSLFH+gvw3osRw9zQLH05cKY0GpZOZXTzA0FUYkcrhugriEsQdh1ZKDu3TD+hONRGmnoTk0akebqZAm9PlJYnthtXlLlV1t3P1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983020; c=relaxed/simple;
	bh=StRsMBOGkUCT59H21lHuoxDoEz812ZnBVcotW+P/k1U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MKFt0cOVusHA+ARYGCT0wRhBCIeESeAj7vd8Xj6Mq3asy5NkaeKRVrTy5oCzmxAWyznRlRoDyao8ztOdQXe72E1DovpaULxNeRUWS3V9HZ8asEEdqZ6IZhlIXEFGwMarFVJUtwZbKtBRNLfidD4i5Qde4/692gWKi63KHOEjwIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hac3ApyD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hac3ApyD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1221F000FF;
	Fri,  2 Oct 2026 23:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790983017;
	bh=BFMQ42Vm2ul/v1PeouoEBmuuznJ+5bv+Px3ac1qSRNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Hac3ApyDA43Sj6U+YrH3pvBdnoPzfbvZuHXqUraAtDZyw193Mpm1zV7kGMwkoZVDG
	 /fXjzEjNRpe5spqqRn9SYQ6IqceHJRyCULWKBEMfSgsyoSGzcbm8AzFKK2sif2AJnj
	 iVv//9imEO0tON73rpFTquSSVnYVyuu2TlNZuDrTIuZL7qalV9AhGL3Bmkn/c8lpnh
	 hAD7BZp4jSA3T1DC1RZwQ60Y4kK1w+5fLo6m12HGk7hjAGmRDPy/HRGCyC/+2mpe1C
	 YLddWspOJbdBourWcPd2JJ9kSlmNDsSyrxxoMyaWfXNzlAv3GQzmkTzpT7FbEGIHM/
	 IdewPfAc/7eXA==
Date: Fri, 2 Oct 2026 18:16:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: daire.mcnamara@microchip.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org,
	linux-pci@vger.kernel.org, robh+dt@kernel.org,
	devicetree@vger.kernel.org, david.abdurachmanov@gmail.com,
	cyril.jean@microchip.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v21 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20261002231656.GA390603@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125162934.5335-4-daire.mcnamara@microchip.com>

On Mon, Jan 25, 2021 at 04:29:33PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> Add support for the Microchip PolarFire PCIe controller when
> configured in host (Root Complex) mode.
> ...

> +static inline struct clk *mc_pcie_init_clk(struct device *dev, const char *id)
> +{
> +	struct clk *clk;
> +	int ret;
> +
> +	clk = devm_clk_get_optional(dev, id);
> +	if (IS_ERR(clk))
> +		return clk;
> +	if (!clk)
> +		return clk;
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare, clk);

Internal sashiko review while backporting b12341b98d5a ("PCI: meson:
Propagate devm_add_action_or_reset() failure") suggests the same bug
here as was fixed by b12341b98d5a, e.g., failure of
devm_add_action_or_reset() might result in trying to initialize the
controller while clock is disabled.

> +
> +	return clk;
> +}
