Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F3388E46;
	Thu, 16 Jul 2026 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221666; cv=none; b=KHGiRc2mnqBKnl+4gkxjKbCXQw9pL/xvHueZRssSXZLbJfoWK7s4zCh8iMwMfq/GIox1JL2+t30tHZ80+b9FwluETFF6wSWJxcS4n1BGtGtEaNH2nKiCZF8J9Xx4WdfYpYTLDAUunQQkJYn7uHxD8kIuWgyLJxaAdgZ85qDrd2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221666; c=relaxed/simple;
	bh=P1+t5VwEpzkLybpDlvsNCDgvYALGLpWirZwTa23h8Ys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ms3BLPMvVZwwlnTYgH/XTxS07I13amrNN3frgFLrOR4HaTzWicQSebl/QpBk/7TvMSgFK/CsdkcfRRbStN2LdQlRfyZefr71lRsCqSCp1t0VrY6uBj1DjXRt4mCEtezeNUeHr0vurkkaJuX2ZsMTQWH/CEjDPQWH1R7RAbQ8Kgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4mNrgeC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4mNrgeC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C0B1F00A3F;
	Thu, 16 Jul 2026 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784221659;
	bh=+GZBC2JMwjaLCP92ysgens8LkXkleMQIpb6ugrXdIBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=F4mNrgeCOpe2e86kubyrk+t5HLArijL0q1P5GWkbv9m/PQqlsS4MMRxqpt9IwiOmC
	 9+Z9w+/WOC7CIOGss5p98vSVW3sC8ITiygP+VFQ2rVp3wf6RsthUi/x+eM+iNH9ewv
	 Oz05thWuZdia2o01sNVcDOL8c2pxHO7JHaY+zA+Yb9QJSI14zw7jHyEPundOTteFCq
	 bm3/98gMAdiQPteDximNfnOEH3JKNeqsGRZ69CC//hYpgeZCO7QZtTcsUML0bkzW05
	 krKTHr45Kg6xG/jmvtVpFLGT5t03ym/TN82aMClQIhixJkJjOI5bZ0N0Diu1qUlqzB
	 Ofl34t+LgEEqg==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Thu, 16 Jul 2026 19:07:14 +0200
Subject: [PATCH v8 3/6] PCI: Use standard wait times for PCIe link
 monitoring
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-tegra264-pcie-v8-3-23e51589229b@nvidia.com>
References: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
In-Reply-To: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7585; i=treding@nvidia.com;
 h=from:subject:message-id; bh=JmbVJZG0ek7JwrjZ8mJSK4lVcfAx1G+/ygj6G4RV5Z8=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqWQ/QdzKLgojz1NTzlGmvj6Q9YfKXDz1d26gLm
 YNWF8wYR0yJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCalkP0AAKCRDdI6zXfz6z
 oVlNEACFvQe3oWt9wQOxG85TSLBT33yvOILfISWCqmLZVNumHpRZ0pbAAdC/nYo3wi3v43eFk5a
 kwEUl37p/aCuPdfP313mQCiZ4lgaoHYqufZHahNO5i8oGxgOrIA4nbCGWwKP1NcJ5h8bZwBrh/o
 dRfxs85WkIEQ8lbynGUH6DSXXixme4tjJ0LmFW0Lxsvoafg3VVW6bmVGtbCaXoEE61NCX6AJJuR
 QQMKqqe/YfHR42ESy7V6LFvV8dlwpNga0mdpQI4LHFqvTeGX8rJTrhzQWYTvaIUBlPyI4JBKI6D
 99v8iS8K73v3AhX/P2Uz4jHZwj19y/CczCs57X6dji4TH7Fh+OooUaxn0DQ+mWugLeg58iAosXF
 LBTLoXEymahEZvB8OfoFBRJkvDAsboaPpSi5/jstbVTZVPAWC55ibrNU0pblLsFSmQrM9H6fgYE
 wilQrSMNwD5IaEAQ+A1ZzgflxiV1c44x7oxoNCpozJJ6q/Lt4ts4uT7RWk0Ioq1GhzyQTpQwVIq
 O1SsYS8lPiWlnPpAS9/5qPYBx3Q7tEB+Qllf4kA2AakfY5DJLITwYDmOJn8cgYgLQbtTDzhfTeo
 mOeA9id/MlmCYI+psyHsn/SGWCGOptANCGXwVI7HicOweve0hwdOKZOAUsjzttH4UKLP/kFUBKL
 /1/o1R+SLRqDusA==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Instead of defining the wait values for each driver, use common values
defined in the core pci.h header file. Note that while most drivers use
the usleep_range(), it looks like these were mostly cargo culted and
msleep() is a better choice given the fixed delay that the specification
calls for. Convert all drivers to msleep() and use the existing
definition.

Reviewed-by: Aksh Garg <a-garg7@ti.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v8:
- add Reviewed-by from Aksh Garg

Changes in v7:
- rebase on top of next-20260615 (resolve pci-aardvark.c conflict)

Changes in v6:
- convert all drivers to use msleep() (Lukas Wunner)

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
 7 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
index 18e4b6c760b5..0ef4396151b4 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
@@ -16,6 +16,8 @@
 #include "pcie-cadence-host-common.h"
 #include "../pci-host-common.h"
 
+#include "../../pci.h"
+
 #define LINK_RETRAIN_TIMEOUT HZ
 
 u64 bar_max_size[] = {
@@ -54,12 +56,12 @@ int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie,
 	int retries;
 
 	/* Check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+	for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
 		if (pcie_link_up(pcie)) {
 			dev_info(dev, "Link up\n");
 			return 0;
 		}
-		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+		msleep(PCIE_LINK_WAIT_SLEEP_MS);
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
index 62ecbaeb0a60..e8346851c49b 100644
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
+		msleep(PCIE_LINK_WAIT_SLEEP_MS);
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
index fd9c7d53e8a7..272c5c8fc1e5 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -256,9 +256,6 @@ enum {
 #define PIO_RETRY_CNT			750000 /* 1.5 s */
 #define PIO_RETRY_DELAY			2 /* 2 us*/
 
-#define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_USLEEP_MIN		90000
-#define LINK_WAIT_USLEEP_MAX		100000
 #define RETRAIN_WAIT_MAX_RETRIES	10
 #define RETRAIN_WAIT_USLEEP_US		2000
 
@@ -350,13 +347,13 @@ static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
 	int retries;
 
 	/* check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+	for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
 		if (advk_pcie_link_up(pcie)) {
 			pci_host_common_link_train_delay(pcie->link_gen);
 			return 0;
 		}
 
-		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+		msleep(PCIE_LINK_WAIT_SLEEP_MS);
 	}
 
 	return -ETIMEDOUT;
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 7db2c96c6cec..0dee19fa24ca 100644
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
+		msleep(PCIE_LINK_WAIT_SLEEP_MS);
 	}
 
 	dev_err(dev, "PHY link never came up\n");
diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 298036c3e7f9..2835c7af965e 100644
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
+		msleep(PCIE_LINK_WAIT_SLEEP_MS);
 	}
 
 	return -ETIMEDOUT;

-- 
2.54.0

