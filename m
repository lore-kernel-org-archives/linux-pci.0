Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C6347ECD3;
	Wed, 17 Jun 2026 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712161; cv=none; b=qd++9MET5p1AMRZlzwNuHrIBHSGWtJMy5hohCWjNffFP94djNdfwisSxQ3Whw6qdzZNn7Kyz8Zaa9rBHjRYQzo/snTI+2OtNYvatV8tath7oU1CQpmOZRNDEvw4w3y33n/B8yXQg0/AD3mRWDv0TyB2rbSmjyqpY0SeMgKauI2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712161; c=relaxed/simple;
	bh=PivXib4sXb95Qs6MahWPwwcB3h4Sc3AXyFBcCwjroKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qOZZPn+1u9IGSTShs4xna9hhfC3JJn19dC0yhd5Zsu0pzUj5fWwHfVEEISFMMxxOeRQfvGRYfSHXDF3zDaof4C8ixGd49P86OgWN+lmaeMMyGllyQIs2K8ob2ymNtw8wOpLmJtbKZkiZxfIHmKPBRm+ypg1YVbtWIkYp5prxOLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHLYP1QZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHLYP1QZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED5E1F00A3F;
	Wed, 17 Jun 2026 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781712149;
	bh=QNi1JC1xdqoQ5ONotS9xiWx2AAGAr5IspdmCzux8EbU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NHLYP1QZpyTwJUVywdWkFbnDjkJYQ5LPuBf7z5JOj05o/AkexJymSO7H979gCI9W2
	 9A02YNmrHA+u5IpNTGueKH1OFCn1OWP0ooD+jOEwfdwMz/p855ouKPFTjxgOdM1upA
	 on1mASX3q1dE2yG8w6VPyoo5DqECFE7dKPWZ6PGnsbRQLrWFgrBJRKF3f/honMWega
	 oTyo3LTDsXVC3np0BHbqjcQ2GEleyj0LOtoTTLzcvRSuzMzCuuJpGtwXVKrLzvhfUx
	 Dm/TUp0If6wGKIgCeZbWcMh+Fo3MJuMj/dFY2wTVsO+wL6aWEbUY3U9HM83c5slq9t
	 5PKVEvam+a3KQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Wed, 17 Jun 2026 18:01:29 +0200
Subject: [PATCH v7 2/4] PCI: Use standard wait times for PCIe link
 monitoring
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-tegra264-pcie-v7-2-eae7ae964629@nvidia.com>
References: <20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com>
In-Reply-To: <20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7492; i=treding@nvidia.com;
 h=from:subject:message-id; bh=ogWzBW+DHXsXJyPZQjohxRSjVQ0Qs3oEo8BcfVyfLQk=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqMsUMPq9+rH88Qrp55QFFsojmF5R7/6zWsslBj
 FbEPPB39SyJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCajLFDAAKCRDdI6zXfz6z
 oeVVD/4szWYI/LqcrBjLQ7evSUaotOuFFUfQ1aDutME8d6Wrs+50r+zTztgeJ+engkidhY7kGuU
 w782vDVpPQ0mtfTOGBVlCQH1WhIMJmU9ylCmJgGZ3U2NHNikbep2gaJZZpRpRcfmhtbJWyBkCSD
 098GqMY2Kr9uLVTAO8Xw3p6GcOTVjsGP9LrHVhYbNpDfZ228ykOuXTMxZhQ1YmsjQYJv2rmvGN3
 2kw7gKPB6JJKBbSUakgvbYiTAVasXOWvhXVzKHt4x5N00S9KKApNWAR5VOOxZUlyLTUwv8RtGhQ
 NP0YewpIgx52RKHmNpl8yrkJ2v6FxNrUd+qlrLBPdRIrMF0YyiqZ79Q/lD9Tti3f9lkOHKF6j+P
 HyBSKdMPqNtCVZZVHQuwaD3gdHPMRt6HNObY/rfBV/Gzuuru9pRVAfbSNG5y/iYzYSG4uMXLe6g
 ptXeTKvSeEqB0X8ANgy4N0m+q34kdGSeIbDGN1MOwCMrPV8cB5uMExAahcYICf3HZO3pxBJlpGU
 DcLHlDP3xKjAzEPr0Sc2bWTkWQmnnDYtLSa4VAUoZqbXmWVMsahJq/1gFakuPuuDzGX4SXT1juP
 mLw58kMizF6JSno+WDjefiCxHItBXiTlNFKklWSTDcGVhyKO6l6JVK0klFYL9Mt1geECDm0PR9X
 eEFrYvU0bvjoUBA==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Instead of defining the wait values for each driver, use common values
defined in the core pci.h header file. Note that while most drivers use
the usleep_range(), it looks like these were mostly cargo culted and
msleep() is a better choice given the fixed delay that the specification
calls for. Convert all drivers to msleep() and use the existing
definition.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
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

