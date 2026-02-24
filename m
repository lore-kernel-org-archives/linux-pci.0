Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47FF366DD7;
	Tue, 24 Feb 2026 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922320; cv=fail; b=Z5+TqT4qQDIn9xabMwm6SxwlxMN1/4UBjbk8AeUXSMxX66kcve69i54HfsVyBZDBAs3fIZsnrUsdauKhWsWOQVk2D8TYd3i52NEbdpo082gLybbG1vy4xXjFe2DtJXGWYALNlWdqyIA0dOhObxYruDlLO4UOCcP3gFdj+plXybg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922320; c=relaxed/simple;
	bh=4RvFDvY8qv2JKPVHEcENWd7WfHAHEMzWfeHyhUuYY2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOLoxK4PPB/CKxxNE4Wia062vcOpHz1jxxRAa/ypvTn/694yU05r8nf8Z9d8oVo5b17YeKfsjtxieCZ5/Qv6vx1NiEuMrhpd9/e/lb9OcezoMdpYvr0mGAR5htcsdOIZ1HT1hopGIeR8xajNTlidodegiwBvoBiUNG8HS8XZoJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZwQ/lLo4; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZwQ/lLo4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYqxHk5G5w092sU9P3kGerGvqoFjgCH/IUuECmgkGJaxHN+tXTrDXPbo+ILKtuzyHmlxWWUs+hXK4eBQ0zuKQFGbHL3Iw1+TDjqsecC8wod7BuZ01l4RdDd1lfha7rlaXiNMdBocW9ggXh7zWLLA9knjjfHPkcd0bgf3uz3VDUNHXphnsiMX+9AJonx2BKVJ7XQ99Kt/8FMOhyJo5QBH42tnd0B7iYviqe9NXRtafKPPJ4X05W403ZsLT0PRkqKkAeRy49jkf9bUBI6R/vI2324ZPxaYj2MHxVdmI3loGFS5IGAcGe/4hjHsV3L42m025bauxAzZQ52lfP0dUajdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ei/HyK0jkgg65by0H1Gs5PdHcZ3/kc72xXVdOoDuyKE=;
 b=E/vyZPjaelQW4SipUMijg6ozQFb0xbnf3+pJlb0OrmkimOamfIJiYC4eXUVGLJWYCeh4wcJQdb9tUfSPsG5ub4abkpfzM1Iu64tcUtkTU9yTX41JOMZBdif/VSGBEzbXf+lmmArSfMV3wxHcfKQz9ao5fwdOBZ3lZAs+BKapxk4sWDvZYNbrx669ZBdCJmwcaNzqMnuyQ+JVrR4fj7zet6njTM9wLIhgKRpOtGkCejEQEfC+MC6vW8p7GSX+Jf+zRvVzR2bVeLCl4Vy3W9v2n3hGYcC2idaUslkcivvXBtX8DV5wl5QzqpepRCK9PxpC6PL7khoMYgC6avY3DBaScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ei/HyK0jkgg65by0H1Gs5PdHcZ3/kc72xXVdOoDuyKE=;
 b=ZwQ/lLo4ECmopjgmedXAmQOEsEomldMWs3De0HaYxwTUGiiSAdelL/ar0nuXYzqWXQMuMr4WO5pnAvF6blYFfgvT7tp5RAWuwl353swBcaLOwYvvoW4EMfPtQnZvHpMPwY41B/HLxeKGZszyC+FMkVTTb0q2RlxT8FEA1Kh7cAI=
Received: from BN9PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:fb::30)
 by IA4PR10MB8469.namprd10.prod.outlook.com (2603:10b6:208:561::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Tue, 24 Feb
 2026 08:38:35 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:fb:cafe::fc) by BN9PR03CA0055.outlook.office365.com
 (2603:10b6:408:fb::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 08:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 08:38:35 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 02:38:34 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 02:38:34 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 02:38:34 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61O8cKBZ2414416;
	Tue, 24 Feb 2026 02:38:30 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<fancer.lancer@gmail.com>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v3 2/2] PCI: dwc: ep: Mirror the max link width and speed fields to all functions
Date: Tue, 24 Feb 2026 14:08:17 +0530
Message-ID: <20260224083817.916782-3-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224083817.916782-1-a-garg7@ti.com>
References: <20260224083817.916782-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|IA4PR10MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a94f943-7891-445a-1459-08de7380198c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2GYnW5mtiMFYxytNKWJ14mFXxy9xMbzQaGP/pN7px5uBYD4X699FLEBmLChZ?=
 =?us-ascii?Q?KYCc4udPepSXQiV7mdmRpaMzjaLGDEDtqHCKFjPSE8aH9zfQ9Ftw0WtCUabe?=
 =?us-ascii?Q?JedGYFGHsj8jYpKYVToIv5B055Hv4eQTyXrh0xEOywPr4m/jlgSyfMwRwqTg?=
 =?us-ascii?Q?KImy4S+kI7FGcC0WtdULUIVFdDLW4DQYr/tgEb4w8mL6CKL/1dhROp5AFw8k?=
 =?us-ascii?Q?k8DDrEN0HNIcCCl1Vbv+XoyyFJ0ORhyJBhSVS3YQkTq8TDiBufhu1Dw0QKD/?=
 =?us-ascii?Q?wuTMhW2tQei37UGYQPZrSzwteeYEBGLXBP5LcnJT7PPafiKktZNC9gVEasvz?=
 =?us-ascii?Q?zc95EdBXSqXh7wi0TwiZGka2HZmOT5mMtM/Z1ILHKHc4tXS/CnbHn+aKZZw+?=
 =?us-ascii?Q?MdRBvlGOk+8WBW1Pdv7vNIAM0szauWOS8DRLEf9z8+OfalCDEixoZS2ponHy?=
 =?us-ascii?Q?VEZR4G6jLyLMOtpa3UkenQNRYjejFJ/KFyCZMIw7KedAlCnk7/29H/9vTYgX?=
 =?us-ascii?Q?90HxTB05/2h6oqm2FyYlQyt+Hh1u0IwYM+80/TkeMW8mF/QnUp4Snexiq8XI?=
 =?us-ascii?Q?w6Vh2eNZmL+crMZpt0BlmsP0tl9bH60WuHwjln+UWy68i3PDwle/smbIPO3N?=
 =?us-ascii?Q?1QkjJuMFVmFt7jYWUVRszxKNYb38lzPHpob7fmaAMmgkh0FePswqBRVnNOEU?=
 =?us-ascii?Q?uthdBLOk6AKRQ6e6AaWwBWpTQwLwI+3k54q4ZCY/EjCL52hgX3KEX8MK7QJh?=
 =?us-ascii?Q?knRYVncJkQosNQSbF+Cn8vhZOOj02D2sHQoKlCS0VojeQU8ZuPCNrlfVATd1?=
 =?us-ascii?Q?zC7Llax0dm8Xjpkr6yq7iOD8rXtaC3gxoJCInyw1tYtiS3jgd3zGIViKgYQx?=
 =?us-ascii?Q?X4YNVXk5ApYgesb4mgIZkt8sKS0wagHpr5lO6TOTVIsNf/r82jlyj7mqTyaJ?=
 =?us-ascii?Q?HkzArjjjs7XP27K6q0UIsyX1yUJNYy9qhXPW4vsOnRem5taiyMug4pzztCAs?=
 =?us-ascii?Q?T4bYEmv9STg5C0yk7lOkiyk/cniAy676mjHUPjvYhH6bo7Pw/6HEJ7MDwkcl?=
 =?us-ascii?Q?xEzyhLmWTo/A43FHHWJ3BRKXgevjcbsZk6euACC4T+6y6ZDcIAyxfwFY7D7c?=
 =?us-ascii?Q?kFBC+C52t3dFe1pENM1aV5l2s9yQxy/MNCqR6gPIMLPNWxGX+XZIhgAuM697?=
 =?us-ascii?Q?al/XO0H/lOHerID/2yQYbjtBCFdrxtqntfYsZuYkk9Ze/EtSW4E8w1sOlmd2?=
 =?us-ascii?Q?uBZuzKr+xqeriFsQOLqMOe6cB3fF16Qknhz7y7RqE1eUHkNoomLABz+ZbMq3?=
 =?us-ascii?Q?PGQRdycJ6kIDIc9MgcYmNvNyT9IR8FauQe7PihsWyEpx0DjmbpBVgsI/6SuP?=
 =?us-ascii?Q?pxyeXa4hUVaazAB5/A8Z+etUDmKB9LAZXtQ61y+8QaqGAMaFGHxdRj7RTlO3?=
 =?us-ascii?Q?8RB/WlU9jVsBOSxZP3RDOKnck2YFE4covs5Q0eYss6l0xhA2Drl27k/90gEk?=
 =?us-ascii?Q?3jDVjoFu1OHTdESYruVev+qktEg49ex3dpHFLwK8jGQo05/ro0bjaSAsVQWt?=
 =?us-ascii?Q?IFs7n18Hy0MRM1CbOlOM5ApueNxkevbgj64WOAfmHEOeQLoXgwshGsxi79+i?=
 =?us-ascii?Q?33a3errK43U2YOO7ZmBmlmUy7GhLl3c+PZU2n9e6lWfRo69h7gpquH3YewvR?=
 =?us-ascii?Q?olaWxDqVTxpPPTyX7vJt0JqhwRo=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	obYN6X74wdvJvMCMs2e4HFKmUmuCZFimzs72aPQBAJ80CZTGVVJm4GS+El9kqSYERP+TGEZwvn8V+4Js9Ym+Sv5Fe+/o/+OPdVFl1gDEETO1tChVgFgopzKGaHXCd5En0DgMO3nFVbg6arPGZPH/llm+fluCYTnujASP9kYx/tG4+OTqBk4cy6lqlCqWLHztp1YqFRSgxYyPVrScptH0aV7art21YFao0JqMWD2r0LsZo4XUtvXCpXC1FUDpTq/vjn4xdpNNtJ47j+yUMbAhweNhBSu1qO8cy9nIvZ8ilrY5WYnpMAyIUorkt5oHzi3rlODQ2juomCd14YDxH4mPDGDfcXXl6AV9VLoq8+4smePxBUEXPa06hxvziIpp/UtJW8um+7mnZMwA2J7wdGlkubIb2LVtT9Y7eOAlyLFMPgDNc9HpNCVRhIZBNZxY6gqN
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:38:35.3566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a94f943-7891-445a-1459-08de7380198c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8469

PCIe r7.0, section 7.5.3.6 states that for multi-function devices, the
Max Link Width and Max Link Speed fields in the Link Capabilities
Register must report the same values for all functions.

Currently, dw_pcie_setup() programs these fields only for Function 0
via dw_pcie_link_set_max_speed() and dw_pcie_link_set_max_link_width().
For multi-function endpoint configurations, Function 1 and beyond retain
their default values, violating the PCIe specification.

Fix this by reading the Max Link Width and Max Link Speed fields from
Link Capabilities Register of Function 0 after dw_pcie_setup() completes,
then mirroring these values to all other functions.

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

Changes from v2 to v3:
- Wrapped the patches to fit within 80 columns
- Updated the term 'physical function' to 'Function'

Changes from v1 to v2:
- Used FIELD_* macros

v2: https://lore.kernel.org/all/20260219064511.695086-3-a-garg7@ti.com/
v1: https://lore.kernel.org/all/20260202072758.101845-3-a-garg7@ti.com/

 .../pci/controller/dwc/pcie-designware-ep.c   | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 771241e1a2c9..8041c7a0d381 100644
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
 
@@ -1102,6 +1103,32 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 		dw_pcie_ep_init_rebar_registers(ep, func_no);
 
 	dw_pcie_setup(pci);
+
+	/*
+	 * PCIe r7.0, section 7.5.3.6 states that for multi-function
+	 * endpoints, max link width and speed fields must report same
+	 * values for all functions. However, dw_pcie_setup() programs
+	 * these fields only for function 0. Hence, mirror these fields
+	 * to all other functions as well.
+	 */
+	if (funcs > 1) {
+		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		ref_lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+		ref_lnkcap = FIELD_GET(PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS,
+				       ref_lnkcap);
+
+		for (func_no = 1; func_no < funcs; func_no++) {
+			offset = dw_pcie_ep_find_capability(ep, func_no,
+							    PCI_CAP_ID_EXP);
+			lnkcap = dw_pcie_ep_readl_dbi(ep, func_no,
+						      offset + PCI_EXP_LNKCAP);
+			FIELD_MODIFY(PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS,
+				     &lnkcap, ref_lnkcap);
+			dw_pcie_ep_writel_dbi(ep, func_no,
+					      offset + PCI_EXP_LNKCAP, lnkcap);
+		}
+	}
+
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
-- 
2.34.1

