Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012069.outbound.protection.outlook.com [40.107.200.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED775285050;
	Mon, 16 Feb 2026 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771243572; cv=fail; b=mabfw30Ncp7MYxq7dytArFpNtxGwKgrgC9UPl1vK0Wa8Qbmr6iUk7lxC0FY5Ti/qu3gLJ1uqPr50VyFwi6NM1Pyze2VuwbyOsIF79RVcVg4zqnwaVEzSUA0MfO10tkY3wvYl9ZyVFIDC/GURhGXXkW8C6WBHQBSWOeY/Cq/NNLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771243572; c=relaxed/simple;
	bh=QpObdIuOfGPoGn//adUGzii0wAfB/tI8glNhO9tmOr4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HNVSQmHxotE9rxpaTWT+9vM1IUxLaFFHTYRqhQJCGqOBM7VhZxBAgtCvvzw7KmNHQZVHxOyAnQkZ+q8dwfd9UHj9wnLSEGxk+OC7DLNwLs40NoWPJ8sIUazwJyMnppSwlKZkpCjMoixLdBJqdTZcvBs1piW6Nvu6Uu/SA1Ei/5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IWO+UNFz; arc=fail smtp.client-ip=40.107.200.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IWO+UNFz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+yMTQs9Dw91DwPSAOC4KZV2reG3EGiPfzRIr0oLMFdw7THKkgpHIIdTBuSurCM4/vYJGhdpy+uRFvbwW13ZcN/lWQZaWJqrVlPpkrQDet6ITRYbDQBgrPhM30Qszj3QyNvmpHW1Niyqr79rfXYsw2B9ompPXsIyZfSNO7CKQhSuD26TKNdKnRtJ0bnAIhhqX0KjqiHyIee8oBdjY+4XXuXUuyENoZ2hHAOWhBtXcuve7qUzatTRIraPEbwTaP8rqQ8Ems+Mzqip6kKJWtiVZGN3IdZhRcIISLki2SPzqSws7YLShGrMNpAeCDLTk0QTamivFUNk1kXfPoXfbGqXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSl9gzcVCM3nFdlbJzTAMlN26QYJqepkkkIF5LPqT2Y=;
 b=DoDbu529CdSkt6yKIbIlNw0YqzliLIr9hKDtTQthr+syKE6sDLDeik9U+C3caHtDSWPWUc2Mw8mmp2uHS/jpU27LJFIa3Q6k7ALeB3HV2vi7zxr93SbE8nc9pbUdwRyYiIHWULBGT9uQMOr+f6wkokk3u6b/jakn+ObDELQgUAduFYWftH1Dd22UpK46Gk9uGTTbvif7YH9c7nteyPsSSfqcUrEpNh5Xgxhwb80hAy8koIFU9khUrD3jvlLoxSn1q8COt1Y+jP5r6/HfacVPPN1364Di86ZndSG5zIfjyVbqA5XqhmliNX+BJhG8WR5VzlWaG6j95r5V7vdYXuEjhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSl9gzcVCM3nFdlbJzTAMlN26QYJqepkkkIF5LPqT2Y=;
 b=IWO+UNFzDkJVJ47ukUjwGuNCMbJxo5PwkiXpT6/65+3nGPfte/3mv6A1dhSAJ/5TqBVGBrYT0/cFbRrTBeDrfvR/LkiS08Wx7lPXrfnU17NYVbG4j2lYHp8gazGvf1LpyLCjjaJLY6u70MBoIfr9NheuwKuC5J8yfmW0fQ6vcfU=
Received: from BYAPR11CA0108.namprd11.prod.outlook.com (2603:10b6:a03:f4::49)
 by CH2PR10MB4373.namprd10.prod.outlook.com (2603:10b6:610:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 12:06:09 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::74) by BYAPR11CA0108.outlook.office365.com
 (2603:10b6:a03:f4::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 12:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 12:06:07 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 06:06:06 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 06:06:06 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 06:06:06 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61GC62Yx1718211;
	Mon, 16 Feb 2026 06:06:03 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <maz@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, <a-garg7@ti.com>
Subject: [PATCH] PCI: Add PCI_RID_MASK macro
Date: Mon, 16 Feb 2026 17:36:00 +0530
Message-ID: <20260216120600.479738-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|CH2PR10MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 48595c6a-8bdc-4253-c4c5-08de6d53c47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CABs1cEbK+BM8HhiOFOd4FxBEDE6FuoCYNo4rqbTSr/Hu+frX0pQehD1kGqa?=
 =?us-ascii?Q?5Ts5jnu8tGufdGtFZwc+Zq9R3IYnIrC2SG5BpwHAdsKbCV5hyannxLBWgSgw?=
 =?us-ascii?Q?2U8tMTJE/l/RW20KKGSIrjV8w1nO5r1DWQlO9IHTzBbJfSy1G3D7mb7k8lZy?=
 =?us-ascii?Q?QL2st4QUek7X/21gXyY0qrqj8xs5thtD3BgG1cvWw2Hy5q8CpCq0GNyU+oRQ?=
 =?us-ascii?Q?lLlp2GKOSNiMUwZEJisLCLFvRJIxpkTjvo6PM17U2o0HUc1CuQZdjYwpzFmW?=
 =?us-ascii?Q?UlIkQ8nd6Jr0JiyjGWR+jDksUAuWm5mipCl06PeV59o6SkwbjQqG7hFHdmU9?=
 =?us-ascii?Q?8AttSkRkWuJBguAYXFVnfdd+PevZSLBDXbG7era+mRoYtTpo6Bo0o+LgwmP/?=
 =?us-ascii?Q?RsxSzIfe+4cknfbGgNJwhQVwN3X/z+AcVjM8ANt0Q2L7J9Pn7VMZxtTjHkHr?=
 =?us-ascii?Q?zBmnH6E5J7fWdhJJm8XSj0yn3yTcVUXldXT1/a1oY4UX3UgxpNOyVQlriUAU?=
 =?us-ascii?Q?3SWi4oS3rv9OC20Htk+XzUBMYA/ZH7IxrKXtDhU0QEkKub+hPAS+x7THLK/j?=
 =?us-ascii?Q?AYSv/LhZrbnDDKRXhDYPw77G5rj5DqrYywOvHiO7d+cbgGKVDUw6vPK+XvWz?=
 =?us-ascii?Q?JmSXqEyGKAn1yvVCRgPhT0KIzDI3gEDhqBi/wa0HUJxU/68Wb7Z2VKVL9MWK?=
 =?us-ascii?Q?mFk7TH3GULqUWETB/qRgLbCOtxHQl6No8V1IcoNYT1uQMsQW5GdIRkBFlO4I?=
 =?us-ascii?Q?oNzDnyH7dPTZHlThs0yYaiY7jBoEw+1cWJ0pfDqpdUWyXPQgzf6I6Tsf5MFg?=
 =?us-ascii?Q?nLbLLwldAseF8U8goTb5vApIISQiwvx85EmGFcarY78F7eKU63Mkq3hhVocF?=
 =?us-ascii?Q?wxWQuxvSlg8aMQzJ3HgvWPQxo1dcElM8vEov6ixeMeLuCf8t+eOrhvIqH7Y5?=
 =?us-ascii?Q?Wm6kHqi+jcler8kBFJP11tNdwc3/NOoDH9lEy/lRwkUZToqTJMvc5m6rycXz?=
 =?us-ascii?Q?PL9rGPnHpswW5qIhabMURG0C/eRvYEYwJm33QS5Hb9pi+XSix6prMBsCvnDW?=
 =?us-ascii?Q?pboASuBx8KLaY9rGfJMgdTJZhFtCAkM4NlKmOBfHfbMs30MUOhocT5iqQnpH?=
 =?us-ascii?Q?CIfTb4fgvIMN6M5d5VlFvBOF8bC3uEAmSMjhAIOoSimpRy0fgZ8b6C+eOhSl?=
 =?us-ascii?Q?XvbIu3FTyzsNt/UqpadEMcWgfiupCca1fQ8euzfhTtqqzZFcILUzenpfbcKD?=
 =?us-ascii?Q?LpxIeXDHEeRP0Pg5rx5Q3y1YR2AuxMkRoG5Dny34UBzDWAtRdd5t5J3CuGu+?=
 =?us-ascii?Q?bnAg4OTqwRshVODRPBYcx/Eprp5f2SfptrPnehUADKBzYvF1ixi8y7pmalZp?=
 =?us-ascii?Q?xt7kxiXBMmhi6ppAA4qYiS3HBx22VPN84QxHPQ7P7jlWnbm5BmZFXetmPuS/?=
 =?us-ascii?Q?E3QFFHQdnJgFayXHv3pEae/Ut4rVYWCze/FdcmPphqnqO1QeNcoAypXiV827?=
 =?us-ascii?Q?By+MVBJnMNawv617enCVXcg4fa2W/U+aki1SJv6QZe9F/ymqRptS02uWZhw8?=
 =?us-ascii?Q?WL+xFzTl+vDTSE+i4BH7oU5SvyENfMfywgbtfIvqf4nT3uyETJ9zCWn4nnqE?=
 =?us-ascii?Q?plSuBIImz/8dVcfnKFNWB5ANCsZww1Zd/T/yzA3/c4sXOOZD+6EobeEf83zf?=
 =?us-ascii?Q?xPFC1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NieFZatKn7IHWqxW3kOur5QhZ2QV13zub8gYMEMO9je7TK0lw7ysJVQEtXlFc3dPMhc54NXzYsAvcJh6rLrAQSuxz9UhURAWg8oGc5NOl00Emb39YD4W9ddlByauaGZGxQDFRxVOT7fRhTjZlffVDO3GDt2DsgbSRXFmmw+rTCq+U/mEOyngVdezAXEVNg4X2Mgyh0jItX4TaZEPFtwMgDu7eL8zpaA4nnzMjJtU0pKbGmWuhEOy3JXUjQueD2KE4UIfncqOarlkWQvL1SGRjF9UwyyDkw+0cdhBMy9CpgEopYu/rA8z94acYByXfTysdjROzmKdfB6kWh/YYMWHD5nVDEx8G9K4A3ytNwvEVuck5pDuce8+pr54mZ3yhQIYP82eED6yNt62nW82+522s3JsI+7Ss1Ubz6HXD002PfaLd1UzfwnO2+kKY37nVQLI
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 12:06:07.8241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48595c6a-8bdc-4253-c4c5-08de6d53c47f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4373

Routing ID (RID) is a 16-bit value composed of bus number and devfn.
Add a PCI_RID_MASK macro to eliminate the use of magic number 0xffff
when masking for RIDs.

This provides a standard way for drivers to extract RIDs without
resorting to magic numbers.

Signed-off-by: Aksh Garg <a-garg7@ti.com>
---
 drivers/pci/controller/pcie-apple.c | 2 +-
 include/linux/pci.h                 | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 2d92fc79f6dd..6bf9fe102e2f 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -802,7 +802,7 @@ static void apple_pcie_disable_device(struct pci_host_bridge *bridge, struct pci
 		u32 val;
 
 		val = readl_relaxed(port_rid2sid_addr(port, idx));
-		if ((val & 0xffff) == rid) {
+		if ((val & PCI_RID_MASK) == rid) {
 			apple_pcie_rid2sid_write(port, idx, 0);
 			bitmap_release_region(port->sid_map, idx, 0);
 			dev_dbg(&pdev->dev, "Released %x (%d)\n", val, idx);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..e3d9730121c8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -71,6 +71,7 @@
 #define PCI_DEVID(bus, devfn)	((((u16)(bus)) << 8) | (devfn))
 /* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
 #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
+#define PCI_RID_MASK	0xffff
 
 /* pci_slot represents a physical slot */
 struct pci_slot {
-- 
2.34.1

