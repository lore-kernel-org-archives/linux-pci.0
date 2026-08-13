Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECD7442B1B;
	Thu, 13 Aug 2026 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613910; cv=fail; b=tLo8WqZZK2oaLcq9OR3/DKJCKFmBbY2lP+c6zD/M8B7fmdyEJ7KfgDTmoBbcZxSh60w2KzwCWSUS47RrAGTWSQrerHlmVr/+xBTDXLg1rS0GJAkKNdLUELx2W0gnz+3NPAPXAvFw0lMkvIRb2qsKTXgDJLcSRKMIHbHhB7vFOaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613910; c=relaxed/simple;
	bh=RP9ZVqH0Lb4Uswsw1sSvc0eu12TKSTpCrqUjyyef1Eo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjoC62Qpy1T8qHzMBUbKpxNYQ5akT/5mCmh+G+vWZHf2zmqpsoWvcyPKUWMHWltYqSVnScFmurHYo9auFekmwIy4dOEZqDdZG8jZkcZhJRrCXzXP1R2BEHtisoAOQ+AmMDMPK/HxC2JnOQTzq0kGXPaLTOcF5VklTOJyivDHYu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c+NGhz5H; arc=fail smtp.client-ip=40.93.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c+NGhz5H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bETqEMEySTnpCp+hgEby8SmK+fWG3eaKdDFFKTIEE5k5TL8S43pZwkLdKSnm+To+jNtShx2pricninBq5VZhyGY/Iv/49avXLf8kSSuQ5FxMcWd7Cef+c7pbMIQBFkHpCmRsnB/2YPAYdn9xA6OmKg26iwmiItVeVO8pKwCrRTvqJ4vLF/VcDnDKWPV4x5I5gw0rF5x+4NqH3whDz1mo5LeSNu+tALnNqsfSPugAT0hL3M1LOhyoiGIHc/DUv8ctX0CqDG3EI3zbQueSg39yloeFSSz/lD9qw1dHXcvRcyq1buiC3YkRgTUvTb5mpf+zd66/ikbIjeT4VgaxjWs8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVrAVcBZYj+/Chui4bJBop97Wc8Ww8d0lQpUOgg6jHQ=;
 b=RXrg2Ewfu0rIJwDRMJ9h3lOWvLSYkD2awbUjtuVa0JbVtMSzkVw3NZD2JExw7YsKJsXYLxCxZf6dfuDpRr5mNtwr1xBfx+6v8OR8zFUs/4PgCEBbest9myMF//yMJxeqFxGYYQqErkbedGO0YkgsDYXmDYQW3q0F+0xn32jIdbryK64b2TpobFtKX9i7z6iCuBiimOOjYuM/I9dPMoSz5kiZfyuasY+ApcqaZkx8Jg+nlE3PXNr0Mjf+nJWYgfbUBlphsZmhxYAQHpjPikqC0SjZfXhSUJNzn6usnI6Rcbyn8IWCQXBHVUvg8nqjzFeGR5CBpz+b1eInf/VP+/0dZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVrAVcBZYj+/Chui4bJBop97Wc8Ww8d0lQpUOgg6jHQ=;
 b=c+NGhz5Hqt37dvK2yidNCJfq8qnXyVbcmKhj/AkxvfOmQyHFTYG6s0YlvefO/yi210IENRxYZagxQsTUMWKBi5zmHbOCwHoBijNnJ6Jq4AkUtcH4eXDaLcVDQHnhQ1opFNn/5ZlxvOPY/3CHZ6yg8JQ2Cb9ZOWAaXmZpyO+xiFEE3Knh+Bmpo6ZwGmw+kUZtQEC1TdNBx28tFuUVIHCANLMScGAMGeDkj64g6bceTmeCyFZV0SdjJq4foyXQ+PJKEwSH1oupXCEH9oECwuURY+HypfY/y18519BYjlINjVvLtwFP1HoCXjtfiwvEWo8eghOK7b/tJ+5H5JWBeIW2ug==
Received: from BN0PR04CA0136.namprd04.prod.outlook.com (2603:10b6:408:ed::21)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 09:38:17 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::5b) by BN0PR04CA0136.outlook.office365.com
 (2603:10b6:408:ed::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 09:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:38:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:37:59 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:37:50 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v4 05/27] cxl: Add a function-scoped reset entry for vfio-pci
Date: Thu, 13 Aug 2026 15:06:09 +0530
Message-ID: <20260813093631.2288172-6-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813093631.2288172-1-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d92626-a7cb-4908-aa20-08def91e9aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700016|23010399003|376014|10067099003|56012099006|11063799006|5023799004|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	hiKwo+e2SVl3tGEBj1+b6fp/w6q/zCBmelo7H+atHgNkRbH9F8rB5RUDiQde6pI/L7U/uSmmYOp50dAjcQXobIydr361SY1Rw0fHUN43UwSqPQOdBVfZV+VB7ujjoAbNctjMxhXBVP3umaCWK5lG1H3HaBLIuN3a2sHJdR2G1rVS3CeD24Yezrvp5jTaQU7YEPwZvyiAe21R3zZNZHEQmOA2yd5MCQBDv5ddHDMQVkYLNCroY/KL/qgwdPDbgJFMFBwD45d2F3lKjZUQVloO4bFlEqCPe/UTO7wQLsmU9NRhr/TK0evCaK9xoyKMVtXCTK8Qtld/mKgTedY0PSmiW4cKP+Xyr8UXSOAwHCPHxyhVp3T6P1mwWf8lx5wpvuukgE3NLdRceGfdNalUmpJryVj7uu/6BdK7WcxmbZBc+CmqFbC+NLg9VIZlBqz/Lf5DSMkvyxXBMJTykd/Guf9YxcS7g1XZXJgThnEjTqAvQdQ19dCr8xMgfUCh20VbRAzR/3TFKy2lqyGvdd/IFRFomo0lIic8RwvCMPxMCHm2p1uX8vGQnZOsWhuf+b9up0Uoead4dUxCC6Are4B/aJ61hRYcrcXwEYZXK6jvZS7hkdhbSHkfizEbaMiPxookyPSk37gQoqZQGiGtf0BUqNvMfhnRKgJCdiG2vAJ1kax9GPGG8DmSfYTDwY+vvUZjXXf9swnVkctn4zi7NVbM6n0C+vDPCN6/8lktmPgF4wRAYc6Encok6csyE79AiaNW/PKK
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BmmA9NUg0dnB+CNKTrLaSksXYnDhhtB2qa0ailp2pMn3I/Hff9auwa3GHymlmosKdywsdgOIbCYHs6ea5ktcHjwCqpMLgAOxvRvFMNPlmlXgs+h5WQwksc5mdkVnweeg4Jxn3AzLSNzYl7sm9JbpIUcqlW+EXDKJZlg+cXZTiOayl+q+zNJaE++eyGRZd7syYicG2BehkP0DJeMw9bsG4bvp5iEz6NJP4u3JatWQ1e2dBFGWvoMk9h7Sdnh8pJ5NXREKnrTMGhuVHhaDY6TX+FCDPL7PQxs0YaxGfVZxPxPv9RgIwzq41toeeEnYTxsZYQgee6lHM9cKaXEwuVGA5tKVq2/KRqkWbX34E7MUUIt0YY7XSF4nlh0fq/YVmPoZQEhMHYXm1ETq5ARnp/K4/QOuJUv4RpuvweGPamDzB/MS9P2pP5s7tu3vLl407PXs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:38:17.0099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d92626-a7cb-4908-aa20-08def91e9aa3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298

From: Manish Honap <mhonap@nvidia.com>

vfio-pci needs to run a CXL reset on a passthroughed Type-2 device
without the host-memory handling in cxl_reset_function(): the memory
behind the decoder belongs to the guest.

Add cxl_reset_dvsec_sequence(), which runs the DVSEC reset and HDM decoder
restore under pci_dev_lock and cxl_rwsem, and cxl_reset_capable() to gate
it on a function-scoped reset.

Parameterize Memory Clear in cxl_reset_execute() so the guest owns the
choice; the host path keeps it disabled.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/resource.c | 69 ++++++++++++++++++++++++++++++++++---
 include/cxl/cxl.h           | 12 +++++++
 2 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 492ffe8e3576..cd15bd9171e6 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -1164,7 +1164,7 @@ static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec)
 				     PCI_DVSEC_CXL_DISABLE_CACHING);
 }
 
-static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec)
+static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec, bool mem_clr_en)
 {
 	u16 ctrl2;
 	int rc;
@@ -1173,7 +1173,10 @@ static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec)
 	if (rc)
 		return rc;
 
-	ctrl2 &= ~PCI_DVSEC_CXL_RST_MEM_CLR_EN;
+	if (mem_clr_en)
+		ctrl2 |= PCI_DVSEC_CXL_RST_MEM_CLR_EN;
+	else
+		ctrl2 &= ~PCI_DVSEC_CXL_RST_MEM_CLR_EN;
 	ctrl2 |= PCI_DVSEC_CXL_INIT_CXL_RST;
 	return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
 }
@@ -1273,7 +1276,7 @@ static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
 }
 
 static int cxl_reset_execute(struct pci_dev *pdev, bool *target_prepared,
-			     int dvsec, u16 cap)
+			     int dvsec, u16 cap, bool mem_clr_en)
 {
 	int rc, rc2;
 
@@ -1283,7 +1286,7 @@ static int cxl_reset_execute(struct pci_dev *pdev, bool *target_prepared,
 
 	rc = cxl_pci_target_reset_prepare(pdev, target_prepared);
 	if (!rc)
-		rc = cxl_reset_initiate(pdev, dvsec);
+		rc = cxl_reset_initiate(pdev, dvsec, mem_clr_en);
 	if (!rc)
 		rc = cxl_reset_wait_done(pdev, dvsec, cap);
 
@@ -1322,7 +1325,8 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	scoped_guard(rwsem_write, &cxl_rwsem.region) {
 		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
 		if (!rc)
-			rc = cxl_reset_execute(pdev, &target_prepared, dvsec, cap);
+			rc = cxl_reset_execute(pdev, &target_prepared, dvsec,
+					       cap, false);
 		if (!rc) {
 			u16 command;
 
@@ -1340,3 +1344,58 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	cxl_pci_target_reset_done(pdev, &target_prepared);
 	return rc;
 }
+
+/* True when a function-scoped CXL reset is available for @pdev. */
+bool cxl_reset_capable(struct pci_dev *pdev)
+{
+	u16 cap;
+
+	if (cxl_reset_dvsec(pdev, &cap) < 0)
+		return false;
+
+	if (pdev->multifunction)
+		return false;
+
+	return cxl_reset_hdm_available(pdev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_reset_capable, "CXL");
+
+/*
+ * Run the DVSEC reset sequence and restore HDM state for a caller that owns
+ * device quiesce and PCI config save/restore, such as vfio-pci. The HDM range
+ * collection and CPU cache flush that cxl_reset_function() does for host-owned
+ * memory are skipped; that memory belongs to the guest here.
+ */
+int cxl_reset_dvsec_sequence(struct pci_dev *pdev, bool mem_clr_en)
+{
+	bool target_prepared = false;
+	int dvsec;
+	int rc;
+	u16 cap;
+
+	dvsec = cxl_reset_dvsec(pdev, &cap);
+	if (dvsec < 0)
+		return dvsec;
+
+	if (pdev->multifunction)
+		return -ENOTTY;
+
+	/*
+	 * Trylock rather than block: This follows the trylock convention of
+	 * pci_reset_bus().
+	 */
+	if (!pci_dev_trylock(pdev))
+		return -EBUSY;
+
+	scoped_guard(rwsem_write, &cxl_rwsem.region) {
+		rc = cxl_reset_execute(pdev, &target_prepared, dvsec, cap,
+				       mem_clr_en);
+		if (!rc)
+			rc = cxl_restore_hdm_after_pci_reset(pdev);
+	}
+
+	cxl_pci_target_reset_done(pdev, &target_prepared);
+	pci_dev_unlock(pdev);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_reset_dvsec_sequence, "CXL");
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index f8e8fddba152..541ed6de75a6 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -164,6 +164,8 @@ void pci_cxl_hdm_init(struct pci_dev *pdev);
 void pci_cxl_hdm_release(struct pci_dev *pdev);
 int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev);
 int cxl_reset_function(struct pci_dev *pdev, bool probe);
+bool cxl_reset_capable(struct pci_dev *pdev);
+int cxl_reset_dvsec_sequence(struct pci_dev *pdev, bool mem_clr_en);
 #else
 static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
 {
@@ -182,6 +184,16 @@ static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	return -ENOTTY;
 }
+
+static inline bool cxl_reset_capable(struct pci_dev *pdev)
+{
+	return false;
+}
+
+static inline int cxl_reset_dvsec_sequence(struct pci_dev *pdev, bool mem_clr_en)
+{
+	return -ENOTTY;
+}
 #endif
 
 struct cxl_reg_map {
-- 
2.25.1

