Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34B385527;
	Tue,  3 Mar 2026 06:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521164; cv=fail; b=GRnBDpMWaYRm3cTsJ4MElHdDjIcCtAEZXRds6C8OScTDS/8AvnswmoOt1OsKTKQwvas3mTh9g6LFwMuKCsRCUIwCWC2kH3ZmRBBr1CY+3+4nGjecLou1YFxOay8K9HeB5+WIbDOZMX2E/2owjBj8eSSA5N2r26zDYbVh5i7mhE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521164; c=relaxed/simple;
	bh=S7WaZGduV7P+kczSjwbWIX7+zsxqU57afk3kopK9N9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=os/A9EhhXXs6KClwZ3Mn6lRX9aCMNe+mzvpLlznURNSY21n8XKCakBDH4/3cAu3lfey95VFLI7RMdoR2eDyOlzH/lkaY+Pk6rOmho0lHFb3ECCHczg9m5Q4VopiXzvZQ1FPDRBICCgPcAnWXRaN2YpKlkySSTr29wCaVUQAm6L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lStcXut6; arc=fail smtp.client-ip=40.107.209.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lStcXut6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfsJCZ0lHdL2DuAeE195+PewVObwVYLNrJqbSgNwMGCoxmTD8cnME83vYhniBN/nusjoDEg6COsTz4H1Re2zHMuCcvRmBKyyshTdj3q/FeMt12JrGZoW80XKlNkFut7qu7bumQ+2DvnCqeb6WuUBJiOMCTmykYk5CXk53cJ8rnx8Fm/KmJnLl0FRqtgo3v2Wg13HnY+sr+HcU/1e9ZgdeuHbvp3n/edcWAdUK6216Lt7FyJFBq+oFpzBX9yQe1kOkWPCmhg5i7fRf0tTWfXwjZvZ6+ynolUQoA4p3q7L1FBDPDTuyvTGUHgWJfnJwN64eFpLt+rajupGYEozpf8JBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bzs4cKO7587USXRl96Tbb6GOlTiKS7V0nHXJyZxCh1Q=;
 b=NhbySaxBwZ6tcwRX0BVDcYNfyiQk2YvBg6PTedgPKJR9lewGyt6pL9WpW7s3/KE7jqSx/ln+WMcxcnl5SNaLApEJk2QUS11mY30e3thxGO8ndlPyBQwFRomAgw7ITVMPJS8b+cTdADBFv+IpRASMsVAaYdtDFwfDxB9rS43HJTP1WSe1My+jdoFvLX3p59Lcywg56g/uaFqxAY/wH0FcgLSVpQFXN6mg/4jZgdq9aPjIWxAFr0+Znei0iekkB70miQ2Utwp7CgMszQlsC/sWRoU+WjEwdXCJWpMkC324PzowkMwZRmD8Q9U/wPBzvmbGi8nFYYUd5rPfRrJDTRqOyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzs4cKO7587USXRl96Tbb6GOlTiKS7V0nHXJyZxCh1Q=;
 b=lStcXut6FJ9iFhBDY9JC4wO29rB85sVFrw9G0q4jDUfKdo117KaaW5lmXofyCHzd/35+rRSI01sSL9zVHXa0eGp7m7LGjtc9ZjVXlUKCMSk/Rh3ysa/CaZ1Q8OqGnwnoa8x3wcJQ/9L1nkjyWolerv7RNNTBI41eyoFxtxju0jsVDTC/LxO4QaLrjlH9seDZcJTk5wlyJNf1CETozCfHHS5mm9LuBX0KwBqR9OHdNbjwIPwccmTmhPH7y+xPAhw9ujyvJrJHHiWuvRZSjuELUcHl/md1YcHibhnuy+N2z1c4doTH9OLXIWg4f4RM20rS7CPFuY1Xb7d/+rqczc1HxQ==
Received: from BN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:408:e6::33)
 by DS2PR12MB9709.namprd12.prod.outlook.com (2603:10b6:8:276::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Tue, 3 Mar
 2026 06:59:17 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::a9) by BN0PR03CA0028.outlook.office365.com
 (2603:10b6:408:e6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:59:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:59:04 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:58:58 -0800
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
Subject: [PATCH v7 7/9] dt-bindings: PCI: tegra194: Add monitor clock support
Date: Tue, 3 Mar 2026 12:27:56 +0530
Message-ID: <20260303065758.2364340-8-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DS2PR12MB9709:EE_
X-MS-Office365-Filtering-Correlation-Id: 7777f7e6-8f47-4a44-cece-08de78f2636e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	hHOjXvVYiTcsMj8Wsq8308Y0vrD26YuC8XC4yb30mtMJWTcm9J75Trw8nqJDy230U/uXa4Fxu0M7t854DoZiVQlKm1wcP5mtSQedI3ZLh78j2jLZ7GuWUJMN+3pDMaBlovS8UCGJpelh7BhUzW3ZLHhWdtQWEp0kscuShK+CGpjrvWWem6Gtpd5kHpbLnKkCEtbPY/QM/nqkHrcVdNAsK+CjhKeK8Umb/ou5byKRv6R8ua0FfLaMDAoJlrOwDDwLf4wy8Wo4o66KfZvklHMWcrsPa4R17/fHQqoqGXllH8GuFUW3gHwTM60h1zMIjZcjqO9ZUR0y5p0PfGf1DfFAsbNuqUViuqmg0D6otz9K7fr3r7IOfktc7RvDxbXp4NZnKuiU0JC0XEXvxJWmMkXv4vv0jMPZFCChzm9W4G/9qZzte4WrVPbAdonP34Q/JVutK/63n1BGz8fsMUAXq1iz5tt66IW+PPmrhvTit7iK+gbEaqKfaSUV0TfVCNC0liMtAOCn0Q/CgE7YUZGjm/RJ5tLNNdIiDWvX+ZfaRpqSyimWi7A0EcT0TgZF0JEqiPILZCXNsgVuHlys3WMlguVu9qsyAAH06OKQ1CccrPVA3XPU2Dok3US+HOx6zXoXUPnaHnXKP0eQhW1u//z4PUW+W9Ek9l1+/2JK7meJLmVi7VoUGBgKod9ML3KVuREh8jd7T/169oylRyLwofT5iLbR1PZvdZOxWLg8zyXtFhMhixr8vf3q3XgSxA+ZwwF+tSQsQBPNSNhcBiC1A4yA9Qx+CsokhNCSOilwcdvE8Jjr09rQfe9bYbYlQaPEQdq9w/ezp4556mFWb9WXsPm+Wej8V7falVMkCZQEID0RNNfeLCM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L3NCFqBOgnAvWk32CQnb+GQbNHBwMovZu2TYuN8c/RxqJ8V+0yA6C16XtLb5T7JoLxLr9TLWTjSEPMGSBxXg+02DVimAnOTWJxYmcGxfZUFgA8Hl+A522EpUXL/xP2nR7JFGKmPvEe0TTVE15LRxSAzLOBYs8ymxTgq6EOqVRDAxG6+DaI6b4FLvk6LV+o4263y5Tgtve0rRvb4hKXPJ4d+qNzFMtkzGNjYBlyXirp1+qQjzQwpfH9CZf5f3wiXxfKnGPzaoWB0PsuD14x8zjwV0LDi1+Qm0ZYXI2lRY3vD8nWTXbA3rFBwm4/DLLcq1SEHPzTb9B9ze4DoDBoIdPoWBmd3beTAqGHDKZ7OK3MUbsDlOgqyKLHOCzi5tLyfsuFg1PXs024bGGIZRww6cRg/3I+ct3m6THzbIghZVuVWd+2cL7rQ0yqdIgBb7Yo7V
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:59:17.6929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7777f7e6-8f47-4a44-cece-08de78f2636e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9709

From: Vidya Sagar <vidyas@nvidia.com>

Tegra supports PCIe core clock monitoring for any rate changes that may be
happening because of the link speed changes. This is useful in tracking
any changes in the core clock that are not initiated by the software.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V5 -> V7: None
Changes V4 -> V5: Fixed clock description per review comment
Changes V1 -> V4: None

 .../devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml    | 6 +++++-
 .../devicetree/bindings/pci/nvidia,tegra194-pcie.yaml       | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
index 6d6052a2748f..7805757f2e2d 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
@@ -55,12 +55,16 @@ properties:
       - const: intr
 
   clocks:
+    minItems: 1
     items:
-      - description: module clock
+      - description: core clock
+      - description: monitor clock
 
   clock-names:
+    minItems: 1
     items:
       - const: core
+      - const: core_m
 
   resets:
     items:
diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
index fe81d52c7277..41041ae7e0a4 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
@@ -58,12 +58,16 @@ properties:
       - const: msi
 
   clocks:
+    minItems: 1
     items:
-      - description: module clock
+      - description: core clock
+      - description: monitor clock
 
   clock-names:
+    minItems: 1
     items:
       - const: core
+      - const: core_m
 
   resets:
     items:
-- 
2.34.1

