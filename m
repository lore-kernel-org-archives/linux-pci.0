Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22913ED109;
	Thu, 23 Apr 2026 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949480; cv=none; b=jQARBP29+8wNP6U/HQeQt6AEXaCscNrAOiYlIBglZbYW7QeUQO5DudGnQXT4fxWMajrm9pX7qmgIANzO/4DEDMi8N4wDkhdqyl7Um78N3pKP8VvFmRibB86cBOC8VLLieAwwLLw6uZiJbIXylxEHY7rBNhspIyZr6ReJGrZuzF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949480; c=relaxed/simple;
	bh=3KN/9xYClnbKmpip1Kg4BXkQ4NkWlYtHiVbzGlXqlc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGdsyZPY8RqipvDejH+6mcPv1oHdQnei4R8ZYBoCDsITsDf/1FZ2GNsrYV7uV06b4TCeToiMu2+BkehBx1J98JPTBdCzajHZAnkCl4zrpQ0WOCBBdWecHGT9m9XDKAv8BN107ssSoNo/kyhUBJ8LYNo0szcqVewhg3u4SxrJ2OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsT448tl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsT448tl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF96C2BCAF;
	Thu, 23 Apr 2026 13:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949480;
	bh=3KN/9xYClnbKmpip1Kg4BXkQ4NkWlYtHiVbzGlXqlc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsT448tl/xYct0rR1E+hiGErLn2sJSkpSyRWragF+IMTUwo2OtWo37yNvrKho8QZc
	 zEhJ7ISzM0SEdWfr3bHn407Km0B17u6GHQ/Ww67CO3ltIwZ9pjQ4wuv+w7LKWvuXZ3
	 RurIresRLswrN2rcUcIQKFH7fCA9BBithVDE53sj2o2A/aLf/g0oNyLRKFuDAI/H+b
	 1+yS1h289WEL5O8b/e8XJc+gPJJRMe4M5Y3yuz4QBX4WCo4OYbhavVefFYI39RFPm5
	 kBESXrfxirSFymO18VWKPW4WKRxJWsEkBR3A2jN4/jiCURPIny0dx2FEcab9SZNmWL
	 oR45LRdNOi7Qg==
Date: Thu, 23 Apr 2026 18:34:31 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root
 Complex driver
Message-ID: <yqxyjv2q4lp5ymb6mjzpldjp2folqsvu4qneaihapbchrcithl@tcj4gu3ez3wh>
References: <20260415-ultrarisc-pcie-v3-0-73f06e972616@ultrarisc.com>
 <20260415-ultrarisc-pcie-v3-3-73f06e972616@ultrarisc.com>
 <7n5b44ynbem2xve3twofaqunqlkw4aijatuuemujrfq5yd5mzq@5qnikt7ximd3>
 <177693928812.2917474.4251479012132866533.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177693928812.2917474.4251479012132866533.b4-reply@b4>

On Thu, Apr 23, 2026 at 06:14:48PM +0800, Jia Wang wrote:

[...]

> > > +	int ret;
> > > +
> > > +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > > +	if (!pcie)
> > > +		return -ENOMEM;
> > > +
> > > +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> > > +	if (!pci)
> > > +		return -ENOMEM;
> > > +
> > > +	pci->dev = dev;
> > > +	pci->ops = &dw_pcie_ops;
> > > +
> > > +	/* Set a default value suitable for at most 16 in and 16 out windows */
> > > +	pci->atu_size = SZ_8K;
> > > +	pci->max_link_speed = 4;
> > 
> > Get this from DT please... This can change between SoC revisions.
> >
> 
> During the v2 DT binding review, Krzysztof pointed out that since the
> properties are fixed for this hardware, they are deducible from the
> compatible string and should be dropped from the DT bindings.
> 
> The v2 discussion is here:
> https://lore.kernel.org/all/c60a712e-ecf3-4926-9947-0e593cdb921d@kernel.org/
> 
> I then moved them into the driver for v3. If future SoC revisions introduce
> variations, I'll update the driver to handle them accordingly.
> 
> Does this make sense?
> 

There are two uses of this property:

1. To provide default Max Link Speed of the Root Port(s) if the hardware default
value is wrong.'

2. To override the hardware default to workaround the hardware issues like
broken PCB routing etc...

For the first usecase, you need to check if this value different from
PCI_EXP_LNKCAP_SLS field of LNKCAP register? If not, you don't need to set it
in soc.dtsi/dt-binding and the DWC core will extract this value from the DBI
register.

For the second case, you don't need to define it in your controller dt-binding
with a default value and also in your soc.dtsi. Since this property is defined
in the dtschema [1], you can just include the property in board DTS file to
workaround hardware issues (board specific) and dtbs_check will not complain.

NOTE: For both cases, you don't need driver changes, since DWC core will handle
it.

- Mani

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml#L117

> > > +	pcie->pci = pci;
> > > +
> > > +	pp = &pci->pp;
> > > +
> > > +	platform_set_drvdata(pdev, pcie);
> > > +
> > > +	pp->irq = platform_get_irq(pdev, 1);
> > > +	if (pp->irq < 0)
> > > +		return pp->irq;
> > 
> > Who is requesting this IRQ?
> > 
> 
> Not needed. Will remove it in v4.
> 
> > > +
> > > +	pp->num_vectors = MAX_MSI_IRQS;
> > 
> > Are you sure your controller supports 256 MSIs with one SPI interrupt? It is
> > possible, but want to make sure it is the case.
> > 
> 
> Yes. The controller implements 8 MSI control blocks (i = 0..7), each
> providing 32 vectors, so 256 MSIs are supported. This is documented in the
> controller IP specification.
>

Ok, thanks for confirming.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
