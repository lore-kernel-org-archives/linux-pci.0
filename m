Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013044.outbound.protection.outlook.com [40.107.159.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F22F0C7E;
	Tue,  3 Feb 2026 01:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083723; cv=fail; b=JPmjja4cDLihOcW7W9TJpQzyS1TusAYAlB/jmnrUgaP8g63MCCiyxxgZEf14u9KIFGw4Lc3ouCfUbNmgeH8YvLtX0IgEgGw1KiiBv4KNKkAxDrE7sMdXXb1tNo2xi9kBSjxR+bBjfCNr6FYzaYEAnPj+IH3CK7XYgS11SElA3PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083723; c=relaxed/simple;
	bh=Ub/2CX5Ss/9q2kwi4xN1RR+/owV3AWY0umWwS4YqG+o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SWqUJPFgcMloFKtz9iwyaS4IcQiHVOlTsbqON2v1Y5jowOWulVEfQMkxXmm/bpFI1PvTHKvL2He1d6JBJZD6ExeRoD5a5wcxpc8rYMIJEgDB5IOZZ3ugsxp8qDk0lZknEtK6ZRNxYqeGYFn/BDiKUxXS5GD4W7HGT7zU9c7/onw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kVyNJs7K; arc=fail smtp.client-ip=40.107.159.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kVyNJs7K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0An2JWhPH5C69PTcUwE5rQG55uRHJ8t6nhXe+3kF1XW99ffoJY1gi/OT8Qqhp2HlLXv7VEhfan8NqGMK4JUJPNVhSG+bHuScFpMcpetQHAJEyOLioYcGk83DowP9uvZLui8nyXfSEwuNBqv3I/jJ2t+M0S/0f1pshC6MNfGwkl1D8if5G6weA9VgUa2oH0c40C57PhZT/JftYb0zhcH2DkuYzCPPNvL52fud6OkUsCzfydgPbeXAeYouqSCUY1GA1wWzu++GOoGEdysvpA37gIBbDjn811cpDFvOn7a5B5NgseQ9aqB7Avsi5837REqjqUp6IOK5iRTFX3bmLjARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AAUIdt/gf2A7VQtr+SzucXQehnd+7wyJMS+RnVjaLc=;
 b=zBr8zol3VpUKFz096VFu4yjoTF10bWH5ABg8f5MQvE0JvLxkcBT52Amjw9osA2F44T8mv4uIPUbgKKdIaOXIzT5Rk2N5w5YY/P8/Ilba9Bq6jalF5ctF9PZkyLcq66wVtMzIHi17XUgNZkTtuFrSWwWQbBoF7dL/xm1rodYgTWXRrnWybm/2jF0afSzwxWw6a53qHRU3ss8SI50oWNUj1wuVnamS+cg2G7H2mUdvZoBYtgZCBJt2Bl0yEEKBhOlxugBlFwc9G6PpGqRzwahqAllk8fGMYzKx+ym56U8O/4VWjMlBa6JVtKDqAm+RrkKm6w7D4W0FL0HYDqvm3T7hwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AAUIdt/gf2A7VQtr+SzucXQehnd+7wyJMS+RnVjaLc=;
 b=kVyNJs7K/XMobS3XKflQUzbLp8o8fW/8gaEr3Rl1f2V5sE9W/lQ2+kYbWZMnYSIBZRXOOx1HyYYpPgPo1m6DOssFTes7Me83GucFk7xlH4oiphGQIR3YAdYvRn+O/HDscEbGeMZItYxsXb9U3dswG7v6M5BUQZUA3+6Hf3/3axWInCgDOT0QYsJ+i+U57xQEhAtgxvdPxMkQ2PWA9+dnuLK9X2pQkeYH+++Hcx2RrSVMNEd47GIRfUNQxtNmae4DWIIjMMx6i0A0zA6kUVSyMA4roj8oFQTAGW+fNL5WREtdpNWacmy0gLHjbd0ClvdGW9SegDQSOBtWd7vQ/SITyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB10301.eurprd04.prod.outlook.com
 (2603:10a6:150:1dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:15 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:15 +0000
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
Subject: [PATCH V3 00/10] pci-imx6: Add support for parsing the reset property in new Root Port binding
Date: Tue,  3 Feb 2026 09:56:04 +0800
Message-Id: <20260203015614.2957479-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=
Content-Transfer-Encoding: 8bit
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
X-MS-Office365-Filtering-Correlation-Id: fae75862-f336-4970-1540-08de62c74612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0SKYlKOfjj0EqjDc7on0NYEETg/W8/TO5QG4jUctvD2o12HVLZPPR2F9I/Aa?=
 =?us-ascii?Q?wG1JYz7uXL541MCosiNW9FTwOIFX6p+hP/qsoqAjdjTT6AtZJj5Q/HrGJG2u?=
 =?us-ascii?Q?jOybm0cDiNejIoDBBzY1s3KIEQm6ojnWQ1VrQORQs3SXyGc8BpXOdW5GLyPg?=
 =?us-ascii?Q?4ymo4Hj1CLvxWbY5uB5RJRa8yUE/ppl/OYwr/jZzSGGtmgQl81KAyJwNs5yr?=
 =?us-ascii?Q?UhPGV5IeDs+zaPEh/h/dGu13ED/ZjMgBIkdMNmifzq4W4DACvy1Tq4SQHeEe?=
 =?us-ascii?Q?6n6MCwHN2Eh6pJWDgabpm/Vt6KaGwUPnjBrLIGyxNQN+DM/kwkdU41Iidlec?=
 =?us-ascii?Q?wx+rf+VG0vxpOw2P7qi7A58warzR0FQvGCed9HwAWlt0bjeFJ8SWFIPRjs3Y?=
 =?us-ascii?Q?ixqchHT6HiqpufuNUFzGMi1zFp1Q1u5mqUfLVyPUpbchPsOwt+t7Itl50fQG?=
 =?us-ascii?Q?vVq3ENx5aleYx9AHr0NdHAZ/afrOS0ufcx+9nARpq00cxZus1bAtzDce/MAe?=
 =?us-ascii?Q?4rovuvL/J8Es+Kxd2werY/t6zsQuLkbfU46UAr6RyfGut/BHqslKYuuMwUsn?=
 =?us-ascii?Q?FmHBs1j4bXaP/4osDVZIQojXcFwRZ/ueUC8zIEM2oKXYxxXhJIeQFEgIYj5N?=
 =?us-ascii?Q?hBmlWIGMyDOLkq7hEDZWhTtVCH9Po+PTIOcvQSDvbWE1gI7dootcz2hW3b+9?=
 =?us-ascii?Q?BJTYs3jnv3cZ9GXP6uWGmiY6K3QQ6l+gzufGQvpqWcUspbuIsaiNQDUrthwV?=
 =?us-ascii?Q?noQY6h9boymKb92wCKklg+eja9EVvAYUbkjHiCl5hpNaKNjQl2Dr40nO9D+E?=
 =?us-ascii?Q?nSG4JfNiUKFqnLUTjJ4JR9PkagsbSGCcuQeJh9QinInnXEyCXNfzSor0Qyil?=
 =?us-ascii?Q?eMO8G8P9wsxu+kzkMzgX18SFGoBSLKl3UqdZkC9OCMBMnag8bT+PQd8dOwei?=
 =?us-ascii?Q?nTCXMze+b7v7XBSzTDPksEGUG97oOFS9M1uABEjZcvNGgG1QoLCbp5CIIaKp?=
 =?us-ascii?Q?//JfOzRSFP2D7q8IKTcUyUY1knwWphtpZE6Ep2su+jPHnZ6Luu4Qq7Ot+cPU?=
 =?us-ascii?Q?8pdu3BjwzegMLqTLpbA0MyBvTfNefVOjlsWPmjYp8c8yhd7m4ipLyaHUcLzT?=
 =?us-ascii?Q?qg/sAAMXyk6NOWpPtcnrg92R91dCwMnzYe/ZstWS0BfaHaQYrxAROrtKuxfO?=
 =?us-ascii?Q?N6vnCj/T2Dljm9O0EBXIOUUBKnTK/tZc9/KC+9GIGlEslELPvm9IKTGzOAsb?=
 =?us-ascii?Q?jN6QLiPGMiNoDoJasFlUpYKYrxxL7SPDBjHLzYQeVcv0xs2kejoi33m9ocbZ?=
 =?us-ascii?Q?xcTJ/lE32Th2PASQTyg8xjF18vYhF9tACZ73vpINDfLG2oFPb/uFwCsJfCen?=
 =?us-ascii?Q?/I7KdymUS3I3SLZPTAM293W1fV9HuzDnvSll4WBWHWykjRo5LvQdSav4uBIi?=
 =?us-ascii?Q?idBEP1IiumnCantrL7sTh2/rlj4Q7ru0qnBbQynp/6VIVNJmPSgV0qUPxvLW?=
 =?us-ascii?Q?JWNsz+acEx+qA+65rYHAjVm9s3QZLfT9VbipKE0lW/7h0MwciuynVDexVyTh?=
 =?us-ascii?Q?5T1w5Yr6IGe+akhFAOcHXYywT+uBTBK7oYqrB/1Bp70obKqZofVhU23Q18lK?=
 =?us-ascii?Q?nBKIdlgJT6JJ7DalqW7hUKx7yWLCmpDs99RUdyJqX2ix?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qDbtfgIN24g+pLwGJm3+xV3Ua/Ph5kICYkHeTNs/RPtt1ZpjgKeRdoeDt24r?=
 =?us-ascii?Q?1l4yVIFvEyW0RXEIXeycmt+IungO5MZtN3qSOi9ZKQy+1IqQtUuGosAey7uZ?=
 =?us-ascii?Q?/Hnk/Vqx6Ijo4qhK2XxSUV2ClDGh3QEpKnG0YFMm2SIItVI+klW6fPI9cOvo?=
 =?us-ascii?Q?itL7f0BLw9L09OAvmjptd25fjXAeA4inZFI/3+uwfKVfIdLQSQBtAZWe9bWn?=
 =?us-ascii?Q?MJc2aycKA7b751/5tmKteMQuAqDYAWp+12LMK7AeS5QygVqdHRY+1ihtIG6B?=
 =?us-ascii?Q?RoGGwmCj9OPcBsjXXtezig7Mz0h60eglqfc5Lnq6ua4JpZWA1OQZhUgyB7No?=
 =?us-ascii?Q?AEjIwOUhdjy+md9+AMleeNU32CqrvC3m82e8m+5Nzdu+bBoCTDR3qLwt7U0q?=
 =?us-ascii?Q?0Kxl23cpfujhwL/ajEY4iYyhYy0XJ8yQDKKjFjpvgeELL5CERxTu1AGAQlF3?=
 =?us-ascii?Q?MiPRMLtUEM8r0yR+aQ8GTwQGqpDIiZWJIYPiNsltc/P39/pQlIo80LY1v4Br?=
 =?us-ascii?Q?pPYIzv8Bk0mIPR3LPfsMjlBdXOfx6ltoWnxz6HQ5OVitNiK50IXits3JpvNu?=
 =?us-ascii?Q?WOzQgClYGoC9LcXpzvNT7t04oMgLh39ibf2lNosGP/bpZVnLZaTPEdxyfp/2?=
 =?us-ascii?Q?9YDHNvgOhSCP8yrCw3ycTlV2noOY7vR0JyP4jPu3EjsvNSEPgHdTknIymYCd?=
 =?us-ascii?Q?bPZF6BGsdPj451UvbKQeTHAUAm24xobUS3qSdz3ooCZFSIcu56iMu2ZyoqY0?=
 =?us-ascii?Q?VlG0P/355o4whhQDo4XImufnX/a9zQCwc+GC9MaF5DsyesUT6oR9y9Mvih2f?=
 =?us-ascii?Q?1ApnAu4p5a0HNE/sbOg6Mwbju/DUEZoX0pZU+s1deH3cBDnMNuD9bK/f0qf3?=
 =?us-ascii?Q?wX9rW+iw6PQsbtJuEBF7T39D2QH9DJUYiFXNBG6P6JplP1mSZPXCQvorlW4i?=
 =?us-ascii?Q?7x5yGTiofVaRDixAMWx/ccuv8rw8LiYcJp0nwnIftq6fxWWEzCsCh2VaO/cK?=
 =?us-ascii?Q?RUkVdwinhlos8tt26PakXJSbF5St3D5xOsBDRdz5VOOFVAzcGhUd6qkOuWJo?=
 =?us-ascii?Q?mrvuACdq+5CiNdpEeBoWiOoe40PJli9BljtRn9SpJPegvjWUzQUY1bI2Fx3n?=
 =?us-ascii?Q?/fAghtZclR3XZYjov4kkCCxyZQyxBuYQVT23KY0wEE8qzFMkNqSJKgdozaA3?=
 =?us-ascii?Q?FSzDrby90DWce2Pd8b0cRNg8ZWFpeW2CfA00Gjm8TTl0k/Mcyj3v9eofgrGj?=
 =?us-ascii?Q?OFy4Qr3cTUSqmz1shSUgdXCHYCx/ZsX2j6WOz29ZtOpqvoLQyrGAqxl33PIH?=
 =?us-ascii?Q?twXnpc/XNrnZ4UKUIrRrch7QWvm1BkcFPlLQBWt+5KIYC6/IcD8H1/JukbSY?=
 =?us-ascii?Q?2b8qv1+O6m71a+W6qP6bPAQ9zOy//r3pp9/qaCeE61g2fsP73U1epts9aCKc?=
 =?us-ascii?Q?Nr0qMo4nGXQc3RzWpcc9aImwUSrDhYW5OTv2Op5oHntsD1gcj0B5Mp+JzT1A?=
 =?us-ascii?Q?/zhOTi0QUDkz7XhKnU8d17LNuvHWB2+NzaggNmWrX6og6/EDaKoaEDOVFneF?=
 =?us-ascii?Q?ho53f9hyvLXEtU0fZhnUMYkl16SWdHwzka8Az9ZegJ6vQi3mq4/Qf+RXHp94?=
 =?us-ascii?Q?4tcSkMEfsxOyOx1X0vYab8lhlTutAF+VrcgcCtJA+SbOxyJYIdEC9+4NURmr?=
 =?us-ascii?Q?+t02iiDmvbIntkFXWTo0UYs5S8iCnUBXuLpq2zC/nRDkD4/g3j/MF4K4mdBc?=
 =?us-ascii?Q?KXCVRdvSeg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae75862-f336-4970-1540-08de62c74612
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 01:55:15.7878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYyH5UbtjogPRjL4VJp5Id0ioIu43P61X+QsH5VVI+PH30wra16oiSPSA9cBMvOeZO/pHdITFnDrwJjzv3MRyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10301

This patch set adds support for parsing the reset property in new Root Port
binding in pci-imx6 driver, similar to the implementation in the qcom pcie
driver[1].

The plan is to add the wake-gpio property to the root port in subsequent
patches. Also, the vpcie-supply property will be moved to the root port
node later based on the refactoring patch set for the PCI pwrctrl
framework[2]. 

The initial idea is to adopt the Manivannan’s recent PCIe M.2 KeyE
connector support patch set[3] and PCI power control framework patches[2],
and extend them to the pcie-imx6 driver. Since the new M.2/pwrctrl model is
implemented based on Root Ports and requires the pwrctrl driver to bind to
a Root Port device, we need to introduce a Root Port child node on i.MX
boards that provide an M.2 connector.

To follow a more standardized DT structure, it also makes sense to move
the reset-gpios and wake-gpios properties into the Root Port node. These
signals logically belong to the Root Port rather than the host bridge,
and placing them there aligns with the new M.2/pwrctrl model.

Regarding backward compatibility, as Frank suggested, I will not remove
the old reset-gpio property from existing DTS files to avoid function
break.

For new i.MX platforms — such as the upcoming i.MX952-evk will add
vpcie-supply, reset-gpios, and wake-gpios directly under the Root Port
node.
Therefore, driver updates are needed to support both the legacy
properties and the new standardized Root Port based layout.

[1] https://lore.kernel.org/linux-pci/20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com/
[2] https://lore.kernel.org/linux-pci/20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com/
[3] https://lore.kernel.org/linux-pci/20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com/

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V2:
1. Improve the patch#2 commit message as Frank suggested.
2. Add Reviewed-by tag for patch#1.

Changes in V2:
1. Improve the patch#1 commit message as Frank suggested.
2. Also mark the reset-gpio-active-high property as deprecated in
   imx6q-pcie DT binding as Rob suggested.
3. The imx_pcie_delete_ports() has been moved up so that the
   imx_pcie_parse_ports() can call this helper function in error handling.
4. Keep the old reset-gpio property in the host bridge node for the
   existing dts files and add comments to avoid confusion.
---

Sherry Sun (10):
  dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
  PCI: imx6: Add support for parsing the reset property in new Root Port
    binding
  arm: dts: imx6qdl: Add Root Port node and PERST property
  arm: dts: imx6sx: Add Root Port node and PERST property
  arm: dts: imx7d: Add Root Port node and PERST property
  arm64: dts: imx8mm: Add Root Port node and PERST property
  arm64: dts: imx8mp: Add Root Port node and PERST property
  arm64: dts: imx8mq: Add Root Port node and PERST property
  arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
  arm64: dts: imx95: Add Root Port node and PERST property

 .../bindings/pci/fsl,imx6q-pcie.yaml          |  32 +++++
 .../arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |   5 +
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi        |  11 ++
 .../arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |   5 +
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi     |   5 +
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi         |  11 ++
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts       |   5 +
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi          |  11 ++
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      |  11 ++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |   5 +
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |   5 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  11 ++
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |   5 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  11 ++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  10 ++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  22 ++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  |  10 ++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    |  22 ++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   5 +
 .../boot/dts/freescale/imx95-15x15-evk.dts    |   5 +
 .../boot/dts/freescale/imx95-19x19-evk.dts    |  10 ++
 arch/arm64/boot/dts/freescale/imx95.dtsi      |  22 ++++
 drivers/pci/controller/dwc/pci-imx6.c         | 123 ++++++++++++++++--
 23 files changed, 348 insertions(+), 14 deletions(-)

-- 
2.37.1

