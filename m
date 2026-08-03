Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957B34888F;
	Mon,  3 Aug 2026 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795528; cv=fail; b=rHBeM+IHVx4vn01Xw1GWeXVOq8jTE4woWIC0MmAjqbHMAYtPJqjA8eSbCk8iUh2doFICYHJwjUKQkOQk+DxoBPj2RH/mEA+cHK0VljWOFLB3+usZKUHDO9tTVzYSNr9uBUXo9zi45qGa+DYnQ1R0QTo6p3ZjuV7ir/zw6c/za3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795528; c=relaxed/simple;
	bh=Bf8cwhPejchDqNOlPr4gJtgh82B3TeZ7nN5giyKH/3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTRoFe1qLsv5VMnXzBaviE/C4pwC6HmZm+sh+5pm3igmxi/ntjTvwEVeWqMRYl/IbjqPrFDFps3HOQjldXdWrLv0TUEN7LeU90NwMmOmpcx4Qd/qSvVOEvJ60frOwLqF9ANZhKtVAE+IiZj27vde9AZvg970e0McljbDbvf2FUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5A3Ag0ze; arc=fail smtp.client-ip=52.101.46.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5A3Ag0ze"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3ds0DDDZIqBP7r57iStHdmaMbnLkhpWxiXzIoK+kyoirkctOBG2OdZpWFc4CTAjQpPGaoumkVvVNCtdZDaNJ9UBD8yM8oAf49Ez7JmMLOucpGfvrHx0oizm/5JRZ2GkxI3l3BipNPEbf4nhX3HBONgTZQHdQp1BPM+06cwOOqsFecFvzrC7560ZmlFfHmrPJUXA0u97MX0OYJHU/QFIyGNrKC0Z3d9BB406omXE7dqhSl2E1i+T6vWJKsl0h7UXXxPTUdBrfnw0jsYldTXzC/u4e/43cQaGUPp8nXgPsSWJSdAXUKLByfXbO46MYbNgtKqOjdzDsBpzaKE/ZzIn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSF3Vj9I34YMCvoYuP7qLraUYTFFp9PMX3WLEw+L9YA=;
 b=XXLhHntWryMDFv8TcjxVINPFSGNk1IUgPIMIQ+y+xlgWMrFshiV9B1MtPXsEkekopF0+qw7PRWF7CERqoxDGqOVz1PbZONKiKXV2HuhLpU7x7a8J9KwzjWRxreVqGM+6pOoZ1iWmXDpcNqqFBRWZu6vF//DihlyLRrkiqTlVYWHaBIDsKtQ8Yy0aej+5c4vDRnnfUREJvmhCTGpkrxRBLGhVQeMLjM145FUJMXKIJztFeuLJ0ic3+QbgvMP2wZzxLibuLtzLkiF/XJAaGcY2gRIi46cV+8CC/hoMStzepxLJuJnMm1gCItVulZ8l13hkWCmUJAVKHMiXC+1Ku1MCXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSF3Vj9I34YMCvoYuP7qLraUYTFFp9PMX3WLEw+L9YA=;
 b=5A3Ag0zeyibMgSnDMhrGqLHV//NfQzJz2TLJNKFRD/pDCCPF/1sCizyOnz7Qg6gKz0Tb+SQ3n/AvnUGIgYJ/J5A3HeUJyWC6dSltZETVGEodCLXk8y0M0FuI8M2p//rehpJlU5e21vfo30E3kxzpDmSdSGsRmDsvoHn83yW5kJQ=
Received: from DM6PR03CA0090.namprd03.prod.outlook.com (2603:10b6:5:333::23)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 22:18:41 +0000
Received: from DM2PEPF00003FC2.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::19) by DM6PR03CA0090.outlook.office365.com
 (2603:10b6:5:333::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 22:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC2.mail.protection.outlook.com (10.167.23.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 22:18:39 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 17:18:38 -0500
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
Subject: [PATCH v19 02/14] cxl/ras: Fix cxl_rch_get_aer_severity() wrong severity register
Date: Mon, 3 Aug 2026 17:17:58 -0500
Message-ID: <20260803221810.3685703-3-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC2:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e12b9aa-f530-4701-524d-08def1ad2b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iCuS/Oc5IajOOUOVUeNoytXMZAohhhVOOysAFiIOFvOf/eykcyU6oCS3JEVkvuYL0jriclI4YeoYhZrQwF+NxcUHCfDW4N90eBgemIKJ2qCFWhUokdtUB4/YLmjSVVg+2og+JgzxPtqLJD2605WwniDZp/RqdXnyDfgCsNosUUNtuLxACEF8aknJy77qHZHSBGuqPW8NO1UXZFXn8wh7CPOWVZWX62pHyDmJi6UIIIYut8dCvyM7nWSNAV0Nai5lyhrq8VQOFnK3LnExQ8u/+cX6ELZubonZVxNE7nS/nVI9H90evHgYj21PFbTWac/5306spiBq0u3uJ4ZpXh7RAFpE1AAc917+ac/UuklJmfwnB7JPi1ZFn7a1awHvew7b6ArTwstbbByinGCudaxlCyZoRGH2IXaMHKgHBPLYlHYhHYXfCB3XAW1JxaZZHrzfOG0MC8bN6SXanQR+6wvmXOiH4aVB2cLQjtIzNCNd4JrDxfdxSnDB8p6ro9LTC7K4AhTRceY5DFTCw1PzNUD6u3BvzrwFVIPW4MxdJ/bGGkitCm8qAtv04KcZc/G4hIGc++HwYH7/hl0vfsMBo8/cOJbSO81vaUzWqyVvwo/cSSlLo4ayTm5N5cwq+0Fstj/4ZrGxwWAGzv5mzFcBfN7dB09ZCr2BYcsjpzb5GFXaYRo4Acq6eRldf6/CMJV2jFawi4kf7XoxdDqudmd8kKymsA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KY5lMQoOu/OESrH6GM89YL2oEL/C0CVV5X424MnqA1dz8054sgx/yCxE5TWSHwcyFKfTHV6sarLxfCT3Sm4JppBiirotZZNd6gn4orxc9f180E2I4gqu+MW6Ut20G+wWGEFayV1AYTZuHvjjDBoyI86r25AY5SCEzsDpqRKbw++7v/SMhrA5Q1DOyuTgkVJ1xeifTWQSQ3CNZgJjeNixt4Hwfi9Z2ErVMVbzRS3Nyb41XDpIw0bj1Sy0JFmgjDbcbfVs2wbtsAcEYJaTsRPPPywX3y2ze9K4S5mBWY2DTFO/WtzMM0/YCTOSeMX/cxOLIzjbJW5jvxlI26QVQXqiPAYh8VJL1rTOuZtoixSp6bPExERxjx53qUurSIXCyLAq/sI/Fh4KR9FlnExtcr5bD3TfjJoRvnVnHwBJ+khPJS6eZUiUYXVJMK2X9vx8SAD7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 22:18:39.1307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e12b9aa-f530-4701-524d-08def1ad2b59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501

cxl_rch_get_aer_severity() classifies RCH Downstream Port uncorrectable
errors as fatal or non-fatal by ANDing uncorrectable status with
PCI_ERR_ROOT_FATAL_RCV. This is wrong because PCI_ERR_ROOT_FATAL_RCV is a
Root Error Status register bit (bit 6), not a severity bit. ANDing it
against uncorrectable status tests a reserved bit and produces incorrect
severity classification.

Fix by ANDing the unmasked uncor_status against uncor_severity. Per
PCIe Base Spec r6.0 Section 7.8.4.4, each bit in the Uncorrectable
Error Severity register indicates whether the corresponding error is
fatal (1) or non-fatal (0).

Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
Cc: stable@vger.kernel.org
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>

---

Changes in v18 -> v19:
- Use local variable for expression in cxl_rch_get_aer_severity()
- Add review-by for DaveJ and Richard Cheng

Changes in v17 -> v18:
- New patch.
---
 drivers/cxl/core/ras_rch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 8a3965edaa12c..e0e01aa5eba6c 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -94,11 +94,11 @@ static bool cxl_rch_get_aer_info(void __iomem *aer_base,
 static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
 				     int *severity)
 {
-	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
-		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
-			*severity = AER_FATAL;
-		else
-			*severity = AER_NONFATAL;
+	u32 uncor_status = aer_regs->uncor_status & ~aer_regs->uncor_mask;
+
+	if (uncor_status) {
+		*severity = (uncor_status & aer_regs->uncor_severity) ?
+			     AER_FATAL : AER_NONFATAL;
 		return true;
 	}
 
-- 
2.34.1

