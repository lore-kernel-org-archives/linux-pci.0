Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF8337B8B;
	Fri, 20 Feb 2026 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582242; cv=fail; b=dku2zAsN4eprrfXRK7xbnJs7Oufg0g3WQJ10yqjX2KBIWb98ISZvPXtSost8scznyamfwjrXjKT6BBfYCjCMLS1YQEQm7XaqBWDDIqZe0/3/g34CiZY1/0/OVc7TghH+QUQLNPn9CU0PHY6BYmQD+nXqMEKcHh/1qWV3LpA9gbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582242; c=relaxed/simple;
	bh=stWpa3ZnieunX/mEZyForl8+kqp0gFgnLATaYuhDH+o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jKvKH7lblSXd20h5eWpW2vFUWdBge7BWJixN3C0p2aSTFJiEOK7ZTzDVjrp4Gg2VYTPDkQfAOzZ/IORt99zleMDFdBHRk80GmfUJCfsJcchpe06FSybfuAK9dAWZ8yno1tenxEVGkbJXqOFtDwBPSDufwLSxPtlFnkPAm6qvaHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FJCxhpuQ; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FJCxhpuQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vk02zRzV7ayBySApdKdQ6ASyzDy+V2qw2kTj1Ah2tQR1fhnXbGOoToVYaMb+xYPIzc0Z+tjftL0JwMBJrHVxYMPX+l/kVpsLsPlyVpKVn4CTtKm/9sAvzXWGJR31JuqNy43+KSst1sx0ZulVXzBE07ri0m/dc8DrYahDWHvBT5X9BOKdNja/Ml5v4Iz/RVAMIHfUP+suAxiKp4XfpTldPXJC3EIg4pcg2EyKEFHEm9TGt7j4Bf8us0A8mtVeUa+dijCGbURYB4F0I/v5TGoLLu1rSCGMP6EYTjxoLAhI/DnVXS3+880mk/uB457Sdx3NR9kIFn+5DfPW+PYd/8pDXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tfjp+49vhzl3By2Wv/sCcXwEFzV8MxBofp59jqYnvM=;
 b=W8T+iob/oEJ8VxknXtl6swTD5rwr0+Hr0iEFSVzAlT39xwbEYEqiZYmrevC5cixSStgReZXLW46w8Pngruy494b+AXMatb/oS8gzu8LfWJnNHgipRwZx/WF7zurwlulPV/B5/IrQC+JsEPHkLdvzb4DoR8tIXqP39Jjc/PqJ6qsIHtIe/oG6YlqxARP/gmfRn23GvC4kJhcLgAbey/+NWAurPUFIwXinxgxge2u7NLUpYa2f1EY1ImpZ5/zK3xgMhSCT+hih8iDBtr2/1loTsTAAwKyiVeF3hMUbCF6A8UozMH3orMfWvGipqNE+ggohE/HCpnITj+n4OM9aVmY/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tfjp+49vhzl3By2Wv/sCcXwEFzV8MxBofp59jqYnvM=;
 b=FJCxhpuQC5GbCDLrvS6AX815aV/7SaHL05MF9oaxGAXjm6A8jd+0CFCwp5qz6EEjkS6asp4uwPw1xeevNhluHKcwGXIvWd1T/edb0qdz2y06PXB0HAvm3pJ+jG1sWLmt2j+0q9DRxTXL0Rbnf35csiy25g4l66bpIQ2z6eGZ4GY=
Received: from BL0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:207:3c::23)
 by IA1PR10MB8211.namprd10.prod.outlook.com (2603:10b6:208:463::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Fri, 20 Feb
 2026 10:10:39 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::f1) by BL0PR02CA0010.outlook.office365.com
 (2603:10b6:207:3c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 10:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 10:10:37 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 04:10:37 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 04:10:37 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 20 Feb 2026 04:10:37 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61KAAWMx4167387;
	Fri, 20 Feb 2026 04:10:33 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <s-vadapalli@ti.com>, <arnd@arndb.de>,
	<mpillai@cadence.com>, <hans.zhang@cixtech.com>, <unicorn_wang@outlook.com>,
	<kishon@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <danishanwar@ti.com>, <a-garg7@ti.com>
Subject: [PATCH] PCI: cadence: j721e: Add support for PCI NTB functionality
Date: Fri, 20 Feb 2026 15:40:30 +0530
Message-ID: <20260220101030.852423-1-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|IA1PR10MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a9f6f9-c4a2-46df-30f9-08de70684b90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|32650700017|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dzAP52p3FA+zgPyNMRZARJvLoV1WEihyTz7hJQnmDjE+4CZq06XXZatyS7l0?=
 =?us-ascii?Q?yoI1LOdt1ifYsIGPuqshikvy2Fw7t9HM/OryFVzj641e2FaanCh8awtj4SBD?=
 =?us-ascii?Q?/AiGE5N+hzVJpE59uKEa2W/+2YP6vQnunR8hBsvBnbS2zlathSKNPD6rq4ag?=
 =?us-ascii?Q?wbACPRoQ+54fJ3IK4YPTvEfKsPCc2nwk4xLdSFzj2q6tcjN6zkm22WgH8f5R?=
 =?us-ascii?Q?WO1Fccs9HXPLA0snPSNbtFZOwOVxLMSgofShAyYgo7Rwhc8JmOwNQ3nqYA1L?=
 =?us-ascii?Q?ZZ+uU8YbIXs+KS+8hsbNRcHOpU80rfV42ZYbRKMkw7nHguyebGGQIPjLPh4q?=
 =?us-ascii?Q?39HQ12/3UI93KPAL5A3v04fDSkEn4YPT7Lryz49IJpPlnKGVw4B6ZOD8NVjI?=
 =?us-ascii?Q?WiBIToEAOdZpLfP75YmUqPlmYbnJpSaDF4tG1wKQlnEUn+OhX3/hnMYTXfkq?=
 =?us-ascii?Q?SLa/lErscLpb8IaYab3zfnTBtzdUnsJrprfbCJFzc0oHmKnGUsnfDHW0vogH?=
 =?us-ascii?Q?vvQf1sXf1nYCsqMLeoqe5aY2H2quLyHE06qE4d5amYo8kwI1zSwh9w6egfQX?=
 =?us-ascii?Q?Z35+iVgkDZ/EqUoKnxNcCE/Znjt3AWOLSZc3w+Wf6hkVOS8zGPbkE/IDCX25?=
 =?us-ascii?Q?RbjVM7qQnSgvIGIJ7inq2DaOuQgsyPPegN7KSGm1Clb1IXN81opwmvq1x/X4?=
 =?us-ascii?Q?Orp9QWfSsMlyRr38dIJEoyzSa+G4f2XYmz+gy1ssrRMJAPrQwaD/s5bjj/dW?=
 =?us-ascii?Q?HeV6dnIlobk7aA1RBKYYaOptofF5ybSxF6N1qiJ/p09qy1dE3eMDqYppOD7V?=
 =?us-ascii?Q?zyBO8SmQ5iRZQBRDoumal6NniyPxkkUQidF7d0pjhNJl8LLtVW50gLyhJHXq?=
 =?us-ascii?Q?g8rBIBiDNp3znx8sC8F/ef99V1DmFEjjfx+eeOFwU6TJ9gtLGgpUTQUyD94h?=
 =?us-ascii?Q?qO6RpCAJEvEL5vKfmTJnKqP1tl/x26Eu6CZN45PrzVB5QnEeBE6HnyB6aFYm?=
 =?us-ascii?Q?kQ5GeVylVjxloNlBItNIq4hsjMjr4/yH0Q+JGT4pt7SWVtS8b/QEbvIymYPq?=
 =?us-ascii?Q?biwSe/9B1xSBuAUIJUb+KfPeQFBGDPB57uWB7C8g82QYSzzP8LruYjvFVgKF?=
 =?us-ascii?Q?8/AT8ChVPHcdCaIuZ+uoRvySBy/QGdbF7HpT79aOeVdOAG6PxNirFaIlr03n?=
 =?us-ascii?Q?o57DoJS4sb6H0vy8Eq+MHTYJZgrs9a7ztz+RHkAh0rAiKAYoiYmh3liYhSS8?=
 =?us-ascii?Q?3vRwhlCce4jjZOS8rPXDr7e566InExX1pOlIC0fsOPKLlARRtw7dhkJoElAO?=
 =?us-ascii?Q?6z3fM85Jn3bgm4MOn/mrNUDQ9lWgnODlSavxrlFAFu7WT4JvNwtOuVzvkks2?=
 =?us-ascii?Q?amSgRg0ycUDNYpa6XN8hNoEwHfT7H8xY/5bgXyTQ3X3//iywT5AarB3FLNKC?=
 =?us-ascii?Q?8huhI1IW1W6WUQgBuHwQjH1UyZe5i+mDAk++070WkMwpCpjlCNb6ZxwR20ec?=
 =?us-ascii?Q?/7KL6yoYp/hO1AX93UPQU3efZUpZLx4hDb86FEGg56Nnldh/x8w3kY6Q2aQX?=
 =?us-ascii?Q?9Om4cSVz2Tg2O4AW56uygOn3PRkl9rViwhU16oMknXLztUvQ/+eqXqxlb2mA?=
 =?us-ascii?Q?5AiG2Z3v3yNsr/fW2Ec/dm/vXy6rXXPgmjFhfJ8HJ+PRy0Uliewvt/lRWkgr?=
 =?us-ascii?Q?m5avz38IJdB3QLa0ixOj8zWIfM8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(32650700017)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UwAOSn5oA04PnrGiehT4e2vFpSyfItY1QvrVkoiE0IES8vafYJO7aX9gbdBCa/cxj7iwQ+xPuJGUWBDI+VGvmEvpt35sMl4lb9StTOBqtCHQnq4YCJLLxsLm5DywwtvHgO13xKzvZ7Dx4CrpJFm7iNpUTPv3B+s1v531+O1rE00Hnz4iQPxS8xlGoKO7Cm7cp77g/VajUICo6UYc0uLReL1wuHKH+4BwcRLqrxtA/gGPCUOQfNXPGFqhgfEWNCJzrv30UQzr/zioFpsWyeYM7CaDFj+KcTTjbavJ3Ckav/3N2nsPsWgoMMfJ7RwC7c3m+c0Hi08sNhEFVy4O7hth3V2cgUgUWsz2FdGzwIaMdTtRBdkVpD0N5FXBSNsHXcjLVKl6+zp/EptVTro5cPqzaAwkdAESCoggqsCAaSvS3Fn2DOkaHjEeCFopjR9PxmbU
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 10:10:37.8697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a9f6f9-c4a2-46df-30f9-08de70684b90
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB8211

Configure Non-Transparent Bridge (NTB) components to build along with
J721E PCIe controller driver to add support for PCI NTB functionality
in TI SoCs.

NTB_NETDEV allows to setup a virtual ethernet interface over the
NTB Transport layer, enabling connected systems to communicate with
each other using standard network protocols and transfer data as
ethernet traffic over the link.

Signed-off-by: Aksh Garg <a-garg7@ti.com>
---
 drivers/pci/controller/cadence/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 9e651d545973..2da9d4ed3ed0 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -76,6 +76,10 @@ config PCI_J721E_HOST
 	depends on ARCH_K3 || COMPILE_TEST
 	depends on OF
 	select PCI_J721E
+	imply NTB
+	imply NTB_TRANSPORT
+	imply NTB_EPF
+	imply NTB_NETDEV
 	help
 	  Say Y here if you want to support the TI J721E PCIe platform
 	  controller in host mode. TI J721E PCIe controller uses Cadence PCIe
@@ -87,6 +91,7 @@ config PCI_J721E_EP
 	depends on OF
 	depends on PCI_ENDPOINT
 	select PCI_J721E
+	imply PCI_EPF_NTB
 	help
 	  Say Y here if you want to support the TI J721E PCIe platform
 	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
-- 
2.34.1

