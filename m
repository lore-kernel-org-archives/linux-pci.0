Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A4433E75;
	Thu, 13 Aug 2026 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613887; cv=fail; b=ojTk0tuOCb6Al59DGgaS5CXGLhSygQmk901L0d7Sp65pfy/Ri1qif/r5TgODlaEs8S2Cwft3dGrebnpWPaoHRdg30tvC/RtYlWf5MZjn5xSzMHNIW/cZBAOoNzI8Pn0pJ4V8nbhdmF9K8IJ0cyyf+L0Amr8oDj4/QRzaH0UX1iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613887; c=relaxed/simple;
	bh=nhnz4m+yMTnxXGJhNNvxUMssStE1tuLVRrvrzEKVVH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbD3vHb0LTYDsP9kMsP9RxHehSNS6VBnjTTwJ+Ad+ICh894wlHKHTQ/1kDBQnRJzIr1XjnpPm6U87UotbDCWQ2zaqEm8eL/SaiAJFo6ER1GIGsfUvZSj70Uq3ASQU2s6JBMQvHmd96LU8bs3op76GfvLfABM6PQzieH5chhAwI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GGd/PZaJ; arc=fail smtp.client-ip=40.107.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GGd/PZaJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxtY3EPUMDsv/GLrZafcQo48RJzUswNzvC5Zacd0f8jeZb54cdOSOJ+NYR1zmtmvEpV4Su1RJPSRqXFpl+FkDGCLPLF2aMkoitlVjRQ3rWjYt13LGTNoI5NhvckSeTzUqYO8F9aZI60AChq4bBpmWtHTffKIJoa2gBXut6Svgeuxb4SiFPlTBIeHVSMxvkGAgmscwYRxSDjEfzm1pDBpTUVdEnfKUnK/1wdONaBw02KwkPP3Z6QSZXbGA78PQ0t09rRrZa1rbT/jcRXL1fUp6zY1TLPWp/n8cGS7yb3oD04VgRVE3FJmmQEDlrOR1tGjLtlmJlZK27wW2sCgFexhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6L/X+qiHZHUaww8wnh7Z37zABLIhYh59rHRQ5r4PAs0=;
 b=xxilcUSiltuv0wRJEUQko8TCqTbqUIWW3zJz267677GZuappF7JfWWhutumNX4z23ExBltflTjpZ3O327nCZnqAB+u1kn8+Or+TBfQQoSc8Svppyb1diXhH54vDPIjW2EcXjOjCLqpdUktqNU6/ngmFTGLMADACYydE+jdRKgo152oLechjnJH0oEJVMTwquapYfqm6A0Xoryl7qH7+FbIRVxeHcawKCe2mO6+wEXQpM8hRmXkdoUPXvST0sgXLjV0TqXeQrhQ/E9lKptKHimR7PwC1FRT9E9BFW+oQ/SnCVHT2b0IIa8lFsnfvMLj1pZf5jupriYl1Qn332Y/885w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6L/X+qiHZHUaww8wnh7Z37zABLIhYh59rHRQ5r4PAs0=;
 b=GGd/PZaJFFrkoGJp8fnJYdkri2GK7ipm8X5P4YqZ/K9P7Qp2z3hlWJJ50lsn9gVh/Ypan9Z3gPSvCNx3+Fp023AcluIhUjRJeZH+dR7Bu0lMHrW9K1nQPOoyP63L3hdEAx596zCWzsGxcBdPp1OLqZ3i7L0mwyFGEHkRo6+NAmAaTGu61W6hnZIC4XC3vzgBkho5rs7y324vdtfDw5vfE6tGTNkY29E2FEAeo0B80Hj2q5hOSGuryLlig7r4P+6r5GlhNbMnXCJxmJnBh38hd5Kd/8Op3/EOlpeib2RRxOggonX2A9IbY1cTm07SKv9CJJW8go25ifBQtXSIoGnZ1w==
Received: from SJ2P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::11)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 09:37:51 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:a03:5db:cafe::52) by SJ2P221CA0008.outlook.office365.com
 (2603:10b6:a03:5db::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 09:37:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:37:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:37:30 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:37:21 -0700
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
Subject: [PATCH v4 02/27] cxl/regs: Skip sub-block region request for BAR-owning drivers
Date: Thu, 13 Aug 2026 15:06:06 +0530
Message-ID: <20260813093631.2288172-3-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|BY5PR12MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: 71caa5ee-d656-4fb3-9348-08def91e8ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|7416014|1800799024|82310400026|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6kF67cy3EUHihJXHseD63wg1xA1BymgGO+HT0nID1FSltEUoCWkMFn9uzCGlLSUE82qxaMvFE1wTBJeQIm709PESYcpbr1PStozMyobLq2xXC5XiDZjMKm5IfYbmGvpG1WABC+HO7dtGRXyoF0ucL+SRim6yOTpz0GuX91UXugESzjghHRbvzp24/QelTT6Xj1iMrRAxZsI2ifxzbnsiUqDrC8NsUAF68BVBleQz4E81tNnc1ndYDQHXDlt1xd+fOEHgJJ8NvUJbPAu1RzWkEHqOe+gDu0fg8nMPHvxUpqJlRXPi9VB0mXsMg8FPwj70WsY3DqU+qKPvOyOdvrTLL+ja6oBRD+tHi+H8n1GrgZqqa3FFknts1qz9oXGAEdpXHWIq5HEXGGO4Lp1694/PkzftFmC3jWHcJoF8Oj+wy0eXjuXOnsbwsnVyo/DrJFCnz8j2mRm910AD5uDVVLtAJjY8RnQRNDpkdfea1V1WRdzc7vaMT3eT3gixZ/4NdWZMSLciK548X3wvp1cyIbmUy9Uiwf17dbBy0dkUlGuTd5YGQaNatrlpqrvOuPPezv+EtOVdjQCa2veTyoBgbakIdwv19vn1Z46jSMw0V6W+43Nb3IK60ox9ksaj9F8Yl1MNPyvOQjJfrwgfo5F0wgV6FC9M4lLoyNPs8+0IuFobhm738AhW6iD2uG89BkzZ/19nEt389W4ypB56/pnpXr29qzHEFHZWl7BQy4dG/9RyFTZsCxTYqD8pono4awL3Z/Xl
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(7416014)(1800799024)(82310400026)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nGzFSoVgjFOv5PmEpB8S3kvFnWNmKOvRQrGVh4KiO+k508lB8XidOGEfn3+Ryni5WY2crGc4wBBinEOctmceezhvfQVZn9rmVrW4GGYqsK7Gq8Q80AAorvYIIhOLnnc+RB5bIHYE3WWw0gfEr63McbInBojUTcrQaNjS1343lwGpQpa10CAXjU7M/oZ7D6W6O2rmkPyDh6eNtaqstt3CMOv5nyGibfDW9MPoRaIw6Cz1nLS9dINL++WPpdxSOaWBz1F2PB+rprYhYwLieiT2kwhPHQ6Ad5ympfDUBu2ig43I6eDv4NBpzRQWhetYxDuXPuxjOMuYYOl8/elKqFy5XhEJA8ZKGqPkRVTcYnyRthnNkzUoBvJmKNEtOcaaCGWSOZP+h+21bYglsnl08T5hyVj8ruVSYMM42Rh5RSIKty/WyuNoIDljCm7addT3j6R0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:37:50.6003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71caa5ee-d656-4fb3-9348-08def91e8ae2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227

From: Manish Honap <mhonap@nvidia.com>

cxl_map_component_regs() claims each mapped sub-block with
devm_request_mem_region(). A driver that owns the whole component
register BAR, such as vfio-cxl, has already claimed the full BAR, so
the per-sub-block claim collides and the mapping fails.

Add a bar_owned parameter to cxl_pci_setup_regs() and record it in
skip_sub_bar_request on the register map. When set, cxl-core maps the
sub-block without requesting the region and leaves ownership with the
upper driver. cxl_pci passes false and keeps its existing claim,
preserving /dev/mem tooling access to the rest of the component space.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/pci.c  |  9 ++++++++-
 drivers/cxl/core/regs.c | 32 ++++++++++++++++++++++----------
 drivers/cxl/pci.c       |  4 ++--
 include/cxl/cxl.h       |  3 +++
 include/cxl/pci.h       |  2 +-
 5 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d807c1a002c..08d4c955137d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -720,7 +720,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 }
 
 int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map)
+		       struct cxl_register_map *map, bool bar_owned)
 {
 	int rc;
 
@@ -750,6 +750,13 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 		return rc;
 	}
 
+	/*
+	 * A caller that owns the whole register BAR (for example vfio-cxl)
+	 * maps the sub-blocks without claiming them, so the later
+	 * cxl_map_component_regs() does not collide with the full-BAR request.
+	 */
+	map->skip_sub_bar_request = bar_owned;
+
 	return cxl_setup_regs(map);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 989e79383b99..90dd85f322f5 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -177,35 +177,47 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_probe_device_regs, "CXL");
 
-void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
-				   resource_size_t length)
+static void __iomem *__cxl_iomap_block(struct device *dev, resource_size_t addr,
+				       resource_size_t length, bool request)
 {
+	resource_size_t end = addr + length - 1;
 	void __iomem *ret_val;
 	struct resource *res;
 
 	if (WARN_ON_ONCE(addr == CXL_RESOURCE_NONE))
 		return NULL;
 
-	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
-	if (!res) {
-		resource_size_t end = addr + length - 1;
-
-		dev_err(dev, "Failed to request region %pa-%pa\n", &addr, &end);
-		return NULL;
+	/*
+	 * An owning driver (e.g. vfio-cxl) may already hold the whole BAR; a
+	 * sub-block request would then collide with that claim.
+	 */
+	if (request) {
+		res = devm_request_mem_region(dev, addr, length, dev_name(dev));
+		if (!res) {
+			dev_err(dev, "Failed to request region %pa-%pa\n", &addr, &end);
+			return NULL;
+		}
 	}
 
 	ret_val = devm_ioremap(dev, addr, length);
 	if (!ret_val)
-		dev_err(dev, "Failed to map region %pr\n", res);
+		dev_err(dev, "Failed to map region %pa-%pa\n", &addr, &end);
 
 	return ret_val;
 }
+
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length)
+{
+	return __cxl_iomap_block(dev, addr, length, true);
+}
 EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
 
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask)
 {
+	bool request = !map->skip_sub_bar_request;
 	struct device *host = map->host;
 	struct mapinfo {
 		const struct cxl_reg_map *rmap;
@@ -227,7 +239,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 			continue;
 		addr = map->resource + mi->rmap->offset;
 		length = mi->rmap->size;
-		*(mi->addr) = devm_cxl_iomap_block(host, addr, length);
+		*(mi->addr) = __cxl_iomap_block(host, addr, length, request);
 		if (!*(mi->addr))
 			return -ENOMEM;
 	}
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bb892dbfdd6d..ec1693c21f61 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -816,7 +816,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxlds->rcd = is_cxl_restricted(pdev);
 
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, false);
 	if (rc)
 		return rc;
 
@@ -829,7 +829,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * still be useful for management functions so don't return an error.
 	 */
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
-				&cxlds->reg_map);
+				&cxlds->reg_map, false);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 	else if (!cxlds->reg_map.component_map.ras.valid)
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index efb8ac97bd92..f8e8fddba152 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -213,6 +213,8 @@ struct cxl_pmu_reg_map {
  * @resource: physical resource base of the register block
  * @max_size: maximum mapping size to perform register search
  * @reg_type: see enum cxl_regloc_type
+ * @skip_sub_bar_request: set via cxl_pci_setup_regs(); the owning driver holds
+ *			  the BAR, so skip the sub-block claim
  * @component_map: cxl_reg_map for component registers
  * @device_map: cxl_reg_maps for device registers
  * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
@@ -223,6 +225,7 @@ struct cxl_register_map {
 	resource_size_t resource;
 	resource_size_t max_size;
 	u8 reg_type;
+	bool skip_sub_bar_request;
 	union {
 		struct cxl_component_reg_map component_map;
 		struct cxl_device_reg_map device_map;
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index 3e0000015871..81a32004a604 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -18,5 +18,5 @@ struct cxl_register_map;
 struct pci_dev;
 
 int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map);
+		       struct cxl_register_map *map, bool bar_owned);
 #endif
-- 
2.25.1

