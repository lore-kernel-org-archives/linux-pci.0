Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3215226D02;
	Fri, 10 Apr 2026 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802347; cv=fail; b=i1nFdLWR/GlIsk68OzF4JbQXNMQO15G/aoCpZhTrixI3nXEVRax8ExTtEeGyEkQiAFwaBlDS4xMFf6dzWH2qt6QfXDWl13ryNwvGuB+CnXDmJivJtJXWcKU6I2zew0P6+ScYiVlqlg533kNmF46yNhiefSWPY7IT9XCMcr3PiV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802347; c=relaxed/simple;
	bh=nlGKgxsDRvseZGYWZ+Ak9h73xkaX4RDKszpNMV8b7/k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hTcvF3/UG/gPbBzeyEUQCKDH99AT1UgVelcXRfvLgaxpcxfrs23QjP2eNDaMF1qaH9A33Srb3JbsQbkYVHgZOJ4NtbtHxUK29LOKseDDhmDnuEIeGzCaHsrcYK5RqjrRH4alsT8doIVSx6ACsmkC/88cj2zWMrpYN5sHVsaEhGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JTGc1R/W; arc=fail smtp.client-ip=52.101.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JTGc1R/W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZI7vLEFcCGMd+frKDZagzlCiGoRtdiChPGVWPAXJ44+bsGHNIs62WEiuPl9L9333iuuvo2rw3eMQyKn9BoblaBZGdCLYjv8iN2nMsOqDqwAQmAhyGuAq9+AMuoqXPqxqbSGDwGeXTx3fZjutz8wxGuSD9p5FUsbnJK67+f+zRL2w5wEWu0dhNZcSL3Fw4BmdBrw8Cy1+wbmtoNXikferntGFiWods+NRISqP2epk0CWx+bFOFrrM+0wgfGljLhtKmwuU8SnEu4xdxAOj52yRpdgRtWR76M7+mzlL+odG58OD28lNBDaBQKboyLEAWO7mwTgXa6URq9aFSdAJlvOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNe6ns2XAmRVpk3ZN2m70CSyMuZalYAUKfGCkkLqzOo=;
 b=QTmSvExR7gP5s+IxDUgAvg/4Zg2FKK3ghIpXBWQNYeQ5maHSJFcdCwY3ymbG445l0uJSV/iDsdMgDfdaADdYfjhsexiaaiUl+2HxjDT1VM5Opo7fM0rmK0vfzQlQHOOuxvw+u+QLlSXAO0viTCZ4n44y1T+G9BByOM16zUvvJJV9sTS0yu09fDktl1CZRYK97eRcmpitB6M/B752msd19OAkEOk+FC4hO42igla2DSgXawQz+R49Xfh2IWfJmJZjmNE3PGGNx7mYvYbpbzyU9xdhDHvewmf8oQV+PHsdv5z+ZUYXEE7dvIEq9UNwv93wZAk1wzMwTft34ma0t3L/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNe6ns2XAmRVpk3ZN2m70CSyMuZalYAUKfGCkkLqzOo=;
 b=JTGc1R/WQLsC5ZMau6ub2BM4mZjb2LmzDOoKAZpNK7uA2QkniTqeTLKlZYq9EVLb7He3v648hbH91KJLijzB2GXnqyeZ7Km1KVhzbVcn59wcVluknj6NBLjIraSPAd+Sw+PS/0tHGmiP4ZzzyJsH6jI4qROGHe/dfvocKRZtcBmcz3uAy6meNuP+ynm+pRwUryL622EXQoOiC1udSXfoBfaBZTTgVE/bUHVQLcc3WGzpmh5DrVEyCdwXpP+4fQUfMV48x8AmGHIQM465uueFxOZINEa5WCRBMTtpHlwzpBcaPoej6AkjYDII15JxVU75GRUuLc+taJC5NB6jd+ZDCw==
Received: from SJ0PR03CA0261.namprd03.prod.outlook.com (2603:10b6:a03:3a0::26)
 by CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 06:25:42 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::49) by SJ0PR03CA0261.outlook.office365.com
 (2603:10b6:a03:3a0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 06:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 06:25:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 23:25:28 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 23:25:21 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 1/1] PCI: dwc: Apply ECRC workaround for DesignWare cores prior to 5.10A
Date: Fri, 10 Apr 2026 11:55:07 +0530
Message-ID: <20260410062507.657453-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|CY1PR12MB9697:EE_
X-MS-Office365-Filtering-Correlation-Id: b37dd86a-38e0-4443-6447-08de96c9fd9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	4rdUnNnjxReWQEdWLhFnVCsU7XoJoe+D393rVdgS5oG7IsDCMKg4glYpLCdJBD1B0nIzy8SFzBTBlQoLX2Pfhzeqmy0q5QPzKM0Re9IL24ESDxGeVj0S2eOf0w//IWEEANOlq/xwJCoP1KW1C+lTinyEAbK5bHz6RGeBgbTJ5ZKaeJecdJ5q4DE6dcvpbXN+/m2D35lBzVLdxYGNa8uC2XXM0m+HmAXYqG8okGDfj3fDmW5R9qO5Vg1jKXwxUAWmgE1x+YpJCGYb4ZaK3VakxGYuq8LJQC3cUoEYTU1bhf+Ebk36NwDUc+BOoRkoIfaJB133u2dGDhQlfpMWiQWwGrlEjA6wIXdl3kphS7vgCGiNCamccuRk1/ddK0z7KhrkTtfSJi3iciiMgF9qTFVoOKZzE3Cj8t472xqcyCpuVZasyoZgbwiB8m6tCUAgzx6dIt0bMkBQRu9wLLpWrKOqYMq67VBbDU3eT82Kz7vx8NFptshm1EZnLzLFtAOi63JZ4YOtrCekYzJ75eg6besEJBUGOZafTNgkzPkEltZr4m0h9Ten3Sa0XlxmavhLZ8w5xmjHdfFaXOeLwr0vBaUfaZh5t2ykRciDBnBArzxL6dGQSREKVb19WPB+NmwONgDOjpb60RMxeRQK+8qA18SkzH7uBjqL2eCpmQS4fjKr6uTozJZMmR8iuHfqSBIMdjcPubPj3fJHYd2OP64VCAsp81AVmEnDNXRnYBsvDxKb6EIpxL8VxJDtBxuMgQ+KxyjE6qzjMfe4ppMBLcw6MP7eCpd8O1SnSEqrS3IKj7jQKxUAZL41L3lyGcga+dN7weqd
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r1+qU1krvt/HAZlAOSorIAW8+bqpTiH9YMqE4P4HhAbzd9pveEmE59FxKrtnIgoK7R2qfzBe0/1BB9TTLAg+jLRDTmNxBpiGMnxB5yrl1Uy7R82OCYtpTWnkSS270ugjZc4dNm3YRqknYLIBg39ICCzgZqQZtQYO7mJCJC3arfFjWfQrcA5In+9C8WYuE55oCmuR5TjS5o75JRhipF+FzRkkhzaIXQz0hbbyn/nbyD5Ycn/B/M1nn5VCHjOah4Exb8YYvmv5mZczbk9iyxGVmWuvSKWHpoMy4VJrSHbbvVv4hFstTP3jfxrijAN9glfPfzn0k2Ishhqde1YQ83TSTSB07s5w9MuKHEOqW6Tq7KQOQ/H8yLmQ5AjM3T+OTS0PG34SA8H96Kw687H64bmWE0J7fAbNcPzunNhq+Lm3ZC7UkXzvza0QBJoNmi3sKWyN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 06:25:42.0485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37dd86a-38e0-4443-6447-08de96c9fd9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9697

The ECRC (TLP digest) workaround was originally applied only for DesignWare
core version 4.90a. Per discussion in Synopsys case, the dependency of the
iATU TD bit on ECRC generation was removed in 5.10a, so apply the
workaround for all DWC versions below that release.

Replace the misleading comment that referred to raw version constants
with readable DesignWare release name aligned with the implementation.

Fixes: b210b1595606 PCI: dwc: Apply ECRC workaround to DesignWare 5.00a as well
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 6 +++---
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index d69db0ab3b14..d0b3b93fc940 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -487,8 +487,8 @@ static inline void dw_pcie_writel_atu_ob(struct dw_pcie *pci, u32 index, u32 reg
 static inline u32 dw_pcie_enable_ecrc(u32 val)
 {
 	/*
-	 * DWC versions 0x3530302a and 0x3536322a has a design issue where the 'TD'
-	 * bit in the Control register-1 of the ATU outbound region acts
+	 * DesignWare core versions prior to 5.10A have a design issue where the
+	 * 'TD' bit in the Control register-1 of the ATU outbound region acts
 	 * like an override for the ECRC setting, i.e., the presence of TLP
 	 * Digest (ECRC) in the outgoing TLPs is solely determined by this
 	 * bit. This is contrary to the PCIe spec which says that the
@@ -563,7 +563,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
-	if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
+	if (!dw_pcie_ver_is_ge(pci, 510A))
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 82946bf78b21..739a213c27c9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -35,6 +35,7 @@
 #define DW_PCIE_VER_480A		0x3438302a
 #define DW_PCIE_VER_490A		0x3439302a
 #define DW_PCIE_VER_500A		0x3530302a
+#define DW_PCIE_VER_510A		0x3531302a
 #define DW_PCIE_VER_520A		0x3532302a
 #define DW_PCIE_VER_540A		0x3534302a
 #define DW_PCIE_VER_562A		0x3536322a
-- 
2.34.1

