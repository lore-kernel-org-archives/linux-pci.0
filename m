Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BEC28506F;
	Mon,  2 Feb 2026 07:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770017301; cv=fail; b=CO0ZCxAJLbT86tao+PjuaIyIUrLmJQOu/ad6DUFuJemeIco0X8w5GkRrEuJQkVlHQ/s8MfHaUWjMonZOujdBcq86fdXSgrk9N9+CxMGxh7vBO8r1nJVK9jVhvqGQXZlV6rwlqeBLzhYciuHILhe/Av0Li8wl0yJeB6BhT05kLgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770017301; c=relaxed/simple;
	bh=2ufqe2sazqzfg2XrejjGswNlNU0WiIMZ2sCWc7YrjvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePjcqo9vHLTzGWHGCy7sT61FV+1e+rl9CktDcGTKKeuBt9ZloJL82naT+xlm42Wfaix16IGjaEA/79qXjqFCRnVSv5BZ3gI2E3L0JN9YZ0W4EiiAf35m4mnWWBUaSP1wXHLC5jO20qod3kEUXN/LVV+boz3cFbk4qTsTMy9dWD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QG7MOqN6; arc=fail smtp.client-ip=40.107.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QG7MOqN6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m64DolVsKS7jd67IEk9gtMTGjf3B0Mz3Ed5sRkyzOSW9Bhx6XG5CJvDO+Ygmsk+T9kBL9Lo4Mg+r/MxsdTbaLpq4Gny7BY/Tnk+ra+oD4CkRuqUm3g2ta0rtWPkRRS2/9nuRGb9r9CpuapRqCUeiGMA6jwoqTz0deDCLxxf2FpVNbeXaEHwu7u2wPW0rHLeOq40kDGkvZP/BS2QsO5KdZq1rFr5XxnrWTXylLwZynHljI3OWIqUJgrolGIcYmF395fzBrzz+5pDIzaHP6ObeFfNQ3HS6ljqEZ0jqvbS4oQoy/DoeUQCbo5OquJjDXP5PHC2plsKHMfwQDvShPhkpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xR06GW8LQNeWQ4r/bPId3u9uM2lKCEFi4x/Bfqn7zI=;
 b=NOuaIlNuvyKkm9QkNwtAyp324f6331059DQb7bi5fyNYCPSC7XJB9Zxi0R4jUu2QQACydUK3F4mZejoDtxCi0znJQ0MzLVqMnQlK4OiClvq2dKNZl4sMl3lUQiyZgWptPctTceHLEzE5lXs111SDUaKt4GXFbJkLh0elNARxn6j3oGE/438+lF5XLK+X6GCEUkKA4vrrCc3FRkFvaT22H0Glqpp0diJAxEpl0uwNGAv7WS4jdPko5z5363zhVnMxR0GlOPL5DRA3zlavGWFvVniX7kHYSraqkaIJxxddMdrEyWQcrjWtuOV4K2rOoFlW9PW0akUPTI0tD80wmRv3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xR06GW8LQNeWQ4r/bPId3u9uM2lKCEFi4x/Bfqn7zI=;
 b=QG7MOqN6qEPbt6Hf0XdwXPcUD2PBnVARngPGYcC/HT6tZ9qtSrznrNtRZqrP1PKcVpGJOycYYzv6hQbXYTlQN8RE9cZSyMayIAgmByKSiYPcTq4bYTGZS9ut2c86/b2YFbuRdpLMJaB3ZH9N9T7724dD5800hz36diIGFcb6Ako=
Received: from CH0PR13CA0037.namprd13.prod.outlook.com (2603:10b6:610:b2::12)
 by DS0PR10MB7203.namprd10.prod.outlook.com (2603:10b6:8:f5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.14; Mon, 2 Feb 2026 07:28:17 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::81) by CH0PR13CA0037.outlook.office365.com
 (2603:10b6:610:b2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10 via Frontend Transport; Mon,
 2 Feb 2026 07:27:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 07:28:15 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 01:28:14 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 01:28:14 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 01:28:14 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6127S09O1732804;
	Mon, 2 Feb 2026 01:28:10 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<fancer.lancer@gmail.com>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH 2/2] PCI: dwc: ep: Mirror the max link width and speed fields to all functions
Date: Mon, 2 Feb 2026 12:57:58 +0530
Message-ID: <20260202072758.101845-3-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202072758.101845-1-a-garg7@ti.com>
References: <20260202072758.101845-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|DS0PR10MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 248cdec6-005a-4d3a-f096-08de622ca0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QpfqoBrOYm8vVs9zGXnXyhoNu5BnLUVYIu8TPIEBzIxNioi8hdZ92/dswvke?=
 =?us-ascii?Q?bRVvsMH0979GTLUaEaelfbS1wtBMRHMLM7WejFwSjHwHWNjVvgbCzJaxtH74?=
 =?us-ascii?Q?cDNkO69lz+ZaPLhPW3kN2CMHdWIg3031iuH888k46qLB0Aowe8m+qp9Ub6rG?=
 =?us-ascii?Q?zR7XeMEqKzSYitpI7D3nGWqT7eXg4Bqul3k5ZmKmSAA9PI6wncLvb7hirFMo?=
 =?us-ascii?Q?cxNUTY11ewGwEf1fCY8x0pIWqEhntCdjujq9QJBjk4F1TXupNpftR5LTG2BS?=
 =?us-ascii?Q?pk99/w4te35JU9q24ydEbAYQ1q1COvPI5U/BUZi1Ek4brD2MphmmJZxDRKg+?=
 =?us-ascii?Q?jDDGPnHtaiZpEj7NtLwsWl0D0kPRLET9kme4RKVbSKVH/53+pIHzXshFI71h?=
 =?us-ascii?Q?FoWNUpZgRggF1LMJvm3mi6hAmD1xLbD39eaiH89WLq7oHQIXrv9etpTlfH+p?=
 =?us-ascii?Q?bhxopatXb5ZplwnrTxPfMsPN8RtYDvc7rVsr7Pjphy/dRtfTLp6ZyCOngJdM?=
 =?us-ascii?Q?9L2BdOx6PDKy/j1fFcQahrFBP65QmFkcocJnX+tiDWPCERJR6oBVL9EhDpDY?=
 =?us-ascii?Q?KoI4QhBuXcK0KGFMcflIW69r9uiUbIWO62dDAh/Xa2riPWjfcqXDpJIpOKBl?=
 =?us-ascii?Q?d/oJCTx62drpgqdiMWWopVAsrV8Yx0VSvoXxzP5OScGZ2f20CPPRdToYY0kW?=
 =?us-ascii?Q?k2xpQklbEVHilwWOI1OYOFDEa/RAz1dANN1EUlZEXLk06SpQTrQwoyBAbI22?=
 =?us-ascii?Q?ZFgicYoddX2E7bSLhjsy0b4LyMRxpHssw9Guq0y9CAQyiEUvjT4iclCsJsae?=
 =?us-ascii?Q?GT/s7Xu4N006SjjrOlPSx0rnHuzJPjVsTTd44NGbr4gdhLV0jFMTlgwjvmqv?=
 =?us-ascii?Q?aXcfsnV23nxTalZ8i9eBEUo8MpBc8T6/fehwiDsfq/4HUkwsjBd8XYVKKNCB?=
 =?us-ascii?Q?en1/EHQCP9oA4WCAE4Nd79MheDC4JUv/M2xx1aSILhdoFmVmTLbiBOuheuAN?=
 =?us-ascii?Q?gkb0y3xgYNVf2hCHr/uhfQpvq4nkcj9vfldHEQqc66C7IdYPEZfK4Jm1W8XB?=
 =?us-ascii?Q?mcIv9n+jA2Oo5ufCHm1MzecGOR5W3VMu9RKhew4upg17ys0nvMgOR8dLiAG+?=
 =?us-ascii?Q?HccsRpNmISoDgOqtasTD/aBONI8EDJtSyIIhLux0MX8dzFZCoOuGVUb5mbk8?=
 =?us-ascii?Q?vULfde4gWDVdo3pTLSqj6HNy7Y7HHoc+nI9VV7aF59FydKnrBAv3rvC9CcG4?=
 =?us-ascii?Q?FmSQ8u1mY159lpesiy+HmvCd7r6is3oFB0ge3kU+NsNkUtRV4/b0rsYrEEHi?=
 =?us-ascii?Q?4f39fgC5fymFWoDNIY2Zwv8gBrGWD+O6YcKUKd9tRqAaA2U+QdPgDzcG4qYq?=
 =?us-ascii?Q?dedrqPRn2LCdtmOsqAUlYQM15/PO7Rdml74pBysZThgWakOg8a/4A9VarmJh?=
 =?us-ascii?Q?QOiIllEBehRe4wbcrGZXdGId8hL7LNNOnQ6Bcx6KPOcD3jWVRcE7V6DRJhac?=
 =?us-ascii?Q?sNqfuLAUKIxlaYzQyMoIgpViOoo+cnjBHVSPSCu4EAS+OW0ihN4q4Lk1Wav/?=
 =?us-ascii?Q?7N4ed5JL18sAb1LRe2fSap04HpEFae/Tllw3CB1u74f3vGaQwGTgIGYp9TL7?=
 =?us-ascii?Q?Vv6NRjohRaHYq0wkwU9HVicyxtWde6Jisvf7yqm8LzKkdwD8RUS2wF9R+Lwo?=
 =?us-ascii?Q?BXBRiZ2dN9EyBtze9+75hSFwTak=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	htSIi5oB98IJFb2kinKir2MLcr2FmrHyWkkcYatp3wW5RZjWqweki3tbZFpuVdduNlobm4EgX1emCvOFzuz0v/zAhvEpX05HdqAZcIQ69rDvay6Kktc0LBH7y82EasvJXN0Qqgix9bngkU2E8m0CXOOBYkv4GrWl+b3kxEmztLGAiqwjaYW2ePBVRaPYEQkm0I2gnSlgdlScuTkJalsEJXE5otuPCpNJAoa3VBmlWlMdPdHS5E0mnJhr4z2nYiUt4rAAFinX6wshFw4iyR5w42DKpQKho8OyZ8EuLRIIq4Nz6s7II8f8gPv2xT4hX007IeTyU9yRYn+nOjcRiiCGdtOByt0NVqDD2w5VNgSn4yR/jMUpIxQtqX7rEfuRWeaumR/LjGxqw//nFP4kIAGJss1jkb8A4orWU8LS6dZ9+TiTnL3+3r5sBQeW5dyuzlzV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 07:28:15.1162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 248cdec6-005a-4d3a-f096-08de622ca0fc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7203

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

 .../pci/controller/dwc/pcie-designware-ep.c   | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 771241e1a2c9..4ac25da2b117 100644
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
 
@@ -1102,6 +1103,27 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
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
+		ref_lnkcap &= PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS;
+
+		for (func_no = 1; func_no < funcs; func_no++) {
+			offset = dw_pcie_ep_find_capability(ep, func_no, PCI_CAP_ID_EXP);
+			lnkcap = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_EXP_LNKCAP);
+			lnkcap &= ~(PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS);
+			lnkcap |= ref_lnkcap;
+			dw_pcie_ep_writel_dbi(ep, func_no, offset + PCI_EXP_LNKCAP, lnkcap);
+		}
+	}
+
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
-- 
2.34.1

