Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E61D6195;
	Fri, 13 Mar 2026 02:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367688; cv=fail; b=ihoXv8Lfxt/JP5xVvjbMKhvRtE6Bc1OY9yrsl+7nwP8+q+d6U7uNfOMA7YaWia2LPNImWsgYIL6SXq9o2voxNqQD+tYe0XIPzz6ABo8LZr1tbvNqMSSVcR5Y9YfVPOFFKKSgeDhK/z6yC3FkFQHtzqZHzrZQ1QA3eHqDeedRxhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367688; c=relaxed/simple;
	bh=3qW0DbpXhzlXNlNUU4S5ym6D0MOWzPxIToT8CpJKvmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K2oradsoJzFPga+5m+cUdPAnbdo8sSznv3u7lU/HNyrnzAqk3MMwFOwjz4MgizOB7BaB23By1Gj26QFdfToLEzbsWgjjwvetu3iaByFI9dUu2cHEdbtekoFo0jyS0eePYxS+LE4miTSAFz5kFQXnPd5S3QWKJebqZrrh06y1O7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ONffsD8k; arc=fail smtp.client-ip=52.101.70.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ONffsD8k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OigBxRMnP/k7p2F1F/qHYB1zlKO26a9+vwD8uB7bS42NOou/eANUigOB/hVQbZIgokoCs7HjOaZTiPBl3XTQv7FGrhek/0GpJV0VaFrt+wT8XV2nmsihiv+naCne7MwJzR9ltHCxtKROvitS59Cgds/Qm7OjspBrbjHPZI1h9QiwFxliqA8W2Ejk3/iv2K2lz7c2RALHZZXWyAhegWddapUfDpPfnIoqPwRRavyyj9a97BLPrBWAoH9e4Wa7lUg6Vhus2b36BK6s6E6zUA7+wJFVPq3PeAlq3D5b9LPthoqNAoQtWjdUQGK86+AYmLXI8E7BU9QNsMHIaXIc7q4JRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IcBE26oRN13Z1koAZGrMF0Xa6Z3GKMCnfUAz5eLY/4=;
 b=cRVcOBWIdLy24JWd0jllos5qsQIgKjbcPJFSydk4CuXtjGEe4l8dEDSZhmhrnGKh29NXLlIfuPAMqxiCd/OL8xZ/y2ygM26sP/vaoW4VJdBJlq09sLnLPEBw50aXa7FDX5TP3LMU5qJ7X29bWu/KPDJaYnGAcDNNo4Ru0a/GG5YSKcvat5Y1D9kSmsm7zqTcnce0xYabC58iZ7EenUQRrQsei6Uf2y8QtDjz6aU7L+mwIs810VRbi/Sqo909+uN/Xa3WqptETFun+j0A1tqu1RH9eAsLFEI4EL54EPqXzigU/+Np61QtQFKUooTADvlvwwEqtbzcNekLGTbVUxFbXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IcBE26oRN13Z1koAZGrMF0Xa6Z3GKMCnfUAz5eLY/4=;
 b=ONffsD8kInBbAqP6QYHnge/o2ADUEhJPXPxu0EgsbqltLUGoLAru5W5yyzlyec9ICTONdowJ25oFoAYTMPaWJfV1BpfeTtwMikecNGf1lZ8idNhuu6fggFJ5Sp5xO5HkTqoFtk35Zigy3lDXnTUS6qaCFmW3/St0lN6kF3rQuqCsrh//+5d+9VnYjd5BDZacALoib8iTKknhrP/MgbZP70KoC7BgDRY+SUjwGlhS5E6QthjLhLCQc2C32XItP8i2aMdBPFtOQUFJ3884ummA5QlTnbgZTpG3suKds0bmvprhCtQCjxJE43QZZPpu9DLPwn7c3KTq+sNDnq2UDXQk8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB6844.eurprd04.prod.outlook.com
 (2603:10a6:10:112::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 02:07:50 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 02:08:03 +0000
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
Subject: [PATCH V8 03/13] PCI: dwc: Parse Root Port nodes in dw_pcie_host_init()
Date: Fri, 13 Mar 2026 10:08:13 +0800
Message-Id: <20260313020823.1592389-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313020823.1592389-1-sherry.sun@nxp.com>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB8PR04MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: f3920665-b602-4b29-be60-08de80a55bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tfnYYhgPwRSILuEHdQejsrDpEvmQk00qfkDc2n3vf7h4+xnFa/gPXE9qEQUCfqTNUSfq8kl4Ln2aL55dZLbmkPOURqWHqenHs1+ikyCo9TWSyKV1ZcFwV2kjsEnhdxExGkITOTgc8eDsG3rLlFpNGLXZfTeFrJDszYc/OmZl1OY5My1rXJNEVIq0Phr/AThgn8auU/PfU8wMZwy30XKMk17FHU5/YsCpOZDE8/e1+ZFU8BgRXeAfr0qexQ9ZGBZBCHM0QG6RJQmTxJcMD+5ixYTmGIu5GsaJQEzOtCjWrM2dSbf/sTS9oSMtBrPUEqPsbYc4rZHX5Tv1caUbwth8q3+82iCmaDNsuK2akbfmqtTtAyN2iFNThv9kXJmW9V8MVbRa3THN+nrC4P/I3tohY5KRS9kOeul43hpHnNogO3O1RSKtFjdciT+usJmQIe/SUTX08WIp6yi2BsEZ2Xr+vcFmVT57iWbJlq0AQfukEjmg7DLbYP8RcstFj01dBJLdY2BNHPHhtRd3LS9EGN4U8FYjli6quGtdj7Pig5c0IcznNjF9pugplR152G2CXiUQACLjN68vZ11uDfCHxsosTn+GaDdmblTJjz0unw2ocpjJ/jKKLo3gcTdlqEWgx6ylxDjaafqug3FxKZoIeJBbiuNIVqWOmfFT1rN63+g/0cAfVJOfyqQrvIVmd3s120xLx+2k66qloqQPikPsrrDc9D88XpP5ONOyOBGM9JfTRiY3ujgzgEwgu11KCTQHOinZHkFnZw3IYaSCsagNH0nK3DYRbFxnDsTsVS57tLc5+2z7VxbDfdPpHdX1+r2mDyug
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J/lk+gmi0YMOiuLrBrJvDkkDA2tkVYpOJGcEWqbD93dz40QsVtvPr+jV6eQu?=
 =?us-ascii?Q?rWNjeg7LXrL9Ah2v+D6tNyUf84fZ/DUg3/AVgY1a/eEXYzHiSb1DHr+kAAbG?=
 =?us-ascii?Q?UKJc6ybF54jo24Tbmb8Ltl4ZBzyrrg+Zf1yH9WY/E06vECLuj803tOqZvtee?=
 =?us-ascii?Q?5vQCD5PFOfgVVTS8y8UfSJy+46i85+EOmc7emrX0k3QFyBB4uvIYafAR3pGV?=
 =?us-ascii?Q?wUvFrqV3cAeKQmEpLgKWrUc5P9256uffUYN0LMkF+V5jXRTDYq/+UDX4FYez?=
 =?us-ascii?Q?ttw4GHdQn7cqIVAOX5uByzCVNVdDa3ADgk58JimVSssRHWOk5Qu5r9zRhxn0?=
 =?us-ascii?Q?SQXMnMvevGgKPBS4Lqsz/9AGqM61owRxZoXxGeu0z/Q4eQyAWeSbcRa59C/Z?=
 =?us-ascii?Q?xs/O7YuIlq8DbQNXr55jkk7BHaTYtM8eaojPPXljvOvEQLmxupHjwFgWIv/M?=
 =?us-ascii?Q?zPsAtRpSUgfTqneOT9Cau1py7eKccky4i4pu85IKbubWfls8/E9Zc/6wne7v?=
 =?us-ascii?Q?nXDDvrHhxChnecrKJj/+GUnUPdwNmAzYjwjCsz9T1GgPUDtxqP1zakpRSzz8?=
 =?us-ascii?Q?WzOO73zWbE0WYStKlDo2KyLSEeNLQ4QPp3J1JSOzIsTo/d4pUZ+JazVI8VdE?=
 =?us-ascii?Q?ZLx7ThbvmLrowK6itSIUoFiuju5yRJ7dxKrBxkNSv6oAvtbQqyTy9HNeB9s3?=
 =?us-ascii?Q?/2YWhjJNOJhx2+GmzhscvokElI9IdIZLQrxazwDO32nH4ujAg4EBQAYMGpfz?=
 =?us-ascii?Q?xka629MjCp4WLBUR/ZDin7GW0HFF8te2WPBg8utmaABBjK3tevHEwyk8vFIh?=
 =?us-ascii?Q?QRQXt43Fg+L/R4Y529EzSIt1eTdvvdyGmRYp3tLkApyRzkHhL9nYO08Q+ygB?=
 =?us-ascii?Q?8YfOReOjSEscxmH+n9aYwopVFU/TNB4FgtSjZYxegT41pmrcPh7RQmRER2jd?=
 =?us-ascii?Q?/TvrLmAk+XEGSXKS88GRbetSQz57SsU2f2yl+2t4KIcz9eUmiGV6qfV3qIWX?=
 =?us-ascii?Q?KBuy5h3+3nFKaWY2eUgmv5DoXnOIBkgVFTgW2fgdA/J4eWtvHik6TvwkIjbA?=
 =?us-ascii?Q?TVQgsVdX/EKXCkuquXKQrzbjEq0QRCCuC+ankaLfyBaw72MzP+FypyW0O+Og?=
 =?us-ascii?Q?0tZzPFcr8zJBxTDnY3JABhjHJrwRSJYcAOC/nJuB9lWiyyP+KH4FQDyOUP3h?=
 =?us-ascii?Q?7D8OyBrOkl1Y917kpbfOhVkC5eRxAImkKLc4HMT3pT3ob2XZODpuweYxpnRF?=
 =?us-ascii?Q?0/fEy7rTMQd9wjJfYVDdBObu2fXWy52o4gBGFXUxWRV/nSOnvbo+ZBHNWnhd?=
 =?us-ascii?Q?P2iaGDVlE1N5z/GZB7XEX3pJWWx0ZbdkO5BFzY6bHW2caBM1UnqYoWShwMnH?=
 =?us-ascii?Q?8OPEvCRZER9kOB39dGoGmpJKafnd8BTvvNgmllG5y4kTQewaQDadRGqjSWfI?=
 =?us-ascii?Q?Etb/TYygwkc2+I2BKfZXNcxk5kt8ychWJ3o5dDs98O7CGtE2IAsg47IHOPfy?=
 =?us-ascii?Q?s+5gTgS6xGdkdch2tp6FGTSpDiVp9JfRauXbNVCaVycp2/7jF4ZutMmbeBXU?=
 =?us-ascii?Q?c49XO7sCTKg3SbNLxOAmpE9YHC8dAqIpXRHRm0LwEmmV/4x8FTO5XGEaoggm?=
 =?us-ascii?Q?o9fva+SyUiQeReqxdfO5QpzKro6+9QNQkvMEQRQleJCbGH7cbXKeZYOQvVPY?=
 =?us-ascii?Q?cTjyyy46QsvZIGrFzStrmhRq3AZIPQDDcNuzn6KVaEk2IWCTcRoiZ0J/jAwE?=
 =?us-ascii?Q?fSElnn+oFg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3920665-b602-4b29-be60-08de80a55bf8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:08:03.6903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEjq9Be2IImdXda2CijGgnyqWfbRa+7wVKwu3O+583hIKWe/YmsgJcDsWe2ON8LPT0p6JLfShmBcF8eXiRMtlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6844

Add support for parsing Root Port child nodes in dw_pcie_host_init()
using pci_host_common_parse_ports(). This allows DWC-based drivers to
specify Root Port properties (like reset GPIOs) in individual Root Port
nodes rather than in the host bridge node.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a74339982c24..9608f9fcd1b3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 static struct pci_ops dw_pcie_ops;
@@ -581,6 +582,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	pp->bridge = bridge;
 
+	/* Parse Root Port nodes if present */
+	ret = pci_host_common_parse_ports(dev, bridge);
+	if (ret && ret != -ENOENT) {
+		dev_err(dev, "Failed to parse Root Port nodes: %d\n", ret);
+		return ret;
+	}
+
 	ret = dw_pcie_host_get_resources(pp);
 	if (ret)
 		return ret;
-- 
2.37.1

