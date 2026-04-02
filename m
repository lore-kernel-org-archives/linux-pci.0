Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786E93EE1EC;
	Thu,  2 Apr 2026 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140081; cv=none; b=cLRJEgeG6FxRHOv86zBCHNY3M8VHwGsxo0x5OFbsGVIrUfnzLsz/vfbVyiPQ5Hfn4EyGGnaHCFfPXA7g6N/cnfQL1ahh2WGEzJHiUQNnAG5fG5TQRShH1o+GdrhgqWDjYjSjVZdH4Pbhyx1HC5dywYwvuGURSqjmY40/1Jd+4f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140081; c=relaxed/simple;
	bh=KAMIzOzCbbIkdN4+h9mLaBbmQnop0xd9spJhdw58o5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hcAbdlinl76FRq7OOSqEDiSSS/5ptLRr/KFzqyD3DSB7Dt0/jU22/3Ap6AqdrzHqn+tn3hDzuOaSPGWbg3FgscPEAxSiv4YKmk60MpGPAIHN7zwXPdIO/reyuNoPIC7oFQJrHoMmPEkOz/ScBKA1/f0nO8v76IHd694MOxTAOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdmBp7yZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdmBp7yZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A16C2BCB2;
	Thu,  2 Apr 2026 14:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775140080;
	bh=KAMIzOzCbbIkdN4+h9mLaBbmQnop0xd9spJhdw58o5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FdmBp7yZC8Smmq2TO45C7ur2SCZkl8gcSfLPtb4lo4TH0BqX+FXIp7bh2VVL0j5wC
	 FR75B+Xt8OwP9FuaXn35F+mPRdD1tHvCSfw64rPTRSIKdYaFTk9lo/imjRi3di/hbt
	 8Awox14+qFJyM9f3JcQcVmsWbKnQUfeIpn6KiYG0Mi5FHDTTR7bQZciD8S2g6mePaj
	 EQgcenVlmhG1c+cMIeNKY+Fd4sYp7Cqvy6M51UX57MCIZwncsOIe71dLjFmxbIzmCA
	 3+yGsJSjRCxk7FAAcxYF7faPNHCtPJHcFG/TkTIAZ4MfZHMV1LSxwLy7nVercwHXZq
	 awz2aqkHVH88Q==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Thu, 02 Apr 2026 16:27:36 +0200
Subject: [PATCH v4 2/4] PCI: Use standard wait times for PCIe link
 monitoring
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-tegra264-pcie-v4-2-21e2e19987e8@nvidia.com>
References: <20260402-tegra264-pcie-v4-0-21e2e19987e8@nvidia.com>
In-Reply-To: <20260402-tegra264-pcie-v4-0-21e2e19987e8@nvidia.com>
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
 Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7887; i=treding@nvidia.com;
 h=from:subject:message-id; bh=oVBJHFwB+gdNI7W/8nXEvJ4Aw93e6oLvRNS3XbChGUY=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBpznzo0GCVjwX6st8+h0v682ZUEPkxIqGzROXu5
 Nfbq+SWm8GJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCac586AAKCRDdI6zXfz6z
 oWyWD/9KqFx3AWLsen71eImhEUWi5Vbr2EBrypY2+xZH9iKEKVVlJX6zH8ICwWXLq/9S1CoF7BI
 gyYELvWzJEiM6ESCDHKhPNtvGAoFCET+VjruIN+kzkv3g9g0n3yijseZDE3XYLW2n+fCQgrc/ue
 gv7U+JfI6npA9oOfh3rsk9jciSVRay4VjYG+IzF7kvWZFsIhDS1ComrThVZMJVXgYFHJ/EMm/1J
 uSZ2vSSneNVSp637VzbNkj4uxxHJBj9TZ81Qq3faJk7BNQOrSKbcJfZzbffZYxDYLBesi8fwKny
 oRsfmO86HYyG18GpqzHW4l3UEU+1EkO3H6Z0BN0j4rX1ZAGhe/RtzbZcoQBhvyla3/5OotxSGWp
 1zlZCz//YAA3VgdBTNI3ob5gd+3rQI6tXRCuRiO1zWmr9z/LBsOOJf47m7Fkcbm9vomT59v1azx
 XRgTCgolqoI1+LSMXlS7/hF8VU4otMyvnROWai7BSFtLOOKgUU7nuF74TwbSCTo9IYbVJkNR3n8
 serEUq/fObYix+yblw+nJqup+1zMA1nRuEa6KAU+7VqR//N/0kC8N7jx+0LXv67NjShXyH1UxCz
 cyxfUhS7mCo/PdAMIw7ttGQOksFOKFNN1cGiYY8IOqqDHc0ljMdVuOC4PY2DYYgAgwXgaFrLxOo
 drF5PgjYPbDmGyA==
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
index 13d998fbacce..f47ed96d8ef2 100644
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

