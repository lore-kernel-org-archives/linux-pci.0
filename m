Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342D3DAAD8;
	Fri, 14 Aug 2026 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738650; cv=fail; b=muXZV01g7tgGKeqPv4KqjjnopocvjBaMmyiIaAHWQ/w71d5bRP7JPfTl3V/zpUfLMc/FtVaDFGxfWV4zNvwanjuoNBCvfFBiozSQK41rgo6EtXtc49BbI2CH8lHxJQcKVQ4ABRqYTdh3XTO1IMoGAeJOnlIbWPtWebk/0kwwST8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738650; c=relaxed/simple;
	bh=WhfvI+dA57+nrs4A32pxYfDvgO/9YOk1AWWmAX0nl5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABotuwFsqNR7EktZRc6JbJ2Fajus45eyzXHk7I9K4Y1TjDjm4eH0a1teVTegQOeKqIwAvNE4j0Y4dUfmwz+vJjD/zHBjS4s7guMWOQEDegmZJkCn61AWJSIWck7577azinZg7eD9DIJ4FR4lH8KPtMxoZNsd/6F/FXWqFbL6Au8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J8aLQe4I; arc=fail smtp.client-ip=40.107.209.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J8aLQe4I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXxbw5SOv+klGvmEKv8d0r3wzOoDJTab36HHwGYJUZmfHbTAqVIUNtL6/XnE9+A2UVtK2fYQZUe1iN/hiQxGGDxTfMqGOtMZf6CnM1YJRPV1EPfQihDxDP6eLgnkUH4uF8+r8++PO/YwofnkDhyDYtGg7rDUJ0hu2Jy2QSXzP3lzYbWe3afGWmTq5Ule49J0os6HZCet0OVmvgr/3itJwC84EGbOVCGS/2abBKScOAy/frFT0Pz4Sq/P9pzKZqTNgPyr3Qjh6fZU2XUl7INMTlskgwPVYq1UuVYEYP/Ezd53dfEgbmttR37PLvqt9vkB0CB5lORjk7c77B2qwZqY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbwQ8Tmzv2BU7UJu9cP4HopiLK6A6LMeYKbLYVxLwQ0=;
 b=byJlIO01CG342NApLZKkFYSc57WWjJ5TbZVsPOZJfCnb2Fx81cxRBKPPxfG6h9L1TIPABZ/fq2hs71bPBH5+Lk3HNPWFQowxd0SUqPQY0h1w6A4/AbNWc8q/BNYX1WoouzYmt9+APOZL5oeoGZg6bPZfQBtUNqUcDokC5oW2OHM3tr/PoWH0V6bdpBdNrEJrgmMeg184zxl276AMbBfnpFwWLxYG1VE+12+f/EMmy7KETPBiu/lSCJTX6hR4UvRcjbsux3mTQ8f0nk4ciYy5mszBE603es3rAbrKzSjogGUGE6PeA0laHFbyPKsEkIQnATz2J9Boq0MaoibAetq6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbwQ8Tmzv2BU7UJu9cP4HopiLK6A6LMeYKbLYVxLwQ0=;
 b=J8aLQe4IJCaZxe6/314Phh2FeMRCPvmH4Zwy7gIRTGApoD+kZD+nRqsCIUIzhV6o57yf9OQd0uP+Ao4Te4F9WofxCgDfI+5C79yrbosRPJVP9TSO24KDMflTbqI9dT6M294XUbXorXsWT1+QWYR1QWm/vd796w0Evi778l9TCmKUBJhsLKPQS33n9/18Z+6HtmYqt3BsS9pFpLdZO/ml5+yhT69dFWeWwmv1bmLcZMd8CyUqFzh6Jd4BMDJqJeSRl7Ts2jD56JTqr27WFA6PyiaRFdKf34wdZul+9suNXsTIjMyF392cEbeA3klMBoYqHBr4AKlKaD3sV5Vp0C/Lrw==
Received: from PH0PR07CA0062.namprd07.prod.outlook.com (2603:10b6:510:f::7) by
 DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Fri, 14 Aug 2026 20:17:17 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:510:f:cafe::6e) by PH0PR07CA0062.outlook.office365.com
 (2603:10b6:510:f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 20:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 20:17:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 14 Aug
 2026 13:16:55 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 14 Aug 2026 13:16:51 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <kumarahul@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V3 2/5] PCI: Move __pcie_update_link_speed() out of line
Date: Sat, 15 Aug 2026 01:46:18 +0530
Message-ID: <20260814201621.2281245-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814201621.2281245-1-vidyas@nvidia.com>
References: <20260814201621.2281245-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f653f1-7e17-474c-147e-08defa410987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|6133799003|56012099006|10067099003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hSj4o8whttiE/gNu9AemVoWlbQ900q18ZEIv0oX3sKWVqGOOsOOQaaL0dYQuPNYkAMdwvT7v+WrLrp/DMLIZSJGChrkw+NyyovaUuHcFRyk5Ixmpds+WANFx9QFmuARQeubr4nQv3x9r8XsjCayj+epjzBhyBQ6oKCoLOK3+Iwvw7+S/4nQB9WLGV8/qpU0CGvo5ImkwOybc0fYqM4mrQVxjuFcAgEvFsDrtd8AowE6Fm3nHhU2q8zRQprg/QSBTFCSxaRKhB+T2kB/6rGKSyjTK0RFUxnt0bJUCjuGdMphLUF+37WHnX64PtjuOZAJytMfvIdMMSmomi4DLEx+ROVYQwT8tb/No9UujhfDDQ3o8XeDY2/DB7YanyLlunkC7rMO2rPpXFio8YpY+HPpwCAXGxCrSfD8DPWiO4Dx7AwcCKQON7IUuXtUj+6C42fjmoEeQrJ2INT7Hl0EpzqyiXow+SwO1f9AQNZ35G4BzQ2a2a/sTZnA82LQ1EjczKmndRcTsEZByk416gJyO5ELX2sM7kPjTLsXQgwVmbz9bOQYcf0YYYg7FZsPIEVLahAuf42hm9h2aChJRAsJIdh5rn9IJu8wlyg8tvJad+qwdnmX7Ay0INI7avjj+aDxxmUogcBlg4obmosY0vz3NJpmfO09lSIut9jpwA1BvVbyznfKDeCkPsPSfeAsAdcs6YNRExn77Sbhc2UlCSdC68jhWmQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(6133799003)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z3j1ivr+NK8dC+pEIGIK2Q7Itfl1/CPk87s19B/loY1mj+xoP2eCiWHMmMjkQ3yNHp4ycQAQCPQDOm75wNjyL/pzDP0L/p8N/puMQaA5gzs+hP/ZoF4kWTglYbouE+bzoL0+6YjhFAcohYrZ00n0gHjG78ZWCZGqv1NsSz3qqN5ZuKIDtVVjYEO0ke9NltHNWFhIjAMvyei0zCSX7XoDXVgkFuLLiho5vv8W4/TrFLtoC9CQOKPymhVgCw+AbElrckaYaBfNCrbRBygUzMR+2vVmMoDWa/K7kKnnoLS1z3DNB1ghC5teG864kOAVx84WGVy4I9gwvJyCv+g/DVo3HjIrr9h+RaN/Y4aHBS6cL7C477q2uHlbP7iXsolfVY/SJu4CdJOaEy/QC7n3gei9iPgWcPbgoPfEI0ChjTaDjncbFbd3NiCoVwoNrWoahXXW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 20:17:17.1368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f653f1-7e17-474c-147e-08defa410987
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

__pcie_update_link_speed() records the current speed and Flit Mode state
of a bus and emits the link event trace point.  It is a static inline in
drivers/pci/pci.h, but it has only two callers, pcie_update_link_speed()
in drivers/pci/probe.c and pciehp_check_link_status(), and it is never on
a hot path, so inlining buys nothing.

A subsequent change makes it re-evaluate the Device 3 Control register of
the bridge, which is more of the PCI core than belongs in a header.  Move
the body to drivers/pci/probe.c and leave only a declaration behind.

No functional change intended.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* No change

V2:
* New patch as a result of splitting the V1 monolithic patch

 drivers/pci/pci.h   | 15 +++------------
 drivers/pci/probe.c | 13 +++++++++++++
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 68b5fb675d1c..9f55868adac8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -676,18 +676,9 @@ enum pcie_link_change_reason {
 	PCIE_HOTPLUG,
 };
 
-static inline void __pcie_update_link_speed(struct pci_bus *bus,
-					    enum pcie_link_change_reason reason,
-					    u16 linksta, u16 linksta2)
-{
-	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
-	bus->flit_mode = (linksta2 & PCI_EXP_LNKSTA2_FLIT) ? 1 : 0;
-
-	trace_pcie_link_event(bus,
-			     reason,
-			     FIELD_GET(PCI_EXP_LNKSTA_NLW, linksta),
-			     linksta & PCI_EXP_LNKSTA_LINK_STATUS_MASK);
-}
+void __pcie_update_link_speed(struct pci_bus *bus,
+			      enum pcie_link_change_reason reason,
+			      u16 linksta, u16 linksta2);
 
 void pcie_update_link_speed(struct pci_bus *bus, enum pcie_link_change_reason reason);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd0abbc63e18..60dd1efe9abb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -827,6 +827,19 @@ const char *pci_speed_string(enum pci_bus_speed speed)
 }
 EXPORT_SYMBOL_GPL(pci_speed_string);
 
+void __pcie_update_link_speed(struct pci_bus *bus,
+			      enum pcie_link_change_reason reason,
+			      u16 linksta, u16 linksta2)
+{
+	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
+	bus->flit_mode = (linksta2 & PCI_EXP_LNKSTA2_FLIT) ? 1 : 0;
+
+	trace_pcie_link_event(bus,
+			      reason,
+			      FIELD_GET(PCI_EXP_LNKSTA_NLW, linksta),
+			      linksta & PCI_EXP_LNKSTA_LINK_STATUS_MASK);
+}
+
 void pcie_update_link_speed(struct pci_bus *bus,
 			    enum pcie_link_change_reason reason)
 {
-- 
2.43.0

