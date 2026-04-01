Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA086391834;
	Wed,  1 Apr 2026 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028642; cv=fail; b=KXC9XTAMnOJOJBk/7GuM/2h2M6tgFbk4kNxs4ndBwZaqsswC9nNT7PPZafXCJYDzkMTK7BLx3mVcxt6hveOUjxX1shpOY5aE4VAUonFGwGF0/OuT102zw7+KW+5QxqpnH+BjN2ZJyDMnP5Gq4Ry0aykGg5NYnsuZB4IArFSWN/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028642; c=relaxed/simple;
	bh=jNZAfKqhOMlUoJpOlWiJScp28OaPyI2i78phpqAhsRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwQfAmDiImyN2lFshmttcRwzMYmOtMG9noHHTGOc9C6zzwzZq+QHXtGw/kkUpfFRdCyNcbLkjZlIcpB8+s1AHFTwpq43NbRrGje9xEnSpZADhJqmaUF6UT1A+CjaF2e2z7rkGgdQ12cc7C0eM2gzOhleSYcERMw5fxcV+3g9tkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C7uA3xbG; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C7uA3xbG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpKuFoTTlzomWiDl2ESic474u5ZvlmuYHLEJs93v4hBMI1xe7wULiYvbltqqZuQ0+uopLumAbs+ktdKSZw97XutLeAaWHBpGFUQ39mWsDtGUoAMcK/5SrnCg5Q5M0aOEYyiVsf4nPhztmyCwXw3lGEpJPGrKpfwTHPTndHc/EbsnPGauInUFKqoqmwGmvWhv5f2sxOHL3pM/ZAexgBwM6fJvSdw5clPZMuDy3rSzKkimxIcgSHIqa5BNVRM0YjjY5S2neq6NR1/vsZnFXDdXkQM3r73MJT1xPX1TY/xsZO42xMyhamiqnj6sTtJXwJsIHBbdCIs2qzx20hvfdqtn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8OEV205hOziypl1nmJRGmEg0Pk/aozqrUUWMUkOv9w=;
 b=CwLwHV3zhKwNjYZrOn44wgZiYb8VEvtwF7aR9CdGk97KxE50ouUJnZdml+tx6XlJJ3/zWYHiSqA4/Kf0qbqaLUqGDhYInMMNeoRd0glXLEbHQ+DESrOgDUdcBET2ptw9oGOceZJWxqQnu32gHeSd46shxmP13KjDv8XITuANLQ1lijO8PmuNERCpONWyTd9tvc7Gtz1tF5cPYz9DB5W+Cjo5hr7sa3uzG0ulX5RewIFlZ4J54VeGNiwABeuMrtMxchhczd+9U7NSBIkeXBc/ZvnzCGI8uielTIuPRpCJ8OjNVcrmrieC/VFrVsLuz6YgPpbi2O+aRSHKLqmpOdlg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8OEV205hOziypl1nmJRGmEg0Pk/aozqrUUWMUkOv9w=;
 b=C7uA3xbGLzUG5rmqVIlCvVyhVm7Dwi5QYsU8hvovXaeVsrDg2UYXeeyiqwMCkdn+5iI6+WvM7e5SD6d5aWuCbHEphzimgFXKk9ka1vAbfoFdnWdtFWYvo3sfZ0LsB6PMgvUAh/x+nEfMVE3cyifQn1JKp/wJ03Iu6Jq/mxW8E0o=
Received: from BL1P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::17)
 by MW5PR10MB5826.namprd10.prod.outlook.com (2603:10b6:303:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 07:30:37 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::2b) by BL1P223CA0012.outlook.office365.com
 (2603:10b6:208:2c4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 07:30:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 07:30:36 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 02:30:33 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 02:30:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 02:30:33 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6317UN3Q3832504;
	Wed, 1 Apr 2026 02:30:28 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<mani@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
	<corbet@lwn.net>, <kishon@kernel.org>, <skhan@linuxfoundation.org>,
	<lukas@wunner.de>, <cassel@kernel.org>, <alistair@alistair23.me>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [PATCH v2 1/4] PCI/DOE: Move common definitions to the header file
Date: Wed, 1 Apr 2026 13:00:19 +0530
Message-ID: <20260401073022.215805-2-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401073022.215805-1-a-garg7@ti.com>
References: <20260401073022.215805-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|MW5PR10MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bf949e-ab45-4752-5275-08de8fc09115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QnYsR+k0hTGagduKICOj88AEPCVtSkNg/6NyjjoF5tKaneWlhHVYIpM0jpHlEByCD3sBaYpMe4QgKcbkGzgNMZ3PRxQ8zXvGfb3DqhxgAHseY1u7Y83Ez3Zv+2IhF48wOFzsP2vpg2XZ8qDa91+d7AQ3VYo8CkqIx0UV/dzulpOZc0DIa+88MTtXklUdTrzqHMBQYNXvIMXvEgT3k4LLSFPtHNZV/JdGRJgi82N/oN8iZGwGMuKF747nVSvoonzI26myoZnvAfYzrPq0jf6IFagsHmmTpKbwCEEj3hBtVjuVy/16bOy2/K23OMULUO/uBzJRQ2JGqImE0OL0v6tD3rT2ok4RFF+7kzztMEDZIhP9QfN6Q+36YaWw6NzsdAIGz/ht1gDXJozZOdPyoZGkQ2nXVZ7a8eD+zHtojQijJzlk/3KB7saUPJymzvdbc8EynItjIakvzACEm8QbaFktdijwidzWUMJZd22Dl614HodGR8QBeNDgIiRsfqw1O+E+bJTKP6uOZ4U6PkPIVbtonjQFoOrQ2VpdPMgJvmMZa+yXAEQoPoY5WIe7s2RE/y5Ly2JxPHXuoVBJxrLvvYOT0Z08HBW5e9lY1WB3a5lwYdn9Uf4kIWOOnwMEBUZtNSqzIas9oAHKoYIYF60cYskGx8VznAE6eKT73jRU39t864gXklx5cJzCaJrO1k5TKq+zaSAXwYWQL24WQKyqoz1PYmV+XUQOExw3yrlSmrnLh+rVkDTpx0Fc9E2ctdiU6yjtKqpzgTTM6v9tSn1ypVEu2hNvB8Tci629FRNG3tP+q319RitiE1PyNQphsGB9uIoo
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aS6LAhxRx53RNyPfSfj+XoB83Xfcz4CHv8JocbC0PRB2AufYftbtlMB08V/X5fwljFheIh0NBkYYAbKQ/iRLho4e9S5cCnkteGEjavBpwfMRG6jOnb08K9EOy6/KVZwFwV11H8B0wadVr0H9uzH9D4XzhrkA9lhTH8BbCROqNMpjEpBTZpyqpAtDDiBywRFeDM0xzwQgzdPZe0Lp8GwsFryreepb2kAvv/MISBrZBnvCmaYLiavwyqBLuNm9iM7YQMQXvtNskqeowZ91YNqvxyzu3uYHGBp/r7gl406p+x7RPjir98ejNgIQtqBgCuHcgoOWvel4fFxGJI6HS/0aTSVusV/sWJI5aAE0tVe2swgTPSmRZmhV/SRwWPeoH6eoYNvAId06MHTsP0iAY54+hAPMcCqRB0Ifi/yVbkjLqsFZnvwjv5mbA0JLspNMMhF/
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:30:36.2531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bf949e-ab45-4752-5275-08de8fc09115
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5826

Move common macros and structures from drivers/pci/doe.c to
drivers/pci/pci.h to allow reuse across root complex and
endpoint DOE implementations.

PCI_DOE_MAX_LENGTH macro can be used outside the PCI core as well,
hence move the macro to include/linux/pci-doe.h.

These changes prepare the groundwork for the DOE endpoint implementation
that will reuse these common definitions.

Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---

Changes since v1:
- Moved the common macros that need not be visible outside the PCI core
  to drivers/pci/pci.h instead to include/linux/pci-doe.h as suggested
  by Lukas Wunner
- Removed the redundant empty inlines guarded with CONFIG_PCI_DOE in
  include/linux/pci-doe.h.

v1: https://lore.kernel.org/all/20260213123603.420941-3-a-garg7@ti.com/

 drivers/pci/doe.c       | 11 -----------
 drivers/pci/pci.h       |  9 +++++++++
 include/linux/pci-doe.h |  3 +++
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 7b41da4ec11a..e8d9e95644b3 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -28,12 +28,6 @@
 #define PCI_DOE_TIMEOUT HZ
 #define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
 
-#define PCI_DOE_FLAG_CANCEL	0
-#define PCI_DOE_FLAG_DEAD	1
-
-/* Max data object length is 2^18 dwords */
-#define PCI_DOE_MAX_LENGTH	(1 << 18)
-
 /**
  * struct pci_doe_mb - State for a single DOE mailbox
  *
@@ -63,11 +57,6 @@ struct pci_doe_mb {
 #endif
 };
 
-struct pci_doe_feature {
-	u16 vid;
-	u8 type;
-};
-
 /**
  * struct pci_doe_task - represents a single query/response
  *
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13d998fbacce..66b7ec80f46f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -681,6 +681,15 @@ struct pci_sriov {
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
 
+/* DOE Mailbox state flags */
+#define PCI_DOE_FLAG_CANCEL	0
+#define PCI_DOE_FLAG_DEAD	1
+
+struct pci_doe_feature {
+	u16 vid;
+	u8 type;
+};
+
 #ifdef CONFIG_PCI_DOE
 void pci_doe_init(struct pci_dev *pdev);
 void pci_doe_destroy(struct pci_dev *pdev);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index bd4346a7c4e7..abb9b7ae8029 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -19,6 +19,9 @@ struct pci_doe_mb;
 #define PCI_DOE_FEATURE_CMA 1
 #define PCI_DOE_FEATURE_SSESSION 2
 
+/* Max data object length is 2^18 dwords */
+#define PCI_DOE_MAX_LENGTH		(1 << 18)
+
 struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
 					u8 type);
 
-- 
2.34.1

