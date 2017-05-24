Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031603AbdEXVEW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 May 2017 17:04:22 -0400
Date: Wed, 24 May 2017 16:04:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: John Crispin <john@phrozen.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Add support for IPQ4019 PCIe controller
Message-ID: <20170524210418.GA31459@bhelgaas-glaptop.roam.corp.google.com>
References: <20170505152524.29337-1-john@phrozen.org>
 <20170523200719.GG7241@bhelgaas-glaptop.roam.corp.google.com>
 <41f174d7-7d11-f80f-5508-17f53af1ee97@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41f174d7-7d11-f80f-5508-17f53af1ee97@mm-sol.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 24, 2017 at 02:31:27AM +0300, Stanimir Varbanov wrote:
> Hi,
> 
> On 23.05.2017 23:07, Bjorn Helgaas wrote:
> >Stanimir?
> >
> >On Fri, May 05, 2017 at 05:25:24PM +0200, John Crispin wrote:
> >>Add support for the IPQ4019 PCIe controller. IPQ4019 supports Gen
> >>1/2, one lane, one PCIe root complex with support for MSI and legacy
> >>interrupts, and it conforms to PCI Express Base 2.1 specification.
> >>
> >>The core init is the sames as for the MSM8996, however the clocks and
> >>reset lines differ.
> >>
> >>Signed-off-by: John Crispin <john@phrozen.org>
> >>---
> >> .../devicetree/bindings/pci/qcom,pcie.txt          |  20 +-
> >> drivers/pci/host/pcie-qcom.c                       | 304 +++++++++++++++++++++
> >
> >pcie-qcom.c was recently moved to drivers/pci/dwc, but I was able to
> >apply this by hand pretty easily.  But I would like Stanimir's ack
> >first.
> 
> Bjorn, thanks for the reminder.
> 
> Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

Thanks.

Rob took the trouble to provide useful comments, so I'm a bit
disappointed that there hasn't been a response them.

Re the verbose error messages, I agree they make the code ugly.  I
think John copied the existing style, which is reasonable.  I don't
see a good way to move the message into the callee, e.g.,
reset_control_assert(), because that's a generic function with
hundreds of callers.  But most of those callers don't check the return
value.  I'm not sure whether there's really any value in checking
here.

Re the ordering in the deinit() functions vs the init() error paths,
the new v3 code uses the same ordering as the existing v1 code, i.e.,

  qcom_pcie_deinit_v3
    reset_control_assert
    clk_disable_unprepare

  qcom_pcie_init_v3
      reset_control_deassert
      clk_prepare_enable
    err:
      clk_disable_unprepare
      reset_control_assert

In general, there's just a worrying lack of symmetry across the init,
deinit, and error paths of all the versions.

I would also propose the patch below, which doesn't change any code,
but moves a few functions so all the v0 code is together, all the v1
code is together and in the same order, etc.

Bjorn



commit ebacba9579462bdc009f4cfc1b605b3ca7a7a1d2
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed May 24 15:19:36 2017 -0500

    PCI: qcom: Reorder to put v0 functions together, v1 functions together, etc
    
    Previously the v0, v1, and v2 functions were not grouped together in a
    consistent order.  Reorder them to make them consistent.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 9b186518cb72..5872a6771ea5 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -152,26 +152,6 @@ static irqreturn_t qcom_pcie_msi_irq_handler(int irq, void *arg)
 	return dw_handle_msi_irq(pp);
 }
 
-static void qcom_pcie_v0_v1_ltssm_enable(struct qcom_pcie *pcie)
-{
-	u32 val;
-
-	/* enable link training */
-	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
-	val |= PCIE20_ELBI_SYS_CTRL_LT_ENABLE;
-	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
-}
-
-static void qcom_pcie_v2_ltssm_enable(struct qcom_pcie *pcie)
-{
-	u32 val;
-
-	/* enable link training */
-	val = readl(pcie->parf + PCIE20_PARF_LTSSM);
-	val |= BIT(8);
-	writel(val, pcie->parf + PCIE20_PARF_LTSSM);
-}
-
 static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
@@ -186,6 +166,16 @@ static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
 	return dw_pcie_wait_for_link(pci);
 }
 
+static void qcom_pcie_v0_v1_ltssm_enable(struct qcom_pcie *pcie)
+{
+	u32 val;
+
+	/* enable link training */
+	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
+	val |= PCIE20_ELBI_SYS_CTRL_LT_ENABLE;
+	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
+}
+
 static int qcom_pcie_get_resources_v0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
@@ -236,36 +226,6 @@ static int qcom_pcie_get_resources_v0(struct qcom_pcie *pcie)
 	return PTR_ERR_OR_ZERO(res->phy_reset);
 }
 
-static int qcom_pcie_get_resources_v1(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
-	struct dw_pcie *pci = pcie->pci;
-	struct device *dev = pci->dev;
-
-	res->vdda = devm_regulator_get(dev, "vdda");
-	if (IS_ERR(res->vdda))
-		return PTR_ERR(res->vdda);
-
-	res->iface = devm_clk_get(dev, "iface");
-	if (IS_ERR(res->iface))
-		return PTR_ERR(res->iface);
-
-	res->aux = devm_clk_get(dev, "aux");
-	if (IS_ERR(res->aux))
-		return PTR_ERR(res->aux);
-
-	res->master_bus = devm_clk_get(dev, "master_bus");
-	if (IS_ERR(res->master_bus))
-		return PTR_ERR(res->master_bus);
-
-	res->slave_bus = devm_clk_get(dev, "slave_bus");
-	if (IS_ERR(res->slave_bus))
-		return PTR_ERR(res->slave_bus);
-
-	res->core = devm_reset_control_get(dev, "core");
-	return PTR_ERR_OR_ZERO(res->core);
-}
-
 static void qcom_pcie_deinit_v0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
@@ -394,6 +354,36 @@ static int qcom_pcie_init_v0(struct qcom_pcie *pcie)
 	return ret;
 }
 
+static int qcom_pcie_get_resources_v1(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+
+	res->vdda = devm_regulator_get(dev, "vdda");
+	if (IS_ERR(res->vdda))
+		return PTR_ERR(res->vdda);
+
+	res->iface = devm_clk_get(dev, "iface");
+	if (IS_ERR(res->iface))
+		return PTR_ERR(res->iface);
+
+	res->aux = devm_clk_get(dev, "aux");
+	if (IS_ERR(res->aux))
+		return PTR_ERR(res->aux);
+
+	res->master_bus = devm_clk_get(dev, "master_bus");
+	if (IS_ERR(res->master_bus))
+		return PTR_ERR(res->master_bus);
+
+	res->slave_bus = devm_clk_get(dev, "slave_bus");
+	if (IS_ERR(res->slave_bus))
+		return PTR_ERR(res->slave_bus);
+
+	res->core = devm_reset_control_get(dev, "core");
+	return PTR_ERR_OR_ZERO(res->core);
+}
+
 static void qcom_pcie_deinit_v1(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
@@ -474,6 +464,16 @@ static int qcom_pcie_init_v1(struct qcom_pcie *pcie)
 	return ret;
 }
 
+static void qcom_pcie_v2_ltssm_enable(struct qcom_pcie *pcie)
+{
+	u32 val;
+
+	/* enable link training */
+	val = readl(pcie->parf + PCIE20_PARF_LTSSM);
+	val |= BIT(8);
+	writel(val, pcie->parf + PCIE20_PARF_LTSSM);
+}
+
 static int qcom_pcie_get_resources_v2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
@@ -500,6 +500,17 @@ static int qcom_pcie_get_resources_v2(struct qcom_pcie *pcie)
 	return PTR_ERR_OR_ZERO(res->pipe_clk);
 }
 
+static void qcom_pcie_deinit_v2(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
+
+	clk_disable_unprepare(res->pipe_clk);
+	clk_disable_unprepare(res->slave_clk);
+	clk_disable_unprepare(res->master_clk);
+	clk_disable_unprepare(res->cfg_clk);
+	clk_disable_unprepare(res->aux_clk);
+}
+
 static int qcom_pcie_init_v2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
@@ -865,17 +876,6 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
-static void qcom_pcie_deinit_v2(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
-
-	clk_disable_unprepare(res->pipe_clk);
-	clk_disable_unprepare(res->slave_clk);
-	clk_disable_unprepare(res->master_clk);
-	clk_disable_unprepare(res->cfg_clk);
-	clk_disable_unprepare(res->aux_clk);
-}
-
 static void qcom_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
