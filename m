Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C874A2E26;
	Tue,  5 May 2026 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002359; cv=fail; b=ihLv7BaZ6j7LLBzRQ7TOAbQzB2INHTg0YPWYMjPRUjTuwAKXIAoTXHqEAyDD7hFo8Q6JH7iJM3MUlJv6mjX2wQ4yTpmVLhJSyHTkxtpRNH87CWBc3oVt3G92LkJAysHORCcMJIl9uqAWeAJZUzhydIBEoIU8NmIiyjJZc5LhHWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002359; c=relaxed/simple;
	bh=X1WLqFZnLXWCTA5QbziIpq0uK+II08S6bJPqXuQxEtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/fQgsHVnakTUiTtQ7wEyWMPfF+X6Y2rxLmVniwlYfi1BD/IVBqAIT9KRQY/0jD6J9qiu2I79MQiqgHLorV0/Zy1QZjIQaMn/QyXT0UhgFh868N1Jcl3RxxfcbLjQt0J/jwbJ2siqwivp47WHDrCosznjNRZbrB2ZMaJJ3h0YLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k63gOZd2; arc=fail smtp.client-ip=52.101.52.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k63gOZd2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIZWlMTU0meEc+j17wmM95XogZnBBjxu6ByS56NgYw5UudxAo+/gUPEpuxc3GzEuD2PZxr9R7ppCybyNAJfe0tpP2duwejg7CPSg5wP7FPaKl5HbY2IsSx4DcsTqlDjlbO9KqTkJkKALzlPegzmEnuRhOVpsZ73S1Ji8dbNEtLBBomHFXREXGw1/IRIcvQDhnwLP7+fCXGzmyrqbMjIVRO/8535gmWW3j2mo2yzS/wVlmV6APGRo/048/oe5bnKvzLk2chG+nn6z6MdHGPXYjsIKtR4sdYF2bGTW6B9TYsC86uh0y3XZdaR4+4yt7IkTndsm9YFSP+pLddyvF6XIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nYYQN6d+0Q0cZAyA4MODE4msDbJeSABeXmFASW7jDI=;
 b=MHXTjgy2POr3Qo+Rey+jyIMXkap6li4CAx5AI1VOqnF9TVmuaABGZoSYcfiPxI/O8/SRGWOCntycvavBYMZBfpg4NjpKU1Zh6143uhawPuW8OR0I4oYG1QBQVZRhL1F8Y3+bI9rj1XN7nCS9xLzMjDNdM5WqWUsVxwgeeYTh/Xkl80b2AcWsD72JeEjPxb5lvj4CHJXUAw5x+qB7pyJwY7JVMa/BK9li4swslsgl5hlLAePAioq8KR/jXoKOQJb0sb35nBNIp1votUonz94y1NWhzF8q/oyql1Ot5di+DUU8vR538+XT6GtMAQc3kMb1iCjMfA8TapsiT252zvOuKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nYYQN6d+0Q0cZAyA4MODE4msDbJeSABeXmFASW7jDI=;
 b=k63gOZd2SHUz+HIu/2JcITbvkoPAJLh3hrCtNB7gAMiKB003nKCPzs35bu/bV+DoFH12feyTJp3P93sE0AnxFNWhEx3HT0kMTSI+un7On8qTSwVfXYCgmRVAhmMOlPQzYO1WTlBBzYJx1DMyiIVih1bNQcM0OKSVRFSUFQAc8B4=
Received: from CH0PR13CA0006.namprd13.prod.outlook.com (2603:10b6:610:b1::11)
 by IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 17:32:33 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::9) by CH0PR13CA0006.outlook.office365.com
 (2603:10b6:610:b1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.14 via Frontend Transport; Tue,
 5 May 2026 17:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 17:32:32 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 12:32:32 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <djbw@kernel.org>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <vishal.l.verma@intel.com>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <corbet@lwn.net>,
	<rafael@kernel.org>, <xueshuai@linux.alibaba.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v17 09/11] cxl: Update Endpoint AER uncorrectable handler
Date: Tue, 5 May 2026 12:30:27 -0500
Message-ID: <20260505173029.2718246-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505173029.2718246-1-terry.bowman@amd.com>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|IA1PR12MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d476ff-9ee3-46cf-bca5-08deaacc4a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700016|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	alRJNLyhcsdno9IO/q86/Yw/3WL52ONJjZTQBH45lFIEeDtrqR4JecFC4syzWfv3mQBQXaMjAyVnu2UjT4DW3HoIihqkFEJfx+FVGBuxY2MRMWGssEyiP72Zt/ToXzHBhmSm8qFMb39FLxx4SPcga1b3p37DgkTgI0oT7nmPQTl4f4LN1LXNssUgMKWHpV6zl0RllMQOnw3Xq/RqmttWv96+wfKgyh2qddRRUpBRcp9M9TUhwakGrijaimc5m0bZlH4BdoBllWeSx4mHmynGJpf1nySBx48sqqqGMmkiejBOviYyoYct4GqCMg7kN+hBIbSYTPEMt1EyzeRv38cGGKQkoQSuCs/gne9Hy7tmBD6lNu1fzMQiaQAOQKm1afOTWWMoFXar+Z0oTxF5iHWyrtG6xRtlsEe9K0IFoq2V7hVa6U1PEbmhjWKQ8f1E0UTcEb3djTrjjOPG8D9EorNtWeRbQVYEeYba9JHZVLjyri3iG+laN4sG38b+uspjmA0zt/NCGuHPhAQgSV8LqWLvckunLrc45bH5HakeaJVZZ9OqhgFSJ0P8E7wEi07qVD92tle4/WpFPdIGi5SjEFj6LQMM6lpc171uBOD5tB+EM6zMvlCJ4Z84AzArlOmwBBXro97E/gfVbItgYYBmuqogKglzp3G72zib41Pj+6Or473F7HYmAI1FrsfwoRDxQPp4XavoSGuY/3q6hWX8Kovh5DSr0qlxqSKu084IUudK1jhtqLTp1nWApSoOYi/nMuPqwUHBg2YiaFD9lkASb96zSw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	anyT7u9Da+OX4WTsEQAe8qhHvZtOT1OMXrs1mdySW8vZrbmAUpG0ufV1pEd8XEwDFZKsFLaEy09DgDhC+eWL1W6PDsdIskvKqDMJKh7+QUB53scqUHXMGAzK6E+65lVI9Oh3Hx6igy3hRgKbZhUqZF4eovAtLL/T9CmD/RSPvNnuqAifYkicL6ZTd9SrDdDw116XJqu/DNjH9qJmmjATk03jMvN40ElqV0SAERx0LWg3pRJPS9l4dFCHoWIfAz4dzgZr1mKHmPrYvkev16gg777Giftjw/YSHOLcuNpF2FZab46yWnJJxgrxnzlhijPhEP2l2qtxEHD0s0tfHDcA50S7Gp3KkOB3kGmd2gcqeQqm4lhMKsk1w+cDSXT4oG5D+cw628WgihN7F3eVz7qSD09E1O/cQHnHRo6HvKCH4CAAXCGjR6jPpzJ9SVgULzTU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:32:32.9466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d476ff-9ee3-46cf-bca5-08deaacc4a54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6356

The CXL cxl_core driver now implements protocol RAS support. PCI
uncorrectable (UCE) protocol errors, however, continue to be reported via
the AER capability and must still be handled by a PCI error recovery callback.
UCE handling is required to provide direction for recovery.

Replace the existing cxl_error_detected() callback in cxl/pci.c with a new
cxl_pci_error_detected() implementation that handles uncorrectable AER PCI
protocol errors.

The handler decides solely based on the pci_channel_state_t parameter and
does not access PCIe AER capability registers from .error_detected, matching
the pattern used by other drivers including the NVMe and ixgbe drivers.
CXL.cachemem-corrupting protocol errors are routed separately through the
AER-CXL kfifo to cxl_handle_proto_error(), so cxl_pci does not need to
second-guess the AER core's classification.

claude-opus-4.7 was used for research on PCI error state transitions and
requirements.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v16->v17:
- Rename pci_error_handlers struct instance to cxl_pci_error_handlers to
  avoid shadowing the struct type tag.
- Restore scoped_guard(device) and dev->driver check around AER read.
- NULL-check find_cxl_port_by_dev() before deref of port->uport_dev.
- Updated commit message. (Terry)
- Add scope cleanup for port variable in cxl_pci_error_detected() (Terry)
- Drop cxl_uncor_aer_present(), rely on AER state

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
 drivers/cxl/core/ras.c | 43 ++++++++++++++++--------------------------
 drivers/cxl/cxlpci.h   |  8 ++++----
 drivers/cxl/pci.c      |  6 +++---
 3 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 5cc4087c2807..a98ce0f412ad 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -253,38 +253,27 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 	return true;
 }
 
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
+pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+					pci_channel_state_t state)
 {
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlmd->dev;
-	bool ue;
+	struct cxl_dport *dport;
+	struct cxl_port *port __free(put_cxl_port) =
+		find_cxl_port_by_dev(&pdev->dev, &dport);
+	struct cxl_memdev *cxlmd;
+	struct device *dev;
 
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return PCI_ERS_RESULT_DISCONNECT;
-		}
+	if (!port)
+		return PCI_ERS_RESULT_DISCONNECT;
 
-		/*
-		 * A frozen channel indicates an impending reset which is fatal to
-		 * CXL.mem operation, and will likely crash the system. On the off
-		 * chance the situation is recoverable dump the status of the RAS
-		 * capability registers and bounce the active state of the memdev.
-		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
-				    cxlmd->endpoint->regs.ras);
-	}
+	cxlmd = to_cxl_memdev(port->uport_dev);
+	dev = &cxlmd->dev;
 
 	switch (state) {
 	case pci_channel_io_normal:
-		if (ue) {
-			device_release_driver(dev);
-			return PCI_ERS_RESULT_NEED_RESET;
-		}
+		/*
+		 * Non-fatal CXL protocol errors are handled asynchronously
+		 * by the AER-CXL kfifo worker (cxl_proto_err_work_fn).
+		 */
 		return PCI_ERS_RESULT_CAN_RECOVER;
 	case pci_channel_io_frozen:
 		dev_warn(&pdev->dev,
@@ -299,7 +288,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	}
 	return PCI_ERS_RESULT_NEED_RESET;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_pci_error_detected, "CXL");
 
 static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
 				   struct cxl_dport *dport, int severity)
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 06c46adcf0f6..8aeb80a4e573 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -89,13 +89,13 @@ struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_RAS
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state);
+pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+					pci_channel_state_t state);
 void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
 void devm_cxl_port_ras_setup(struct cxl_port *port);
 #else
-static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-						  pci_channel_state_t state)
+static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+						      pci_channel_state_t state)
 {
 	return PCI_ERS_RESULT_NONE;
 }
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5eb64ced0de5..6459f94f8fa8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1000,8 +1000,8 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
-static const struct pci_error_handlers cxl_error_handlers = {
-	.error_detected	= cxl_error_detected,
+static const struct pci_error_handlers cxl_pci_error_handlers = {
+	.error_detected	= cxl_pci_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
 	.reset_done	= cxl_reset_done,
@@ -1011,7 +1011,7 @@ static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
-	.err_handler		= &cxl_error_handlers,
+	.err_handler		= &cxl_pci_error_handlers,
 	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.34.1

