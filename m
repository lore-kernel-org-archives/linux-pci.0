Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4D2E542C;
	Sun,  8 Feb 2026 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574141; cv=fail; b=HuZKK6cYoQCCwXqxGm9t+Ol3UGWoZabkbfYA6EQ42LU1ic3MKexLIhKPUmuRGXM/ZYgnbyDV0XxGw9iVDSkyw9iphha3QhGSXPyVHFqvY+/9zv62ls7hKQk0+QxAJFFUjINen0TOLddIw4iYa7Sy1cfuOBPWgh/L/9JNGjH1+5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574141; c=relaxed/simple;
	bh=/oa9Fr18invsNvrH/yb1jEVH7atNkYQ0TVCuDZ44o3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fq1BgwBl1dzyccCJiNQ+TAIlyaE7kGToyOyJfudcJQleA+jmP7IOFnQzjZn+QvzHAqPZqbqSfOe8KYr1VwaCgetvrMgBfA91N38pq7P/y1vSoBYTpfGUtHIx78EYwcdSPkcEf2DXMotuFRts5DglBqlUj8sd4PasXTXuqIUFg90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GEPx7mDh; arc=fail smtp.client-ip=52.101.52.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GEPx7mDh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDUoVi43lmVjjtDW1Swg/nJaM75gAdOn1oFzx65x9xBsfGTenetMD+acJxcCm0iH3WzeYMstTaHcY+WQ78G4fv3/jWdlv4TPQRH9l6m52kuAAFtJmcDNCvDCnjvq9uAiGJhZeaEewoQNTPXmAFqbU9QPFkxURquj2tQO5CyN0p3FrZZwF02wWjfV+ZeTV4zmZKbEprUOaCtXtrSnINK/zgZ6aZuH9hJq8fEdmLzV7HkeQdHXNTQvS9/EH7kQfRcz3LGMKwguYIplFZ2eaiSkm3vznQPd07d3YkpRGyc72deQvkC4aHSOGefYWBpXT9ywia4bUGd9CPuHi+YinNHGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bicdfWhspIQjwORHC50ZZpPcgh20CrWsEhxcgfpcn0Q=;
 b=US9gECL91eHIXkv5yXsoz4S7s5qHRExezh/dyKSQ0C1khMvzOfD4U5kG3posM801NLhSbsIlcouhGxxB5cYdBi88CCE52Xt4hQVxWTmTjVGFx1326/zxLiWEuLaUG9ZSc7uthKa7CkdGSP9ABTxvXDCZiy6ezBj3Wz2MuSNroDALfgTpzGv5fJ1NDfKwGgxfzjwkCzvAE3XP9MdMAmkNcoqLD53ZsjSXVrzZOWHZF7gCWWSc/ZkNgIjfd4Y0XKHF6G8iPJus3ulg6XGmHkiwmtUMtXJE/Gbt/S37yX8pCNKQnrxACReO8HH9ty4fqZ5QfTReemxG1LefAq9O3yOl2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bicdfWhspIQjwORHC50ZZpPcgh20CrWsEhxcgfpcn0Q=;
 b=GEPx7mDhPlfisq5d+x1pkz64jQKUfMYrV5o77JIO4EJ4QqRhXt/JBI0yknzjuF9w7T8yd0LnpM/Ll3JTb+a9ZKy/dUxWiYn3dV9AQ40QYHRoTsNM/2xzSzvdzoicLeGKxvvuRqry/9XKEFHFX3oSCK3xOqp1/eLVC3zvFSo6Q3S9anKebU8BNAsqdMH0Cqq3eqKLdlgQaf8R7Y+NU3n4cnK/ucXeoqc4dijFX65tZIG6SXDykgTKqYCKZMkasErkxchWv++u/EZI6x14pGHPhMKxj6/JAJslaZIHYOv2oIh5IwNWEX9JYbdskPawe9bvrqb0ij2JqVb4fn9HaIzXOw==
Received: from SJ0PR03CA0120.namprd03.prod.outlook.com (2603:10b6:a03:333::35)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Sun, 8 Feb
 2026 18:08:56 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::76) by SJ0PR03CA0120.outlook.office365.com
 (2603:10b6:a03:333::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:08:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:08:43 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:08:38 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,06/13] PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
Date: Sun, 8 Feb 2026 23:37:39 +0530
Message-ID: <20260208180746.2024338-7-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
References: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: e59a912e-b66e-4e21-5609-08de673d1fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vFsQD6rMIooFfL3wnIsMIEqbJV1Rd7jR3i4imYf36bR6aNHsLF5jLyXLlTeW?=
 =?us-ascii?Q?eC98bOctNuyIfmEBG+N1635fqqF+Ymvku3mxIRic+ffs6dOXJBqdE9dP8n70?=
 =?us-ascii?Q?wmxpq5HDJSNSJ94WBg4LmtY1B1wBK7GHiciHKfxP72DDKZVp3LLCHWJh9G8q?=
 =?us-ascii?Q?uUeuX8qhVXiTTb0JAdq6SMKx9S1jV+o7dT7PtYQh7nvFEonIT+cLyXUCNQKT?=
 =?us-ascii?Q?qaEA70p1NSUeABzfiXW0xhwmM8hvQkiYW88Ua50WfNaVP8KtfjuHQ6mvny43?=
 =?us-ascii?Q?JqLoM9UGOVgeCdSlhAtkTYGp82ZWW78LyOXnC+OVtMmhE/ixOOivPZtVUqNR?=
 =?us-ascii?Q?AuWRaJ0sHk0UXqa2w6mQxd1mCVqcM4W5/BDX082mS6R+ojs9jHkR4+OQFyKf?=
 =?us-ascii?Q?cdZD70be5VyM2k0xqi7bbh1KzfomE8Cf3z42POkbH3Rr+0VtvsHbq7LwrzOb?=
 =?us-ascii?Q?iSLfNV6gR+ojrzv9BhIHMV5S2VhUZJSz7E1JN/4k2pARMbj/IE8NYFXoNHck?=
 =?us-ascii?Q?jFVTdwTUu+NRwQqLn2SAP4dRCIRTNAbkfwodmx1LbxS+K4bGbVpeDEexfbjE?=
 =?us-ascii?Q?prNSbHaozlXRsUmlDprjmsFTKIYGiT/md6mqbO/1V4Y8PcRkMmMzooUovQ6r?=
 =?us-ascii?Q?1k4lUsLc7YxcoY/K7PEnZDcngpYNWGcl0UwGARhlexnmK8t0jOwfAxaNQJLH?=
 =?us-ascii?Q?/0H5Rg+LXV5RDkQMrLOXzPCNPC/wURpzg6UweYAMNmtw1g1tKLqnOVEsyHfX?=
 =?us-ascii?Q?fFHplPaS9NkabyjSx09MsAp8EwPsiA19Zevx1oGu0DbbfjdWBatUf5rg+siR?=
 =?us-ascii?Q?X11g1oz+8P2URK0IQQJkBCcBObCb0AqbBdY33kp+Ay4dej9zEIQ0JZ10WVLg?=
 =?us-ascii?Q?v02DnDqyH+vbYsnmjkhPiE4k1Lk3qnFYcoojM6KigGsIbobwxBmAxnFOKKND?=
 =?us-ascii?Q?2dVoTEz0KFDK/3evUXhWRZrQzPgynKwYyTXXMVHOQQphqekekII6KjwcCcPs?=
 =?us-ascii?Q?Rp9F03IQE/Q3XjgHLtniRQr9xaMfoj23toGS3FajXGT1O5+VKx4kaRfs9Sfq?=
 =?us-ascii?Q?QIdnsuAyxye7eVHRKXaV+g5Gv/S52c833CWWC4gQVuOqHZ2mMcq+St3DGQDU?=
 =?us-ascii?Q?Womc3nzpfGbvD7l6DcZiciy9JJ4Ctm+D8dDcJL8Y9WwkFxyMszzUU4PtzVEI?=
 =?us-ascii?Q?9iyM2FYkwS1HmTPI70rTlsIbZX6snts71iG3T62HH14bZn2jX0LyYheZDqLG?=
 =?us-ascii?Q?0qF3xcBMFR/ps0y9SC+5utS8tYqJ6dDyGg9phn81RVrIH2WgxE6hrykvPlvg?=
 =?us-ascii?Q?B47m0/3Cgzz6DWY2sXV6V2SGrfV7yYdKHRREU7u96IGneaQ1s0OQWJppEu+Z?=
 =?us-ascii?Q?OZwRoq7Irak0mBO5/QVkVZytwOjoJJFdLqDP312QNVqNYF9VNj3zJdXS0ciY?=
 =?us-ascii?Q?pqeef4ah59t4EFlNd4qDHCrTcv6m9fIZcVyhpnR81CqDzHH7JK/4p+Z1MWDD?=
 =?us-ascii?Q?EsTTV23D9QItsBv0rKpNqd6hJGwexhPWduzKQOSgTqKky/R5gDkJm5WRpfN0?=
 =?us-ascii?Q?k2ITvKXUyyf6X5+/6HuZJqMkyf84ewVlvTMzsNQ5iE3eOf5tEusHbgvppAL4?=
 =?us-ascii?Q?jrGZwrffsu6t6Ze1HiQb2gw7djnZndzRudLafAcljcoRhLCT/8n+F6gcFRow?=
 =?us-ascii?Q?F7JgXxuPjxcNU1Bzmh6xAjVf17E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+oDCxAYw6tZXuFA0fsCHPY0KJDd0YXC/oFHrZwIPq7jTKH/vxBpBROmZh362UEp27rUgDqwRXKktKzjMtBsaodK+1yd5cjbNB+8WTBNkRz3rqGYqQON52DMNjOrubqcaXIAnHw/VOxiuMETC373uCBfPVCkt9tO8YDHSLD6gdHt9FmI9tF1WM7UBTKIXawUNjpgRAKbXNRqFz/6OeuOWbC4RjEbB+TzBgsK5rvJekhOByUWsn7pwqsWJlIcdIJQFrGLRa6DzLSjNkNeqC54gkgs1mKG1/w2iNZPBn68Va9FZkBkb4YbND5VowxGVTURUsVs5iuz9IySTw7q4ZJWqRGfmcojshFVLxghHDEPNyKUuGf3fFI2TahEbdmwihi4AJrKnqAR9958XXJKpE6oUD9n4quEKaTKTfb3KS/WVEGrgS1DM1fQmEVIrvMeUUu4v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:08:55.6718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e59a912e-b66e-4e21-5609-08de673d1fda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053

When PERST# is deasserted twice (assert -> deassert -> assert -> deassert),
a CBB (Control Backbone) timeout occurs at DBI register offset 0x8bc
(PCIE_MISC_CONTROL_1_OFF). This happens because pci_epc_deinit_notify()
and dw_pcie_ep_cleanup() are called before reset_control_deassert() powers
on the controller core.

The call chain that causes the timeout:
  pex_ep_event_pex_rst_deassert()
    pci_epc_deinit_notify()
      pci_epf_test_epc_deinit()
        pci_epf_test_clear_bar()
          pci_epc_clear_bar()
            dw_pcie_ep_clear_bar()
              __dw_pcie_ep_reset_bar()
                dw_pcie_dbi_ro_wr_en()  <- Accesses 0x8bc DBI register
    reset_control_deassert(pcie->core_rst)  <- Core powered on HERE

The DBI registers, including PCIE_MISC_CONTROL_1_OFF (0x8bc), are only
accessible after the controller core is powered on via
reset_control_deassert(pcie->core_rst). Accessing them before this point
results in a CBB timeout because the hardware is not yet operational.

Fix this by moving pci_epc_deinit_notify() and dw_pcie_ep_cleanup() to
after reset_control_deassert(pcie->core_rst), ensuring the controller is
fully powered on before any DBI register accesses occur.

Fixes: 40e2125381dc ("PCI: tegra194: Move controller cleanups to pex_ep_event_pex_rst_deassert()")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V5:
* None

V4:
* None

V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 3924ac123183..bc9a66ba53e2 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1742,10 +1742,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		goto fail_phy;
 	}
 
-	/* Perform cleanup that requires refclk */
-	pci_epc_deinit_notify(pcie->pci.ep.epc);
-	dw_pcie_ep_cleanup(&pcie->pci.ep);
-
 	/* Clear any stale interrupt statuses */
 	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L0);
 	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_0_0);
@@ -1806,6 +1802,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	reset_control_deassert(pcie->core_rst);
 
+	/* Perform cleanup that requires refclk and core reset deasserted */
+	pci_epc_deinit_notify(pcie->pci.ep.epc);
+	dw_pcie_ep_cleanup(&pcie->pci.ep);
+
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
 		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
-- 
2.34.1

