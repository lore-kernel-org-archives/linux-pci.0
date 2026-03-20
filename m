Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DFE244665
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2026 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046904; cv=none; b=jJ9eiVoABbC3IlUpxojdINdoixN228BRluA1ETrlRy4o5U0iyL14GXmt19rAv20hRNJHqsNwTwrvqUx/TYfd/KhT0Bhq4LL/qIT0nl5iFIQ+D9cZcoButnTXwuL5XkOvJFPzu8Q+hbARQ0N9lB6RAZWM+9/CgQM3mUC4hZacOyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046904; c=relaxed/simple;
	bh=F7wtKERyAW10tVzrR2NShbHmK35CspKk2rWys/MAvP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbYKFkXNEvbfz1IlcGh1b38kRe6JIRYSMdJaAkF0DRsRxB120rdfp+1RFtC9MWUxlyoA3fu7QcZWipfPGFMQ86F1DxGIhoiinoG1RR8XQ073XhdXVpWgeLKI0QU/i4qVcS7u0IQKCUx82C8ZhZPS0gYaKC353ty/tn2wCe5pTp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGbKwdr2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGbKwdr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6F4C4CEF7;
	Fri, 20 Mar 2026 22:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774046904;
	bh=F7wtKERyAW10tVzrR2NShbHmK35CspKk2rWys/MAvP4=;
	h=From:To:Cc:Subject:Date:From;
	b=sGbKwdr2hTRLY61YuicQzhkmlkhf/lvghTup859FwzglNeIHN0+w20+f30Ebzr8dO
	 MFv/ut4h2ZnrR7WRV+lDogKXVtZwJqs1RZLKxJhGpoqIJZnafwX687mzKnOisxCPTK
	 gO43SaRdrnfsmBZUin/4vRQwzt4rM5Jt4v/qFcIAyVF8X6xrR61NhxwY4jcvLe7LzX
	 qQ4pLlZdqJKz23HRY9LzHMI32NZOuxGWyWc6egXxPnpvAmUr2NcmwPhFaBvpYHVBr6
	 0lW8xiDUWPzqzjjFJxAO0oTzoq8jfdPMQ1xd2OVrgmFkPi/KkTklqlQtmqAPpApPet
	 FlEr4wrBVbIsg==
From: Thierry Reding <thierry.reding@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: Use standard wait times for PCIe link monitoring
Date: Fri, 20 Mar 2026 23:48:21 +0100
Message-ID: <20260320224821.2571373-1-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Instead of defining the wait values for each driver, use common values
defined in the core pci.h header file. Note that most drivers don't use
the millisecond waits, but rather usleep_range(), so add these commonly
used values to the header so that all drivers can use them.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- fix build for Cadence

 .../pci/controller/cadence/pcie-cadence-host-common.c    | 6 ++++--
 drivers/pci/controller/cadence/pcie-cadence-lga-regs.h   | 5 -----
 drivers/pci/controller/mobiveil/pcie-mobiveil.c          | 4 ++--
 drivers/pci/controller/mobiveil/pcie-mobiveil.h          | 5 -----
 drivers/pci/controller/pci-aardvark.c                    | 7 ++-----
 drivers/pci/controller/pcie-xilinx-nwl.c                 | 9 ++-------
 drivers/pci/controller/plda/pcie-starfive.c              | 9 ++-------
 drivers/pci/pci.h                                        | 2 ++
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
index e542d1bf2853..0ca1c159b458 100644
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

