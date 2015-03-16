Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34671 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965058AbbCPOZC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2015 10:25:02 -0400
From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	" David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>, <m-karicheri2@ti.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>, Liviu Dudau <liviu.dudau@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@stlinux.com,
	linux-pci@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
	Gabriel Fernandez <gabriel.fernandez@linaro.org>
Subject: [PATCH v2 4/5] PCI: designware: Add disable IO support
Date: Mon, 16 Mar 2015 15:20:34 +0100
Message-Id: <1426515635-9466-5-git-send-email-gabriel.fernandez@linaro.org>
In-Reply-To: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

ST sti SoCs PCIe IPs are built around DesignWare IP Core.
But in these SoCs PCIe IP doesn't support IO.

This patch adds the possibility to disable it through
a DT property, by creating an empty IO window and by
removing PCI_COMMAND_IO from the setup register.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 .../devicetree/bindings/pci/designware-pcie.txt    |  2 ++
 drivers/pci/host/pcie-designware.c                 | 24 ++++++++++++++++++++--
 drivers/pci/host/pcie-designware.h                 |  1 +
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 9f4faa8..40544d4 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -26,3 +26,5 @@ Optional properties:
 - bus-range: PCI bus numbers covered (it is recommended for new devicetrees to
   specify this property, to keep backwards compatibility a range of 0x00-0xff
   is assumed if not present)
+- disable_io_support: set this property for PCIe host controller without IO
+  port access
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 1f4ea6f..f9d70f5 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -471,6 +471,9 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 		return -EINVAL;
 	}
 
+	pp->disable_io_support = of_property_read_bool(np,
+			"disable_io_support");
+
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		if (!pp->ops->msi_host_init) {
 			pp->irq_domain = irq_domain_add_linear(pp->dev->of_node,
@@ -704,6 +707,7 @@ static struct pci_ops dw_pcie_ops = {
 static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
 {
 	struct pcie_port *pp;
+	struct resource *res;
 
 	pp = sys_to_pcie(sys);
 
@@ -719,6 +723,18 @@ static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
 	pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
 	pci_add_resource(&sys->resources, &pp->busn);
 
+	if (pp->disable_io_support) {
+		/* This PCIe controller does not support IO, set an empty one */
+		res = devm_kzalloc(pp->dev, sizeof(*res), GFP_KERNEL);
+		if (res) {
+			res->start = 0;
+			res->end = 0;
+			res->name = "PCIe empty IO space";
+			res->flags = IORESOURCE_IO;
+			pci_add_resource(&sys->resources, res);
+		}
+	}
+
 	return 1;
 }
 
@@ -822,8 +838,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	/* setup command register */
 	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
 	val &= 0xffff0000;
-	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
-		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
+
+	if (!pp->disable_io_support)
+		val |= PCI_COMMAND_IO;
+
+	val |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
+
 	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
 }
 
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index d0bbd27..027045d 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -52,6 +52,7 @@ struct pcie_port {
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
 	unsigned long		msi_data;
+	bool			disable_io_support;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
 
-- 
1.9.1

