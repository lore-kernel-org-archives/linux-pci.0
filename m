Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AE737B402;
	Tue, 24 Mar 2026 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774319366; cv=fail; b=Kn3He7Yo+P4+mIpWK50FAChkNeDNecoP51DVrrTYeZRzce/K9ic8wEzbXTiNYfxbxH7O7rl50y6MyRjLOvUBOFse5wdFBTjfQHugKDcItrnJ4EFcDBDNAwWIXSNu7ImmZdJlv19t1yCIms61IW39Ldha49cYbqiDtMgrpQsUW+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774319366; c=relaxed/simple;
	bh=cILWwOm/cvWgB7AlqvpDJDO2doTOG+L/9Os6Gl8jiE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R14uTlJJ/WosOtCN1Lr9eveDLRBolFJppBtT86dDh8+jN+xSSyMOJctBrIIbovSxWLPrM9A6G8MHJeb0lXEBi1LQ5dtpZAZOZMOdfZmpcl52TY5hG3PO13G4lFJpaxVoFf5S+p2b2n+Z5oIzwSS2PCBGRR2V1xS9CYPm2tPZABw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yi59NYuB; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yi59NYuB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTy/itWdjDUDzUL0e4ZQ3PDReH+iPMOTQ3ANBwdLS9fMtgXwdwNr+01vT67LlPFs+I0+sHsRV27Tk8I6cWZ48GmMIgQKd/vUuOffotfJaDUvmhKzyh1Qfno8IHpYq/Ys+wf3C3boAIgHX1mDUHoKv82ngJg1GUvOUATK60txCFKQ9GPRI+L+67Z7KPh6pi0t/EtZzLrWCFzlQYHsB5eMxlTePMi1XPRpR32DKlm7acAxFoaVsJRXZw71RRnBfH5cyUvTM6VKxLg7efn5k3ZmJy7g6Oq03B3lmrXp3KRWUTa2EYzT/mkKl0fjqbFUIvU6ExGHL73gF0DcfoX3O6gOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+lgryQn6hO/fMLEw5GgeSMGeHBtiYWTjuzMrnJ2+n0=;
 b=BBv3aQhgJyxGvyVHSs6whQ+RJ1lU95FM/CItbXucj0EpwxiXjGtSDF9Kmt/Pb5Hd9AzLNuJvFBRXKrFjYm2co6HfFeBVzbj4B+I2Bh35Tm+vpjr6OvDxzIR4xBxEKNwN6KRliTY2XRRI02t9JpNtEXuMBzDsgeBX3LDOmHxQ0YVLIvFOi2bG6lyEuoiOBn6Mv8ooOrM0ChlamJYxYGng0ha24CpgHd15gd12VZYoqKHpxGzlQOOCRxDEYqG6n37Flo/kmXb6pZmIY64OLl6GZQyhvirVnXBxHRffaOPWr/2o4m2vHXLw2eBpxMxv8/DW1gnR5rlPyBaohkPHtvTQ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+lgryQn6hO/fMLEw5GgeSMGeHBtiYWTjuzMrnJ2+n0=;
 b=Yi59NYuBUZLPW3s1umeCwRgzkOtuvvZJAQsi+5dsnRbh9aO4Ux8qsRWG+IGBS+x73PQOiu6V7mB2xrGf3KRWr+vqBmdLbyeOnus8dNDWpei6yUJGOpM4QmL0kzJbhC6eTeD0vuWB9QaG6pDrbi7HS0Zw6K8e9TzzOix7YcaSZ4eRgQR0tuNuxEeq3bGCnH1KbR+8ojfCso6453ZW1PS4KxvzEea8qsHqF1wvsUEbxHgsDFFGhqOBWg1DcfKmu+9r1ST3AMO1p8+Nu7HdGJMz5/uPIck+OtHDEjNdMAjJVF7SGFei6DmTCNtGl5BIjRXSY8RYYih7xbrSdyfWcgd7Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM7PR04MB6886.eurprd04.prod.outlook.com (2603:10a6:20b:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 02:28:49 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 02:28:52 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v8 1/5] dt-bindings: PCI: imx6q-pcie: Change maxItems of clocks and clock-names to 6
Date: Tue, 24 Mar 2026 10:30:32 +0800
Message-Id: <20260324023036.784466-2-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0bf7b45c-de45-411d-8d24-08de894d1700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|19092799006|366016|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MZRrJQ+fP1IkqACslzPuTvE4jHNgvodDMRfKCTuhYgKtHUt3GIpuhvQgj01nEHb4aHRpB4c0AGD2i/mfAjXtwzlYntwqWlBCkztMNEkr9PyYUnM6oo+t9A1y68r+YUT7pSkoO58hA8Ox0CqyWRIrP/ci/xSq0hzNkYGL5TmbYo/rd41cymfo4ThHlbURx/dTQI2YuYnJiOSMHFPVIqiKQbL6MJRpK3CPAVbNuVfObXNnZAGYQ2ccR7+X1TjISfUJibOc3GId2uCrFfGDZDGYPWBfals/24lL0jwh/uqLyNFUR9AbY2I1xxB7TpsaXuuwY6PqdPhuhMfpCxN8znrrIRT9cMyKDQAwWV2GErmF6YfAFC93+KWPTFHk81ZvKbNj/noqJwq9szmymQqPTg1xloq89wBOFaEycin26qxDd6PzLtj5wGnKMZgfS2YmHdci3TwV9jUkuQf0NgEeAMOZ1XQjqXGDQ/nEJ6awS91FFCkO7Exfn/ZAZB1nR/wrt1qBoLZP1oSLgu6rsoxsn9H15cxqE8ynroEIpJR78Q4BEoAvuyjBNEBikb8zLbtned2NJRbke6ZZ8ZTTegAJqM7GHyekFJYYsKMnvJ6NAIFfXgVIa9q2c7v18ZgxQkKQ4Ma8ww+T/p1bKga8a0ujApTfD9ZCNJo9RqaAczMyP4edrARXLzx1n30OUIz4JCde3Ojz6iCL3wBoPDp1KMNyQZX4XkTQEuJYUntTamLZOVNLS/sIm0JC1s3XM4iaUGmTIcC1bfK7ba9n24AkyUy7DfC65g5V/OiTuIaLg7enbRjhprtR333ziYGXD3TaclMH5JO7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(19092799006)(366016)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CDEBynliIPTkxZNjeBMb6pghAFY3GmjO46UZEAJByW6E4jrQr8p9M3zlXITm?=
 =?us-ascii?Q?rqXCzLxyi1H/5Hxk4n9eXA9dOWIA4LM8vJisuUMiLDiV0eQjJ2oecKaFvuhD?=
 =?us-ascii?Q?0z+sfRntfO19Xn1USQv+snEaao45UqP0+jCio+wvQmrU8cj/WPQ2T4S2k5GH?=
 =?us-ascii?Q?FD5dvyudyDoaGgHFXbWKFX4VIEh9dRJGv/15kjmm6B7Aqtl4hoRh7sYfYA2+?=
 =?us-ascii?Q?pmfjle2SewcBGbH5+OICh5FY1097AcBSIE7aokGufBMJlNJ9j5cIl9wUq3au?=
 =?us-ascii?Q?ZTRqjIg/GPd1wOhrJQVbmbzyLsTo+7ZZ/nhwwFlR2mqfjE5Pv17Gx5utZ7Eg?=
 =?us-ascii?Q?G4Hb/ST9jxQ9ZWJEja4vjLp/YwtdTcxVoxvst9MvZJNeepXv/5j6S7sXyQT5?=
 =?us-ascii?Q?1ULif/3QjkO4CWa8bLuSqRxjvxXsyj8DYG+rlHPicGDoqxDpA+pDeUJRuVYK?=
 =?us-ascii?Q?jw7uBo6g7s5UcoBwuAfsGHxtlRYT9FE43iVvaunJ+WKqB3itJz19sRz80riq?=
 =?us-ascii?Q?tGi/mwxZvCJ51nD+d6n5Wp1A4Z7f+IjOgKIqJK5oVdZohQo18vA0zs/YYSHR?=
 =?us-ascii?Q?y2sE5sRbRJptRVl0iTHhRKRVMDksknAVIazlQsYhLodHPeaLgBaEKrNTuJHM?=
 =?us-ascii?Q?IVRgJUbUWbE5VthWPa9bwG1hmT92eMFvWI6XF5T/V5giCgQ/3OJrXQ1SmBSp?=
 =?us-ascii?Q?y8yZDbK6BTCArWi5xFUolAOWGp3yF34lGStym1ituwB+IuVvs4VOWvXWdbZr?=
 =?us-ascii?Q?TyAZtJGXH16jKvWcVEdVylE/yW70hANkET4nD9nIDVtvJayqP51SVJZWdfyf?=
 =?us-ascii?Q?5NB/7fR4lgUFrtRPKJebAqGEB/wASqf8QzdtWbxb9owE2CkVDDK36F/kc46q?=
 =?us-ascii?Q?P9Jo29tU8Cje2kvzyxPEOL6LyYiyc+0Ne/efvbAZ0I7BDFJJoXDnP+p0tMTT?=
 =?us-ascii?Q?/aHYON0aCl1KvMcsPrJRxqfD3wWVRmmd7AVsC8njga3B0MNjEcXYzr2we7HP?=
 =?us-ascii?Q?ooJxrQkUWYD7IrNFsE6AqaKWhs/QudA2DykbTtsJhaVyHmfvqzSDUBjMZ7qy?=
 =?us-ascii?Q?vCAm14iXcSoEhmeLJbS6F5lMG5mqRg7kxoBhU3eezJ+0+4LXwA+cAkVrst3c?=
 =?us-ascii?Q?2ieznwd1tXJyQJbBPtSu1+ZKsU2r0dNlIBW6jUmaaTjyMjAIrPOGgwWEugvn?=
 =?us-ascii?Q?C2wQVYhY9mwMxLFhdOVH0FWJZoryfTznlp3bFflXAVesW2jIe0V7w/yg+9kY?=
 =?us-ascii?Q?Syq3USyq/8DeCq9rDd0od+ZSv888LEWfpFcNU4xeLU1/zZjuhqDRVGLvoE5k?=
 =?us-ascii?Q?KMz2SYTF3MaAyx4Nab0ttDgamY+mdEQENpflAKVlVj064IIJBxAyRtjx/eH1?=
 =?us-ascii?Q?xKfAyRSD9nz4yaIyndQVP1vXl1+k3VirW6TkqSEHaUTYQNQt7o2usTMrTEhC?=
 =?us-ascii?Q?H5E3a7LvuyAoBv9o4ALmG/mSgezaIt+w8KNGoDzha9Nib65WiE/tuX+mWpAn?=
 =?us-ascii?Q?W0rb0lHqQE7nYg/+5I+n2Px6PqL0/rohysxs/ek0D2+cz0YzQHy7NJ5n/MJ3?=
 =?us-ascii?Q?m2oCkTh114Thq1gTWStj+o60XZXxrQjMiXrLPU1+jknoeI0M2tqCvB0rauq4?=
 =?us-ascii?Q?6+LdZr+eN7rLmQC/pfUc0ldNIgEquTptck4eW2n3PEfk5HsMfyusgLv+X+Tk?=
 =?us-ascii?Q?oqKjd4cdaKMkNTZkZHQPWWh/SvYEJNsVI1GOKeWYswpakuOt+RqeDCqtj2+x?=
 =?us-ascii?Q?XrjzInaXtw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf7b45c-de45-411d-8d24-08de894d1700
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 02:28:52.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4peIMz7qbQ6ekUJRoT2trZtVrv9hvBncdpm6ZZR6Om6yJsoR7xn4Bv2eywjOh6u6XRIuVH2WS4iAh+C2NQf9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886

Previous commit 1352f58d7c8d ("dt-bindings: PCI: pci-imx6: Add external
reference clock input") was incomplete.

The constraints for "clocks" and "clock-names" still enforce an incorrect
number of items. Update maxItems for both properties to 6 to match the
actual hardware configuration.

Fixes: 1352f58d7c8d ("dt-bindings: PCI: pci-imx6: Add external reference clock input")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml        | 4 ++--
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index cddbe21f99f2..0488c942092d 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -17,11 +17,11 @@ description:
 properties:
   clocks:
     minItems: 3
-    maxItems: 5
+    maxItems: 6
 
   clock-names:
     minItems: 3
-    maxItems: 5
+    maxItems: 6
 
   num-lanes:
     const: 1
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 12a01f7a5744..21dda8066014 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -40,7 +40,8 @@ properties:
       - description: PCIe PHY clock.
       - description: Additional required clock entry for imx6sx-pcie,
            imx6sx-pcie-ep, imx8mq-pcie, imx8mq-pcie-ep.
-      - description: PCIe reference clock.
+      - description: PCIe internal reference clock.
+      - description: PCIe additional external reference clock.
 
   clock-names:
     minItems: 3
-- 
2.37.1

