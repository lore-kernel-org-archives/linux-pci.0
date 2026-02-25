Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011049.outbound.protection.outlook.com [40.107.130.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6115B392C54;
	Wed, 25 Feb 2026 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016875; cv=fail; b=t7uHnCqn+jhUhgEtwuE9dFE0vG+BfPChqn+AWncRUYg2CaR7yb3o0R5CO0SZfLKFol8K6B2o6iR5Zjqr3M1gskYdaVHSl7Vs93AmmhdsXnYbMnSpcmilocM+g7RuymCsjfq32G6vcO3N8OdxFFlGP3eGeQLP+sKuqeAfuHajd0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016875; c=relaxed/simple;
	bh=0TT28JUepOjXCOqcYfTw7FEsLbA6T51ZYKPhogLAAPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h0giL4GFhcXlnnO8Sc14UzOlj87Jq4CZusVEw+uFd49I6qehqZzg+2vUQzjfhmJW81OS/sjvk7U/oOyE79NDzsnIpKim8MfLoWfMpvbDZQgTPffOIx4L/2LNFj9CJRmFBL+vbjuzl0aqCHwZTSk6uKpWaaJ3gQYjiFRPy0R+jaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KvCdufzh; arc=fail smtp.client-ip=40.107.130.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KvCdufzh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbdJ7y6JUnzhrVeVYy3Li7bVZGZK5GsM92u2qxhaB67L9PjaGXyC1wpbXPsOd0lEFpHgzwPrPvAi1WMVxXDFvXOAZF9UZiI78qiZi24zhRXV8VqSsLf5204/H7ncpe8l0KzRmDOumuq5vT9/Q2NxdkOEpiiidpK4v1F/AKT0wYjBplVGi1GXG7zTkmeT/SoJ8VLgabSlld+miHwYODdTZG893k0s+LVC8Ui6yEClRfjRRVPh5nApaIj9oIrh82eQ2mMzqs0Rthny5RKz6b3xWaOEtv0pTglB5kvppPYywEsB7tWdgKR699EEhZdJIT97U1Oo75mdVPAPz4SA2PT6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OT7OcF8SEYzDwXh42Lqsyv5PQhNwGohdUxeIa+Btvb0=;
 b=kK8kTmzpQ2d3O8K/DZ8/wNbbOPkcyk+0ojTKkVm59ZMH83rNh7Hzr33ZnQMh4sU5w+CcRTZtT/aD5wKTBUlofcG+jN35GzxcvGkza+uM5CuKZCn8ymzIVkI0yQpZwqaNHr6n8XOqSB+yUrfE46Tc+FZExRvO0ypDgZqXjMIfe5BVV4lOJ80tnXaDMCdw6aA1hDp72hqI8nddiyaB5PohJp6spo4A16vl9vnB7DtalqEsK5uPAdfTE7zjjgBi56RgiWixePpSu7VoSxn2Ai1T07bQ5t+TvEZFr2s8JH7m18oSfpiNsSuSMo33egOoVtbk/INqORifZ0Oy7PgP2NA5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OT7OcF8SEYzDwXh42Lqsyv5PQhNwGohdUxeIa+Btvb0=;
 b=KvCdufzh0mjdx6IN0lhnYyfsvWiaEF/1TsGtwsvxfozD6lxskzkaELfciLfNEHArEjrtczDzviKa/C4bUsSL5IFnKFh7y9DY2PDkB16o7esATSAhOVY5BZWpEqSwl9PkbMFm+IJ/evECQQvRFltmoqdQtsXFaLoalozb1eO1kU95ozXbnQLKy8NXYvwyDiKLEXIp2Bh7WawBzgSd71HG3/YrFDShZtSItivYVOlfTvNvXqaFYCr6G/oiiyuJfL7o2A92ytJFXHzGQDnaN0gky4wGLGhTtx2yoX3H5sfmugRLiJdF7CmvFGOeie32NbnNvc1YwP1GjbEHxmsfK8SDLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB7668.eurprd04.prod.outlook.com
 (2603:10a6:20b:2dd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 10:54:31 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:54:31 +0000
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
Subject: [PATCH V6 03/12] PCI: dwc: Parse Root Port nodes in dw_pcie_host_init()
Date: Wed, 25 Feb 2026 18:55:14 +0800
Message-Id: <20260225105523.748775-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260225105523.748775-1-sherry.sun@nxp.com>
References: <20260225105523.748775-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 66dc09b0-d79c-4001-cccc-08de745c412f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	PU1P/iXb45Do/TiNVXPZIzjReKlc5LebDmkPiIJ/Zl5AYNaGtgEaDUETu8U+KLIPwhnuiwloU18TwaMGeDgw0MjwZht57VNW8BpBxDBbatszuZPWTLvoz/82b/hnRbM0zTu0JQNilRe1t79spJYCpmKnOVs3m6FuEm28oxoMl+YZ/IyWocZV3oci1BjipkE+9squ34QAPXVC8wkLVd/JGbp3nTHt0wCY6lRv7gdSk6eisU7z3xb0hTYCRHz4pVbWQuw8nlHE+QmCmZHrYkMl/aFc4fS4TySd8k9pqlQmIR52h+UTtocKqub9b3fXmC91KqJ9zlkwJ9VUykLhK4lKvqEhdxgk9Ib4DFspqZjlI1NRyenxVs919SIB/aLrCNw8LeMKxuOb/9Nw6bb+YgMcDzekLGLLr8UxUJySw6KSegLoOL6fYhi6It07DoTdbJVlb4yn0y5DVOBrLgHCPRhGIm6GI05GTRlz3fEgHGyjyY/bDGb6CpSy0QFRJmSW6D/kkJ98ID+BlhFQW5teRMBBz9GHwbfdFat7Uqu7OKyOA7jHO0rqLHPVitZxaD1OVABkLl9hw0bzn+nDDZ5qHda5tZqmM6XeLobC9HVzGfPgn4v5mcm1kf3dPFiixoaxihCONp70xhhNDG4MO4j5QAoHJxLzQ9tCCZ3bAzKYpKM3Q61gtyjeNzoS0c6HOHriM0O1WJjImDq4mFZP89HqVtD/Qa+9/XWPwSWZTpmTR8qnCNJf62u8zDjdpLHByVKgK/vw9KsRXkX//x8cT3Qu/twoTWK7UDlyL7onelBp5N0uVM3LTW73lRS3MB+zXZN3KhAm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y1ocAtGwP0HgTIDZhHxSnAbZZXTqIGXBuD0JVrQ3Z1yz68+6/en2kAL/Lxxn?=
 =?us-ascii?Q?hOH7qabhIacp/oyg/Vit/Xx6QdxzGA81n9gT4aGma8PmelE+2+g6konZKZxy?=
 =?us-ascii?Q?QofQltuwF+IBxyLbSA+RDPc2a2GrczERv/84Eday9zbrXVy4X1OJczQmE8a5?=
 =?us-ascii?Q?z8VuYIq1qEHUlOGvJ9FyXLNHklcekX75odtnmI5Fz6eOB2Zr1A3YnE/QDGwl?=
 =?us-ascii?Q?3fSHcE4EdEzZIILkW3UsqT17e4yej4LcibGfe0bX8VAmDGzBO0aFBH6dwB0C?=
 =?us-ascii?Q?Sj4/6JYStN9cb8udQbtsS4sOwV27FEKevW5IELCJUvIPInjgPk8qk9Aw/bjU?=
 =?us-ascii?Q?4F0MsrcUX7U2X0jgmz+36hr2nbOlCe6EekvK6THQitpoaT2oqcGREp5bwFW4?=
 =?us-ascii?Q?o5ns9pR36VhiXQf4oBNDgU/QyOPzsR9olikEjzb2H4lV6Gq4tP5diiJ+PdMI?=
 =?us-ascii?Q?RYTjP5RumXfeDRwzNeocdRlK2Jv/uQkMmogThVUNfxkYdGXTIvtBzqsO+Pkw?=
 =?us-ascii?Q?ycJc/Wghi627DvTWYdH8w1ruXahLXeGNIjX5vtN5S5mVHwZQ0zIN8aOC28BA?=
 =?us-ascii?Q?QPTs4R+xjzkb8kb+oSg7jSP8L1J3bWGx+uqh9wRrmFbiSU70fvfbiG7O5GgN?=
 =?us-ascii?Q?mut1mixEUzkcQojtb9qwDBvyj0Fj8ynyUOnw5FN7kefmFm+gaZ9OfJV4kDFu?=
 =?us-ascii?Q?WtDR8QWGEVEWnKMZRpai3QHn0EQbeI1wDU70bxbe91VhQ4yuevJJhUGcjWy0?=
 =?us-ascii?Q?MevN6M9kNAjw9Jn4GJbOKUZfULw3Z+4D0z1j0XuyinVSfvPxpPVqUBjGf1JC?=
 =?us-ascii?Q?WhfID6sGl0mWJ/W6uSjHkWsFPdH+CvfRiZPNgcc7onzsLhuAdUvwaD+vD0Zw?=
 =?us-ascii?Q?ukcKbnNdvuvrfX3NMwfWSsPfuMtCg7s6OCSk5ZL7eS3KxI7kQ6yJa6X1/paR?=
 =?us-ascii?Q?8/lxFs6AoLQAKxQX3kmtfh+q9m07fF2cobTHIvWo4FbF7xy/X9fYz3K64wyG?=
 =?us-ascii?Q?2AWzfbTp9Me+QOCax5Cr0UKj4aunC+R/O/avUGUjtlZUO2AOoeybofL4YSWh?=
 =?us-ascii?Q?IQK9ePJdwbkklFzyW3TGPk1PSk1aoQ0Nw3W/Xv8bafvis2m9PFbHEfpgSKJp?=
 =?us-ascii?Q?h1dTuli/+Qkvm79fn+WX3+/rWAAI6OcW8QKZ9OWzPQVWHjIAGXB1roqbrBSN?=
 =?us-ascii?Q?0aivQ5oxvvWuEPQijtRDCmHV/APL14wwFtt3MXnfijUTZkkF68RVr9q1Zc4e?=
 =?us-ascii?Q?JOP6Q3xzaNuXbyW17Yh3bRjaa37nbn1MYNqNCZiOn7zv43kCRP9AZZhqQVM9?=
 =?us-ascii?Q?2rWqlkOP+MIeG40BzXgilobyBW0l38Zck0dgkUQSuN6PZnmm5qyiN9U/hRWI?=
 =?us-ascii?Q?w5b5Bml7DBEhtjqavQasuhlbZSimHlxTs1jQnEnbXaLxUoqxf3okMkp2nOSC?=
 =?us-ascii?Q?N8V/1Gxsq0RvjDM8ICLAiEoxXorxiqQ+/eiCqv750+0VwRDSXKAdM57ERw0k?=
 =?us-ascii?Q?TtZmU2XBuj6l9Z0os3ARsuNeY08wffOYKKZX0lB+DW4vrmkezmSQZ56x2Ilm?=
 =?us-ascii?Q?kyP3WrevL9kfxw8Q9+0h1ZJQ9UrUqXzTpF0EVSF9Kk5sAoImWkqPonJwweB3?=
 =?us-ascii?Q?NoIDOYHCFbS5zn76MhATNaao014lMTY5V+iQMhQaK786Yb2hHFIJy+y9O8Mh?=
 =?us-ascii?Q?7A9C7PYe0qLhfBf+jK6tlZyH4Rh7wG0pppaT98jp9tjxsjffzRZQL2UCMXIS?=
 =?us-ascii?Q?3DK6FMSw+A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66dc09b0-d79c-4001-cccc-08de745c412f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:54:31.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uh8ANDWNYmr0oZT7qiieEXDEX8TQVPWexxiH2j5GvB9qSaujWgqNImV9f3ZlBQ2H5CgO+sL7XpfjEuYahfOA+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7668

Add support for parsing Root Port child nodes in dw_pcie_host_init()
using pci_host_common_parse_ports(). This allows DWC-based drivers to
specify Root Port properties (like reset GPIOs) in individual Root Port
nodes rather than in the host bridge node.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 6ae6189e9b8a..6ceb146e9a04 100644
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

