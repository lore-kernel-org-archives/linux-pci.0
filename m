Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE6288510;
	Mon, 23 Feb 2026 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872434; cv=fail; b=J2UnQQ5SsFR6abK81Q/GyEh9ehdVeCQ92x1tds4LY+PPsHNED6Ol2LfxKOoIlOlIvVC+UE6iyCO9XDlcfLbtqLJ5FkJ1ePd3gXJf036aeY47d9X6nc4ILAW+4QUvuQDwBv987WS2uRwnmc1qdja97kInk3JEDAGdoPV98fZKepk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872434; c=relaxed/simple;
	bh=YRMqm6/u3YZUg2qfuF8AyqkWdL2SHl+EwRj39yV+NwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhiic3GE9rBuJtKsaD/BpkAxMlNcWB9j3C8kayGaklTzsKKCBiFMID1DTCInmdv3mvOqfN+jR3u0A1wq9io6NnFOPkR8AijbLoX24rXeowWJ4S0woSgA3Yu/IFd9qMsGdQzC5sz0HjbDYkStLGQ2DuBtHphrgX/ls2/wN9b/BwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VfRkwkhR; arc=fail smtp.client-ip=40.93.198.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VfRkwkhR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoMh2UeqacHSgUZOyjRnpSoobOtaImAL2UBv9STyddWISlA7KxLZi226/2ZceDv1u2v3iPLsBC/ENpKhXsP5qxBM2W4r5dLz0kkByosjMWKmVUIx6l95GTbMweCGi7El13rlyds4yTPVx38SMj6zMexiFfwXOiujY5wqXPasC/PsgNGLeoRbr6clSpn9yaW/th9nKN5ih9Z1IquLA0L3VCdsR8ma2x3mt+EQJrv/YB0Z1NEvzYnfGMKjwDjKJB9D2Ozpzog4zBfXzpSTfWHn8wDBMw8YS58b7FYiG4so5bQ3DHS/W9H1n7+dbZVJQRwa3tMmHqihk5ds+dB3LGlD/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PEHFFng0u8khelxsE7XPjj+m4G/w6aFbyNz/uKK1ks=;
 b=ZmZSJQTj7CFc2t5oe5Ra2WE1x6KG7ZLZapwqRZUT09cFb719HgjEX2Ndbuuu7ounBgkl9N83vyngMWIpXUR6qlWsll1dPVeIYwbPdzJX4+5eueHyCAI3H24zgmDAdARQYkK/nzohQS7ql/1pd8uvxKc5ASFQznY0n15L3pdomWuoduHtPaTwGObC2PzD7tfJLDaehyert3gVjLF5dYe8orgEMxG+NAWSxZkPli9Xmi+M1mYZ5DZT9eZv0Fc95a6cZi1WF6Fmp4M8rT7WGlOkip/C6TmTFQSCY2DOema+/9MknXGq0EaBfH8w9ufOSuhJ+vNYJcrn/V3wk8DGXj/glA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PEHFFng0u8khelxsE7XPjj+m4G/w6aFbyNz/uKK1ks=;
 b=VfRkwkhRrMzm8pGGa6y4m/6oN2Dnu926KRZbfTaFIkEB8QeD3YRr+B9ESuGmkUgTpZUOxXJ24p9MTJ5axAbJ/FrKBw74p0VmIFqrG4iU++JnCb+0so04WLaiPdaFGFHGouqkUTEs6c80UahUIvlSWPh9BKICqYc8kRY44FsvKUqDAFx0bEQG7qTPNn3aeA6pjeE1l+YkyyrQLtAvXoGf1hqM21JTSTvGKlerLso3IQ3fKcIkwKk9bGqedrRueDUYnk8e44j50Z58AOh4jCNuFjxS5KQa9T4zB6edSPen3CqPVx1dBsnoleAHOS5369Qs5gRG0wUqQu0BrYmS0pNyIw==
Received: from PH7PR10CA0013.namprd10.prod.outlook.com (2603:10b6:510:23d::9)
 by IA4PR12MB9785.namprd12.prod.outlook.com (2603:10b6:208:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:47:07 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:23d:cafe::54) by PH7PR10CA0013.outlook.office365.com
 (2603:10b6:510:23d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 18:47:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:46:47 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:46:41 -0800
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
Subject: [PATCH v6 7/9] dt-bindings: PCI: tegra194: Add monitor clock support
Date: Tue, 24 Feb 2026 00:15:36 +0530
Message-ID: <20260223184538.3084753-8-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|IA4PR12MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9cfcdf-df8f-4d51-6cb7-08de730bf1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/GvWuVx3vNc3qTWcOXvE7UmCQi15mxKNfPFD2jl0SbpJ1ePet33XoI+Bhi/T?=
 =?us-ascii?Q?T7P4dcaM4Hryfi+0oAUPnT+0Hf4kTmjZCRO4EUqba3/3AbubFjqDh92vMNBb?=
 =?us-ascii?Q?CHqCQMR49auWZbFcuij0kMQXvpe5oJSB2ifF+egatq0Ds7JzbS4PzVufG6gf?=
 =?us-ascii?Q?LQU41aDoRkUdvLiRzdSVRD97Ug8LyyiYQ/alCtzjY3LNHSzoZq5HE09qKPD6?=
 =?us-ascii?Q?dvQ8s+JkSQaN2axs+BP3SPKBPyc4ur+Z8TavhNPtO7Iu/ekvy+BnbOJd+rq4?=
 =?us-ascii?Q?9fD8grSG+5ml0nBLen/I+kKY5HWRHzBH3WuxQWsQW+u7fl8joIjFCrlCi8fy?=
 =?us-ascii?Q?xc/4RoOnwJi3l3jptKw5kS4tbRvL7W0zO/kYwBrog7euEnbTwaoikK1kslhQ?=
 =?us-ascii?Q?RRu10i7kKAeJZPzIN7BcsqjaQz5oevMuOLQWfszsOhIGdyG5ywlQrhxxPNBp?=
 =?us-ascii?Q?BR5V6PGGgkcJj6uGHPQVJyjP1t/q91IPk2BydiDvpN9/CMg4/C6PFVE/Fk6n?=
 =?us-ascii?Q?HAa4X7yTzUp4ZJD2UeyQqzazytIxy1f/JGNwBJZMdIMUJzm1FHMBENSzDssm?=
 =?us-ascii?Q?0R9zoq90KqgF6lGH3KpVQcrPjvuVcxhfTZIvoeFFwU4Qa/BlOBeWdUCoqyQR?=
 =?us-ascii?Q?roBmozOze3sCvOR+4fXbW/ZdIRzmDv6+8rQuJIA8cvPYvKpJtCQuJs88YkrO?=
 =?us-ascii?Q?+cwxga1+DG4ZPkMrBR45XgvLydwTXsPAuIsseipP8PNHVK7Yr/gIFatTA3zf?=
 =?us-ascii?Q?bacTloXqpg56EjU2D+JjTcDB/hstgQklqTFYIAKngQWWPlfeH0mmnj56q1D6?=
 =?us-ascii?Q?TotYA9YbD3upDkfP3kM5h+6Vcq+AB53u9lHCvrZnSyNf8EA3YIEPFtTIXEIV?=
 =?us-ascii?Q?bt13YjL7+oVaDxwSEsnhGWfE6McP3NCVUr6RR6Q4A7NWyu5ASb9LWOAOoK0D?=
 =?us-ascii?Q?IlA274XD+XxLPe90y4dot/Cw+3T9K3+GVV45qdkvfhCvzYLxg/lZ0dWEIfzZ?=
 =?us-ascii?Q?3W15yzp+MWOb8mlBS0D/24C50NqE5zbZfWohLrLH1mlLt2SpLrouvaOcZEnM?=
 =?us-ascii?Q?hv/HJk2XuwMZcbVAY1Q/tExNXSj4VEBzdIOBLAZr+tkHWIQ0zuNS6z9Gu7eq?=
 =?us-ascii?Q?kBLECycWP3gaoBH9pPQg6W4zU+VIi8N9JNIxyo3cHncWtHvKvqCvsawoCq2N?=
 =?us-ascii?Q?Zo+YiJ6LD4ST14ZuvbTqqW/GnhEApRP4oglvMMm8ME0WCgAcrKj3JJ5uI9Mt?=
 =?us-ascii?Q?0A+Q3SheGANI4NlZl8F2H7XBOi07J+gHUOFT07eh/YbjCTPYI84660rzz0DC?=
 =?us-ascii?Q?e6Iu8zYrQ2lBjtHVVwPmQJY8Jjri9vONRKwbpdF6PQWBGhwKJMp5Xey5rm+M?=
 =?us-ascii?Q?qnui8xKXp1wiJde3XM4m42ZfrD5Lnq/wrnE4JXRLkE3vHzLXfz4V5FI//BZ0?=
 =?us-ascii?Q?jilVl6FmqaUjkvfonU12EKAP0FoM+2XjqA6kaSEHKUudFSCVyQR1j0cd1saI?=
 =?us-ascii?Q?TXUStNIgkdETuxsEYvcfWug1W4eme9CpWcfL7X87xuf10Q9br48uViKPw7sF?=
 =?us-ascii?Q?2ykk+N/bn0FTEFzql+fMmsefXBjy63B13ULOnP7Ofs8tgaOT77igTN220BIz?=
 =?us-ascii?Q?lyhgf7psyU5WaQShQXFZ9eTGyicuFeeXjmVgCTnp4fVbKu+vYxDWgmlyDpjB?=
 =?us-ascii?Q?V52yQ2Qzq1y3CQzcNrbbk46+vK0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ib9gCyOQP3aJ4NSXSFBnsoH5fmTfOsEpHc32eu3cC51BXgFRdsmv9PguKIqzq7MLj/IcnCUY+3MEmKeKV6A1EGzI+mg6hs0LR9gluvFRdWd2JwAAbCH2VSChgkrgfYmHx0bbS/r8VLv5xfv28umR29+zPVuQsA3p8x0ZXtQJWfA/KllSNUubLD0P/fOEhivRlD4xP7VskLPJKSE4lAvO9RPizN2VOHmJ5VyGRzNTmjiG77f6xX/mGPK93AhYG9BqaQGmiR8r5VzuW8EGn0ABAc4XjCefieWiz1mFcMurdvwpItK7A4xsM5DF3BG7Tp/Yr8FZS1LHVjSHmNee9uL647JWbS2U3n4Z+t3c9XUnuUeUof7ByR9dBPg46VoqrjkZ0z2hB4R1Z6H4ZQQLbKhUeq4ySKelQ6Sji8fM9y+9Egmrlds6eL5uHhiPJ/6kUls+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:47:07.3410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9cfcdf-df8f-4d51-6cb7-08de730bf1fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9785

From: Vidya Sagar <vidyas@nvidia.com>

Tegra supports PCIe core clock monitoring for any rate changes that may be
happening because of the link speed changes. This is useful in tracking
any changes in the core clock that are not initiated by the software.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes V5 -> V6: None
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

