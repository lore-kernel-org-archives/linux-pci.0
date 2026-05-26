Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE1E3CF03E;
	Tue, 26 May 2026 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785613; cv=none; b=t4CiJ1d018LVkC4PIJD13z+ALzwIt7g5TmbWl+ABbvrQZY4pxKt0bdhcyyRBePJOeKpPXVQR9OJsclcDmrUSCuAvC+0Kw5oK08wXjPWgber7Ylfy35q5SWDJ15hIsPaN0+TQ1a2V2n1EmmWDDNFs8mfzPBuuX4L/ITTVKejVC/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785613; c=relaxed/simple;
	bh=B8ij85Hw/qLn5RVZglRVIKe28UjQQOL3hPs8+BosxGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOz7rk4Culsw+xRR9OJfL8s3V1AaCLUvHUIko+eUORFyju2e/uIX/K0Ah/a+PwBt5ewrbhiaDw280eEl8nqjhSvhB3DUhY/3hx49kqEyio4o5fFFR4+U9bEAgdI7Psn1UtK7nCHKVnKwkUMUICnzp2ldEddy/gFfVYTBBJru6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLJpYADu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLJpYADu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC281F00A3A;
	Tue, 26 May 2026 08:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779785612;
	bh=FTfoCK53LZqTZePQr1um+a30TBuhboiR4GXKJunKjI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fLJpYADuO9aDwXTgr1i6axXNU6GKD++aYW/x1kjnKWN1K0oYy5TiGmCkHM1WD5Z/9
	 dPSi43RgtGbPE51wxE2zLq6FVIZI+z9Y5IK/zCXBJsPI27Fzcggc94Bqets7gLrPi4
	 nSC4Ll4iQHnykhEJ1Wa2YRSO7UO598Daw6PWcoB/CNyoQm0kkVyhC2OuXNpJjNLrTd
	 dPwu57x+qDHf6uvr65rlY1EOcJ329rqeAd6hxhxL7AYSoOO5TBhuM9MLujvacwgj25
	 qx1uam2RySG9qSn0ON0utoilUCB+/sYeXkHsPXfvr9lkftMcfs+F5uNvAJ1YdMPkiU
	 BMiPW68mU3EVA==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Tue, 26 May 2026 10:53:11 +0200
Subject: [PATCH v5 2/4] PCI: Use standard wait times for PCIe link
 monitoring
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-tegra264-pcie-v5-2-84a813b979d7@nvidia.com>
References: <20260526-tegra264-pcie-v5-0-84a813b979d7@nvidia.com>
In-Reply-To: <20260526-tegra264-pcie-v5-0-84a813b979d7@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
 Thierry Reding <thierry.reding@kernel.org>, Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7887; i=treding@nvidia.com;
 h=from:subject:message-id; bh=21/xDPo1GJPZ4Dc6CWXBd9Y2Su9238+zhKdFG/Km44U=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqFV+Damiy3x3fwh0koJF9O4ZPkaHgfWQb1cEPr
 CE4hIyGVqiJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCahVfgwAKCRDdI6zXfz6z
 oYCKEACR+lTR3MhKk1M0IaR+PUW2zrhUjqZYEjFzd4AyM4cT2iril4pJniXGhjDoLkAdHHbxLsm
 GxgZ5tkMVjSBmLJLT/GLLmvSPuWTv9/Ij0K55VDk0ZlLd3fE18mCERaXwHQT9JEtvT6pIeeexNu
 nONfXbWRyw4uUpPvUClqJO3++w389E2eFQAdlJqXEqlPl/ScZk2UnIKb+Xp7cgEkDVpf5/GRthF
 g31RtBB/4FDbz8aV84qfLbCBXbcJuzqDaEOHaW6P0+39XouGOLTpvh/NVXjeEJV0BJxjAkrK4Dl
 WGBzOURG1NhR9a5P8We/o9CMLlsH07K9Mo/eyH9c7LTCdWkYVnPuGXnkDXDvAAgK9sEiPGhlfiG
 E5XlwVdOhD8PT4DCicDlS0D6SmJ/B4JFTynnSrf6zVdvg6SXAUBJO7J9VFiUH24T3G9cQvz0wk3
 4k7fQqECVX4GSoImR0ouschP/mWFrQ2NyQ9jl/SurHFCQcp9zXUAhGqZVBipbKdR2jvUilBAdAd
 7VBVwLtm7LqneYa0jEX9IhVG7gArIzk4Jzgfg0z5St0V7VSJSSoLS34O3L4fF4Ty7Xysmwb58sU
 6zc5QdMcDjJ2U5MyF4SglkjvyCMObaNaU+aXDE80gEY3iEgN3YBoEoc2Uu9iWZ2p+mhkQ0ojB2V
 K0FH8HeNQgehRkg==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Instead of defining the wait values for each driver, use common values
defined in the core pci.h header file. Note that most drivers don't use
the millisecond waits, but rather usleep_range(), so add these commonly
used values to the header so that all drivers can use them.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- fix build for Cadence
---
 drivers/pci/controller/cadence/pcie-cadence-host-common.c | 6 ++++--
 drivers/pci/controller/cadence/pcie-cadence-lga-regs.h    | 5 -----
 drivers/pci/controller/mobiveil/pcie-mobiveil.c           | 4 ++--
 drivers/pci/controller/mobiveil/pcie-mobiveil.h           | 5 -----
 drivers/pci/controller/pci-aardvark.c                     | 7 ++-----
 drivers/pci/controller/pcie-xilinx-nwl.c                  | 9 ++-------
 drivers/pci/controller/plda/pcie-starfive.c               | 9 ++-------
 drivers/pci/pci.h                                         | 2 ++
 8 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
index 2b0211870f02..72b36c70f389 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
@@ -15,6 +15,8 @@
 #include "pcie-cadence.h"
 #include "pcie-cadence-host-common.h"
 
+#include "../../pci.h"
+
 #define LINK_RETRAIN_TIMEOUT HZ
 
 u64 bar_max_size[] = {
@@ -53,12 +55,12 @@ int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie,
 	int retries;
 
 	/* Check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+	for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
 		if (pcie_link_up(pcie)) {
 			dev_info(dev, "Link up\n");
 			return 0;
 		}
-		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+		usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
 	}
 
 	return -ETIMEDOUT;
diff --git a/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h b/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
index 857b2140c5d2..15dc4fcaf45d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
+++ b/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
@@ -10,11 +10,6 @@
 
 #include <linux/bitfield.h>
 
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES	10
-#define LINK_WAIT_USLEEP_MIN	90000
-#define LINK_WAIT_USLEEP_MAX	100000
-
 /* Local Management Registers */
 #define CDNS_PCIE_LM_BASE	0x00100000
 
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
index 62ecbaeb0a60..cc102032c1e6 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -218,11 +218,11 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
 	int retries;
 
 	/* check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+	for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
 		if (mobiveil_pcie_link_up(pcie))
 			return 0;
 
-		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
+		usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
 	}
 
 	dev_err(&pcie->pdev->dev, "link never came up\n");
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index 7246de6a7176..11010a99e27c 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -122,11 +122,6 @@
 #define IB_WIN_SIZE			((u64)256 * 1024 * 1024 * 1024)
 #define MAX_PIO_WINDOWS			8
 
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_MIN			90000
-#define LINK_WAIT_MAX			100000
-
 #define PAGED_ADDR_BNDRY		0xc00
 #define OFFSET_TO_PAGE_ADDR(off)	\
 	((off & PAGE_LO_MASK) | PAGED_ADDR_BNDRY)
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index e34bea1ff0ac..506323a6c72b 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -255,9 +255,6 @@ enum {
 #define PIO_RETRY_CNT			750000 /* 1.5 s */
 #define PIO_RETRY_DELAY			2 /* 2 us*/
 
-#define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_USLEEP_MIN		90000
-#define LINK_WAIT_USLEEP_MAX		100000
 #define RETRAIN_WAIT_MAX_RETRIES	10
 #define RETRAIN_WAIT_USLEEP_US		2000
 
@@ -349,11 +346,11 @@ static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
 	int retries;
 
 	/* check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+	for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
 		if (advk_pcie_link_up(pcie))
 			return 0;
 
-		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+		usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
 	}
 
 	return -ETIMEDOUT;
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 7db2c96c6cec..fc65e9fdddb3 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -140,11 +140,6 @@
 #define PCIE_PHY_LINKUP_BIT		BIT(0)
 #define PHY_RDY_LINKUP_BIT		BIT(1)
 
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES          10
-#define LINK_WAIT_USLEEP_MIN           90000
-#define LINK_WAIT_USLEEP_MAX           100000
-
 struct nwl_msi {			/* MSI information */
 	DECLARE_BITMAP(bitmap, INT_PCI_MSI_NR);
 	struct irq_domain *dev_domain;
@@ -203,10 +198,10 @@ static int nwl_wait_for_link(struct nwl_pcie *pcie)
 	int retries;
 
 	/* check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+	for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
 		if (nwl_phy_link_up(pcie))
 			return 0;
-		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+		usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
 	}
 
 	dev_err(dev, "PHY link never came up\n");
diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 298036c3e7f9..542a751b6f4d 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -45,11 +45,6 @@
 #define STG_SYSCON_LNKSTA_OFFSET		0x170
 #define DATA_LINK_ACTIVE			BIT(5)
 
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES	10
-#define LINK_WAIT_USLEEP_MIN	90000
-#define LINK_WAIT_USLEEP_MAX	100000
-
 struct starfive_jh7110_pcie {
 	struct plda_pcie_rp plda;
 	struct reset_control *resets;
@@ -217,12 +212,12 @@ static int starfive_pcie_host_wait_for_link(struct starfive_jh7110_pcie *pcie)
 	int retries;
 
 	/* Check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+	for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
 		if (starfive_pcie_link_up(&pcie->plda)) {
 			dev_info(pcie->plda.dev, "port link up\n");
 			return 0;
 		}
-		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+		usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
 	}
 
 	return -ETIMEDOUT;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b36667969ad5..54a9e06e85f8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -63,6 +63,8 @@ struct pcie_tlp_log;
 /* Parameters for the waiting for link up routine */
 #define PCIE_LINK_WAIT_MAX_RETRIES	10
 #define PCIE_LINK_WAIT_SLEEP_MS		90
+#define PCIE_LINK_WAIT_US_MIN		90000
+#define PCIE_LINK_WAIT_US_MAX		100000
 
 /* Format of TLP; PCIe r7.0, sec 2.2.1 */
 #define PCIE_TLP_FMT_3DW_NO_DATA	0x00 /* 3DW header, no data */

-- 
2.52.0

