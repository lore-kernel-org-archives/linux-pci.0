Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98F3CE4A3
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581724; cv=none; b=ZFtRYLlcPIhmSsb4Ju743+y83yZHrX5l9uAnGrqzTaSF0AnwkNory2/+H+KyTBYLc23XbfbIOxj7HpXC+6PITpsgetbh9xmjhEKQExJ0nelF/FMkdAuAn/Qt5UHcT31sMef0anLElNUSTRkQ3nAgeYBYt2QcEy+NgFMYo2jiC4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581724; c=relaxed/simple;
	bh=Z++wP04oDfEOU8RLO3/xCLwJOrX+sTJTMLGPoAq0Wqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FOhXQxGsUvvRFm5TQhYCVVO1DVLQx9rxp/iGp15YlBCwOG2zR4phw8EhqJa4xylQ/oKwgAi7FaZyHCAhInuOleo5irc03V1njhEBB45z5WZOo7aLEqXibFx6qezELOz/t5FkOw3AdnfRRGFy28uaDIskq8Q8HBOeZMPCqse8xpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOM9y+kx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOM9y+kx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896D21F000E9;
	Mon, 20 Jul 2026 21:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784581722;
	bh=IQgzDGgaExhJIpprRmVCQji+rU+Wr3B0j9mwrxgF/SY=;
	h=From:To:Cc:Subject:Date;
	b=NOM9y+kx9Zee8dxPKH8R5h0XFzYpGn3g2fotIhKA7Kw+yc4kjrKCZ4k6QkHUEmv8w
	 QKBw8AKPdgmpthNgTid4589blu9AKIK7T+PDdxjBXTqdr7BZTz5uXd2pbLkZ4tM9Q2
	 6tNLQ0fDNxOH2I6hZ6mR2YA5FOBj7bj1SGTUmhqyuQuoRWILFlOjAJrij6N4XbCHJ4
	 uGIIx4ljcWysH6K+jiXLaUyKDCgdUw2pbiGlSABeH2KftPH/y7DDe8PDAEv0LbIn/X
	 nCYFuuGWCCe/eqIw0seCUx/23Nvv/8QZ2jyZeUlBaDRlNmnFJB3GpGbUQ6QVeJ/rWY
	 jjFUpnsjAhfqg==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Use %pe format specifier to print error pointers
Date: Mon, 20 Jul 2026 21:08:39 +0000
Message-ID: <20260720210839.1507406-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, several files in the PCI tree print error pointers using
the %ld format specifier together with an explicit PTR_ERR()
conversion, which prints the numeric errno value.

Thus, at every affected call site, use the %pe format specifier, which
exists specifically to print error pointers, and pass the error pointer
directly.  With CONFIG_SYMBOLIC_ERRNAME enabled, this prints a symbolic
error name such as -ENOMEM, falling back to the numeric errno value
otherwise.  As such, the explicit PTR_ERR() conversion is no longer
needed.

No functional changes intended.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/controller/dwc/pci-meson.c     |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c | 16 ++++++++--------
 drivers/pci/controller/pci-aardvark.c      |  2 +-
 drivers/pci/controller/pci-tegra.c         |  3 +--
 drivers/pci/controller/pcie-rockchip.c     |  4 ++--
 drivers/pci/doe.c                          |  4 ++--
 drivers/pci/pci-acpi.c                     |  4 ++--
 7 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 225d887cd0a3..125229ca7d7c 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -398,7 +398,7 @@ static int meson_pcie_probe(struct platform_device *pdev)
 
 	mp->phy = devm_phy_get(dev, "pcie");
 	if (IS_ERR(mp->phy)) {
-		dev_err(dev, "get phy failed, %ld\n", PTR_ERR(mp->phy));
+		dev_err(dev, "get phy failed, %pe\n", mp->phy);
 		return PTR_ERR(mp->phy);
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 795cef5a915d..63a0f56cad8e 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2196,15 +2196,15 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->pex_ctl_supply)) {
 		ret = PTR_ERR(pcie->pex_ctl_supply);
 		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get regulator: %ld\n",
-				PTR_ERR(pcie->pex_ctl_supply));
+			dev_err(dev, "Failed to get regulator: %pe\n",
+				pcie->pex_ctl_supply);
 		return ret;
 	}
 
 	pcie->core_clk = devm_clk_get(dev, "core");
 	if (IS_ERR(pcie->core_clk)) {
-		dev_err(dev, "Failed to get core clock: %ld\n",
-			PTR_ERR(pcie->core_clk));
+		dev_err(dev, "Failed to get core clock: %pe\n",
+			pcie->core_clk);
 		return PTR_ERR(pcie->core_clk);
 	}
 
@@ -2226,8 +2226,8 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
 	pcie->core_apb_rst = devm_reset_control_get(dev, "apb");
 	if (IS_ERR(pcie->core_apb_rst)) {
-		dev_err(dev, "Failed to get APB reset: %ld\n",
-			PTR_ERR(pcie->core_apb_rst));
+		dev_err(dev, "Failed to get APB reset: %pe\n",
+			pcie->core_apb_rst);
 		return PTR_ERR(pcie->core_apb_rst);
 	}
 
@@ -2268,8 +2268,8 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
 	pcie->core_rst = devm_reset_control_get(dev, "core");
 	if (IS_ERR(pcie->core_rst)) {
-		dev_err(dev, "Failed to get core reset: %ld\n",
-			PTR_ERR(pcie->core_rst));
+		dev_err(dev, "Failed to get core reset: %pe\n",
+			pcie->core_rst);
 		return PTR_ERR(pcie->core_rst);
 	}
 
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index fd9c7d53e8a7..f2bbfb0f20c9 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1722,7 +1722,7 @@ static int advk_pcie_setup_phy(struct advk_pcie *pcie)
 
 	/* Old bindings miss the PHY handle */
 	if (IS_ERR(pcie->phy)) {
-		dev_warn(dev, "PHY unavailable (%ld)\n", PTR_ERR(pcie->phy));
+		dev_warn(dev, "PHY unavailable (%pe)\n", pcie->phy);
 		pcie->phy = NULL;
 		return 0;
 	}
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 229c69534476..59b56446c507 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1356,8 +1356,7 @@ static int tegra_pcie_port_get_phys(struct tegra_pcie_port *port)
 	for (i = 0; i < port->lanes; i++) {
 		phy = devm_of_phy_optional_get_index(dev, port->np, "pcie", i);
 		if (IS_ERR(phy)) {
-			dev_err(dev, "failed to get PHY#%u: %ld\n", i,
-				PTR_ERR(phy));
+			dev_err(dev, "failed to get PHY#%u: %pe\n", i, phy);
 			return PTR_ERR(phy);
 		}
 
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 0f88da378805..8d78ab1b31f0 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -232,8 +232,8 @@ int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
 
 		if (IS_ERR(phy)) {
 			if (PTR_ERR(phy) != -EPROBE_DEFER)
-				dev_err(dev, "missing phy for lane %d: %ld\n",
-					i, PTR_ERR(phy));
+				dev_err(dev, "missing phy for lane %d: %pe\n",
+					i, phy);
 			return PTR_ERR(phy);
 		}
 
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 7b41da4ec11a..ac95b1d2d999 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -858,8 +858,8 @@ void pci_doe_init(struct pci_dev *pdev)
 						      PCI_EXT_CAP_ID_DOE))) {
 		doe_mb = pci_doe_create_mb(pdev, offset);
 		if (IS_ERR(doe_mb)) {
-			pci_err(pdev, "[%x] failed to create mailbox: %ld\n",
-				offset, PTR_ERR(doe_mb));
+			pci_err(pdev, "[%x] failed to create mailbox: %pe\n",
+				offset, doe_mb);
 			continue;
 		}
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 4d0f2cb6c695..42d545edd7fa 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1636,8 +1636,8 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
 
 	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
 	if (IS_ERR(cfg)) {
-		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
-			PTR_ERR(cfg));
+		dev_err(dev, "%04x:%pR error %pe mapping ECAM\n", seg, bus_res,
+			cfg);
 		return NULL;
 	}
 
-- 
2.55.0

