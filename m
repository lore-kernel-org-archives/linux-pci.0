Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753890AbcIBPym (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Sep 2016 11:54:42 -0400
Subject: [PATCH v2 05/15] Use a local "dev" to avoid repetition of
 "rockchip->dev".
To: Shawn Lin <shawn.lin@rock-chips.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Date: Fri, 02 Sep 2016 10:54:35 -0500
Message-ID: <20160902155435.8650.36730.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


---
 drivers/pci/host/pcie-rockchip.c |   98 ++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 63fb0ebc..ea75f35 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -380,6 +380,7 @@ static struct pci_ops rockchip_pcie_ops = {
  */
 static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 {
+	struct device *dev = rockchip->dev;
 	int err;
 	u32 status;
 	unsigned long timeout;
@@ -388,31 +389,31 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 
 	err = phy_init(rockchip->phy);
 	if (err < 0) {
-		dev_err(rockchip->dev, "fail to init phy, err %d\n", err);
+		dev_err(dev, "fail to init phy, err %d\n", err);
 		return err;
 	}
 
 	err = reset_control_assert(rockchip->core_rst);
 	if (err) {
-		dev_err(rockchip->dev, "assert core_rst err %d\n", err);
+		dev_err(dev, "assert core_rst err %d\n", err);
 		return err;
 	}
 
 	err = reset_control_assert(rockchip->mgmt_rst);
 	if (err) {
-		dev_err(rockchip->dev, "assert mgmt_rst err %d\n", err);
+		dev_err(dev, "assert mgmt_rst err %d\n", err);
 		return err;
 	}
 
 	err = reset_control_assert(rockchip->mgmt_sticky_rst);
 	if (err) {
-		dev_err(rockchip->dev, "assert mgmt_sticky_rst err %d\n", err);
+		dev_err(dev, "assert mgmt_sticky_rst err %d\n", err);
 		return err;
 	}
 
 	err = reset_control_assert(rockchip->pipe_rst);
 	if (err) {
-		dev_err(rockchip->dev, "assert pipe_rst err %d\n", err);
+		dev_err(dev, "assert pipe_rst err %d\n", err);
 		return err;
 	}
 
@@ -436,31 +437,31 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 
 	err = phy_power_on(rockchip->phy);
 	if (err) {
-		dev_err(rockchip->dev, "fail to power on phy, err %d\n", err);
+		dev_err(dev, "fail to power on phy, err %d\n", err);
 		return err;
 	}
 
 	err = reset_control_deassert(rockchip->core_rst);
 	if (err) {
-		dev_err(rockchip->dev, "deassert core_rst err %d\n", err);
+		dev_err(dev, "deassert core_rst err %d\n", err);
 		return err;
 	}
 
 	err = reset_control_deassert(rockchip->mgmt_rst);
 	if (err) {
-		dev_err(rockchip->dev, "deassert mgmt_rst err %d\n", err);
+		dev_err(dev, "deassert mgmt_rst err %d\n", err);
 		return err;
 	}
 
 	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
 	if (err) {
-		dev_err(rockchip->dev, "deassert mgmt_sticky_rst err %d\n", err);
+		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
 		return err;
 	}
 
 	err = reset_control_deassert(rockchip->pipe_rst);
 	if (err) {
-		dev_err(rockchip->dev, "deassert pipe_rst err %d\n", err);
+		dev_err(dev, "deassert pipe_rst err %d\n", err);
 		return err;
 	}
 
@@ -492,7 +493,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		if (((status >> PCIE_CLIENT_LINK_STATUS_SHIFT) &
 		      PCIE_CLIENT_LINK_STATUS_MASK) ==
 		      PCIE_CLIENT_LINK_STATUS_UP) {
-			dev_dbg(rockchip->dev, "PCIe link training gen1 pass!\n");
+			dev_dbg(dev, "PCIe link training gen1 pass!\n");
 			break;
 		}
 
@@ -511,7 +512,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 			PCIE_CLIENT_LINK_STATUS_MASK) ==
 			PCIE_CLIENT_LINK_STATUS_UP) ? 0 : -ETIMEDOUT;
 		if (err) {
-			dev_err(rockchip->dev, "PCIe link training gen1 timeout!\n");
+			dev_err(dev, "PCIe link training gen1 timeout!\n");
 			return err;
 		}
 	}
@@ -532,7 +533,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		if (((status >> PCIE_CORE_PL_CONF_SPEED_SHIFT) &
 		     PCIE_CORE_PL_CONF_SPEED_MASK) ==
 		     PCIE_CORE_PL_CONF_SPEED_5G) {
-			dev_dbg(rockchip->dev, "PCIe link training gen2 pass!\n");
+			dev_dbg(dev, "PCIe link training gen2 pass!\n");
 			break;
 		}
 
@@ -551,14 +552,14 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 			PCIE_CORE_PL_CONF_SPEED_MASK) ==
 			PCIE_CORE_PL_CONF_SPEED_5G) ? 0 : -ETIMEDOUT;
 		if (err)
-			dev_dbg(rockchip->dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
+			dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
 	}
 
 	/* Check the final link width from negotiated lane counter from MGMT */
 	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL_MGMT_BASE);
 	status =  0x1 << ((status >> PCIE_CORE_PL_CONF_LANE_SHIFT) &
 			   PCIE_CORE_PL_CONF_LANE_MASK);
-	dev_dbg(rockchip->dev, "current link width is x%d\n", status);
+	dev_dbg(dev, "current link width is x%d\n", status);
 
 	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID, PCIE_RC_CONFIG_BASE);
 	rockchip_pcie_write(rockchip, PCI_CLASS_BRIDGE_PCI << PCIE_CORE_RC_CONF_SCC_SHIFT,
@@ -580,58 +581,59 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
 {
 	struct rockchip_pcie *rockchip = arg;
+	struct device *dev = rockchip->dev;
 	u32 reg;
 	u32 sub_reg;
 
 	reg = rockchip_pcie_read(rockchip, PCIE_CLIENT_INT_STATUS);
 	if (reg & PCIE_CLIENT_INT_LOCAL) {
-		dev_dbg(rockchip->dev, "local interrupt received\n");
+		dev_dbg(dev, "local interrupt received\n");
 		sub_reg = rockchip_pcie_read(rockchip, PCIE_CORE_INT_STATUS);
 		if (sub_reg & PCIE_CORE_INT_PRFPE)
-			dev_dbg(rockchip->dev, "parity error detected while reading from the PNP receive FIFO RAM\n");
+			dev_dbg(dev, "parity error detected while reading from the PNP receive FIFO RAM\n");
 
 		if (sub_reg & PCIE_CORE_INT_CRFPE)
-			dev_dbg(rockchip->dev, "parity error detected while reading from the Completion Receive FIFO RAM\n");
+			dev_dbg(dev, "parity error detected while reading from the Completion Receive FIFO RAM\n");
 
 		if (sub_reg & PCIE_CORE_INT_RRPE)
-			dev_dbg(rockchip->dev, "parity error detected while reading from replay buffer RAM\n");
+			dev_dbg(dev, "parity error detected while reading from replay buffer RAM\n");
 
 		if (sub_reg & PCIE_CORE_INT_PRFO)
-			dev_dbg(rockchip->dev, "overflow occurred in the PNP receive FIFO\n");
+			dev_dbg(dev, "overflow occurred in the PNP receive FIFO\n");
 
 		if (sub_reg & PCIE_CORE_INT_CRFO)
-			dev_dbg(rockchip->dev, "overflow occurred in the completion receive FIFO\n");
+			dev_dbg(dev, "overflow occurred in the completion receive FIFO\n");
 
 		if (sub_reg & PCIE_CORE_INT_RT)
-			dev_dbg(rockchip->dev, "replay timer timed out\n");
+			dev_dbg(dev, "replay timer timed out\n");
 
 		if (sub_reg & PCIE_CORE_INT_RTR)
-			dev_dbg(rockchip->dev, "replay timer rolled over after 4 transmissions of the same TLP\n");
+			dev_dbg(dev, "replay timer rolled over after 4 transmissions of the same TLP\n");
 
 		if (sub_reg & PCIE_CORE_INT_PE)
-			dev_dbg(rockchip->dev, "phy error detected on receive side\n");
+			dev_dbg(dev, "phy error detected on receive side\n");
 
 		if (sub_reg & PCIE_CORE_INT_MTR)
-			dev_dbg(rockchip->dev, "malformed TLP received from the link\n");
+			dev_dbg(dev, "malformed TLP received from the link\n");
 
 		if (sub_reg & PCIE_CORE_INT_UCR)
-			dev_dbg(rockchip->dev, "malformed TLP received from the link\n");
+			dev_dbg(dev, "malformed TLP received from the link\n");
 
 		if (sub_reg & PCIE_CORE_INT_FCE)
-			dev_dbg(rockchip->dev, "an error was observed in the flow control advertisements from the other side\n");
+			dev_dbg(dev, "an error was observed in the flow control advertisements from the other side\n");
 
 		if (sub_reg & PCIE_CORE_INT_CT)
-			dev_dbg(rockchip->dev, "a request timed out waiting for completion\n");
+			dev_dbg(dev, "a request timed out waiting for completion\n");
 
 		if (sub_reg & PCIE_CORE_INT_UTC)
-			dev_dbg(rockchip->dev, "unmapped TC error\n");
+			dev_dbg(dev, "unmapped TC error\n");
 
 		if (sub_reg & PCIE_CORE_INT_MMVC)
-			dev_dbg(rockchip->dev, "MSI mask register changes\n");
+			dev_dbg(dev, "MSI mask register changes\n");
 
 		rockchip_pcie_write(rockchip, sub_reg, PCIE_CORE_INT_STATUS);
 	} else if (reg & PCIE_CLIENT_INT_PHY) {
-		dev_dbg(rockchip->dev, "phy link changes\n");
+		dev_dbg(dev, "phy link changes\n");
 		rockchip_pcie_clr_bw_int(rockchip);
 	}
 
@@ -643,32 +645,33 @@ static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
 static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
 {
 	struct rockchip_pcie *rockchip = arg;
+	struct device *dev = rockchip->dev;
 	u32 reg;
 
 	reg = rockchip_pcie_read(rockchip, PCIE_CLIENT_INT_STATUS);
 	if (reg & PCIE_CLIENT_INT_LEGACY_DONE)
-		dev_dbg(rockchip->dev, "legacy done interrupt received\n");
+		dev_dbg(dev, "legacy done interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_MSG)
-		dev_dbg(rockchip->dev, "message done interrupt received\n");
+		dev_dbg(dev, "message done interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_HOT_RST)
-		dev_dbg(rockchip->dev, "hot reset interrupt received\n");
+		dev_dbg(dev, "hot reset interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_DPA)
-		dev_dbg(rockchip->dev, "dpa interrupt received\n");
+		dev_dbg(dev, "dpa interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_FATAL_ERR)
-		dev_dbg(rockchip->dev, "fatal error interrupt received\n");
+		dev_dbg(dev, "fatal error interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_NFATAL_ERR)
-		dev_dbg(rockchip->dev, "no fatal error interrupt received\n");
+		dev_dbg(dev, "no fatal error interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_CORR_ERR)
-		dev_dbg(rockchip->dev, "correctable error interrupt received\n");
+		dev_dbg(dev, "correctable error interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_PHY)
-		dev_dbg(rockchip->dev, "phy interrupt received\n");
+		dev_dbg(dev, "phy interrupt received\n");
 
 	rockchip_pcie_write(rockchip, reg & (PCIE_CLIENT_INT_LEGACY_DONE |
 			      PCIE_CLIENT_INT_MSG | PCIE_CLIENT_INT_HOT_RST |
@@ -684,13 +687,13 @@ static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
 static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct rockchip_pcie *rockchip;
+	struct rockchip_pcie *rockchip = irq_desc_get_handler_data(desc);
+	struct device *dev = rockchip->dev;
 	u32 reg;
 	u32 hwirq;
 	u32 virq;
 
 	chained_irq_enter(chip, desc);
-	rockchip = irq_desc_get_handler_data(desc);
 
 	reg = rockchip_pcie_read(rockchip, PCIE_CLIENT_INT_STATUS);
 	reg = (reg & ROCKCHIP_PCIE_RPIFR1_INTR_MASK) >>
@@ -704,7 +707,7 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
 		if (virq)
 			generic_handle_irq(virq);
 		else
-			dev_err(rockchip->dev, "unexpected IRQ, INT%d\n", hwirq);
+			dev_err(dev, "unexpected IRQ, INT%d\n", hwirq);
 	}
 
 	chained_irq_exit(chip, desc);
@@ -876,12 +879,13 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 
 static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
 {
+	struct device *dev = rockchip->dev;
 	int err;
 
 	if (!IS_ERR(rockchip->vpcie3v3)) {
 		err = regulator_enable(rockchip->vpcie3v3);
 		if (err) {
-			dev_err(rockchip->dev, "fail to enable vpcie3v3 regulator\n");
+			dev_err(dev, "fail to enable vpcie3v3 regulator\n");
 			goto err_out;
 		}
 	}
@@ -889,7 +893,7 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
 	if (!IS_ERR(rockchip->vpcie1v8)) {
 		err = regulator_enable(rockchip->vpcie1v8);
 		if (err) {
-			dev_err(rockchip->dev, "fail to enable vpcie1v8 regulator\n");
+			dev_err(dev, "fail to enable vpcie1v8 regulator\n");
 			goto err_disable_3v3;
 		}
 	}
@@ -897,7 +901,7 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
 	if (!IS_ERR(rockchip->vpcie0v9)) {
 		err = regulator_enable(rockchip->vpcie0v9);
 		if (err) {
-			dev_err(rockchip->dev, "fail to enable vpcie0v9 regulator\n");
+			dev_err(dev, "fail to enable vpcie0v9 regulator\n");
 			goto err_disable_1v8;
 		}
 	}
@@ -1082,7 +1086,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	err = rockchip_pcie_set_vpcie(rockchip);
 	if (err) {
-		dev_err(rockchip->dev, "failed to set vpcie regulator\n");
+		dev_err(dev, "failed to set vpcie regulator\n");
 		goto err_set_vpcie;
 	}
 
@@ -1117,7 +1121,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 			io_bus_addr = io->start - win->offset;
 			err = pci_remap_iospace(io, io_base);
 			if (err) {
-				dev_warn(rockchip->dev, "error %d: failed to map resource %pR\n",
+				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 err, io);
 				continue;
 			}

