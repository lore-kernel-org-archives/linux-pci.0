Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795258261;
	b=byNlbXgsJgbKTvqWxhj7xQgOO7JX4RyNECnrMHc0ZU+itWISpKHXWX0NlpIg8ED9kZJR
	 ennDIwcCqcSE6HA2D2EF4jIHpjP4e2JPBxlmc26a7F5jhc319ERww6CplZZ5jf88J8lj6
	 hvXmEMpq7iSjdA00Pq2jn6nfUja43/y6G5V4L8EbCgO6EnA7Rm7+nUmcg0h3JaocHjrjE
	 GkQSimvDShSWkl/HdUowQXTmSrHpdL8qI5YSv5GTBqIByXBhIn+rfdnTr4R/Ht3ntdY/M
	 6iD0h0fhV+LTVRF9iigCEpMgzEym6FIV3LR/SgCpzqx+kTXTkFP+R7WZB7JyobLb5RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795258261;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=M/ARuAtZjvBYiN9dCUvY/c/RYFPb3ETuS8cmj71muUY=;
	b=hxIfHo6IoZ/j4aV3m71LeDHRePRokfx4YuW1Ep+0t3/QDqM4Y99JZY/iqe599EEnH4XX
	 24OBwLYEL6yzjWkLB0y6kbc+HrMMnqX9mBDPPRhuUkDCZo62RxxQUHI8ZrlxiNdSQT8Am
	 KYCWLJv029P0cuGNoBuW0oRv023Ka/5QHTXHNKKHXZLxNnMEtYF3+Dz57sGMuHT3knXab
	 3kVEuIQFJMD/ZIqneunAYYLmBRZnf/5clFRVZ7pNKmC11BDlTmYpnhhuboX9Y9UrYJV2y
	 j3AoZhJRFmkgvferQ7xTr/o/7jFM43ZHgL8Ao9XyOwf+anOhPfdJNswTsBPmUJHiouw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=wpkf8KL6;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D37606A32A;
	Sat, 21 Nov 2026 10:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3D37606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=wpkf8KL6
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=M/ARuAtZjvBYiN9dCUvY/c/RYFPb3ETuS8cmj71muUY=;
	b=wpkf8KL6Ap4MvBK5IKUKJLs21eUL/Eb15FTXcS5B1vls5P+jEVcO8xouYO2FL08ui+aXc5A3K
	wwjSdkRMJkAnaodJ91b598agTCNvam33McDKsysvkBH83BHHps5f3xWeDUiCP2Tfj909k3cdxf9
	StsDzAGsY8DrCPcj2oKtML8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jWprF0fpRz1T4GM;
	Sat, 21 Nov 2026 18:50:05 +0800 (CST)
Received: from dggpemr500010.china.huawei.com (unknown [7.185.36.210])
	by mail.maildlp.com (Postfix) with ESMTPS id 33ED8203C1;
	Sat, 21 Nov 2026 18:50:49 +0800 (CST)
Received: from huawei.com (10.50.85.180) by dggpemr500010.china.huawei.com
 (7.185.36.210) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 21 Nov
 2026 18:50:48 +0800
From: Hongtao Zhang <zhanghongtao35@huawei.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>, <mani@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <liuyongqiang13@huawei.com>
Subject: [PATCH v1] PCI: Make PCIe link wait timeout configurable via pcie_link_timeout=
Date: Sat, 21 Nov 2026 19:08:06 +0800
Message-ID: <20261121110806.1158344-1-zhanghongtao35@huawei.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemr500010.china.huawei.com (7.185.36.210)

PCIE_LINK_RETRAIN_TIMEOUT_MS fixes the timeout for waiting on PCIe
link training and link state transitions at 1000 ms, matching the
PCIe spec's minimum recommendation for declaring a non-responsive
device broken.

As hardware evolves, some combinations of newer devices and newer
boards may need more than 1 sec to bring the link up. Rather than
changing the compiled-in constant for each such case, make the
timeout runtime-configurable: keep 1000 ms as the default and allow
raising it at boot via "pcie_link_timeout=<ms>", range [1000, 10000].
This gives platform and device bring-up a flexible knob to
accommodate slower link training without any code change, while
out-of-range values fall back to the spec default. The ceiling keeps
failure detection, bus/slot lock hold times, and the blind-sleep path
on ports without Link Active Reporting well below upper-layer error
handling thresholds.

Accordingly, adjust the two DPC log messages that hardcoded "1000
msec" to print the actually configured timeout.

Signed-off-by: Hongtao Zhang <zhanghongtao35@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         | 14 +++++
 drivers/pci/pci.c                             | 61 +++++++++++++++++--
 drivers/pci/pci.h                             | 10 +++
 drivers/pci/pcie/dpc.c                        |  6 +-
 4 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd94..cde4faa5e3187 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5304,6 +5304,20 @@ Kernel parameters
 		force	Enable ASPM even on devices that claim not to support it.
 			WARNING: Forcing ASPM on may cause system lockups.
 
+	pcie_link_timeout=
+			[PCIE] Timeout in milliseconds to wait for PCIe link
+			training and link state (up/down) transitions, e.g.
+			during hot-plug power-on, error recovery resets and
+			runtime resume.
+			Some devices, or specific device/board combinations,
+			may need more than the PCIe spec's 1 sec to train the
+			link; use this to raise the wait, e.g.
+			pcie_link_timeout=3000
+			Range: [1000, 10000] ms. Values out of range are
+			ignored with a warning and the 1000 ms default is
+			used. Only affects failure detection latency; healthy
+			links return as soon as training completes.
+
 	pcie_ports=	[PCIE] PCIe port services handling:
 		native	Use native PCIe services (PME, AER, DPC, PCIe hotplug)
 			even if the platform doesn't give the OS permission to
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba81443..a5996beeaebbd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -159,6 +159,25 @@ static bool pci_bridge_d3_disable;
 /* Force bridge_d3 for all PCIe ports */
 static bool pci_bridge_d3_force;
 
+/*
+ * Effective timeout (ms) for waiting on PCIe link training / state changes.
+ * Defaults to the spec-mandated 1 sec floor.  Devices or device/board
+ * combinations that legitimately need longer than 1 sec to train the link
+ * can raise this at boot via "pcie_link_timeout=<ms>".
+ */
+unsigned int pcie_link_retrain_timeout_ms = PCIE_LINK_RETRAIN_TIMEOUT_MS;
+EXPORT_SYMBOL_GPL(pcie_link_retrain_timeout_ms);
+
+/*
+ * Upper bound for pcie_link_timeout=.  Generous headroom for slower link
+ * training, yet far below the ~30 sec abort threshold used by block/NVMe
+ * error handling so a single link wait cannot cascade into abort/reset
+ * loops above us.  On ports without Link Active Reporting the wait is a
+ * blind sleep that runs even for healthy devices, so the ceiling must
+ * bound that cost as well.
+ */
+#define PCIE_LINK_RETRAIN_TIMEOUT_MAX_MS	10000
+
 static int __init pcie_port_pm_setup(char *str)
 {
 	if (!strcmp(str, "off"))
@@ -169,6 +188,37 @@ static int __init pcie_port_pm_setup(char *str)
 }
 __setup("pcie_port_pm=", pcie_port_pm_setup);
 
+static int __init pcie_link_timeout_setup(char *str)
+{
+	unsigned int timeout;
+
+	if (kstrtouint(str, 10, &timeout)) {
+		pr_warn("PCIe: invalid pcie_link_timeout=%s, using default %u ms\n",
+			str, PCIE_LINK_RETRAIN_TIMEOUT_MS);
+		return 1;
+	}
+
+	/*
+	 * Floor: PCIe spec requires at least 1 sec before declaring a device
+	 * that has not responded as broken.  Ceiling: keep a single link wait
+	 * well below upper-layer timeouts so failure detection stays bounded
+	 * (see PCIE_LINK_RETRAIN_TIMEOUT_MAX_MS).
+	 */
+	if (timeout < PCIE_LINK_RETRAIN_TIMEOUT_MS ||
+	    timeout > PCIE_LINK_RETRAIN_TIMEOUT_MAX_MS) {
+		pr_warn("PCIe: pcie_link_timeout=%u out of range [%u, %u] ms, using default %u ms\n",
+			timeout, (unsigned int)PCIE_LINK_RETRAIN_TIMEOUT_MS,
+			(unsigned int)PCIE_LINK_RETRAIN_TIMEOUT_MAX_MS,
+			PCIE_LINK_RETRAIN_TIMEOUT_MS);
+		return 1;
+	}
+
+	pcie_link_retrain_timeout_ms = timeout;
+	pr_info("PCIe: link wait timeout set to %u ms\n", timeout);
+	return 1;
+}
+__setup("pcie_link_timeout=", pcie_link_timeout_setup);
+
 /**
  * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
  * @bus: pointer to PCI bus structure to search
@@ -4612,7 +4662,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
  * @active: Waiting for active or inactive?
  *
  * Return 0 if successful, or -ETIMEDOUT if status has not changed within
- * PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds.
+ * pcie_link_retrain_timeout_ms milliseconds.
  */
 static int pcie_wait_for_link_status(struct pci_dev *pdev,
 				     bool use_lt, bool active)
@@ -4624,7 +4674,7 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
 	lnksta_mask = use_lt ? PCI_EXP_LNKSTA_LT : PCI_EXP_LNKSTA_DLLLA;
 	lnksta_match = active ? lnksta_mask : 0;
 
-	end_jiffies = jiffies + msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
+	end_jiffies = jiffies + msecs_to_jiffies(pcie_link_retrain_timeout_ms);
 	do {
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
 		if ((lnksta & lnksta_mask) == lnksta_match)
@@ -4650,7 +4700,7 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
  * bit is valid.
  *
  * Return 0 if successful, or -ETIMEDOUT if training has not completed
- * within PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds.
+ * within pcie_link_retrain_timeout_ms milliseconds.
  */
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 {
@@ -4715,10 +4765,11 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 
 	/*
 	 * Some controllers might not implement link active reporting. In this
-	 * case, we wait for 1000 ms + any delay requested by the caller.
+	 * case, we wait for pcie_link_retrain_timeout_ms + any delay requested
+	 * by the caller.
 	 */
 	if (!pdev->link_active_reporting) {
-		msleep(PCIE_LINK_RETRAIN_TIMEOUT_MS + delay);
+		msleep(pcie_link_retrain_timeout_ms + delay);
 		return true;
 	}
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960e..e060e129f02a0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -20,8 +20,18 @@ struct pcie_tlp_log;
 
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
 
+/*
+ * Default timeout for link retraining / link state transitions.  PCIe spec
+ * says software must allow at least 1 sec before declaring a device that
+ * has not responded as broken; keep that as the floor.  The effective value
+ * can be raised at boot via the "pcie_link_timeout=" parameter for devices
+ * that need longer to bring the link up.
+ */
 #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
 
+/* Effective, boot-configurable link wait timeout in milliseconds. */
+extern unsigned int pcie_link_retrain_timeout_ms;
+
 /*
  * Power stable to PERST# inactive.
  *
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861b..ef04532d9c8ab 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -163,7 +163,8 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	 * to allow the Port to leave DPC.
 	 */
 	if (!pcie_wait_for_link(pdev, false))
-		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
+		pci_info(pdev, "Data Link Layer Link Active not cleared in %u msec\n",
+			 pcie_link_retrain_timeout_ms);
 
 	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev)) {
 		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
@@ -328,7 +329,8 @@ static void pci_clear_surpdn_errors(struct pci_dev *pdev)
 static void dpc_handle_surprise_removal(struct pci_dev *pdev)
 {
 	if (!pcie_wait_for_link(pdev, false)) {
-		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
+		pci_info(pdev, "Data Link Layer Link Active not cleared in %u msec\n",
+			 pcie_link_retrain_timeout_ms);
 		goto out;
 	}
 
-- 
2.43.0

