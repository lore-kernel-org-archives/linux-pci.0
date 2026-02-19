Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E565427AC4D;
	Thu, 19 Feb 2026 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771483535; cv=fail; b=B7ETtNJkVAdU0tS+/FxzFgmebIQtlvtfGv+HFZpebz0B9ZK4YVZWEbxea73upqtkvGiw0Ks9GjaNFNoxmNVEaPJqWEKk0INS1wNYCsfDqKLLqxqxnXD8YjM/PhgmJz7JZJu4to6yVmKmXvjpv16fHTRn2uMEfb02sHGAaqNByhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771483535; c=relaxed/simple;
	bh=2KXUgdQ2V18Gudv+G4GKSTleaiNAF2FJ39i1gXI9b6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVWuuSIyUj7buq3mYPY927mLTwG+pDJgjpp9PlLaw8eLTwgw5S1zGRFXC4kHcr75EdkvHR4VUz5c4sWGvRU/KQx0951II7N07huUgKcy82MP2bYOgGodEaHW9pm7v2jx2SNd+i1Wsix3f4qSHelU8+WgmitjAeL5qsetZnaCfDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NVCgBTMM; arc=fail smtp.client-ip=52.101.62.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NVCgBTMM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJ47BzoAfH9YQ6dE0xoPIAXSChpB3FTF9OKHonvwnruAm/c/zeI/XhSijTeQANOkKU1awER+inlDpAees+eLUHDlYUNGSx1H1xslCrLHde/RiLnPqs7kF6HqbPmckOWG/CDpdB5iTPZm58q9JLmNNIqLzdEV2cQI0PadwzzaBHuz60lNRCW5HrZ6jsGbVYZ8/KE+3ffbFqiL4Fec4LiwZesMpAGOQQqM+Bx8NkUJnbrJcvCoMcDQbi79QjzGwX5EmPzlY1b0MqySaeaPBL3+N2ceGNF0VrovFJwh/G6r8u88Xc77+7P6Cj/1v6TEr5UhP3agT1stBcDoAY1LHpAboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rL4cPuZbI6GPs8ukg9GNHiHyR41wJwpW1vmSAlwfEg4=;
 b=BCs3cbREVEU+D+S/7JkT0WqBAzv94yJT1n2havfQ8IrPKn+daMbT4ikbpnmJzwOjVcKoDtgWqtAaih7qfIbQ2Kq2cdHG3tIJp8sGDSyhlNebfhklmp46ttf6FZuvuvOe8Y1NwUI0KMyTjyFxWMpahH1xrDNtj2JZwlpfvlfOS+7Cma8KeMJKeV/biMRAc0C2JnpJoq+hUOorxCtvjvYqmnrRRfJAkoFl5seSvm0ddmfohgpsmaB4ym/cJSA/38euzKUAr1Wgv2v23zxLowMIPB8FwyF+wCUbvin7Ru/b8Rlwhf2rfwhsn8pDOTh8nSyxq/P8RNMoBCyY5tGezZxtRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rL4cPuZbI6GPs8ukg9GNHiHyR41wJwpW1vmSAlwfEg4=;
 b=NVCgBTMMzRJxj+LmHU8I/AuqzX+k7Ncx409SBRoBhO1hz+iDkYKGbptGsM2pvQqaVg+EezQmtpHHexXnAymKkZFnVDy0JAAr+NUV0/OREGrTslTcfcNMaJrGRF9c8hH2BjcMCyHXe1CAa4n3SFaOv6OGXHqHiNaHMurHMS468Ag=
Received: from DS7PR05CA0050.namprd05.prod.outlook.com (2603:10b6:8:2f::9) by
 IA1PR10MB7116.namprd10.prod.outlook.com (2603:10b6:208:3f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.15; Thu, 19 Feb 2026 06:45:29 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::d) by DS7PR05CA0050.outlook.office365.com
 (2603:10b6:8:2f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Thu,
 19 Feb 2026 06:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 06:45:27 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 00:45:23 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 00:45:23 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 00:45:23 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61J6jDwi2156628;
	Thu, 19 Feb 2026 00:45:19 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<fancer.lancer@gmail.com>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v2 1/2] PCI: dwc: ep: Fix MSI-X configuration to write to correct physical function
Date: Thu, 19 Feb 2026 12:15:10 +0530
Message-ID: <20260219064511.695086-2-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219064511.695086-1-a-garg7@ti.com>
References: <20260219064511.695086-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|IA1PR10MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbcf269-647f-4c49-0340-08de6f8277cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i1GQPqFZpBJL9wjH4NWqN5sYEIx386A7y7UkK+nx6OCpU5LP6XnGSja2/Hjj?=
 =?us-ascii?Q?nNSWnEynhB83WwD9mh6CGqa0mgeK2TxHZ4+q63h7pnQGJht/+2teKXF+COPn?=
 =?us-ascii?Q?w9OeZaixaVQyB2v2puhnyXo7VOFxKzJ9CW0YSmwqARH5JB6xWKBy+CLFkVAM?=
 =?us-ascii?Q?cC9WByZ4Qb8mVEO4GZRIfjxT7aTH/xLSWOeRqbPC4y37K2BbhoME1La94WXK?=
 =?us-ascii?Q?uL0mKPZx6mGHJio8h0cuhZ1XeYKyZ8a7k0U75yOyNQI65sS8i5F59Z+glaIU?=
 =?us-ascii?Q?GSaiXjCkFOu6spIhZ8vG9ENiMeBHI+2+jWHGfVKrgiZOWoM9ZLLFmWA1Q00y?=
 =?us-ascii?Q?cWyoJq+wSjUSE432tt5lm2uojCKuXJxVF3WBh8lrcCNj268VINV1bK49tQm3?=
 =?us-ascii?Q?g3UdS+GmQ80oJa2pd5xE3O/0fRxyC95GQKuE2dlEwwvaBRGbjp1yJnBEwBD3?=
 =?us-ascii?Q?tm0oJj4UTE6eKtGcMkJcpdroUzb9r6s/MLOeUR7oONnCtjwOiKDsYrMNQhSw?=
 =?us-ascii?Q?vzXzCmY5Y5q29DVsF+PVGwXYRY6LpHNN/gu6WrEFCB80XC3YylLWQlGmys+s?=
 =?us-ascii?Q?tbFINsHcDPGuPtCxMtYGMho9z/xQVrlB2xHbrD1XGaP4l1uQkolQNf1ZK556?=
 =?us-ascii?Q?M5ySBKxlsW+nt5Q8Vr+z3N6YrkqAoS0/jpT6vzm/4x0vQiMcjnOWHPZUXIyl?=
 =?us-ascii?Q?83NySmEgIYB3fjhojQ16KyrR/P/KjkCsgd3FPYoR1419cCd9phzHJOXLZUb0?=
 =?us-ascii?Q?/iTZn+pX2ieWl0x9FDzYKj3raa4t67ZMYJUW8B4NB7TXg7euo4c0b3NX9mE5?=
 =?us-ascii?Q?NhxfZ3hCM4okJLNhvqO4PiqwCYRRs7ZotW1N9CdpEeIl3M3FRqXChZcIEDxb?=
 =?us-ascii?Q?ewlEbNXwFze38iOYlrsHfHsMzAUFqjs6IloesfXMH+8K0fSb0vD8iMllqJ+9?=
 =?us-ascii?Q?khN20sTFp3yzOPjilAEaoQGVSSJ5l0q4/gpaLJpUBl4gOJz1MCYLKjdf79Rs?=
 =?us-ascii?Q?ouBbi+5kmqkd5k3zDglE57+SfvghZPfoB97w3CnvATXGq57f4JB6F3bXWTZR?=
 =?us-ascii?Q?BftTQH8wgFU8mJujHpoOhLFerMmip/XSy4rKQwJQuSXd+8+OVc4iCTYzVJRC?=
 =?us-ascii?Q?fkMXi3cL32mTOhLLOfFiGD6JHAPnqeXdrihywpgXqih1JRYpKXS5c4GMqLN0?=
 =?us-ascii?Q?AU5bcgZqncn1Ach2add+htE9fzFlAmjNsbIpinwjG3xsWtbe1JiT0T4N2Mm/?=
 =?us-ascii?Q?z4PVykvpr+oom1DSamXl6MLXCguGDZnMUFnB7YHOiNRdz9M4oJO90M1I9VQX?=
 =?us-ascii?Q?Ksc5R+8USRPunm1cm/PZujkVREFmjh7/iAjW3cLD1AEhqDMfnSS2OKVWkUpF?=
 =?us-ascii?Q?QIeA1umz9kxkGZsU37qtMZnnDmdb2njfEDy1HF1kekjqVvg7R9E8xTvgqLtJ?=
 =?us-ascii?Q?U1I17w6X4NmcEpGTL3f16H3JCJPU/J9GnaC8fJEltCmIcLQcY9M7VCFmofBE?=
 =?us-ascii?Q?OsigO8zyLeXMG4R8JMJi1JqOUEwO4V/wKzhAa8UrKWdOYzsWfYZOzInjLAY/?=
 =?us-ascii?Q?cKO/EUKzKWy4dYwNH3WJ/Ohj05CbTFnHyJeeWixrWD1mQKYd94d7VgJu77gz?=
 =?us-ascii?Q?ffMtl1O8+o3th2UJRJzQ+hNcS3iG1bfpTEoXrWQKwJ6mR8UF88iqb5yxnMt5?=
 =?us-ascii?Q?RAX+e4HPwNR4Cw1P07xhSh7C8TU=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fejENUhHGaSWs7EGRLW/7/5Z5LC8zytYzbeWgv4GiUGExunrub126A/L0z7GsdzKWrK8wBv0M75LJqj9lzv41tHeM2wdH267klZQW2vAOsRXL6OUqSKURAx+DKPUBgcV3o+WFFTgshgtBoHDLgwwYER37jsboL7hZ9XIsLyL3nAAfjxpSI6BN5kWz51WIrFSKumyAAYNWDEGIABxWm8iauYu3oUcu5AVtHVw6aomi8yHDZs6DgOWslo2CErCAqXzNBNzni6l0nMp4H5f4TRbrHyz+2wcOqoMFJrZT+5aFbiGXFEImQUIHThAxCXFmDeJLd8eqdubn+dBJ6mrvhYeX+zb9zGauaqqIoL2zrSJ0NVJigxB/yx2nxPhpQv5ncjj7IsCi+VD1cMgtKRWjxiPnPFWfPirfwhsA6HoHWGazARq04eZZBONTzKpeMB4/Ze9
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 06:45:27.8878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbcf269-647f-4c49-0340-08de6f8277cf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7116

The MSI-X configuration code reads from the correct physical function's
register space using dw_pcie_ep_readw_dbi(), but writes back only to
PF0 using the old dw_pcie_writew_dbi() helper. This causes incorrect
MSI-X configuration for other PFs.

Fix this by using dw_pcie_ep_writew_dbi() to write to the correct PF's
register space, matching the read operation.

Fixes: 70fa02ca1446 ("PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers")
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---

Changes from v1 to v2:
- None

v1: https://lore.kernel.org/all/20260202072758.101845-2-a-garg7@ti.com/

 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7e7844ff0f7e..771241e1a2c9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -745,7 +745,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
 	val |= nr_irqs - 1; /* encoded as N-1 */
-	dw_pcie_writew_dbi(pci, reg, val);
+	dw_pcie_ep_writew_dbi(ep, func_no, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
 	val = offset | bir;
-- 
2.34.1

