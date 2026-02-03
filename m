Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013000.outbound.protection.outlook.com [40.107.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE892F363E;
	Tue,  3 Feb 2026 02:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087288; cv=fail; b=a0X3uKPlWVFcsSlKiISTGZe2ylzXXSnWdTt/HFrOBTQj3SUR1PjsPhqwUXOL89vbqk+NEZBC11E4sgptkp2rClEOxygNT9A954vZp2dERnwt02HqvvE8JCw6sojn69sOFqG/abeZOsSXIveHWKDYoQxg5GiG7VNtpWs4BAJJH2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087288; c=relaxed/simple;
	bh=ehWfwrv+XRWNW7ko1wM+qihPDhwqrSneDSJdehhylyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVCu5BTmjDaQFn/YxJSQJT+k3l+qbGg/vmsYTwuDdQAMorUzG3A/9WCxsIp6ykMs5pJOTuOjzgAzAJHhHoiOpWGu9J+1pcqMEmFHevLhaEhBfz/DSKRMBuOeVdjN1xKuzQImOpelQsWfoxL0jD0NoOyOkXUX7QF0MH1ALtBuc9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DWZ0S5+E; arc=fail smtp.client-ip=40.107.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DWZ0S5+E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDtk1DvHGCsLM7TqqRpF/yt6DxjmZwN3aRX+EgFHjVZZ9S8hKA+yedsy5HMO5Ll0uSqxbaVK/L7n66YzyILLe8xB7rqE/iRgbHgzyLYWhi7tGhshfMOCOkRzp93AjL9ZpDP4wY4GchuPjUE2RpKWBk8RPTdadBbYSB2osllC0ltPRYYgvBOwY6ZB5JaHjJ5QZB+uy0sB6ZzgXYqCHRjfPqkf7fW/QvM3lbOjIr6/6IecGn71FGdQXq5b46sDh4RHTu+X/UTPCz4Rl73ZKCB4bu8WK/28Gj0n1t5u1K+2i8ZVObH6P19q3IhXj8H6TcpHrn7SFrOaXkVKB3NQXpYAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xo8RopOcWhXtmjAiGSKHa3D4vCp+0aSjsQ/0uTwWAVA=;
 b=ecWT4IsjWshoFs91xcpWhJ3uOj8eDpkorXxbUGW8XR861yxsBgEbyAy3T1Fnq/tBqZYrItp02xJlmeJqcgStE5UvYWYTIlZEnpmcVBudZMlDipb2O1yjoz5qME9NZw+8xQ7Z1S/ERGZFtN+Zu8trLELkNWhJDX3TBjvhGkX9iOY5U6cx1lhrL8PEl48EoUnOWaTZFRKyKNay+ZNiUXSTXC46GwSPXQ1pxmhds+JGQF9tRfw2uvObzIPsIHhD7gjnhF6+uAuguWftUwi2enKI/kb7fK20PQdVi5/lY6fGPM3DvOQLbx1aezYzcxvdz0nGL9uhp5ksn3vK6Q2jYwz/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo8RopOcWhXtmjAiGSKHa3D4vCp+0aSjsQ/0uTwWAVA=;
 b=DWZ0S5+EUm/feDEnrSicMbu731UaB8ye6E2QtXzc7EsDNvZsHWXNItewotNft4fLGPnn5sAge5WCCLnMotDdIju+WOtiHItIeVuqDDxLIsORCx4mHBXvyEvddL1LzqGYK0W8yTr3CwAulDT6JNW/+UIHbApEtOm3rumXAPwORZo=
Received: from MN2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:208:236::28)
 by SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 02:54:34 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::f9) by MN2PR05CA0059.outlook.office365.com
 (2603:10b6:208:236::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 02:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 02:54:34 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 20:54:33 -0600
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
Subject: [PATCH v15 8/9] cxl: Remove Endpoint AER correctable handler
Date: Mon, 2 Feb 2026 20:52:43 -0600
Message-ID: <20260203025244.3093805-9-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SJ0PR12MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f13fc39-bd52-4d26-5f50-08de62cf8ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o5RgVr0L8J4AGY3+iYcNpFtca0NG4FR3DV0rJC5ZbjcVE/9TWEKUh6NkDc9N?=
 =?us-ascii?Q?X2yp6EHar+42i2my33PijLDWffMHDlaCn0hLnPFpCOCpIa5U8chbknLal5CG?=
 =?us-ascii?Q?MEjfepCSh5LfBPEE794sbyzyvCJAoaFPrf8a/noUR4QEckcuLhhd8bJZA3Ds?=
 =?us-ascii?Q?SdNOaa6GOMc9HkRH5oGdK21VIF4GXUlMMuBFrMMcJllzs5W6xjpbGEt/YWMG?=
 =?us-ascii?Q?upwyTMA4HqT6tquRLZuVLKpKVB1A01VfRFrAS0uKu7vL+6YhIfWIyOBgU6Mx?=
 =?us-ascii?Q?Uop162ljWKDxu51CnsYNkBXHaqNxvGs2b3qpRIgPK637dg7wv7TEz9r4cx+w?=
 =?us-ascii?Q?fdCMmDHIocXvXjBlpxl7NqIVNB63SQA7CpfMWzCXCIlHWkfCFqFCjDH6Xf41?=
 =?us-ascii?Q?JPqR679IXgbiyWzj89zMMQOC1GzY49thvRoyO0O33h0XAGoN4lnN5vWPOGIU?=
 =?us-ascii?Q?2zMRTN53l1vwWxQtZ6qvKqcQOcOCyFOWln7NrFV5R6487kbiYGk4DD90MRVC?=
 =?us-ascii?Q?TAnBTC9MCXxCeROn/YXNzMh7N9viE91bXMC7tDT9egXgsZ4Aju5fujbvoiGe?=
 =?us-ascii?Q?GumWu53aKp5wyOCs7xdBuFac2U3l5vSN84mjBuyZ4vSJvtEtlye5tGf9UrAq?=
 =?us-ascii?Q?cWO9+Ozw+XszLDfVq/8my5dIOOa2CYKyfsorhMuXzHna3j0M/aGCmWU40gb2?=
 =?us-ascii?Q?WKCnpEFri46Cv0+p5cRmbi4nHumgKSIFjayyY9U4nKlkWbwdJBhmcNHeH+HF?=
 =?us-ascii?Q?bOJ598bSf6Nm+mYhWrI10JDI9ISIS0u9FUKgGkuRQ/Ql6hZDTrdMOkt3jBnF?=
 =?us-ascii?Q?CUQc4ZUnV/0ztgqHthz3icW/LlICs9DAMdoEF1+9nR027cPoYp6f8FlahHwn?=
 =?us-ascii?Q?d2loRehONcEPehSyHMo4BGuOJv0w3kQl7/6rfEWJnTdjPE3D9iLAJAUjLbWb?=
 =?us-ascii?Q?bDWutkPYXL3hRTew1Q84M4gx1MxdaHnoOyeDd3dfkz/UrLWPAwoBTr8XxAiN?=
 =?us-ascii?Q?dtLij0nhSRi9OZQHO005UEH+9qOtQflx/LtnL8cXPx17EZkNXxzeJVQtiyQk?=
 =?us-ascii?Q?yo2MzQC5deZfupoagRl5DFgxwczrt01sRpf1yweCZQ0Fuu+mapIMPYoDfScj?=
 =?us-ascii?Q?5vrlQpVA4o2xlGhEAX/pfe+Z9wSSlSbiRQhw9hTXYSvQNkY2FJ6VIpLlaZSl?=
 =?us-ascii?Q?XsDsDvTNglLnERqpxw5TgH3p7oXlfHD6HqPss7GFGaN0kbgWBB4f3yLCYV29?=
 =?us-ascii?Q?OXTv4X2Rp6WN08o3BOpMOgnSx2hZIZupss/zT5xBPCTtDOiRKDg8jxuofrf7?=
 =?us-ascii?Q?Sn33HWpcXp3fVbPYvX9fo39GZlDd2tazsE/3qo+ZEzbJ3NGHdBnO7oG4FAdf?=
 =?us-ascii?Q?m33eK7VapVrgGMSf4mKetlAAmXPXzn8ndHhHy70NTJLRHU4wIdTastYrX5LA?=
 =?us-ascii?Q?M86iVnTfJpcY1Fys5D0OCtSWxqe2akcwZO/SrWFnD2v3jo2QP3G67591AzvY?=
 =?us-ascii?Q?R1YNKwe8wrDDQ4jqF6S2MsmoYG+vZK/BF+kwwATOsw3P+0Zo0NyCNLVnAAlB?=
 =?us-ascii?Q?v4jcTGa99sn5Ftcq7Fc7biVkoZobmjYXX4YQIuZhtOrFHmwu68IVHkHDO0CO?=
 =?us-ascii?Q?548V4t6xpjFpI8gY3ogjTHJUwV366vht7v3PnvigSKT8r88gh2wTbKJR15o3?=
 =?us-ascii?Q?foxP519n8q/TFnN0eDcrFP5iV6w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZyhUCl6wvskCFN9DKxekCclgtPfv6GaTjzZQ3LyqGI29vFcRwVD4w7TodyJilLoFIZE4CAHLIkACTqNRGYkp+HEwMQybS+zPsrz5zQEKJRzYIBKJnFU8/jTJmQRwNwX1Tx1Gj5gQEL5yQ2liZmIskGKXlilKwmj2CSKoNjc9avDtmk+way/UpQNMEP5h8Xgf+PUO6jR3Gq9jxSsEyMZ8GNs6QmawNEc9m8iNwWRUZWs18YzMti605AZu4/piD0nuBQ7Cvvng+3iUMTBiIttBxdNCcKurYd/pWiQwRMYXSWhB/3ENbl7BBFa65RIPVPaLMiVmFVfFKHCUBh57r2CJZEY3jSgX++zaCKd+o+h324LBkbyFALhVbeHqGhtzF1PimelHCYyvQKulqCiH9k19RGkEUuHlkhGMbbm9FcyYK4kWm4Ew3Nt65OrUqh6v5aYy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 02:54:34.5669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f13fc39-bd52-4d26-5f50-08de62cf8ff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733

CXL drivers dont require a correctable PCI AER handler. Correctable AER
errors reported by CXL devices are logged and cleared in the AER driver.
This makes the correctable AER handler callback in the CXL driver
unnecessary.

Remove cxl_cor_error_detected() and drop the .cor_error_detected callback
from the CXL PCI error handlers.

This consolidates correctable error reporting under the CXL RAS infrastructure
and avoids redundant or conflicting logging with the AER driver.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v14->v15:
- Remove cxl_pci_cor_error_detected(). Is not needed. AER is logged
  in the AER driver. (Dan)
- Update commit message (Terry)

Changes in v13->v14:
- New commit
- Change cxl_cor_error_detected() parameter to &pdev->dev device from
  memdev device. (Terry)
- Updated commit message (Terry)
---
 drivers/cxl/core/ras.c | 23 -----------------------
 drivers/cxl/cxlpci.h   |  2 --
 drivers/cxl/pci.c      |  1 -
 3 files changed, 26 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 061e6aaec176..e5a0d0283d3f 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -418,29 +418,6 @@ static pci_ers_result_t cxl_port_error_detected(struct device *dev)
 	}
 }
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
-{
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlds->cxlmd->dev;
-
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return;
-		}
-
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial,
-				   cxlmd->endpoint->regs.ras);
-	}
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
-
 static bool cxl_handle_aer(struct pci_dev *pdev)
 {
 	struct aer_capability_regs aer;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 5534422b496c..e3388dffdd75 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -78,13 +78,11 @@ struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_RAS
-void cxl_cor_error_detected(struct pci_dev *pdev);
 void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
 pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 					pci_channel_state_t error);
 void devm_cxl_port_ras_setup(struct cxl_port *port);
 #else
-static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
 static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 						      pci_channel_state_t state)
 {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ff741adc7c7f..c6b2966f5fda 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1055,7 +1055,6 @@ static const struct pci_error_handlers pci_error_handlers = {
 	.error_detected	= cxl_pci_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
-	.cor_error_detected	= cxl_cor_error_detected,
 	.reset_done	= cxl_reset_done,
 };
 
-- 
2.34.1

