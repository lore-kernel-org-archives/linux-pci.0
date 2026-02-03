Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013051.outbound.protection.outlook.com [52.101.83.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3742C21F0;
	Tue,  3 Feb 2026 01:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083734; cv=fail; b=X5BZCeJeysk0IRUAedoYYQXFhFxmoD9HO6QTT/2fNkZ+C/HOcf4HVXeUyenumdZJNEAH7fWVOArUiyiCTzyFgN2NskGmudb6DywU8lq5O00WDr/8KgpZiZjIjWKmbOjjxDcvjRm7T+XOf7qKApvNJkp2AySolpmc6Ja3Fk2S5W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083734; c=relaxed/simple;
	bh=XGsNVnf9CmiepQz/K9oAmF5VrJPKp/XOq+vs9pThBDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mJ9JNL8zZkkcL3dmiip170u5YzPJClOipa3QqeL4n3UIcKxw6YMLPFcALO0KfmNKfcuyae2zrBu8QO7aqUaFBkEazNy36lrVoOQGLRE/1Plf5r3R8rlDeYALVnr182cHyH0h87MyGTXSIsq5M/7yWRCXObn4iOui+HkORX57hDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bMNYnqOd; arc=fail smtp.client-ip=52.101.83.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bMNYnqOd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1FSqsS6Ef5Vmh20biSXJ1mwjSmKgWzYeJKPYLwSpg3k//rKFT6aRBZhElSr4ONxwxHn8rePuV1emYr0qLu/PdGnAPgrA5f4wsgxKFnBP4ujFMie1K3/xH5kvLTubS1oj0DBPVlbhLDATfZpTTgNgRnsiBYy4TKTtoxikcxKl821paEhRTCb0tDEgy502/fb1ZzTy/3sMG8cf3BNLx28fkA/kFWsteqwrwUgTjfYD6CpL6g/FSPoHr6rofDgYGs/3Gea8/dVu8v6h9W2WOo1Tg38qAWQKEtMqQXs2Hi0fQSC2deWe4O84dFkCzRY9vJFUZXQH81E13Jv0dRA144iow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4jo6Z8DXF8j4EUder97XwXrh0/1F1GWAixTuoTyy3c=;
 b=kMvw5/app1oQprW3WDrwEHAF6HSPPNXESgS8BBhvOAX3tkhb1/wdJaeCm72G2jaUyEOQTiRSulMC+YywnfTPMdV3c3xv5LMn33hYy8vohnurcsk62tOpFP3zmUlZXg2gRiskvQ05vCrk+ccsusBif/57s2xDi8wXa7P+E9V2TlIUzo4S4RyuX12FB64IovgOwFLgp221YgUr3BY1pDNDqbnvnXnF5SHh3LiSsVbngqeTBuvbRWxoHKgJyLNCKwHebvfwvVQS0PrKy+9l/nHr9C5grv/eqwq0K5RVVOWTTwJ0V3A2jhR4JL+qpvEtBZnGUiIo+yVQubchTrxg6HgQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4jo6Z8DXF8j4EUder97XwXrh0/1F1GWAixTuoTyy3c=;
 b=bMNYnqOdnnLGl5ws6QXJcd8HlQ/K50kOy0SWZiRTwGmJKLA6ZCmHZWiFNOCRuihIWsGvGa4JjNf7/q8Vp/e70RO/SfwVEwBqSdv9Y5oP557QOeSUGptk8ej/ypR+SuhU7wO9A3R7aHMRfBwHwSG1kk8plFnjMvcu3hvqVG+ZOx9IEVhk5B4RVIeWY0n+oSin28euM13aE+2AUY2N/r4iHXFswfrCa/m+OlXW29RIiOjHO0jUas2KT9S+8ID8pap08mowiXalU9VMFpjArd3e+KZgeshLxbdsYCHi0s+TUof9wmnauOLIpd9kHH4ZkMKTxp34UMxeuU0+i1N/jSBvWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB10301.eurprd04.prod.outlook.com
 (2603:10a6:150:1dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:29 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:29 +0000
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
Subject: [PATCH V3 02/10] PCI: imx6: Add support for parsing the reset property in new Root Port binding
Date: Tue,  3 Feb 2026 09:56:06 +0800
Message-Id: <20260203015614.2957479-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260203015614.2957479-1-sherry.sun@nxp.com>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GVXPR04MB10301:EE_
X-MS-Office365-Filtering-Correlation-Id: 11df63a5-e264-4074-ae7b-08de62c74ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pgz8RFokOZAbO+ujUVm3go3JCEo+PIz314ZmJnX7b8N+y1gokqrq0EfrSjcF?=
 =?us-ascii?Q?DnQVrz8rSVjsYjudpvlk6ndbcorOmQIGRO04lOOaEGlBs9Q1FA90tyLDpugK?=
 =?us-ascii?Q?SzJtbJb3dvrI5aH+DCAb2o6Qbu/fbACgS7i39KuAehdhgkLjofWVd37SpVHx?=
 =?us-ascii?Q?s8xgKtmrEFNyDRkKgVXqOhDdETk8J49dfM9buwRPP0C93QmSWCuCqs2A7ps0?=
 =?us-ascii?Q?fMNRwHnQMBlRuFQPKOQuNEiN7LNVUkj5OpXlxMXDtODaXd4Bf5js/tra80VY?=
 =?us-ascii?Q?GPUwG4Cw9uXAyPuQi/Cnp3tEhQQLxDItg2d4C/N/KLeojjlaaHeMNhLflQoC?=
 =?us-ascii?Q?IJcWYnkbiDVWdP6uitY90ed/Z7Idnbo3syN+enWL6qtar/GG8aEay3uNtU35?=
 =?us-ascii?Q?ujpjpkFR2AILCN5f3yet1wUzjNE6cSz6tgL19/RlFfh711ZkqJUVdPgXtJWc?=
 =?us-ascii?Q?wl19AL9g2ac9y/7bOw4EbdmLLq8wVdOecwQrAN5vqNh/gFmwODeLYayDqSJ/?=
 =?us-ascii?Q?fQPpjmr1zHQDC9yEkzG6A9wUwAaFUb4wQ7hld+HerBrZciQnfqMGBusiKT69?=
 =?us-ascii?Q?kiSzQ/BktYkSaFQHvbyUxO6udGMT+zwyiMcI2H71CMkPb7HwD2e7qo9Alff6?=
 =?us-ascii?Q?KGo/V9lSgLISwoxSrUSvEuf27WieZdBe4lUKiubIa1eEfrBkCu963QHGO4j/?=
 =?us-ascii?Q?R6Qy1KfYMe0m1HvLdLnAWQAvttkUBWVkCI1NuGZuj8aBHDhsem9sVtnzBLl8?=
 =?us-ascii?Q?MBIL4ND9VzDmYBOsYitL6eayQRM7DOUGZH4JMqFGFR8vBPMn5jItJZBhNSrF?=
 =?us-ascii?Q?oFWZNd0Z8hRj4A6g4Indwsgf2WNXNIIqEuIqqgP9vAKns+VA3137hGJoeEz2?=
 =?us-ascii?Q?v3E42bByWOSHLiPfI06qdWKv1vSPXQ5JMNocKkerra9F9MdCk9a3I/KctmlB?=
 =?us-ascii?Q?zFtSxrKJq0FE+Ft3hQ8e1ixTzg4o83dkLFRWRd6eXVjRZHLJFAGUvMn72RMM?=
 =?us-ascii?Q?2Kfs06qvABtaejW4alnBeFgYFOzoxumJCHrejcm58cbX/SEftrpAvL+RbS5r?=
 =?us-ascii?Q?fFdG65fM5WHcWc9k9RQkJxR9Wp43j9bkeEY7C6VMJ0tPf7LH7Po2D+hixmHo?=
 =?us-ascii?Q?8NVUW1+/vdwgZ4xD8JtRAt4RDZx/5auve33FVywqnVkh6RQ9Vox8QvpuyL65?=
 =?us-ascii?Q?KqeywyGbeq7ZSQtT5FrYP4AaLO3YRRxxbTLRfY2TO4kW5xnLl8ENELUwBkCS?=
 =?us-ascii?Q?6Qc0ykCoQQYzWzsduIxIEdDz+Nm16SJxuRgam6iJ/TPv6B4M488x1d1MxfDF?=
 =?us-ascii?Q?eyc278Vi+RCqgaY52TB+2Z3Z1XPVKRueTAY+Fc/KUFSl7IAkbvdCwFYMprhD?=
 =?us-ascii?Q?ne/e7BpvN0zCmyrambb7wC7ABMOU5LTT7/uLqMKW36xUOd30f12hl0ik+g/2?=
 =?us-ascii?Q?Ka+x3h+0hM924+E3uyLntIFmj2gO3YXIgWXrkRwBaLQFbWBDdxO1Dx+G35Vr?=
 =?us-ascii?Q?P0lWMM+D40ZnifCB99ZvXl5IODFtC7FclOYRS9if6VJ3lDUZnIplHhXh599T?=
 =?us-ascii?Q?2SqooG5hwxy/fBdtL1/0duDVZ4jSwiXRnGAT9N1CIdvb7hUi1LOvgSgxSMXT?=
 =?us-ascii?Q?DL/6qfkkbyXBKh3EJUjgyuT2diqrhZ1SPQ8G7Vyf0Dmf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tUYSkswOgEto+EPtrit7CMKJYS7OyqIZ4IaYrEnL1VJOKiXJcW1FnFrultDU?=
 =?us-ascii?Q?AKpmITrxsslMNbE5DXIvoGCAyoPCG1GADPV7ntEk38hlxt4UeBC9rJAERmux?=
 =?us-ascii?Q?QSNIw6RCA9fRaF3NUxjD1qum21HLdyk54oQrzyWu+D9h9XJqKtU/9VDAn5G8?=
 =?us-ascii?Q?5SUGc6fiDsfSrYuzg3y1b7kiCYvjZlsBiarj7rPCEbEPR9WDWuaTc59RLyQN?=
 =?us-ascii?Q?WRBNsxyYSkGubEQDCvjtGVUMalARwKpA6Zm9Z0jJaqnnKouvoG4ZiZeeWOS4?=
 =?us-ascii?Q?RGOktppq7EnjMGiOryw0mX72bM34zLXwrKggu0ID0Ms2wuwp9v10PiKh66gT?=
 =?us-ascii?Q?VcwZvmrasbLD180LTQQzrnDkDnzk6m7cbBd9F0MPcX9nEpZ8uJi29InicLrv?=
 =?us-ascii?Q?9ZNYT7WoBLhaxWfYM+Dxduna3aNprsN4tcZAkT3BPkDCxqKWfFmjJdzGGZ0l?=
 =?us-ascii?Q?D/O0WNJdE6jK/Po4HxU5XorR9KzF9QxV0a/luBRIiXmehCl03nHB7JTQOycE?=
 =?us-ascii?Q?O1q6Ek6NL8u+OptIrTQYAQzRMC/py+TW3MTr9mBjAPiS1IqUH0v3vZEjdXnQ?=
 =?us-ascii?Q?t3pvOK6YkRi3tilNa+oOCQQlNTXyTP4RNLa4Qix54qZpUWH11U9wPynOds1N?=
 =?us-ascii?Q?QQMB4CFitjUBObFU73mKAr00uBKpTDkgewPyg8je/bLyaYrOUrK4/lBAj+Gy?=
 =?us-ascii?Q?vUtMR0+FVPwQYOc5oKAejQ4Ixp+ueHzhBZiKkO+zju23JdgLtFfJAeg7gS2p?=
 =?us-ascii?Q?sIWcvzKOquv109tqKaZlYBI548FxKOQXzXH0amT6SK8cXWUXnCrPF++lXYph?=
 =?us-ascii?Q?leO7RoZzv+0DI5RXn7qsdC/7pofaNx4TMOTLjurQMsBRvI3hGR+44d/FyTY/?=
 =?us-ascii?Q?BcJY0xCXeH7qLRDiwdevFO2oMfNtIxTHW2rpQddJMx3a97mP1aJFvbi2EKQt?=
 =?us-ascii?Q?pz/XTmxZxsySwvA6REc2qqW70h5dVsZU55zuYwTQeQLIv6AI5G4Pt62FFwuS?=
 =?us-ascii?Q?PDoGGhrfqEH18G/7O2/saULmpdtT1fP2XMUqOObkvxH8TknxVaroWnOlo0E4?=
 =?us-ascii?Q?TZvyWBlg+5YzHm3XZWDmFdHwKDE0UCT9Szd2yaJP79GzOJJziepi+kOgnlq3?=
 =?us-ascii?Q?OGEpULSQNjtKGt5GeDuHtYPR3cQ1jIt2S+ca1VMzbsE0J/QiBue5uyb8DDup?=
 =?us-ascii?Q?WyfwNZ+Us0zoiRwHo3/UQnW5Dyo2kVPyug+tnGLNuJ69TU46moJGOR4PfP6D?=
 =?us-ascii?Q?nJi85MDshntmgIiztGqQmb6mhstLUrwT56yAyqGmD3j5pgZ8xo4cstEP3Y5y?=
 =?us-ascii?Q?a7L1TVSJscgVV6Vz1i/sjTHt9PIYWYrVqa8iedjHjFQ3NXWnINMdJuykiLQX?=
 =?us-ascii?Q?arGbPhCQKe+eQ5WYmiN32Y8A9ddGG2k1GveOtL1TZb3R2D9lxGMS+kLM/vkr?=
 =?us-ascii?Q?eZlu903d97A8xbC5+FiXtWxBnUer8SuuzuAJpf4/vGvu76OiIFVrlx1rt2XH?=
 =?us-ascii?Q?ZJ4WUft5RveohMKWDggJCzB8FgsTdTSiEwlnoW/qQSB+AoWe9d7evDUbDGZq?=
 =?us-ascii?Q?nHF5VUE2rsEQxFJSQB4my/pQPWQvATcE2PGtSjZf2NeCZq/3eLEETDcl6s2o?=
 =?us-ascii?Q?fgHEeoKGwczHIJq8TShbjCBajlb2N3HkT92l2OQ1LR1M0zvXe7pUfEA+wNPI?=
 =?us-ascii?Q?xYRtDCwmUre/5oeESJYagySLJ3Q2TQHcqHT76qVOhZ0zvdEpOTFFbPLkJL80?=
 =?us-ascii?Q?z7xrdFprCw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11df63a5-e264-4074-ae7b-08de62c74ee4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 01:55:29.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5u9wynHJZFy1O2aMIPktuB2G6Xz1uq+i2owXQGGjP4V/7aqpgAfqaJop2rVpOdBYqIFqBqa6ZIW5gpwP9wtUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10301

DT binding allows specifying 'reset' property in both host bridge and
Root Port nodes, but specifying in the host bridge node is marked as
deprecated. So add support for parsing the new binding that uses
'reset-gpios' property for PERST#.

The initial idea is to add the PCIe M.2 KeyE connector support and PCI
power control framework to the pcie-imx6 driver. Since the new
M.2/pwrctrl model is implemented based on Root Ports and requires the
pwrctrl driver to bind to a Root Port device, we need to introduce a
Root Port child node on i.MX boards that provide an M.2 connector.

To follow a more standardized DT structure, it also makes sense to move
the reset-gpios and wake-gpios properties into the Root Port node. These
signals logically belong to the Root Port rather than the host bridge,
and placing them there aligns with the new M.2/pwrctrl model.

To maintain DT backwards compatibility, fallback to the legacy method of
parsing the host bridge node if the reset property is not present in the
Root Port node.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 123 +++++++++++++++++++++++---
 1 file changed, 109 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a5b8d0b71677..e3ba68976bee 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -148,10 +148,15 @@ struct imx_lut_data {
 	u32 data2;
 };
 
+struct imx_pcie_port {
+	struct list_head	list;
+	struct gpio_desc	*reset;
+};
+
 struct imx_pcie {
 	struct dw_pcie		*pci;
-	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
+	struct list_head	ports;
 	int			num_clks;
 	bool			supports_clkreq;
 	bool			enable_ext_refclk;
@@ -897,29 +902,35 @@ static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
+	struct imx_pcie_port *port;
+
 	reset_control_assert(imx_pcie->pciephy_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, true);
 
 	/* Some boards don't have PCIe reset GPIO. */
-	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
+	list_for_each_entry(port, &imx_pcie->ports, list)
+		gpiod_set_value_cansleep(port->reset, 1);
 }
 
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
+	struct imx_pcie_port *port;
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
+	list_for_each_entry(port, &imx_pcie->ports, list)
+		if (port->reset) {
+			msleep(100);
+			gpiod_set_value_cansleep(port->reset, 0);
+			/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
+			msleep(100);
+		}
 
 	return 0;
 }
@@ -1642,6 +1653,76 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
 				  imx_pcie_resume_noirq)
 };
 
+static void imx_pcie_delete_ports(void *data)
+{
+	struct imx_pcie *pcie = data;
+	struct imx_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		list_del(&port->list);
+}
+
+static int imx_pcie_parse_port(struct imx_pcie *pcie, struct device_node *node)
+{
+	struct device *dev = pcie->pci->dev;
+	struct imx_pcie_port *port;
+	struct gpio_desc *reset;
+
+	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
+				      "reset", GPIOD_OUT_HIGH, "PCIe reset");
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->reset = reset;
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &pcie->ports);
+
+	return 0;
+}
+
+static int imx_pcie_parse_ports(struct imx_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	int ret = -ENOENT;
+
+	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
+		if (!of_node_is_type(of_port, "pci"))
+			continue;
+		ret = imx_pcie_parse_port(pcie, of_port);
+		if (ret) {
+			imx_pcie_delete_ports(pcie);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	struct imx_pcie_port *port;
+	struct gpio_desc *reset;
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
+	list_add_tail(&port->list, &pcie->ports);
+
+	return 0;
+}
+
 static int imx_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1660,6 +1741,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&imx_pcie->ports);
+
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 
@@ -1688,12 +1771,24 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx_pcie->phy_base);
 	}
 
-	/* Fetch GPIOs */
-	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(imx_pcie->reset_gpiod))
-		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
-				     "unable to get reset gpio\n");
-	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
+	ret = imx_pcie_parse_ports(imx_pcie);
+	if (ret) {
+		if (ret != -ENOENT)
+			return dev_err_probe(dev, ret, "Failed to parse Root Port: %d\n", ret);
+
+		/*
+		 * In the case of properties not populated in Root Port node,
+		 * fallback to the legacy method of parsing the Host Bridge
+		 * node. This is to maintain DT backwards compatibility.
+		 */
+		ret = imx_pcie_parse_legacy_binding(imx_pcie);
+		if (ret)
+			return dev_err_probe(dev, ret, "Unable to get reset gpio: %d\n", ret);
+	}
+
+	ret = devm_add_action_or_reset(dev, imx_pcie_delete_ports, imx_pcie);
+	if (ret)
+		return ret;
 
 	/* Fetch clocks */
 	imx_pcie->num_clks = devm_clk_bulk_get_all(dev, &imx_pcie->clks);
-- 
2.37.1

