Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010061.outbound.protection.outlook.com [52.101.193.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15DF503BC9;
	Mon,  7 Sep 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797220; cv=fail; b=hzRtrsf5k7F9O2iDAEfGCF9KgmWAifkD33aKT5TS7NWR80dG2ShjJM5MSKlfPmtSoxg0mL+mXBvZvQMzwwUINMKMI/8Ea5gg9JfG0oVKj2i0EzphxHGJqCRf3YisBVlNJl5p8uyKs6fYta5eGM/tn0IL2P0AI/pWpCFU6DnjlBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797220; c=relaxed/simple;
	bh=5bh0s62d0+iip/MykvoGSDVLP9hzrKMTg5UkOZz38IA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUYwcQsdEb48aw2CAkqKIJNTWE9VfV260wewPZR85+zmP6kJZ7qZ/UoaxPGswoUEqtjtk48lTQQCtvHYZmmsp5g3IPG++gvqtHyzevSExRFNjj3qgxDIVPWwDb6Z42iaF0e1UX+QDpllitch8HzmxgWoWjzz/QWLym+eIz9Y2rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F2mW2V1l; arc=fail smtp.client-ip=52.101.193.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F2mW2V1l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py/PRVVjC02DR9Zw1W7EU/k7hub1zPsEvyxdxy5PjSri4IpZca4Lb+bKqN+zuZT/2kaSJ3D9ucOJWZSlltJDFHTkcU6elopyeHaQCL9m4/J0Mwly5u/cN2PbyLy1WNIERfLgO+l+FeuwQFfnVaJOhGmN+fFPW+qzM9jDku+I2SZ3Ade7BdKJTuhQFnZFPuJD1JHWbDHzFa4gZkA0cxRvO8zcFqAeExzO89wVLyj9/iUbT9EW5SaEak/NTJKA8jPqwJHWvaPA6qJQwNSTUL7J9vmtCCmINgK52mzw85y4+QCCxUzqO6W72TSnaT0N8fR1GSuCGZ/hEB45F1ERkYi33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvRENxPFMuo44ZLq8DOq3H9/A0pmOFvLSXWBuBbNTwo=;
 b=AIb3veGfHR551080FOAzf7avqVOvOwf20KTffyPnpF943WxwagsFaMLJpMWPvgVgx3vGqJoIQCJwiRIAwkjnjrH93+XvxW6r6XCt5dDs5wUyllxiz0YIoCQrqCZ3oTD/7tuwVZ4aDi4cyjKLqcRkQm8lTaRkQuKK+ehduP0W6bbbAmlevOohJfL3AyyttARtT2ocCab2mAdXimXk0iuyO0l+tyxbJygkw/K8lpIUtUz7eJYbvrbMGoCowYhLKEDGB1/IJjTue+Ct8oPYLX4kHg4HvCFrfVSHFKIRagfC5T8jQ29gk0FiExRYkdwqErjhlDi7mWXL8JIyH88YOjaHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvRENxPFMuo44ZLq8DOq3H9/A0pmOFvLSXWBuBbNTwo=;
 b=F2mW2V1l2czkjizUMmS/W3aOD3sBzYT5iXRcLfUKZiXIOH0ci0tOOWvQFNb5hRse5AyIWvay7CsBCO7xyMBQI7iFxax0pabMrgV1zIBGQKcxMEt4K6QZV4wnSfafjRf0UCKO3BugPOUKH7FTwkIS5SzuxQucKdRTg0wC+tzNq7Q=
Received: from SJ0PR13CA0067.namprd13.prod.outlook.com (2603:10b6:a03:2c4::12)
 by IA0PPF170E97DF1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 16:06:47 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::38) by SJ0PR13CA0067.outlook.office365.com
 (2603:10b6:a03:2c4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Mon, 7
 Sep 2026 16:06:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 16:06:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 11:06:46 -0500
Received: from sriov-SYS-7048GR-TR.xilinx.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 11:06:44 -0500
From: Nikola Prica <nikprica@amd.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jerry.jiang@amd.com>, <haijun.chang@amd.com>, <andy.zhang@amd.com>,
	<christian.koenig@amd.com>, <jim.chow@broadcom.com>,
	<matthew.mcclure@broadcom.com>, Nikola Prica <nikola.prica@amd.com>
Subject: [PATCH v2] PCI: Accept AtomicOps already enabled by the hypervisor
Date: Mon, 7 Sep 2026 18:17:01 +0200
Message-ID: <20260907161701.454364-1-nikprica@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903121217.23F751F000E9@smtp.kernel.org>
References: <20260903121217.23F751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|IA0PPF170E97DF1:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f584af-eea6-4aa5-e0a3-08df0cfa04e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|6133799003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5oSeYonK8fqHfnx9dWWaO/opUFsHAGpfOEO3sm8f5oxhVyHrIJcAsMyncmo5g7kNaAdvmN/Hottsku0FW1I1RD+ngPA6QMj+cQroy9+wY/5uxHgAW5XIzy1AgM+nfXYu7bhkgY+p+cL8G/L28laNCjpfxPcnJJbnI8wPV1EzXaQpFkFK2UFb0ZiXwO6agMSWhGQTjbWylN4BNmyIxX/xvvA1kwtaa7Vxe3WTr17UWhRvNfvGtm6LGkxW4+dpIIZDDt4rNy2rmQ7MMcaXLqC2tRmNwQJsmAHPqz9+HOcRz4BFNnE6r/H1fdJOVInBXGmr8BzxyutOapp/mkT6XN0RxPN7euVxGTs0rqKieyYVOjwyaWi0Lw1HjC2HbWQMUkLXHmNkEq5KU/YUuHycI4OsIj6gn2AG/FdZ7TCgX8+Yf8cd7ePTeMs+qk90qF4OsD/9+Y/Xpf7rfkDGN+gifyouagrf2clOu+p23ed6zd7qkf0sgv2UV2mtuhw5g8Jll3AeGEEsAqZywGpHEQdCMobFIHmYvDfSuq/vHejEOluGlbOIpYpCNW8OGjP2cidgPrKzTfkcQj+dTsItilTd5F0q5KFDtKfjorXyl00IhAmxmLqrYh0pGvr2UFDlwAwWWE20Qxn26Vz6D0gt6vrgwYXJolUlVTifyUgaJiZdSu9lFg32wM7BUHHitkcl4CZ/xPbVBzNWYTBDoEJixKB67+LfDQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y7bcK8PmPws5dIK1k291oPnltcvMnoWUvb92Q4ARVnwApCDvUc8okZeeBYQDhQu9W2CIdTV5Gu0uWNiND1xuYO0An9QoUnuI+jpL7TrQM81xr1hlhcVDD/c3WTZztSs90ANzPeG9iYVJ8C4KriPYl3cBNwduwLrtqdqypOEEOKOYs3bjMKE3rCbD1ojpl6nso0EcVGr+/Mtd0TsjhEqPzN14KSIVTVJel7lkCW/A6VcWGihuhEpxuee/P3Qsni8dQuPRVDx1QBpiIYHirArinM0VxlIkX+1b2JWLrIYwSKeNhemtOR91EOm8yzEWSOXdAGwxmsReDziEJR520Wi42qQs6n3mT0JVyxR6Sp+qGd/LzdEKZzf+SJHhdWbk536JbhOjD1pkTNWzrQiwOl9womN3CMCVbFM08lr6dibm/iFIgVFAqIVx1G76zCwqBVXa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 16:06:47.3000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f584af-eea6-4aa5-e0a3-08df0cfa04e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF170E97DF1

From: Nikola Prica <nikola.prica@amd.com>

pci_enable_atomic_ops_to_root() currently fails when no root port is
visible. That is common in passthrough guests (ESXi, Hyper-V): the
endpoint is assigned to the VM, but the guest topology has no root
port above it.

In those setups the hypervisor may already have enabled AtomicOp
requester enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
treat AtomicOps as already enabled and return success instead of
failing the Root Port walk.

Signed-off-by: Nikola Prica <nikola.prica@amd.com>
---
Changes in v2:
- Be more strict and only apply logic in headless device case.

 drivers/pci/pci.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..62729ade496f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3769,8 +3769,18 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 	}
 
 	root = pcie_find_root_port(dev);
-	if (!root)
+	if (!root) {
+		/*
+		 * A hypervisor may expose a headless topology with no
+		 * visible root port.  If it has already set AtomicOp
+		 * Requester Enable, there is nothing more to do.
+		 */
+		pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
+		if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
+			return 0;
+
 		return -EINVAL;
+	}
 
 	pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
 	if ((cap & cap_mask) != cap_mask)
-- 
2.34.1

