Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA59291C10;
	Tue, 30 Jun 2026 06:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799485; cv=fail; b=uv33/e/FYuQMrcanM3GN78er9NdlGEdUhWX7aVH8ATstGWtfOKnzHbkW/PRFH6X0dDmiU7snIu9Updvc358EhA/I/flwCq/x7Kgq2Yk8eHT4XN8OJl9/c/slEroTdqSH+1JVN323LgoqDkLeML/GHi4OATz+MPIvGVDsq+LY844=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799485; c=relaxed/simple;
	bh=MRTgytEPTt43VWUOSFR87BvuGsmnbZ6bIZ0fNc9E2W4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JhETJ2J4pOT++7pAoyCM0/cNJ8IdTzR6RbiL0NO9yhJO/BruQ9mKPz2X+woMMgkEbF1eWr0/QZxwaHr3ZskIMt4bdoWsD3cUjsJa8GJ/m2Xa/OBWFy4pGD3X/jZjM8WuNswUzkZLyS0CowmMAhb/AjEqL27Nir890EmI9YkAEVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BaIj49VX; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BaIj49VX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAUzxyhTiMqIc8P/gZfqMfGnBmnBiOkmMR5UwWDbpC2P82YsORj9wsD1RCY6WrznioRI3EhfUTvpUXVbkyRmgYqxoE42qIciFIoE5R/kvxaSHP57dO5j2XRgAvNFrAGh7t21GaHJageH5azlsDSeol2+resXrqE5HUUPrGzpMEjqO5B+2VpQEeWnVKkcWO3ZYUnDsK2kz0GzrA3KZk9OLRtG82i2U5AUTG/WFiHcAfbfno5AOnOw3RO+6KooT78rBjPEJzIVWACYVV92tl0ySrkj7tU2r3rmGNUMGCh+GQfO9rrKeZh1WRIdnxkDTsLsXfuJ1ZENWgvSkAgpSCzq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDjpftuZZzLgruqeDlL+IP4PaJWgaWYemXuZZB7afB8=;
 b=EcoxHvrKZUcWZx4301U9txeTcmCqUl91cl+hlGjkiIo4a+4YErp3DEGRf4Psi5t23rr9O8j1C5gtlZ8mX6IeAQthF/QJRQnLfUmyKLJKCmec7ySrUJgNC5W7tr9lxaHAihvvgzEve6T/KXF2gxRSGISvx5+QEo8MjWM4Az5Ka5RFw5dUsxWVnjVv1NuUVup8PF3GJfjKhGz1dTJXEhuRQrxY/qXp1WG1OoeTi3yq51l8vdkA6t0mdYfCcVvjVhKhSAKV03G72ATrz+tFuezPwOAaEVIj6JjStfg41x3ICVm824R+E76WzWmeXKKRHZQy3Vb4lb8RPfa9MQw44SK0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDjpftuZZzLgruqeDlL+IP4PaJWgaWYemXuZZB7afB8=;
 b=BaIj49VXqZb5nURThF1SaOSxAtv94HRR5SVMFzsdf0BNYXkN4XpRFgHJVh0ZSYYWbO3u72CxSZzB9i59YktbkxwC5iuhu+5HfaCkmn5HOwDG6SNpmsKUHuiHEMDgOmVXxrulBDQeiE+TkvaDA002K1Ps3M279xRtXYyFe5BzU/NpyomrzIfM8IbQ9FBLYwPB3+oi9BsBvZlSnBmJ8vOV3PoPqlHcEbDIHaJU5nYEj/R0Exs6pTNLZh/2t/t2HU/Tsn+oUM7P0yQZ0KIDadadBs/BIrWh7Vi2MOiVP+2u4ED9FKSxqZzkM6m4hcyw6JAuuiHMVm5X4M8htjMasFe4Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM9PR04MB8748.eurprd04.prod.outlook.com (2603:10a6:20b:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:04:40 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:04:40 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
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
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V4 0/7] PCI: imx6: Integrate pwrctrl API and update device trees
Date: Tue, 30 Jun 2026 14:07:03 +0800
Message-ID: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM9PR04MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: c8739f96-365d-4b15-d3b0-08ded66d7887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|19092799006|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	jgGCECtYsXBI6mZEBIWFsGVy1XGZOBmUUKgy0a3AT2u+opVp7cRKXdqPVYkJy5uxRXkdeullh/BJJpi+QbdPrvfnse4oWlhTjB0l09IpfR0yjguSgYXcorY23CFTkspgmulm1H3++4zPYQmUt6PmhJD68Hm2jNQbVnYje6CP1MmCcKjKnWPSmfW+2MLyqyJU1Y9f5hWu3p8nqlG0YBV+YyxE5a+aKmCj0+P0Aq9pDrpjszsfeAbxBQKdbjtMUIU8BORiufJEw2BoZZvEfc7xZshnnxBowDzNOJfL947DafQDs03oj0x9ISpHS71URYRQvepSs1tOBaBUi3OeftLzRB5MLL7dUkuzgSQTOCEE8+5cImbIRfqaxi8W0efe5QjYmqo8LWMGERTZ3qmPF9t2IRbPwR/crnTb7tNtDxrUCLoxVRpnwNXVx3v8bbldv573zK2W6ZlOni9aeXJDl1pan9EsFkjfbTUz/Uf06DR+kNFjY2Z3qJ5t6QAQsaF9KLvGnM6rifCTGqjTUJlW6n6m1d7lFQMSegClGy3RqMWHPn6VAuP6RUFEET2cTo4PVdwvvGjT/ZvTlpJK45eQtfCgie2tvuP3Cxx1ZMt3JuMqhGfP78eI5rZSDfvBWwHDKS5PgCRhN+Z2KNHsXKS6rfSaYOaOuucqFIXndf+awWkkP/0qHQ7OJM2bqEWq8Pm+wOrcZ+d90AHT2LHKJ5tMiUVGXA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(19092799006)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LRaMakBHBb7wGBnW0p1dqsu/Od5Hnu3OQnNY1cEf9WvPrn+nQbcPpyjjc9Zk?=
 =?us-ascii?Q?nRa/OhsWfrL6mVlgN1uLhmnHNBIbbm7f3/6y8ZzY4QoPNQn/SVca8DS6qRBF?=
 =?us-ascii?Q?9DvGHgr4QhUjFTwuttncoU2av//tFx+ks6XyyY+k5Vri6TU9Z+Nw2mw/t1Xu?=
 =?us-ascii?Q?K6ka2aD8mKwJsDcUdpXR5OnFZJi+QnfFjCtIXte+xh8ex6qXQIjnk+fEAkaU?=
 =?us-ascii?Q?RHse6KFmstFS6GDcXmteBlg2xqNGfYZpd1HJz7jix0OR8ZpTGPTjJcQqeSzM?=
 =?us-ascii?Q?w99dm5vWXcXSsx1nJfFPa7URHknYVUOri7b5dyG3bsg0g7FPrIzCWGTSgKYp?=
 =?us-ascii?Q?dap7d0/bP2aX18hPCxo7RGA7OAjXWBXXf0NK/SlyxFE8KxoTIrTuwbB9CyYt?=
 =?us-ascii?Q?Wx71Hkdp0diCA+dE/XJkKJITLVPMpyJFOeovOVljphtsqAyCm0SZIa7tbX44?=
 =?us-ascii?Q?OlM2o9PL8Q6XfmJecWfrXowJnC0o9FeTZmVIYacuVD1e8tTsvlBqCk2GwSdl?=
 =?us-ascii?Q?2qDLfCbiqRBnXDQjAlpD0EhFvDwkjvKtZmpLjPOEW2z0xutf0ZbPCAmD0hzn?=
 =?us-ascii?Q?U+31UobHn7MqpAiYX/95ecP76OS62zr+XTQ/QG0km4FKGE6ua6cVIEmox4Fp?=
 =?us-ascii?Q?/smHc7wdwFF1rAIciABlN06rSCDt1Hxny6zkeaYqQZLkZeFbN7WqV/ddJyoh?=
 =?us-ascii?Q?zVOwaJCZ2HPkRisAUZAr1Kzm4FevS/lKXVb8xnRnazC4dtZyVOHctbXyme29?=
 =?us-ascii?Q?pb+W+6KBfhJDBVJB/QhLiP2V9jWUiEYfKPJjzcsh/+8bCo8zdsNkJ9B3FmCR?=
 =?us-ascii?Q?B1jCsNAi9I6g8kcQw67GEuYXz8gBPNrvlDj6yW48uBNbm3tKAxfLC89U4vSY?=
 =?us-ascii?Q?42iZSnk4i1mumyZBWFx77WG1gOmx75pJ0+Cgv4sohvxyB9TXIGoZWQ5YZgWK?=
 =?us-ascii?Q?mgN4qwMGvw7lRonfCWUiDNB3uQrB95lF1u7+hpHm8YyL+i4bw3rbUsNJp96g?=
 =?us-ascii?Q?THvElGv18ywGlEQOKpYd/V/IuvcUHZdtxzRbzQ6fPL0bCe+tDx76c84KgunF?=
 =?us-ascii?Q?UFVzTXQ/Xc+hXcYATbLAkQZztg4lilghVjs3NzZeIphnXGyVMxLUSA21vk9Y?=
 =?us-ascii?Q?hDwOPtyM5ttZW4rs78rdqqU9QzAy5pRzMEA2llM6BRRBU8aXqmahx3rUDkCy?=
 =?us-ascii?Q?K/vFB6FKRgxqGgWHxLTU01CWPHCKSu1OQDLZ7hFnUryX+xyu0gswMGIZbQ53?=
 =?us-ascii?Q?R/NlCLTyR1MKwCrV5TlqPaQ3hb6ZFYTOf3cOwtoWCw12eFrB3CjM/AyhVqph?=
 =?us-ascii?Q?KDkY4i6sLTYbGHGyivqjpJHdyBIanOlcH7FoOPFlH4bQr4k3QTlacucpWYT7?=
 =?us-ascii?Q?/ro8ecsw52cE2re+PH3mozFA7h/aufsStAVd8mgUtVhGoKuYPCwmMCkkl+r8?=
 =?us-ascii?Q?PGSTU4vNEZO9jlJ+b/qnWtqs9jatDYa34XiytoUUS21dpCX/3DixoeF881hu?=
 =?us-ascii?Q?Mk2GXVfnFnpB02759jpvVY5c2CjPJbP+w7iNfdv+nfVM7wpvxefNi5DylsPJ?=
 =?us-ascii?Q?Zv0sq6bwuG86hqJGA1b4B0BEWg8J9L+q+zZWtxAKdyuljCEmtj+yDSTdbnQp?=
 =?us-ascii?Q?/lSsq9rXfhwc2SCskRR+4ZaEhTfHsm5g4zWah8yVQV4KVq5gOughcpw5h8og?=
 =?us-ascii?Q?n83sTnjCSOIAgoScoahJ9BVl5qiotaFL9I9ukXSStrM/TiD+gmAkohPG+OFa?=
 =?us-ascii?Q?wrq6eZ1dgBMqenLiDAVT31slPmc5CRPinfqyyr9pPOGBTEBG1BPr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8739f96-365d-4b15-d3b0-08ded66d7887
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:04:40.0325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwWBWufnzkEuRS81ayJwihT1lMXtgFRMRAyaq62pNlTG9gQXxnyzD01FBJm3KXpGNvSHG+kq6D471IRnUy4ZdESo/Rlld4B4IZDBQzZJmJX/Aps2/5xWpU4zUveorFID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8748

From: Sherry Sun <sherry.sun@nxp.com>

This series integrates the PCI pwrctrl framework into the pci-imx6
driver and updates i.MX EVK board device trees to support it.

Patches 2-8 update device trees for i.MX EVK boards which maintained
by NXP to move power supply properties from the PCIe controller node
to the Root Port child node, which is required for pwrctrl framework.
Affected boards:
- i.MX6Q/DL SABRESD
- i.MX6SX SDB
- i.MX8MM EVK
- i.MX8MP EVK
- i.MX8MQ EVK
- i.MX8DXL/QM/QXP EVK
- i.MX95 15x15/19x19 EVK

The driver maintains legacy regulator handling for device trees that
haven't been updated yet. Both old and new device tree structures are
supported.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

---
Changes in V4:
1. Fix the CHECK_DTBS warnings. 
2. Drop pci-imx6 pwrctrl support patch as it got applied.

Changes in V3:
1. Rebased on top of latest 7.1.0-rc4

Changes in V2:
1. After commit 2d8c5098b847 ("PCI/pwrctrl: Do not power off on pwrctrl
   device removal"), the pwrctrl drivers no longer power off devices
   during removal. Update pci-imx6 driver's shutdown callback in patch#1
   to explicitly call pci_pwrctrl_power_off_devices() before 
   pci_pwrctrl_destroy_devices() to ensure devices are properly powered
   off.
---

Sherry Sun (7):
  arm: dts: imx6qdl-sabresd: Move power supply property to Root Port
    node
  arm: dts: imx6sx-sdb: Move power supply property to Root Port node
  arm64: dts: imx8mm-evk: Move power supply property to Root Port node
  arm64: dts: imx8mp-evk: Move power supply properties to Root Port node
  arm64: dts: imx8mq-evk: Move power supply properties to Root Port node
  arm64: dts: imx8dxl/qm/qxp: Move power supply properties to Root Port
    node
  arm64: dts: imx95: Move power supply properties to Root Port node

 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi    | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi         | 2 +-
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts     | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi     | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts      | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts      | 4 ++--
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts      | 4 ++--
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts     | 4 ++--
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 4 ++--
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 8 ++++----
 10 files changed, 19 insertions(+), 19 deletions(-)


base-commit: 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc
-- 
2.50.1

