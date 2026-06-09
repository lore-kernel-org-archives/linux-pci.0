Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013026.outbound.protection.outlook.com [40.107.159.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B28538332A;
	Tue,  9 Jun 2026 03:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780976196; cv=fail; b=slp2hZm7miQj/X7aBWRgG5u6962EL0NY5ZL2Ve5BqaGbEFt8KyjvMNR9Y1S+vrFEX96Z90sA5S4kFU2MRUieFYSYqgo+U5woqrlUScBKaWVc3NE7tYqfSUL596tz4g2lI4iXLqHiLD3jZHkSJbdZ+epiMVdGAzwVQITDs/nuiqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780976196; c=relaxed/simple;
	bh=bcB4N41gSLjFKOfODWzHD8tLsJGYnZj2LXulwwknHls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DrYYP4NTr150BSXPGOOEOH2fcRdoXyT5+9h+nmS31jjlJnxNw5tX7GQsAC6jrLJLOqWpUexsw850s1g4tEiwxv2M8eoT54Dp235Hh9iBIOgsP2TU8J3aUA27ES88FHhYakZw+IzuZ3lNHvFrdYSTN/5z6SmdyL+BgExZJAq3VSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lU8vGoAH; arc=fail smtp.client-ip=40.107.159.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lU8vGoAH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=At4cAgY5qzWLcnmLaTnn9vih6gcsN27EVq9NSGdESPtHonH+eb1pw3emhxCer72kfq7hjD3+fzFRpm2zjlg/7DY19zRshsomuz4PsVK9nDnz4NC8mlsex1eecHI2hLVCHlcenMCGBlXsX30vWloPz7lO72UWHCnvDznPqbotyuUS0V4j0IiGivjHxwRes+qQEX6WItFLHyEsTRcUhpzNNCJxCoJ6CcdUwPL8o7ywaCsWRtprr6I/h7h+44jI4K1xJ/hQFcXtLgPDDxSGlwIyVFcgFBf/ZvNXS+UXlFbLUHR4Po7zxOrD/YUxRv+kn79NDaWN/BU0N1FovpYOIrGd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+XavoGLa/6+7aWsLMBhWGRI0JQReY7D4iwx33uZhP0=;
 b=vyedn7l11N8tgrFjx7mHbpPjR3NTL31QReF/6KbT4UCGbfAWXinAQgAlBlzB+v9in/9DVp3gObkn/JGPhYGUJdpXeyrOphM0eU254hU4micVY9RramQBh5ZeYZMS95gJxRwILSuPifzof+iwy+drEZ3s13lyMpiwbJTXRGBx2c5S4gKSYAoMrrXuHVIJ+s0l55T1SWHKthKZgfiBZW/kLnAENJ6ngRf9Dnxa4iKeHiPEUGqweRMHnu5r4/PH9y34Xn04L5ybo3qAL2C6YB8SPPMxhk8my1PhuY6sDiq9hFDjyjlC29u7arDRMXE1p9Idxh7zk1TxicMPzyrsyQ1Mkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+XavoGLa/6+7aWsLMBhWGRI0JQReY7D4iwx33uZhP0=;
 b=lU8vGoAHqRikx4soUrkZIr+QKjgx+vgrwR/32qgmTex2NFn8aJ4fNWYnvb2IKRuLjaGudddWGp0SRyIG6iupZS0bZZBwQljXcp2X9Rj8QOCDV3mSTSES9rBH/HoTgfX9T2DXjR2wJWv0hfv2X+ek7AsWbGcXpXCWE8bzt+bielYUK1+XSxXIQoqapoTzdlOfYi/AMg4f8p5tK9M53+kHj98lhqLpukJtpb3z+ChZDGyTMiYNasCx9rVaBeTuBJBzb+4p+2xCbwGU526tPKASQDxMe43K+Mr7g0uaQ4/EoUhYJmccy0AE+4KdrfQI2+I5KvtXxNxwZugzmWuwqyyCGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI0PR04MB10543.eurprd04.prod.outlook.com (2603:10a6:800:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 03:36:31 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 03:36:31 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	brgl@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	Frank.Li@nxp.com,
	hongxing.zhu@nxp.com
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH 1/2] dt-bindings: connector: pcie-m2-e: Add 3.3Vaux supply support
Date: Tue,  9 Jun 2026 11:38:38 +0800
Message-ID: <20260609033840.2006078-2-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260609033840.2006078-1-sherry.sun@oss.nxp.com>
References: <20260609033840.2006078-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0299.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::18) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI0PR04MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: f55c11c1-21c9-4fcc-91aa-08dec5d84bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|22082099003|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	qYTWIQo6aSnDYYwfEPNYmadvNZMpCo5mQK46/LuyeyqqQboRuVH2FO65bBe/jhPfqi727nJ7XuBop09ocVGGVn1kypL5PlgKWo3goGz2FIcQ0BZkC0rHCUQoaybzH3cuBko5GAVcOHGLkx0YhEGqhB5VWoLpq6BZPCN4I+ordDXo7Vyk5ZwWNhgyvDrDgO/2lQZHYn0UBWkbGtDQVockN5eRR9qTtaHAALfgmfx9J0VXkig2Xn/d6A8yRCZBCh6gmV013OV/zzGzAv+M7mMDhqYsyPagI7wJetZllenanEYee5go5YSXn/YfgPA7bj1TTvQJB8VWv7suvDeiZWQ4OGiD+fHHaxlQxbGkWF++jZ7tj9yNHeD4D5uoRqkQUwqx/MslLOXb4VbFUoR6kRq3PcEOL+MLRWZJW6H/8vHl7VTQcGTwzu1bf/GxsffbP3CKquqfM05/0fdtzFqT8gNlxS5oKoOzXcUA0sZ7lnHxDKMXhiVlqQ0pStSNhGD+KA6APPld5lDcyRZb9/vgSKDbOQZf6Dqzs9kfm8I0fNrf8oOTz6TLRwgQmx5+vTqTClKzBL5shHwKF7Ss7CKshlauu9ZEWT8Oam+u/e204IHPYspAjNXz+gr8AxuSphdzPyi6qe8GxLbl1D6hvUGrDbhqHhheRNIXkiPVyI0IV6uPV692KBWypb4ykCax/PIhXnHO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WYChXirOIKM+Ak3nlaJZFeAUZ0hXX+IEagvVYIm9xdy0JjWpuBiG178EvTbs?=
 =?us-ascii?Q?ZV3jcF8mLSPy3Gcni10DtAHMMmddOgxq1EG6HBZiTAtWablKdJ9nR0c47xUl?=
 =?us-ascii?Q?6oVPT5pfSOYZFBtbQd7kvPFx0ttFw0Z3O+n/4EF46LLGjvwD7b4Mz80GYiHI?=
 =?us-ascii?Q?qkJ2F1/Gp2qcGti4jNAPs8tFZsa6hLLSqxxHvwICzfKS48n0Ww5hKktwYx5o?=
 =?us-ascii?Q?Yaj8whD5M9WtQ2pGlDm2PDgzmRnGPbgV75fGyolupyBmo6XhCAaFjeFN85pj?=
 =?us-ascii?Q?8mt4YBAQOQcsZ3XKNrphqfqwvBA9zfkGsPcTFgmnvOa/4g0LYdx1iSWQ9OAZ?=
 =?us-ascii?Q?bkj2btY4AWTV1ivv+kg44cbnPF3nfVIRCw/AgauxKBdrGTNsw5Rkufwei+gD?=
 =?us-ascii?Q?wIoV3oEorD/V1EGdBIW0fquwZQb8Y8VXuAPJMxPYoff8uZ0INo+qtBGt7jli?=
 =?us-ascii?Q?esg1GEVP79gsBS797mPprxgma6HXtAfbPbFveA8zIojOWmVgbx1b1TgXw8/a?=
 =?us-ascii?Q?RDjtjJbxTD+CtYy6rbHuaMAXmpbFYT9R4S6T4XesQ0yyCUFiEpTap5QP7PY8?=
 =?us-ascii?Q?hPu/JD9MmwIlUkylGx0uFSYRhYw7wlOhiWXd2w6swsYvW93uSpRtAaj3BNRz?=
 =?us-ascii?Q?OXLXRUCycpKiFhTYPe9lmIYinWevftT3br7n1ryfS5+ZwrSFV4Iqc4QCFc+L?=
 =?us-ascii?Q?aYcrU3JL7shWe6GFpybKuIPf6BQ3+l2/0LQ3sVeD71FH9ADsVkaaEriS+pF3?=
 =?us-ascii?Q?VL5e3qlFnJrCHICM1LtM3hNAq50v66MuQRnCzY/2Y8hjob8pr2Sbk7H6XjRK?=
 =?us-ascii?Q?aFAISN8yEnvvIKJR+51VJ+uknCYKS2xLd6fpOe2AUS0UCPfeHggc4V1vpe3f?=
 =?us-ascii?Q?D4DP+6OqZ5ubDl3VxlibeEp5X8mlIh2x4SyxuWldohNXAGuzICSKs+oKaJTf?=
 =?us-ascii?Q?BhbKXsZO8MRxw0MRYL3FWAFEuaY2bLtrukelDFtn95qJCFEuS7nS1ce9cGa2?=
 =?us-ascii?Q?Zx61xfN8wz7ygEjseYA9HP+JJvNhv1NmdnAI+NZQ9ZfPgkiXfJanpYnGn1hL?=
 =?us-ascii?Q?jeTdPhWueHBjy8k6NqFsyiV3Da15Zp16BMOHQaCI4iToKzPbBp+SE9oWwFcw?=
 =?us-ascii?Q?dJy9Fdkos/zeR8E+zd05mb2WbO9hD3shfGHx4gVts0TZ5VCbv348S9aISP/u?=
 =?us-ascii?Q?232ZdeU6TUeSbPXVTPYuya+CittHqnLf8ZKoylU4pUe0iuJcz7qq8TrDbGEe?=
 =?us-ascii?Q?F4EqPgzm1qTtXf8ZwHmnst1mmZioMK0RNCQW7CPgcHEqdxZV10OBs4MoxcAd?=
 =?us-ascii?Q?lrY8reKC6azt7TLw1DPIrKRwx+9ZQGPz+j1vwEiZVEQtsfuOOQHi3vc5jDja?=
 =?us-ascii?Q?GZcFKP5C2u9IS2kRYXPbPjDgzxzdqE36/TB3sNI+dlFeMrGdb5AN9BZtWupN?=
 =?us-ascii?Q?emLUMNl2OWhBwtBtK+KZEyd391n6ciZUWsPg6/8t7TjNmP28Vg8sZ/WFZ/NX?=
 =?us-ascii?Q?6HIC6gXC5EwONggo8/KU9G7/WD53vA6/4mmvKQIh6mBc+WVkZZGkgNztczZ0?=
 =?us-ascii?Q?A1JVDiV7XwTAkT4pAPSDuSjpK5JoBuTQ5b2du/hLtCkvX302/JKz6RImQzxE?=
 =?us-ascii?Q?wb7+VSCyaK70Roc0pEUC1X0YI5iJxKHGWk4NOvMhHrrARr/VUhlTIeprFeAj?=
 =?us-ascii?Q?+aeJ37ng+MyJ88vPyBIGSSgVRdAadsUVfhtwAQ8W1JCCv7MQxhIBRnEhM92T?=
 =?us-ascii?Q?qb801erLYtBPgTWENb0uMBUD8wN6bWokjrmHC8J13bjJ3msB2tqC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55c11c1-21c9-4fcc-91aa-08dec5d84bef
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:36:31.3766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quxmodx2/M6gEs5WlSrd+4f5MRtQfwIsp6TyvJabn9W/2mXqLYQFyBjB2lIc0V4Pikn6lATlmKAkKc00ahCO2Wl9Ym5dQI8n+p67616ij8FXtue2EjwjC57PHnA1QRLQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10543

From: Sherry Sun <sherry.sun@nxp.com>

Add 3.3Vaux separately for special handling. This supply has a different
lifecycle - it must remain enabled during system suspend to support PCIe
L2 link state and wake-up mechanisms.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../devicetree/bindings/connector/pcie-m2-e-connector.yaml     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
index f7859aa9b634..381b2ba8c80d 100644
--- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -25,6 +25,9 @@ properties:
   vpcie1v8-supply:
     description: A phandle to the regulator for VIO 1.8v supply.
 
+  vpcie3v3aux-supply:
+    description: A phandle to the regulator for 3.3v AUX supply.
+
   i2c-parent:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: I2C interface
-- 
2.50.1

