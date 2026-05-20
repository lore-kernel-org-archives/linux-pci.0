Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4139F373BEB;
	Wed, 20 May 2026 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296514; cv=none; b=iCZKZsQyXuhlBVPTF5xsoCSDDzoRxuLPGKRashhLjz34sTHA+Q+Kuxyp+5jRZxTi3MsxHSgCKuYgi6htoo9CTWzT5EACIJGsBmFG3+ezWSfEcrV+tUApxouCcxu/DpoG7+35T9V/uWng0z0DvPE7Qll8iIpS+NkldbnDStDqfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296514; c=relaxed/simple;
	bh=NcA5iylp2Wk1Y0XB33LW7W9WbA9hrzWgufyvObGgTnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0bvkbgb4U7F8tff+4PlL41WlMTNJ6gaf5n/j4ykvS6zFKzsHqr4LuyVsZvCUjHSR3Oq7ZH7747V5UWELOktzpIKEz2OohANc52ixKKHm/JHMVLp2WDNo7kXUSDDBXsWL6k/6vPSQKhsoy9OxkGvpbRWKIyKNhdmP0AQe9aRNsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPKbMVGz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPKbMVGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDA81F000E9;
	Wed, 20 May 2026 17:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779296513;
	bh=CyqlaRibvO4e/yWQywkk+BQnCzTvOxdVy9RJIaujXg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZPKbMVGzd7QF78ONhx13PW+aVlKdS2JLjf5K4sldP55wG1RzPygan3gUYd/Z/A52w
	 yYdkDRS2c1KA8jGtj64C9uD+5BFGFLbwwIoy31zlerxU1w43JXzvmiPxXUEkLkLU3S
	 b89NCL7+7ReT0MHND/OFxmtA43iNhxLCj85WgSk6Oq+Asfk/HDCkbJlfWT9AK7hanx
	 W3m/rRxn0wuq/VdzcHq0mX5o4WjMMaX/rRkjc26k3sZv/TlRI39Ks7C3Vaw2HBoaQF
	 yXHFBUXokbbUgBETfWOmp7flCZcB4MTT9EefV9te6J6TmsqbZIlptJXHlL2nzBS1Nf
	 MmtWHytGwil4A==
Date: Wed, 20 May 2026 22:31:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: sashiko-reviews@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>, 
	robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v7 2/2] PCI: mediatek: Add support for EcoNet EN7528 SoC
Message-ID: <fvpmuxlo5bnawafp2xuikct25v6ik6gnzyaskwe2r25g5cuovf@qxmmu6pabxq7>
References: <20260514151318.3444959-3-cjd@cjdns.fr>
 <20260514210141.2DEF2C2BCB3@smtp.kernel.org>
 <22d7274b-640a-470e-86b0-997a4b6e102d@cjdns.fr>
 <ihqxutsgrcrbusbtblxmaq3swcp3xtiq6ycnpi7nl45fup36ym@6kvdzwu4zivy>
 <1552f47b-7542-414e-ab6a-a07efc8e81e5@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lexhwneazodixted"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552f47b-7542-414e-ab6a-a07efc8e81e5@cjdns.fr>


--lexhwneazodixted
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 20, 2026 at 03:14:52PM +0200, Caleb James DeLisle wrote:
> Thanks for weighing in
> 
> 
> On 20/05/2026 10:34, Manivannan Sadhasivam wrote:
> > On Fri, May 15, 2026 at 03:34:53PM +0200, Caleb James DeLisle wrote:
> > > Regarding this, I could use some advice. Bjorn I tagged you in because
> > > you're probably best to have an opinion here.
> > > 
> > > 
> > > On 14/05/2026 23:01, sashiko-bot@kernel.org wrote:
> > > > Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> > > > - [High] mtk_pcie_retrain() iterates the PCI bus without locks and holds an unreferenced device pointer, leading to a Use-After-Free.
> > > > - [High] mtk_pcie_retrain() only retrains the first root port, silently ignoring any other ports on the same host.
> > > > - [High] Link retraining occurs after downstream endpoint drivers are probed, causing a race condition that can lead to system crashes.
> > > > - [High] Calling virt_to_phys() on an __iomem pointer causes undefined behavior and potential memory corruption.
> > > > - [Medium] The IS_BUILTIN() workaround silently degrades hardware capabilities when the driver is compiled as a module.
> > > > --
> > > > 
> > > > commit 08338fe344200ef55148194108ab3b65616af7c7
> > > > Author: Caleb James DeLisle <cjd@cjdns.fr>
> > > > Subject: PCI: mediatek: Add support for EcoNet EN7528 SoC
> > > > 
> > > > This commit adds support for the PCIe controller found on EcoNet EN7528 SoCs.
> > > > It introduces a hardware quirk to retrain the link after startup, as some
> > > > ports capable of Gen2 operation will initially start at Gen1 speeds.
> > > > 
> > > > > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > > > > --- a/drivers/pci/controller/pcie-mediatek.c
> > > > > +++ b/drivers/pci/controller/pcie-mediatek.c
> > > > [ ... ]
> > > > > @@ -753,6 +764,135 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> > > > [ ... ]
> > > > > +	/* Activate INTx interrupts */
> > > > > +	val = readl(port->base + PCIE_INT_MASK);
> > > > > +	val &= ~INTX_MASK;
> > > > > +	writel(val, port->base + PCIE_INT_MASK);
> > > > > +
> > > > > +	if (IS_ENABLED(CONFIG_PCI_MSI))
> > > > > +		mtk_pcie_enable_msi(port);
> > > > Is it safe to call mtk_pcie_enable_msi() here? Looking at
> > > > mtk_pcie_enable_msi(), it calculates the message address using:
> > > > 
> > > >       virt_to_phys(port->base + PCIE_MSI_VECTOR)
> > > > 
> > > > Since port->base is an ioremapped __iomem pointer, passing it to
> > > > virt_to_phys() produces undefined behavior and could return a garbage
> > > > physical address. If this address overlaps with valid physical RAM mapped
> > > > for DMA, could memory writes from the PCIe endpoint corrupt random system
> > > > memory?
> > > Learned a few things from that note. Seems ioremap is just giving us a KSEG1
> > > address and virt_to_phys() is getting the real address back. In any case I'm
> > > just doing what the driver already does.
> > This looks definitely wrong because virt_to_phys() is supposed to be used for
> > virtual address, not the ioremapped address. virt_to_phys() will calculate the
> > physical address using the page offset, which doesn't apply to ioremapped
> > address.
> > 
> > Correct way would be to store the physical address while doing the ioremap:
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 75722524fe74..c503fbd774d0 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -175,6 +175,7 @@ struct mtk_pcie_soc {
> >   /**
> >    * struct mtk_pcie_port - PCIe port information
> >    * @base: IO mapped register base
> > + * @phys_base: Physical address of the I/O register base region
> >    * @list: port list
> >    * @pcie: pointer to PCIe host info
> >    * @reset: pointer to port reset control
> > @@ -196,6 +197,7 @@ struct mtk_pcie_soc {
> >    */
> >   struct mtk_pcie_port {
> >          void __iomem *base;
> > +       phys_addr_t phys_base;
> >          struct list_head list;
> >          struct mtk_pcie *pcie;
> >          struct reset_control *reset;
> > @@ -405,7 +407,7 @@ static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> >          phys_addr_t addr;
> >          /* MT2712/MT7622 only support 32-bit MSI addresses */
> > -       addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> > +       addr = port->phys_base + PCIE_MSI_VECTOR;
> >          msg->address_hi = 0;
> >          msg->address_lo = lower_32_bits(addr);
> > @@ -520,7 +522,7 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
> >          u32 val;
> >          phys_addr_t msg_addr;
> > -       msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> > +       msg_addr = port->phys_base + PCIE_MSI_VECTOR;
> >          val = lower_32_bits(msg_addr);
> >          writel(val, port->base + PCIE_IMSI_ADDR);
> > @@ -953,6 +955,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
> >          struct mtk_pcie_port *port;
> >          struct device *dev = pcie->dev;
> >          struct platform_device *pdev = to_platform_device(dev);
> > +       struct resource *res;
> >          char name[20];
> >          int err;
> > @@ -961,7 +964,14 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
> >                  return -ENOMEM;
> >          snprintf(name, sizeof(name), "port%d", slot);
> > -       port->base = devm_platform_ioremap_resource_byname(pdev, name);
> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
> > +       if (!res) {
> > +               dev_err(dev, "failed to get port%d base\n", slot);
> > +               return -EINVAL;
> > +       }
> > +
> > +       port->phys_base = res->start;
> > +       port->base = devm_ioremap_resource(&pdev->dev, res);
> >          if (IS_ERR(port->base)) {
> >                  dev_err(dev, "failed to map port%d base\n", slot);
> >                  return PTR_ERR(port->base);
> > 
> > I see a couple of other drivers also doing something similar. So I'll try to
> > send fixes for all of them separately.
> If you want me to integrate this fix in my patchset to avoid merge
> conflicts, just let me know.

Attached the patch. You can add it to the series. Make sure it is the first
patch of the series.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

--lexhwneazodixted
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-PCI-mediatek-Use-actual-physical-address-instead-of-.patch"

From 3d710606079d285f2431ddc155824b282218fba2 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Wed, 20 May 2026 22:11:45 +0530
Subject: [PATCH] PCI: mediatek: Use actual physical address instead of
 virt_to_phys()

The driver previously used virt_to_phys() on the ioremapped register base
(port->base) to compute the MSI message address. Using virt_to_phys() on an
IO mapped address is incorrect because it expects a kernel virtual address.

To fix it, store the physical start of the I/O register region in
mtk_pcie_port->phys_base and use it to build the MSI address. This replaces
the incorrect virt_to_phys() usage and ensures MSI addresses are generated
correctly.

Fixes: 43e6409db64d ("PCI: mediatek: Add MSI support for MT2712 and MT7622")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/pcie-mediatek.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 75722524fe74..c503fbd774d0 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -175,6 +175,7 @@ struct mtk_pcie_soc {
 /**
  * struct mtk_pcie_port - PCIe port information
  * @base: IO mapped register base
+ * @phys_base: Physical address of the I/O register base region
  * @list: port list
  * @pcie: pointer to PCIe host info
  * @reset: pointer to port reset control
@@ -196,6 +197,7 @@ struct mtk_pcie_soc {
  */
 struct mtk_pcie_port {
 	void __iomem *base;
+	phys_addr_t phys_base;
 	struct list_head list;
 	struct mtk_pcie *pcie;
 	struct reset_control *reset;
@@ -405,7 +407,7 @@ static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	phys_addr_t addr;
 
 	/* MT2712/MT7622 only support 32-bit MSI addresses */
-	addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
+	addr = port->phys_base + PCIE_MSI_VECTOR;
 	msg->address_hi = 0;
 	msg->address_lo = lower_32_bits(addr);
 
@@ -520,7 +522,7 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	u32 val;
 	phys_addr_t msg_addr;
 
-	msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
+	msg_addr = port->phys_base + PCIE_MSI_VECTOR;
 	val = lower_32_bits(msg_addr);
 	writel(val, port->base + PCIE_IMSI_ADDR);
 
@@ -953,6 +955,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
 	struct mtk_pcie_port *port;
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
 	char name[20];
 	int err;
 
@@ -961,7 +964,14 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
 		return -ENOMEM;
 
 	snprintf(name, sizeof(name), "port%d", slot);
-	port->base = devm_platform_ioremap_resource_byname(pdev, name);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
+	if (!res) {
+		dev_err(dev, "failed to get port%d base\n", slot);
+		return -EINVAL;
+	}
+
+	port->phys_base = res->start;
+	port->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(port->base)) {
 		dev_err(dev, "failed to map port%d base\n", slot);
 		return PTR_ERR(port->base);
-- 
2.51.0


--lexhwneazodixted--
