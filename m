Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E64357A3E;
	Fri, 24 Apr 2026 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018119; cv=none; b=j6y7UqmURo4wSMLnde3QF3LLk4dz6C3AUXuXf+kfCZArqCLT/HzYsyX26ZtFBvWwkD8+m+C/VyO56PLQA9GUNjnyt9YH3HShoj+PoJE1jeZHh+30G0ssgYA9ebfnbGvNK3H7rrOrVO+M+j49wAM7KIKgFXafKLNy7WHYJynJ4SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018119; c=relaxed/simple;
	bh=2TaKfA1MO3gCCHPa6GQ5SKhvOw5Nx4IuQUaFMqsRiB4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Q2bki0Dnf2LbSP5rgd/zCbjBBPtBKqwalrqAzFQfI4vfPvkaTt5lOkHtiEtXR3N1WhBKWN7IarUW3v2eng6eeEtFOZ6bOaIV/IEuEH3iGa3NqRBEMxeT/kdTgTJRmJzUY4GhOTvAatLpFxQ8cehiUa7mLcrcErOti4Sx2qhAkNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=nRF8tvkV; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="nRF8tvkV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=eTJGPHVC+FHEwbvDrrf6WzRnGbVhSBhMK
	KfoizHRA4g=; b=nRF8tvkVgIBhni7R7TB0byk3ixZnyLuhUb4oZqDsYaste+bWm
	2F2LhmtTRMyy/NwKD3TezMwgsKijDmXULScjMsK2ZdH9MJSrdN1gGULovCprVUrN
	8jtE56/Ims7IDktux+CTt6rNOmQUJm2JDE0HB/QUVV4XNlnd+1U+IhIrms=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cUISJetpHssCAA--.1691S2;
	Fri, 24 Apr 2026 16:08:50 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 3/3] PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root
 Complex driver
From: Jia Wang <wangjia@ultrarisc.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jia Wang <wangjia@ultrarisc.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <yqxyjv2q4lp5ymb6mjzpldjp2folqsvu4qneaihapbchrcithl@tcj4gu3ez3wh>
References: <20260415-ultrarisc-pcie-v3-0-73f06e972616@ultrarisc.com>
 <20260415-ultrarisc-pcie-v3-3-73f06e972616@ultrarisc.com>
 <7n5b44ynbem2xve3twofaqunqlkw4aijatuuemujrfq5yd5mzq@5qnikt7ximd3>
 <177693928812.2917474.4251479012132866533.b4-reply@b4>
 <yqxyjv2q4lp5ymb6mjzpldjp2folqsvu4qneaihapbchrcithl@tcj4gu3ez3wh>
Date: Fri, 24 Apr 2026 16:08:06 +0800
Message-Id: <177701808603.4074358.3746548668378362054.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777018086; l=3701;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=2TaKfA1MO3gCCHPa6GQ5SKhvOw5Nx4IuQUaFMqsRiB4=;
 b=I/9P90g2nhfwDMBKNn12m4VK/5/jAxo0LqnT2YIPypNbuHWxsf1jb8N+po2XAdN/NlSDoLaS8
 eA9zCU1hyvGBaNXmbtzDxb81W/SS6FgQf0Cv4g4nV9kQJvesw/kFyDw
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwA3cUISJetpHssCAA--.1691S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4UKF1kAw13Jry5Cr45ZFb_yoW5trWxpF
	W5GayjkF1vqFy0qr10qw48A3ZFyan5GF4j9rn8t34UAws8K3WIqr4DtF4Y9as7CryFkr1I
	vr1jqrWagFn8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAHEWnq6L8ACQATsZ

On 2026-04-23 18:34 +0530, Manivannan Sadhasivam wrote:
> On Thu, Apr 23, 2026 at 06:14:48PM +0800, Jia Wang wrote:
> 
> [...]
> 
> > > > +	int ret;
> > > > +
> > > > +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > > > +	if (!pcie)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> > > > +	if (!pci)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	pci->dev = dev;
> > > > +	pci->ops = &dw_pcie_ops;
> > > > +
> > > > +	/* Set a default value suitable for at most 16 in and 16 out windows */
> > > > +	pci->atu_size = SZ_8K;
> > > > +	pci->max_link_speed = 4;
> > > 
> > > Get this from DT please... This can change between SoC revisions.
> > >
> > 
> > During the v2 DT binding review, Krzysztof pointed out that since the
> > properties are fixed for this hardware, they are deducible from the
> > compatible string and should be dropped from the DT bindings.
> > 
> > The v2 discussion is here:
> > https://lore.kernel.org/all/c60a712e-ecf3-4926-9947-0e593cdb921d@kernel.org/
> > 
> > I then moved them into the driver for v3. If future SoC revisions introduce
> > variations, I'll update the driver to handle them accordingly.
> > 
> > Does this make sense?
> > 
> 
> There are two uses of this property:
> 
> 1. To provide default Max Link Speed of the Root Port(s) if the hardware default
> value is wrong.'
> 
> 2. To override the hardware default to workaround the hardware issues like
> broken PCB routing etc...
> 
> For the first usecase, you need to check if this value different from
> PCI_EXP_LNKCAP_SLS field of LNKCAP register? If not, you don't need to set it
> in soc.dtsi/dt-binding and the DWC core will extract this value from the DBI
> register.
> 
> For the second case, you don't need to define it in your controller dt-binding
> with a default value and also in your soc.dtsi. Since this property is defined
> in the dtschema [1], you can just include the property in board DTS file to
> workaround hardware issues (board specific) and dtbs_check will not complain.
> 
> NOTE: For both cases, you don't need driver changes, since DWC core will handle
> it.
> 
> - Mani
> 
> [1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml#L117
>

Thanks for the detailed explanation, Mani.

That makes perfect sense. I have confirmed that the hardware default value
for our SoC is correct and there is currently no need for board-level
overrides.

Following your suggestion, I will remove the hardcoded max-link-speed from
the driver in v4 and rely on the DWC core to handle it. If a board-level
workaround becomes necessary in the future, we can add the property in the
board DTS file without touching the driver.

> > > > +	pcie->pci = pci;
> > > > +
> > > > +	pp = &pci->pp;
> > > > +
> > > > +	platform_set_drvdata(pdev, pcie);
> > > > +
> > > > +	pp->irq = platform_get_irq(pdev, 1);
> > > > +	if (pp->irq < 0)
> > > > +		return pp->irq;
> > > 
> > > Who is requesting this IRQ?
> > > 
> > 
> > Not needed. Will remove it in v4.
> > 
> > > > +
> > > > +	pp->num_vectors = MAX_MSI_IRQS;
> > > 
> > > Are you sure your controller supports 256 MSIs with one SPI interrupt? It is
> > > possible, but want to make sure it is the case.
> > > 
> > 
> > Yes. The controller implements 8 MSI control blocks (i = 0..7), each
> > providing 32 vectors, so 256 MSIs are supported. This is documented in the
> > controller IP specification.
> >
> 
> Ok, thanks for confirming.
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
> 

Best Regards,
Jia Wang


