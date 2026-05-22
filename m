Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013048.outbound.protection.outlook.com [52.101.72.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377CC3290AA;
	Fri, 22 May 2026 03:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779421296; cv=fail; b=kYNr8TascyWtaSwwUywfH9nQ+wfrThaseiY2s2OeXtD1eVumN3z0oIPjuqRNk/tFVzG0BjDz84gUrBQXBNwlLcJIME9Cp91fm1h9wyNynW5L3im717nKoATRd4hgy9Tls60luxrUS6DxwnCgN+Mnsy/TORWwa6TNRYCwUpmZyYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779421296; c=relaxed/simple;
	bh=NIPs5Zfjo7IWmuG3g5+Y4aYKB5mEJOe6i60wzqtkS9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BCS53OCf4ZmXevyI8K950MwgirYvnoqYEsZEnybjN7j8PjcrtPsgdRsaAzNl3BXBjsrSo3r8noeoPP30XJjHmfet4tTMX32uLgOKcCmCfSdaUr3QJCDVvuDB3AASKt2x17mumjXEma/hfhK0ye4R/2ywW590+7Pq14+FP24+PiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qkkg6gFK; arc=fail smtp.client-ip=52.101.72.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qkkg6gFK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8RJkC95OE5cpYUJ5FXKD0+0gPg5S2sGt/hllQOIm3ugGMi8M+HFwL6ZKL1G1QDwH6fuGcNjIv9BYkSrAU4bhj2y+H8ued+fFAxYgQs4JfYhfXb53XuhFrOmnymoOxTeUDZzKR8dIOsl+IxoZyhjPUuvE8176340RvpR/Rjcomt0YZ1rBRqZd04id3og8Qbh6gpaLECZLf2PByo4CoQqFFPl4fmUlVMw4GTsyo1iGYZCh5pG8PvRbztD3iYODoIla4TiIsC17Hp5XS7tGhtfImjzbvXw/oRU8TtcStnGhOAnNzw8tiljLJWO+/1jLLGA649WTgkEsrt6XsJMXMRERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaxmNx66AVD7lrfEG/KZ7sHRBgle50nJWUpjovbkxyU=;
 b=boHBfJkq2C8EuDmpdhqFgniP8XhsVaDoAhFczYTe06UsgRusnllw3CO8Vngkd8Je3/62yifEFKQGyHRgexcMZ1WZxeB5Rlmkn6cv1lVPec+l/Vu4sxnkKhGInitSXxnLKYZqkfwlOisWZO5aDz/WWs1L4/6UMV8+bQ/k5KUEIqvgh7odce57lr7vX6OPzGQXDHLEhCboQnMDftUO4vm/yXlfXux0dYqSAdCfbfKbTJG27Jzt0LXhsLl2/29PSuKR3OrwA7tXIapkk6cJmYBAUOj7/XqHpCyh+n+/gPIWaqNcvc3ZbiBGJ16vQIksfaoZkCMcqsuwu07Jc54nL5JBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaxmNx66AVD7lrfEG/KZ7sHRBgle50nJWUpjovbkxyU=;
 b=qkkg6gFKK3Kd7P3k7rKmOGV1mZdmWR4uDyppKYo5TLYH//mUNLJrBaLzTpltXfe6mkmv31EjOdc0WWI9QoMyf2biTpzuJd1LQh9DOayrkvZ9xJ+wmBDcpq9LJUlrllWfPBJt66U8WF9Kqk2ij22EaysMK7U/Pes0Yxlu+1TtH1O/IHlUZ1V7xcmiuLb2Vdz1C/zDtnP3cWK0OEcD/6aK+RBU3Adi5aHjMeXKv/8crzBSHqVhMcwvrOe7o5vyiAwva8+CQrt2AmGBK4TaTbHQsA1GsDH4tmytStQhEa5IAv0hljXzJQpsUSDvrOrHJUItSmnaXrhxPmLRCgLrJFXaIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by DBBPR04MB7881.eurprd04.prod.outlook.com (2603:10a6:10:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 03:41:32 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%2]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 03:41:32 +0000
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
Subject: [PATCH 1/2] PCI: host-generic: Simplify return value handling in pci_host_common_parse_port(s)
Date: Fri, 22 May 2026 11:43:43 +0800
Message-Id: <20260522034344.1147775-2-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260522034344.1147775-1-sherry.sun@oss.nxp.com>
References: <20260522034344.1147775-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|DBBPR04MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: d2776475-f01c-4720-5692-08deb7b40400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|11063799006|6133799003|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	pP8/a8vnX7AQ3wAYOnPmKFX3Dgn02rhDZmT4umiChj6XtiReR3EiKeIGL6zMfAvuUigUtY6xOYxdKqWxJaUOE7ElnnvRB8QY5We3m42KtgJtWOKj0RkVgxEkMo50wUY71l+EE1B8sr7qZViMCBswly+zXYMMK59DMNRiewoGcz8Tv8v0SXTSfm5MiX0ebT3Bg3z1kUIVco/rL/y87qmAMc9BXOt/VhmRiyGLzUXcTwO9VOZ7MB+m5t7xcE4PDvZB/mx0SNiR3ElX7gH6xkSddcC0YgR+aXqyuNcJTnqew2EUuBKqsIRmYK1cttYDEETCNNLGdNEzYnmuxdmxzcrdGlUaoolxfIq/aGOw3HaetwLhLIiYeP/BgTH/rTodxNt1oaCeMgUu1aBOiX0wxE9neUwIerykuT6jssPPMCLRVP3qdXPoAGhDwDqFiLUAZg3powlW90LeWDfdWJCdac6sq9Umg7x3LopaxRMSGe+AFziSDk8uV8VpTc3InqZUYCwU8tPiEvDRQ3I17sP1YJ5R+MvgosNSLubgTPuikSQ+DxrIZNgDHQicu5bcz28aqI2oByQ2d6jVisgjNlPDsVhh4aCLMG38R7oIZfni/KuCx0Qj9oeFq/Z8a8WGH3V1Gt/v1dtBQU2f53SQS+8s+5bQkH4zQAJ/ydi1cXf+s+pdUMxeVONxcpILzIOdcCKZFbaNHZNRtPODbjGNGjLOMGFPREtFH/e5OmkWZTxHyv3nNAc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(11063799006)(6133799003)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AABHU1G2riuOapsx6EnyRy4UOTEqnBVU3AezIkKtoVqxetKMCfgTZvabddyL?=
 =?us-ascii?Q?Ir1jchuXCjTvO0nl1DiRYdkHQE5/o9IUkb0wIn94tUUnVR255bdMnLbie9mV?=
 =?us-ascii?Q?dieL4Sx4JOq/mG68LugDl/s1bC0Z2/89YVycmEqOrGDDTN4m657CsvVv4Fjs?=
 =?us-ascii?Q?ZIti1EetQfACb6/OzFZHmxnJA70jIu/KepSMoIfvFfsnwRMM/WGst7DXfinu?=
 =?us-ascii?Q?WUdQQZMXfm9JCQfYOvMxnOPqbTLDeLKP2Evxq3y8xndUYMa9lz2GTLp29AQZ?=
 =?us-ascii?Q?OUgPBI8OtGeeuQNVikExoU3YBE361yzMCv+hszsR+nq4pXOr8h/jdRaYYrAR?=
 =?us-ascii?Q?b6BvXLPEZw7UggqOX9M8jcPHAgHoUGp8yUhGTzd13/nTqsPRZ4Gg+3kPbw0l?=
 =?us-ascii?Q?VgQZ5EXaKcioWcTC3jSSDhUxMg8VZpi90m7Pid5L7MgejmoFF/apQmV1FsTU?=
 =?us-ascii?Q?TstJRgKCpN/Yw6yG8AgPLA8U8Tc3AOX9O+6W29zyxfimGqdQ2xRTuOfmwHKf?=
 =?us-ascii?Q?EAiL2TyscwGVRg2Ndmh0tRsiw9pMQ8eUzFzWvIjNiJePJSZ9/i4lemXz0/zU?=
 =?us-ascii?Q?NG5uyl7Q3N2jeG0CdtSX85GBZ95VKWRMbyt3sPKVPEKH+njVz9v/eOgkrHUc?=
 =?us-ascii?Q?qD5ZEtDbEf8jwxctRGVFQkM4mlt96WCI6WAHkO2lYxcUEJEjeCZhKv97/IZZ?=
 =?us-ascii?Q?6r34PxCTUkomzvfUx3r7pKQ95wnm/o9rkJrE7PfmqHg1nz+d7OdhYJbF5Re7?=
 =?us-ascii?Q?9LAvriXJC5S9ZeVKuu+uPuetMW+jjHxnC0L4z3AEM86bbLxp2ebA+z2oUdoS?=
 =?us-ascii?Q?HQ2jzYB7PHF3pEtMY5Ttu3x9A+7t5z6mhBSIdEFuoofpdhc4iRmAKFA6l6q7?=
 =?us-ascii?Q?yKXXzxhyBfJmgMWd0Kn+dh6ABlGZUfn0L088t8o3zlTXAfvjTTxlSo6VF6WO?=
 =?us-ascii?Q?E0ErVrbT2cXSxTDXL7kbREGLcRwp7Na8vxxzZUurODCf0BH4rU/WKsZSvk9+?=
 =?us-ascii?Q?GZ1TeKnGiJ9tPoSf10loWhGV95mYBmc5YFjOURR9VyVHlria2IVf/PM+pMYN?=
 =?us-ascii?Q?0QJBSp72IWxSXcK1ik4NazuHVYS73sDMinVQHi7UishrWorQgkAqlYrKXSwM?=
 =?us-ascii?Q?4sWPdMg7wYqA6Y6n3/CYlMC/ySjEblt4VQqpiOM4QR0uHbqC8lHBJ+B4bgox?=
 =?us-ascii?Q?vaUh/4Pdzg165Cgtwf2KOKf+Zjd/NvPqMV0Bf8/vwj5l1IcuCUt6DhrmB414?=
 =?us-ascii?Q?6XEeYTLG1sQnhvrmnPJoCF5Vq+khbKragvtjNKsxfYb9DVzic/UDUK3Rjs4I?=
 =?us-ascii?Q?vCZbxNoOpX1l9jOU9Agf/JscGBAwE7eRCwdDDoo82TsMzEa47VcJab1Hwsen?=
 =?us-ascii?Q?fo4OR6GHTeI056/gl62uyAtlpyMErxPM9EED6DIU22/cK0vOAPHniXNGaJtp?=
 =?us-ascii?Q?2n43u/qov5XfuTT3+m9Pe9rRHMVOCxMiZuKxQRwXYC7SSIT2FuddJd4CtI2R?=
 =?us-ascii?Q?NXJcf8E35DRKAHV5km27ORtoiSW0Lx5RKLya2lKvHZ6OZUSidmHGDXGmA8BC?=
 =?us-ascii?Q?P06fF372c79lQBYENfqEKYtlB5hEuQq7fx3EWUCPps1pk2j9rR+fpOO3wDj0?=
 =?us-ascii?Q?4I64DwaFCiQvJb4rsAXlHHQjTtX6JQ+MeOWnf0n4LPqrZ/Xzw/6n4dXcI4D5?=
 =?us-ascii?Q?Fyv+UCKYaRc0sbl6giAhLBooFvxnRjegbamUGLKLBL1iAUuRFc3SbexQMxXR?=
 =?us-ascii?Q?X0npf6erSDAprfVxwYsTnh70zLWb0yRTNy7JDbrbEnRdCcrNQn7n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2776475-f01c-4720-5692-08deb7b40400
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 03:41:32.3571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUob1WULLtsJx1HGtCNsC8wQ9z6xOIjqE+ciw12YYffEV6UKV9Rff2veqm21jPVj0K13boqUyAG6bUFxiF66Sy/GPDqb2d2+odXxwQt3cq28kTwMykQDSNU4cDS+YSQL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7881

From: Sherry Sun <sherry.sun@nxp.com>

The pci_host_common_parse_port() shouldn't check the RC-level binding.
That's a policy decision that belongs to the caller, not this common
helper.

Simplify pci_host_common_parse_port() to only parses properties from the
Root Port(and its children) without checking the RC node. Also change
pci_host_common_parse_ports() to return 0 when no ports are found, since
it is not an error.

So now both functions won't return failure for "property not found" or
"port not found", they purely returns 0 on success and a negative error
code on real failures.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/pci-host-common.c | 29 ++++--------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 67455caaf9e6..7ce5a939e3d9 100644
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

