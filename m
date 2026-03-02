Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012051.outbound.protection.outlook.com [40.93.195.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E03A3AE194;
	Mon,  2 Mar 2026 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483912; cv=fail; b=LBy2OZFdGVm8Xt0qLExgCjUNlTGWN611HJPHMEtPNGVYQAy3ttmVS3euW5/5SEzfQ34PRe+qCaKjucUZChZm7QJfJYOxULEXnHu49a7wjbrrzYfgBbM7pCFPvzZgPXvcDDZ365YGsnqbHCvp+qAgwUuNcgO2VTSlRD8yOgtOG74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483912; c=relaxed/simple;
	bh=V7dpm3FqSxwHKax0Ste9odiXW/Tn+MKbPAI+CCpQDGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHM1JRpFLTao/DxkPt7xQ5NCtGDNr9vMBKm2Vuj4Kafrt00CKzt3XefDHsAB+n3xH6CvDx/bJ9FVtfFXDOXvJuVPXMMfRz0YF1ZH+PhWkBA3OuK+Ob5Q4m1BUf67s1V0pEtcEVrG0WWYfB77YbqbiEJJKxJF1h6AxEWOfyqZB/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2mCweIjl; arc=fail smtp.client-ip=40.93.195.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2mCweIjl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oL9J4ribspU1jFOCH2ECbiWUKL8WOTQ5Ikj5zJB+darfpwTgPKIJF9VMQ4n/Zo1H6uSjeBYnQJFd6tKSEbaikGPk4Z3xyhKYOR9vPlOFNSyFqpQTxFd1sCLt0ZAcx4pykWx3zvhNVro9O5I1yN23SJ3jXdg2nQ2MI3yPLj5omQN4uds6MUKuaprBtCSwuAyBscUt0OWXI2RbtcIT1q63djDGQvXu0y22YqPz7c9CG3hVuVCwcB8QNykTaAlAMPLiN5ZiUwp+n71jmSR1sA2Z0nELYH5cJrNv9ziiehmJEdCZMcKMX5zil7BKe72tFGE5Moc1EzVWphBhmNgSCcAoag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCxvhw7qeKBmSfbcs0STtNTkxZQlF4AX6G64K/xVMWg=;
 b=lLOYRI5N8RSDMzXd1zvqZBdXehOONNfcl95+A63eJuO263Oc5qtWhOSVOouE6oHIhvtCcU9KpoQXf4ShCf4nHv+yRtSDh9UbDhyuZWGJAv9114V3vs0I6wH+/xSC8/V6uQDpkrdnA3gCAV2K/o422HdSAIE4YpYUV3WiUMBe0d29Txu63rBUm3l+DVlolKl1ycyX3gdUYiRny+fYJZ4qUolmoMJnPkJKJJ//Ng/edVnFofVXJzE5BzQkQG/7klkd0H1dTAetOaP0kRkImnbqWjtOcco6CWIcWUNSRPiYi1vKTWaniCMV74o3Tb4t5rwMbHySJk4SKuVEroi73YvazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCxvhw7qeKBmSfbcs0STtNTkxZQlF4AX6G64K/xVMWg=;
 b=2mCweIjlEg3kfTb9P3exyeuHtu069rufIpdUnXs7ccdfUggmYGj9eZ8OA2R5XkrGGAMGnahhGepcCEdVDGiOu5dkpcykgGqH+pmaGCSaiVYEJHoUAYOfXF9v60ICq2zQ1S1ZH3j9jQJlSuALXw9L09e4b4lbV9hJqWNEUJjB5f4=
Received: from MN2PR19CA0061.namprd19.prod.outlook.com (2603:10b6:208:19b::38)
 by LV9PR12MB9831.namprd12.prod.outlook.com (2603:10b6:408:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 20:38:23 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::95) by MN2PR19CA0061.outlook.office365.com
 (2603:10b6:208:19b::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Mon,
 2 Mar 2026 20:38:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 20:38:23 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 14:38:22 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v16 08/10] cxl: Update Endpoint AER uncorrectable handler
Date: Mon, 2 Mar 2026 14:36:46 -0600
Message-ID: <20260302203648.2886956-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302203648.2886956-1-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|LV9PR12MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: a868d40d-a859-4dc2-2f7a-08de789ba5d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|30052699003|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	LhLpzLiCaf1U2Tt8CzgyRSdIeDhluVF2BjtA1ZT2NnIEq8rpFqgMCRljUNdRrMdt10n7Uos7uYXkOvjqHrwbSw1w9vnTTrt9OQUm77UJgvDNDa7NBp3Zq40/pRNhRJENuZ0gAjPafS50wDWuFUMdRc0sXj+VnR4jZBbhjf9N1VDKcd04rHLQELzAXyId4SNylabkv4Hpqwyt0urHrE7HH94iQpttp9zzVM0DU6xU0T0Q2PufXkQvBLt8/RLK8dU1xwNhrlw5WQ2T1WzN1A0Ki1ba6Ty3GwZu470Vs9NzsiiRsupArLBKrwarVhfcw7icw7lND8QgjuHcJDl5s+c6nLFsaJxjLTk3GiFIHiPgQb205tlfqBGwrkPcV6LoGWG1efnnojAau++17lqlk1+d+Gp6wVU1zHJ06qzu40BXcgKJoJQPeXLzbXiA+kw3tFSByGKooYTO+yZNu06FQtPXeWuP7gNJyHNGwrognw/Qm5AjoxjtsRp9U9kj+8dXQSSMGkRDtwMvKA+TuJRvRipGiQbLjOI1sp7PpMJlEVbuF/vBZ5W3iMrsu6BrPufq5TKW9DTCX2HRji5aNK+gPDnUlHM0gt2vB1o7tpGy1ay+7yOs5UbU478tDjNxV5SsrS8Rrb/8bPi9+9wuTdvWspPE170zB96YyeE028tw9wX1x9numYZAoPkysJStqvy4hHuouVUnylQDhVBnvOVYnHWQ1AowLUrXpayRD5SM9BUuDUMzsmmA8UxUTFjq7jmXRmO8lTs7YrZPdBWo12+0TdTb+vM7kCh1ndJ5kg8/6dGwteHS81MlSy5Hcwixt6Sp4eIwEFXoVS4LZvSy+jYBTy9VHg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(30052699003)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pSmUuKtnvWK0e9MZO1/1WiKR1VnFTXRnE/s9hTP25YdRXq1M4xSRRcNRcJ16vn3NpBD/qhfos81iA/SnRiDA5Ovj9dEL8aMAoL2468Gl23cHmoiCjoswAJV8nASM/Lsah3xljtasgFIPzSDQ/5JH2kb0WIwjQkjLFb2dNrVUvi/VVxpUHvPGOKh3GwaDbkuYP5F2GZPAG6VTf30KAuqcfpiKxKGihLoa+Z6AQQ7pEtXJ7YDMXI/rB8qR1AsTd9MohDK4OVPjyp6Geq7lRiUE5R8pqRnd2x3q/Wm/b6MGIktfnlXqSUf+9jptlp4xoMMFP1AV5NdJForCd9657ssa9mRGCQLNu63Kgu3yiI/bMqHgKsM8W0KdRh/mzXuaAyvamv1Dp2KdZm30gzILb+11vmaU7+SgkB9ePSGnZkUDirXHaZ4oNSm6xolOlg+P1KWF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:38:23.0091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a868d40d-a859-4dc2-2f7a-08de789ba5d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9831

CXL drivers now implement protocol RAS support. PCI protocol errors,
however, continue to be reported via the AER capability and must still be
handled by a PCI error recovery callback.

Replace the existing cxl_error_detected() callback in cxl/pci.c with a
new cxl_pci_error_detected() implementation that handles uncorrectable
AER PCI protocol errors. Changes for PCI Correctable protocol errors will
be added in a future patch.

Introduce function cxl_uncor_aer_present() to handle and log the CXL
Endpoint's AER errors. Endpoint fatal AER errors are not currently logged by
the AER driver and require logging here with a call to pci_print_aer().

This cleanly separates CXL protocol error handling from PCI AER handling
and ensures that each subsystem processes only the errors it is
responsible.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Assisted-by: Azure:gpt4.1-nano-key

---

Changes in v15->v16:
- Update commit message (DaveJ)
- s/cxl_handle_aer()/cxl_uncor_aer_present()/g (Jonathan)
- cxl_uncor_aer_present(): Leave original result calculation based on
  if a UCE is present and the provided state (Terry)
- Add call to pci_print_aer(). AER fails to log because is upstream
  link (Terry)

Changes in v14->v15:
- Update commit message and title. Added Bjorn's ack.
- Move CE and UCE handling logic here

Changes in v13->v14:
- Add Dave Jiang's review-by
- Update commit message & headline (Bjorn)
- Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
  one line (Jonathan)
- Remove cxl_walk_port() (Dan)
- Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
  sufficient (Dan)
- Remove device_lock_if()
- Combined CE and UCE here (Terry)

Changes in v12->v13:
- Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
  patch (Terry)
- Remove EP case in cxl_get_ras_base(), not used. (Terry)
- Remove check for dport->dport_dev (Dave)
- Remove whitespace (Terry)

Changes in v11->v12:
- Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
  pci_to_cxl_dev()
- Change cxl_error_detected() -> cxl_cor_error_detected()
- Remove NULL variable assignments
- Replace bus_find_device() with find_cxl_port_by_uport() for upstream
  port searches.

Changes in v10->v11:
- None
---
 drivers/cxl/core/ras.c | 57 ++++++++++++++++++++++++------------------
 drivers/cxl/cxlpci.h   |  9 +++----
 drivers/cxl/pci.c      |  6 ++---
 3 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 254144d19764..884e40c66638 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -393,34 +393,41 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
 
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
+static bool cxl_uncor_aer_present(struct pci_dev *pdev)
 {
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlmd->dev;
-	bool ue;
-
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return PCI_ERS_RESULT_DISCONNECT;
-		}
+	struct aer_capability_regs aer_regs;
+	u32 fatal, aer_cap = pdev->aer_cap;
 
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(pdev);
-		/*
-		 * A frozen channel indicates an impending reset which is fatal to
-		 * CXL.mem operation, and will likely crash the system. On the off
-		 * chance the situation is recoverable dump the status of the RAS
-		 * capability registers and bounce the active state of the memdev.
-		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
-				    cxlmd->endpoint->regs.ras);
+	if (!aer_cap) {
+		pr_warn_ratelimited("%s: AER capability isn't present\n",
+				    pci_name(pdev));
+		return false;
 	}
 
+	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_STATUS,
+			      &aer_regs.uncor_status);
+	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_MASK,
+			      &aer_regs.uncor_mask);
+	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_SEVER,
+			      &aer_regs.uncor_severity);
+
+	fatal = (aer_regs.uncor_severity & aer_regs.uncor_severity);
+	pci_print_aer(pdev, fatal ? AER_FATAL : AER_NONFATAL, &aer_regs);
+
+	pci_aer_clear_nonfatal_status(pdev);
+	pci_aer_clear_fatal_status(pdev);
+
+	return aer_regs.uncor_status & ~aer_regs.uncor_mask;
+}
+
+pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+					pci_channel_state_t state)
+{
+	bool ue = cxl_uncor_aer_present(pdev);
+	struct cxl_port *port = get_cxl_port(pdev);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+	struct device *dev = &cxlmd->dev;
+
 	switch (state) {
 	case pci_channel_io_normal:
 		if (ue) {
@@ -441,7 +448,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	}
 	return PCI_ERS_RESULT_NEED_RESET;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_pci_error_detected, "CXL");
 
 static void cxl_handle_proto_error(struct pci_dev *pdev, int severity)
 {
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0cf64218aa16..86029d96d6bb 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -79,15 +79,14 @@ void read_cdat_data(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_RAS
 void cxl_cor_error_detected(struct pci_dev *pdev);
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state);
 void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
+pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+					pci_channel_state_t error);
 void devm_cxl_port_ras_setup(struct cxl_port *port);
 #else
 static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
-
-static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-						  pci_channel_state_t state)
+static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+						      pci_channel_state_t state)
 {
 	return PCI_ERS_RESULT_NONE;
 }
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index fbb300a01830..b57f4727af53 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1051,8 +1051,8 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
-static const struct pci_error_handlers cxl_error_handlers = {
-	.error_detected	= cxl_error_detected,
+static const struct pci_error_handlers pci_error_handlers = {
+	.error_detected	= cxl_pci_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
 	.cor_error_detected	= cxl_cor_error_detected,
@@ -1063,7 +1063,7 @@ static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
-	.err_handler		= &cxl_error_handlers,
+	.err_handler		= &pci_error_handlers,
 	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.34.1

