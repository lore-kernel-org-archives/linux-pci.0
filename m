Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC9431D371;
	Tue,  3 Feb 2026 02:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087253; cv=fail; b=JwzaQ4ZWqfrbRF+yJmpEx+SxvmjLgDSyl4dMM9BNHCuz+rMm269mc4ubcc4HYsg5zrn9m1EOXb853Orck4TBezSi9j1Oz8bL9sTqSJmVJ+bcvqvfsjjmAmkelr7X/8qLxhpjxObBhzOT5iFM5u08MeSwTnl6n4Re0z75CdHnfDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087253; c=relaxed/simple;
	bh=2hiCegjab/Fy+TZMjKQ7QnoR5tNjvjdxySIXA1lKbjU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngY/Tppa8MYWvsbqkQ9XmnPpjEmMnbhwoOq6JbwZhVtkcgu4XTAxx4LlEiSVakS7zhfmHT3r6CQnJybtSbZ7kYIdtyKgGKEk5q1yGJPSkBW1BqJwlCj+M5D2xE9ZLJBViOzG2dZKCen9dgmGRMKdAEqhUd0xqw3Hgbrwd0JK2zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dBDit8G+; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dBDit8G+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWS3fsTuMcVjIQxuz3W9nE58JPW/SxUHY4I4iyOk6ikqthn1sqo+iCMigK7fyV+AC1nDh83AN+rpWsaJJcEZaucSlX00i2xekfDhgKAHnAjApJWQCcpKFiR/KwXzuvWThN4ynFr8oxOJFgxp8qfvYXJ0tdmRlAzfpxkSXAbkc8KXlw275L4CGQEuPY5v3uvy5rRhgtWM86ACmisokFpzx0KMHe0WdRkxvTWccDOCjlstooMhUo4XHi5VscD0HNxV8Oy5YVKTizaNvvDQO7fEzvONimS/R2QA8KlbKBaaAbRLLPhyHTvInDE4X4vKT8V2UFJpkZTM5DNdrhJ/ChWrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MywPOXciNFGosc7k7G4TIsxQn05mZJOw/uFpQLhhsv4=;
 b=n0avNiqnMvassj+PRDEvk5Ed6sJL13HhfqiYyA1nab+10TlZJJFfhR7haYshc/P3SnfG7QTbZi/y42b2WwiCUm0JgFCWc8eni1iNiK/ka784qwRSt1vZP55O9R1CR11jzvWMnwnp8+LleKwBHVT4lCe7eOLWwEDrAvtRuZkg5kzNyq0+pziBrlGhHNXJx+R+wxZCrS6sc7Iu3Uw/X2kf/NC2zVFk9wHtNUdaorexb4V+dcnVkKz5JjXPPl/quiFPGq2LlJr/WVdZA2S+FLi/E5QAaqkJBS0osBVTaBRtpKkf+7BD4mLuIuGNNoHT5OWXp0AgtrKxLTpMOqXC7BI98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MywPOXciNFGosc7k7G4TIsxQn05mZJOw/uFpQLhhsv4=;
 b=dBDit8G+sCKNQbrQlWEyawvbsxBwoN+LK6pXzKpF40+YxkU905qQFVW/myn2r0Snc6Vp9JKAxwBt7ck5o268E1YJXxW/VSIEenli36d4L4mtNBBx9EBYU2N0/Z4DgfcvHpxKxs9mq9fPc8ReUX5WZZx7dYVYASzZ6XWuunQTUXk=
Received: from BL1PR13CA0270.namprd13.prod.outlook.com (2603:10b6:208:2ba::35)
 by DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.8; Tue, 3 Feb 2026 02:54:07 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::89) by BL1PR13CA0270.outlook.office365.com
 (2603:10b6:208:2ba::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 02:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 02:54:07 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 20:54:06 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v15 6/9] cxl: Update error handlers to support CXL Port protocol errors
Date: Mon, 2 Feb 2026 20:52:41 -0600
Message-ID: <20260203025244.3093805-7-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203025244.3093805-1-terry.bowman@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|DS7PR12MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 529a5415-e53a-4924-970d-08de62cf7fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dcHF/YSWitDnvsEg6Pfb9iTZWmpqvYic1YU5e4DyXhMHrvFFh2awJK/QgPbR?=
 =?us-ascii?Q?0wA+rAPImW+B1DFmFkPt0Df5yp+aaFzPZ3SzJA41zVCwKPC00VcyVtZ9MC52?=
 =?us-ascii?Q?YSFarTn3bM+9BabeR7+uLuSv4KyYh/wg5+tt5Dk05NDgKJATRBw43zrpzLRN?=
 =?us-ascii?Q?kai3/FbmHo7vqQmdAAvc9gD+DSVtKtiZMiNLYFiJIBPTniuEW/XyoNiCo8ka?=
 =?us-ascii?Q?PJ1Gb87WE2Iu3H7QqK7Gr6zmuK2OC49iv2G03lDIF2eqX4Y145lURQM6/4Pc?=
 =?us-ascii?Q?NoEga+EWEX0JJO10yWjPHjTyQngPaHCfk6S+IrdrrqK9pVhOp31CDc9Q5H+j?=
 =?us-ascii?Q?7/lnEZ9tg1ge6UZ3tW6Dj52QsrzyP/Fr7C8Ts7SBgv3soK22SRZ7UKkxyulb?=
 =?us-ascii?Q?EUsaCxGyy5WVRVfJn81lSTmFQzPYucBsnrDX7VIRt2mQxDMGkQfAp4etrgmG?=
 =?us-ascii?Q?zungLadoHECbBdEM1Vda5e3vmPTRd+p7wGeia9w7qcmfVJYa+OfabDNcd73T?=
 =?us-ascii?Q?lkJU3UOUIKrQm4cpwc42cRg/Q6Ta3Qd5AuNIa5HHVbq1m45xBwGERqWSC/iN?=
 =?us-ascii?Q?N2viZpVwiUopkrYVy3JYAXV1782/P0JXLL+0anhIbTkmuVn4elWzoouT6sBW?=
 =?us-ascii?Q?Bku9DhFt4wfHpTEOdTci4qHeJWdZlHgBtLJbAkmQJVAznx8gayzxHkr4zNc/?=
 =?us-ascii?Q?9y/Bz/9Fxczr/+QR/pnTVbabi734o8p9SLH+tWTZyQYtu1ZEB+XFkMBq9lD9?=
 =?us-ascii?Q?hc4zopIkMCNdfjFn/uQyLPv1G1Ye8aTa0UhxDDA8SCl9cVTiCxiDQmMTT5n+?=
 =?us-ascii?Q?RGLQqc/fnpaxjpmGKehFRJttGDvyBu6T76K5pSTWk2rD+39lCzeaAg8hSx5A?=
 =?us-ascii?Q?7BxtdniNBWUeyA2OmKlxTR6pa9Hf6VCpmded2pnz+Hjw3v7+b7ZHKBwyoKO1?=
 =?us-ascii?Q?FdMgI+MpQPWfAYUE2M0XniPmD0OybOSmHXnpnzOrzme+0aYNRUvXb1NShlV7?=
 =?us-ascii?Q?kz4aFXQ7FifoaVAvJLezXzuaJenE/JFBgqhDm2A3dkkIZmC4hdaXuvUFsAOQ?=
 =?us-ascii?Q?Df+ZYqGQahnI4bRr6iF+66H2VUTYlxLgRRUOovsIw3oyUOGC/cHDFtkPV4/4?=
 =?us-ascii?Q?oQQ5z50XIrkpnmHlW+nmiW1ucRSk+OXrysid1CWiQ9B6ByqnKdtxsFLgVw9x?=
 =?us-ascii?Q?mR/ocYNVwTdDhg4Gt79+cgOd2ckphny3RN+DHOF/d3viyCEOgbmdJiTu9UUO?=
 =?us-ascii?Q?jAePMxmZfxdflCejsjWXf8b5yLJIRrzi7EO7EIPxxQCO0HTLdAqxR1WIzsIW?=
 =?us-ascii?Q?1ZZMxd3fQZ6poGqbqqoy47MuMQIelFRczU62y1ZHq3RbT+SVDAkCjJ13y297?=
 =?us-ascii?Q?wmeifRbQ4EKE16P/Unpv+B1H9sqfTMSCeNN3nHPxNbgBcPbTxNHmAww8i+D8?=
 =?us-ascii?Q?8lBrnQsKdGF6vjpIOgxDwKDh/KvCrNzIWaYMhnoAuH9+t4MdeCTyPmNf8Azr?=
 =?us-ascii?Q?aSaUnTV6UsrsbeKpqRavrdX0uXC82DDW/qfIFYhfAOQBqyLU/qruXT4Oli0u?=
 =?us-ascii?Q?Ojtu++fBcpEKZ5j2ZF47oRrU9cPvYfJabiL5Ih8LViy5QUHyodAkgAxpkUcR?=
 =?us-ascii?Q?Fh18OT4yu+G+/IaV1rqeiySZTt0WHu/soXsbV5eJDoTk5mMXaF1fIrbzZth9?=
 =?us-ascii?Q?LkLa0LezFCIjJWKJzZVVyy24N+U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LVt4aQWvJBl0g8wYcLRYVDowBja1ETtQkSQYMFuxKTrAxoLOo3XddwT3kza1BaoAXy07zirxJ5k0FhXaDBTym2PGfj4POr1T+Oynn4zyxxCZxRBRa4DzHrnDav3NS9+Vs2kP29oQ6kkMOdNzM+3BHGTCDiPBJ+AEv1VgkxDOev7Fn+7K2aAuQo1zcI58p/fN5pqgjj5Ktx5FHiYWYFYICVEmHB5soV0Wy55mz+qrEXXtw/vZAF/WULZUR8fxXJif0WelzXz9WkbgDmJjyQgUYrDyx2nWtLrPpUj6V0aDNZ5/7svTnBNBLd7+qKyDV/P5xrA3IODocNygVS8i3O9TcJWSDO2t3guKOMDvpA9NZLSmpN1wZ+DhLFyZVJoahbyfnyP0yY7X0mfRZShgSM/YwakFZAaHBUXoa9nPslXf6GP4WpDJJ92ocTzEmUQgAgRa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 02:54:07.3105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 529a5415-e53a-4924-970d-08de62cf7fb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216

CXL Protocol errors are logged for Endpoints in cxl_handle_ras() and
cxl_handle_cor_ras(). The same is missing for CXL Port devices. The CXL
Port logging function is already present but needs a call added from
the handlers.

Update cxl_handle_ras() and cxl_handle_cor_ras() to call the CXL Port
trace logging function.

Also, add log messages in the case 'ras_base' is NULL. And, add calls to
the existing CXL Port tracing in the same functions.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v14 -> v15:
- New commit
---
 drivers/cxl/core/core.h | 10 ++++++----
 drivers/cxl/core/ras.c  | 30 ++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 92aea110817d..3b232e991b12 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,7 @@
 
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
+#include <linux/pci.h>
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
@@ -155,7 +156,8 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
 #ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
-bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
+pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
+				void __iomem *ras_base);
 void cxl_handle_cor_ras(struct device *dev, u64 serial,
 			void __iomem *ras_base);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
@@ -168,10 +170,10 @@ static inline int cxl_ras_init(void)
 	return 0;
 }
 static inline void cxl_ras_exit(void) { }
-static inline bool cxl_handle_ras(struct device *dev, u64 serial,
-				  void __iomem *ras_base)
+static inline pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
+					      void __iomem *ras_base)
 {
-	return false;
+	return PCI_ERS_RESULT_NONE;
 }
 static inline void cxl_handle_cor_ras(struct device *dev, u64 serial,
 				      void __iomem *ras_base) { }
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 0216dafa6118..970ff3df442c 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -285,15 +285,22 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 	void __iomem *addr;
 	u32 status;
 
-	if (!ras_base)
+	if (!ras_base) {
+		pr_err_ratelimited("%s: CXL RAS registers aren't mapped\n",
+				   dev_name(dev));
 		return;
+	}
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
-		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
+		return;
+
+	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+	if (is_cxl_memdev(dev))
 		trace_cxl_aer_correctable_error(dev, status, serial);
-	}
+	else
+		trace_cxl_port_aer_correctable_error(dev, status);
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
@@ -317,15 +324,19 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
+pci_ers_result_t
+cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
 	u32 status;
 	u32 fe;
 
-	if (!ras_base)
+	if (!ras_base) {
+		pr_err_ratelimited("%s: CXL RAS registers aren't mapped\n",
+				   dev_name(dev));
 		return false;
+	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
@@ -344,10 +355,13 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
+	if (is_cxl_memdev(dev))
+		trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
+	else
+		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
-	return true;
+	return PCI_ERS_RESULT_PANIC;
 }
 
 static void cxl_port_cor_error_detected(struct device *dev)
-- 
2.34.1

