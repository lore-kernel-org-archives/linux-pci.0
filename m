Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795454411;
	b=wq+ijmHQlxdfhtL9WQAC5LVOX96DqIXp+dq8PcA9wkRgWK20UIXusFB1Gyo2c+jmLpYD
	 5L0AgmXNdFVsjM5u+2T5m/yZhJY+7DN9xE6TzDLIuLtTDZ+Ekom9fmmylbA8RZJioMqAB
	 sx5GFSWhnPYfqUWzz/Ci3ei8+0PSDqMHk/+Jtx3kjbpkolLTvV0tcbXGIppKyG9Uuf6Ks
	 Ay6lrbeE63hlkJx1IUI/d2E9nTvJ95j8Snrs3ffiQubFYPCmIgTK/kWFrnOyhixtP0xcq
	 8g1lWVB21Uo324l5EWOhR9Kc3BUPXZULgYA2LUhJMIJkung1Age45U1KroX7AQW+duA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454411;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=M5FNpC6FckTVPxyfc/j2NtLVLthEzPKRMZVYL+JwMcI=;
	b=g0ixDsbdEShaY9M/ynTgisn8f+40hYuwQatP3nkOTn33uSLc3YltAtXsDfLTqc8QYuBX
	 tVB19Z8HGB8kLWE1mVrI3xgWc5guJ+C6jPCt2SHSUFhaB2BmzHg8LkSVN2Cpa+A2VJFmD
	 rTIqJCuJ6Xl1Ix0PG2kuwH8YWW6cec1+ZKP4NOqgrk6qFpdI0J3jiw3+PKagCiEJSSEu0
	 fNpNi0fJzaK3HcLqIyssplO/o5JzqlopFGBtK2Dms11in3W8rBDoWSRxVT6HoxkWnVvdW
	 ufOzWBI+EE11r9Cmy0dZWTX79dh727xjGv8pTsLcpPUP17b1rDTmq/UGRM1u+I5vmKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kk+TSNIV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.15
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFC7606A31A;
	Mon, 23 Nov 2026 17:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEFC7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kk+TSNIV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ME5xOxFCGIZ7IxymCds6TL4ceB0FwkvwBIka5wjOKV4ApTwr+Upt4gdXZuRPrRnygW1xAAJyu1erVbSkVF60NPczWEeQM8sLjT8pXks7sFTZBFgZRiNzhwBVGol6GUmpCWI71+3PWp5vMC5vapLjXp545FTkxkuFIa4BsDnzalUntholeFh6EkAPyZhO6c55m2XYK3vzXAJxu6+L5yfU+T2NCQpIe7pXM/68b5jOSxBSjsND8su91X9Qx5wB0phdmP6+5cdPW1KdRq6P8SM7DrYMP2uwoVtnNgsYN5RYmZAL+gp386TFV6fJDFaQu6FcyP+fCTYOODoQnO9Von4nrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5FNpC6FckTVPxyfc/j2NtLVLthEzPKRMZVYL+JwMcI=;
 b=t5c64P9yXmILIkGelvvbKk5edJETTMW3ZNjDgz580IkAMAZsg9HgmpBr6zdEwly2ugZUGXNQCaib3O0WUB1rKyDup1jzm1/a0By0CAZQA+Kdcp2y1QmYhqH9kLYnKfYv8afGy8BV/Oe7DzCgRBgZdLVG88RF3zki5v0tu4glDJddfYaC7m7e5H8JbwSCgEw8NQnkcZjp37WCRTtXJE0bk/bczAZ2YCCnwsiRtZkqgA8z0whB3h88X6ODJgqBkCiWVlAXWAVW8wnMyzMvOL+ANJigxPozDsCTgD5LDPYcWTEPTrq+J6VmdQ4+gVgMoB5mG8LwbiriJ+ZcN3mgcMhnSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5FNpC6FckTVPxyfc/j2NtLVLthEzPKRMZVYL+JwMcI=;
 b=kk+TSNIVV9M7sgTGTVtYSGotkadCTQe6DVKjaXph2ZsXYFFO8NtIPGVXeC/58DusWwRUzzuO2x5Th5Q6KrxJ4dLUnLWYvznv5o+zjX3cYimOcEOfXIlWRieUy87Tkopl1U5y3eb9gEBQGJkNk69C0AtccoCA8gQPLqyXx08Rm2qLaZajCLpxZTfb5Y4Pakg2jpLEWW1VhOmt1kL7JFV5MRWrSCL6kZqYCgx9v/0CFRvuhXXaF1YLf33rCZzYblDFcKJs3qb+4Rn/zFj1ZHC0oYkKV9reGvdxEvdhR2K2r4K7O/Vdmd90FnC4WocNkJhYJ5ecESpw/Oo8rZ4MUfPw7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DB9PR04MB8495.eurprd04.prod.outlook.com (2603:10a6:10:2c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 17:20:05 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 17:20:04 +0000
Date: Mon, 23 Nov 2026 11:19:53 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 10/11] bus: mhi: host: pci_generic: Add support for
 Qualcomm Nord
Message-ID: <awR1uXERtCij75xj@SMW015318>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
 <20261122-nord_ep-v1-10-6d8839ffa9aa@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-nord_ep-v1-10-6d8839ffa9aa@oss.qualcomm.com>
X-ClientProxiedBy: PH0PR07CA0074.namprd07.prod.outlook.com
 (2603:10b6:510:f::19) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DB9PR04MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 3481ab83-7753-4448-426c-08df4986032c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|1800799024|23010399003|18002099003|22082099003|6133799003|3023799007|56012099006|11063799006|261009223027099003|4143699003|261028144727099003|261026140227099003|261102123227099003|261022105027099003|261022075727099003|261021121427099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	4nFySNTC9HsPXZQ/smfVWVqznvYW7MdyCMjaQLPmv9Pk3sDPdN8lSCsh01ZjrEf53FbWnU9aAmJWEait1mBzdNNzKFO2tCm0yelS5eXxsA8neXuFoECIsUSZ9irJvuW4Z6UAJCHqYw3fmvVXguD3TBLD8wC1CyQ42H5W4sas40am4iTZFNNmmiVhI1J+dE24KZbNi4qaRzkOA+j6JgtLQvUQwaaMy7THWL1DdRlExQF+PaWSDY6sYlzzXicd2du3mFNxlz3THzuAQp7Lw2qJhRYwKiURNeYu+5BGzdPYgShgzT5lGatbQHxWHwy0pJRCaiB98xnZElha8Xqu+On7rLU3TYTXEEguqp3NIzadyeLOlSaDJ2nJhq1NpDFF//HeijcRi6iZF6xF/rKVaB2GBHnFNIdKKH2nKPChMc0bl0u3UIqYWF/aiuwOgEGlhynSW/Zk4fV/WMORYWZXQ3mBA4ohBJJ8y1sCWtCBHChI7X/WDHwovMhPBjuv10gEb1+jWScT4HxstZd6srFfeMR28C0VNWhIDcSTrwjQCDml4HTDirjlv0Xrw/Ts3Gn0gXoCL+B9wa83sBYYuev8qrGOMG0vt23vndSfV6j6ie91289SkRs96TOJhZuGcw6tZl4T+EDvVTUz0I77bt5tcL57hZJPlE5pt40LP5kACEUZ2/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(11063799006)(261009223027099003)(4143699003)(261028144727099003)(261026140227099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1OSHH/SQnZ4Z7qNskKwF2dmqLfjUNF+6Rc2x4NzwBpad0RyHdvaEPZne5L5C?=
 =?us-ascii?Q?WsfGMkVdYuWKNYMO+RoKlKyAGS/xddiI9eX3Ff/wDIBmd+Qw2jovdjUe9hlr?=
 =?us-ascii?Q?v5T2FSPhHAIcKQ1RYbftkhAOCu4D6e5VvMeJuR4XHV0T5Ak5n9aMbKrDSoAN?=
 =?us-ascii?Q?gBVKeKoCrd02yYCBMVMo924PzJf7fmeQOxJAzplDWAROrVu58FB7wnSMmQqb?=
 =?us-ascii?Q?N+Jeu4Z3uovSakONf1EV2W056skBI1REif8GzfqdJdFZUwgsdiSvdUHPB0dJ?=
 =?us-ascii?Q?Pk1899Mj5nckdTvdh1S3XYvcHmVUA5V4sHGNKC527mKgDVH0PpRP1HxUNl3v?=
 =?us-ascii?Q?glqgwdEjhrrUGguXL7Cwz+GuGOCphZ6i+pGb8PU95v6VZOSK58cap7XJLcxh?=
 =?us-ascii?Q?uSQHUA3M2OZttmWPr0UVgsHv4Gc3+lxdcuMIBavGHp56DPDrGnfrPY2OVI7w?=
 =?us-ascii?Q?XVAEk90NM7XmpJf9hPFYv2oknHXF88wo30NTAhBvb0BkGW5SUh9elNJkHKCs?=
 =?us-ascii?Q?//WqowCRjumA0olfCcOgVfst3w0bwk8E8Eb0O/GjfM3wh1PKMVnB2WcrH3xA?=
 =?us-ascii?Q?eP+hIjMIHZgoFHVgUcklvfD4snCHXhhJUfDcW8JtG8lm/iGWVlDsLSBrHP/r?=
 =?us-ascii?Q?7mIu/mxPnNDMD3oE5h3jH9+Q4GPK6kCKmXs+2FS6NLiBI1SqdlT2kJ3/7pJW?=
 =?us-ascii?Q?bjLckqWnPwlOG7+fYH2UFHTB4smjQnLYNl3TQ5eVu8+NMIqgmKilq7aF98jw?=
 =?us-ascii?Q?POoWYoW4PH+1VepzeFyAI1coKcm7SEBhJLW43Nz838oJCzU4qKyXkc7k1w2+?=
 =?us-ascii?Q?GI9hFAmPTdSQRajvY2b8Khh3JQ3JPYywGHgAc0txNKlcs65ogMwKPhXxrAV+?=
 =?us-ascii?Q?ilaWaJ7M0+Mvde/tmO6014KK+LWt0PH+FKDPzgvXBe0aL68fbQ4Lg94C73+S?=
 =?us-ascii?Q?9V/vrJ4lAQUpgnU/DalYmeSphp4P8dJ7gG289n1HcVyfp9VSX76DWnzEsYSh?=
 =?us-ascii?Q?j2+GUiiFI6qCEvDhd1DQdhb0xMkHbwMT2/su5dgYAm8hcl48n4yZgIfsR5jk?=
 =?us-ascii?Q?bmmOPMacl61QebgdkSHjrASvfY+m3Rpzpdgt1izSo6Nis7BPNAHW4lpSl5qc?=
 =?us-ascii?Q?aUULDP8xeWa5xMQmgeXVpkIzMHqjUsFoHwc3nhKj1dfQ5/NkeHZNndC+PkfM?=
 =?us-ascii?Q?fofE4NRY+Eox12jFX5Awnd/k7SVVSnE9+33nnjwn/b8SCA4CuL30/AHEJsLu?=
 =?us-ascii?Q?6mbraNjtmZXCRrHzspCf8Jn9RjuIaWmw2mSF5GME05Hl4ZWknyS4xF5x9SgA?=
 =?us-ascii?Q?4ttgLW/kzpNqUZBqnY1wQStKZZBhEmSKgV2FYeic0X3py25DEANXNPlEMrNP?=
 =?us-ascii?Q?ZFNihEnuqV+cGyZm/qutmmgHUXSBIfYmVsxYgi9oPouIpe9R6Rj5cCsh8n0F?=
 =?us-ascii?Q?yg/FhXK4Z7gkAMrPnyhg9Td3yi/Xt7XcrZblB/P4/YlaWzSkSLKV0KlwRQMr?=
 =?us-ascii?Q?dJHJBXNJC1dNqYqCnbWRRC8Ac9yiHxuvYhGJHOgSzHulUYsmjBmFUjRDkH9O?=
 =?us-ascii?Q?R8WubfS/111AEyULAjegAUZDsgb8WAqBY09l695/CA0CKxOlPym7ohbl5BSy?=
 =?us-ascii?Q?5bwv7TrboSTW1rZByI/wLUwp/j5SU2JlF6UbACAln5k8UmgS8m5GyAOTPYjX?=
 =?us-ascii?Q?Jw3nhBiYxoZIe/UskmgZuNNZewrfKEio9Zc/0CvSbrFgS6Hm+L4lJyPEXeLr?=
 =?us-ascii?Q?MG877e1TzhX7tSFLN0yRiSUOSgBSMMSu5d27FueAwwzCu2wAsfBs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3481ab83-7753-4448-426c-08df4986032c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 17:20:03.9548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nv3GELSISJ8vcBfBXjlCxKiTEcbDI5Jo6ZnnuX+wpa9VR3nouP3Y1N/l94e7G2sSmkugm/paT8FY6867Ca2hQjNuWyy2hJpW0N3ZtoUaqYMM42t41RCVKkpJyRjQXTCF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8495

On Sun, Nov 22, 2026 at 08:26:23AM +0530, Krishna Chaitanya Chundru wrote:
> Add an MHI PCI device entry for the Qualcomm Nord endpoint (device ID
> 0x0120), so a Linux host can enumerate and drive it over MHI. Nord
> exposes the same software IP channel configuration as sa8775p, so reuse
> its controller config.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/bus/mhi/host/pci_generic.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index ca9ef4aaa014..65201ec8dc76 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -383,6 +383,17 @@ static const struct mhi_pci_dev_info mhi_qcom_sa8775p_info = {
>  	.sideband_wake = false,
>  };
>
> +static const struct mhi_pci_dev_info mhi_qcom_nord_info = {
> +	.name = "qcom-nord",
> +	.edl_trigger = false,
> +	.config = &mhi_qcom_sa8775p_config,
> +	/* The endpoint places the MHI registers in BAR 1 */
> +	.bar_num = 1,
> +	.dma_data_width = 32,
> +	.mru_default = 32768,
> +	.sideband_wake = false,
> +};
> +
>  static const struct mhi_pci_dev_info mhi_qcom_sdx75_info = {
>  	.name = "qcom-sdx75m",
>  	.fw = "qcom/sdx75m/xbl.elf",
> @@ -966,6 +977,8 @@ static const struct mhi_pci_dev_info mhi_netprisma_fcun69_info = {
>  static const struct pci_device_id mhi_pci_id_table[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0116),
>  		.driver_data = (kernel_ulong_t) &mhi_qcom_sa8775p_info },
> +	{PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0120),
> +		.driver_data = (kernel_ulong_t) &mhi_qcom_nord_info },
>  	/* Telit FN920C04 (sdx35) */
>  	{PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x011a, 0x1c5d, 0x2020),
>  		.driver_data = (kernel_ulong_t) &mhi_telit_fn920c04_info },
>
> --
> 2.34.1
>
