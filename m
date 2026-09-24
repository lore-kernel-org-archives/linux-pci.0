Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011044.outbound.protection.outlook.com [40.107.130.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127544119F8;
	Thu, 24 Sep 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269461; cv=fail; b=BPok3cYtfBdZqH4XM77JFZl1RfUz/uugM2U8kcmFV8gv8UwtHtpNM3IVTLJ8GnZYQLk62sjDjxkHXn4wtNj0XoVUCIFkLoROJZvCsJSISGkwaEudQoheqh5PuSeLNipOjUMsxYksCvvS+MP+2C/t+KF1XxSJBnE3tBCMSis1gQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269461; c=relaxed/simple;
	bh=0nbjkgTcOZOX+leJqt4I7uvz17mKMkI8mFaLdy/wghc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZZMiSZQQSmLiftRILubfh2SO+ggvTlp2YI7L5rxrvpr98qHr0mkFGoBeYZ2U3+SCHyHUlJ9/ykXkjQR9tZByyogNUC0k30AlZcz3LpwFyDf9B/gzSmo1i8lNxgXjkjhp/zUlLSooT0k4DpadN7yBuuCN0y5v1MrFUy9WvCbS1uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NZEnWzdD; arc=fail smtp.client-ip=40.107.130.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NZEnWzdD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/pWnUbTioozyOZjsQC6ruyM/ipmNVPvCSdWNlnsTTUz6iJNgAxez5EWaNNRQgnPEfJkFDjOwxZAhIL7/TK+xrbfghVhSj4tmLZ/ZnlsAv6Db1uQzaIDm5ZKG1MItpLzVvSkx4oaQ2qypGc3ksE6VWY0bZVf68Y55Y3O/MlqCL2DfIpZNrgbjMYqNDL3goBRqNhcAV2y3f++F2BTlb9+mUtLWXWu4arfIaaXNZVse8KeDJOPeJ5PkKzkcFuqbWi+f7pmnxKM8Le0mJCggSxE804E59iSEBJUIDDCEhyrkvXfGUkhCDDv9X1Cxs322MS25lEhAX37i7TM+wTZ1PVBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFSfCf364HDDIbyy0n5mTLmrRpPAAe1jnyBrMQQjCF4=;
 b=XQoqHCTjxfb57We/GLcH8WbvtCvlI0G7NqrVPhj+uSrjDyiTx2zKknm051WzJpadD3fTLYYd4nuKJLxs2ifoFR1m79vMhrXvjCsxRRZWTrwmbLRWB6KR6gHqtfOsi+RJ6/5sBTyw+vpcIcx7+JP1AhM+mV4ZnmY37GqrQmu+QSe6SH9egDYmL6LAoFafNZaehIq+wOjPInuZF6EtKccXjXxZCMuJL7UEP26fF5Iq+X2JDB82G7gfTBedua3TbFSIf2IUxgxHRLDqJIt2IDxjTj7drzij38iQ/KN1QQrQwy6HxLLaZNKDXXniKe42SnWE6eU21zt4Do2+qkkVcujAhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFSfCf364HDDIbyy0n5mTLmrRpPAAe1jnyBrMQQjCF4=;
 b=NZEnWzdDDgLd/Zkffzu8EKNTJjAfE/ZjMxS1QN46HIUOkipPw8jvf8MZG7rU4BwyjEHtPWjfG7n0PQcke4iBRbxeiE1JcYjqTOcOJNXDgB982m4pZ4sx1e4hJ7dewQ55vHL3iApALEQGl9iVBD2YID03+y+yJVZLY7Jf9GbDm0ZjYDrMMDG9jhloq60IrLWBF7O8lz3bx5/uXg3GbsYm5Id2+YV7RFo6ojagzaLdtJnms+yXoBkcPNbadxt31Cze1dqacTsfdNQwxy/g3xlFTbmaL6BO2xnYhZjf47WL5b5g5QVIeI26N0m6BHkCgYOfQvSVtLbV5t2HC53+jR+H7g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10198.eurprd04.prod.outlook.com (2603:10a6:150:1a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 24 Sep
 2026 17:04:13 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 17:04:13 +0000
Date: Thu, 24 Sep 2026 12:04:04 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH] PCI: dwc: imx6: use regmap_assign_bits() for conditional
 set/clear
Message-ID: <arVYBC5N4PCETEGH@SMW015318>
References: <20260924083429.461746-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924083429.461746-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: PH7P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10198:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f09a538-8884-46e1-e644-08df1a5ddbf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s+GJ6Zpnd5baPAb18TmYKdhKRYYzwrLUNqE+RoHLuczbvfJq+Cs2lHBrfVGxRbCq06L1jQ857fw2adAMIlbReb76fbOBiDB6TzeljG+BU7rStcC+khKXyY0Ee5x/hxnRsM4eWY/cCPkstFqzrF83mqGFgOS5zajqDWmps3/kFYjfQaabwbXWG0U363vGutAKP7zgBbVvB2LvYdxlKaCtdwBHmPjuFrGfZySLQlj7eJ/vU6otvNhkZOI+KHa/8aPTxNJhYBrinrRjecY3W6CwwjU3ASX4uX3RA5IaX0Ow4XadeUQ/rC/NPUGkA3lcLhL4IB2FuZbYHrKIHdGAxeaYXh3qi289WxYQCr92K/eYyAW1/5TIGA+YoW3kEdgs+gBSOQVh7xffENNlvkDvYzxsaOmlqpyIbEWvYy9QVaZsaDTRLgYIpH4QZFN93oT8Z+BRBLhN7oQcvbATWRaSrML9O6bI2wIyLMoF/3Z3yn4vgU5fYWPR8HOp0qaTo6eQ+p26Kht3WkPXpIfXLXxbNw2xHe9dl2gbd/mNNbwVHEK7byOTxrv8aPf3oKPub0w5ktL81UUxsmh21E3z18qP3+r5yQ30+oUi+nT35TkefdlRUUQGveAj375G10RuV6bERKI126sGoDHicfF7LKxTPns9hGuyQ6recvGxGF8KSvgHugI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XmX/LE0M7TwN8UZFUnO7cihPb2X9P6n/aQPrupFKhj3TFBIwcsvney2lGe3Y?=
 =?us-ascii?Q?LswfnP7POpuYS3SouZrTWrRnccAVY154LqoKNcO4CAnG/w4zTiyOnsielptV?=
 =?us-ascii?Q?IXmL51ANu+N6Vmcf7chwf1r1qiWEYdY9A43iKG9tvZ3hmaIQeA9LVj/i3Ud8?=
 =?us-ascii?Q?opr/FzsaozkLtcbKuO6DmxStDXFeCZwJn7fW2u9IPlXU+hf3bpiUxdzVv0kY?=
 =?us-ascii?Q?hRI+fUx3xEol+nUZvJr4A7M3u/g34wtkGbvWU97jgNwpu/YQabMM6TIybI22?=
 =?us-ascii?Q?p7QTLO9IF/N5NYuD5QRGJFoGei+ZDxJ8bnxz/xMStOqL8rFJApbNOfYIAM9v?=
 =?us-ascii?Q?9Daali3BmwQs5f/tP/6Syn57+V3+sUW0ksFpTl5L/KMRxQW374c7F8Q10cQH?=
 =?us-ascii?Q?/NAzwweHqneYoM2FT31730ELGl60Ob/UReY+6flFRhPWeZVCBNsauIp8cFcw?=
 =?us-ascii?Q?sRh3JPUtVj+AQZbOlaLjeeoruTt7uxQ1a59U3OiRhNjKBMuZOgTPDm60K0Gw?=
 =?us-ascii?Q?dq1ziIEc5MsfbN8annIBeF6HVwB3LErEQOcp/OE2nu0JByo2CgCN2SRYfp3Z?=
 =?us-ascii?Q?qk26hnrINMVE94TRMYvj+sJEzSKahRwmaPJ4MOM1f7fuGVzuerXpta6JGVzh?=
 =?us-ascii?Q?p4944ffcgpw4RqcFJ6w/5jhskLn/J9Ly1jU60Obq23K0FDjD0Fa03g2FF0WH?=
 =?us-ascii?Q?F+xvocyh3zdGzQdcrwuZF7A9LYIUkgAPJ2MnTWVzCc8CKwbwFghxumqDKNSL?=
 =?us-ascii?Q?/6oWtg5KZuPesdkYTFxzd37o6ChzB4y6Tx9q2f73mxgyD1SzlpGKcsPsShWH?=
 =?us-ascii?Q?nnbLBacfAs50iS7w9cG2qCXQQr6hzbqR7DFhMAAc/dVQbih1r0n87jy3pt8j?=
 =?us-ascii?Q?U/ULZRXDF4EgCvMQyT8jMGHI9Y+ftPbAhFTgv4b2cNo2vMNgYds1t3oFTcUR?=
 =?us-ascii?Q?Ee3+mgFPUq1Rsrxdk/dwgYg47ZuHMMhId8pj/FYl4vgpWgr0W7N0Mb2BP8Ji?=
 =?us-ascii?Q?zy9u5TuU1hUYc1HR7D/OI2THv3EIIasoAVQuNwcLYpCl8DZQy6AXI0JZMWq3?=
 =?us-ascii?Q?kYusJSYT9iKYiVgSi6Kc+KMneCU7wIbxwz4hvkpnNslS1jp8U8japCOCBSf/?=
 =?us-ascii?Q?QffqrDvXbzgMv0iM0QlKzJDjx7YiuPZS40Qzt8Ne/wbWfnFPlLB6w1BA13cZ?=
 =?us-ascii?Q?jppfCywl8jzcT/+7sxyHyLSjHq+f1OlpkMpWXBV6O8lnGF0/0f4Y0YOCCBRP?=
 =?us-ascii?Q?BzWdkT8GZwz6qXll9kjOnkikmdZywRCMdWuk0gEMkycdRAJjSfUnZs7EiVWs?=
 =?us-ascii?Q?31PO13nvbBlxFax/gJLNUlP7XwQsTPCJOouqN8EzVjmw4LzEcbXLr0ZmzFhO?=
 =?us-ascii?Q?XeZj5ppq5OFzY4UUrDmcAkghOIHRnItlwh3Y4Zj1nZ6c+kVgcFdIx0WFDqyf?=
 =?us-ascii?Q?VgQEX3XeEd8rGbQxIcM3YUxuugxumVxf3jKRhq9r9teEJAJTkwbGxvhMSOq+?=
 =?us-ascii?Q?sOk9XUMCvQpAFMEk5BHeqhbIf5UGB4HeBj17ZPMo6Yt+P07/uBuuwi6D85M4?=
 =?us-ascii?Q?m4PhKhaWjxk2Fswq5csn9wikxnqLwiu6r8hSKtb6P2njsiCBo+p282xSKXzP?=
 =?us-ascii?Q?ZrRwMqlda8yU8UyncNVf2tamHWZ7CHOJHOF6fpBmEwzbYdFkGFfov7EODk5d?=
 =?us-ascii?Q?UF8Km7Yvf73NTCawz/cdSagloQDmPN7zBriuWbLQ7pB2ZiGRSbMl4ZBOp5RX?=
 =?us-ascii?Q?pNyzSAvQ3enpfSVlrIUcOayoDZHm5ozong+Ty+09/wKI5Hp8T5vI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f09a538-8884-46e1-e644-08df1a5ddbf3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 17:04:13.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzttnULstgaa2dAnCSJUfQDH5M2xLvX1JPz22YqzaTbjjwGP+kIGVRgsVU/T9IxGrsaanutBMdu8SJEZ/P4d2msGZfMItD86ci6Vdqr+1m5z95UclKMWKpbMHF3IBPqb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10198

On Thu, Sep 24, 2026 at 04:34:28PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Replace multiple if/else blocks using regmap_set_bits()/regmap_clear_bits()
> with the simpler regmap_assign_bits() calls.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Thanks for clean up this. It is much better.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-imx6.c | 32 +++++++--------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 28fed010b503f..e2e55a88e0132 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -747,12 +747,8 @@ static int imx_pcie_attach_pd(struct device *dev)
>
>  static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	if (enable)
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				IMX6Q_GPR1_PCIE_REF_CLK_EN);
> -	else
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				  IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +	regmap_assign_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +			   IMX6Q_GPR1_PCIE_REF_CLK_EN, enable);
>
>  	return 0;
>  }
> @@ -868,12 +864,8 @@ static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
>
>  static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  {
> -	if (assert)
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> -	else
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> +	regmap_assign_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, assert);
>
>  	/* Force PCIe PHY reset */
>  	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5, IMX6SX_GPR5_PCIE_BTNRST_RESET,
> @@ -883,12 +875,8 @@ static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>
>  static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  {
> -	if (assert)
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				IMX6Q_GPR1_PCIE_TEST_PD);
> -	else
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				  IMX6Q_GPR1_PCIE_TEST_PD);
> +	regmap_assign_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +			   IMX6Q_GPR1_PCIE_TEST_PD, assert);
>
>  	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
>  			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
> @@ -901,12 +889,8 @@ static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>
>  static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  {
> -	if (assert)
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				IMX6Q_GPR1_PCIE_TEST_PD);
> -	else
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				  IMX6Q_GPR1_PCIE_TEST_PD);
> +	regmap_assign_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +			   IMX6Q_GPR1_PCIE_TEST_PD, assert);
>
>  	if (!assert)
>  		usleep_range(200, 500);
> --
> 2.50.1
>
>
