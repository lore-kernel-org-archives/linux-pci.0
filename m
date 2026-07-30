Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A3438DC4F;
	Thu, 30 Jul 2026 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400002; cv=none; b=KmSwTgOOZ5o8m77uQik5nuJIyMPkDm04C1+lvh56oo0G27lDBtldIxoh0q/AHNoKi96buT0mFpSpr2FMnLPKkIYp1r+0Bdj38jGKKT4o8jPwfcb+WHFClq5RvuV03JdqcWX4tQywcc+fJzlClAO+YD/ug6Wu/kvTad5O5waU2x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400002; c=relaxed/simple;
	bh=4w8q+HwzoPPem5RJrr3ZmXMHDoIyxikUraEmRbUPK5E=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=qjppd6eTY2G+cKE2t/wlA2v1kVslRlaa2xcH2Au9VRXpFedTJSvKRuZHsXXogLWEj8YKyMvPHoePDttIl5n/ZHrZQ94irzT7OClXOAbruxae8SG7h3diMpJQgY/Ol7bvIfqBCc/H0oeDvCPcuoGzYnROPzGvms5ElqbIWXvgm58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=WDK2/Rka; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="WDK2/Rka"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=dFgcn74sVilpLq7F2SOu9G/jEv27ABV7Y
	bzyHKYYlJA=; b=WDK2/RkaQy6bsZ7duu0XLw2vgZsVBA6shB2CKbH8+rwm4jwLE
	aon188Lvl+rMX5og5+gMyJHEQYuxgXYotgssUf6ydGPt3j9YqIq7uOeeXJ5JYYPm
	Gtn5qj7YDBrffTv74y2lmEsQxdDuYEtXfJU1NrMNYkpvIJwpCP55qtbq9g=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cULRCmtqQcsVAA--.18292S2;
	Thu, 30 Jul 2026 16:26:57 +0800 (CST)
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
Cc: Jia Wang <wangjia@ultrarisc.com>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <hqzcquvsbd2kpmkup6be6lxwihitugai7aubeyyz3rxtgmra4a@wfhz4rdfp5mw>
References: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
 <20260714-ultrarisc-pci-clk-v3-2-e72723fc0ef1@ultrarisc.com>
 <2n44tfzw26mfis3nvnre2fph4u2whns5xgxvdmcczyfebt6gt2@ln53o5bi773e>
 <178539410375.553273.13405298466842007043.b4-reply@b4>
 <hqzcquvsbd2kpmkup6be6lxwihitugai7aubeyyz3rxtgmra4a@wfhz4rdfp5mw>
Date: Thu, 30 Jul 2026 16:26:29 +0800
Message-Id: <178539998982.1582149.3956352602743263407.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785399990; l=6976;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=4w8q+HwzoPPem5RJrr3ZmXMHDoIyxikUraEmRbUPK5E=;
 b=XnG8JueFYxIslDa+4z/tr0/w0mm6l7L5YmuV865DxMVx9LjxzmiypDBUtvONL4WBSaqesK9qh
 9YcfDnsktnHAExZYfGqRu6hQNpr6tppCK89C2d9U6FxXbIiJwZzENk1
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwA3cULRCmtqQcsVAA--.18292S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFW8ArWkCFWrJr4xWrW3KFg_yoWxWryDpF
	WUGa1jkF4DJryYgr1Iqwn8A3ZIyr1jyFy7XFZrKw12vrn0vFn7try8J34Y9F1vkr1DW3Wj
	vF4jkFW3Ca1rX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAEEWpqylMAEgAAsf

On 2026-07-30 10:00 +0200, Manivannan Sadhasivam wrote:
> On Thu, Jul 30, 2026 at 02:48:23PM +0800, Jia Wang wrote:
> > On 2026-07-29 15:48 +0200, Manivannan Sadhasivam wrote:
> > > On Tue, Jul 14, 2026 at 09:11:03AM +0800, Jia Wang via B4 Relay wrote:
> > > > From: Jia Wang <wangjia@ultrarisc.com>
> > > > 
> > > > Add the required core, dbi, and aux clocks for the DP1000 PCIe
> > > > controller and enable them before initializing the DesignWare host.
> > > > 
> > > > Also manage the clocks across system suspend and resume.
> > > > 
> > > > Fixes: 5fc35740c3b3 ("PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Complex driver")
> > > > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-ultrarisc.c | 102 ++++++++++++++++++++++++++--
> > > >  1 file changed, 95 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > > > index 6ee661ceff67..72ba5840b62d 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > > > @@ -5,6 +5,7 @@
> > > >   * Copyright (C) 2026 UltraRISC Technology (Shanghai) Co., Ltd.
> > > >   */
> > > >  
> > > > +#include <linux/clk.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of_device.h>
> > > > @@ -23,6 +24,12 @@
> > > >  
> > > >  #define ULTRARISC_PCIE_COMP_TIMEOUT_65_210MS	0x6
> > > >  
> > > > +struct ultrarisc_pcie {
> > > > +	struct dw_pcie pci;
> > > > +	struct clk_bulk_data clks[3];
> > > > +	bool clks_enabled;
> > > > +};
> > > > +
> > > >  static struct pci_ops ultrarisc_pci_ops = {
> > > >  	.map_bus = dw_pcie_own_conf_map_bus,
> > > >  	.read = pci_generic_config_read32,
> > > > @@ -98,17 +105,66 @@ static const struct dw_pcie_ops dw_pcie_ops = {
> > > >  	.start_link = ultrarisc_pcie_start_link,
> > > >  };
> > > >  
> > > > +static int ultrarisc_pcie_enable_clks(struct ultrarisc_pcie *ultra)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	if (ultra->clks_enabled)
> > > > +		return 0;
> > > > +
> > > 
> > > This check looks redundant and I don't see a need for the 'clks_enabled' flag.
> > > Just do:
> > > 
> > > 	return clk_bulk_prepare_enable();
> > >
> > 
> > Thanks for the review.
> > 
> > Agreed. I will remove clks_enabled and have ultrarisc_pcie_enable_clks()
> > return clk_bulk_prepare_enable() directly in the next version.
> > 
> > > > +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(ultra->clks), ultra->clks);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ultra->clks_enabled = true;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void ultrarisc_pcie_disable_clks(void *data)
> > > > +{
> > > > +	struct ultrarisc_pcie *ultra = data;
> > > > +
> > > > +	if (!ultra->clks_enabled)
> > > > +		return;
> > > > +
> > > > +	clk_bulk_disable_unprepare(ARRAY_SIZE(ultra->clks), ultra->clks);
> > > > +	ultra->clks_enabled = false;
> > > 
> > > Same here.
> > >
> > 
> > Agreed. I will make ultrarisc_pcie_disable_clks() call
> > clk_bulk_disable_unprepare() unconditionally in the next version.
> > 
> > > > +}
> > > > +
> > > > +static int ultrarisc_pcie_init_clks(struct ultrarisc_pcie *ultra)
> > > > +{
> > > > +	struct device *dev = ultra->pci.dev;
> > > > +	int ret;
> > > > +
> > > > +	ultra->clks[0].id = "core";
> > > > +	ultra->clks[1].id = "dbi";
> > > > +	ultra->clks[2].id = "aux";
> > > > +
> > > > +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(ultra->clks), ultra->clks);
> > > 
> > > Use devm_clk_bulk_get_all()
> > >
> > 
> > I used `devm_clk_bulk_get()` to make the driver require the "core", "dbi",
> > and "aux" clock names. Using `devm_clk_bulk_get_all()` would instead accept
> > the clocks without requiring those names. Is that intended, or is there a
> > requirement or convention I am missing?
> > 
> 
> Your DT binding should ensure that the DTS supplies the required clocks. So the
> driver shouldn't hardcode the clock name and just get whatever clocks DTS
> passes. Otherwise, the driver will become a DTS validator.
>

Agreed. I will use devm_clk_bulk_get_all() and rely on the DT binding to
validate the required clocks in v4. Thanks!

> > > > +	if (ret)
> > > > +		return dev_err_probe(dev, ret, "Failed to get clocks\n");
> > > > +
> > > > +	ret = ultrarisc_pcie_enable_clks(ultra);
> > > > +	if (ret)
> > > > +		return dev_err_probe(dev, ret, "Failed to enable clocks\n");
> > > > +
> > > > +	return devm_add_action_or_reset(dev, ultrarisc_pcie_disable_clks, ultra);
> > > > +}
> > > > +
> > > >  static int ultrarisc_pcie_probe(struct platform_device *pdev)
> > > >  {
> > > > +	struct ultrarisc_pcie *ultra;
> > > >  	struct device *dev = &pdev->dev;
> > > >  	struct dw_pcie_rp *pp;
> > > >  	struct dw_pcie *pci;
> > > >  	int ret;
> > > >  
> > > > -	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> > > > -	if (!pci)
> > > > +	ultra = devm_kzalloc(dev, sizeof(*ultra), GFP_KERNEL);
> > > > +	if (!ultra)
> > > >  		return -ENOMEM;
> > > >  
> > > > +	pci = &ultra->pci;
> > > >  	pci->dev = dev;
> > > >  	pci->ops = &dw_pcie_ops;
> > > >  
> > > > @@ -117,7 +173,11 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
> > > >  
> > > >  	pp = &pci->pp;
> > > >  
> > > > -	platform_set_drvdata(pdev, pci);
> > > > +	platform_set_drvdata(pdev, ultra);
> > > > +
> > > > +	ret = ultrarisc_pcie_init_clks(ultra);
> > > > +	if (ret)
> > > > +		return ret;
> > > >  
> > > >  	pp->num_vectors = MAX_MSI_IRQS;
> > > >  	/* No L2/L3 Ready indication is available on this platform */
> > > > @@ -135,16 +195,44 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
> > > >  
> > > >  static int ultrarisc_pcie_suspend_noirq(struct device *dev)
> > > >  {
> > > > -	struct dw_pcie *pci = dev_get_drvdata(dev);
> > > > +	struct ultrarisc_pcie *ultra = dev_get_drvdata(dev);
> > > > +	struct dw_pcie *pci = &ultra->pci;
> > > > +	int ret;
> > > > +
> > > > +	if (pci->suspended) {
> > > > +		ultrarisc_pcie_disable_clks(ultra);
> > > > +		return 0;
> > > > +	}
> > > 
> > > Same as above. This looks redundant. Actually, it is wrong too as there cannot
> > > be more than one suspend callback invocations.
> > >
> > 
> > Agreed that suspend_noirq() is invoked once per transition. However, a
> > failed resume leaves pci->suspended set and the clocks disabled. The PM
> > core records the resume error and continues the transition, so a later,
> > independent system suspend can invoke this callback again. In the next
> > version, I will keep the entry check as an early return for that case,
> > without disabling the clocks again.
> > 
> 
> OK!
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
> 

Best regards,
Jia Wang


