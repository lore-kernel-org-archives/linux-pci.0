Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5F4DA9AD;
	Wed, 16 Sep 2026 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584018; cv=fail; b=K6jj08KJ6Wa34bTEmprSUhBTQBqcSBJ+7RW4sey/UxW2C90VEzi9vNaWronP56ACHhyZlQv/UJdFn7GgMlrv3H+awu9K1BYPgpsakewECxAiOxVL2BM2jU6Df3j+Z0ZCG22eJdLXiyJTDEl1WodBBMa/EnHOtb9L9NFoN/UVDf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584018; c=relaxed/simple;
	bh=WRH0kzzfyuLsciNtwByzNE7iMGTYk1vUbJarGVRmF2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jed7Ygw7M1F5TgAf3J5o4wpe9TBhUSYiaaOmk8ytpJacJZb2EwDbyATrlC36X7bC4+aiFC5Q+DCnTchZo0g9EzKuLF8UqrCJD+ofOlov+mlBRsKtZQPyhDQL9V+vaKg++IsknR6rT0s7crN1ViiL4+rYPTBDCPf30LBcyiOhYPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S8qJuVWa; arc=fail smtp.client-ip=52.101.43.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S8qJuVWa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fP/rD0c2/zoURCvx7ZiBA7kYxa082Fz+fj64yIDb3+iRezdpY2tNTFMpt3Vc+WfWTQrQUxnCzbH3K9Lj1YEXx+EtcqticH/Oh/53bgAgL46Fsgpi2iV+eeDfHgqC3/0Q7dB4VZBLw2XJfm1M5ZHuz2YsmPALbdUx/HX3XdBTZYNN2njWOvdm0o969JTl2tau1SIvhvABwfTlEEUjJeCLKes2npJWKGEiDAS+wk6IU9l32QrtDlOzMNNiamZepsIaAW872CkrJzNaDdKwq4pXa8qF4wrx1+PAsItv1trZ9CqSJD8rdckMRQSapU3qx+ssR+Y2LtBoaZ9nCp2nug0dRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UN45E6cy3y0MHWat+jNEXnZKy+YJeXOaOpv3Od0cQQM=;
 b=BzjQjlMEyMi8+8ZX2D8CmA5v83xbgNsgzoikqUoaPtjYVuDh/mnPT868nLZDIaKCmEy5rWb/KyYHnWeUXFVO2yJegCccZAuN0xSdBH3PERJ77zJn6SpKVNS25VtHfHkTaSk9Do4u9NUfED/mkUoAMMTK2k08JGQh7+pPqRivLxnHuom+LmSldOrPelN17M0knQQ7STPgHgV678NohUwf+Rl25oiJ/NGH6gH4sbLlUkWSyTZgofn0QyIKFU135NL2J6toKM/cVSCN2E3JmUd1CqTIYLPiVsFg8F3TjFbRkPhttmwa6iBdmicXzmriC8xjNmbX+/Uy9hV3Z9GfHR4wIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN45E6cy3y0MHWat+jNEXnZKy+YJeXOaOpv3Od0cQQM=;
 b=S8qJuVWaDuvF6KTYgvaPu8mH/B4pPoQxWsEoGeq7gN4hPl5k+F8pem03YKulw9h2qWpey0Bn7szdlVqpLRT4B8zITPyfcWVH9Z11IU8Zbo4dmbXUg3Oe+kMDOpGKEjtwytVcuOgzT1E+KfOOsplLpYx4eyRJyLez03Hmk0JsxDAeFnNB8SH/WczcbLzYy7m4YBuGXencjGfBjLO3EugF7BWYzJ0gWdtUm3l3pDQkvniX5nKQwWBTQ9zjGaFKr4OZtG00ylcNVZvpQtO/x1JXNXU7ZB3vDxF4ThUWg07MDDyVopV9WBFb/ifQusBRe/eeppXwDB8wRr++qYUQMGIv8A==
Received: from SA9PR13CA0029.namprd13.prod.outlook.com (2603:10b6:806:21::34)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:39:58 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::1f) by SA9PR13CA0029.outlook.office365.com
 (2603:10b6:806:21::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Wed, 16
 Sep 2026 18:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:39:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:39:30 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:39:21 -0700
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
Subject: [PATCH v5 22/27] vfio/cxl: Clear the HDM access gate after a hot reset
Date: Thu, 17 Sep 2026 00:05:35 +0530
Message-ID: <20260916183540.3813685-23-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916183540.3813685-1-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4782d1-3595-4071-07f0-08df1421e8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|7416014|1800799024|376014|921020|5023799004|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	izt0ocP+xV0U/ZINvV20Um73bQneE797OjPy5AwIb0a605FD6tDT38/XwU+ba1x65I2ezqB2G5doG5diYN5W+0vtyrc9z4xWHK3iCbYpdAKjfvFDnlaWaZrKJvI+Lc107U7cnFrey7eDnu9XnCv+BQre6dfsJRkmQNx/faFIZTizgRMMAPAZ6ruaQWi8/zsj6Qwy5jZlaDlM863wy8NS2c2yvLAzt9i2vYgLvisiEMYxvAgGfrAns9Prfqgo/+yLlmphz8jFKcRH4P18DQUbn+OUWQPCbGtk67OtuaPZG9bP6b0Mi6AH0wx1bdtMwbOJ1VILevyxKnmsTsZ+MKZspxx+LMCOW0dTf9RvRkQIuRi5vkjzErsP/WQvO80Zq00W3YI1EOXBiFMSOOckMLHxULtDtx6TDwo9iTX1t8UXZn3kxp38ptKp7ExjnaAto6jSA+st2fn9XG5eycRKhV0pl3Eiqdti3nbZq1C6BX1mKqZoKCdCMQDoqSSgS731W655Kt+Fm16CwtyKylH9decfb59ieZBwLZHO175dKXrVg/Y4FbZZJZIwfbKixIY4+AsTti6WZ5nIz9QcKkyNLkpGDs/JfDDDoBHNMwTN8EyRzsH3+eCcJ9oaAcO7Gqmf0lJGQRt1brcfQIoqpe4ufIzHsdvzY0DsMhPBqb5CK1XuCmcCTfFrP5DA4r9FaPPg8DdWnoO0wDXiVfng42Ln1e+ltZTCFKs7ox3P066nL97FsDMIEGdSa7M4X1YG9MeDAAxB
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(7416014)(1800799024)(376014)(921020)(5023799004)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ymq6Ru1dMaWZLI7baZskdlwDpYcW5+Ow45kZyGNxZxWRTvPQgn7lEzf8rdSC+MW19BmB3iQ8He5cALSGvkkDAeB1l3btK9UP9GJzgPwDZyJ3hi5O9zYfXTvPPBXyO7KfAH2qu7ATLRGN37C2d66ltWiOvQfmzfOLcT6dCdgtW/rBHyTisAXdYcjxD9tzPR7zYVtX4VjrXKas2MKgJMA+8+tBI4antaF36qgSeNkskT9A3N4pRcsDcQGCh9UQZOY+M24rDbd5SQiVuYdQ/NuZ5TQldyi2RMN4sZ2JycOMjAGeEZjRxl5+InrB3Z9sxF6286KJ7RgLaQUDAlN3gy6E2+4p14SqFYxN+uZXPC5hTjhkH/YOv10kck9xHJLLN5WRO8WT5OrWrLDIvvvScc5JZeFBICoy8noh31gINwoLnpg0zLxMlzd9xL5Ec3woowJK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:39:58.2685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4782d1-3595-4071-07f0-08df1421e8ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385

From: Manish Honap <mhonap@nvidia.com>

The HDM memory fault inserts a PFN only when the decoder is in a
known-good state (cxl->hdm_valid), so the host CPU never faults the
coherent range into a disabled decoder.

VFIO_DEVICE_PCI_HOT_RESET drives a plain secondary bus reset rather than
the CXL reset sequence, so nothing restores the decoder in the
reset_done handler. A secondary bus reset only reaches a CXL endpoint
when the upstream port has SBR unmasked (CXL r3.1 sec 8.1.5.2); in that
case the reset decommits the decoder, so clear cxl->hdm_valid to keep a
later fault from inserting a PFN into a dead decoder.

A subsequent VFIO_DEVICE_RESET runs the CXL reset sequence and restores
it, and a masked SBR is a no-op that leaves the decoder intact.

vfio_cxl_sbr_unmasked() mirrors the cxl_sbr_masked() check the PCI core
uses (drivers/pci/pci.c) for its own CXL bus reset.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 38 ++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 37e8a3b54cfb..395b4a5b0956 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -514,8 +514,46 @@ static void vfio_cxl_reset_prepare(struct vfio_pci_core_device *vdev)
 {
 }
 
+/*
+ * A secondary bus reset only reaches a CXL endpoint when the upstream port
+ * has SBR unmasked (CXL r3.1 sec 8.1.5.2); otherwise the Bridge Control SBR
+ * bit is ignored and the decoder is left intact. Mirrors the cxl_sbr_masked()
+ * check the PCI core uses for its own CXL bus reset.
+ */
+static bool vfio_cxl_sbr_unmasked(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge = pci_upstream_bridge(pdev);
+	u16 dvsec, ctl;
+
+	if (!bridge)
+		return false;
+
+	dvsec = pci_find_dvsec_capability(bridge, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_PORT);
+	if (!dvsec)
+		return false;
+
+	if (pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &ctl))
+		return false;
+
+	return ctl & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
+}
+
 static void vfio_cxl_reset_done(struct vfio_pci_core_device *vdev)
 {
+	struct vfio_cxl_state *cxl = vdev->cxl;
+
+	/*
+	 * VFIO_DEVICE_PCI_HOT_RESET drives a plain secondary bus reset, not the
+	 * CXL-aware cxl_reset_bus_function(), so nothing restores the HDM
+	 * decoder here. When the upstream port has SBR unmasked the reset
+	 * decommits the decoder; gate host access to the HDM range so a later
+	 * fault cannot insert a PFN into a dead decoder. A VFIO_DEVICE_RESET
+	 * then runs the CXL reset sequence and restores it. A masked SBR is a
+	 * no-op and leaves the decoder intact.
+	 */
+	if (vfio_cxl_sbr_unmasked(vdev->pdev))
+		cxl->hdm_valid = false;
 }
 
 static const struct vfio_cxl_ops vfio_cxl_ops = {
-- 
2.25.1

