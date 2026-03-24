Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D13CEBB5;
	Tue, 24 Mar 2026 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379493; cv=fail; b=J3joDy0CzoPxM1b9HNC/fCxWkf2vibi4ja05KldOOCwg43P+qrSmLHkjEzLivEi6ZqmPMoCX/BZfVMPoFnkvtMM17YPttYOtG62FG3ef1qUtx/XbMwCU6Hzu59BZn+073X9IlcBhN7RFvCYpkSApJEAl5QzE0ji+3mjm//vcuQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379493; c=relaxed/simple;
	bh=qD3WVxJo+a3mz8p2QEtsOw/w+6nwTYUszkr0q+Z+nBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EohKuYZDI+RBjvjvpjuVnWsomNOFDLPv5s9DZgJPY9IAyABiWnM50uI5BEu5r/ZZWIHpVAeXoS/hvWLM8Bx0zOgdLaEkdSFZj6ddMcqNQ2Y8WKU2WyQQCErLtZc6UMfp+HtSlylfl7ERfCv8fsUkELgWlQz5mzyVLq2/1AepxmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DB0hCJ3o; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DB0hCJ3o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjDFam0Qme+SQAOiRrRs9hzDk6FRzKJ7hqvQBY+uRCqlyS7XZMSrM7QLGv/Gv8aDv8gqJPVV8PQNSCzhD5F4GNXAow80NmoOJHXy7gjMA3rygu4QRuWVdAifaoc6GHLsx0nIQpVPBvR5kF6gqCR3JPFhBHnXrLkl8fm6ee+B0XOEBOAu6RnzSr7iS1MjzjBln70qzvdNn9M/ooIq2ZDHdGX4TdORZctZ8otUyKQxq1I2GwPOMAqyWmba3o6ZBk7DP+w6aes2B5bjUH1xvFbVlLLLVj67ttjgX/jBpbHLjtAPg+ip1wbPSRnqsyDW9b7KtLuCziuHjqmaMRMVUlAn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50F4wZr1D9zOzO1t55hCpjcNfgJYBSlO1QcZxbxVcBE=;
 b=fPpO5CIdlMD1dxrwjXdaW2T5djlbzkERcq/0UnLXXKUCvAXBqzQ34siAeXoZgGSmk1JSirtu0xdt5wwWteoSKK3nV7UWbge9eVbKpC7NiLwqOPQURuG0rq4j3uedi2GTSMWOAByM0MuNKBJDoOmo0kWPHRTjz2vDmbmcbawwhI5xU78yHHdvCSqtgC1M9a4wXkT/z504YbuFVzrK2vo7SHTjMc6rgvza0WRpzoqjRtZxEmnIEsrOAqV3p7XMcOdu7Gyk4CkURKNApp8ovX43NBbpWZhIZH5IjS3626gnZKT0f16xZwETM2wsxCF+ne4RVSIESyacf4PfsfwOZ15i+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50F4wZr1D9zOzO1t55hCpjcNfgJYBSlO1QcZxbxVcBE=;
 b=DB0hCJ3ogcy7/vxG0kneABXNPjs1klEXP1kEHXti0NmR6UwzU28D7GC/ggUhXo6F4eQuqnPguZQgUEtMnvXiSGbzTfCozPgE+TyA17ZrDlAsP9ntjmSHPdzVIlVGHkHdJoJt6SYl6Xas6ZEDlUxEIZq+M5Tyau+QwAQczU9QhV8SoO1DG8sK7b3cuXE595I59KSy6s7p37qWgtbI77rCqoeoFhZzc/LzGmgfabUC66atxIguHNNZrH5WsVtvWejl77Evji5sGjqNwC19DwpKhMHeaIya6qnB8H95sHBffUmpmpqLe04eA1mankUKGlB8bjnotW9nlMkSAGSg/zHLOQ==
Received: from DS7PR03CA0336.namprd03.prod.outlook.com (2603:10b6:8:55::20) by
 LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:11:24 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::21) by DS7PR03CA0336.outlook.office365.com
 (2603:10b6:8:55::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:11:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:11:01 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:10:55 -0700
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
Subject: [PATCH v8 6/9] dt-bindings: PCI: tegra194: Add monitor clock support
Date: Wed, 25 Mar 2026 00:39:57 +0530
Message-ID: <20260324191000.1095768-7-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
References: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|LV3PR12MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 5540692c-4908-4c49-c59d-08de89d923ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JhyW+ykcnhy440h0W0PQ78CSRSGKjQjtCNI9GB6EKACYDJiF96N1/h7CQuAtkGhe/7EFy6sHzocPssUkS/TysAlOqx4zPfQvnCj9wLzM+C4VfUqZKylZcw7fQQmq7xhMYJuM/+l1UuVl66v7tdYdBamde0tQSwldR1xSPcHEjcGGyBFiZKSCQRRPLOOtafmp3owAlYv7praEoPWKKAwxt1UFXX+liRO2vNKWRSlMAEzUv0y1OkB9uwIgZRN8VCa/B+MipcPy8HZ3Tx4INnnDJe/cGBZlGu7Qw2Bxd13czLhhKUSgZ/mMhN4x7y/agf+BQfqG5wTqjTxkEuM4PpcRJkfQKAwZ84pb1/Oo9IWxcvTPU1ZjCIg07HeRZL7TJ0eJ5bUq9I7DDg+MBVSaPrPb29lwy/cigzepqTNNaDPddVHVuTv1d+gzqCCTw2H/o2o4oehsoaGLX7hGZbIIogd8wpKhWjBKvduwD6OVHP8I4DcwIpXgYYEfq6Z1sdWOlkXObbI9wBdkcYQTO/71FxWyl274mNHjTM98kgENxNrm9FsV+Dm67maILlQfmXmA5x8uRxl9vqCIWyfcGDNFlA+/j4K5SkoKkzDDxGmwHLGU3ks0Sheo1axsqKS7bv91Ill3C0x9A3muoPLiM6k/mX0rkaM5jImVMf1Se6gSWbh/MwOt/kFJ9sY47RPaOuYM5NKLNgfjCvcJI5JYGY8rJhNJ9Fn2hswtO6P3KccDOjULv+W12wWGhtPOYjgq3aqJ4Y1219NZOQFf9Dh9MHFKs7Va0fZ5VPMIvk2qNU/t7xLOkvGjYdER8fPY0mmKq3ymJocw
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kmS3s9YZRRQgf4VJugKQyduiR4YWjtkjpjPl4Gbza+cYXszKzXbTmC7qfaZRrh5F3ouYjZ8/Yvsu7ZvgGk5F+cBkZUkwJqreECsakCMtuWxv+px4G88qAspcAcIizcNTiUehPXMWZJCz7z0e7f6kVmzI70tECeu+YXkUPoK9XE8Wo+xHsNGgricezD73DUEy+bEnRyg2hrGonyA7MZoTh/+MvEGIavZwC0Yo3R5yx3Yc01o0AzEn7yOvuBjD/5nye/VaNFUdMeVMZqMoQdGT/WpMYi5y9c8awYBaAI1hujzz//GvdKnjDLbA4a0VfzkJOJmrMZlsDww9eXM/6zrvNmRSMSsaLGDCqglqLikS167aSvhPJ1FV3q53PLVU01TNUgAxqtOBhxeR3yta69U2D7FsFTcmXODUkjtqoQl8+XT+K80OSWMplmSHhSK8b+bt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:11:23.2090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5540692c-4908-4c49-c59d-08de89d923ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143

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
Changes V5 -> V8: None
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

