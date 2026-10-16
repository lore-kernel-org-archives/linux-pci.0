Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A727F5172EB;
	Fri, 16 Oct 2026 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167624; cv=fail; b=obHwCgPCQx1k+sa0ed2ouvj4BhpM9/X7gn62bYZDEA8fpdOPy+5wO4O93WoajqAgM+ZP/Q9oCUbeDyTbeVYvaLXv6vkjWwq9pkDfi5YUSxiH5yGD2gIV7TWPqjidutsYOAfEitsdPHbZ/h8+I5zeU9PWmgLo3Hg7BnG/k4iGih4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167624; c=relaxed/simple;
	bh=8QhyH9Jcjjt9ujwr5O6h7SZdxK5Ffn0sTE8sbDtEhTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m69tmPnLEMeiMW1rVJgND4UcCCpT3i1o0coxTMCsRwo+mjdn3xYc1Ng8eCGTFahYx4bTD6e1XWFVtV/B/aE1pmZuhIiwODlqcA0ByaxhfU9yRGWpBv5soIPZsIx1CaiYmG36Ta7HhIuF+s950TlT8+GLRezi3MNgs5AhrsjJ+R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=trsrvFvZ; arc=fail smtp.client-ip=52.101.85.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="trsrvFvZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBpi1L21OQkd3AjyGPKafWEerjFlwDjgiN3Z0CPlm2SUZ58jK+rl3PdTxl5pHpix/X2RXWC6lsnLKrRSoaOISTDKfnMgerO7PbeNM8qO/p+9nxYPJknWt3fhaSzM9uCttYH7Q9PA+rCPKZDSkTSSOLFoEJYK3Rs0PIrvzDtOx6ooMuRHu7xtZ1CtdtEvHAX8l8Y672sYd2kRr/DNXVXK2AGipefuJdil6uJkHrxPIOWZVSUcdlXsq5IA89sszc54pKdu/fUz2FC3IaObYHv0vJbveN+FTape0h83atjBkQYArJ5ar2gnzN3EzULzqBCu3cKLF8U7E1Ny7WbIYK6rJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pqwj7rutqEAKzmmRhmHaeiTk0Wr+mOa+A8BVtvmtaG8=;
 b=OOoGppRx8jzlTRlh8xV3AvbfULNSXpDX2q71biyXzwIHRrZHerHQb3Yt/i2LfJqJowRQSLM9SAbMkPJKlFXORtKhKPEYc+jtZIBT9OAu6wGOvG2H8asVj5RF/I8K5FE2hr4UA81Q0ja0CbDKtryEQv4zKUKkCbpqpls3qjb3SgfgbnAUSgO1ZBsFHLATPKtNy5KUE9q9fPpG3Gu+sE9NVxsh0y7+CPhpJvtQChcXWyUm6CL/n/yrP2BPAzi6jy2gVd5Nouyyy/oJv0ZQj2sFQ1h4f0rjZOWs152oX5skxbXv83NJPF79EgHJsSZq5azvWarxghuDoGkIeVA2tp4Q4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pqwj7rutqEAKzmmRhmHaeiTk0Wr+mOa+A8BVtvmtaG8=;
 b=trsrvFvZBQrv0QAEIp0qD9QUT3rhZtEpV29U3TJTyQlRz1N78RCLthabUQnMiWL/K7xSLx62BADHxDw4G9NJge7F8Ka1DmlsrQ7zY5dlWHUy5usqljGtiexM0jAPD6Zo7NkkKLIPiDPEHcoRfBf02N4ZMwvKdajkA6QeUyQcUhoVJLZmKQhYuUNgx1y1CnSk/fn6pDAEWG3XOLKzIIjj6XFvLAMljdUU6XLUGMCxnPAWHpp8sHsZYN22yO09ATgLL53Uyhk+47l8NUy6kwdHDou2C8hETmrAKlkULnc3c/QK1wloOc8Qu2+UBQFCuGoMF1cXg406lTjQARxQ14jObw==
Received: from CH5P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::27)
 by AT6PR12MB026081.namprd12.prod.outlook.com (2603:10b6:170:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 16:20:07 +0000
Received: from BN7PEPF000000A7.namprd05.prod.outlook.com
 (2603:10b6:610:1ee:cafe::56) by CH5P222CA0006.outlook.office365.com
 (2603:10b6:610:1ee::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Fri,
 16 Oct 2026 16:20:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF000000A7.mail.protection.outlook.com (10.167.245.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:20:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:19:40 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:19:31 -0700
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
Subject: [PATCH v6 04/31] PCI/CXL: Let the driver that owns the HDM range run CXL Reset
Date: Fri, 16 Oct 2026 21:48:11 +0530
Message-ID: <20261016161839.2765592-5-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016161839.2765592-1-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A7:EE_|AT6PR12MB026081:EE_
X-MS-Office365-Filtering-Correlation-Id: ea77363f-65c6-4464-b284-08df2ba157cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|7416014|36860700016|1800799024|6133799003|22082099003|18002099003|10067099003|921020|261009223027099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	oV6yBP0RZXHPDG4k3q6QXKEbtXX0lv7Lv8m6cR6ph9GNtUEzTsukqXftxbqg65dHuwIdCt0aGP+pE/EwvVUIOLKTw2+iSnqajeIO8IuFZQm6HCCcmAm3TAFL9nQWTRp8aFdOdbIiyjEEASZC+blGvqcXpSju61Mwm0fy0tz+ab2OlSNOVzmQ1WgD0AVLcj/iHkrPAn4DLwDGxuirFKg69SdQeHSe1D5b+jmOZ3CTfouD5ZHgheVfcRi/h9kg1nCUQrWjSD56ruExx89d6KKaQTqi4yfNI54/uOqyjpnfBkIHRRAHPgcYoKkeir/7pvk0hIEptVRb6j/eDO2FlGOipkmWL9HPIalTbhDF9VYucAp/Q1PDl7xz3i3h9fUo2HDj33ach/gunNi2UoXiq4B3MkCCVqwo4guSU8G2sereHj/3yLyHaUpnTqy7FsJLZjhtmdDLYvWsGguh4jbmySKvlkPF6yxlegZ8SagXxO0N0P3RsyUXYzgOT5TMzrtjDlZVb8FuhS/XLazTdb7BV4zdWcVLv02qu5D2PK3qMYW5XtfVunuD8WlWz5EyiYbP5GJFGs9tZN9hlhUZ73O6ear77ThzmMKKwMxWXwCepuandPeAvo4lKfORMHCC5LY7pivl4gjEazpXk/M/VeiJw2FToJjaCnYbBgKiX8L7AKvEpuPsm0qgthodSyk8EeteALoRoO+q4aHcRRQkOTPEOdIKkebEPI6PxVFTCtWEzapt3CslfSpl0JtJ/CAw3saPGlcQ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(7416014)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(261009223027099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	noSjxSJt/MoL2BWlnykxtNFf6qRX9b+HtBNFIjDxSHWE7ATJ5bJX6QrhxXS9+uySsbaoCc4Fw4roAHQskGNn8H7nkSHnXNfDw5X3yoYAP0kvXmfZFRIoy/hkktYzs3BmAlWXHFFW5ewALEil+8q6U37wrh2fDOUTlOLYTnmEBbeUty16PCvrkBIh4e65qC0bTc+LcCKJEAgn1eTWQOG2jfvVKbCHFfto/QxW79u0jIJXiLV9oiAZwCRpcabpn0UPGak7KZ2rFUckUR4m2tr0CKXI3mZAJjh/sabfa3hy63s1gX+llk/apPysfLRiG7MfSB5b/AM1reoOBLv3m2YmgnRYWISqMup7/tyflptnY5ncJqncal80sp8+Bfqi3bP2phXzGzkEZjmI+tMkUIQFUtfWr9k04MwaxvhpRfJuitrLB4rtue5eel8E48ubLSd6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:20:07.0682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea77363f-65c6-4464-b284-08df2ba157cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB026081

From: Manish Honap <mhonap@nvidia.com>

vfio-cxl passes a CXL Type-2 device to a guest and must run CXL Reset at
the vfio reset points. The cxl_reset PCI reset method does not fit that
caller:

- It requests every HPA range the device decodes. vfio-cxl holds that
  range with request_mem_region_exclusive() while it exposes the memory,
  so the request fails with -EBUSY.
- When the reset cannot run, the method returns -ENOTTY and the PCI core
  moves on to the next method. That is FLR, which leaves device memory
  intact for the next user.
- The snapshot and restore helpers that vfio-cxl needs after a bus reset
  and on return from low power are not exported.

Let cxl_hdm_quiesce_prepare() take the resource the caller already holds
and skip the request for ranges inside it. pci_cxl_reset_owned() accepts
only a resource marked busy and exclusive, as
request_mem_region_exclusive() leaves it. The CPU caches are still
written back and invalidated for every range before and after the reset,
as the reset method does.

Add:
- pci_cxl_reset_owned(): runs the reset method's sequence for a caller that
  holds the device lock and returns any failure to that caller

- pci_cxl_reset_capable(): checks the cached HDM state and the CPU cache
  invalidation that the reset-method probe skips.

- pci_cxl_hdm_snapshot(): copies the HDM state cached at enumeration
  without requiring the device lock. A driver needs this copy in probe,
  which the PCI core may run in a worker on the device's NUMA node, where
  device_lock_assert() would warn although the binding task holds the
  lock. pci_cxl_reset_prepare() becomes that copy plus the lock assertion.

Export:
- pci_cxl_reset_owned()
- pci_cxl_reset_capable()
- pci_cxl_hdm_snapshot()
- cxl_restore_state_after_pci_reset()

to the vfio-cxl module only, and declare them in include/cxl/pci.h.

CXL Reset always clears memory, so there is no caller Memory Clear choice.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/hdm_state.c |  22 ++++--
 drivers/pci/cxl.c            | 136 ++++++++++++++++++++++++++++-------
 drivers/pci/pci.h            |  18 +----
 include/cxl/hdm.h            |   3 +-
 include/cxl/pci.h            |  39 ++++++++++
 5 files changed, 171 insertions(+), 47 deletions(-)

diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
index 95daeda0ef80..9452047e3b97 100644
--- a/drivers/cxl/core/hdm_state.c
+++ b/drivers/cxl/core/hdm_state.c
@@ -267,7 +267,8 @@ static int cxl_hdm_ranges_collect(struct cxl_hdm_quiesce *q, struct device *dev,
 	return 0;
 }
 
-static int cxl_hdm_ranges_request(struct cxl_hdm_quiesce *q)
+static int cxl_hdm_ranges_request(struct cxl_hdm_quiesce *q,
+				  const struct resource *owned)
 {
 	struct cxl_hdm_range *range;
 
@@ -275,6 +276,12 @@ static int cxl_hdm_ranges_request(struct cxl_hdm_quiesce *q)
 
 	list_for_each_entry(range, &q->ranges, list) {
 		const struct range *hpa_range = &range->hpa_range;
+		struct resource res = DEFINE_RES_MEM(hpa_range->start,
+						     range->len);
+
+		/* The caller already holds this range exclusively. */
+		if (owned && resource_contains(owned, &res))
+			continue;
 
 		range->res = request_mem_region(hpa_range->start, range->len,
 						"cxl_reset");
@@ -316,15 +323,20 @@ static int cxl_hdm_ranges_invalidate(struct cxl_hdm_quiesce *q)
  * @dev: device for error messages
  * @q: quiesce state to initialize
  * @snapshot: HDM state from cxl_hdm_cache_snapshot()
+ * @owned: resource the caller holds exclusively over the ranges, or NULL
  *
  * Reserve every enabled system-physical range in @snapshot exclusively, then
- * write back and invalidate CPU caches for them. Call
- * cxl_hdm_quiesce_destroy() afterwards whether or not this succeeds.
+ * write back and invalidate CPU caches for them. A range inside @owned is
+ * not requested again; the caller's reservation already excludes other
+ * users.
+ *
+ * Call cxl_hdm_quiesce_destroy() afterwards whether or not this succeeds.
  *
  * Return: 0 on success, or a negative errno.
  */
 int cxl_hdm_quiesce_prepare(struct device *dev, struct cxl_hdm_quiesce *q,
-			    const struct cxl_hdm_info *snapshot)
+			    const struct cxl_hdm_info *snapshot,
+			    const struct resource *owned)
 {
 	int rc;
 
@@ -340,7 +352,7 @@ int cxl_hdm_quiesce_prepare(struct device *dev, struct cxl_hdm_quiesce *q,
 	if (rc)
 		return rc;
 
-	rc = cxl_hdm_ranges_request(q);
+	rc = cxl_hdm_ranges_request(q, owned);
 	if (rc)
 		return rc;
 
diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index ed0b6f619c70..b4d467506c54 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -372,9 +372,32 @@ static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
 	return rc;
 }
 
+/**
+ * pci_cxl_hdm_snapshot() - copy the HDM state cached at enumeration
+ * @pdev: CXL device
+ *
+ * The cache is read under cxl_rwsem.dpa, so the caller needs no device
+ * lock. A driver can call this from probe, which the PCI core may run in a
+ * worker on the device's NUMA node while the binding task holds the lock.
+ *
+ * Return: a copy to free with kfree(); NULL when @pdev has no cached HDM
+ * state; or an ERR_PTR() on failure.
+ */
+struct cxl_hdm_info *pci_cxl_hdm_snapshot(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *snapshot;
+
+	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
+	if (IS_ERR(snapshot) && PTR_ERR(snapshot) == -ENXIO)
+		return NULL;
+
+	return snapshot;
+}
+EXPORT_SYMBOL_FOR_MODULES(pci_cxl_hdm_snapshot, "vfio-cxl");
+
 /**
  * pci_cxl_reset_prepare() - allocate HDM state storage ahead of a bus reset
- * @pdev: device about to be reset
+ * @pdev: device about to be reset, with its device lock held
  *
  * Copy the cached HDM state before the reset, so that restoring cannot fail
  * for lack of memory. The decoder settings are refreshed when the state is
@@ -386,14 +409,8 @@ static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
  */
 struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
 {
-	struct cxl_hdm_info *snapshot;
-
 	device_lock_assert(&pdev->dev);
-	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
-	if (IS_ERR(snapshot) && PTR_ERR(snapshot) == -ENXIO)
-		return NULL;
-
-	return snapshot;
+	return pci_cxl_hdm_snapshot(pdev);
 }
 
 /**
@@ -433,6 +450,7 @@ int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
 	cxl_region_quiesce_unlock();
 	return rc;
 }
+EXPORT_SYMBOL_FOR_MODULES(cxl_restore_state_after_pci_reset, "vfio-cxl");
 
 /*
  * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
@@ -642,7 +660,8 @@ static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
 	return rc;
 }
 
-static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
+static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap,
+			      const struct resource *owned)
 	__must_hold(cxl_region_quiesce)
 {
 	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
@@ -663,7 +682,7 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
 		return PTR_ERR(snapshot);
 	}
 
-	rc = cxl_hdm_quiesce_prepare(&pdev->dev, &q, snapshot);
+	rc = cxl_hdm_quiesce_prepare(&pdev->dev, &q, snapshot, owned);
 	if (rc) {
 		cxl_hdm_quiesce_destroy(&q);
 		return rc;
@@ -686,32 +705,40 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
 	return cxl_reset_save_restored_state(pdev, command);
 }
 
-static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
+			     const struct resource *owned)
 {
 	int rc;
 
+	/* Raw reset callers may not have saved the PCI state needed for restore. */
+	if (!pdev->state_saved) {
+		pci_err(pdev, "CXL reset requires saved PCI state\n");
+		return -EINVAL;
+	}
+
 	cxl_region_quiesce_lock();
-	rc = cxl_reset_quiesced(pdev, dvsec, cap);
+	rc = cxl_reset_quiesced(pdev, dvsec, cap, owned);
 	cxl_region_quiesce_unlock();
 
 	return rc;
 }
 
-int cxl_reset_function(struct pci_dev *pdev, bool probe)
+static int cxl_reset_check(struct pci_dev *pdev, bool probe, u16 *dvsec,
+			   u16 *cap)
 {
-	u16 dvsec, cap, ctrl;
+	u16 ctrl;
 	int rc;
 
-	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
+	rc = cxl_pci_device_dvsec(pdev, dvsec, cap);
 	if (rc)
 		return probe ? -ENOTTY : rc;
-	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
-	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
-	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
-	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
+	if (!(*cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
+	    !(*cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
+	    !(*cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
+	    !(*cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
 		return -ENOTTY;
 
-	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
+	rc = pci_read_config_word(pdev, *dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
 	if (rc)
 		return probe ? -ENOTTY : pcibios_err_to_errno(rc);
 	if (PCI_POSSIBLE_ERROR(ctrl))
@@ -737,11 +764,70 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (!cpu_cache_has_invalidate_memregion())
 		return -ENOTTY;
 
-	/* Raw reset callers may not have saved the PCI state needed for restore. */
-	if (!pdev->state_saved) {
-		pci_err(pdev, "CXL reset requires saved PCI state\n");
+	return 0;
+}
+
+int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	u16 dvsec, cap;
+	int rc;
+
+	rc = cxl_reset_check(pdev, probe, &dvsec, &cap);
+	if (rc || probe)
+		return rc;
+
+	return cxl_reset_execute(pdev, dvsec, cap, NULL);
+}
+
+/**
+ * pci_cxl_reset_capable() - check whether CXL Reset can run on a device now
+ * @pdev: CXL device
+ *
+ * Unlike the reset-method probe, this also checks the cached HDM state and
+ * the CPU cache invalidation that the reset needs.
+ *
+ * Return: true when pci_cxl_reset_owned() can attempt the reset.
+ */
+bool pci_cxl_reset_capable(struct pci_dev *pdev)
+{
+	u16 dvsec, cap;
+
+	return !cxl_reset_check(pdev, false, &dvsec, &cap);
+}
+EXPORT_SYMBOL_FOR_MODULES(pci_cxl_reset_capable, "vfio-cxl");
+
+/**
+ * pci_cxl_reset_owned() - CXL Reset for the driver that owns the HDM range
+ * @pdev: CXL device, with its device lock held and PCI state saved
+ * @owned: resource the caller reserved over the device's HPA range with
+ *	   request_mem_region_exclusive(), or NULL
+ *
+ * Run the same sequence as the cxl_reset method. Ranges inside @owned are not
+ * requested again, so a driver that keeps the HPA range reserved while it
+ * exposes the memory can reset the device. The CPU caches are still
+ * invalidated for every range before and after the reset.
+ *
+ * Return: 0 on success, or a negative errno. Unlike the reset method, a
+ * device that cannot be reset returns an error to the caller instead of
+ * falling through to another reset method. -EINVAL if @owned is not a busy,
+ * exclusive reservation.
+ */
+int pci_cxl_reset_owned(struct pci_dev *pdev, const struct resource *owned)
+{
+	const unsigned long held = IORESOURCE_BUSY | IORESOURCE_EXCLUSIVE;
+	u16 dvsec, cap;
+	int rc;
+
+	device_lock_assert(&pdev->dev);
+
+	/* Only a busy, exclusive reservation keeps other users off the range. */
+	if (owned && WARN_ON_ONCE((owned->flags & held) != held))
 		return -EINVAL;
-	}
 
-	return cxl_reset_execute(pdev, dvsec, cap);
+	rc = cxl_reset_check(pdev, false, &dvsec, &cap);
+	if (rc)
+		return rc;
+
+	return cxl_reset_execute(pdev, dvsec, cap, owned);
 }
+EXPORT_SYMBOL_FOR_MODULES(pci_cxl_reset_owned, "vfio-cxl");
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 476e8eefafb2..b1fa4ec7ae75 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -730,14 +730,12 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
 static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
-struct cxl_hdm_info;
+#include <cxl/pci.h>
+
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
 void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
 int cxl_reset_function(struct pci_dev *pdev, bool probe);
-struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev);
-int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
-				      struct cxl_hdm_info *snapshot);
 #else
 static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
 static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
@@ -745,18 +743,6 @@ static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	return -ENOTTY;
 }
-
-static inline struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
-{
-	return NULL;
-}
-
-static inline int
-cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
-				  struct cxl_hdm_info *snapshot)
-{
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_PCI_NPEM
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index 02cad2d74329..fa3b5845a33c 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -96,7 +96,8 @@ struct cxl_hdm_quiesce {
 void cxl_region_quiesce_lock(void);
 void cxl_region_quiesce_unlock(void);
 int cxl_hdm_quiesce_prepare(struct device *dev, struct cxl_hdm_quiesce *q,
-			    const struct cxl_hdm_info *snapshot)
+			    const struct cxl_hdm_info *snapshot,
+			    const struct resource *owned)
 	__must_hold(cxl_region_quiesce);
 int cxl_hdm_quiesce_flush(struct cxl_hdm_quiesce *q)
 	__must_hold(cxl_region_quiesce);
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index 0b74819fea6d..64efecb44c1f 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -4,6 +4,7 @@
 #ifndef __CXL_CXL_PCI_H__
 #define __CXL_CXL_PCI_H__
 
+#include <linux/errno.h>
 #include <linux/types.h>
 
 /* Register Block Identifier (RBI) */
@@ -27,6 +28,44 @@ int cxl_reg_map_set_owned_resource(struct cxl_register_map *map,
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 int cxl_setup_regs(struct cxl_register_map *map);
+
+struct cxl_hdm_info;
+#ifdef CONFIG_CXL_RESET
+struct cxl_hdm_info *pci_cxl_hdm_snapshot(struct pci_dev *pdev);
+struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev);
+int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
+				      struct cxl_hdm_info *snapshot);
+bool pci_cxl_reset_capable(struct pci_dev *pdev);
+int pci_cxl_reset_owned(struct pci_dev *pdev, const struct resource *owned);
+#else
+static inline struct cxl_hdm_info *pci_cxl_hdm_snapshot(struct pci_dev *pdev)
+{
+	return NULL;
+}
+
+static inline struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
+{
+	return NULL;
+}
+
+static inline int
+cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
+				  struct cxl_hdm_info *snapshot)
+{
+	return 0;
+}
+
+static inline bool pci_cxl_reset_capable(struct pci_dev *pdev)
+{
+	return false;
+}
+
+static inline int pci_cxl_reset_owned(struct pci_dev *pdev,
+				      const struct resource *owned)
+{
+	return -ENOTTY;
+}
+#endif
 /*
  * CXL r4.0 sec 8.1.3.1: a CXL.mem capable device reports one or two HDM
  * ranges. 00b is illegal when Mem_Capable is set and 11b is reserved.
-- 
2.53.0

