Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF93845D0;
	Fri, 13 Mar 2026 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390822; cv=fail; b=SdpzgN9nBCqDn+k2DZTQCh3eorFDcwbJq24j415U9UPLy7CqS++dTUEMheOMZGjIdhS87td9qs+tGHoZMMz0xMEubqRo6mztsWINXwx6NQzVZUCRiwVhPu0UJ7612HuL/aY7RwPisJ7oopPRDKPJ+YwZBtXD0FrP1fAw+uXxl28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390822; c=relaxed/simple;
	bh=i2VNLYb1xMz4W6PrXCDgvNW528vnDd+/LvKB4mQUx8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KNIklerOyxz9njfx+vliW1zGHJmppOthE9MwIA/+vHmnST2KV9AlcdP9Gp//w2/RPU70iYsom7HxhmcyN5Vjs56eQTtGACfT+cfiJq9gih/1ueOvdEICNbxVFWAlseXwGscc7IXKv7jyXNskQIENZdwIZeg77Q5TibWPJg6UEQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GD+iIvux; arc=fail smtp.client-ip=52.101.84.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GD+iIvux"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAm00/6mjFw+/j3wj+an2x5Rosjuya7H4dXJHZPFGSbCV9fKMY3TwfZ9RvKRSG/cBeVOcPHSo4qLzps40x9XclDqFH6GJQOU/FUoo8QYpQh8z0E96JFNTaMvx3WISc/6QIJ8bcZ8V/MSQ1PAoCSvBYrwxJFp+Olqq7ljXu+pCRZUClITwFCkw1YEA90Erg4q2CZKgh1UzCoy2bh/hnFXOCzsfbkfrN5LvoSRxRaqZ1t4nQKg++hvJjbCcVrM/51aph7QzejZfNj57+slkCxAnYItu9uFDuVjy4xfQIQsn0enNa3JrVeaO3eK7ll8orwdEdDcWNjOS27cgIV04K5JfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8DJwMyFRaTpT7ExGjsLnHPQjUmBSMpIvhQpQ39EioE=;
 b=hBwjS5XHwDnUMMnw+Xg9pFYh5YMxXYwnrbM89g35V7R9eQtHogo1KQiy8LRulRoXXoJR4B+4+dTlmRvupSLtp869rzeRc6QofLBfd6RC66VZT3i75MTz2ubB5U1aeMAIblDHnZlke7WtWO5co4DlZea7Og4W0EVfF3nrTBlH46E/PKJcXQQh0mQPtY9yFeY3kuCG0AjhAXjaCaiYf3kWl6tzqKuFfR3559iFSRLu4Rqwbxlvt/H17mU1fiVZ6Rya73FQWtp5zxBZK6gVMHi8U64IvUM3Js1EWaKTSiqehQlz+MIf7fahR8im9ybbHv81mmGyMiYMgFHYBj95e/tYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8DJwMyFRaTpT7ExGjsLnHPQjUmBSMpIvhQpQ39EioE=;
 b=GD+iIvuxzQgdMXVELtDuUQwob7Emd3IBzIOuaXpLZy8BDGgrAHjVxfpqbFTI63OaSd5TcnAssBYwyiHdFEWF0/ngmdQ+bhhGZhGXji0V+4zPnU16169zpKeBpGV9I9Eqsm3DLMXbglQla5VBDyNCm6KvcyoNhi/jC7BDwxCaocbJ5M2hk8q9lbDmX1u5ordKgzDi3rE0AfBLpweCsgkq4j9xrfl9zd6zGxBoqRXLXhrTyEnrCcsftk2eGPf3NkW3Y5uMcYEL7RwW2KyIL1we6JIUPEG1IlFfWPun0Shl+Z7xi9sQsXFtf/VReLlmFjMpYLgkQLHkAMin+ChwM+O/WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 08:33:30 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%6]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 08:33:26 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v7 2/5] dt-bindings: PCI: imx6q-pcie: Add i.MX94 and i.MX943 PCIe compatible strings
Date: Fri, 13 Mar 2026 16:34:40 +0800
Message-Id: <20260313083443.2391254-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313083443.2391254-1-hongxing.zhu@nxp.com>
References: <20260313083443.2391254-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DU2PR04MB8840.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|PAXPR04MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 7071b81b-9d60-47f8-5c00-08de80db3249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|1800799024|366016|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+/a9jM9PEb7+laXY1hDaW+UYJZLsPSk/y/LOKIbYh19ie0luuJCrkn1EYyPB0uTWKpMwrfMa8MYusXTKXDGYEmHoY9ASz5tFvHGJBoZ7q0GjhJylLntShhUel2cPlRREUVBFwVom71ACeAUH6wjKhpSysNTBkULi43YKaGzY9Xvz+AzcR0yX6xywUcUo+gj7jHQgZ1+WPEvKKLAUpN9Hu5cShle0fBRRidWNGzsQFc7V+MH74JtYHayYttD7nyLJ+Ra2QzaBaBkU9WDkkm/xTdThLz3fKTkzSX3UJ3hE8lWDHLSRputdIs5UfhTWnTq4r9YjmhwgAf1Nnpk7UMPsR2bP898ayYw01rEdKhFBQAnTCPgQBgFYM0j4qOVm28nmtiMzNyqUErUT6wa3aV8U+u+PxfO9p3SxdMxDLimjiJWlijWkL8a/T86n/yo2T2HK2sI2STdCsttApA4y74KaAlQ1//7Xakl703YcqM9X33IR8zhd9gWXPeV0YxBDeQ+DrRQpEiB1akF3rPi3Y3ugfuil17yIJqBJ1vpZtjjuuMKVX0SkjkDr6DChrnB0rVCpD153IqjysFNjDZqTgmXHOluNdW5ziX1WvASBQLn/dOKsoFXl4Zv0fd+as8nPXVzjmgf+EImJrrg+G7zKYCk5ffYpIPQ4qNm3phCTYMe7etuqYaIpxFPkMeAWW5ixBlu54wx3NZqIYxAIoJp76EmnqpcMgWLe1fQEpqBIDgfsv3nNr3DCK25vFwnKexBvwo/PuI7yVO8yxnxxHqvT8RsbCtLk5uxum/n28+95pntsoUrZXaXQes97yfY16Dna7AKM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r6eeAzxSkaWrTO+tVuYpNpaVADUQnI2td521zxIFYBGMGBrx2qk0tC0e2UWv?=
 =?us-ascii?Q?sdQaGk2zHmdYgvZS26bfpQDt/UMFlmcgxtPvIDYDO+2FgbmFMxpOkks8sLZp?=
 =?us-ascii?Q?czbfhV7BRA8Ihy4IURat3w4sChloWXYsCrfOcdWA23mU1gLbtHuYb3KjHhTs?=
 =?us-ascii?Q?lEtZUAxaqhUK+UVVi0WsGgC0h+dZcIWlVn4LEWak0PisFAEKUmyP/zjUV5YU?=
 =?us-ascii?Q?bTdHKEypX/afAwgx2iCoZUxsbyVVdYEM+yoVFjmIZuP6LiL9EqaOTLYmWU17?=
 =?us-ascii?Q?HARTGpy25L8cLkJVoQiZtOuW3/UYnED6LiUwRP4XBP8r1AWR5eBZU49RjHcI?=
 =?us-ascii?Q?5O1PkCyJvw6vUkWhEsbTWGgLNtr0iF8GlDJ7pARIiYoFoD9cBpOclXfVt7B6?=
 =?us-ascii?Q?uVriJt+O78Doo+W3yHLzMTPKc0s210nEezf6id7CxwqMOSOBLLW3Ter4YrQz?=
 =?us-ascii?Q?2EZLeZC5+3JLCXS9BybPRrdgJHxpi/M77QxN3Q6mnj6fZ85zI9gcu/7oJbQw?=
 =?us-ascii?Q?AyYqFThcquWEDlQwkgvFk99wTLug2SGwATBkFmhppuF27Pg071QgcvZZYDcF?=
 =?us-ascii?Q?RI4gHDD9Cg3Ge44QV/+BbdE5zgLxqFNRHLsRcdyrbIS233H72dCjIXKAQEPB?=
 =?us-ascii?Q?YvjWbmc7uitEVFSCkuYYcGwbdU3mTMFqzvSayJcgTyeCdofxn6njByoxIndj?=
 =?us-ascii?Q?32uZ5w6eZmOMquk60Q+TH6eV0YvQ/g3BMMnbMpPMQsv4macMA7E23ESIV84s?=
 =?us-ascii?Q?Sazbm8/kuG67x7p1Gqs//viqeXHOazsnYH3M98ozubQ9fUUJVH8QlW4CL0s1?=
 =?us-ascii?Q?I9V2olHtb/AunPc4f0ePCJ0gwVe4NMSMrNiCs9BWg+fMfY3FqgoMhMzyS98b?=
 =?us-ascii?Q?LjglqId/RoCl2ZUwZX2Q9PK3mAWqNZxaPzUrKVeTT+O9i+9Cr2nIkAZeC3Yw?=
 =?us-ascii?Q?7eMNIHZ0atcwenz1Lza90upuVY9qX0pHBoCuEuLN9PFr9PIU50/pTK8WjTCl?=
 =?us-ascii?Q?cTUwnharbx7dV0FvSc9m6zW0UHHONnmjF1O9YFVQaC5NsWv181jQJjb7eJ/H?=
 =?us-ascii?Q?DJ1A+Q6jF9lzZVmJHj+IfiejoxL7pPoiHwPR2Ve2oKlcNrgHQKeteUWZ7J9F?=
 =?us-ascii?Q?Az5/tcYcm8S1CzlEi9ESslJ4w61029Z+2GuLI4ZyQ9vuPFQDYbyCj8gEEpsI?=
 =?us-ascii?Q?XS+f90IaEwtLtP5DzclxdCZZuHkJpqNa741RW/hYJYZRu09vN67LQcRnKkbP?=
 =?us-ascii?Q?LbaHamu3+WlW9clYFcOT5NDiaLyfxripY05IJcwfpIjjLgnLYMqQbe2NMg4l?=
 =?us-ascii?Q?XmUt5kqbIaFCSUSQyrPlVGhmswJGZH4UNCQEv8RBMukS/SqMm+J4nVqOLUkU?=
 =?us-ascii?Q?PXGQYopGPwN8W1qjcQuZjAUBvOxvr0twZk7flRmN0fRbdXCaDbOmwzV8BvHq?=
 =?us-ascii?Q?W+CnJoO/oanhkOPUzfYURF9qDPwpTdhbsHJyy0xeJFqOJaNxg60n4TkoMQvC?=
 =?us-ascii?Q?Gbl+vTuEDXNZsBSNy3AmggLdNRDRHi1cHx1Tx+aMkkuh+FDk4GNfCU97XQFp?=
 =?us-ascii?Q?Q+pT7WOVcPFuhdIf6vGgu0Ie4jhBAufj7713OzQbxIgVX8LXyASrYwW6wzS3?=
 =?us-ascii?Q?zjE7cLcL6oAknxpEUkkVTiRdKRyw78hiBXt4C+4S2AMRk6fBXoBUSsl2Qowe?=
 =?us-ascii?Q?vFS7wI5USJesFOjezpfO4+5FF16L1n7iW6XCKvAk26TkEkFSPCcx/3MtyLLO?=
 =?us-ascii?Q?LPApmXQa4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7071b81b-9d60-47f8-5c00-08de80db3249
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:33:26.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hnLN+XviOW4MB0TJGZTnmo3NY/wtwOPao7ZvcBtEVUgrnbEsH/UcJ8UqBKh0reN3nvYvxWkWa+cWtLdp99QDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

Add i.MX94 and i.MX943 PCIe compatible strings and fallback to
i.MX95 PCIe compatible string.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 20 +++++++++----
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 28 ++++++++++++-------
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index 0b3526de1d62..b3b1ece6681e 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -18,12 +18,20 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - fsl,imx8mm-pcie-ep
-      - fsl,imx8mq-pcie-ep
-      - fsl,imx8mp-pcie-ep
-      - fsl,imx8q-pcie-ep
-      - fsl,imx95-pcie-ep
+    oneOf:
+      - enum:
+          - fsl,imx8mm-pcie-ep
+          - fsl,imx8mp-pcie-ep
+          - fsl,imx8mq-pcie-ep
+          - fsl,imx8q-pcie-ep
+          - fsl,imx94-pcie-ep
+          - fsl,imx943-pcie-ep
+          - fsl,imx95-pcie-ep
+      - items:
+          - enum:
+              - fsl,imx94-pcie-ep
+              - fsl,imx943-pcie-ep
+          - const: fsl,imx95-pcie-ep
 
   clocks:
     minItems: 3
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 21dda8066014..fd5f7ff9c4a4 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -21,16 +21,24 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - fsl,imx6q-pcie
-      - fsl,imx6sx-pcie
-      - fsl,imx6qp-pcie
-      - fsl,imx7d-pcie
-      - fsl,imx8mq-pcie
-      - fsl,imx8mm-pcie
-      - fsl,imx8mp-pcie
-      - fsl,imx95-pcie
-      - fsl,imx8q-pcie
+    oneOf:
+      - enum:
+          - fsl,imx6q-pcie
+          - fsl,imx6sx-pcie
+          - fsl,imx6qp-pcie
+          - fsl,imx7d-pcie
+          - fsl,imx8mm-pcie
+          - fsl,imx8mp-pcie
+          - fsl,imx8mq-pcie
+          - fsl,imx8q-pcie
+          - fsl,imx94-pcie
+          - fsl,imx943-pcie
+          - fsl,imx95-pcie
+      - items:
+          - enum:
+              - fsl,imx94-pcie
+              - fsl,imx943-pcie
+          - const: fsl,imx95-pcie
 
   clocks:
     minItems: 3
-- 
2.37.1

