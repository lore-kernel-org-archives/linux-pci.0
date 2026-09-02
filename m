Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946E49CF56;
	Wed,  2 Sep 2026 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356428; cv=fail; b=m2g4oEJXl6MgbRzYWd7yT0AhKNJ73LmXzzhRsx3A9t06/YnYQm0dfJa2xAEjLHl3atN7GsvAgxJnBBVK1f0N7yAXKMs+XSfdbXiw233IEWTU93tg3lZYqUZww4sbC26c/ew0vz96UYLKJqxr+aF9PCFacU7YQXZGCILrl7XqKoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356428; c=relaxed/simple;
	bh=8A9cSEa4rzCnXod76iDkM8PWZ5MEpv/5ZHcuYD/Z6Aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNn0HNh8m4hDH5dvyHbGLrq80xReueQ6vj8diQ8esmUML9Rq8QdOVGjEsV/qufugcutD0q8I9VwXlM1eylbthVNafA14U4B6Dt+6xDnoS++0j1cmBKk4Iv7E39mGDjEQSXZH48dbjaWRHGzVFNeXVvUaThMgJbeVX4zSNTY8XqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GUcjK3I/; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GUcjK3I/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvSRgPcBzsn4jnGSfhNLnd+qr7Dt9upd1JG1LXmO50/y8YEyLCnICkmXOU+LFcmz4aANTJV10hfX9eXmItR0m9XJDxjs6jChX1N54trx3y4Dsxh/39UHe5EqvOmwgULG2GCgcDbQGBrla1JRnrqVKzpS67YOPLI8aSm/9JVv+E/yBYUfmvlKD8wNrWIpXpwLZT9UAt2OqVFik+HTMJNdJ32N294rbF7o+lQwRcvPw2kJLt4r7WnpsoH14LQeT7Rqb9GGcn8c3hHtpqzgcWdoDlXS9prqUMap3SoLWYq2CyyCifhvMYfF6Q91agsqGpaWSJlC4gCbusSb1+djMAh/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IydlHagDOF0ZT2lAVvDqQE58edBOjzpRxSsUn2pZqwU=;
 b=wpxoGYjeagMDGloDxMqIUA93uYHFXC/c7Jp09wdIEbOppZftvDKkWvhkqFhsg80UmhI+qNjiSws3a/Ft5I6TivpMs0X9JYWLH75xN+0C6jQ5rLxdwKVbbwNmJsSfP6O7Di9+0EJo9Ig38hBvp9UkFachVMwJujMZF67zs81xZiGpCVTJxkTLN7PI8AlDdxmIvs2y4qqHheEpe2wCRa+w3VV7ti6i0RRp7JtreoGb/dvA+Wog+OlQUR2SBeOf2BuVDVKouPp6CdED7UvUGBAlHRUPrIDCk8OC13B9F4cLirKgzz/QO8daZ0YXkG2rDqUG6B3iJ0KJGsACrwABMpz+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IydlHagDOF0ZT2lAVvDqQE58edBOjzpRxSsUn2pZqwU=;
 b=GUcjK3I/oBkYgjDu57RjUivVU6OvlZAFXWLVStesSu4fYWAOf3/N4gza20rDzn3uCjwwEgswirT91Yq5OWnYJ8wdvm23dXTPXkJewwrEsWXWzZ2Ro+k9ejIIRgOA3f1/wL5XYP3fRKKdAoge4mSLonXZSKOSiG2Mcy44H4YgZ5E=
Received: from SJ0PR03CA0063.namprd03.prod.outlook.com (2603:10b6:a03:331::8)
 by LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:40:14 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::18) by SJ0PR03CA0063.outlook.office365.com
 (2603:10b6:a03:331::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 13:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:40:14 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 08:40:13 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun
 Guo" <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>, "Lukas
 Wunner" <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v20 3/9] cxl/ras: Handle RCH correctable and uncorrectable errors in one pass
Date: Wed, 2 Sep 2026 08:39:27 -0500
Message-ID: <20260902133933.2992457-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902133933.2992457-1-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|LV8PR12MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: a43ef9b0-a2b0-49ce-1296-08df08f7b7e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	4b37t42Ln/Hd0PC2wPxcJQ+dva/mSQgbQi76EsVB70ddDHWZiPK/KbA2cw/mOGyyt+/RB+Ar7KCcl5+ZWjE3P/Nlpajz/eG990gbYJ52P2mbYbZow7Zh7tT1/Bkv5bXqKEkiRXTlRrAI2ysFOl0Skx0KBg01jrsl5QxVJN/1LCM7ZQSo7h0VV10zED1fUkyyTHSBOF1+23pYCsLJZU0BD6tULh3hcO8PQOpIqZ9IHlZsYhaGLzilPAhm1fl9rxs25MtmsFGtwMvZx7IMvWaGr2kTBFThDlUDMwzJyVAHG7vY1WAv7T7mZ0SJMCS5VrEdY7+gwtspXKHZoi/Bi8tQuJPbfAAgCMHVlMVFpGSdsUKChbNPQmyk9kRAjBp2KwvTesEy0cvMx6yWgAj3YvPWODBzbJu81wD26RZkdm7Qhf+MtxroXG+AJ4v1/Y1RYFWZ3j1PmhVydyT/6cDxjw79G3zriiOicZRCr+5V8y8sLh29DSCQvt2ZQtlTM2pPJitLnrceorZNfOu9AzK1uZyQ8dgOkFwHrvlQ4AO/0n25gQFP90qWzs7uPCpeMBNEQee7dV/yK6HZvkKYnu927K8xAYQt618LhY4iHElbn1c6QrRSM6cccchH9G6wLxILBH1PXd2CKyI009EE7NEeaTQptzizrNwDf8NqqPTuOvaNQR9sUint2Z4viwH4Omk99q9eH7XaKPo8y5UKmjLVPJCJ+UVEdFF2rLzeWFXu2cJ9qV6jaxrfqJ2JrWR+lf+OdD2L
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uQuFN+0yMmnFUDbWbFXFeLX9MQ4qr4cSs0q9OBI5NjTpviUbzr+qgl3R0hukCM5xh4UjDYWQ0fNkQzkcyudg71Z1lIPuTtE22dyMP+9QDP1iSuqRK4yUCJrfNCVhs6rpugxnPkCJeerTcGMQ+0j5L2yBO3QZ34yZn4Pi2Cyo1z7Q65LidSg/BzarGl8p8mZmsDpT3l2zUaQ4jmq84Ir6h+jbq3V32Fdf3sPO3IwmpFs+jlws+2QwNw9NrV4OIwtGB7cHdVMqPwZXaCZMQhfIXIfgkoRXwycR5eEVTdhWjJu8bAlH/I0q8HuJ8GqaPqmc3EH1sroUebCUXDexNkHB5f1m95YWoWncQLJQySTkaiTuUBH4trd0/LW5RM3CP6vVWaoS75hWQokS5Y7fBwgABZdIrbLecLYUBJWJleSEeSsYdh+FBd+1MtSFYc6mcSTx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:40:14.3604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43ef9b0-a2b0-49ce-1296-08df08f7b7e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9715

cxl_rch_get_aer_info() reads and clears both the correctable and
uncorrectable AER status registers in a single pass. The previous
severity decode returned after the first matching class, so when a
correctable and an uncorrectable error were logged simultaneously the
correctable event was cleared in hardware but never traced or handled.

Handle both classes independently: dispatch cxl_handle_cor_ras() when
correctable status is set and cxl_do_recovery() when uncorrectable
status is set. Remove the now-unused cxl_rch_get_aer_severity() helper
and decode the uncorrectable severity inline.

Log the uncorrectable status unconditionally. __pci_print_aer() only
logs it via ANFE recursion when aer_compute_anfe_status() is non-zero.
A conditional skip could drop a fatal or non-ANFE record once the
hardware status is cleared.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/linux-cxl/20260803222923.517B11F00A3A@smtp.kernel.org/
Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v19 -> v20:
- Add snapshot of aer_regs before the correctable pci_print_aer(). (Sashiko)
- Log the UCE status unconditionally instead of skipping on PCI_ERR_COR_ADV_NFAT

Changes in v18 -> v19:
- New patch to process correctable and uncorrectable RCH errors in the
  same call so a co-logged correctable event is not lost.
---
 drivers/cxl/core/ras_rch.c | 64 +++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index ddaa3d7781678..285eed5b828b9 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -89,42 +89,15 @@ static bool cxl_rch_get_aer_info(void __iomem *aer_base,
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
 		return;
 
-	/*
-	 * The RCH Downstream Port is the Root Port's dport
-	 * (dport free and RAS iomap) is hosted on the CXL Host Bridge
-	 * (port->uport_dev), not &port->dev. Hold that device's lock so the
-	 * dport cannot be freed and its registers unmapped while in use here.
-	 */
 	guard(device)(port->uport_dev);
 	dport = cxl_find_dport_by_dev(port, pdev->dev.parent);
 	if (!dport)
@@ -133,12 +106,39 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
 	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
 		return;
 
-	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
-		return;
+	/*
+	 * Snapshot aer_regs before handling the correctable error:
+	 * pci_print_aer() takes it by pointer and rewrites uncor_status/
+	 * uncor_mask in place on the Advisory Non-Fatal Error path. Use the
+	 * copy for the uncorrectable dispatch and logging below so neither is
+	 * corrupted by the correctable pci_print_aer() call.
+	 */
+	struct aer_capability_regs uncor_regs = aer_regs;
+	u32 uncor_status = uncor_regs.uncor_status & ~uncor_regs.uncor_mask;
 
-	pci_print_aer(pdev, severity, &aer_regs);
-	if (severity == AER_CORRECTABLE)
+	/*
+	 * Handle correctable and uncorrectable errors independently; both
+	 * may be set in the same pass and cxl_rch_get_aer_info() has already
+	 * cleared both status registers.
+	 */
+	if (aer_regs.cor_status & ~aer_regs.cor_mask) {
+		pci_print_aer(pdev, AER_CORRECTABLE, &aer_regs);
 		cxl_handle_cor_ras(dport->dport_dev, to_ras_base(port, dport));
-	else
+	}
+
+	if (uncor_status) {
+		int severity = (uncor_status & uncor_regs.uncor_severity) ?
+			       AER_FATAL : AER_NONFATAL;
+
+		/*
+		 * Log unconditionally. The correctable pci_print_aer() only
+		 * logs this via ANFE recursion when aer_compute_anfe_status()
+		 * is non-zero. Testing PCI_ERR_COR_ADV_NFAT alone cannot tell
+		 * whether it fired, and the HW status is already cleared. A
+		 * duplicate line beats a lost error.
+		 */
+		pci_print_aer(pdev, severity, &uncor_regs);
+
 		cxl_do_recovery(pdev, dport->port, dport);
+	}
 }
-- 
2.34.1

