Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3874044C4E2;
	Tue, 11 Aug 2026 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466874; cv=fail; b=a16DBU6qmH+VPoXI3CC5n68tn27qOs2DuBtfb6wAmcJyzYFko8b5/AQ0On1bALn6Krco8zL3sREPTfcvrcsjo1ThS+lrQMD3CtRC3oJr9N2Ti7keX6Yt0valvGz3vOHg7DJy5uxwkfiDPQGwH83VZkqtg2DGXpi2dawo2Owtgxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466874; c=relaxed/simple;
	bh=OemBd1Nc55s6fDZWezyoxhWTji5Ms4Dc+5O2fay8f/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnc2g3hjHypXn9BE1Y6+S0ZnPZaly4ANpYbgPEoFnDmkNvv1xvpFVtfRc3C58qZ7Bby3KvjTFEqSZAxlK/vQXSFRt4I3gOQXU/whfnYE8uj6widGYQau2FwBzT9WOBXrldLmrsjIAUQsoNVL+pzvhrOz9FCR1zIScx2RCVJIKBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tytH8yxW; arc=fail smtp.client-ip=52.101.46.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tytH8yxW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzN7/lyCRBujGP6LTREmOKesYKDKZVVoPUFKkPEcukDEnnJD6FIm0l/jsnPjcbk0UJAmqZZIwnUL+fXaTXSW5/GXeGoseulBBBxVSYWTz5/fQB8AWc1SR8Z4JYdCRgcJ/UfxDEMzpq2MURp55iIZ71CGd9NDYqVV+LCuG8/MCYrklohQ2UW5H5YbGlmhXbS9/YY+v22F16elLYdHaZ84HhwoQ+lLg+HYw+3SqUTxOCIJSDfwkjby+HuHTB6M6XXb78HjML3TZ6sSOhPeQzd4quxHtPhMQvjv1c1JJCOaMOv/gmOC/mH2DihPeV78XxZKY0oDeqZM6WkuqEPHs3XpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHxsGRxWXDWB+j6QOgpq4mHL5uYzXvl/TmyG0qGPf78=;
 b=floGXMo4aO4OrZ8n0xZJL7+3l+9RIV9LsIsktTsoL3t7lldgEQH1vjHF6Ooic3JU6Ta9goe2Jtau41WUx3o8wcLxY2YzViaW7YCiaw240zAAoiVzLVhKdQKUte0z89XMMy+slz78Gi7ZIUvnz98lkza1TPoA7Gx/5quH7oUjc5zKQUCR7p3M1vbhWAjlIQnZv92jxrddfKh75/wY8E2h7WVK/ySm0oMa+IlUJH/i2LrtYxbBxRU4lOSgMBZF9LoWsRKsbA1iAlm37pr+q56ymTOj1/DI3Y7q08mWkrAek7MgclMSU3n5DQx1sSPXnw5+FCmnYpSjpAkvvpQVwKZS0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHxsGRxWXDWB+j6QOgpq4mHL5uYzXvl/TmyG0qGPf78=;
 b=tytH8yxWNFicqAO6ykDmDudL3zWc+WplsQIL/pzc2h7b2v7YJK/yqh/Srq5UMIfEpVvZg2Fa/B62HWPqJYtr7Oun4RfkBBIdwJbtAKQduXhtkrNYljgMa4odCeCMYZCZP09Fr7IgfWIQph9SGCn6uHcQXCXf6v3/8ylykyTA/5WhIOdOPqWOzg1/3KcPkEIpSBRYTnVNI3qdBwZnAnJyH+0tplRAzT8opXC+mBWZDwsmB+HmQny8+zsuyOviKnnIn6Tq/UP0T5QzZ+kyBqmhTKM/N0aRx1OoECgC+/Cu2AVvr9N5RpcT4Ki5t5jEz0WoSCCjNQr1bH/MLmU0EE/JpA==
Received: from CYZPR20CA0012.namprd20.prod.outlook.com (2603:10b6:930:a2::11)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 16:47:37 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:a2:cafe::7b) by CYZPR20CA0012.outlook.office365.com
 (2603:10b6:930:a2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 16:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 16:47:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 09:47:16 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 11 Aug 2026 09:47:12 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <kumarahul@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V2 2/4] PCI: Move __pcie_update_link_speed() out of line
Date: Tue, 11 Aug 2026 22:16:38 +0530
Message-ID: <20260811164640.587078-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512163012.2336191-1-vidyas@nvidia.com>
References: <20260512163012.2336191-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 391566cf-e736-4a3f-f979-08def7c83fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|11063799006|5023799004|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V70XLUg1tQOpexxuUK6IHrS6IgjEDUSRt4flS4tO8Rom/hhRLzrSRcmlyUVNt5mVlQz18h80puZ5Ee106KpPKvb/eruuAT00kY9jlMhh4GQ1wKsl6ft47+OWL3d/skjrEn3pl/4EREsXnEmYNj2G9Eyv4q7/pjMtudJ/G9H0O/drEY5+DWyBXieHQOv0Bc8B+2A6ODhdkwRT3TtIpYwO7vGYBhcdZpdRTI8ujosA1XZ87UByl7ApoOZGrrr2d8N73HUOYxjpeOk8pAikra1/V8KPVkjVbAiAW/Q6nD/fkM/Um/y2txIwCzZ8M/kkzvHlXWGTnQCAHV2z2p52aLnPsDCRnMxIS1A7JhlJjjR4jIZbYBCIwGP5zEFm9N51nNdkeeL40v5ZoGiYlUjA7Jhug3hLR/jNZP0bxuPWoOHmiUacA5g02QzuzTiI1lTVbwxFkHnXf+esRNj6RJdu8CyHLIDudl2v70D05B/yHs5zAx7lgrvsDWtFmNopPoJHTpFAOiccXBWA6dhLgginTENncg37HSIWaQ82ZdW11igeRqs48WdRoP9vaBKeCSHlq96H0Pwd+tVMe+sRyVtLpOEc6sbcd2fAdyYnZjSVn81Ez5g/nqnjZH1BryYkRJjycER0Hyo8AH1QqTpcVeHQ9lyn7lW01ZET8975tKvXELEJmJbNrywHKB0Q4Ipt/BEyQQi6CdFc02mSGdq1x3BHFJgpdA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(11063799006)(5023799004)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	07T0pw0Ig3946rq4waFcPr0iTg8PdKsYxEeWaR97Xhr+DyvgkFWoz432oGMfAPt5t3HLe2Vcqr9US0UuzGbALbrsddogSgYmrZi4CZ54qCLpOnaUnnxH6m6Z4ZQvr3BD9v0nJ8cKE/ypfYl0no0hdOaaJY3gwigQmozXK/bnG6OVXCx3iF63P39GHaPNQogWbl2Hq0jCqoTXe/sA3f5Xfqx7XyYli+MCNuK8Sc9ts2VOkI8pzZCIbEmNEG3SfG2P41VsA8MRvNNH7iPCSd1ni/ep5vc/MGC78SwQk/58tphLbxZRTrd69Pwbis6KyIKFdCKUzioiDbIn4PtNCPHbUaAR53+u+/QpSFEF+pzVY1ym3fU5Dqg/Ye3G3oXHEHSz6q7z9JPRI0L0rP/yKUYeBh0PzNlKx8Ep57zeABu3GplYGQ6ruXMAmlJ2OAD9HdfX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 16:47:36.7891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 391566cf-e736-4a3f-f979-08def7c83fcd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095

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

