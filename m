Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3504AA577;
	Thu, 10 Sep 2026 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055336; cv=fail; b=GgzwNQSinKMdsRrwUNkQipUHj6YyWbWlh3/PKtzJf0Rwnj+qkKjYtLjRm/GbrNOeQetJF277w4oUe5FcmX7u9M+75HGAnPzFBuQn5sRN/8DLA2fHMeDH9+w8Ln9vfiRZLz4Yx+GuJfztGQNW1jeFYOhfSHxgmSJC18Be27mz/Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055336; c=relaxed/simple;
	bh=fDQb9pxa3awaWLxpUINOC1kp290NvXPZR3m8TGW+6Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KTqq1gpNfvKvj6BilSiP2p69Z1KE2/FcOsUvqPInoanp9v3fJDpWEjfUcnbhVF1CZojIIV7U8kz6/6eogCVo1twExtCEdzeV7IcgLPcvxF8vsb0KLzl+hGryaGUkA7voIuz918LoAuXGiRtogB9UME9/iQ+5ZEc0AJqvykEZDJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gb6pMQlC; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gb6pMQlC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFQpStIxHc6JCGOIzPlveIam2y4t6LzCQpAW4EsRKJqaqyA9uEu+sQA/qyiURoPZxoN+JS0rVxG9/kJWRn/yxAfx0S3sx6Hu2K6veqvlVaZ6LsLcSKIMZTFHuztv+c3BS7qkgFU28kMLncMcHi0lA/jPRQt4k2bmLqkorY9EH5EfiLxL0pADapv3PZwLOXgQKRgDCZI8WNd8wQNMYWE7A6Bz8Tb8x6tCD7F/s2LJiBizgFhTKkx5199jnxrIdP77Q3QS/4fkIiKubY/idXc7JCdZ0HSZ8eby54P5nWGRFZ2JSMLGLfBDEq4EmGxuyjef9vXXCXJQtoZ5QwCePuWBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIpYEvehT1CEM0D38twvoOSM7txdCWPLHwkaegpEhpM=;
 b=Mz4fP6CAH0OXuYU2JFGhefGuAMKY2cFHh/iqJ+aZqPMru277Vsgo1+mRFmv0Vyxo9jhAHA7Hsy+OYSgJEW+ZJPsGv4n7hn0blaLndRXEFR7SDZS1wd+D7bO+Lk7OXzM7MWTbKBRaijC75jJAYBLeFlycbJdTrj/KtnV2Q8cQQ0c3EpXN7qYiStJjEMBPJhZp3yYC6WwSYHHjlQWonqKUWwkoU2sqVduuH61bwaiga9jKw8luhjQlP+E3haEuJQ2j6qwGbrXRGCqWt1+zsUNSXa56nxjuTWPPzB35Q7W8A4Pux6GGhx8wdo4KTq/iGvvWVFzFKPUOjGQpVpLywn+adQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIpYEvehT1CEM0D38twvoOSM7txdCWPLHwkaegpEhpM=;
 b=gb6pMQlC67H/YaaWeXJ4PVzq1lvGMZQQjCjwethdvuLZqn0zZ5D9PHbk6l5XSnd0AekxmAstCGUIYf+ufB8HnNDQ+fOMoceZQ4CcHnckeGYZpwJXW7D/OCUciJ/oRiaivNpkoM/AhtNDFStdUtbRBExG+095eRm6OqyRrnlrXlXVwvM9sT0MtfU+/eJMTf5yFsLBAhiUu0EfV5hekV6pxNoSLanFHnn/LBE7MLBaxgxsi5HsrwD5g0IC/jPNvyNZLFgLB7FwTNXCTKLDpbSUW+wD7TPUNpuYIJ6VsV96sr4AGTCIvTwPdprktF2hq0rAiY1ASqKN+ZJ3JYPvZxR93w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB11526.eurprd04.prod.outlook.com (2603:10a6:150:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 15:48:45 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 15:48:45 +0000
Date: Thu, 10 Sep 2026 10:48:34 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: hongxing.zhu@oss.nxp.com, frank.li@nxp.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v5] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Message-ID: <aqLRUlosjuQPUJ5J@SMW015318>
References: <20260803034319.992323-1-hongxing.zhu@oss.nxp.com>
 <ojbp5v6txcdvrs2hcrknai7kkb4bu6cnp6fometzkrf2mdzvv4@cepxzg4r7jvd>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ojbp5v6txcdvrs2hcrknai7kkb4bu6cnp6fometzkrf2mdzvv4@cepxzg4r7jvd>
X-ClientProxiedBy: CY8PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:930:4d::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB11526:EE_
X-MS-Office365-Filtering-Correlation-Id: 236889c9-961d-4e89-a3c7-08df0f52feca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|19092799006|4143699003|10067099003|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	1+SIickxKvfBh0w1eH07VIG7E+yEQmdgTJqah4jpefBAiLwM6t0UKCjnm8z8EpCUoyyp1SR+4Mk+nZ2fTWo+CGUEMl05e2SjZfXrjpOeiBeyAKkMYVlYfRiv0t3/4x2HfHsmNzSsUrcPRNVvERZSKZVKGAfVYZugOpkbzPxipUg9GUvmVpxnpeUQOn1oqVrNDFhlYjMKwzzwCbaxEN+DD1JLoaBR+LfYeAGl7yc8J5AE9pBPjuOR0/wvYxn1aSph9b4HT/6+4B7JKxNXj3v0chgTybOQY4Ow5fKMgqYso8794Zn4peJn8o6OtIzEpBmMt0S6NvK8X3orM5hq9WOOUtfYJ68WR0WKI/3Wy+DHMol7GlhFcWqF6ci9xPe9On6amUzv4fAD7K8jYIfUvB4rKLjADR+c46g+ldi2oZyFdNwB06JLsGiR36X67EhCOqIjdXmWx6fqkYZceBPb/wk3Wqz9Z8kyBMwyj5GQDMKVUaKNDmOZcv0PtHKXnD9w08AUm2FpSXolU6nn7Imx6KiicmMadeb5PUHHCUnSq7Ub7SUITW+HeCWPQEW+2fASTBXUv4Vi6x1cfV2kmWMfWrZ3H1dP0idYi7jcZ6Z4cCE2QYWNv/BBj8DKNTu2POZpdWkhvh0RQ3QgqOLbID8pLpkQBLNvLXE2sJz0CO5ZfdaIY7M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(19092799006)(4143699003)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWIrQlVtYjc1NDBiaGZyeCs0VDFFS0wybjF1WHNCK0VHZk9CODhjZzVYRnNu?=
 =?utf-8?B?OWoxUjcwMk93RGJ4M2Y4aS9KSmpsVE85YTVaZ3hTT0J1aHhMeTYyRUc3ZHJX?=
 =?utf-8?B?YmxtVDVGMlNLQVA1eGl3WHpONHJBQ1VJZGFaQ0l3cVlUOU9jK0UxVVpWWlF1?=
 =?utf-8?B?cy9VQXAybFpvLzBIckpEM0taZVN5cXhqL0hpbWVOd3VNbmFCUE5TblM1YW9P?=
 =?utf-8?B?dGFuT0NsdkVCZm56YjJ2ZDZmaG5sYWliTm5xVElvSUptN20vYi8rK09IQzM4?=
 =?utf-8?B?bmdhUWlWTm4yTHppd1NEczFSdU5aNWx1SW1jd2JVTE0zRGNkMEIzZkNoOWV2?=
 =?utf-8?B?VlBWVEVJU0dUWVVDSVc4RlFUSE9iRzVkekJiaXYzQmRoYzZHU200L0RzVG1p?=
 =?utf-8?B?LzNTS0tjemZmSVN0US9pTmJ6dGZqc2FFejZvUitxYWRSMWQvYk9Wcy9kL0xi?=
 =?utf-8?B?cThWYk4vZFY1OEVUYW1YM1hhUmhIc0FvT2JPQUN1ZC93MXhxc1Z0cmx3Rnh0?=
 =?utf-8?B?bVFYZ1Jya2Q5cVZ1dXpkNStHYTZrNGFiSzdVdjNrZmRnSXZJNHlURFhTcGlT?=
 =?utf-8?B?Y3NUaWFsYzJQY0ZLZERLUlBGWjFwK1piTmtuMjYwWWJjVUdYQlN6MXI1Q01r?=
 =?utf-8?B?eTk4L201T1hlTHhkMWsyazdTS2FMVk1NT21jTnZNcFNvOHU3TVQrRHpoR0dh?=
 =?utf-8?B?R1ZCM1lnT2FMOGNFSktWQW9tU1VsdUVSYUlKb1pyckhuaDNZTm11dzg2LzBL?=
 =?utf-8?B?RjV4am03dXAvdjA1QWI0RDEyVGR2SUdkanprREkzM3hZTG15YldZYnpKTlBG?=
 =?utf-8?B?WWlGbERyWC9udGNnbDI0UExBL1dpMTRvOEQxREZPVkpqMUJkUE9sQ3Fja0Ex?=
 =?utf-8?B?eUczeE5tbUpGU01yVmNmb003Z21QV2JLNENEUFRnbUhPZHlwb0tqM3lPd3ly?=
 =?utf-8?B?YlpBc0g3MFd4RlNOc2FEZXYzV1RXbXRtVkpvSGQ2TXZ6Qk1aNThiUWVNVFgv?=
 =?utf-8?B?RHNqaS92eDRUdmlIakhQY2xMclh3NHNXUGx6dUFGUC83TjVDMmZjell3YUFO?=
 =?utf-8?B?YjFncm9rbFpwdGd5YzhkQjcxV2llbm1TcFRDN0c5aWZzVFVMS0pjRG5ZN2lF?=
 =?utf-8?B?VnFMS1ZjQmNEZmNCOUgvQlpaQmZwbzdyVk56OE1hb3ZJck1TbkYyejdDUC9h?=
 =?utf-8?B?YjFwdlBOVmNSd2k4VXFVL2RLUlFKL3ZYNzcvZFU3V2xqekdvamhiM3JveEVF?=
 =?utf-8?B?Szk2Tnpnc3pqa3FweE1kVFhPN2c4aEdoTXI0WllNNE8vaXB2RXNCaUdKcWFC?=
 =?utf-8?B?YWpLRUJtbjZSUWsrMlVJbWxIZjU3TFcwWHcyMFlwK09DaElQSElQRVU1UWtm?=
 =?utf-8?B?SzlrZE41cXFtM3ZKakl4M0ZPMmlpMklYYzFwZEQwcXlNc0dkb3VEdTd6ZU9G?=
 =?utf-8?B?MlNzaUx2U1gwMysyTjVydGhTV2pXUC9zV2loTk42SHNLOGNuTHNsNUpQVmZh?=
 =?utf-8?B?STFBcExxcG9SbERzM0dnS0xYeUk3QzhyZWxoTDVEK25VQzVma0NLNFllUXYy?=
 =?utf-8?B?RmZNaEJmVWJBVnFqelllVytqSFVQZFNQdXp3NGxwekJTY3djeWNzQ2FROGZR?=
 =?utf-8?B?eXZrR3dLNFYya3U1eGdydHFTQ3JzcGc4aUJsUVE1dGRSUk5qNWtrYklRcFJi?=
 =?utf-8?B?US9tZ1JzZ0dObXVhMVBUSVdUL2VubFRJT2daWUtYUDUrZXpGbmVpQXVXT05Y?=
 =?utf-8?B?TUhVdzlhTEM2c09tZnVsMjFuck1IU0hrdUxhS3ZOaFE1NTFlaGkwR0Z4RlF5?=
 =?utf-8?B?QkdNN2ZmR3kxTTFobDkwYUpXRFF5QzQ5aUlsRWhPT29Na3F1bEwySVd4cktR?=
 =?utf-8?B?ZDFVZTZGalZRMWRzUFN5NkhoVFB0ckwrT2xPVEZ1b1h4Q2M0Z0RHaGVjWSta?=
 =?utf-8?B?UkZKTEdzV1ZOQmk4V3JpWnk5d25LcjU2dUtQeDFTWUVVeEVmbXczbHBBWnp3?=
 =?utf-8?B?R1VqWEJISUZ4ak56T1NOQWhzV1c0N3NPVVZKakkzTUdNTm92djYwN0doazRa?=
 =?utf-8?B?dUlRU09sc1A3SEt3dmlqMFErZllqZW1zZ3gwTFJuUzVVMW1aeDNFRU90eWpH?=
 =?utf-8?B?UjdrYUluaWtJd3laQUR1M3p4dzZxczFBRm1NYU52NU5vcjFibVFWVDFhZjNX?=
 =?utf-8?B?VGpMSVpVUDhVMytuZWwwUWhBcWpDbDUralloOVp2dUVmMW1EbWg3dXYxcWw0?=
 =?utf-8?B?QWRIZmpvUTQ1dlZySHlvRG03TkRYV2VSR25MVXRNTXBvOVlUaTJpdVdyZ1RR?=
 =?utf-8?B?a21XRDdYVGdyOVF4MUdTMEtqNDkzZlBqcDZZM0FjRlJSS3ZmTEZ3bGgzcGt6?=
 =?utf-8?Q?G9pQzHEWoCDMmdSwrgR4pyTi5mXqfjdNqcPie?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 236889c9-961d-4e89-a3c7-08df0f52feca
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 15:48:44.9544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YxOmxIUxMJF/qas5c8iQKQNAsGLWrm4dOjaBUNJ1KVVgj3583tWTdbJUjkr4H7ptt9NE7NkVIqlAOUvqEzy7RxEEcFce4rhiVw2CLdZGZI3Z9qnnSozcz81P1TCpNLA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11526

On Thu, Sep 10, 2026 at 12:46:43PM +0200, Manivannan Sadhasivam wrote:
> On Mon, Aug 03, 2026 at 11:43:19AM +0800, hongxing.zhu@oss.nxp.com wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> >
> > We observed poor bandwidth margins during i.MX95 Gen3 PCIe tests with
> > the default MPLLB_BANDWIDTH value (120). The margins worsened across
> > voltage and temperature (VT) variations and different test matrices,
> > potentially causing link stability issues.
> >
> > Testing with MPLLB_BANDWIDTH value of 140 (0x8c) shows significant
> > improvement in bandwidth margins across all VT conditions and test
> > scenarios.
> >
> > Implement PHY register write helper function and configure:
> > - MPLLB_BW_OVRD_IN = 140 (0x8c) for improved bandwidth margin
> > - MPLLB_BW_OVRD_EN to enable the override
> >
> > This ensures robust PCIe Gen3 performance across all operating
> > conditions.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Changes in v5:
> > Update the commit log refer to Bjorn's suggestions.
> >
> > Changes in v4:
> > Move the delay to imx95_pcie_init_phy() with a comment added.
> >
> > Changes in v3:
> > Regarding Frank's comments, refine naming consistency and clarity.
> >
> > Changes in v2:
> > Update the register name and bit definitions.
> > Don't move IMX95_PCIE_PHY_CR_PARA_SEL settings.
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 32 +++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 39790e66b98dc..3bc52c4781903 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -80,6 +80,17 @@
> >  #define IMX95_SID_MASK				GENMASK(5, 0)
> >  #define IMX95_MAX_LUT				32
> >
> > +#define IMX95_PCIE_PHY_REG_ADDR			0x3008
> > +#define IMX95_PCIE_PHY_REG_EN			BIT(31)
> > +#define IMX95_PCIE_PHY_REG_ADDR_MASK		GENMASK(15, 0)
> > +#define IMX95_PCIE_PHY_REG_DATA			0x300c
> > +#define IMX95_PCIE_PHY_MPLLB_OVRD_IN		0x2004
> > +/* BIT(10): Override enable for mpllb_bandwidth[15:0] */
> > +#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN		BIT(10)
> > +/* Register offset: Override value for mpllb_bandwidth[15:0] */
> > +#define IMX95_PCIE_PHY_MPLLB_BW_IN		0x2005
> > +#define IMX95_PCIE_PHY_MPLLB_BW_VAL		0x8c
> > +
> >  #define IMX95_PCIE_RST_CTRL			0x3010
> >  #define IMX95_PCIE_COLD_RST			BIT(0)
> >
> > @@ -270,6 +281,15 @@ static int imx95_pcie_select_ref_clk_src(struct imx_pcie *imx_pcie)
> >  	return 0;
> >  }
> >
> > +static void imx95_pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u16 data)
> > +{
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
> > +			   IMX95_PCIE_PHY_REG_EN, IMX95_PCIE_PHY_REG_EN);
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
> > +			   IMX95_PCIE_PHY_REG_ADDR_MASK, addr);
> > +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_DATA, data);
> > +}
> > +
> >  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
> >  {
> >  	/*
> > @@ -290,6 +310,18 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
> >  			IMX95_PCIE_PHY_CR_PARA_SEL,
> >  			IMX95_PCIE_PHY_CR_PARA_SEL);
> >
>
> I've added regmap_read() to flush the IMX95_PCIE_PHY_CR_PARA_SEL update before
> below delay, while applying.

Thanks

Frank

>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்
>
