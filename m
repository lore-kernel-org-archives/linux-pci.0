Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010028.outbound.protection.outlook.com [52.101.84.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA8A3DA5C8;
	Thu,  2 Apr 2026 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123427; cv=fail; b=SfVSBJBzqDfrVso3ckhuxx5qprkaxo0NHrMx14/K8o49jkwpWhJWlssYq39/Is4eoNIeT5xAa4ETVNHqoSOWtuilrUKZMIEo9SdaZHC44fF3Vx61EbHmDjl8Y2G8tTsxSmTlGgi7JL6FMpb8lkCKrHcnINfheemM9+n5boWlDKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123427; c=relaxed/simple;
	bh=V87tEpKgA+FGv+5cQPlOrRdKStQKUl76T7Bu/FChWAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxLdyvXQQJQZ8v/9VxnJUElh9wmvWF1rWglEAZEVStvDf3ELf6Gq8ho9OrzzCM5lHykyyt8WTY7lxi7uBtCTNKeNbKGLXo0cW2vNm+1EnAn0KXO5B3UPKvMHmuSwoOvHuFWEMprB47j+qtlZDJwyaco6MnTsu1xYzO7RnQkzgRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lDnWSZVi; arc=fail smtp.client-ip=52.101.84.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lDnWSZVi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbehUwCS4RZ8tq9WP+mBM0KucT4DUp0x+ld8FqTN/zu88JN2pBTVXx89eHJXab6PgXtTZ9XMYJrDAtCPW4Af8z1Cdc9ZDWA2+MRIyV3D62QLxFqsmYBgQ7ge5HxlEe77/cQAzuKnxeuPUIcUVZs9AS/kxrenPm6fQqvg2lpghnFlCHml0mxR+m7VxgdAVn1YaSWafMQpNwXNBnNSlYGJvLvoHWLMnnkTTVF6YK1hpvOVaNpjSlRpa9LetdWp392Au1FVdMxUGObjuOHakwhAKLmHIVVqM44UR9Y5Jb4o+LrE/rwpnkcH5wS6Pl1G987k6X43b0CRyGIUMYFH6wyK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOi590e4zPmoM2GtJDI1V57nl5fPXBjONLKlB5dZ8K8=;
 b=hlzb/fqZvqgyN/GxAEk6yvnA0H3u+gk2h7nymtkiXU/Zp2FC6lF9DccQvMFiL/Ct8FauWjsJhGbxBf2IZy/kSLsx4v+w38U7GvrKcYqo1+nHGvyAE2Ev3CJTFXQ4e4QkU1TVPE/zUF1TlNs9da3kaThXOdvuMKcDhs2d8KhK+Zrhp9l0XTbi0uW9NwCpkAXESuMIgGbWrvZLrqGQ+xgW/b1G4fCT89KDANNZE/U6EYmydRXXan8EGu91C02NyCxWxW+fzDRI+4QPW4sZgKwL41FvvL1xoEbh9E/EoDQ5NJPjozjBR3vHsXry0R/xGNBbtdv8bvJUgwsJ7loXC7Hm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOi590e4zPmoM2GtJDI1V57nl5fPXBjONLKlB5dZ8K8=;
 b=lDnWSZViFODQDqaL7QDZetgQI2TB8iVcnBcH1d7Xh9tGMRAl2EG9mkAPsZPlKEc3lkB4odStlfLqxzSV5b8AUK1hl0R/5YtJsoJCofQQfvFVy1lVsTPfw5ZeopZP8ViCL1oq7DqRM38yNCkXAcZTFNhykxNQg/on3xgNeyA0WjNukEzX0Sm35kisi82gGSPkH99d3JgroFcDTH/ZdILlJTjk73sAv171mv0366D9QnUk0blGX/QS9PqNPc4dRwhvGqL+7yQr+A19+NQbx0A5Oycmvgy/Vm6Wv6E+lZCUw9930/pdF3YuqjclLRDJl+pI1G7bOS5cQZ4FQoI+Xa0Ytg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8471.eurprd04.prod.outlook.com
 (2603:10a6:20b:416::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Thu, 2 Apr
 2026 09:50:20 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 09:50:20 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 03/13] PCI: dwc: Parse Root Port nodes in dw_pcie_host_init()
Date: Thu,  2 Apr 2026 17:50:57 +0800
Message-Id: <20260402095107.205439-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260402095107.205439-1-sherry.sun@nxp.com>
References: <20260402095107.205439-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0163.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::11) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 012c1792-fbde-4ceb-468a-08de909d4071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|52116014|38350700014|56012099003|22082099003|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	cLjcNa/7sibJh5uNCwF1eHIQfj9EzEanu/54A0DYfTZF/2aelDWaksfiXHBhW65RrZGfW7nuY0Jt+JLZ+ILsnpmlSRoAErxo7B6FETtM6qWk9aH0kc9XeQ1q7SpBl+kbZ9DvQloVgHT+9VEv6xFFGsi5OA+8bgvFvOdSkGaTCxWibK4ZdhRuNfkW8LNY5e53Gw6mvWBQvRYet7aVMqmQomcD9EGaZhjS3wfxp7ReXuCPD+NzjRaH+XaDSwQyhYNMimJCrDux9HgT198fWmItFCCkDKColO4Rw4FwOSH50o0qoKoTHmWbK//xInw8a+Yf3RYcLVQmLwAeu8cMlMUHM5i184ElTDccs/kbqzGNNJ/kz2yey+tlt0qyYL2gZkX675xiE9eJhqYuBN1nwb51ArS2BckO6n38eJyj4SkcZtXsJyOZpd2V9dumC7jak/6OLOANaAcrF5aIr5rAVK2lB1ULZNPkuOnZZXZp/1ukPn/cMukf9YoImyBgVzsw75iaavVZDvF95dnLFSJh95VNrBJ/yqcRrg4OvpYOOl3iohQWM8BMpj/qpncJ5DF6vQy9BT8AY8IqxO8gIvGcC3mXBrkBIDtv0EXmmayvzbkDXCftdB6ILvmKqtPygmPEHPed+mWCSJL7El8BY2fCwQd8vsRg5njwzt7ORrDE5O2o1qgGDrfEk7OYFrzwLuDSys+W1MKj2OcPXRlUp6OkrCv5+fDomoCMUY0fq0oTFGsgbpHoV6mbAqI7+7Q8eaRVWx6QGmvZtbtQ235AkQv/B4CQ0apZSSveDP5yxmbglTujkAjcYkIsibkKVU0j7QBjdIya
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(52116014)(38350700014)(56012099003)(22082099003)(921020)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T9ySAmtgnpraA52xHMkfw6ozdnAvhXeMEbkRMYAMcWeXWFzcYzOwoDSKEMrc?=
 =?us-ascii?Q?XjKf59tpKcf4xU2Qeg7tDNQ2x/XpcVQJ38cBcTxSO7R6CsVL4ZMUssqQpdyD?=
 =?us-ascii?Q?nAf8C5BcN9rY/ocx2ORltay+hTDckeLw/dBBZ17zByTpMoxh8/fG0uqgO3uR?=
 =?us-ascii?Q?Wbdu3Ofax5chHXEZiL5bRqH1D33Va/r1zOXIPxtXnzekXf5anzGlSVYVOkPP?=
 =?us-ascii?Q?aEuoCqvsqUDjxtTtH08DlYHTetxm8ypG0p6uvPyqL3ZMw56pBKsPAO6OPr5g?=
 =?us-ascii?Q?m6Z2/RnbdMwLAuewVMzwTHfgHEPdipuKNHGsMqKKoPqfg3UAB/vsXO2Qj3c5?=
 =?us-ascii?Q?AEF5GKtJldgjngTTErJ/11romVdL9C8rEvG097p9mc+x0LYA82nsf5srPSwK?=
 =?us-ascii?Q?oaKBt69cGaomoB47HUlaxbxRwLwquNsalqer0+QJJmeVS2oDivtAlkMmDQ5t?=
 =?us-ascii?Q?lVVWZa6eHWCKc1f18tECRp2g/tbzBP9FPJkSdKt6M/YaTgGf97zZ5Gfby+Da?=
 =?us-ascii?Q?SrmRhlKovE2YGZjnNMM9N6NE+29i4A66udvCINKcW4kPri4rG1+yzwSm0nFR?=
 =?us-ascii?Q?zyjmQFaJ17Az5TIJasHLT9RKsH6m8jju+0rxDNKxAzbr5TYnnYZqYj57yC1y?=
 =?us-ascii?Q?JlhGRJbjy5RQORYq/Vbe9v/kzt5Kralc7ABDfiVUGUpatXztFPXtOm5fO6Nf?=
 =?us-ascii?Q?v7mhbS9rszo1i5dL4cpewa4Qe3hq1Xz0gRxDDodBKIOwe/7TP2AVBAJqaQ+C?=
 =?us-ascii?Q?6Rw8KoJYGj3L4HmbJiodMC8o6WFW2uU5O23gRaMA61JYd9d4q97R5IHVqzRi?=
 =?us-ascii?Q?1cpt5sqvrpgw19NVs/E4vCGSX/eTNJRI1rhaMuNPojl+e9hhLR0FJU0NXbxl?=
 =?us-ascii?Q?sFtZTEosq4d1yol0j2F7lvhhfeAWzGFalZwZ5XgiqYG26BNq0xvbN1Bm/hRP?=
 =?us-ascii?Q?8QOfa2kRGfeGNcDY9Q6y4CZ/m4byIyjfFEQStWktT3xEM+lq4P0Hl3+bpaMR?=
 =?us-ascii?Q?Ahd5AOQzlycrkAHabP/FnJK7RBJSCd0ohpLtXZ/1KuU4I3/dutsLB4xyOmXh?=
 =?us-ascii?Q?lp6IEUlkTYSn3RWdQtAPouxpRWxn4/nypIPmf+bF37c2BLZfSNitmPzIzIlV?=
 =?us-ascii?Q?/QC5LCgteFkh4CTAVXOL4R+/GWNLsCq0zWfywVxEUUGT+K07y7phY5coyB7D?=
 =?us-ascii?Q?Cniv2kGzLiKpUH79ptTAmKkf1JP2ARGXsI9Mpx++N/D8n5UI/NpuGDBTFeow?=
 =?us-ascii?Q?kwnCTv4kDcutkME8fiT+H4xmOyFjFs2Zss7Hzs2HuAeqTNm5FpQXEU/G56kX?=
 =?us-ascii?Q?2CjxhRloNQfS8INgGFJFuTDuWbBLDJxYH4WVvj0euvU5MmNbjyF58prWYGgt?=
 =?us-ascii?Q?CDsAP3JkR7s3aNxuNPd/+Rpz/eJz5tukHWZXyAXdh4bkPVrjiQq/oy3Rm0cH?=
 =?us-ascii?Q?x3ND0h+LXAv0vmH42C0VGBWoMXWTrhnR16kZuwsqDO5Vdy/RJkmrFaCSpfhK?=
 =?us-ascii?Q?R2vvDn2p2kT3/PPDbiQK3L9Tx39aZoDgqv7EQMfjaqquAWfS89pHo2GUeGd2?=
 =?us-ascii?Q?Fyi+i3TnSa/HJVHkDkxwnrrQWr7AIpNLakaPupzQc8x5egFS86oO1y/nwUxB?=
 =?us-ascii?Q?HhQDMwMiEaHai6s1qwISZgtFvg2LkvA0e6gZIe60r6GVJIcSUqj0umTRK9sG?=
 =?us-ascii?Q?/0/mxcoQkZz0DSAaXA0OEflPSexRd8DqlU2PQESLYANkMaqKqsvMXVy2YLEY?=
 =?us-ascii?Q?Jja84fMJfw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012c1792-fbde-4ceb-468a-08de909d4071
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:50:20.1716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEIHekWsvKlhbxACGhtW25FdkSELqS18/xpqr8RL9Q0P23Wtc8BWBItVE0G59VVSlg6z9QmfcdQSds06HeD0xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8471

Add support for parsing Root Port child nodes in dw_pcie_host_init()
using pci_host_common_parse_ports(). This allows DWC-based drivers to
specify Root Port properties (like reset GPIOs) in individual Root Port
nodes rather than in the host bridge node.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index da152c31bb2e..f6fca984fb34 100644
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

