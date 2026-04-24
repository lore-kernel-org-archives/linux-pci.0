Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8464930F534;
	Fri, 24 Apr 2026 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776999384; cv=fail; b=j1kKIPkU2HAAVGhXH599Tt3UpZLBUFGtmbqBfzZ5HGU6nclT4g3/NymGs4OzjGW6FrCQuBUTxsE9APHzQTMnl0cMhVcfh15DNSHRp1GJyvFOIOdwfiTaUrCDcXE9pODyJm494NCnuXMBhAt3nDt66qT16QmXMlwTlwewHfKwDDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776999384; c=relaxed/simple;
	bh=wHfM22c8dIKjWpr12lTdoWJa3DxqAcaHNkWTXqIZ6+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sJzV59ow4gkutIPFfcpphcXrEeClEDYrZg0+DGyRo8s4x4+mdOMjROo5roboOjDOhFcttFpzUYT1lSYE9F3MWtWJtELkQ5oBb9iktSynmAfIIGi1AyrCofYBLAora0JhLr9rfDEN7H9GMjA9hyGW/zTy3cfsbxVL/qrj/STZuWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FsQ64784; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FsQ64784"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izocc8IL9CPhpz9AuEXDrEgi2CKLGWoKpbbH4gkSU7b5Dk7oGIy+fikgp0CeFtpHk+/T8eotpT+1b8arMWrVkaf//MmJBYOocR8Ax5rsLWDQ9Fnnu2AGgAH9Khpa4KBsdBFzUkyA+hD65x30mAs/AsGvkgpmq1IsNdUq8JnXbuWF/1k1D0D8es7mY42buEzQWRmKuRwQIfnCYJktenzQWMoh1Evw/k0gry4+24YZ1VOjXCu8/ekNST5wchso2Oo96oFdbQl0g0U32nz0WX+TzaCesFgO5I0KtQX324PsoX8cDJOIA6KNCbchMpLv+Pxm5VP4L3tfO7ea6PbDAWtmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbqblN1M+IvHHk3UdGJ27HBKC5QjQ+lxAifFkb/7KmU=;
 b=dR9pIl6gO/X5RBclOFbK0GU/0xAFLFvfOo7ZHQjnfjsb3aVTmh14HbsY+DiaZrWjkGddk65aCjToUzVzu9tP4StPI/dq4xoffCdwTquVb2cBE/en3caf7EnI91AAJVYAb7EbYz3+uxj0gLX5wcw5st0QPE+fmw9xgLcdw/c1mNLIjzougmI0wc6l526zxKROO7CHOXGuUPDvIVtrcPzPb6RjoOJyJ0lQlq+TK8ZKL+idogmGcN+vW6wy+O8GRZYB1qEjmmNY7jduC3ipWlSpOvp+pZP7W8gcpUq2y3ZIYozB2GBTZE1XXYsbtUrb1fFTkPX7XLV2TuzQyh3PC3cpCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbqblN1M+IvHHk3UdGJ27HBKC5QjQ+lxAifFkb/7KmU=;
 b=FsQ64784fgivd382TvwKRsvaKaAXfWb9XdqQTB6sBCYssDbpMYMlYYDdZfzegGVL2tOILrdgyiZbPb2PRFS9bdxEGd3GQg46GwVgRH/ntvnTUYUkDat3MzxGbTeqk/C2hv/sN7BkeAfGbFCFQTG7IHjHNpgB+3ir5tAefARivpINyDtsY4ELT0i0uiCKFyb0ClFdWzI7+qFJg+jcmfXxo7g/T8vyFg2Vmqjzc0XwzVR2RlHaSlrd8mIYX/I7XtmvGYWyCBeA8tRZ+C4L37ptvI8UMG2ae20Nu5piF9zXAJ9NZ7MBidAdtE4b2HcK/eQS/2h98FVT+EEcmBi7TRuJpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5222.eurprd04.prod.outlook.com (2603:10a6:20b:11::12)
 by DU2PR04MB8791.eurprd04.prod.outlook.com (2603:10a6:10:2e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 02:56:11 +0000
Received: from AM6PR04MB5222.eurprd04.prod.outlook.com
 ([fe80::374c:87:282a:63a3]) by AM6PR04MB5222.eurprd04.prod.outlook.com
 ([fe80::374c:87:282a:63a3%4]) with mapi id 15.20.9846.016; Fri, 24 Apr 2026
 02:56:11 +0000
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
Subject: [PATCH v1 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and pme interrupts
Date: Fri, 24 Apr 2026 10:57:33 +0800
Message-Id: <20260424025735.1490772-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260424025735.1490772-1-hongxing.zhu@nxp.com>
References: <20260424025735.1490772-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0223.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::9) To AM6PR04MB5222.eurprd04.prod.outlook.com
 (2603:10a6:20b:11::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5222:EE_|DU2PR04MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ec6988-09b5-4c22-c8ce-08dea1ad0abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|56012099003|22082099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	hJ5vUZ2l5vluVIQcwzQkfPzSV2A21S1RQ+x7MvrDgjM2K8XC+wBYumhUAc8aGJDl4IZWFFuBPz9ap+Y48xpO44PH2ffjQYk8BCex7ferTQ0wcUTnbDmpwHkJeP8O4LeFOdudyGpPVPXxjrBU+NYVWMpLad93EoxvxJszbgnaw6vxYeVAmBiPfag/W/THUxxruu2jwAT7hZjIAqAzBB5PNiLyRuAvWW/GOU6HVr1ZHqr2gM4/i60XTjszLazgi2hx91cnssVihIxy8+VSCIOXC0zfCRsF60Krrl6S7Y7WxXr8zigK5qbFmC8FlKXvBVHy7bnQtKD4Z0NPajF3oiBz+IFQhRrXxF0O1dpgdxSpJvefc7WkVwqzW4KSt/5E21OBSCwxrh9YhPE/cMKLU13PIiaExF1QQCd/XtV9EexPV2zc+BUv1BQaxSIk6qCzzuJJEBj8WjLCCjxQ1nO5K3j/NXtQRCTLABhmgpdwK7Ph0SiuQ9sfj7x9dYAhMmAHJ4r9sljf2+aDcY8mXJuJB4w707/IjH0JRVmXgmaS8tZoWVcZ9f2cBllHGhD8ZGly7aNmiNly5/ceRqZrmsRccGActWhGQJsCEvyb0FI7wfrIXCJBXSEw629b8fTLuwgB4fz8oHgAJYirdqZ/lP27Xdev2irjM/mKLepFD1Pr9l0SHkns8YNimNw3ZNNAZJL56E2h1Ezn9m2EE7VTRXI8qlRPYoWN2E+JiOTvj6zBLDeJA6ryNHNE33jaEdwM/LyKWHs++PWE/BQeJ4vDH/jYtoRWymYDRjGahbDzoAjy9N1EKuuE0gYLZj9AQiKAQ2k8iymT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?exRFn4OdIf30AagzrFAANcJ/QrtSm0FOQwOf6A8gq63G97hNG/kxaOw3yNqA?=
 =?us-ascii?Q?uAQwhnZtarDeVnPfUSDRbsJqv6RysP5wJwj403bpsEasRW9wbXSw5hS8z6iY?=
 =?us-ascii?Q?Kh/5f4jNk7sWc4WbXwTEKpJzVcUQBzLPuveHH2ygy+/avJ8QsEi7701K8RSK?=
 =?us-ascii?Q?if/mBdLu2Kbr3TbKxeGCS+bZPGTUvOjQ+ODMWXfsArC2oxdA99xSkGuyYTf8?=
 =?us-ascii?Q?+P0uPtZtxUICrskFJLQUFagSlTv2XOqA+NKidkeCOjS0w+GcJVa6wwAImz/T?=
 =?us-ascii?Q?oqy6fKgkE5a7tFSFZcL1FntI9ecQVZmLfZIcyq9BZKiXfU5FGitHkO9yUHR2?=
 =?us-ascii?Q?aGY9CgrYrBKVaSJNM7ywQLWqioqcxcmP3K87scJjZwrBgcbKJi7Qlc68Cj99?=
 =?us-ascii?Q?a9lQbDx3gfTYQha0D3aWLPXnXD8cc/JV3BI0Lkfw/J6DLWq7azVthc8xzowk?=
 =?us-ascii?Q?/ncNewVJmgV79jj2j7jqCxVnLFieFsYq7RST6FBv0TJBJ0zq+g9o/W7zvR9g?=
 =?us-ascii?Q?pWZvXK6cNGIjaNgwc2zYo1Ee17gQSNUmykiDxuwN3DUGx9BGDOPjPlMqpYbN?=
 =?us-ascii?Q?18uwXgoQm+cVWoNbyqbNz12ll9M2RhfbKi7TR8ZFjq+5gi7jl58RiUcv6fMm?=
 =?us-ascii?Q?iMiMBLPdhRpj65FxkVmerwbJI+Y6Ip+GODl/hjHVcnRaWbN7ZvzuFQzaG1vR?=
 =?us-ascii?Q?QuGa7fqCA8AGXMiGW40dPEHvAIPzVmoKX/vbdVp04UZx0+FNPus3ofmaJE1X?=
 =?us-ascii?Q?DTg4zBa0yHv22saqrx6bdd0zbVxnRaW8XyH78W0qdxKpKVx/Pj3YApeA0kvm?=
 =?us-ascii?Q?G8gxEZX0Ga1VAZrgSN4CoEIsSGUDRfcD6ZIjjof7eqVcl7x6GmbZWkkwa5Hu?=
 =?us-ascii?Q?kVY8M82zboSsCmWFCAQ1mQdBsV+l714/O+0Zp6O6vkAs8gGXOit3a/3+927f?=
 =?us-ascii?Q?5EeCKrFquRxq5dDaUMCNFQfzn+pvUCyA1BTu7WLupHLKUORi5+qZfbO+f+z9?=
 =?us-ascii?Q?q0KT0xXZE0kD4p2HhnLGNq6h88pfusMr7TNEardCjL7KxajZbyuXoCwL1Mf4?=
 =?us-ascii?Q?oPRkmhIjBvlO8dEN4VF21H6Zl4BHieSVtCwqr5UpWUZXye9F1J6ostDuAlmm?=
 =?us-ascii?Q?7Mpdo1RBD4aU9Nb0Zi46iG20TezxB0dhwq9SeT5MbxXIubRLoCLDsBaO0Ulz?=
 =?us-ascii?Q?Zthev+6X5eEq0MGUrGvnw4j9HTzi/RbmDUFrun2fChdbhzxpyK/PF4GiBKrc?=
 =?us-ascii?Q?EWcnADMGCqVidvseEkrkByk7ofqvVgBkTajRkjEUvcoXB9zctX2sl3AerTnP?=
 =?us-ascii?Q?UaBY+fOC83SHOAHzfWZ7mQlCrMSmGjSnNno1vlG3rhJDYo/VgH324zXO1IhZ?=
 =?us-ascii?Q?tgVfqMxEJl4vrmNl0e+pDJQL8LiuYYu8JYodhHhWFTHbskbFKc6cwCdFNAFn?=
 =?us-ascii?Q?Q+ASoOJWCyAepsVwwWM0PA4qT+rcwvK8X/OdpYIypAjC/e3HULs1Qn9OcK4p?=
 =?us-ascii?Q?ZfxbBI6XAZLoD02cIcnynZeGqupGpHOC9RWtSW1a0WEqjc0Feu/QJ881JPbt?=
 =?us-ascii?Q?/osNtx20C19p8XVF23h6WOP/L+melG3ZxLvQQNzzuU+gFjSCS9FJ/dgD5FH3?=
 =?us-ascii?Q?B1jdnWChwDw+Gm01BMuhAK2e8P3hzC6EwR8I7qtsuUm/Yh90pCKPcOLd4Ziq?=
 =?us-ascii?Q?DUPVkTlRLmMUFASgMmxlvqequQ+H858lhwd10F8oR9dQak4k+RLDeFKwPlFw?=
 =?us-ascii?Q?uN2UHxPn/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ec6988-09b5-4c22-c8ce-08dea1ad0abc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 02:56:11.7872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDhkBqYBF6WaLGwQ2420p00352UQPvHoi4lu6eN+6CLz2YvGstKCtpndxG0O2FpFf4RMUIFJIsJWD3PbdsIYig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8791

Add optional 'intr', 'aer', and 'pme' interrupt entries to the i.MX6Q
PCIe binding to support PCIe event-based interrupts for general
controller events, Advanced Error Reporting, and Power Management Events
respectively.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 9d1349855b422..badc7fcbd556c 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -58,12 +58,18 @@ properties:
     items:
       - description: builtin MSI controller.
       - description: builtin DMA controller.
+      - description: PCIe event interrupt.
+      - description: builtin AER SPI standalone interrupter line.
+      - description: builtin PME SPI standalone interrupter line.
 
   interrupt-names:
     minItems: 1
     items:
       - const: msi
       - const: dma
+      - const: intr
+      - const: aer
+      - const: pme
 
   reset-gpio:
     description: Should specify the GPIO for controlling the PCI bus device
-- 
2.37.1

