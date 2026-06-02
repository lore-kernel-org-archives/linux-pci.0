Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CBF3DA5AD;
	Tue,  2 Jun 2026 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400039; cv=none; b=OpuMqsRGP3I+Zl3qt80j5sUIbCN/zgAd2UPRKrjZJMDMBWhHqS0lnAZLYp2GYoG42R5Wl1RaR+sM/AUqLa1bpQTY1XoAGGUImsEQrl2Ib+2w2oi8fuceScZ+9tG+k5I8k+Jw1SNyyfLMifQ8kEOvwTlfa1v//rWejcyt6mOwvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400039; c=relaxed/simple;
	bh=I2PRLhHp5HFMtHk9nLbKcnZYbHbNwQC1Zz0YggL3jq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OgziI32zsBGBSvcYqhmw4zny/N4iMF+bwJ1PkuXxw3fxarg41WRezaiFRRJE9Fl77NyS1Mm+95S8jmS2QpcG/647mCMETKZUDQOY1kdEcYFxvuCkrls0yx3ygPseq6xVbeQKs+f3e4O1QkQMMYwz9Fh3gzTNll0PDPASgbOR4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haD7O7PB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haD7O7PB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A6A1F00899;
	Tue,  2 Jun 2026 11:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780400034;
	bh=9Dti1Ks9iser3mNgTmZWTGw6Q5z0m+WnYKy0bxCCQIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=haD7O7PBJVQBaJ7hiNa1nJscDcnjgGJehsGoiOkx1LLgcW/y9f426fu6mB+5Ail7U
	 hehDcJYpCV/9ASf/LfhPgLLP3SUsD+ZJfQrutTLuifyHBUHNBmdToj9uYZtHfDHQoc
	 1wECKoCDjvPCjzRhO2F4f3OxifIjJw5mdR/cHur9kYvicFlnW4GAUENPGO1yyNBQHo
	 mb42tLJLNw4DqSzApiFjJQ+hlKoJhnahUNiFMBe21dpH93er+XcqPipoPoaFQJWrhx
	 7OsXS+mjX1fxcMFSrlEI/YYFpHgPWKNilwpumkGEA0OxTVVIoJb+ivNTeBA2Tq0wN1
	 HKVVhfTbkbzVw==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Tue, 02 Jun 2026 13:33:24 +0200
Subject: [PATCH v6 2/4] PCI: Use standard wait times for PCIe link
 monitoring
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tegra264-pcie-v6-2-edbcfa7a78fe@nvidia.com>
References: <20260602-tegra264-pcie-v6-0-edbcfa7a78fe@nvidia.com>
In-Reply-To: <20260602-tegra264-pcie-v6-0-edbcfa7a78fe@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7337; i=treding@nvidia.com;
 h=from:subject:message-id; bh=jYE+kLAQiCWkq5qD/7JKEUn3MiW3S1xDlNdPvcYdLho=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqHr+a+msU6u/m2qG8xBA+cAmDG6+fTr57Mvrya
 e18fc7Y466JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCah6/mgAKCRDdI6zXfz6z
 of8FD/9L5v2x+HSXZkKKjSwua6I55S/R2n/AURzqk4cEawv3G838cJn6RiFiqcstmMULpeBJUbE
 Rws29cr3DXe5RjASOICVzFXwCQtQY//vX+LMfXdlhraEGd05SGUL8IbHJ8ycndpJ3KC+vkFXOLM
 KdDeUfJKOuSfdOa/gp0ay9Uj3S519lQjffq3XiKbWofgg/1+jiogeNXEU85cjhx6S8K0qdF6NWR
 60MKPpUooZBYr8NkiME7Wh/lBZgKgtj1nf9DNrfO8eIz+Lp3m5yNE4EpnK0mnuk7J6CFwACu2Lk
 z0CZWwRz6/C61zq3DxwzyGJHcFyycVszmGDZ8hNi3frOVPTzvVj4uGP8DeNlMbpaxJyesnx5yRM
 CaoMnJoeRql7mopyw9GX3GOkcsKGSAklXgYn5EUA8SkvfyXnVFldgANq4LiGhdDmuXttY6XU4H5
 I9JH8V851HXcspfWoQ545ZWwwRcCPZJVf3nyNP5+eEO0ntIeD8vYCRHxVcj5nUVtDHxhPIfmZG8
 ovgAcv9JPc2JIYGbdjLqzOPL60M89lp5XXSacecxQkKsTY6U90pFxnL4roWnnbYW25OtL/lZA/g
 PN+unKg47HPLBObpDhRWQXSRt3o1/rtPiDkYTX8/K0wG2Y4yB0P4bjzx6QGDWA3epSknCxGvLQX
 +C+35K/2ZeBLCxw==
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
index 2b0211870f02..41a59e1582b6 100644
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
index e34bea1ff0ac..160e1fb685c9 100644
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
2.52.0

