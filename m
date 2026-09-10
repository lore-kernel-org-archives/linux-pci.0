Received: from mail-m3277.qiye.163.com (mail-m3277.qiye.163.com [220.197.32.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F10339375;
	Thu, 10 Sep 2026 01:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005444; cv=none; b=dtzJGcGxndpkx6v7YhZMAOjKYWTZPfv/HVEXfYecYFGiZNLGutdTjE6lztGU5934dIDdShntxjNIFDUEBbGDIkvKeSSzYyGmAe3B2fMAxaRTgyudgbt1k7eQXygGi0BThZrQ2aEo7FiSelzWHTwubiR5o1Eetu0jv8K5RbFXSg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005444; c=relaxed/simple;
	bh=8P6RFvNRM7aVavOKJDcdcE1GFLkxo7Qq05iPs3SN7Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QcsNC32JYOEtN9pcfzzwiKZu1tyD1eXlUaxa/11aSwe8uYRmZbQl3DMZSyx3NBNpuKceID6BzvWb7RJY4fbIwHX0+Bq5CuhZ7l/5yBaKQBTalhiRmNMePJ3iTHCCMhSz0dhSjq3eY7ZayZHcMjw8/VggWX3rtIpr80U5B36g9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b=ckg4bEvP; arc=none smtp.client-ip=220.197.32.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b="ckg4bEvP"
Received: from localhost.localdomain (unknown [122.224.147.158])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d333b606;
	Thu, 10 Sep 2026 09:51:58 +0800 (GMT+08:00)
From: Hongbo Yao <andy.xu@hj-micro.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peter.du@hj-micro.com,
	jemma.zhang@hj-micro.com,
	rick.yan@hj-micro.com,
	Hongbo Yao <andy.xu@hj-micro.com>
Subject: [RFC PATCH] PCI: pciehp: Allow more time for link activation after slot power-on
Date: Thu, 10 Sep 2026 09:51:51 +0800
Message-ID: <20260910015151.1876630-1-andy.xu@hj-micro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa08903bba203aekunmb2e45c464cd740
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQxgfVh1NGUxLSE5LQkgYS1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUpPTFVKTkNZV1kWGg8SFR0UWUFZT0tIVU
	pLSEpKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=ckg4bEvP7UuyUdW8JQUEYtxnBDcnNYrwDUqI5Ec+SF4AAWQpdJwLrLi7SHOXOSlnuVdjrkm/2blYzz3vNobmTN61L54/1354ksv0rMi3YnMchaAIa/ezgzQQGkKs2Rm1r2Lqj71smfDyy8f5JCkyjjX8Xl3awPP7nDNr2qxc2jo=; c=relaxed/relaxed; s=default; d=hj-micro.com; v=1;
	bh=GL/D1ac2I1bLVT/3wNdeeRjnwkgUx/3HUYxNALzM58M=;
	h=date:mime-version:subject:message-id:from;

The OCP NIC 3.0 Specification, version 1.6.0, Figure 132 [1], requires
an interval greater than one second between Main Power Valid and PERST#
deassertion.  The diagram labels this interval T_PVPERL.  PCIe link
activation requires additional time after PERST# is deasserted.

In the reported scenario, the adapter is already installed in a
powered-off slot.  Pressing the Attention Button generates the event
that causes pciehp to enable slot power and then check the link.
The one-second DLLLA polling timeout does not account for the above
reset hold interval when that interval overlaps the link wait, so it
can report failure before the adapter can activate the link.

This is observed with an OCP ConnectX-7 (MT2910 family) adapter.  On the
affected platform, power-on to PERST# deassertion takes about 1.2 seconds,
followed by a few hundred milliseconds for link activation, exceeding
the existing polling budget.

Add pcie_wait_for_link_timeout() to allow a caller-supplied initial
polling timeout.  Keep the existing pcie_wait_for_link() and
pcie_wait_for_link_delay() interfaces and their default timeout.
Use a three-second polling budget in pciehp for slots advertising
power control.  Other slots and link retraining retain one second.

Three seconds is a proposed allowance for the reported sequence, not a
timing requirement derived from the specification.

[1] OCP NIC 3.0 Specification, version 1.6.0, Figure 132,
    "Power-Up Sequencing - Normal Operation".

Link: https://www.opencompute.org/wiki/Server/NIC

Signed-off-by: Hongbo Yao <andy.xu@hj-micro.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |  9 +++++++-
 drivers/pci/pci.c                | 38 ++++++++++++++++++++++----------
 drivers/pci/pci.h                |  2 ++
 3 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3cb4..14b82b9b03a2 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -28,6 +28,8 @@
 #include "../pci.h"
 #include "pciehp.h"
 
+#define PCIEHP_LINK_UP_TIMEOUT_MS	3000
+
 static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
 	/*
 	 * Match all Dell systems, as some Dell systems have inband
@@ -291,10 +293,15 @@ static void pcie_wait_for_presence(struct pci_dev *pdev)
 int pciehp_check_link_status(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
+	unsigned int timeout_ms = PCIE_LINK_RETRAIN_TIMEOUT_MS;
 	bool found;
 	u16 lnk_status, linksta2;
 
-	if (!pcie_wait_for_link(pdev, true)) {
+	/* Account for power sequencing and reset hold time when enabling a slot. */
+	if (POWER_CTRL(ctrl))
+		timeout_ms = PCIEHP_LINK_UP_TIMEOUT_MS;
+
+	if (!pcie_wait_for_link_timeout(pdev, true, 100, timeout_ms)) {
 		ctrl_info(ctrl, "Slot(%s): No link\n", slot_name(ctrl));
 		return -1;
 	}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a73d1a3a8939..772d4c8abfcf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4553,12 +4553,14 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
  * @pdev: Device whose link to wait for.
  * @use_lt: Use the LT bit if TRUE, or the DLLLA bit if FALSE.
  * @active: Waiting for active or inactive?
+ * @timeout_ms: Link status polling timeout in milliseconds
  *
  * Return 0 if successful, or -ETIMEDOUT if status has not changed within
- * PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds.
+ * @timeout_ms milliseconds.
  */
 static int pcie_wait_for_link_status(struct pci_dev *pdev,
-				     bool use_lt, bool active)
+				     bool use_lt, bool active,
+				     unsigned int timeout_ms)
 {
 	u16 lnksta_mask, lnksta_match;
 	unsigned long end_jiffies;
@@ -4567,7 +4569,7 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
 	lnksta_mask = use_lt ? PCI_EXP_LNKSTA_LT : PCI_EXP_LNKSTA_DLLLA;
 	lnksta_match = active ? lnksta_mask : 0;
 
-	end_jiffies = jiffies + msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
+	end_jiffies = jiffies + msecs_to_jiffies(timeout_ms);
 	do {
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
 		if ((lnksta & lnksta_mask) == lnksta_match)
@@ -4606,7 +4608,8 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 	 * avoid LTSSM race as recommended in Implementation Note at the end
 	 * of PCIe r6.1 sec 7.5.3.7.
 	 */
-	rc = pcie_wait_for_link_status(pdev, true, false);
+	rc = pcie_wait_for_link_status(pdev, true, false,
+				       PCIE_LINK_RETRAIN_TIMEOUT_MS);
 	if (rc)
 		return rc;
 
@@ -4620,7 +4623,8 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 		pcie_capability_clear_word(pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
 	}
 
-	rc = pcie_wait_for_link_status(pdev, use_lt, !use_lt);
+	rc = pcie_wait_for_link_status(pdev, use_lt, !use_lt,
+				       PCIE_LINK_RETRAIN_TIMEOUT_MS);
 
 	/*
 	 * Clear LBMS after a manual retrain so that the bit can be used
@@ -4644,24 +4648,27 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 }
 
 /**
- * pcie_wait_for_link_delay - Wait until link is active or inactive
+ * pcie_wait_for_link_timeout - Wait for link with a specified polling timeout
  * @pdev: Bridge device
  * @active: waiting for active or inactive?
  * @delay: Delay to wait after link has become active (in ms)
+ * @timeout_ms: Link status polling timeout in milliseconds
  *
- * Use this to wait till link becomes active or inactive.
+ * The timeout covers initial link status polling, not the additional delays
+ * or failed-link recovery.  Without link active reporting, wait for timeout_ms
+ * plus delay instead of polling.
  */
-static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
-				     int delay)
+bool pcie_wait_for_link_timeout(struct pci_dev *pdev, bool active, int delay,
+			       unsigned int timeout_ms)
 {
 	int rc;
 
 	/*
 	 * Some controllers might not implement link active reporting. In this
-	 * case, we wait for 1000 ms + any delay requested by the caller.
+	 * case, wait for timeout_ms plus any delay requested by the caller.
 	 */
 	if (!pdev->link_active_reporting) {
-		msleep(PCIE_LINK_RETRAIN_TIMEOUT_MS + delay);
+		msleep(timeout_ms + delay);
 		return true;
 	}
 
@@ -4676,7 +4683,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 	 */
 	if (active)
 		msleep(20);
-	rc = pcie_wait_for_link_status(pdev, false, active);
+	rc = pcie_wait_for_link_status(pdev, false, active, timeout_ms);
 	if (active) {
 		if (rc)
 			rc = pcie_failed_link_retrain(pdev);
@@ -4693,6 +4700,13 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 	return true;
 }
 
+static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
+				     int delay)
+{
+	return pcie_wait_for_link_timeout(pdev, active, delay,
+					  PCIE_LINK_RETRAIN_TIMEOUT_MS);
+}
+
 /**
  * pcie_wait_for_link - Wait until link is active or inactive
  * @pdev: Bridge device
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..1984e4c1891c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1078,6 +1078,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
+bool pcie_wait_for_link_timeout(struct pci_dev *pdev, bool active, int delay,
+			       unsigned int timeout_ms);
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 
 /* ASPM-related functionality we need even without CONFIG_PCIEASPM */
-- 
2.43.0

