Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E0318B9B;
	Mon, 13 Jul 2026 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783909953; cv=fail; b=UuLGOGHoYRsK97YxfwRwf/b6iaxqgiUS2coD28T+PNe6KAR+eaXLbzJ/w7WSD37z7B/2AZeS2+aTZ7faw7rlqddgKURSbQmxNFvmXiAYpwLiPfkpHbMaSxEO02OVsfXlqMfo/kmPrx+NwI/gJVsqFsJUjB+S8+8sBDWSDwBRiig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783909953; c=relaxed/simple;
	bh=lxgQ+eU8nE3MlN3l0xUv9lnVo4bVfUgnVtFPnWMBct4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=atVzGJXhrAdvwcb4RxHnrkF/WmtOCb7hWikgHVcC/dfze4/PIn96JGsCj604FoFR419zN4dlb9Een2mfajdWUXoVmoxmlyPyB6XzZxPi9+h9p4VRk6+hFYqnQJJUaoNgMDhE4y3GWAA6LqzQAmstdAIQ1BnZtp92mb+BE4VF6QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JtLfQzbv; arc=fail smtp.client-ip=40.107.130.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JtLfQzbv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0Fk18qTPVOQ7weWfRfZcIbYVrp39+OU9GB6hVFK4KcpJhfMzjImGMDlnwtl4KjPIHOGx46YHu4Xp680Qeq/SkBNbhJkHhuq6Jjrj1lhyC28vvUN83AncFrUf9J5rM+K0sb8BtjKryRNiRVW/maqHbdYrozTzKnQX2zSds04n72ULqLSeJ9lxdY/+EsdjwIZtEkGokcuoQojQll1+1NCLtD8LlLbK75xZxYJOGxJSTufai6zwnCi8Cxej633G2sdER+dfljHYbMdWg064YLdlmZYn//ZaeNIwzs74NHpo8TECM1BvMonpcJ0gBa8Pe5tLoNlyOWR6U+O/e3lwLtzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxFoTxT5QQqje+oE/KCQbvRkw65a9YSAM9FGmAc5evo=;
 b=yhkog8E686MXOIUZbvCSr65se/J7NG6Q0YRU0VwHBLeJ0OvMZnSshBoF8qlrwgUp67ISWRRyl+QEk6wFxrXDYCGoszwwTnHQVhzVP2DapKkdfx5aoKM0UI0imjxC6kqcfkU3ng7+tUV4VIjXE5QQi5hFcUQ/3026/EdPLhNvgO0VFPeWCBf1cAJJmlyno3YhUPHQpIKuFpzyfNgpMrPpOA0NBSUwLVld+loZw94qE9q0zLQJwV+/OqC/ruw3fAQPwrGRr0vS1g11U8O44hl0xvI9beDxdV/bBtLQdQePxjK+ESMi7Fv/PRgXv925d/+aUXViYoRBRKfP2HGQ8KNqSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxFoTxT5QQqje+oE/KCQbvRkw65a9YSAM9FGmAc5evo=;
 b=JtLfQzbvf6qXcyDA/hr/3Qoke24QvNgmcKAP0gU9H1Eazh9mWGpqqfJgpXJDmcWNGPRtz5/ywUy1Z+GUNIEIOKS6mejQWDYj8SaL3HYatoHPTFsE5Mn9ENNfjGI5bHIS8+xPvF0+p0k+xVVT0hQukwhVLbU/KAv5fpjIjN+oSLWwFOh54CW7tf4Ko7jXlR/pP5V1dTvCuGGnD6Vc+1lNHfR1aYbVYyNgTfdEHZZUt7MbD8WzDrWbKFowhonC/Aqu7ahl1RAeZLMSqSSNnp3IRmfhqomjVWXY0Bub3Mpb85Ns2lj5MqnBRz3ueW5sIcQahNvziblQJXp4Zvrn90yQCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM9PR04MB8810.eurprd04.prod.outlook.com (2603:10a6:20b:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 02:32:25 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 02:32:25 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	brgl@kernel.org
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V6 2/4] PCI: imx6: Add skip_pwrctrl_off flag support
Date: Mon, 13 Jul 2026 10:34:33 +0800
Message-ID: <20260713023435.235765-3-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
References: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM9PR04MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e03a6d-dacb-4615-57ec-08dee086f973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|7416014|376014|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	GbK+idxBU2AqTNHc0ijRVwvtGaKoe+/oj4PhMpXB8v+rYgG9xiumSjR0Rb9ADB0lGKWEItqsm0jRYtUPSpGJqz8M4RXYYKYck3HJo6Ols54oIq1QeUmOpicsre11pc/cCEj8TAiC/U1i1CyWNQ5Nqd1pLAyv/thW5i94Eyeu4LQFn1uzQATGd7JlSVhSJRFMkWmfSjjIEy7WQB4uEu5cPlkjqbqtzU5WOenYVwivM72baYo6/iIpIKbqksm55lgcKG9CB+nAJ0/Rzsux3dh//93m5IuvNHPGw9wers6E/5/uznZfperguUCtazuADjWwGOf0qAZI7amy9aPc/qeZzvOYtRVF0BFm7vsRUXs4BSXzaid90z0Hs5Z9+Y/GwycDp4JCP8kUWb2JYPw2Pn4FWuGY80jf8+7ZCIJx8zQwYRGqBEb6H3sTyccs7qvE6lregX13hOxi/5II8Y32OftOC7rVzi1vjGkGW8tt+KYw8OJ2bGgiJ9xszoRaKDgMozMFKNUSlAYZtCid51VXW1xFV0qfKznXW1SMd/90wp56L2AuGm0vkv5ksHJu5hk6BNwfmqovmxAy265sEbNvqhA1PK6X6eDtydhsi3JR0FPgMAj0Vsueq8K0wnG/SG5Xgos+y5j3XEuMwFhrYnSTMg8JBBorXA7AKcMy5QZoVjOoRJ+7LEyeDVp9f9isQ4uI1+urjeINUiE2xAWosqe1jBlxrA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6tjDf3duxTReyQMfSUpHbplUjTRKQJrIDpKcbs2mJs9R9EViX1SvofVuqov0?=
 =?us-ascii?Q?zB2qiVjFrZKuGa0rkzvNhWXvWzN96GeIA1MvnlKa400deRetZFEPwTAmiSad?=
 =?us-ascii?Q?xiJ6WTpUYVznynFWHhL6TZRfRjFIeQRNj7KXIB1VMJq3xFRoe175+ErQs0GE?=
 =?us-ascii?Q?AVL9Lr+dVdqzEDGcow2s6nGUQzu7EIWsCWELlHSY+clmB7sw0cWSPC3ejSgb?=
 =?us-ascii?Q?7tlYNEQYWiNOnuCi3lqMFGKUwnDrZ5fS7BC7mL6dOgeLnyB829Dh0sDg1UoF?=
 =?us-ascii?Q?BBRy9nEW25CM8Gf7QH5jsFxOuXtYP5Jn3jFH7Afjp6V1QVTMamw3kJurFQmC?=
 =?us-ascii?Q?oY8cXxZSa/y53Sr95vl+nan+epGYmQbeGt7yHGYFa4CzGuGSb5vARHOi6gOY?=
 =?us-ascii?Q?dYd/59IK6sboOI9jiqhUDkx3PPMDXxPVsHsyZgajz3levZ5AJs6gxTXiy/Wt?=
 =?us-ascii?Q?6K/xcuSUZ2UX0+m/XvIZyRuiP3KlH0caDviZaBDhCVuykF1k+xjRC9UCCN0u?=
 =?us-ascii?Q?0GwoV1eE0B9r05t9b02Z3DkWfNHgdM5DogzEuJY6qbO2z7Av5z7b25OVsNWf?=
 =?us-ascii?Q?rUdkAWH2FesR/q1h8ssL3v3t4lH6DSGAy47PNPzbELee4Qtvhq7YAVuj0VqE?=
 =?us-ascii?Q?+8EffwY8u7J1efQfLByfBN9fXJjU+x5o5b9klP3q7IBBcZDsgSXia5M1lem0?=
 =?us-ascii?Q?46HcuSYuKRwHZlzMm4kYnQsWggdrmHHvuLAsjOCI3+1z0Y/Xvm8pzw/SXWpK?=
 =?us-ascii?Q?8g383E1vkqvzfYJQvJ2axKjCDE+CusBUXmA+Ex5jHpm3cJg+ornQU6bMRy8e?=
 =?us-ascii?Q?wN3o4I21J6pu7NYlo4gKuLPPheRinIApGJ3oMxvJvEJKUtDNmPieF2kSzrxh?=
 =?us-ascii?Q?C8p2TbOH+gdhNHqSQDT+JBDlgFqSwIFreuCH/0s0HP8QQWQSl3IC8lQHMH7Z?=
 =?us-ascii?Q?gMfAJ6URiYVVdJlNoal/RZN5CaHYN5VFz7PKRKIWziFkXrmBrgInZBgYGXPQ?=
 =?us-ascii?Q?RjWQANTFcMBMkq+9vJv6YZQF21mHrdEoukmy4w8UEBmN5VjXCHsbC17GoRSQ?=
 =?us-ascii?Q?acHVOH0o4QeQLuwzMwVYeIOYak1tLuw0hsaaUSrATmAsSO97IS010fxC99pq?=
 =?us-ascii?Q?BwEsDXgFi04nb/tk71ezFhopYUHusy0LwbsDZyO73daWVVJi7Rjk+6aaHe5d?=
 =?us-ascii?Q?oJjf2M9nTEWsYGD5FDirAFpbHegAe1AsHfu4lMRAKk7s7jQXrCBHBCReLwQk?=
 =?us-ascii?Q?nKW6CRMfIEOVpUt0hWq7OWVR4nd247C/ANLRlx3Le0jkXe+XKr0RJn16H29Y?=
 =?us-ascii?Q?bo+tbv5l36YigZjbtmrkeXfOCWJB2mRx5K/CGhXki24VhSQrLdu0wyrCN/bM?=
 =?us-ascii?Q?0ibzslQtZ1iInBmHXbmd9QXY8810rdAnkyiFa2iEEdOFsRR/nivXbV2Ru9kt?=
 =?us-ascii?Q?qnARgI/Dzd6fChbfHis94Wu4cl2JjPubK1HrMWbJ60no7g4zMpDC4v8FJyR6?=
 =?us-ascii?Q?t6xGaiUtsEBft2bETJj0c3exq/pGzJIh5yhnLbOSWQgHnS/XvWqCWmD45egG?=
 =?us-ascii?Q?IAEozV8+zf3rdwSWOaOjF2E/mNGqIq2R4sFb8G9Tz6S4ALo1A3Uqnas1Waju?=
 =?us-ascii?Q?xMxOpLsUoc5B+zdu7jPAbYg/P8KEj+d/sYmZYLPOD+DV8kSDz6KjMo1EWndU?=
 =?us-ascii?Q?I2ab5aBCplTWuOPchGU9XxvLlNAaHVQjbRRH7qMMRGPs19f/H4bvWmwpnPbZ?=
 =?us-ascii?Q?pLuKEKarmgsqRQcvVx3K/K84CE7VYsFow5vjZLC42P+P5uuwijWH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e03a6d-dacb-4615-57ec-08dee086f973
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 02:32:25.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2ffq1h3WNsngWlR4jQRii+ZsAXXC7eHUeVnVzG12fxaEXi1JupG9Y7ghFO1IJGeAK408m3pwTybOiN6j5Zut4lU+tZ1MnA6N52joZBSGUsGLNbPL7pEjqaGiLEDd2xH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8810

From: Sherry Sun <sherry.sun@nxp.com>

Use dw_pcie_rp::skip_pwrctrl_off to avoid powering off devices during
suspend to preserve wakeup capability of the devices and also not to
power on the devices in the init path.

This allows controller power-off to be skipped when some devices (e.g.
M.2 Key E cards without auxiliary power) need to support PCIe L2 link
state and wake-up mechanisms.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 92f8e4a299e8..afcf3b6bf3cd 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1382,10 +1382,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
-	ret = pci_pwrctrl_power_on_devices(dev);
-	if (ret) {
-		dev_err(dev, "failed to power on pwrctrl devices\n");
-		goto err_reg_disable;
+	if (!pp->skip_pwrctrl_off) {
+		ret = pci_pwrctrl_power_on_devices(dev);
+		if (ret) {
+			dev_err(dev, "failed to power on pwrctrl devices\n");
+			goto err_reg_disable;
+		}
 	}
 
 	ret = imx_pcie_clk_enable(imx_pcie);
@@ -1454,7 +1456,8 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 err_clk_disable:
 	imx_pcie_clk_disable(imx_pcie);
 err_pwrctrl_power_off:
-	pci_pwrctrl_power_off_devices(dev);
+	if (!pp->skip_pwrctrl_off)
+		pci_pwrctrl_power_off_devices(dev);
 err_reg_disable:
 	if (imx_pcie->vpcie)
 		regulator_disable(imx_pcie->vpcie);
@@ -1473,7 +1476,8 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 	}
 	imx_pcie_clk_disable(imx_pcie);
 
-	pci_pwrctrl_power_off_devices(pci->dev);
+	if (!pci->pp.skip_pwrctrl_off)
+		pci_pwrctrl_power_off_devices(pci->dev);
 	if (imx_pcie->vpcie)
 		regulator_disable(imx_pcie->vpcie);
 }
-- 
2.50.1

