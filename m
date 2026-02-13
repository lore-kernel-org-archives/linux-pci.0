Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012030.outbound.protection.outlook.com [52.101.66.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7851257423;
	Fri, 13 Feb 2026 04:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770955697; cv=fail; b=J+CXKfIQSACS76OYVX5ze5b9HRwMQLt4wDGN+1Y+uFTIj/n34FQXyvnKzwHF3NF6j9iNI/xOOjn0nFFbrPVw/Oo7N7bepLcLIMokIrtyAC0udsz3oNOE/PZt7vR0JOjFpLIFo2BhESKD2rDuAJ0n8ivFOkSDD6YSKVlhW2jM1s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770955697; c=relaxed/simple;
	bh=pgaxKp1H1/66RvSuRyC7PY430SYwWi5zJgTGx7BRWNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y3x8/bjaBB26GUJRP9chofyvkvu+qqpbdEl+pVbuGcOB1THkIWXx1Pfspn7hX+X5XFrA7EZQ/N10ZadY3Gz/QvnXNGc5t1HlnRfqo8a0yvhqMo1RFfHjf8ERw35GmHrXYt/1rr9VZwy9l+WWSY5Wlg03djlTcfIQzKsM3mQmuVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dKYDQSw6; arc=fail smtp.client-ip=52.101.66.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dKYDQSw6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xh/ncgrfrys50qxzjsehuJwEnp8w/LWJXx5yaJfxDQSsHmWClAUR7rKnrSsBad+Ea0NzqXBcG5O98zADpXoMRp6SQ1BlCIIB4olJ5pN+Qc91phKOaFi6YnM7XAskC357RIMuDDebBSyYvwtZzbQ0bPXSGOETRgWX28tusDf9/P9ROGbAnOhE9o0HXzZ7m/dUyu36IvgdxN75eKlwexyzG2YKXiHrp2jB2LtMCbHaLFHcu9W09uSYY821+vO2112dxf96FQvQzhEgN/oMr1GrrFAyYzHLUj5tAuMgRCnqF8gaACPe+kwU/GsrQnL0pQg32hp36JAc/P3QotLnLZNEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkiMxUttTum+oCXB5Yhi3HuDFHcVUJHOQlBw69/0sDg=;
 b=pt+MsU3dfJzRjxaD166enjNh++GHz/xMVXHtVjyBFFkICu11mtATdgrnkcmqfuSU5m86IWV8uW3L3/S63jq3Iw6let/hFCbaMmjfv3yCdM9z+qfwY1l53S8UWoKdFNNmi53PT3VEthoJfV1hWA+kZi4JuouPkXFw0GLq5XQTZ0hwVNQSjtGsFCBM4cKFzsa0dUaBErLuyXPTzeBCrc14hBLY3OWNCymZWnocRK5nsaQ0EV0ekytsyHU+n748fUq0OxRAwrXvRZwJduQ3lY0zvg4WNZrlKvvZyOTox6yfgc08xm/RApJoBYAd07mFVuWsWR3pJT0FLAy0K0ItgHJGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkiMxUttTum+oCXB5Yhi3HuDFHcVUJHOQlBw69/0sDg=;
 b=dKYDQSw620jtRz+B82nOiTEQXxkMVgyBUNUw3EhjBHdNpXg7vwu4jQMNMkO+NUkpAhHd/vxhXdfsFEkDe5KPfAmO943gfzSLkSXA/tJ9T6M3A8GzSVXG9zTZtmDQHBy2dRgVKyrzdEhsXko0JheqQcG2KiksDvwURvBJNmoF+nyeXjXz7U5wtaY5Ew0eLFxdWyBxwM37UkBHb0wS++0220heIbt9A+dsc7N6bL0ukgAB5tnV3yU5Rza3sD1HJup5Duc0STSBvd6Q3PyvVjZI9jgW1elWAHv0l+0BbVz5Txtj+gRUJE1l7H+utyIUjebvFwXAYGgsrWFaKUg3cr+oPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU4PR04MB11900.eurprd04.prod.outlook.com
 (2603:10a6:10:61a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 04:08:13 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 04:08:13 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 04/12] PCI: imx6: Add support for parsing the reset property in new Root Port binding
Date: Fri, 13 Feb 2026 12:08:44 +0800
Message-Id: <20260213040852.3340547-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260213040852.3340547-1-sherry.sun@nxp.com>
References: <20260213040852.3340547-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DU4PR04MB11900:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4a5c24-e860-4023-b54a-08de6ab58197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VvbnSB70zDs4tGOe5pyR5//VuyuyEdweRyoVAUi4+ETSiYRz77vBwSsptBCo?=
 =?us-ascii?Q?6BBX1m96i0hrrku4XprCzDA0MZ/qbAXDHuxthIMLf6v/m97bsQ+LVhUysKyS?=
 =?us-ascii?Q?mXKtsGTOywGAhVhDBscrCryYvAWsA6kGmpEknT1YJMrRVIgNtQjEAA5N6BHP?=
 =?us-ascii?Q?E4cxPQwo/YkYZ2oc1Z03RLlY3vILntduD5vJpfckhPXhaWXSr8dyhHrTL0r1?=
 =?us-ascii?Q?gftHRGrujYlfDOLE7W703NvLRMc8ZBWw95z1vmxMEAJ3mD4Wy4SAP52yb8DL?=
 =?us-ascii?Q?wY4T1JB7mIFmn/XABh3jaikx2Kl/tmkyNAKwJbSVFxsElRv1keBpSJ4cx56P?=
 =?us-ascii?Q?lhKKWMiK/Gb+rWd9077Yjqg66eBDvmaw4rF+AYwnjQB9QDfn/Mc138+C9Pli?=
 =?us-ascii?Q?26RmqxA4+hrTqwoXRStksF3lqMK29DJEoNPe6TE/pfM58qgc5TW0CrTkcVIY?=
 =?us-ascii?Q?DR0snIyNCtfuEn+Jj6nSqokbrrWcgn9Q5wHfrtChtWDlUf6cuRvzCnrqTIUS?=
 =?us-ascii?Q?oucsv64YnmzqYNBc7TOFBViRXWnlYG9nE/VL84Q9JXAgZwoFUnsvoqAMn/Z+?=
 =?us-ascii?Q?9OLrZjNXvCjgyo0NWDzb9+zQjLuwCKS33gFxKNNLdH2gVBcQYVIeRFoCjbwp?=
 =?us-ascii?Q?cnutfPjvEIMAfFE40tg5YBXT+G3LGfEk/Ww0U3zb0Be2/TBxKLIEZ4EPGB7n?=
 =?us-ascii?Q?LBaQdpM8s++dE8dgkbS3xdpf8nMOp+Q/a9tiRmQHhkCwv1h4x1Hf+QCGjNYX?=
 =?us-ascii?Q?OXEfDBCrCs0jJ3yXLfUemU/iyNSqt+htXD/BKeKcn6j9mX3tCt3tmuSV85qp?=
 =?us-ascii?Q?A7r6ad56ExWq3VCEsXtagLGrJFn3CdIv/1MesAnpT7ICHK/Kv9n6YtPNNOup?=
 =?us-ascii?Q?ZyzCEZot3RRz7DJrLXO3kJaIJ0C3WySJYhR7pMfcIkbgXH09WZfnI7WF/sVo?=
 =?us-ascii?Q?FTTe9OOB7Z4WioqK4Rpa3xXo2pbdVuvMnUaE1Jvk1LsJSu9l9EuAHHqd5j6X?=
 =?us-ascii?Q?wzN2Jx+IBl9kDrnzjipXacOUjDxqFuhT9s96bDfDshr+jmVTE85qrswY6enP?=
 =?us-ascii?Q?cRv2HYvctNR59KR/M5k1eCwSM0ttRhS9ZoG86XCXBrNyyiHld9wI+8WKaL6h?=
 =?us-ascii?Q?y4T8v6wf0A/+7M/qcfqYPZk8MbZKcV5min3ggJb8rFVMqWpXqsPnrmkiJP59?=
 =?us-ascii?Q?KU0fJNP8VmIJr/ZD1+EX8QP9BaekVmDq/yA59mJd2HvkukHrq5rtURzGKRwi?=
 =?us-ascii?Q?bsLq5jxJpAd0lsGHVyKTrVadvgVWVtyR3iFaEtswOAiY2jX+YVmwl7ILFyRi?=
 =?us-ascii?Q?tfe9lJzlDx5mksAq3rf7YUSsbI5+GezMQ+gxW+ZN5vTrA9U3ngeas7jS9QmN?=
 =?us-ascii?Q?WA114D7CcCV985MnrJ06/ltQmVdmobJgHyXBuJVT/s6WPlzzsRiWnIOUtlBF?=
 =?us-ascii?Q?551ks9O//LQDmv61byzsqcH7BDArF7l+jItFqDLfm+XqUQHWwVCft9Blch+H?=
 =?us-ascii?Q?KW9EZpFF0GA4VIJe7lksC0BeLpiBEtoE9TTGa7iF67AXfz/TKOZfz8+st8WI?=
 =?us-ascii?Q?9h1KBALrWES70svjwAah/3eSqoFittip7ZA8VJAx3HJpWCMxzQHmlt/U9nfC?=
 =?us-ascii?Q?xoH4v6jQStYnybLP1zEOxtMtzhCwaxKzci1yn9d8k0H9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NaW9grcmudRyE2/PC05rNb/JcCVBMXoEiYetKzhnF2kSg3ynzW8RKjkkFXr1?=
 =?us-ascii?Q?srVwRG7E7erMKEbJzldvbujHqAB8UHTYoGuQU3keVo9+37lkBrM59TswOw9H?=
 =?us-ascii?Q?ocXhDe2flmm+hPBE9sriHb8a0faQ/nKGF5vgLhTJAaMOctmeER4Fo1qgsnoL?=
 =?us-ascii?Q?Mpm+czXMXbmcfqrfFV2NLc1l0F0e7z/tE73R0HKWHYQBJ8+atyD0mkPH4bbU?=
 =?us-ascii?Q?YCw3qMr0X7WOo/rzsZv8Ek+C+z+WIhdW5dkNHXW1J+g5eh3+jgehBnbjBxFb?=
 =?us-ascii?Q?QBX5BpsRQQWcDdDl5A7zXXaj+QUnoIBgb/f7GYRet3yXgUEltOFBcpQPrHm7?=
 =?us-ascii?Q?8PWxB8Loi6RINegW4rY9yZW+e7vYuDP9oZ+jodX2o/Ft8/WJitiUBC/YZSPc?=
 =?us-ascii?Q?KyCVg3dnOUSM37OcC2wjQ1wRoHSNfojCNxsSYmQissWQgvDmE2h3XWy+O9yA?=
 =?us-ascii?Q?zrAe7PXezhVYU2ShiXinqMuVfPwVp4Y51uiREInZ9W67lUgZtb7WEi/uGNoW?=
 =?us-ascii?Q?j12Jr9j0YQd3vghwQ8SNGbu9Ghs1UYM+eoPaiOjezHYWFzwqcwVkGSLbYiin?=
 =?us-ascii?Q?1IEqgCNhucGWi9TmCJM67dldwZSvu8TqeZIgxTc2aVfj7mh7m+nWlkWCkiBh?=
 =?us-ascii?Q?8p60NWJ8onkdZpsHmAXWTBs4S1sScg2AmHnILYySCjaz94dtVXfyw7kBHBHa?=
 =?us-ascii?Q?9pjN/5cFeff1aMHAuk7booDPdbi8QggCaBqOA7pQIqCI8NZ6hxC2qzq61DYI?=
 =?us-ascii?Q?kem+VfEg+Jb63ENK1Ytg5RtMuNSZjfEIDpYRVmNSmfM7wLziT0VISO3G0vjs?=
 =?us-ascii?Q?yYwFRbWa3Gq73EZ6i6Qf3XIy5M7G21NQ/P01jzLsgJAq0TWXnxbodHK6DLeA?=
 =?us-ascii?Q?2PU2ZC6opx8t4mYw20NvS9V4kF8p9cLImVFQyqJQ0oeIutO1jWziVdo478kT?=
 =?us-ascii?Q?6OYgnnDLQR+A1IaX6jV39tcHFggo/VWwoAJVmFWjCtCZ81mk+3Lo00w6TnuD?=
 =?us-ascii?Q?cec+dX0PrSLpX1xZEWFDkX9JUztX7STCo1hkwOHRAyTLEE0l1wsW/u36kB0Y?=
 =?us-ascii?Q?Gbal5kLtOHsVZxRyrupM6uAgfQUvJ/GreOanJnZDiFO6zwnrzBPsFKGIoIZB?=
 =?us-ascii?Q?CgrnkwC5R2cG5MpjXxIqfGSQxAR+U+t4is9kELoMPgI8Yl4lNjSLjMnL3b6b?=
 =?us-ascii?Q?9bXXvH7vlkrn1oK4WFDgwf9Ialvo1XuDbCijwKTyTPtk05IhOh7K55nDE7Am?=
 =?us-ascii?Q?8FqE60OZqrHRbQh0Twox29itR113hkY4uJzdjI4uClqgp5QJReFd8KIWyudV?=
 =?us-ascii?Q?Yed/t+5e08eMTw4TFihAtznO9QTYwnidsRFMuDa59E2Ibze5gu9O/gIZ7rSp?=
 =?us-ascii?Q?ZMY+4DrPzbwyGlWuReA4gs/pg9rny2L1m7d2AZf+6v9ATOMxO8BIjckyqf/u?=
 =?us-ascii?Q?gJBp3B44z80U4pNxQ+RGsfLzWb5jD2MJXcJJWUjm5K7bmRiZ79dzWSdzWbjO?=
 =?us-ascii?Q?nC8Rw2uFM/qGqmvkmKDotfGfPh7ZKd+kjRUYRh8+NvdSLms9SP429x3fIPpK?=
 =?us-ascii?Q?sJeOkR9Jgta1SqFzaVYxhvKvV/8yWWR3/sQwWoqh7opvi22CGnpUvoBhqOuR?=
 =?us-ascii?Q?iqLOVrfFk7IoHUcl8DZ7KO4+OVsCKgAkl6lfvpf/aHguWb57IdlGywUryMrU?=
 =?us-ascii?Q?Z6hUm0Kl5Er5HpnuG839panI8b9o5yrO2s56XeLgg4BR6AS0Un8XM4Mzta8E?=
 =?us-ascii?Q?pBXMwxp4vQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4a5c24-e860-4023-b54a-08de6ab58197
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 04:08:13.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzGAHvJjsGG1ERKuEudVs4diHn/xBJEkKBX8nVccg5oHy3/c8Qdz6jottlXPRHPIF5v6uj+nso/YB/0tifS9hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11900

The current DT binding for pci-imx6 specifies the 'reset-gpios' property
in the host bridge node. However, the PERST# signal logically belongs to
individual Root Ports rather than the host bridge itself. This becomes
important when supporting PCIe KeyE connector and PCI power control
framework for pci-imx6 driver, which requires properties to be specified
in Root Port nodes.

Add support for parsing 'reset-gpios' from Root Port child nodes using
the common helper pci_host_common_parse_ports(). The parsed reset GPIOs
are stored in the bridge's ports list and accessed during core reset
operations. Pre-allocate pci_host_bridge in imx_pcie_probe() for RC mode
to enable early Root Port parsing.

To maintain DT backwards compatibility, fallback to the legacy method of
parsing the host bridge node if the reset property is not present in the
Root Port node.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 81 ++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a5b8d0b71677..75afd56dad50 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -34,6 +34,7 @@
 #include <linux/pm_runtime.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -150,7 +151,6 @@ struct imx_lut_data {
 
 struct imx_pcie {
 	struct dw_pcie		*pci;
-	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
 	bool			supports_clkreq;
@@ -897,29 +897,40 @@ static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct pci_host_bridge *bridge = pci->pp.bridge;
+	struct pci_host_port *port;
+
 	reset_control_assert(imx_pcie->pciephy_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, true);
 
 	/* Some boards don't have PCIe reset GPIO. */
-	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
+	if (bridge)
+		list_for_each_entry(port, &bridge->ports, list)
+			gpiod_set_value_cansleep(port->reset, 1);
 }
 
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct pci_host_bridge *bridge = pci->pp.bridge;
+	struct pci_host_port *port;
+
 	reset_control_deassert(imx_pcie->pciephy_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, false);
 
 	/* Some boards don't have PCIe reset GPIO. */
-	if (imx_pcie->reset_gpiod) {
-		msleep(100);
-		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
-		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
-		msleep(100);
-	}
+	if (bridge)
+		list_for_each_entry(port, &bridge->ports, list)
+			if (port->reset) {
+				msleep(PCIE_T_PVPERL_MS);
+				gpiod_set_value_cansleep(port->reset, 0);
+				msleep(PCIE_RESET_CONFIG_WAIT_MS);
+			}
 
 	return 0;
 }
@@ -1642,11 +1653,39 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
 				  imx_pcie_resume_noirq)
 };
 
+static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	struct pci_host_bridge *bridge = pcie->pci->pp.bridge;
+	struct pci_host_port *port;
+	struct gpio_desc *reset;
+
+	if (!bridge) {
+		dev_err(dev, "Bridge not allocated yet\n");
+		return -EINVAL;
+	}
+
+	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->reset = reset;
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &bridge->ports);
+
+	return 0;
+}
+
 static int imx_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
 	struct imx_pcie *imx_pcie;
+	struct pci_host_bridge *bridge;
 	struct device_node *np;
 	struct device_node *node = dev->of_node;
 	int i, ret, domain;
@@ -1688,12 +1727,26 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx_pcie->phy_base);
 	}
 
-	/* Fetch GPIOs */
-	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(imx_pcie->reset_gpiod))
-		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
-				     "unable to get reset gpio\n");
-	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
+	/* For RC mode, allocate bridge early so we can parse Root Ports. */
+	if (imx_pcie->drvdata->mode != DW_PCIE_EP_TYPE) {
+		bridge = devm_pci_alloc_host_bridge(dev, 0);
+		if (!bridge)
+			return -ENOMEM;
+
+		pci->pp.bridge = bridge;
+
+		/* Parse Root Port nodes */
+		ret = pci_host_common_parse_ports(bridge);
+		if (ret) {
+			if (ret != -ENOENT)
+				return dev_err_probe(dev, ret, "Failed to parse Root Port\n");
+
+			/* Fallback to legacy binding for DT backwards compatibility */
+			ret = imx_pcie_parse_legacy_binding(imx_pcie);
+			if (ret)
+				return dev_err_probe(dev, ret, "Unable to get reset gpio\n");
+		}
+	}
 
 	/* Fetch clocks */
 	imx_pcie->num_clks = devm_clk_bulk_get_all(dev, &imx_pcie->clks);
-- 
2.37.1

