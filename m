Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01727FB37;
	Sat, 12 Sep 2026 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789229797; cv=fail; b=f0nxEIbvzk21/9co/XUNbq2pqPUPbvHzrn8xSStv6ymnY39/nfotxSkXBIFHqxSyNrgo9KmW+W7FwyMoZSN8AnN1/e7+udSKLILhnbVWKpCwWhycF5aM0ZdXf250vdKHQLTlcpjVzr17KZHWykFeIrKOcl0jYyea4L7j4+zeD5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789229797; c=relaxed/simple;
	bh=/qrbLHadHC3vjBMOOck7EXhLBFi2SszF5M2IP4QOOX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nV22kFhpsrX8fBoArS6gs4fAxWZsXKRBaeVYMs8PnwuaxfUvRmRiIaZmr8AxNNOP0W6rqnZZJA46jkzs+pm7KjsqbPi+bfJpVrqu3naVvO/LsUMGNwqnuLJT71tPtYHZpQkGJRgiwmH3y5ut/jLOg+c27IgP2Sr8WwkWiFTmlME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eopY0BWO; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eopY0BWO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/Tp4CLqhTOjRSYSS5Qiw67eJe0aOD6jzcgfdVUdIO6kes5pwtLbeLSAlD6rpVzPjqsHT6bbeGagrlBADJk/0ls+7qCngLHX9PU450IO0XV8gBd7gAWssSV9XApBd+osvX408bXNBbMVlPHivzJ05CxPR9KVIF8I6ixiB9WDAZ1Gzpr0f1QJxdzA7+o5e30Gz+fLCn44pdnHaar2R7KC2j+bRi6jEvgqD7wygoTuGrIYb7uKYaStVdbdfGfR6ie8MEi7SQkv1l8WAbzRrijH/hPaST7V1zvDGbRvL4KjfXhlLQ0ygDPUG1qozwrs0tfGhPhR07iwn8SEtOK4ZtPseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoZbRRqYtVHqcPM6hFdzgqle9b2xvCA1hlTCv7ez/50=;
 b=qCiQXUxWxBLoBuM54VNYSVHy28ukpZvIo6eMqk1kIIGYeOYyl3wCeYSITIn6aBKLSqEyZHQ/9bV9804vxil2zlfRJbFiNL9E6v4dRQa7E/aX03zWbLG+YBuiRqIrhbhjRijpaYxW77LKYrxzxZ9A8kuKjuk5+IIZLzzPVxIRUmpJenhvsxvVsFRn9p+R7I28iVzMLZ24oKsxVerRlJJvpeSEETFTX01M1nLpkZv4Ln7dK50dRFUQ0qbvgeoKa0uoF7JyN66wwirxg/F8bINAr3tFOg8tn+HMJQ3vqmqPmaF2jS2CettmcftnPy+2a4ZF4QMjIVQt4ocrFFUyKekHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoZbRRqYtVHqcPM6hFdzgqle9b2xvCA1hlTCv7ez/50=;
 b=eopY0BWOAk15ljI6Lhaxu9PZm4OMawBQptoeM1dyz6TZxHiaINDdm0N1EX433lBaJsERkMGyew6K81Rc8u+2lye6lJTE8z3RxnkdDqOzSfqTIKDD6YapaJ3JIy0QnRpzveQt5Uqfq2MyIIVAfX096PjWicdGOCWFdQJCCHQF6BJ1n+Tl9g6NAW/sGWE1NhxmWHYr+cMyAbsXpC6VtkjaWqu2hvAAN2lGfhwhXw8/N2G3qOT5EDrsEufE5B65L5yz/OqF4LoYzLrew4HIOcmwUW2b7X5ix1quPBuFAWHq/jAJFW1RX7ic4AXpJ4ET6zvKYf41X3GMSXEbjPDWB8fBNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU2PR04MB8871.eurprd04.prod.outlook.com (2603:10a6:10:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Sat, 12 Sep
 2026 16:16:25 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 16:16:24 +0000
From: vladimir.oltean@nxp.com
To: linux-pci@vger.kernel.org
Cc: Aksh Garg <a-garg7@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Manikandan K Pillai <mpillai@cadence.com>,
	Felix Gu <ustc.gu@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] PCI: keystone: Remove device links to PHY
Date: Sat, 12 Sep 2026 19:14:40 +0300
Message-ID: <20260912161440.1032188-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912161440.1032188-1-vladimir.oltean@nxp.com>
References: <20260912161440.1032188-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::14) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU2PR04MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 7746d58e-44ec-4dc1-8c92-08df10e9312c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|19092799006|366016|23010399003|376014|1800799024|7416014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	z5x2Ic+mP0jnDdsmvmFQip5ZaHyn23IDA1Ky+TWaN2Nc2ovenmYOJ40XxOtP4E5+1DhESXzt7za5z8H1RFNfU08cmXyg2UUMA8OoalBFa3VoY62Qsyh6NCNG3cXsCn/1ko6TfWUzTQ9Dk30gV5znl9p7ljavmr1QSBxx8320MQg2CUevuVsPfaGuqIPl5zmphBXeTKBAmQrkMMh103kte+LJ+2GM9b1CH9HYJ+G0cGH52Px+9VRKvJbqp1Spd61M8YhnFtyuGKyxZ5BaZTk7qgYjqd1qwQmRxtCL58/5VPJ36umpfSPVKctvOG97cyaSBN5rrHGkNKD5oUCODtQhIsydlPIm4TJH0q4n88MY2lSajdcgWnXHOHMoyfnI1QBteAPaNniaUo/aEb7NtChJAO5yzXHOyHAK5L3kHwT2g0uEPH0jm8r/SKfpavOLwmyBlHj8DgVXD6DjP9pNakDw4EYThG9x0Nb0oXLJXAXOKJU1Ws5p7pz9g1Gj+FOPX8B38gEdoPKtvjfKt6yo2QcEaW5w9Nw5e9RAyK32ALhCRr/DOhVh/ws5EE+L4Au/HbvuDf7NGcp/LxEHhuX12QUd0fXKd1klpXkMpAZbY34b8W7nJzPndG3Q2GL6fVZ7hUcLGRjPip1e2K9cb7mrXToACogLuWLiXiS4mlNUqTKDAug=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qDrhgmbsYWHectne4eakpUVJarkFBFk+J3GMCVt3OYNtAUqva4vHwel9fnbU?=
 =?us-ascii?Q?VweVX/dJKwc3vzgluyTuttv/8sz8rS6iIPrYcTHyBmof6uastBIxcKpn/LMh?=
 =?us-ascii?Q?BKKcYrT4GxfKTkwswsgHsNvjvCPGu9to/798MotjsJB7fRkv72/ti3QpgN/b?=
 =?us-ascii?Q?Fiy+sv/AsnDklpS8FAX7ZZ+gu8EIwSF51aoLDgQAKniqBImn0AyrDMdhY45Y?=
 =?us-ascii?Q?ezr0cU7gdsCBy3x54yzY43FOzC/r3aM6bI2jh/gNU3df9tlv1Rv8mQW+QAGl?=
 =?us-ascii?Q?5l3BabxKWcMZmBTryKt8bHhPaaygZj5gr8ZxSVSy0zFJI3BYmypmyateJbGF?=
 =?us-ascii?Q?wxaPTZUiEp3sfaI25SI4T0AWmQh6JgzV7H8UaRxH+8nSjDXW6mvEqMZjBFqP?=
 =?us-ascii?Q?4RCoRmiYoNTCD36/0n92+4VIXpk3witJiriMZkJNS902DyZ+plolTN+ZEKG1?=
 =?us-ascii?Q?R12ZdhyBGs+4Z3Vb1mqdm0Fh00++lYK8dkhf/YSrOJOPgjWACTtRgim79ykR?=
 =?us-ascii?Q?JPBcTPA4Fx1wUSmYPTEe2mYDsx/QWVBzMtzwnsyc7PPgJlQaO6+yWfPKpYD2?=
 =?us-ascii?Q?cYuhCo9INT3mxCFYe0cXM6roxDEy31r6Ir8jcam9ABNBFYAwV/n1xZ0tt1b8?=
 =?us-ascii?Q?OWa10EuAYa3UpAp7MZyiaPPrC/9Sep1nO+dVzuUs1gvik/LSGbFIFvOOuI9h?=
 =?us-ascii?Q?X/upxrbHWlKpRB1xyu/K3Ctw8TbmU1Bj+JQnneZT2XhF60h4grYsqVhDZZIb?=
 =?us-ascii?Q?FFBSjFsb4UYcSpERIpZa7y5759JbRMMbGTzY7UmbMgIx+Q+WF8qPFlwhX6B7?=
 =?us-ascii?Q?G2zBksRPw7bzMs0mBvTG7SYo/6Ek0SWjqWjEC3HrJaka76R6Uc/ltS9xlil5?=
 =?us-ascii?Q?ewZjuBLtLHtQwr1jGcJtS3w3YG8iCGrgzn/M73c7W4y9GSL9KahiQqMd9Ywf?=
 =?us-ascii?Q?T77oPrYgvfZ/ErMbvxXvqbTr0p8x2/teQ1Ub+lEtnBJO3fnXLVO4iKEU0yKl?=
 =?us-ascii?Q?1UtCl4y3hiwJc8Pf1H3uiAGplEgWim4Pbo8yBrTd8FxgKmpB+66GZuyS0vau?=
 =?us-ascii?Q?ALJfR1SqtV6rb1CmNjBH0Z2FFt5Vbj8MWCRJY7vr9aD1hHtjAiLCE7C+CT1N?=
 =?us-ascii?Q?bbPVYeF4mz10bOCOd0DZGSVLKpGKtuUFWjoXdpAyBxK+Ro+9qwyFEh3xlyBa?=
 =?us-ascii?Q?WFVe+FQh6a9rgXot2wwyo5cOcY49BIFomqKF06RldzWqaFFEkS6DkfkKNHhG?=
 =?us-ascii?Q?SRJtQZiBOIkuVRDNfs82gJGLa+3sjyGVUUlWj1uOgy3bH3+caIx65M+3NoPo?=
 =?us-ascii?Q?YnK4Y+t+uZEOutO6l5ccKV81aNOoCyC3mxdG6Az2Pqk+tBFxxYh92bgZ9mEH?=
 =?us-ascii?Q?3wbaAHnNdP6CR5xeS3r5j1NTJ9V8OvOFfYJJOKFVVrJ+dx80GBPPCR+xWxv4?=
 =?us-ascii?Q?x672twxkhaGK7WVBhHM4oRgz7pvlf/z0pFDBbEznQn8iGeogFrnmXFkbwjSe?=
 =?us-ascii?Q?YkV+IwlmH6nEqbrawyil+n+sl0/KVli3GQAv/kpg8M8fJU3w89JN74geYgqO?=
 =?us-ascii?Q?PSORJIpyocllVhyua89xKczJEAn7kqHDgZ3Ufslva5av9meOZf7wxLP2/JbX?=
 =?us-ascii?Q?6TjJxrw6LzlwZZDGfh1CpMoUPDMRKgaiDZfccGQjzsDZXF3MZJuKVi8hJRlJ?=
 =?us-ascii?Q?J7ttTOplhXykz6h2q3tSTAitfIlJ3atwR7A1GYB4KYWLslFjUC3BOhcAFsCa?=
 =?us-ascii?Q?QXoIAmjSf5iZjotos8cp7K8Vc5P1grXTbdC9aF9sTSHzxahjXzp1FTX69PlG?=
X-MS-Exchange-AntiSpam-MessageData-1: bPoWTVpbtHLBLyKxgGBKMtWxQY5vwjNHNCs=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7746d58e-44ec-4dc1-8c92-08df10e9312c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 16:16:24.9251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZaoLkjFToVkv+JZp7vO8D3gE1ug0AtMZu2b6Evaz8E42eal6tNwQ4y0/M5/ldN1ZbYLWAWO6khqHwurhUj1IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8871

This is a partial revert of the device link pieces from commit
49229238ab47 ("PCI: keystone: Cleanup PHY handling").

The trouble with this is that a PHY consumer driver dereferences fields
from struct phy, which will become no longer possible.

Since commit 987351e1ea77 ("phy: core: Add consumer device link
support") from 2019, the PHY core also adds a device link to order
PHY provider and consumer suspend/resume operations. The reverted
functionality is from 2018, and is redundant with the PHY core now.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 31 +++--------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 602516239a57..bd736a1624bc 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -129,7 +129,6 @@ struct keystone_pcie {
 	int			num_lanes;
 	u32			num_viewport;
 	struct phy		**phy;
-	struct device_link	**link;
 	struct			device_node *msi_intc_np;
 	struct irq_domain	*intx_irq_domain;
 	struct device_node	*np;
@@ -1131,7 +1130,6 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	enum dw_pcie_device_mode mode;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
-	struct device_link **link;
 	struct gpio_desc *gpiod;
 	struct resource *res;
 	void __iomem *base;
@@ -1202,31 +1200,17 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, num_lanes, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	for (i = 0; i < num_lanes; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
 		phy[i] = devm_phy_optional_get(dev, name);
 		if (IS_ERR(phy[i])) {
 			ret = PTR_ERR(phy[i]);
-			goto err_link;
-		}
-
-		if (!phy[i])
-			continue;
-
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			ret = -EINVAL;
-			goto err_link;
+			goto err;
 		}
 	}
 
 	ks_pcie->np = np;
 	ks_pcie->pci = pci;
-	ks_pcie->link = link;
 	ks_pcie->num_lanes = num_lanes;
 	ks_pcie->phy = phy;
 
@@ -1236,7 +1220,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 		ret = PTR_ERR(gpiod);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Failed to get reset GPIO\n");
-		goto err_link;
+		goto err;
 	}
 
 	/* Obtain references to the PHYs */
@@ -1251,7 +1235,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
-		goto err_link;
+		goto err;
 	}
 
 	platform_set_drvdata(pdev, ks_pcie);
@@ -1338,25 +1322,18 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
 
-err_link:
-	while (--i >= 0 && link[i])
-		device_link_del(link[i]);
-
+err:
 	return ret;
 }
 
 static void ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
-	struct device_link **link = ks_pcie->link;
-	int num_lanes = ks_pcie->num_lanes;
 	struct device *dev = &pdev->dev;
 
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
-	while (num_lanes--)
-		device_link_del(link[num_lanes]);
 }
 
 static struct platform_driver ks_pcie_driver = {
-- 
2.43.0

