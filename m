Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647FE3911C6;
	Fri, 22 May 2026 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779427497; cv=fail; b=UZ/aI/BGaxuoOvdIkeyzRhuXMVjOh8NM7j1q2nI6BlVWAafWocsXYq/F/LBBNyvxZ8sTSPL5AgOqxu/4hrKZ9QTqcxnPbq9zzHTTR+uejvWr4oGDaGIrNrlOKrdBBpDzG+/PcoIkPHItqAHp+22YqiLMw25Mh/6bVM1jumyqPMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779427497; c=relaxed/simple;
	bh=rV+SL64WSibZCJuuv3r8Jss6QrFDZsPhRNVgqHO+Z8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzOsuTui/CYXN7hXYjXgsaEzTn0eUltzrUujrchL+KNv/0ECiYhZuL6ovkGv+ip2N6Y58JQXgoYi35ZEhLFHPQI/QwaYpZMF9yoIdRwmPgoIQ0OuhIrGE+r779LlmwRNHjNU68TW/nNv1G+fQTn/bLcbLcPfglPcJAj7o2XSSi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JSRtHAbC; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JSRtHAbC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fThYTNR8XISNthXebaREtYtIBwQLPtC4jDoKcAl4Y651yg0Hhzani5ZqbYHPeyjpVcuKuKNeicdwYMdgS380E3xubeaTHFzPo3au7IMhh9cN4by/jmgKty4NWsdzzoVN4hpnVaQ6fHRXuDcviVQIjCFMMCVIPWLgrB2LjjGBmPw8084hhfwpi9nIK8g2UgF9Y+csPZS2GrRaHvCVUzCPtllguOlPPVB821XOL2yyTh4wHvqziv3fp9UjCmPKQ/7RcARvivDwGQGF2W18BYOSOqn94S2Zvt+6ifL0eaRJj84SWK8zz7k1SqrCYpsGjMnGJa9cyy1sGhe8FGON6T9gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXIorvbTV1fc4KMOa02FLgl7HQom8FsxP0CttsJECtg=;
 b=ghwN8Cwa8fz4zR7zPvf3xBHTqyXkCU2s1EWkAAP2oyAME7yMuoa/ISgaljTsrYgNlmPMG7NHL4cP+AVVmKZW6KBfs6MSB8mvf4yrCOeBaWroacFk38BWb2F5/M4K7s4tnG3xbMnUJiGrSmQtOhG6rTegIRN1SrX/4576IQ/I5tMX+tm++DTkhZDiYGEWgHwWZVaRfH0m2pYKF7IMGNRhUZ3LIBnoviRVwnsxIr2Kr3cD+YWsnRmqFZjDBMEh9BykPJDFu8PG40CUiNef3cSfZ2W8j+O2v0I/D/27l+KNgQveyNL9unc9hA1YTtBujRMO0FvyZ5WXHZcx4IVX2b4K9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXIorvbTV1fc4KMOa02FLgl7HQom8FsxP0CttsJECtg=;
 b=JSRtHAbCsx4KLdpAawwbvqgJhXIi+jsyAZWA3sLaBujIXsSEDyP3rqRzcxpfaIwBl+a1MH+hRe39GgMB0xraf1OAADnOZ9bOk90XvGK6WL6ljA7qnloWMOBvNrPigigm7m2gLBzkc/cumMJZkntu+zAC/Cu7soBCFxECrf6EApk=
Received: from SJ0PR13CA0229.namprd13.prod.outlook.com (2603:10b6:a03:2c1::24)
 by CH3PR10MB6858.namprd10.prod.outlook.com (2603:10b6:610:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 05:24:50 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::7a) by SJ0PR13CA0229.outlook.office365.com
 (2603:10b6:a03:2c1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via Frontend Transport; Fri, 22
 May 2026 05:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 05:24:48 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 00:24:45 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 00:24:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 22 May 2026 00:24:45 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64M5OZpW1350956;
	Fri, 22 May 2026 00:24:40 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<mani@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
	<corbet@lwn.net>, <kishon@kernel.org>, <skhan@linuxfoundation.org>,
	<lukas@wunner.de>, <cassel@kernel.org>, <alistair@alistair23.me>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [PATCH v4 1/4] PCI/DOE: Move common definitions to the header file
Date: Fri, 22 May 2026 10:54:31 +0530
Message-ID: <20260522052434.802034-2-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522052434.802034-1-a-garg7@ti.com>
References: <20260522052434.802034-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|CH3PR10MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: bdedb1e2-5306-4020-a993-08deb7c27111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	l3nJmt+iYy/VWFVhZJ6F3VTR51CZf5HsFataHcH5PyCIGZTaLHEtk59Xqs9P4EDaK1mUdR4ADRfJikhBk/peENirO7q6mTyptaJvdnalh1HXz+/zO6kOS86PRw/Yq8NCoi678JIY6mqXVe5Ka/mTHBSL5kVMcuqez4Yd2yCz/MDPwqJ6K3Lqooa6TkF1EdUmimCcYM9e2nsOuXqEcaMysKscgqk0CA/fgwjaOLg8oiEea+RuVKCFV2mD2ovINjyo/RObkrjcbsm7vK2dsGI6u8sRXHxZl52Ph1H9g5Oby6hnaxpSYJ/rIwJKcPYD8MClN8CUA/3xMeUxRx8JqzI68tnmDGGg3OJtkPSe+Q9JcSqj0E17nVdCtfSnV4eR+ytix/0MNyxLsb1Ch6jyt7nTa0bCuvmu7NjgLKbGcRIlm/BW8aT5Rst0fpXtx2NdXDnarbvZUL4AbeAZq8qfUDSDafdkI1ZBfsRUAKtQXYnLgIhDhy4vvZ0+fNG4k5FwbHSOu6lZrK3CTQgaOvQP3wd6jvJQXJT38oIutempqF9yd6hHxlFlCIugdbNTSvx7C7WIX+yXkE6SrB0gb5pNSBSdgi1D++elruxWhajOovyscYvnUUnENY1cqPO9hFti8BKHauR6eXeFYUS7n46fr+5s/0KbURaXBwZbtSiklzfBJP+D+2wbpI4h+H17ecKJqK4r9fZ7KsyP/cNxxb3QMgQeoR0Tbr/h30DJz6JFl5SEzjPk65VL+lAwGCXVX1f/M89fEE2OPlHHDNPHAAt6vUF7rg8VbTJb24yqkhKXnnEzrYc=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SzX6PwM41fO8KlIx+VPgTDYOASLnO2FprBSAhzUjm50oUvhO/SsaixC6DTkF3PmtbS0fDif1WkLoJ33GPzzfTCZIqN4Eu7sdks6cy4gwvGmPPwspb3ED9kZPq+PTZRI5AVsySRyKR3Ex7E7JQUPW6TLvq0SXExffjJMzJ26eQLjuvEOrCnE38rhO+oByLUv/FPevrG5ZEnCu+q0m17UfqIXQyM0ng2Kr/CXe3ZI9xRYlkQb/m44pzQhEx2KYe6hbVjdrjRhCTnQ+t77FMGaooZxlMn1O3iEen1Y7qSNdGZleGlTWAMRWkf2aU3oPsQbw2YE0JAVdVOFeLjHthfjy6v1XT5J7iHS4W5qd+udHjp2v1cPRFbcWpTz+qBzSmA9uvdI+C/rOgXXxixuS74R95NUiMycBCzq/ssg6uHSrEjYsqdujIsx9EwQ1h57Eyk5A
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 05:24:48.0316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdedb1e2-5306-4020-a993-08deb7c27111
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6858

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

Changes from v3 to v4:
- None.

Changes from v2 to v3:
- Rebased on 7.1-rc1.

Changes since v1:
- Moved the common macros that need not be visible outside the PCI core
  to drivers/pci/pci.h instead to include/linux/pci-doe.h as suggested
  by Lukas Wunner
- Removed the redundant empty inlines guarded with CONFIG_PCI_DOE in
  include/linux/pci-doe.h.

v3: https://lore.kernel.org/all/20260427051725.223704-2-a-garg7@ti.com/
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

