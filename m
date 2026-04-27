Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D3149C6F;
	Mon, 27 Apr 2026 05:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777267063; cv=fail; b=DdO1iDS+++WhA2S2O8yE3S9trRvcMQeNzzi5Ucjzwu35CXs/GoOYDpxJ54YzY8W1DRrCvYOnL8Hum26JAclYMGNFJfQcupDouFzV79vsFCJEwnfQ188JMxwta04ml/J3sWvMDt+P2A9DPPicpe4DhRuB20zpYxJfrDZCCksfP14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777267063; c=relaxed/simple;
	bh=DNpGM0Q1KRWYc03yomhj3EM8Obra63M07Sdz74FFkWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsYe6VwQ2ltjhle8DfRJUYLRwZi3nBJamAZqv8qL5EY3or1wHtZNqcdo50K29y0xOIcn6Gc2IlFzU3V91oAGhat8pqPyBWkQDf2N93d5VfCwa3ThxLpdpr4zn2Yv8cKoB5CbGPUHW6mrS/DAgb3KeZ+36217Rejnk6IQQDMUPd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a5+tcBxP; arc=fail smtp.client-ip=52.101.56.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a5+tcBxP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9noDiXgzXdchEBEtH/w3Yh3wqzKogc0W38iVvQyDyeMkUP2zNgGc9H2zK7Mw6NhbWBp0qn5bagk28tNKP1z5ygIh1MYhhCRBlsLbSBCU5LnY1Ai0sd3iQf3Ns5/BkYR4NTDWOVmSs8C/OBFpyUGAckoajLVuNX/j8+Fbftz1ZNkV2x4t9w6QxED3Ya+hVPxbedmh0suJaZoSt521Xq3XLC1tcaHUi9GH2G5ugZ3JEg3S5y+uyA0yUmjRg9zCeTbuviwG2ejrzsYLsAHviKJDsZXZDWC49s6Re9O2U/rjPiME3sI2A2uFv/3e8xh7O1ArHFEWwFDObNVgxgd6EQoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTMNjOPVTi0X49a5yAsXYHT4jx4G0soPi8Tzw5XdXOY=;
 b=smhz24l04u5tzkwWcXainn1xHonvGZsG5onzNF1k1W/cy7hhfmKNftjxcwdgYymQVXniapEA9eZnkwTJf803r1nc9sXTzCKWlGGUi+jJly7VvyvqneT8qLx8PIaAiAeh9qa8W5RMoJM+zW0KalqDPLeOI/YYHJSPc6UaBRABpBYdwGQzom0XRlUfiHVGJBgv1NmzKChpl89W2G2j1QzyelDVB7BCXaeAMpouqDgRm/fE4CnxMlXtSBGcGgIMpNsfvOTAS+4ZSh3gCnNmQ0O+a1GEdxAUemRv9JcH2CYFR9RGdwPFVlDW2gN06SUAmfgcD4PH/2b11Tew8oyjnqqJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTMNjOPVTi0X49a5yAsXYHT4jx4G0soPi8Tzw5XdXOY=;
 b=a5+tcBxPAI5gwfO+4J7bez48/0FeJxolHxPT5vEcaSr1PLv8jOZQc9dJAR9q4MwGkOKa4FVV7NhA6bzZEBLfcDu4N6gmmBp9Wh+WO37fqo66LAI6AH5EBeRiQFifL4mZLrssP9dKd2eiKI/x0xYiTxijNuw+8e7YaoDkmnKTZ4A=
Received: from BLAPR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:32b::6)
 by DM4PR10MB7451.namprd10.prod.outlook.com (2603:10b6:8:18e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 05:17:37 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::eb) by BLAPR03CA0001.outlook.office365.com
 (2603:10b6:208:32b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 05:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 05:17:37 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 00:17:36 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 00:17:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Apr 2026 00:17:36 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63R5HQUo2543740;
	Mon, 27 Apr 2026 00:17:32 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<mani@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
	<corbet@lwn.net>, <kishon@kernel.org>, <skhan@linuxfoundation.org>,
	<lukas@wunner.de>, <cassel@kernel.org>, <alistair@alistair23.me>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [PATCH v3 1/4] PCI/DOE: Move common definitions to the header file
Date: Mon, 27 Apr 2026 10:47:22 +0530
Message-ID: <20260427051725.223704-2-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427051725.223704-1-a-garg7@ti.com>
References: <20260427051725.223704-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DM4PR10MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: d71eee4e-fb87-469c-1dbd-08dea41c4c05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	idmqcuxh3wxiFtGgnWSR7zs1rRN7v8ENQfbhR/XAccaSlKEbkA14WBvsw2UgAvUMvj0T17TO4ndVBi2l1fUJnutPAobexokwJtm9gwbVii0fmaF4jMTjVb7/JgUWkViUZViMmgKurAnZDwHIywI+901r8Tt6naEUe7jDc/3El7SccZ2ApiF0yLdp3JUJo9DPhTVkC85qnw+rPbmAAr6s0USsd1KdJsAmL0YpZDFRE7JtpV39xwQrsMiO03xsOptmtyJdLSDlcPbtDnXuykTa+XER+6gdZttI4QoHZ3E1YbzHEFMxB0D9OAmLSiHk/EFKnZFSN+qVa8NVq5iHIGazBttddOpmOfzJp79ksRX6/0J83Z20AX/k38OkTTb4dIxUsjB4S9qkZKZwCX88NHE5980qOswa+Kto0lecgRk2Bg/3UwhBBgFvfrEIpn+5xwxzYEcRqedGLZVl7JvtscXIVpFU7R1LR2yrnC0Er36vrOO5pOunk05hiCsCCvZk8CGyzXeF+vnT3qa/6x2HE/HDRYn1fMkYxnlj6u0gKYF4CSks5P97HSmR1vWgHYnisDmwmOHxMtSDCDIG4Dqf4LBSHYIdoMD0B8XgRwPbdWocSkem39w1GJhT3fx/QqnTwelvqEK401Z00iF/a8F8OOx6UIuF+BOH+Ghja3yb6TYw11GkT+VVLOWhXb83owFj6rm4FStLwJAKtt5J2mLridHm5tPYh9XG5ztxhxApa2hLBtPzhyDOiuJhK1SdrZPEhouGzZqrpMCVzs63V4wLlx/4qKaPqKrj2+BGUHwW0ZglLeO0T761x3sE+go4eAEES97q2Qs/iECbAvTVMuX73GZFUg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dvCfMHhi32JB0EfjnrQ2RLLWOJCtREbULRJ4jkjWS5pWA9v+R2SsRMqPzAINOdQCvbC2KHX6VPnp290IeJ2u6aN3hlNQAr8Tz61Lk0EFL9+SxnqbA8Gz0uXtrzvozfcK887svPkNrPpoMTBpuqSNCnNJyYtIVXYFvXoaiqZAV6+pIN+LBlnpl6GwA0xIyXA/lSp0Ncr+SpkdKB94O0mSpE4HzQB4oDWN0lap79C/AIZwiyVMrMvBe+Yn3eBHfQKYb6U/LwB6jbE7c2fiOgjifQ9Zq3cx4f7CxHXhSUQ9pyQMPKx0YZgdRls/dvNCQWvT6NHl0/8dx+DlI91QNvW34vkuep0HcUpXnAN/Dbm9TAtIjZYJmE7OKx89Dhdofilf5Y6PyzJIlRrYg+PuRG+8qaVRq6Oh6MZDtOQ5naCR2hjlbky2tYIk5SnyXpONKFnb
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 05:17:37.3434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d71eee4e-fb87-469c-1dbd-08dea41c4c05
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7451

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

Changes from v2 to v3:
- Rebased on 7.1-rc1.

Changes since v1:
- Moved the common macros that need not be visible outside the PCI core
  to drivers/pci/pci.h instead to include/linux/pci-doe.h as suggested
  by Lukas Wunner
- Removed the redundant empty inlines guarded with CONFIG_PCI_DOE in
  include/linux/pci-doe.h.

v2: https://lore.kernel.org/all/20260401073022.215805-2-a-garg7@ti.com/
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
index 4a14f88e543a..5844deee2b5f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -683,6 +683,15 @@ struct pci_sriov {
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

