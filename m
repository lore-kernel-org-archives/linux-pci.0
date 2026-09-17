Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1134E021E;
	Thu, 17 Sep 2026 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660589; cv=fail; b=I5YJQwotkP1nX2IwjynjNZtyNIfcw6Nza2L52fxpy8ldNK+IuwCgviTBBbzWBXKqyGxO1/DI9o7M6Pa2cbsAZDNKiUMkC6I5d76aCjbgPijO8zdq4zuX+RNeiLztMkfjHj5fheZVL/xVxm7ZGz4960m9/4eBQhgQyQVomqQ3D0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660589; c=relaxed/simple;
	bh=Lpbh+q6ID0ZzNoYrpPAmpF5K5EJpD8ocYwfXSfW2TRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iN2C6XSPE9hjR3s9L9JbR9K6ETiAU0u6fRViVCWd3Ose5Ay5xlH5X3cxNRI2IvMcl7mRm9MZM/0LHLzYEzGF64B2xTk/lhYJqHDmuvHJdfW5cnSjY3PfXW42masZBT/2f7T2Yz98mRf1hGtK1GFvdmjlIru6J35CWr5LzTbykIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dAtSaNOp; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dAtSaNOp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvmtYiVvsmHOdNw55DZLDtDIFYrEjcJVPmdclWqC2OPUr0/lmjptbnuCpVNpr0+CPXQ8qvZFhBC+y0Fd8sh0vB59Gt2fsWNlcDtAy1RLexctL44MpHJpA30rYNJnrstszddjNpMuuIaOckteLO+uj+LJFEXPIMNSxIyfXR4kKrmJFQGQ/rkzzU/xQl+YFztgEMHZo52v/fNEvHh8zMY/WA42oJJhBbu9NepIdLoQ7SVFgGTH7amSBQvR2CfLGBWUUGadory/nP33arUS+yTMQ6zzkDhO/c/0JuQGi7VO3JFqjj53m5tZwq0E2a3cPkJsYR7YIodm3PsG1/EbjBtixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwZgb/y5CcQSIblwdvJdyc6N9VW/IX9eMISYq59jggs=;
 b=xT1VTesUdhrpvyTXNj9ifGnguON3s3TdsVGhQOSE0lNiCGa/exG5mdqzLOLbWTSC9x9IIWclbcv4uL2LKQBfj+ROCqT8BHkIc5VcIWoEUDBgCnPBOZ01SyVnD0f1VNtMPi9J4DfE26HzHF3P7+0HotKrcSWVf0V0fHujTcHcLE92G31XYigEtxXt2sp9e7f3uAr3s2e9zREHENGweFOLKq16ZPVzu2MPe659HJjAjuYMM4W2xZqXLWhpNzt9JL+H0W/zPY5aM5y/hgHhW08n6xSYqrsTJYe1HGzBHzbTccyVQRMzD/DJVUthkLSTGDNzbj1uf1rbMMDkJWTkPR4ZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwZgb/y5CcQSIblwdvJdyc6N9VW/IX9eMISYq59jggs=;
 b=dAtSaNOpE2HHj7Gq1dT//1AoZ7wTebvBXtpm++VtfwshB1ZTGVXQepn23BlHfYUxTOp+OISxzo+WUfwoZTq3CtAfZKaAOlVi5vMJ77mAdFVPRlRqd7eI4Ew8/NrD+CyjrgdiQKOT+ox+2EXpiOO4nkiL5kAlXb/5GY0BEMmOR0QvkVPGuAgdW8w07n4qbyY4ZrAGmpxsboiy3vKVNK41vHylgEn7hQ7Q2KnZRe6M/l3mWN+HMvmTsYmgfDBVqF3B+xvdoZvAxOCWIYUeYaIfvdCyOBtKdSH9szzx21ktDsHmnnJYxpv8RhMzWpOaF5hYWLkBoKONBycEMT3wlBT3eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB7127.eurprd04.prod.outlook.com (2603:10a6:20b:113::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 15:56:23 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Thu, 17 Sep 2026
 15:56:23 +0000
Date: Thu, 17 Sep 2026 10:56:14 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v2 2/2] dmaengine: dw-edma: correct IP name in
 xilinx_cpm6_dma_data comment
Message-ID: <aqwNnrPrXCI2hVdm@SMW015318>
References: <20260917103050.1020982-1-devverma@amd.com>
 <20260917103050.1020982-3-devverma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917103050.1020982-3-devverma@amd.com>
X-ClientProxiedBy: CY5PR22CA0020.namprd22.prod.outlook.com
 (2603:10b6:930:16::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 54722fad-dc7d-4d76-daed-08df14d4386e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|19092799006|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2U7IixsREOvJHplywi4D0iAtXrJ0M1madR3ef1pbEAovIxTPpO0EUo6/91FKz1FBp0dQcpiNxvrN2D1zC5qkxrggVuOUDM6emJOQI7atrJbMM37tOYkEGU8Ht4jHAE+Mji4lMWptfamQ0UwonlpuketwjdtS6bv5HPQ0rZurWyX5ybzP00TuULWh5MldQiHJEFyi81hyRbpuZyF39+USC61iqMS4TfFGOZlaPuX3OR4CrEDhHHv5bXVSAfVxKFIYCJdVrjM7y6bbSRNw6gTk1Jr40585mho8IqWuJbCsvZo/DlOUq7F967TdkdQ4QIkODIigDsXatVUWAERRPkAWwAG/Ou4EpBocU19yRVlGV6+zd4ZwxfOrFh0/Xp3OPgjqYLAPej4x5rzKsK0clUUddWB3lLhAx/nd6YJzctGltpsiBFWMlxDahZugVILe+eUhZdExLmeIwIAd6OrRk8/tRafM2pKSImFxSdFf7NgmzyDD5zarttlymdlOtdna7H97GDdTM9rBj7JkdlicZ7+q2RRivtYVtvZxdHifDWpPBKDu7KRUz3OjvQw+cQfmQ8whOREfY+6Ua9W4mssOJ4YGCgukydpwx/0geq9qS+Ilr7YSpoj1GiVoinm3NBuV1pDN/oQZKV4VAQ8WPD9zyO7Jmb7Czc+mlOvILLlmuBpE2NE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(19092799006)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aNpHJTUXhb5M70Pf1tz/SWIEQgKrFZZlwOfkLqSs4jNtJwA2YSIi/71LaB6u?=
 =?us-ascii?Q?QZkiqAndmpqmR/4NalwjUSDZ5oP9qP9MznxV1Bki08YhKMROeKS/K0DxmGje?=
 =?us-ascii?Q?oVj3U0ojHugN4/VfDpCHK7f08dEB0lu6wIgorIgZjwrOfHk86knOmIHwJiEa?=
 =?us-ascii?Q?L/WOwm1y8n95j1Dkrmp2Xaq1Su4yiCihw8Qv+OLUniOGAG8RnVgzNFulIGqU?=
 =?us-ascii?Q?K1kQ5NAWbPNp2oRz5Eyg6GgALOYesIJac1idP+vpaTJgn9XfwFEiYa/G7Kz1?=
 =?us-ascii?Q?QkLXO0uFo4LD5lFckSPb474yv4nWqi2AfNpYtm4xEWoBdGD9AwbPMVyZWozl?=
 =?us-ascii?Q?XnmcBbJEQMu/q/D8lrnw7yQ81ZyLiyn3JDdn5NkSUQ3Q62FdESjUvNVe+OMK?=
 =?us-ascii?Q?WaU9JYLIAZ/zSSxPjP46Rc6rOwbRz/30SQksmu6u5vYRhXWutSTdI4gFS4Eg?=
 =?us-ascii?Q?NL5loWkoumujNwHjATHyMr0GbSe9euocBd2MBqFZloZer3751Abo2M0uyqoX?=
 =?us-ascii?Q?80LUZsp6eT8bLZ4cSoWD+3FKhOaRhlLIeE8Uf3+vZVw1/vF5FVr/cNAAENUV?=
 =?us-ascii?Q?iIru7f2JfdIlWy1apb6I5aH+Ftpp53DmVYzHJlsiD7hyzSPyTUq7tBbHco5J?=
 =?us-ascii?Q?4xY78q6qHwU8hz6N5EFpcuUZYU6KmNxXr+ou8jLH6KI9uwEa2uRf3O2zxPdz?=
 =?us-ascii?Q?io79x0NZ585i1q9kTGoCTIWAz+dyG7HJo6pk4Isz767LZ/5a7vnGaFSm4wh6?=
 =?us-ascii?Q?eNANUmvS2yJaLrbFNXxQgAkwKSHgrfSH7uZE9+nBwTNNuCPtyfnIYlcvutpe?=
 =?us-ascii?Q?CTHojgWQQEUnCNRums0OQiWSm/jPOssiFpiLQc8orimou1KYTZ4XX/Yw8GpV?=
 =?us-ascii?Q?iua3Bn8kwmpZ/Y42Kus4w1JgefSWuwLNfGIZ5qSGzgxBj76XvswxYXe6taNw?=
 =?us-ascii?Q?oPSdzhc7EfstAEOa+V+KgeuEO8LkVU91Ica4clb9K8sKh9pTwkP7bmPUgyEo?=
 =?us-ascii?Q?rSxbJKVZ7/dHgzTqjWHgtLfXP17MXDfJMORCxejZgYcTNSecWC/r9O0k0EIL?=
 =?us-ascii?Q?zcTGotUJH7Ks9noYK6H+MK/zNQ9IDAVLMfV0VT0Uhzlr6h3YOx0W5fRx63GP?=
 =?us-ascii?Q?tHCRlpevOBeNBcCArSa4/Df9OsNVJGP4Grs2Q3/96TIKANvPqBK49S+UV0ED?=
 =?us-ascii?Q?8BU0Igmr1Ak7suZjMQbPr+tkQLz1P/uTHYptxmCOWxu3ajeIW7hUu1OqgD2O?=
 =?us-ascii?Q?kKtwKzX4zYf49L3uCthmRfDHCi7patf5ZdDmDxHmCL7zUlAgeOePsPeTvgqN?=
 =?us-ascii?Q?3+r9LQkbrcG2JeWJHzJow9DixQ18ayYQNOKZGGhm9tAPyRvuROcK/6pVeUKl?=
 =?us-ascii?Q?2ex9xw88YGPXfATTukjCUUex0/0ZOhY+0bCKjBTQ4peXTirGvHuwh4zXGCF5?=
 =?us-ascii?Q?LpW/sKW1hYGe2k0qQ0LFtIGzd6+/mTEF4s5KaMMelV2RUbA802jL3sJBpgsh?=
 =?us-ascii?Q?h3onajVTLZqN1DTysiHl8tWrXF4TmEfFfUjNqpgR4RI2kczzAVN1Hn+zpPR3?=
 =?us-ascii?Q?P5FHngSs1NyawWLvn4FomvEYl+zjM6d7wRDNwR91vuUDX8KDYZZngqE6xCX9?=
 =?us-ascii?Q?1AJBaIhDrlliCWJYLVep8xzyvHGU9EeQJOmAXMazrN3FGVoaL5bvGmdtWwfz?=
 =?us-ascii?Q?xcv766vu6eU4VJS2RcjyFvFCcAO2NeBcnBF3Klf8+6XEndq6LQNg73EUPAch?=
 =?us-ascii?Q?ClbMsflvUuF+1lhbD3fxyJhIyE1f6JpayjbJ73mVxJjMnDUU+K28?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54722fad-dc7d-4d76-daed-08df14d4386e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:56:23.3353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tufhDKSRAQ13lBgVZP91JKCsJyD8xHEf+KXcka2314fv1xnfTLJDgnEU3hGJ7s6gh/dusZWUAS+hIvffetj8E1VOTqLrmyYDZcXIM+ESvjw3xj75zGFIUkAdit1iOT0q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7127

On Thu, Sep 17, 2026 at 04:00:50PM +0530, Devendra K Verma wrote:
> Replace 'MDB' with 'CPM6' in the xilinx_cpm6_dma_data comment to
> fix the IP name typo.
> No functional change.
>
> Signed-off-by: Devendra K Verma <devverma@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v1:
>    o Corrected heading and body as per reviewer's suggestion
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 006dea7d6322..762a693ab55b 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -146,7 +146,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>  };
>
>  static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> -	/* MDB registers location */
> +	/* CPM6 registers location */
>  	.rg.bar				= BAR_0,
>  	.rg.off				= SZ_4K,	/*  4 Kbytes */
>  	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> --
> 2.43.0
>
