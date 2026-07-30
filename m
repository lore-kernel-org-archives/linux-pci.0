Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5353E3A257E;
	Thu, 30 Jul 2026 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394125; cv=none; b=LsEcy2S4NXwITlZ08GEmur1PaQOdzT7qPtcWl+ok8Qyzjdi8owwYyBhU8bxHPw1uOXiVmIVQCtR+F599Vl6FdC5I4twxmTQcq+GK10GUrvc+KOQRZJPBCrjglGpLyNogIZnnPjP38t/cQxf8cp4ToycUW9VA7/P97WkqSqmYi2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394125; c=relaxed/simple;
	bh=w9JA1QWCYIXMKw/JtbhVTB+bYrfhAqw2nhIdfPjot54=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=rhVh+lSE8i0j+R92YdKmF8HkGOHArFZUS9yeg4FGUNvxFwGfOnRR+BEEG0cNBr7z4bkfMNB3NwKFX/F5MymXP/gL8lMHTCq083t8hwUBZfg9LcBPOF43wiRVzrZBiqLaYixYqbyeEqIyb1cz6QvsOo2im1HaNgggHSvaZS8u53g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=byvHLhPC; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="byvHLhPC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=LtOBVU2mUGvOXKtwiI8qRGDY4RMlDStVM
	VqXFMd4gPU=; b=byvHLhPCgV3KESFM652v6AUf5fqOGmpqubdSqX6B8OP0Y0ZOZ
	GnefcGY+eTGUjm72B/gyqHPV137nK74BCvVsI4R4k2FGJkSx+voxpf7IgHGYP7XX
	fqjTBry9x7/W/HyQL6KT+UqeiPEGq3E/uY+Z0gI+RR7gyEB5GIHUXqNhWQ=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cULT82pqA8gVAA--.18166S2;
	Thu, 30 Jul 2026 14:48:51 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 2/3] PCI: ultrarisc: get and enable DP1000 PCIe
 clocks
From: Jia Wang <wangjia@ultrarisc.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: wangjia@ultrarisc.com, Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <2n44tfzw26mfis3nvnre2fph4u2whns5xgxvdmcczyfebt6gt2@ln53o5bi773e>
References: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
 <20260714-ultrarisc-pci-clk-v3-2-e72723fc0ef1@ultrarisc.com>
 <2n44tfzw26mfis3nvnre2fph4u2whns5xgxvdmcczyfebt6gt2@ln53o5bi773e>
Date: Thu, 30 Jul 2026 14:48:23 +0800
Message-Id: <178539410375.553273.13405298466842007043.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785394104; l=5795;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=w9JA1QWCYIXMKw/JtbhVTB+bYrfhAqw2nhIdfPjot54=;
 b=SHVekOz1FBpGpvV/i2SigSv7c7JbgUKuDIJBbAYc8SEsjhsFJi85cn+OYYAs80AjwsN+0UfH+
 mRIw6pWqH3fDJJ9nQVtzkEqtxPFX6xjVxO0wmFkDBbzPdkhkquTHIs/
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwA3cULT82pqA8gVAA--.18166S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWrtrW7GFy8Kw4ruFW8Crg_yoW7Cw4xpa
	yUGa1YkF4DJryYgr4Svr1kZ3ZIyr1FyFW7JFZrK3W2vwnI9rn7trykG34avFyvkrWq93Wq
	va1jkFy7Can0q37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQADEWppeNMAFAACst

On 2026-07-29 15:48 +0200, Manivannan Sadhasivam wrote:
> On Tue, Jul 14, 2026 at 09:11:03AM +0800, Jia Wang via B4 Relay wrote:
> > From: Jia Wang <wangjia@ultrarisc.com>
> > 
> > Add the required core, dbi, and aux clocks for the DP1000 PCIe
> > controller and enable them before initializing the DesignWare host.
> > 
> > Also manage the clocks across system suspend and resume.
> > 
> > Fixes: 5fc35740c3b3 ("PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Complex driver")
> > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-ultrarisc.c | 102 ++++++++++++++++++++++++++--
> >  1 file changed, 95 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > index 6ee661ceff67..72ba5840b62d 100644
> > --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > @@ -5,6 +5,7 @@
> >   * Copyright (C) 2026 UltraRISC Technology (Shanghai) Co., Ltd.
> >   */
> >  
> > +#include <linux/clk.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/of_device.h>
> > @@ -23,6 +24,12 @@
> >  
> >  #define ULTRARISC_PCIE_COMP_TIMEOUT_65_210MS	0x6
> >  
> > +struct ultrarisc_pcie {
> > +	struct dw_pcie pci;
> > +	struct clk_bulk_data clks[3];
> > +	bool clks_enabled;
> > +};
> > +
> >  static struct pci_ops ultrarisc_pci_ops = {
> >  	.map_bus = dw_pcie_own_conf_map_bus,
> >  	.read = pci_generic_config_read32,
> > @@ -98,17 +105,66 @@ static const struct dw_pcie_ops dw_pcie_ops = {
> >  	.start_link = ultrarisc_pcie_start_link,
> >  };
> >  
> > +static int ultrarisc_pcie_enable_clks(struct ultrarisc_pcie *ultra)
> > +{
> > +	int ret;
> > +
> > +	if (ultra->clks_enabled)
> > +		return 0;
> > +
> 
> This check looks redundant and I don't see a need for the 'clks_enabled' flag.
> Just do:
> 
> 	return clk_bulk_prepare_enable();
>

Thanks for the review.

Agreed. I will remove clks_enabled and have ultrarisc_pcie_enable_clks()
return clk_bulk_prepare_enable() directly in the next version.

> > +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(ultra->clks), ultra->clks);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ultra->clks_enabled = true;
> > +
> > +	return 0;
> > +}
> > +
> > +static void ultrarisc_pcie_disable_clks(void *data)
> > +{
> > +	struct ultrarisc_pcie *ultra = data;
> > +
> > +	if (!ultra->clks_enabled)
> > +		return;
> > +
> > +	clk_bulk_disable_unprepare(ARRAY_SIZE(ultra->clks), ultra->clks);
> > +	ultra->clks_enabled = false;
> 
> Same here.
>

Agreed. I will make ultrarisc_pcie_disable_clks() call
clk_bulk_disable_unprepare() unconditionally in the next version.

> > +}
> > +
> > +static int ultrarisc_pcie_init_clks(struct ultrarisc_pcie *ultra)
> > +{
> > +	struct device *dev = ultra->pci.dev;
> > +	int ret;
> > +
> > +	ultra->clks[0].id = "core";
> > +	ultra->clks[1].id = "dbi";
> > +	ultra->clks[2].id = "aux";
> > +
> > +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(ultra->clks), ultra->clks);
> 
> Use devm_clk_bulk_get_all()
>

I used `devm_clk_bulk_get()` to make the driver require the "core", "dbi",
and "aux" clock names. Using `devm_clk_bulk_get_all()` would instead accept
the clocks without requiring those names. Is that intended, or is there a
requirement or convention I am missing?

> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to get clocks\n");
> > +
> > +	ret = ultrarisc_pcie_enable_clks(ultra);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to enable clocks\n");
> > +
> > +	return devm_add_action_or_reset(dev, ultrarisc_pcie_disable_clks, ultra);
> > +}
> > +
> >  static int ultrarisc_pcie_probe(struct platform_device *pdev)
> >  {
> > +	struct ultrarisc_pcie *ultra;
> >  	struct device *dev = &pdev->dev;
> >  	struct dw_pcie_rp *pp;
> >  	struct dw_pcie *pci;
> >  	int ret;
> >  
> > -	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> > -	if (!pci)
> > +	ultra = devm_kzalloc(dev, sizeof(*ultra), GFP_KERNEL);
> > +	if (!ultra)
> >  		return -ENOMEM;
> >  
> > +	pci = &ultra->pci;
> >  	pci->dev = dev;
> >  	pci->ops = &dw_pcie_ops;
> >  
> > @@ -117,7 +173,11 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
> >  
> >  	pp = &pci->pp;
> >  
> > -	platform_set_drvdata(pdev, pci);
> > +	platform_set_drvdata(pdev, ultra);
> > +
> > +	ret = ultrarisc_pcie_init_clks(ultra);
> > +	if (ret)
> > +		return ret;
> >  
> >  	pp->num_vectors = MAX_MSI_IRQS;
> >  	/* No L2/L3 Ready indication is available on this platform */
> > @@ -135,16 +195,44 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
> >  
> >  static int ultrarisc_pcie_suspend_noirq(struct device *dev)
> >  {
> > -	struct dw_pcie *pci = dev_get_drvdata(dev);
> > +	struct ultrarisc_pcie *ultra = dev_get_drvdata(dev);
> > +	struct dw_pcie *pci = &ultra->pci;
> > +	int ret;
> > +
> > +	if (pci->suspended) {
> > +		ultrarisc_pcie_disable_clks(ultra);
> > +		return 0;
> > +	}
> 
> Same as above. This looks redundant. Actually, it is wrong too as there cannot
> be more than one suspend callback invocations.
>

Agreed that suspend_noirq() is invoked once per transition. However, a
failed resume leaves pci->suspended set and the clocks disabled. The PM
core records the resume error and continues the transition, so a later,
independent system suspend can invoke this callback again. In the next
version, I will keep the entry check as an early return for that case,
without disabling the clocks again.

> - Mani
> 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
> 

Best regards,
Jia Wang


