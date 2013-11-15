Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:50800 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab3KOUzT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2013 15:55:19 -0500
From: Stephen Warren <swarren@wwwdotorg.org>
To: swarren@wwwdotorg.org
Cc: Stephen Warren <swarren@nvidia.com>, treding@nvidia.com,
	pdeschrijver@nvidia.com, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	=?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom@nvidia.com>,
	David Airlie <airlied@linux.ie>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 10/31] ARM: tegra: pass reset to tegra_powergate_sequence_power_up()
Date: Fri, 15 Nov 2013 13:54:05 -0700
Message-Id: <1384548866-13141-11-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Warren <swarren@nvidia.com>

Tegra's clock driver now provides an implementation of the common
reset API (include/linux/reset.h). Use this instead of the old Tegra-
specific API; that will soon be removed.

Cc: treding@nvidia.com
Cc: pdeschrijver@nvidia.com
Cc: linux-tegra@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: Terje Bergström <tbergstrom@nvidia.com>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.
---
 arch/arm/mach-tegra/powergate.c | 8 +++++---
 drivers/gpu/drm/tegra/gr3d.c    | 6 ++++--
 drivers/pci/host/pci-tegra.c    | 3 ++-
 include/linux/tegra-powergate.h | 4 +++-
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
index 85d28e756bb7..f6f5b54ff95e 100644
--- a/arch/arm/mach-tegra/powergate.c
+++ b/arch/arm/mach-tegra/powergate.c
@@ -25,6 +25,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/reset.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/clk/tegra.h>
@@ -144,11 +145,12 @@ int tegra_powergate_remove_clamping(int id)
 }
 
 /* Must be called with clk disabled, and returns with clk enabled */
-int tegra_powergate_sequence_power_up(int id, struct clk *clk)
+int tegra_powergate_sequence_power_up(int id, struct clk *clk,
+					struct reset_control *rst)
 {
 	int ret;
 
-	tegra_periph_reset_assert(clk);
+	reset_control_assert(rst);
 
 	ret = tegra_powergate_power_on(id);
 	if (ret)
@@ -165,7 +167,7 @@ int tegra_powergate_sequence_power_up(int id, struct clk *clk)
 		goto err_clamp;
 
 	udelay(10);
-	tegra_periph_reset_deassert(clk);
+	reset_control_deassert(rst);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index f629e38b00e4..0cbb24b1ae04 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -279,7 +279,8 @@ static int gr3d_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_3D, gr3d->clk);
+	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_3D, gr3d->clk,
+						gr3d->rst);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to power up 3D unit\n");
 		return err;
@@ -287,7 +288,8 @@ static int gr3d_probe(struct platform_device *pdev)
 
 	if (gr3d->clk_secondary) {
 		err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_3D1,
-							gr3d->clk_secondary);
+							gr3d->clk_secondary,
+							gr3d->rst_secondary);
 		if (err < 0) {
 			dev_err(&pdev->dev,
 				"failed to power up secondary 3D unit\n");
diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 174a5bc2d993..aace19edc469 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -956,7 +956,8 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 	}
 
 	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
-						pcie->pex_clk);
+						pcie->pex_clk,
+						pcie->pex_rst);
 	if (err) {
 		dev_err(pcie->dev, "powerup sequence failed: %d\n", err);
 		return err;
diff --git a/include/linux/tegra-powergate.h b/include/linux/tegra-powergate.h
index c98cfa406952..b5ad64aca071 100644
--- a/include/linux/tegra-powergate.h
+++ b/include/linux/tegra-powergate.h
@@ -19,6 +19,7 @@
 #define _MACH_TEGRA_POWERGATE_H_
 
 struct clk;
+struct reset_control;
 
 #define TEGRA_POWERGATE_CPU	0
 #define TEGRA_POWERGATE_3D	1
@@ -51,6 +52,7 @@ int tegra_powergate_power_off(int id);
 int tegra_powergate_remove_clamping(int id);
 
 /* Must be called with clk disabled, and returns with clk enabled */
-int tegra_powergate_sequence_power_up(int id, struct clk *clk);
+int tegra_powergate_sequence_power_up(int id, struct clk *clk,
+					struct reset_control *rst);
 
 #endif /* _MACH_TEGRA_POWERGATE_H_ */
-- 
1.8.1.5

