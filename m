Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06009345EA9;
	Mon,  3 Aug 2026 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795598; cv=fail; b=hUcmAAblgs+7Z2jAkndjpHPbCF5LQNFNvA1kY5q53Qv0r4Qvy3W0lWxdgoZ6h8W7sVU+hpAycLuy2/HzLIjD5GE6y0gNiKxi2ZJ+/6g9GVxPtpe1303+KOjqcAPLC2kz4m1PDiFXxLlQ4aDXCoWRve+mAm0th3puMPXKHWUahlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795598; c=relaxed/simple;
	bh=sl3fZPvc5tLncgJwSCd1c4BvGxHqcqGFRyZcDbwB/2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Su+PQkkwnnMFDmZj+nqZx7GxUuqSl6Nwpn6hCarzIvtRXR4np+cn7/318Q55pMMF2kNIeoIWXM7Eo3ajCPV7+I0NULPsXaWUr3F6k1TA92SRkGiw/oNNEJJwTmmQdui340pFR473Xoz+mXeQprokZqIezMNEzXYGhInnrM+/zbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dYPGO99G; arc=fail smtp.client-ip=52.101.48.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dYPGO99G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZjA+7h+5SUdvk0m+kPAoD8DsBfSfN+WHV8JQY99n7N0v5Xapu7CbgrxK4v9Ua9DXg3vij+TLWpiG/2M9Dd1hvJ1ludkog2RYJsXAy2CV33kgCsT7Gcm/yhkBvEe/HkZF4/fSXJ9Cx1N1XlUjmDARHMemFmb6VQc9DIkvjk+hFBDlagrLUeV/nE+DiCybvAiwRLtXzNcpBJs+AnYMegNUX8kX5kQDgANVffOxXuBQfGYhnpUhVDzT05mbS6jWpopm38OpkHiIGcqOFWr3lPRYntyYt3Z/HQFPNSYgj2oOXYlBZa2s0QION4SG4lSt6RXOmRF/7H58mVNiz7giV6lxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SHE0SQHRmaKQr4DcOzRnPrU3/EYrACNQYpECMUJ46Y=;
 b=htEfZmCrFS7YIi/TCM0tHF1TLI4Z1Czx0va7qjtPTKvQCBxB87qDRr0XWmxVpp3/7dgWvt8GJ6OU9aOPpqD+k2wDLBnHQh7AXqyhyfybWdVNOIrLaHhl2p9Y/qMZOKNrO7pnoCgKkdrW7NcAacPHb3NAYLckOHw5sVRTJwYhqUPEplMLU9+VQEH/Y84PnQ7MUhk2/Z8bCbH/hMoA0T9+ROMyGVXBmdVqufeWxWdkw8Zd0nlnv0rGvrYPbyaMHO7+rEkfVfFJ2npgtB2T2oC8tOu8vwlKt/0lpvmvTl2rnyfgNhtWXPioYoE4B2l1N4E9Z/abFcX+vRtlGxVIXIqRiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SHE0SQHRmaKQr4DcOzRnPrU3/EYrACNQYpECMUJ46Y=;
 b=dYPGO99GtamF1WZCjhTDf0hpYqGV2r5R0ZlT3UKI/3oeFVKk9E+BUZXuINy52fbwnC++Vjgsvqy78hruFgKji1reF3Q59AkijY5OtebPBhsbeeDqNBOktp1VRBEdLdKV19gYFSzUdUGQIvt7cIenTZy2DZSx8PQlGI6aVmmH3Do=
Received: from BL1PR13CA0135.namprd13.prod.outlook.com (2603:10b6:208:2bb::20)
 by PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 22:19:46 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::15) by BL1PR13CA0135.outlook.office365.com
 (2603:10b6:208:2bb::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.14 via Frontend Transport; Mon, 3
 Aug 2026 22:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 22:19:46 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 17:19:45 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, <linux-cxl@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun
 Guo" <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v19 08/14] cxl/ras: Handle RCH correctable and uncorrectable errors in one pass
Date: Mon, 3 Aug 2026 17:18:04 -0500
Message-ID: <20260803221810.3685703-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803221810.3685703-1-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH0PR12MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: e3741efa-2584-4635-9888-08def1ad5383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UQ2gau737abPIidW/w28OJsLu8xklPh6CHHoTSzk6JQlVtZq1KH8yF2PWJcpKyB75WPUQpX3oJbO2/nBVET23xQyFTaonWM9JwJUT0kY1tg6ECAjcOoaoSG8L8nwbxF2o9LTHNAvAZy/eupkqd77OpTrGIPQ5krLE6kIOhwTu4arwfWYBeEsFAMgbkezbQg0BT3bdDwVqtpnfjjFGhh3OXFYr4aH38/jMMl2kgT1UL2kUXzrifoj/wTEKXY4rhackTVPeCBHJKW9zxSD1ntaaP62X4fbtLJg7eSZSP7dnYt3Ag06fEN9z6OpaDQ0JE4vE7G6UHBsd2YjpkR8efImt9eS1kTz1PkFfPbdIsgc/BnbhFx5aeju2r52XDcz5HFbRuZeh9/yVshiU0s1mnvT+iYpFW/qVxVWcUROZFgdeLNacrdTYSICyvS2dxBZmPm+Yvs3xi3EKHuD7LcRjgRPe/RashwuHV5yCEbosBwYOOPsgUInTsHE98dGjOsSqLXylp+1wzYg+zvDNxSWP4rL6GdJEaP3pvBol0rZpkLO12laNaIMPTa5XTJ081mpS6Bu/Ag5pu7rrYqtVb+m3BcwpLB9Ru/qzjQwI6MMtxqn1W9PHQM9+V9GoX/nMiX4DpmtBJ/9dCmEXeGTEHhGY5UGNRoGy09OnmNCBtKpbIoqcbr6ouVGkeyrknUYw9IfFXrw305hfAoi0GNs8DHj73x/8Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bIE2bXHX911dy6CfYUkfVWER3Uc1xnPk9OG4E1sElsUJ6wFEggRtFNG+b0087+cvrkUBm5G5PiIUw5USz7d59NYxkRZieeeMf0pqo8Itc88lTIAbi+J9ISgJ1F9xZxBPQUOBdGbY5Fo+lVEsSJL0O8K/erGqmrKuxmAiqC8/4oMvJpcIrthD+bbr3eWnMR/ykVVHA3DKh9tR9EBlwbDqcNc6/dgdAAsesEHb6R0ArNAl2PqngXEE9scbknOSraJDR3uk9pwXFue9TGVPpfyzdNPJ7nBjH2G08jlVvXB3LomPxC+deKUHJi24qp2DTTecdXIT1BfpR/v0yoHUWKpY9vrKj5BHMuvUFylJTswftowOrNbLxPwa1sbLxJEgcno9lUsf6f+4flTLfDDW2XR7A7R/pYSKbzc51YhuwoxxFa18POD7XLiIiNhmYRlfIICM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 22:19:46.5461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3741efa-2584-4635-9888-08def1ad5383
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7093

cxl_rch_get_aer_info() reads and clears both the correctable and
uncorrectable AER status registers in a single pass. The previous
severity decode returned after the first matching class, so when a
correctable and an uncorrectable error were logged simultaneously the
correctable event was cleared in hardware but never traced or handled.

Handle both classes independently: dispatch cxl_handle_cor_ras() when
correctable status is set and cxl_do_recovery() when uncorrectable
status is set. Remove the now-unused cxl_rch_get_aer_severity() helper
and decode the uncorrectable severity inline.

Reported-by: Sashiko <sashiko@linuxfoundation.org>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v18 -> v19:
- New patch to process correctable and uncorrectable RCH errors in the
  same call so a co-logged correctable event is not lost.
---
 drivers/cxl/core/ras_rch.c | 42 ++++++++++++++------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 41959c0333711..6f95542e2e6a7 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -89,31 +89,10 @@ static bool cxl_rch_get_aer_info(void __iomem *aer_base,
 	return true;
 }
 
-/* Get AER severity. Return false if there is no error. */
-static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
-				     int *severity)
-{
-	u32 uncor_status = aer_regs->uncor_status & ~aer_regs->uncor_mask;
-
-	if (uncor_status) {
-		*severity = (uncor_status & aer_regs->uncor_severity) ?
-			     AER_FATAL : AER_NONFATAL;
-		return true;
-	}
-
-	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
-		*severity = AER_CORRECTABLE;
-		return true;
-	}
-
-	return false;
-}
-
 void cxl_handle_rdport_errors(struct pci_dev *pdev)
 {
 	struct aer_capability_regs aer_regs;
 	struct cxl_dport *dport;
-	int severity;
 
 	struct cxl_port *port __free(put_cxl_port) = cxl_pci_find_port(pdev, NULL);
 	if (!port)
@@ -127,12 +106,21 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
 	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
 		return;
 
-	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
-		return;
+	/*
+	 * Handle correctable and uncorrectable errors independently; both
+	 * may be set in the same pass and cxl_rch_get_aer_info() has already
+	 * cleared both status registers.
+	 */
+	if (aer_regs.cor_status & ~aer_regs.cor_mask) {
+		pci_print_aer(pdev, AER_CORRECTABLE, &aer_regs);
+		cxl_handle_cor_ras(dport->dport_dev, to_ras_base(port, dport));
+	}
+
+	if (aer_regs.uncor_status & ~aer_regs.uncor_mask) {
+		int severity = (aer_regs.uncor_status & aer_regs.uncor_severity) ?
+			       AER_FATAL : AER_NONFATAL;
 
-	pci_print_aer(pdev, severity, &aer_regs);
-	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(&pdev->dev, to_ras_base(port, dport));
-	else
+		pci_print_aer(pdev, severity, &aer_regs);
 		cxl_do_recovery(pdev, dport->port, dport);
+	}
 }
-- 
2.34.1

