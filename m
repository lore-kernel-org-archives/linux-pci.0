Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6DB387347;
	Tue, 24 Mar 2026 02:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774319368; cv=fail; b=YPdoo1t9cId/4BJ7H7BJ86sgBtuMjzeX6jU+ftUPt/50SkXPsu9nrw/B0ECFXjCTV1EaUoDaPPxKRV5sRZYwURk8XsskSsHkFqLPR5sfb8ZLVmHFMt0LlfW2AACdQc1uedBQRjhreXbAN4uwDSpqSbg8GyHsGR2q/5jBXBnBZeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774319368; c=relaxed/simple;
	bh=pJNf8Hs4EujT+5XmjPev5gEbnm5sJCBJHxt3Dkdiy/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LjuVU26icvUAhlJN4yT/VLCRvPnBnBrKwKDFQBwbXoRrbcNkbfo7XH8sjRcDsWAd1k/YJGDm2unpk6Uwucc6EJ7jZjEbbryYa/2pgXpTJWYsyHL+O74TQ5QcRA5TqCoHpSyizBHaSPMd8Ie8enoNE6Zbmz9GOr7KG5Re1++yc9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NgzaDTbP; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NgzaDTbP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQ3ZWxePCyfZ/QsRRrofJ3DEnvlwj/0/eEG24WOObngzy6StU9XxdPw3Z8Kfp/vOrA+/qkTmC6tj6FmHcxdvlyLFwXGItakBc9kyzs6szWkqxm/5ewgvLSkGWIBD2fnLW3wljJaTRp+8bOnlixZ29KDhMY56n5oA5ETJ6ZCVnMrZkaI2KL0c8q+HNYqePndoNh5k9O5W6uYYPsgxsHF90I3AdllDlBXbmCJYay/pZtZRdAFAIHwFGjW2nao7l1UlYvuUeQ34UwK6ZzScpMazV44mYAGTXP7MWPaL32NMFq1kopj4KQHam2NDhNlYcvUnJTG488FAA+rglz6kBklZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9IUroWJqAUDDSc9iesT6jHvOvyQbQuNSf/i07T9HTk=;
 b=aygt58ff+njCruveWAgrqRf6f6F9eMoFvibZtjx35yHbzl42IxG7ufz96+PlACuyOxP6kqXdc+tGbDflNBeKc4UtlXRizBSLNRc/KbHAIioAMRiROpakYI7Qk5e9CZcfch/OHn+ueeA3OXNPArlLZfu2ts1FWPAJlVuvzIZK2h4MVvhlZDuF+yeIXViW3jVZK7IFckQS+gUTeAMRAZyU/O70nSATR5GVoRUd8fYMDwoGEGFqp+kuVKKTi0TkAAPonN8Yv7f9/GBWREefG78644/IXNNkiWWhi5a7EUTRKmWRrf7w4wyTG/WLI1/3CNiMeBYjOAGEc97ssyOIorzztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9IUroWJqAUDDSc9iesT6jHvOvyQbQuNSf/i07T9HTk=;
 b=NgzaDTbPriEqYTXkizrm1R06hoRGhEK9dBqeKDnECu6//ydFSbIJi1Q6XsE3nzQ3FtsM4aBPhPZe6V5YFyqg12m1TH2W5BiXcSl8AXxilPi+slbMRKJAzWvr5vXgaYW13Gg+Z6uzc3HwVCH9puUWue1z2/ueW90PhT2XToq3uj5x5vwqiH/Rh1iht5FVvAXQuWN+vpcMnx5gsr6PtX1V+3x3jnOoKWKcjDaoWGM3ectclfbPa2zY3al9Btq2QDQX3YsgwuQs+add8alrhOfQIc2ssU2Tmdxw+6F1pqDsx9gTGnR0FJ0/2P2vYu6sChlvJz9PZ3W8bis15wLu1uG10A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM7PR04MB6886.eurprd04.prod.outlook.com (2603:10a6:20b:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 02:28:55 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 02:28:58 +0000
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
Subject: [PATCH v8 2/5] dt-bindings: PCI: imx6q-pcie: Add i.MX94 and i.MX943 PCIe compatible strings
Date: Tue, 24 Mar 2026 10:30:33 +0800
Message-Id: <20260324023036.784466-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260324023036.784466-1-hongxing.zhu@nxp.com>
References: <20260324023036.784466-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AM7PR04MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 011649bf-7a13-438c-50d0-08de894d1a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|19092799006|366016|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kU/7RX9RQcNkeO96fDJd/koBwn6CfV2z9uDZTagEO9vuYM8RXhR2NSIUwC5t95cz7fN3D7JbxzJnoHJB4kLKyfp+LOnCTYPIwQfsMrp1XQePFHcCjycj1gB0ow+iKbQO+WjJfmYqOkYIOI6jYD/1NbxnKlGHRYh7TzF2jgT0JJayZExFivXSfS5y6FHiLmFtp316xVzoyLvesnZbi4ULxcuEHVl4kOCDaWhpfR+kgAjdsPHOQKK8xoAqzixdJcdvej1vuHlkzAlOMgI/MzjkaaNLDMvSWMoTV2rSTnlSJnkVrJs+ISjm+4DU4MwEtMJQtjyXCj9ULGXFkKgsIYbf7vWrlCuO3YNaNCWKKY3lC0twI5w//LCqo/QFn9CLCVS8XBB92xI9CwD4icNi9AWOF4jZP04rDSMq0xGZdYrEGCnfk+x0EcHpxH52iKkEe4PR8oslZL9IJ4WFhAI3J5htBHc/IS6u91LUL4VHEqPCVFfAh/HlnrQDoj0DB18AAQIv0FIb6jFzduuv58jfqBTvrXVGjX30wTYA+TFw88mdwcqtKJnCDW8gvTnAzlJsIgCIgbnBCOpa/J9USnbPy5V8mP8QmTB4sOJSrd8GuvyLgjb11oN/P5E6o8F69mf+ReyxYP6U/LmRSjsCosroO5zSeZ0bsNy7YxxzpxkB71BVcQHcRpviR8yBBIN2VR10u3Mq+bBObtrViNb35xmKr5Pg5Y5g7PeZsF+asta/JjsNBrP01deHeIka1Meun1XuqTropTKLFO8fnEJu+pxAWN3XwtbKV99IXlNbHK+PKfQzdRdJ1IOzYRt+AtwfPleD8zQn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(19092799006)(366016)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pF6oLbsWIKTGM5cnoF8DlvPS6v6WMCb7h6dHoOJE1aLZOiUFmTtyXaGUA5S/?=
 =?us-ascii?Q?uZ0AWB06wBl2fykZ85bCPGDfMd7p5T8h2aCHQ9OxYZ7+eIj5KQP0Ka8jgl7u?=
 =?us-ascii?Q?I139524HMdw3mf8w5O8vmzvrdbD9vX75ZUw1ZwKXEfA3Jnqs82Sw3R7uMU3g?=
 =?us-ascii?Q?3KZxfD/ENraK7L5c4iMJbTGv0uH/o+zOnRx5B3m3BEgfOm3daJHkq+EufMRX?=
 =?us-ascii?Q?U5y4217pUp7RIygWQmLuXUXiwlFcFT2YWQauhU+KTOdiplz6n+hm92g7Bc1O?=
 =?us-ascii?Q?nquRmsFI+bSl1eQjL1iYKVNda8Pe7cY5GWG3Vek0nrhUt/PKqrP/w2sVQI78?=
 =?us-ascii?Q?pdwhrEARGUfxz3B2vyPRofNFnYYMbUmSrSzktaAfZFdlvqRVLhHGdVCHXdVs?=
 =?us-ascii?Q?1J1gRs1l2CpLAti7xhFOPdC7HnVkScoFFXrZMtqt5fPt+zdkayAcotislkTP?=
 =?us-ascii?Q?w8rOH+JJ1kYvbz21kzp1eBWWbJfDIoayGys3OPT9DMdQvHJIl4Hfi2pgHRrr?=
 =?us-ascii?Q?hGtPKsrgGYsp8140Mx1nIW2LUlFQkG0cqKiWt2rCSW86M/JyBC8ZMPnPkJDC?=
 =?us-ascii?Q?uAkB7yDPjuRhiSsSny7mZwzSQg6w93Y/HTxXkT9Fm9LUUAIWGxPn9hxfiSOr?=
 =?us-ascii?Q?Vo7kLpbnvKxd+6u6lX7HBJ24t4+vUqj1KJKld1AA9tybEWwwUzXRhU8+FtPt?=
 =?us-ascii?Q?Kh6ltrPIw28A96eZ9+dbDe8YFljc1kJD07/1ZyZ9m3lsCTWxRX5wC6EU53+L?=
 =?us-ascii?Q?UlrGLe839C82sB1Irdc9Y5vSzNRnuZull7AmnnBxrZvv9kz+mPNKQLZhO6Uk?=
 =?us-ascii?Q?z4JqpU3P1DrWuJ4dSxnVmuoxOIWbT2GFOedgVg6DaX+7R8KXtsoiQuFidDHU?=
 =?us-ascii?Q?LOPyAmPtTbTBDCVVPt8mtPK8Xz568sanPYTCPBNlRnFKcSedMFoXjNt2laxu?=
 =?us-ascii?Q?9T0FOo4BAtJEFbOGKu94NkOzAtA1wV2r58G/C0xtOk/2ouuYuCSSXb8YHcDZ?=
 =?us-ascii?Q?O6+YWgyHUUdQhEEqRF3L2Ys1Hk8DOGKsD8GonIUPsPYOWXxu8yE2XfUjpoOR?=
 =?us-ascii?Q?rBJZtirDyIb/UDula/rvaRmr20aXNib9D4MmmiFYm1D6YS/uK0SuD4grOxnl?=
 =?us-ascii?Q?K+iWBcYHS5nTWsuO8QJ12gxX0dMzft4UOi+EOoPcDoP74LUG052kFXsL/PoV?=
 =?us-ascii?Q?6SCfIlll58FasDQ6U6/SJM9XTjmc16qZsIbkHFPfpBUA4CqgSLHL6AhO95pR?=
 =?us-ascii?Q?EJYenMLFZxu0kEzPPrCV/qOJlBlbeN50ucqkrm3/ZcRIfVPoS/JJ8/O6riOX?=
 =?us-ascii?Q?96oHsozOOmEOBCwr1SoIHkCKBrcoJuizQWMTGzyE0PiCjYj0/JRPN62OkTLQ?=
 =?us-ascii?Q?Rb90+81jfKcINjsCGaib4dR5Dbxo0aC0HTX3KrxbwODKN3HDqemBUQzrxtYK?=
 =?us-ascii?Q?37sUiUSyWjq0IaHRty+F4YhwmChbC1pPi6ZHtPtvAAIWbkSJnWsBy6ktJCrg?=
 =?us-ascii?Q?FKSoJMocjOVY1mjfgZVtcRErKwilhZrnMk4TPy0LPTLNfhZaqM2bl7LZn20A?=
 =?us-ascii?Q?DdQeMYutuEsTgAh4OSt1noQJ7DeM5Ui1rrFEUwuucYVc8ZGR05RsiV8IWukC?=
 =?us-ascii?Q?j3pLE086ScIU91D7CrCePUYRUTXljvyz5QskTCKrG0SvJfTfEdJavoW2bjeq?=
 =?us-ascii?Q?eIdtTy3qyB8FTluGAZFMpvhOPwcb69nEFNyUTTTvEg+PwlPpG1xc50+7jB5a?=
 =?us-ascii?Q?m5g56gzz1w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011649bf-7a13-438c-50d0-08de894d1a27
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 02:28:58.0459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/stS4x25jICak5udT4cI9+myUbdu4spJhFCoqLA89aVpP60IDDktzn3ArJJS/+AcQ4xXKSzjOGkxK0nIa+KIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886

Add i.MX94 and i.MX943 PCIe compatible strings and fallback to
i.MX95 PCIe compatible string.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 18 ++++++++-----
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 26 ++++++++++++-------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index 0b3526de1d62..e4e30da0acb0 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -18,12 +18,18 @@ description: |+
 
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
+          - fsl,imx95-pcie-ep
+      - items:
+          - enum:
+              - fsl,imx94-pcie-ep
+              - fsl,imx943-pcie-ep
+          - const: fsl,imx95-pcie-ep
 
   clocks:
     minItems: 3
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 21dda8066014..9d1349855b42 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -21,16 +21,22 @@ description: |+
 
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
+          - fsl,imx6qp-pcie
+          - fsl,imx6sx-pcie
+          - fsl,imx7d-pcie
+          - fsl,imx8mm-pcie
+          - fsl,imx8mp-pcie
+          - fsl,imx8mq-pcie
+          - fsl,imx8q-pcie
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

