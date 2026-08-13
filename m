Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1782356764;
	Thu, 13 Aug 2026 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614095; cv=fail; b=Y97zyHwp2Gv7jPPupcuN9EDW9h3hO5N0UdJCu4mEeh/MNQymO4udKow5fIwszZs7tpbhQOyzMP1RcP7yGmuot+yqdDHzh5wh2JjkmZ7tqCDVy3K0qjzEZ1BmzN3IqcjZ3Jyobvu+FDGO/ad0nAylLVPdP9xTGH4S/uMgG2X3XmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614095; c=relaxed/simple;
	bh=t9/RH+EzZqHCZYu5okQQj27PqcBSDlXntBu4mkXJXlU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRViR4wgHrbrD3Cmp6j+sU8QCMMgBNDn3T2LBxAeqwgmmfKxYixv5pPqCsuxc3lnnlQ5EScQjAN/0XfBqAzN0uOav6iBA61Nmeb3bTwgTI9n40ZbXGmnxnDsHDVYmY8RxQpI5QqndoIMg5lpxV8dArQ2kccY4bpXiCG8H+EoyWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fejXwfI3; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fejXwfI3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzAQxlv5/Vfw2OiWsnVdLqyHDXnU9blfg9LZgIg8htOV1q/pa9Llr8jQLV/LtgV+Oq1gOGqv5Vmygiu8Zm421qtQ2zxxRnFkDqcLbp9M/1CKpS0f1jWqQMTsGEBXmiEDDDLNpP49yOYWul1Xt3Sa8aO8WJdmHa/TtKUXvmiy+a28K/BjTO+OdOEgHUBiPM9IpCeiELTngxeRXXtWonzPLi5KB9ql4bwnkyS/yYNwg5n+IFKbYyp55lBorEFh0V6Sx1Fws4ScieWRM3nCyW1W57go4UVQ2AQQddp9KWEfLADdrCXw3lCJG9EPo8qTtNuDAZ5nHxve8ns3yk8C5ZmtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fQ2pKgW+VvooD+qgzd6Shp0PJZNn21hQaEnFKraENE=;
 b=aoklY7cddkWTQ1F01OPVFfO2tHPF2fvUrULZBxkFxf+mCPqfFGHFN16LX3/aUoOQ/2hFs+dpONXaBJ9Vg7WTpRAxeLYaaMCCQtdJN7z4fXRujU9to1vmT2jUjE+l5blmgV1mQ3AEnTeCV0tUphFuzUUNZ83PnEQIYxXxD/ne3Ml4zWcsftCn8/0QrSuxlxq8Qgiw9UXbM1tmSbZy/reg9O8AS5oGF2/5915l+PmaBoZxP2kI4k6rqICo4NaRSOsqFVyQcPh8C0A0638cBxFZnj7CVXDVXhcJBVaSHgK6MTAhN9vJ2lAr7siHI5FD2FYlhPe0bMRflQEgPcuSNh/Ehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fQ2pKgW+VvooD+qgzd6Shp0PJZNn21hQaEnFKraENE=;
 b=fejXwfI3C+zTm2v/n+h/11WJkYTzSNhv3AZcNOe4U+BmatLiB0IiTFN6Znu897FnRL2gjHzLxuDGZjNg+zdhiXSllN/xexLNC87/bV1C5ratr3gAwoWDqlg7EI/teUP0I4Zlfb1kRtuwHHFQ8CAGo1+ivMXoC2RhtrQJcwPNPam6boCZky+5Ctz6eiwFgGP5ABgZ2gGDaIVtSBfj9AHb+VYaI7i53vDhuqyC//lJfNPLVCT6QIG43dR/UmJ2+INpgtQxt56cZJc3U7ySEQaMNftkj1HCb6RdkTuF1vsPZsjdVY/4qGY6Kenp1vTMgEyvfY5elIEh4QVfmhh+5CGaFg==
Received: from BN9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::11)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 09:41:27 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::73) by BN9P223CA0006.outlook.office365.com
 (2603:10b6:408:10b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 09:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:41:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:41:10 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:41:00 -0700
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
Subject: [PATCH v4 25/27] vfio/pci: Provide an opt-out for the CXL Type-2 extensions
Date: Thu, 13 Aug 2026 15:06:29 +0530
Message-ID: <20260813093631.2288172-26-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: b450fc74-7682-48b5-5be6-08def91f0be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|23010399003|1800799024|921020|18002099003|56012099006|22082099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	u9BiMfndPvqMYiiPdZ5HIQSVj31notCDGID9+iLC/Jv5gKWkLQPGth4UVf/pUFGp21us9HgA4DVsTQgKCt1Cu1otlhzj+/Sm0cjpQWqkxobHxnCN2khDwPPWC9SAzypE7Ccy2biaDvBjjUbin3doJmHsWbxMS7g8zKXa7aY2OAaFLSNuknWjW3BeFKMZP28eMMw90W5Ej39aREyuDZvRE41P4uLeet6AdIq+7kKZ+HMwoewdhpe7vJI7Dskq9FjBrpn6IMQwTAAp58udnWHHwsIYtjbKscprnCuIDvc7lIZUfWYrqmVu4JYlaYu9JTJS3rtU3ADW59S8fBPd2UC7dbN3VD4Hlrmc4Ee2YNTCH6UQJHXLiyBLfuggckPaG4fC4T6eCT31C/pHucrKvLlOI0MbWdWZfcYYuYWnqNmAod7LTZbfoL9o3TCm05mqwt+2nGuENqhetYmX651YKKClD5vK5AETgWyZw81iLdz9S5K19ckar8Eds2BZiaW2siuN1yaEj/u7kswDyF1yVhmmqawQJBj2kmjnvZGm2btkq7b1g3xPme5YbTcqIlORL+aGXxj/YLrxPxWBb1G6pmjaNSA6EmpjdDf0B4QH011+SkxqvsdBpkWetUmxM9T7tHVJfM3emDpLFSqrjcBbuCX/mmhwOplVOZZ56St2Vywe78biGAJrLd4DsIyeGy3kEj13YqqkDG/iQ18JWUwHdV6sXggdeWYwVxYTqL5yXMtrh04FRP4xUy9pAuHL6jr2wCt1
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(23010399003)(1800799024)(921020)(18002099003)(56012099006)(22082099003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jpp7N2c8PDeT5QZtx1gs/PD5WymhAuUTlE5CvLSqFs5Bj3KJvzJotomFpcytBpc5zdOTJpMcuTXNdonUq35wzOto9D9+grl+dS3vtchva/ZCjYj0Iy8M0/7D6OC/wfb9EuYbXsqPSqE7WfuqJndo65Vs7RnJSFroHuLE2Q+hdFD4dp/evqI19BFIAEaunT1bSJN8AMLrjaUcTtSvflZ8ckd0egR4diCwqAHVrl+vUtwUkdwUtAsYC+VlUYo9mkwv3zBHNq2ILXAtWcznFJLsExkm/JM+Q26ks48P6Rc1vTjwBiCMXg3t19maUDCZdvV4FLlpcLcYpEkRdkyaaHmi6qYx85odYoBPXIByRLi+C0aAj5LF3ivewG8wwgoTiBzCPjPpTr1eaWJv3PRzLwI42sNPuyC2IqwU0xXiThec7eKW1vsQGYX7E+LJU6QHcAk9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:41:27.0156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b450fc74-7682-48b5-5be6-08def91f0be6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403

From: Manish Honap <mhonap@nvidia.com>

Add an opt-out so users can keep vfio-pci's CXL extensions out of the
path for individual devices or for an entire vfio-pci instance. The
runtime gates are:

  - Module parameter vfio_pci.disable_cxl (bool, 0444). Setting
    disable_cxl=1 at modprobe time makes vfio_pci_probe() set
    vdev->disable_cxl on every device it binds.

  - Variant drivers (nvgrace, mlx5, and others) may set vdev->disable_cxl
    in their own probe for per-device control without the module
    parameter. The bit lives on struct vfio_pci_core_device so it is
    reachable from any variant.

vfio_pci_core_init_dev() consults vdev->disable_cxl before it probes for
a CXL device, so a device that opts out is driven as plain vfio-pci:
vfio-cxl is not loaded, init_device() never runs, and the device gets no
VFIO_DEVICE_FLAGS_CXL, no HDM or component-register regions, and no DVSEC
virtualization.

The module parameter is built only when CONFIG_VFIO_CXL is enabled; the
disable_cxl bit itself is unconditional so a variant driver can set it
regardless. This mirrors the long-standing disable_denylist opt-out.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci.c      | 9 +++++++++
 drivers/vfio/pci/vfio_pci_core.c | 8 +++++---
 include/linux/vfio_pci_core.h    | 1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 830369ff878d..0ad041fffe48 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -60,6 +60,12 @@ static bool disable_denylist;
 module_param(disable_denylist, bool, 0444);
 MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
 
+#if IS_ENABLED(CONFIG_VFIO_CXL)
+static bool disable_cxl;
+module_param(disable_cxl, bool, 0444);
+MODULE_PARM_DESC(disable_cxl, "Disable CXL Type-2 extensions for all devices bound to vfio-pci. A variant driver may instead set vdev->disable_cxl in its own .init callback.");
+#endif
+
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 {
 	switch (pdev->vendor) {
@@ -142,6 +148,9 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 #ifdef CONFIG_VFIO_PCI_VGA
 	vdev->disable_vga = disable_vga;
 #endif
+#if IS_ENABLED(CONFIG_VFIO_CXL)
+	vdev->disable_cxl = disable_cxl;
+#endif
 
 	return vfio_pci_core_init_dev(core_vdev);
 }
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 0fed8e00bc1d..4b51a0f1e847 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2423,10 +2423,12 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	xa_init(&vdev->ctx);
 
 	/*
-	 * Load vfio-cxl on demand for a CXL device. If it is absent, drive the
-	 * device as plain vfio-pci rather than failing the bind.
+	 * Load vfio-cxl on demand for a CXL device unless the user opted out.
+	 * If it is opted out or absent, drive the device as plain vfio-pci
+	 * rather than failing the bind.
 	 */
-	if (pcie_is_cxl(vdev->pdev) && vfio_pci_is_cxl_type2(vdev->pdev)) {
+	if (!vdev->disable_cxl && pcie_is_cxl(vdev->pdev) &&
+	    vfio_pci_is_cxl_type2(vdev->pdev)) {
 		const struct vfio_cxl_ops *ops;
 
 		request_module("vfio-cxl");
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 18e206a35d8c..8e3723a55c17 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -158,6 +158,7 @@ struct vfio_pci_core_device {
 	bool			disable_idle_d3:1;
 	bool			nointxmask:1;
 	bool			disable_vga:1;
+	bool			disable_cxl:1;
 	/* Flags modified at runtime - dedicated storage unit */
 	bool			needs_reset;
 	bool			pm_intx_masked;
-- 
2.25.1

