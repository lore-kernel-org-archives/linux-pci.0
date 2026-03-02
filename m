Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BBF3AC246;
	Mon,  2 Mar 2026 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483900; cv=fail; b=jRuBw5uN7bgVb2X5sXHa8tk4Zx8GYsPs6QJhay/1q5+zJtiYRZF4gS6XQnKkQnf+Unq3RXz+gKnmdzUhOr+t6tBxFWo77hz1qmuMA87mGrkQixA0uOwHEATAdjtb0ObI/4zgdfgWdCd9ZpWTEVGemT7CycqPzJViAbM9DImb+zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483900; c=relaxed/simple;
	bh=F/ArOJdiMFOIF1waOWGCZArIYpWLdPwACPPvwHIm4Lw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRS6iKMouzL5a1wXv8yTdl2Jx8pRjFfEXW2FqkG622zDD5ozuPNd90NJBfAoAvOMEtHRMXYFfyXdXg/psgD1SS5T8L2z2vG6jDTJjniEnCUUMt7vM/qtuz0G11CaiiotgpzQmoEkotF44ttHALIMK3b6cY4DyLx5O8F6JK53KBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LRyxvdDe; arc=fail smtp.client-ip=52.101.48.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LRyxvdDe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGbiItt8mCNXrcXXbtyxl3KF2UVlHMPFAVKf9lXlb0asX2kzFUpM63SDf5tGNTRR2eWoMJuVEqXLJ8am4nIxbZmZNrCn0YgqwYt4XpCufwTBv/CrVl7jcCzpKtOD9FtfMhqSuwCXXBpxol1ed7+Ku4Rgdw8aLly1THyR2WVZ8U9bYMhgLL3vZE6r+QRc6g8K3DnvzXlIVJ2Wr5u9NJxDaar33Al3Bb6yHWBpfZn9NXbV3VvlzNdup/t/2q/6zoJQq9w6Jrh5x2GOkWfnwxUu/kBAD7Hx8SDd002M6PpuoP+TSPv97T+g/78emAxioeKJFA27i/McN2F+G2diRQoBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qE848hyq7hz3KmcacW+ylNm3E7kcV/etEwMLoXCMAI=;
 b=R4KOE6ce4dhdVvOPYql/mWp8GNbRLaXzGokQ+aWn+VS9VNJKixOhOOpEaafe65u268yy50PipKe6KG+DbeJeXDNuKOYTPAyFk1Wer0oq7Y9xnfpuN39cqhlTDKjPNNCzcFtoFIjCNN9A9mic4xj4ydsU97OKv+nUNvaQfrw2TFRHN9xHWCTGDAXhFTeR3bFh1movwGgLGqwN2UAzJIeHVnhHFrVOv4natMCPrmOgiOjbSkrWzJZbwiLkI4BpigH45YRa3Ay7WQKL66tllA8VhtEA0HgykXEUM08isPWAa+UX29WONVSJ7ZowRRyLbWgAtibrvfutNM8Pe0d+vGzIGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qE848hyq7hz3KmcacW+ylNm3E7kcV/etEwMLoXCMAI=;
 b=LRyxvdDePdKTVCq+tKns6s/DozgRhyElKOOjOTrcDPREl6oCzt+hCPNhp+NaptWswfOJYpe8AeOYwr2IZb91dmvphNDQsx/wA7EYd/wdLAhgwEauOZMg+oKI7/zDvzbsJVWDpF1+C6FGXgtMjiAz6iyN1Ou5I8/7bvQNbhYrwdw=
Received: from BN9PR03CA0481.namprd03.prod.outlook.com (2603:10b6:408:130::6)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 20:38:13 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::e2) by BN9PR03CA0481.outlook.office365.com
 (2603:10b6:408:130::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 20:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 20:38:12 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 14:38:11 -0600
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
Subject: [PATCH v16 07/10] cxl: Update error handlers to support CXL Port devices
Date: Mon, 2 Mar 2026 14:36:45 -0600
Message-ID: <20260302203648.2886956-8-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302203648.2886956-1-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: ea551f45-de42-4ac8-baa9-08de789b9f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	pucvuXZpMztPAPm2nANcdW5vRjS/QqIjf3DFnh9s81T2ZnQAAWqO/UgsThLmVful4TFlUzUdYEoyoLBmmiYo52vtrXsxqTY9XQk7FmLCkPEwQLOBc4NfWvG33wrMoeaZw29g5m/qWv3l/SOGzxc6T21GKFqUB3yJ7KQk+NHANjxhTV6R7OUoTSiBAfNGctLJ84hYyGN/eJwJI2eHRSgEVzg6v5ZvcCdCtzknRwrwi2ATB65v1uNqx5Wte/sARotv6d8MPqqhBpAr78diR6bb5fZmSHY+xwMQ2kDsPBFvt4CSWPrbI2duVuVKo0xAONJCjSkVbZIFmMVtuVYHbtjqOYPkvSPqAbSDIDVf1USgkgE71kdOi2CJJF61rbSAOA3h6d76P0HD23YCPBaRH7qX8l8Cuygcs0cvS3k6FOVX08PdYnwykcOT4ujXI+m0FKFuB6W0MqexQ3x7bYvndMCoK15tiJkzE04yYa1s8YuMKI24EZyNkA5yyMwDj/7AWJTzhr6bl9hoTXSKcKwFhQOyNevkKp2NDomc2HBOsho863+cBTXVylgvXyVPcnkg5J/S6hGGjh3gTDVSpMJtS6glA361KY7GcVDQfyotwQYq4pLSVGIojyKsF1NI9zAYwzfOY+4pgzWTnoJ9F94wic33GpPcHUfFQxVuzv2ECHc/TJgLW5lT4LXBHoxMMG80q8Fm5maAFb1tg+LpsW+GvuEXk75Zyle6CDLRRHQ507qLByQZyzhft0AKktFVXVUhXcfwkDGTTM9SFrjHhhU13jZxR7JtC6z9OnO/NVL3yPof5SwD1Zna8s9B3SOHp3R8sKDhBG56SHaPydaVBfDWEO4l1sy2Tt/1FJqZhIy7AIGYVBk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vW1K1NUxjz0TjVvS3DL+9omUVcov0QvMYrFP+waXfiL8/SCACjNXS2VLf0FA6Azc8qXasGztgDmsvSpQcYZVOWObniDPXUSYcoIh9Xw/J8DOIJgOWDr3jPKngFvtG0P7gzJYWVRaFhHRw+AIqvZizVSSN0V1xr2qRAuEWkf1YWzaIiuXfRKcagS9y71h1Xm6SiJAC+6ifTfGypMgH7ogilO2gsta9T0baEU8SOKo3nxMj+KidNrpKI2rKNVqIZ43FE/iqOryaZ9bStOmNJzAZJDUMMa1xk1VwnpO3nbcN8lINvi9pvcpe5hKMk9/Ywl7+yPHqmQKMYYfoxfVzYlqoFBYlmMX2LFXFXYslFTnfuGGOalnVx0Ovc1nQWzGPnFbJz3cM00+CHbik9bNnqrzEmdRNy8GxVoGxrn/GTW6nTiEhWORNx+nvq6cds8et65c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:38:12.0938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea551f45-de42-4ac8-baa9-08de789b9f51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

CXL Protocol trace logging is called for Endpoints in cxl_handle_ras() and
cxl_handle_cor_ras(). Trace logging support for CXL Port devices is missing.

CXL Endpoint trace logging utilizes a separate trace routine than CXL Port
device handling. Using is_cxl_memdev(), determine if the device is a CXL EP
or one of the CXL Port devices.

Update cxl_handle_ras() and cxl_handle_cor_ras() to call the CXL Port trace
logging function. Change cxl_handle_ras() return values to be pci_ers_result_t
type.

Check for invalid ras_base and add log messages if NULL.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v15 -> v16:
- New commit
---
 drivers/cxl/core/core.h | 10 ++++++----
 drivers/cxl/core/ras.c  | 36 +++++++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 76d2593e68c6..984cc37be186 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,7 @@
 
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
+#include <linux/pci.h>
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
@@ -181,7 +182,8 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
 #ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
-bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
+pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
+				void __iomem *ras_base);
 void cxl_handle_cor_ras(struct device *dev, u64 serial,
 			void __iomem *ras_base);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
@@ -195,10 +197,10 @@ static inline int cxl_ras_init(void)
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
index 48d3ef7cbb92..254144d19764 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -291,15 +291,22 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
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
@@ -321,22 +328,26 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
 
 /*
  * Log the state of the RAS status registers and prepare them to log the
- * next error status. Return 1 if reset needed.
+ * next error status. Return PCI_ERS_RESULT_PANIC if reset needed.
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
-		return false;
+	if (!ras_base) {
+		pr_err_ratelimited("%s: CXL RAS registers aren't mapped\n",
+				   dev_name(dev));
+		return PCI_ERS_RESULT_NONE;
+	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
 	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
-		return false;
+		return PCI_ERS_RESULT_NONE;
 
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
@@ -350,10 +361,13 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
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
 
 void cxl_cor_error_detected(struct pci_dev *pdev)
-- 
2.34.1

