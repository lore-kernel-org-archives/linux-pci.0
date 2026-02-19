Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95E27AC4D;
	Thu, 19 Feb 2026 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771483548; cv=fail; b=DOGEBg8AgOqV1oFQFGNswt4xyeeo7wI/pU1WrO0Z/UEfQpfpV1UhblVSR7kzr//prwKtJaODKKBKS+eWUH0MTAHv8n/uL+YYWkEWThRSXJioP/0ZTQ8BAno2GX+BNH0sqOs5bdPTdf/cbdZNi9wyhY2XDiBUkRAZmrjedKvNLwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771483548; c=relaxed/simple;
	bh=xsYNTREu9XK3WQjh2Lq83Ktq3LCfEwssbqo4xN1HdrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGOo9cG43+QE1jNNXSWEDlwFkszxkg6acJyKlEdpocaVCGSO3Vypou6k9WkO48LWn5YWB7tAIPf8RIs8SL0WKL2ck7DEGFp4D9/z0hAypkjcVBBPQUvlJf1UjTT/PG2dgMYiLqnlgc8WsYWtP5F2pWM6lddwhpuBcu2J9Qox4XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h3wGRqnM; arc=fail smtp.client-ip=40.107.208.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h3wGRqnM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+w5RjGCUODwDEcl0y8gkCuZXIB581276yvHP71Ne9Pkt/8zIlLOTtpe3vTpD8MP428wlM9510GBIF2sakcDAvM0yMInqma6euZ7d+JgU+OR1H2KXeZb6B/R2pG9xMfVyhlzb9JpXliI2QQYq2/LJvEowclPTT2vbstGImdp7SJAGgw0f8CbTCXyCusKt0/GxDW+weP2cK1dtvmi7KjX0bpzaa2ozwmzUE52ij0k6o2kdze2pf5yJ7yVwDX8linsfTQI4cIwBrBHcMlljPxcIzWJZpxWcP7ytF9+N9//QRl2pJABKLDSBkrzJRztDR60eP2Ei3nhS5fOeRfAphcC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=633mlxtij+R8xduUUkojgXALF8t1UJjnfskKkEq4VWU=;
 b=JNrI4KM+CnPAmztgzpiJ6/IVK5G7xRt7Z11E7UW24PeBD6yDCOJP5wmT7QQLUgWMfClR0wNyMauHni4nx1Ml/WoiI4rLVm1ZjVabgD4lzXlfEYPPqDEEs0SJw2PSdTrCe+EZ/2NYxDEOfcw2AdvxKrnfLGIPovvLtMOAcF7j2HZKNCSWGwei89wTx/Vvdybv0O6D/ZM+s6p4+1jZgLv03Uo/57toi6oJx/ZgYCXIO1w9wepQKfWetljAP/7qMw0P01CNPje/YZSqQehwERNVVuHjyl+c/6Lp9EUAy2NolTQS8KE7FflRTpFKtlzk3dT6iIHTfvTLmF4SNvWWpzkxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=633mlxtij+R8xduUUkojgXALF8t1UJjnfskKkEq4VWU=;
 b=h3wGRqnMy9tIHJFIZ4VhIxkhtwGtf50qi7BM+f13kiZew4rG9NfLPRqD9vCUfULLXmfOvNXIN0U9P6gR3VJ1T6vvn44LnUH6n5d3ySyMeCeACvBBYeExVlvPtEB1Pi5GEV78lvht81+v7M5nFmJsbl8bzulowPe0MUeoCuy1G6o=
Received: from SJ0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:33b::30)
 by CO6PR10MB5618.namprd10.prod.outlook.com (2603:10b6:303:149::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 06:45:44 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:33b:cafe::9e) by SJ0PR05CA0025.outlook.office365.com
 (2603:10b6:a03:33b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 06:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Thu, 19 Feb 2026 06:45:42 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 00:45:28 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 00:45:27 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 00:45:27 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61J6jDwj2156628;
	Thu, 19 Feb 2026 00:45:23 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<fancer.lancer@gmail.com>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v2 2/2] PCI: dwc: ep: Mirror the max link width and speed fields to all functions
Date: Thu, 19 Feb 2026 12:15:11 +0530
Message-ID: <20260219064511.695086-3-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|CO6PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e5b5fe-4d4c-40b5-e26d-08de6f8280d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zDQQKEBlh6vEVSi899VsBrkkYF1STIDZ7y906LqSlHNHlT2BOPyLlWk/N9Mp?=
 =?us-ascii?Q?PRuAfYPQh9sIODiqGOtwDXG2XCMltMEJxr9gTf0g8IytOxs7OHcMfXKQjw32?=
 =?us-ascii?Q?rSJuTClwebM5vX1lnLEw/IgDvW/Y7aQIRkfiJWWiUgm84IPdJwqtwFnX4InE?=
 =?us-ascii?Q?sk6DOfLBklhI9uBb4NeWIVn1KQOXGm2EnspX+HKILeT8z27QKwl6UjUGOkeF?=
 =?us-ascii?Q?prUxHC6123g4IBHZR2F6verj7fKL5lAdcW0NvuG1DJ3nJjpGct1JrSDkKC58?=
 =?us-ascii?Q?PjMkS0QE1oh3fReHmtBUtKctBWSTnq7BW7TxJLPiMGR3UcCeGJPB16NuE4Ws?=
 =?us-ascii?Q?rErJafarI605/0hN/6Pf5ge2KHOlzjNrVzSm9iQ5+InBG6NUN6e98V95rGKV?=
 =?us-ascii?Q?Y0KdSilYPcaW3bp7fMtX7UwwX0ifidklhXVBDq9KfnaLqsYSaserDYWC2ql9?=
 =?us-ascii?Q?19Q7uRw9VwvaTToqb/fgPQL/EfkIBG8e0CSyDb+ToTDj3hPyqQKpqcruv3L7?=
 =?us-ascii?Q?QoCQaq/+Lo0wbOqiu+gsFlcx8ZaOeFwiGzFcycKF13nmp6yDnOBYwidSR1a4?=
 =?us-ascii?Q?DhbMHvDok3I+DPsidNYhrvLGEnfqIgrxC8/Cl2aRtaLlA+gK5OYJ9si1A95d?=
 =?us-ascii?Q?mWVI0nFXQZrLXmhNbBMpjtCW7Ve/t2l+Tej1mbsJQgblfsJXTmPPABvI67qy?=
 =?us-ascii?Q?bUcp6PUTAKiiCLHloDub3SJRPBvaiWWAzgQRHU+57gyO9th3e+i0ZyyRwVey?=
 =?us-ascii?Q?Amtc9pH4L01pSQAhEKrff2ImpVP6EWPkvQrvAhFMz54oqxGJvLU1rolvEtdQ?=
 =?us-ascii?Q?azyZZAfnURBjzNWt8EYgGUR4dw/aq+pVuo4vIoBaryE618WY+yz+hZmE+yvs?=
 =?us-ascii?Q?xb7LPW9mgN+duMXyVaSvJ4XIvm4kqIl4xswf4pPx2Sretw1iwg6MELw0OsO1?=
 =?us-ascii?Q?O011cLXdXy5kv3pzbuCmZIoJxpjTFpC+BNgemlORkxb74jZSHb5BoK45ieAI?=
 =?us-ascii?Q?fH5J1gPq0Y+82JzyU5MHh9NYe73JmSdGYCDGF0rMJduczFSc6G5soAShUPzp?=
 =?us-ascii?Q?JqJ51xSGdLVJiBN8ieN3iI1JTJv6/i0tdq9brm8pSt+2HDyrUE0cNcNmN3jT?=
 =?us-ascii?Q?zHU1pZ4oFb2qI10B2ZIO9N3TuFUqh+sARfZyefXaqp5RwECFDfCJ03++jfiA?=
 =?us-ascii?Q?GyWlkGHd4Js/d6U9yH3rIW7zaCqy3/OUf0m6S9BI6dRRDFgyE4aiaQXygl6A?=
 =?us-ascii?Q?CC/j7WEb2liJIvjC4URjlNRn02AiGXrjFBI2W7oMYXJJI2YnUD6du0ZMBIpu?=
 =?us-ascii?Q?FbtZQ2JXG9DIJ8hPE0st9XQ/Ti95txxAhAJ6uJlkBdd+5HGA13akTlU7oQyR?=
 =?us-ascii?Q?Kr+Ycf6fv1bTRUluIHPv8KH6jGF8+TqwRKzj8gR5E5K2aKMka866AjLb/kT1?=
 =?us-ascii?Q?hoNDAeP4QBEvRePhm5QzNG2t6hj4rWvbC/9abC1RYs4GoDYWx64OhF79vea9?=
 =?us-ascii?Q?4NaL4LCyaNMvwSt+Gowgi5gRWqsbYqojJwu5y1HZnKw0TrhnskULPZU5vHTI?=
 =?us-ascii?Q?TY/lbPzvDZFOKkDyxeRLXZWrbzkJEeGswDFOBNLozZBPrDLRPb+CZikH4vKK?=
 =?us-ascii?Q?EnyFqjvNOTAH1hglsCisojAitEu/P0OJXxdC/llsOrNUbbaL7zGulxr4+NDS?=
 =?us-ascii?Q?fDik151go85RhDVPtHGFX0/4dk8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NZSXdUzBP4XaEvjpyO4irsxnWJnlQDWNPW8WAUHIcjcQdcD3pKRhzJb2xucL6r2aTrIskIvgnDuEzxZSlinUPxW87UrNc0idwcfioPmlICFpYUjXOEo7btXj+eTpLrmrP5YaUyDfXOoVQP5TxvnGdbv9VhX0F9ixwriqgTQqEerkl96T+nibDwEhsyvEPfG356vkrlupMb+UGK9q/WHqTtqO2sgZ7iNtzInlfRv+2wJmvWUPKo+D5ls4wHfd/FZV+PQd+BWmVqCyeAwXP/v4xSf+RKRMgZ/NcvXCDlFH8Q9Q1+9+FWgAxhcXIhPvCefXxWrFcT4fTeXxMjhFg63pynqf8dq61HTGSPzKz+sbCfmFQxKR0fAdHTAtYNk5XB+rZILEc5CbsYdRxNErVkpN/NBNxzRYIpMF6Ascg5hLL0l6NjkpYJvR1HgxDLuMxwvr
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 06:45:42.9648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e5b5fe-4d4c-40b5-e26d-08de6f8280d2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5618

PCIe r6.0, section 7.5.3.6 states that for multi-function devices, the
Max Link Width and Max Link Speed fields in the Link Capabilities
Register must report the same values for all functions.

Currently, dw_pcie_setup() programs these fields only for physical
function 0 (PF0) via dw_pcie_link_set_max_speed() and
dw_pcie_link_set_max_link_width(). For multi-function endpoint
configurations, PF1 and beyond retain their default values, violating
the PCIe specification.

Fix this by reading the Max Link Width and Max Link Speed fields from
PF0's Link Capabilities Register after dw_pcie_setup() completes,
then mirroring these values to all other physical functions.

Fixes: 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")
Fixes: 89db0793c9f2 ("PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling")
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---

The link speed and width would be negotiated through PF0 during
initialization that controls the link behaviour, hence it didn't broke
the driver. However, the change is proposed just to make the driver
compatible with the PCIe base specifications.

The fix is implemented in pcie-designware-ep.c rather than modifying
dw_pcie_setup() directly to keep pcie-designware.c independent of RC/EP
specifics and maintain it as common code.

Changes from v1 to v2:
- Used FIELD_* macros

v1: https://lore.kernel.org/all/20260202072758.101845-3-a-garg7@ti.com/

 .../pci/controller/dwc/pcie-designware-ep.c   | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 771241e1a2c9..6b9f90810fec 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1094,7 +1094,8 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 {
 	struct dw_pcie_ep *ep = &pci->ep;
 	u8 funcs = ep->epc->max_functions;
-	u8 func_no;
+	u32 ref_lnkcap, lnkcap;
+	u8 func_no, offset;
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
@@ -1102,6 +1103,26 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 		dw_pcie_ep_init_rebar_registers(ep, func_no);
 
 	dw_pcie_setup(pci);
+
+	/*
+	 * PCIe r6.0, section 7.5.3.6 states that for multi-function endpoints,
+	 * max link width and speed fields must report same values for all functions.
+	 * However, dw_pcie_setup() programs these fields only for physical function 0.
+	 * Hence, mirror these fields to all other physical functions as well.
+	 */
+	if (funcs > 1) {
+		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		ref_lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+		ref_lnkcap = FIELD_GET(PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS, ref_lnkcap);
+
+		for (func_no = 1; func_no < funcs; func_no++) {
+			offset = dw_pcie_ep_find_capability(ep, func_no, PCI_CAP_ID_EXP);
+			lnkcap = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_EXP_LNKCAP);
+			FIELD_MODIFY(PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS, &lnkcap, ref_lnkcap);
+			dw_pcie_ep_writel_dbi(ep, func_no, offset + PCI_EXP_LNKCAP, lnkcap);
+		}
+	}
+
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
-- 
2.34.1

