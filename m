Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020137.outbound.protection.outlook.com [52.101.229.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980262D2491;
	Mon, 23 Mar 2026 03:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774235773; cv=fail; b=ubnKHxbQFQaoy3BxqFTWAQd0Ajt7tVyvUD012orryLHYU8Cn0WRm9xo413nEXCD7I7+H00kt4UkqGjvrUcGSFe/9C/wqzBnfe0aYRQD7iYX7fW7toyk7usr4jY4EaZmp2yA1kOW+orRZZTcufejTZlLC2NMC2vQV1movRt6sNLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774235773; c=relaxed/simple;
	bh=kMX8Xabq8caChuSpi70GzmFU4vh+NdM5LaY2m+JLAWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o94YM7ZtJQbka9uTVhDYqyjXPLGprb1G32QpBa6UXE8UJypUA/9WeFXsE2MZfC9bOLpkcKobsHq7obVFmiJEAhW0oLtiMaCCARdXvqHz3V4ERIojmTg3vjhcUIl5Xr3UKdLG06ZGnBBrDQMOHiLXVAoO7vdJQkSmreW89QIbwZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=oEJspvg1; arc=fail smtp.client-ip=52.101.229.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="oEJspvg1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5N+E69xCn5+jnMLLky91D6Jnd3W+QY0IDuG2jNKHbJMPcpcpmo7zgU87rIMC+z6BeLUgZMmSKq7w3BR/hanRdTpH6pOr8ZF7V6gf4TA42cFzjKoBRd4/A0+P9Gyu9IZzelAkNE4bdxOJDqMB7mPcVARPrayVo4qzHd4EUcX1NiMtSiMSM/AVkAe9FEQiJBHSwUNkq8sDDXd+wyford9HTAQqeTtTbKJT4UXF62OJUW/z9fD3dJzE55BbOB0YVBOejc/CHruoo/ewrhLCM5XZ9uWseI7CNSuLaSn0f+ArjR+n0PhMjrxlXL+iG7weLS6zfkN7rEb24sIwIuwbfWs8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN8gA4shE48oVu71dEOre0m+r+Hc7KPSDGqXl1V8lTA=;
 b=Q9XXbTxnXszOz0pgd8HS5b5voT93KkXKoW727zuvYcbKYjuPN0vSJ+jrUsW4fYTnGWLGoyZF4OPNxSvLWb5TsqflM14IZe4vB72iiVPdjr9UTYQO59vNtv95Uz0qxgNaXZ//pNa6WhOZuxMr5v99qOnoLxEYqUW9qQmRgy+JtbrrnmOvB6QBQY5C/8ISIv8LQ+pq+uqPbPlUtA0JD8nIzajuzK1j1vcwjapYaILPJMnCgtfKPuSuY/Cc/yShZgCEvn003+vC0YLuTj1RFCLZSUN7cGBnVHzzOmeH9NXsmOSkD9d9Vdwb/TnbeT1/AO6Ebz73j5IlrniLY3UYywn3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN8gA4shE48oVu71dEOre0m+r+Hc7KPSDGqXl1V8lTA=;
 b=oEJspvg1HxjbpOBot+EHtJpFtgo0lFItjnnhMyi61K+iS7Hj2Ck1Dwpe56bE6Ozj2Cn1ETKW/8gK+3ckznpBMKtGrY6YYz4UU6Bbynh/Tj0nbqW36YWUym7fLOXuwyvR09kNtjGaEVeHanR5i2AVhIAJK+tLM/6XsQrrRZhYkO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2385.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:16c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 03:16:07 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 03:16:06 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v3 08/10] NTB: epf: Report 0-based doorbell vector via ntb_db_event()
Date: Mon, 23 Mar 2026 12:15:42 +0900
Message-ID: <20260323031544.2598111-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323031544.2598111-1-den@valinux.co.jp>
References: <20260323031544.2598111-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::9) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2385:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8387fb-e61d-4916-ba0b-08de888a8600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	RKO3DlpZuWqvmOA20Etxj6WG2OkYqyUgFDhEQZs3IiuKRwdz3upIFT6ZSbmfTy6H8ni+Fi0v2A1JyXR6UWooxkp2GqB9kR6UZwcucGODlxEzh/HIcD7ihChf1sFBY1BtJ45jlXoMCcOy3fc+YQXPi8uFO0UxWS0zcRs4MxtzL9n+8inn5vj0TgUgia0jR7ThZSHbVz4IngNdbyQqbx9mILUfJCoTzHT13fPon8nxAmS/lIJiwi9MXtfmzStw962dpdlFh8hBPe1zLzb7UawEuwzM6IFHmYbs/PkkMxfQkeQhZ86CrJXnEWs09BzcHxdVhIpt8u4VMCLrDBOsHw8jpfzbjDUnxj6qVtn5mqXWjpJx/o6ZYtQoyz9BcUG7IIDY4K+jp+9yYv0QoxsI7L1X22zxkvEMh6l+Rb78CBNPhXgNLRN+Bgwcl8cjDKm1PM3p2RD3nUClZ4CUObCurQG76V52fspvxkoLrGiKaQxSOF+RZ+9qfhLUd3H2w4lzICCTQdJDv+5RNwg4PDGytc8fb/ORAttr7Ho/O5OAyCkg3OUQ4dTSecQ0P/2LTeeyFkZX9pNkrDQZ3Fo5n2gM2Tg0Gozb65znIJDKEdx9qcjsMakoC5pIOgG28c8rB4dJTMDpWHw+iSTDAUAIB0nXGBZv9XK3KKvp9vyQ44qyudkzWWdCO3rw1wFSWxX/yiRbp3HBh9HbZbcl0vduA8+U5q6Zt/eBoz1QkWsJNKvgI4z/NJtex34Uyn2VtB87cihJFGziPIU6lTtm1ZsEThxgMdL9AQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6gs92SFKpy6RTlmRNO3hJGI++zpyT4S/eXjmPG2GUp8pihT+j0bSR8ZGNgKq?=
 =?us-ascii?Q?KD7LQ/w3vc4tlQVFJd41sKoiFsp5jTfwBID7Vdqlau6yfDM0f1unahbMJVki?=
 =?us-ascii?Q?njxhSEVIbWD07j9X0tsGBaKcU+OOW+BXYzuLACmxokRldTrwV1izuqiCWbXR?=
 =?us-ascii?Q?SeFKx2UEKuqfU1L81n7MAJ9kk2nF5avYIuEvuyItqKVGODpJ7ktTU30Pxmo3?=
 =?us-ascii?Q?C8vIQVa+/UDFQ85LtLkNB1Egmb0XPjfhce8oAguuJMLGST955NU7Hpra04So?=
 =?us-ascii?Q?O9tLwyYmxoPj5+gdFjIbHSs8j6ORU30QJUGVA5P8gQmRQVqtlRzteOR2xUYS?=
 =?us-ascii?Q?NUwgYAaII+uJFfA8jkjuDW3Pc5ntixYb5Ebbpwnsvzxjb+BgEtZtVY7vcc2f?=
 =?us-ascii?Q?TRiAUZ95VzN7TJPHyFYVkmnINMM3FrrSwxDGG0WGlocY4pGdUDCWj6pY8q6d?=
 =?us-ascii?Q?h8cSQ0iVmINekzmPo7RiEbpOwVBO8AGNUYENJiG6FzMyTsvo7ygLFS8ecIAV?=
 =?us-ascii?Q?A23dmD19n8hAkgurQz8a33ebE0I13JlcPWayP2YeV72SAoV3LI221lTWIeqE?=
 =?us-ascii?Q?NcEwUZftqT4Rvnry50r77OQsKJE55/+26ijCZblp+TDqndcdC4akEz/mzvp9?=
 =?us-ascii?Q?zPcMzv7qoZ7K3R3SJORkUSq+Ci4zBXKm78hxBe9tCVjW/vEznddUMvtfgBsM?=
 =?us-ascii?Q?Ng81yCtjvA94ZF6LvU+O1zebEibCiLwRbHho0myROMuCnGcyg90T5rjSP/uj?=
 =?us-ascii?Q?PYhkEvSxALcNKJHp7ixVLYSKWI3IVYTeUkqZOZIPQYa/cnP8WhUrwxlBD0/O?=
 =?us-ascii?Q?pM/SEioNNNBn4drIprcOKglqVONPoJk30t56KAk+1u2M+KCjYQzjN//fhe59?=
 =?us-ascii?Q?Ote4JQ2fpH+QPFiYc5Uiys9KU63s4OcxJgLPxhdFkdYI/+wEgcgTgbv+uHhE?=
 =?us-ascii?Q?iRA1qkywvRbBnl8erLOdb5ezPCPV3heTIeJ1rGwVZB2TMk8dQKrvvzVGVAhp?=
 =?us-ascii?Q?AFi+Bv0Y/FFKOeM88tjldWBM/M6/4Tzt8/PA6IMF78vrqB/FabL1oq3y7sZp?=
 =?us-ascii?Q?CGiOSxe6ta2xidnPjWn3exFXwU76TsVRHY3PooQfmv8BGTrXS70AbPUKzia/?=
 =?us-ascii?Q?Bi2vd1CAq1o1taKgRB79FKu2YKsiMCTsO2FUfwAuyrK4wmFFxzxzkt/uD1GP?=
 =?us-ascii?Q?5pP3gzoZ/q6QoJKCo/4tEJyaLCMNXoLdktCSi1ne4YYNqkIYiaydKeB+JkXT?=
 =?us-ascii?Q?n7kDGycadakwkds4x+BxkWztx4aS0bSN/Mfzid7KRzMhuJqlkvcQDCQFtz2d?=
 =?us-ascii?Q?2iFlOQ/hBQbtUeyNGHdShnN83lyRtkz/ICn4sHC1bSiXX7AtBG0essWCV2Nk?=
 =?us-ascii?Q?nphoCRQpAAszzJGuNCysVDLey7Gt0BCwrhGHa6zjXo6ebCz81sN0Auc5HvZV?=
 =?us-ascii?Q?ruJ/vFgwyYZVnv1XVigubvGqqvOwRiANpTStTcxPsq4fGMkdJJiLJmBNjOnG?=
 =?us-ascii?Q?xx4DfS8TzmXaezZ8qUy/SopmOKcfqZrOFDKT7A0blXLHq2bl80y/7BF3495V?=
 =?us-ascii?Q?DhWUv+M93uRc7Tp65N3P01ccTjM0/An945sJuN5FdYAEed3xxmJrOlt7ihK3?=
 =?us-ascii?Q?ww4p3daI4WmS76TYBDjprKkGR0vfHNC9hLDD9xQK4lGQGiLlEVG24ASQ30vw?=
 =?us-ascii?Q?GbktJzHzpnk+CTRo8pvTVBbNM9h4+k3N9sUZIQTTO4DznubDt0sWgmLWTT2D?=
 =?us-ascii?Q?LfQn4LlM8blSxUCMm/OgkuP7ZDOHOp7YG4vV1UeaiILnHFdgZ+5q?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8387fb-e61d-4916-ba0b-08de888a8600
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:16:06.9294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32aCXRwlrW49TPRgUdhPY6LkAn+OqmXLVwy8UAXKevymDswUYrCyBNwA8Y4FmP2OaU/CVpWwwHbwx6HIrC/A/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2385

ntb_db_event() expects the vector number to be relative to the first
doorbell vector starting at 0.

Vector 0 is reserved for link events in the EPF driver, so doorbells
start at vector 1. However, both supported peers (ntb_hw_epf with
pci-epf-ntb, and pci-epf-vntb) have historically skipped vector 1 and
started doorbells at vector 2.

Pass (irq_no - 2) to ntb_db_event() so doorbells are reported as 0..N-1.
If irq_no == 1 is ever observed, treat it as DB#0 and emit a warning, as
this would indicate an unexpected change in the slot layout.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 07dc97d3270b..67cdc5d729d5 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -81,6 +81,12 @@ enum epf_ntb_bar {
 	NTB_BAR_NUM,
 };
 
+enum epf_irq_slot {
+	EPF_IRQ_LINK = 0,
+	EPF_IRQ_RESERVED_DB, /* Historically skipped slot */
+	EPF_IRQ_DB_START,
+};
+
 #define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
 
 struct ntb_epf_dev {
@@ -333,10 +339,15 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
 	irq_no = irq - pci_irq_vector(ndev->ntb.pdev, 0);
 	ndev->db_val = irq_no + 1;
 
-	if (irq_no == 0)
+	if (irq_no == EPF_IRQ_LINK) {
 		ntb_link_event(&ndev->ntb);
-	else
-		ntb_db_event(&ndev->ntb, irq_no);
+	} else if (irq_no == EPF_IRQ_RESERVED_DB) {
+		dev_warn_ratelimited(ndev->dev,
+				     "Unexpected irq_no 1 received. Treat it as DB#0.\n");
+		ntb_db_event(&ndev->ntb, 0);
+	} else {
+		ntb_db_event(&ndev->ntb, irq_no - EPF_IRQ_DB_START);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.51.0

