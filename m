Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD623A784A;
	Mon, 25 May 2026 06:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691956; cv=fail; b=Ps0XKE8cCRKu3xpA1wS88T/jlvju35whOaXun7d/w3DiSclihd94x5ZzpUWlcPDouCK35976alM5YfI3o3wOLyObVeIEd6P8CNarKAOk3aSlgkP2mOsLQu3QGEy6M77NA9DW2Ai+D4BnmOOh0E8Gj1FUfogVGpDJVKjJw+Kst9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691956; c=relaxed/simple;
	bh=bjY76JtG214nlILpfuM8busXu+BIc0124BTLMO1N3K8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sqaz/TAskbMQuI/q6FTkextWEPJuzKpRvk2bwji1zt0YVp1y8IpAGx2voX2GZWq2X5BJmAekAw4LxFMT0lWAfqT22U8rORcEcxtCIZ0NZmAiwjyWl06iSn6KFsEgH4btuJXHi3eTykIeAAXBL/vllkY1QuYvLrrmyI21fCUSCic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SRb3nKMU; arc=fail smtp.client-ip=52.101.84.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SRb3nKMU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8FOIxWjz/VdC3KJhknAQSkkhAy5eV1IdciSY159x+0GITkKyPUJuCaAD9LG2qzQQntr1G6NFzYAgHXEobJaDXIcaQEWjjesgos5tDmsb/6Da1P+Sr3MjOtRh/tBaPxJkak+bp7kbohLPjAp1z0jgzJPbsm4nDyE4rl+PpYyW106S0dD5vbCSZoSe8cb4e6qXxG8NaAz+H6b16naWnHH94d0yRRO2K6MzPg70p7yZg0ohmI3edtLAL8j6PQpvqpYTu8etpgcPtTAwe0gj7sesjIhoSV4Ua/4EdhWXrz+mBse1IbyAZBXSmZBavOEQaOhuD6ywW5dVr0fK3l1jo4mdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPZUxeEiCgIidWzgUuYMF4ANeTPfB+JPIL/hgIi5jnw=;
 b=bzr9p1cBfaXY1GtfjqfOow119tFvBFk/oSMRrtRBG1VLTz8QV3fEaU2ZRf/kzZYkHke3covfOj6gfouqZ+dp/gutwVUp9NXl1msKxSd3OJZ0MasFs1T9u54DuiM5CJAJlo/NZ3v3yUyGqe92aKjTekMmw1ZBEt+tapeBHytL+vtg6IeR2d4uQrhlZUOGf/TH6GRetqKgmwaX51PN5TaOXIl+a/a5mxB0qx6gRpNLSMx/IDVSL84kDKqwIzd3wmC/zFla0tLzT6slI1aMIMjY+hrUxfAWLxnFRAcIKOregwFBgaMchfHOlwG+fLFMNd6TxF/OosUcXR2NtfB2/Pggqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPZUxeEiCgIidWzgUuYMF4ANeTPfB+JPIL/hgIi5jnw=;
 b=SRb3nKMU0tMe1r2M7fVKKnI9JHsu9sY+wJ47TqVCJhTM3idRM8uUBVjukOAZSOcrQO1iVgkdqtIB6x/+cx/rax3sWMrvbC4QA1xgNdPSkgnPjlH6ZKRpIXG4uzgiIpL8hEzZ7kTJLsZe3N2F9M2Cgf7lfwu23XVlo4cnvlZzUS2fz/jMOi4HHgkazFM6EtYLqrqhLiRKPc9UnkGdIsgLF3Z3IwdufD+Nea1AmJCi7VW6QSKhi2elqZ5ywHII+lu9DvJhy7EYLZWMvAEcuGpwgT4OXPPixjaIgRpFL2LF51E4gfXUsIHBBEz0UEyZpXRf6cFaFq5DjsuAla43/SxmFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 25 May
 2026 06:52:29 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%2]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 06:52:29 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	will@kernel.org
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V2 1/2] PCI: host-generic: Simplify return value handling in pci_host_common_parse_port(s)
Date: Mon, 25 May 2026 14:54:42 +0800
Message-Id: <20260525065443.2338629-2-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260525065443.2338629-1-sherry.sun@oss.nxp.com>
References: <20260525065443.2338629-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|DBAPR04MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 141648a0-7bc3-4eca-acb0-08deba2a303e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|921020|56012099003|18002099003|22082099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	bxm6C+p7OvPi+fEBxoaykpDTSQywyMztN/NEsDe4HWHUfOQgzOKlt0eJSgGPijsXbHJfVSmt3fDi+1PpqSIv1db+CC45RNlTZ5uS7NLRbcWPQd8PmjNH1+IuVHocc+ICrlILhm0dHWgU63rOiIxKo21MkPlKesP08yvy+nwIFkLhE52Hg2EaIfZwaSzCVNM3YIVdzaynwfZ6l5Xg7yY4xKVHNnrBMPx8oMyu7UTWlbqgusccdgUmOirTBJNeBx6tL9MVOTGWR52fMhiutvPctasDXs1ID1TZTToy0ezeOz4Qv+ZJeGScxPA4EEPYkcJ0Aejs1B1yvAyCLdBEEVEpVvSJQqsT+xwb4qa2AY1fFHLzUQZlRkPgt+F/AAj0d8aEAUUgdmrC0N+MsAJM9SDczGIb1na9yMTZWVwtA8FSt2b3cpBs6SzEcuQ/LRtzSxEACHHTntAIuxPH3URreI6UHeZqcazu2Y59hQ1MOLMkrLXbJ6atwm5igerzyeJoXsOKTQvZqtPlfQybdLNZ7Nw2qNIaoISbIhycKXkO1oKr7grZ5h0O4H+tZscXCAhWBFJVbDEyzs3DpTLQEDxgQmK1TVxef6slX1soThCF/9y6sgmTK232H5q/Lzm9Tiw+tEjJu6fmqoO0us7hwFHOqh/uqvObGJDNCc5R7CC+wyWFX38JS30fE5bz7rPaVYPmGB7GGSjTV88L5KHn9kNPkVL1oyL0soWFGay04ISzg76kvZI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(921020)(56012099003)(18002099003)(22082099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AsRGBfR52kZBP9KSW5HByiGkaKsGcGcJ2uLlPpg5deNUX0IikOlj1589nqLh?=
 =?us-ascii?Q?gGZLlmqoOskw+BtGaiu5Mo6ONpop2xeCr55fuaO3uX2nSHq0JFqDCslGydjT?=
 =?us-ascii?Q?TzSIz4dO3DQa1KUwfkFj/vmef6CtC3Eh24+eH8vgMq83skJHqAcybDiXEgXc?=
 =?us-ascii?Q?DjuTyarUSt081HiRq0TMFpDnmQ1jr1IjpE2R0Pp7+46gcrZfjkllVCEW07T4?=
 =?us-ascii?Q?ETCfNz8lQbfABnvHq4c81rEyC0VZ9UvF46MogQos82T6ocM0Cnpt6HgUnVKX?=
 =?us-ascii?Q?TF+2B+cDtyAbBNlO5pAq7zY0zbW8YP8EqveLT5X8ePnYeCJk9vu70HKjYM0S?=
 =?us-ascii?Q?58AI12fsl9Vzk3CrnXICGmpVurAZZQcAKf4zSUK/g/scunLXj7p7bEnUUHgF?=
 =?us-ascii?Q?t9t7rLBhOESCeFPvAnbfKaTIQeP/tsCvTr55gW4Zq0h3Srf8chB7F0G6mEh1?=
 =?us-ascii?Q?lhzqH/VERxZG3vlaHFdshmewDhjdSOi0aGBlID3sWKZsoCEkID3Rfbj62J16?=
 =?us-ascii?Q?4wWlQ5wv8YJnIgeQqZgKJHuwNsYo5DteQ9l1zNOLQuUqLkfBToIeTHWe7ByK?=
 =?us-ascii?Q?ioopXdq+XqkXpCWRb/EASSYCVWGIvNkmeE6E+KEsq53PPmUNJPOp5e4sylEM?=
 =?us-ascii?Q?KDsZXWL/5aZBWadP7zpN8+OVX4OiwabCwi2e6kptAUbfsqfxHPSDYiVYogUB?=
 =?us-ascii?Q?GIdmQ4gfNOjIMD61n1FCfbLgFPBJbCU4/w+nuZm+wmRbuu0sQqvFDtfDm1Aj?=
 =?us-ascii?Q?fXKMlApPt7OUQ8xUMXJ/HBMOKfO1jdhLtoO96+q4JaHU6kD4IGWue361aeAC?=
 =?us-ascii?Q?wf9VELW4IoKfqaMI1/cNWk3roV+xeDLD5bDKPkFKBYeDJ5WaqsRpvts73YBd?=
 =?us-ascii?Q?dtq3QoNUKQTYkssyJP5wJ5k8vFnY0j23uhvjiBYrlRzFbc6a2LlpJ9baaIjX?=
 =?us-ascii?Q?ja+NyqwWOGNjax95OknNu3KLBbCRmmRzTqbBD+AETHtQpwcErcRgeMORYgrN?=
 =?us-ascii?Q?627aa15TT9LN5ETmhODL2JyDXwKfeogSTO/+7FDppFJAxuLC9hZVmFkuCTaP?=
 =?us-ascii?Q?VItwWftQXluJ0GeJFlHm7LvvcD6l9NfvVwbezJBzeJXDRc08pDZau8P1EsJ8?=
 =?us-ascii?Q?e78Si96DpGNQLaHRD29n+sPocGtqLZWE/YaiF5sHpPPJ9waL4DNuGCAuNWBn?=
 =?us-ascii?Q?oKWc4WEZbNFymovVx96+kwuw7fQm64eFh2JtSn1Dzb6mAiT0bNie4eLGvWhm?=
 =?us-ascii?Q?E57knj84uQOaPzB4t2Z8yaMbxNxdb2qQDej1Cn65rxODsoc5hKR03MCQ3RMs?=
 =?us-ascii?Q?lTFHCasLpP8k4ZODbcbEJoN7Dkw3CMyn9pVO1glP62rVHy9AyMQXcIS2XRFL?=
 =?us-ascii?Q?4MTr+BgURG/Uw7vBUfMr7duPtZauB3w8KdDKyCWPmJM19s3XmFCazy0YWaye?=
 =?us-ascii?Q?BxEfEdCWPiBPgx8VIAUdLoL6D6beYVOJHvHRG9VltesR069YV9oXFVeaLqmh?=
 =?us-ascii?Q?0DoRvZaITrRKYEGoCVm6oqEbVWijDmpuLtWZ8xGLQtb5NH6wC2B2yVHy63fR?=
 =?us-ascii?Q?OabIpXWyTHL5E0Cpwy32TQ6ilZyVuSlzcg1pRI79C1H+UFg9nmx0L8OsszZd?=
 =?us-ascii?Q?BUC1ne0aXtTDU/0nzGg+1BcAhu1WsxWOlkXNCKNHcXaJWH1QBkHIxcw4AJr7?=
 =?us-ascii?Q?i/h01dK/g70ZCDq7i3j4mDnbQUCq+TZT1xRNHFZVCU5NUj3iORTicLE/FgCW?=
 =?us-ascii?Q?/eYV2Kbb+Yr/nd4cr6yeJM3rTY1WPlSV0RU7ss2vVin+Si0v5MYt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141648a0-7bc3-4eca-acb0-08deba2a303e
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:52:29.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6khYZlyigaxtQvj84cX7goR8OUYggBrJwcR2ClAJUmYEl9YEu52FDMEe2rIGtAgjy7Kl13bxWEVkSX4zFlNbSPZu4ARNH31YySRMLEXJsST2AA8oFFdTBfhNx7TZSaad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

From: Sherry Sun <sherry.sun@nxp.com>

The pci_host_common_parse_port() shouldn't check the RC-level binding.
That's a policy decision that belongs to the caller, not this common
helper.

Simplify pci_host_common_parse_port() to only parse properties from the
Root Port (and its children) without checking the RC node. Also change
pci_host_common_parse_ports() to return 0 when no ports are found, since
it is not an error.

So now both functions won't return failure for "property not found" or
"port not found", they purely return 0 on success and a negative error
code on real failures.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/pci-host-common.c | 29 ++++--------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 2ce6f4b66133..c93de5a10758 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -108,8 +108,7 @@ static int pci_host_common_parse_perst(struct device *dev,
  * dependencies and the driver may fail to operate if required resources
  * are missing.
  *
- * Return: 0 on success, -ENODEV if PERST# found in RC node (legacy binding
- * should be used), Other negative error codes on failure.
+ * Return: 0 on success, negative error codes on failure.
  */
 static int pci_host_common_parse_port(struct device *dev,
 				      struct pci_host_bridge *bridge,
@@ -128,22 +127,6 @@ static int pci_host_common_parse_port(struct device *dev,
 	if (ret)
 		return ret;
 
-	/*
-	 * 1. PERST# found in RP or its child nodes - list is not empty,
-	 *    continue
-	 *
-	 * 2. PERST# not found in RP/children, but found in RC node -
-	 *    return -ENODEV to fallback legacy binding
-	 *
-	 * 3. PERST# not found anywhere - list is empty, continue (optional
-	 *    PERST#)
-	 */
-	if (list_empty(&port->perst)) {
-		if (of_property_present(dev->of_node, "reset-gpios") ||
-		    of_property_present(dev->of_node, "reset-gpio"))
-			return -ENODEV;
-	}
-
 	INIT_LIST_HEAD(&port->list);
 	list_add_tail(&port->list, &bridge->ports);
 
@@ -158,13 +141,11 @@ static int pci_host_common_parse_port(struct device *dev,
  * Iterate through child nodes of the host bridge and parse Root Port
  * properties (currently only reset GPIOs).
  *
- * Return: 0 on success, -ENODEV if no ports found or PERST# found in RC
- * node (legacy binding should be used), Other negative error codes on
- * failure.
+ * Return: 0 on success, negative error codes on failure.
  */
 int pci_host_common_parse_ports(struct device *dev, struct pci_host_bridge *bridge)
 {
-	int ret = -ENODEV;
+	int ret = 0;
 
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		if (!of_node_is_type(of_port, "pci"))
@@ -174,8 +155,8 @@ int pci_host_common_parse_ports(struct device *dev, struct pci_host_bridge *brid
 			goto err_cleanup;
 	}
 
-	if (ret)
-		return ret;
+	if (list_empty(&bridge->ports))
+		return 0;
 
 	return devm_add_action_or_reset(dev, pci_host_common_delete_ports,
 					&bridge->ports);
-- 
2.37.1

