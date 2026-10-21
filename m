Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792596306;
	b=Z2YmPO0hwcY24SBdOokevzVFMOidHRoLjQuHjlPtdL+kBkJ4Ef3H4Vqd4W4D5//x9mot
	 LdUoB0VKADrP/DrQuDfp1ph69pICiDh1js49YqW3lYEAuRKfY+blgw4xhtOoeZVnsrOlC
	 xhaU7e9Tw14MdGmerhlAvvUAEyJ3Wa9DKF1x1EYxstROP4ZesRoAn0XyOPY1OOC0tXNLC
	 lBilPgLeDBAu/gghC18zmXu3BbOSC1oCLWVNTlqwP+DrnLuOiGy4uSOc7oydv7E7S8yvl
	 AcHTiHEtPcE84xGk6iG1/JnCno/TED7rJ4aNBudD+K67jAhAUn5Q/jkkEXFlFqlQlyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596306;
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
	bh=3YQW2wPoNrUElvQVBxdRB5ZJamVm6YVC6pzY12xi64c=;
	b=rCnbbjJnqOALq+vbRuefGn/hliu/OsIQkHjSO9RPNwB0vZfCJG/6RSfGTuTKH/s9IPTg
	 n32HDgEycAmsfgLFNEn/JCdkrCgyfqcFx4UIBD4xFcoSni+A37nOwLKWrD7auhC6WdZl5
	 LhRUPQf//y40BEf+3ieW6PYDKxb4UInxqyHt1Hgbp2E0Il4IcktPPVaUbcmlJinMagFIK
	 pDR6QXhrGUAFYKGoSB2pguulsnuo6rFldaOmH8D2Sm9mrw9Q7bf6XTQ9ACh20WnR8mpMJ
	 cNabeC+S3wfHLrADi1jOgl2GlUpNr5TAdgmRyuJ1qhrh7uC4EVheXM97wHIPQPE04zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=w8nNdRXM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.62
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61771606A31A;
	Wed, 21 Oct 2026 15:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61771606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=w8nNdRXM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Etp/MeupraReb8HekDV65ptt1U+iLmpI4QTUBjxGEKzKdaUKMe7evnHXEzqu7TZqdvHE14J0iHju3FMYdmNwROiu7HPPHJiBM2gy02+q0TP+Mfrb9bdmuzmPLPtSBaTO7jnWyN2DbXfiWhFM4agbCmU/TYns2X2DvmNoBs1AM4bycco58D2GJrCUH0WuYmobmayzuou16jCPFLuo1LgKDvyDhsAstwg8pe0NjeUY1pn0P7lVbkc2GUdUDMtQJBqBFrc9SatW6JhpaoUsEs0l6Ae9gSh2+GTwXht9NwEeMM4qTJKb3zQufF0i+SK6PKGPKpXAvFbyzSqbeKdjQov4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YQW2wPoNrUElvQVBxdRB5ZJamVm6YVC6pzY12xi64c=;
 b=qHBai9rxUZC1JkWepfoDJy91r1CYc5TsyjWgfQVJH3DxSgKPfXozN3BR89rbe4aGDSoT3St/zlq1FZJyPCnS+5Jx0I90akuTdfyU72B3p4qfHqy3BpshmJUgR8X06oB86cpZJa+l9d/XHWWsFUHF0HngZtWMjDCsy0QMzVwCDT4xxGUcrCNNDEhlt2gcwJMuU6O62Tj5wZ8GFA/zIcLhmouoCWjC0R1ulBChsDyqT2Tzcb3i86yZUMpVTcHP7tcKrKHsTFq1VWnDtBydfWnll+HdMwFrLpplEQvbaKX/2OUEeunZBqvGNrnq3LBOhMauGkfx87ozcltE7yjMSfR6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YQW2wPoNrUElvQVBxdRB5ZJamVm6YVC6pzY12xi64c=;
 b=w8nNdRXM/7MzCLD18DZSUUIVbRdfUpP8bqsv7pbPR4NqQVjE38bHXqiQI5phcRNZkvo9uC2T48YnUeGzYmah27cskzWTniNDZT3UTD6eNsGo7nSI+ycvEETEZszJdEqKr2w/oYx9AEoRzQkua4g+fOp5l3iOGV+MqJisHNjjRvLBNhmkzyLwMwxneBAIhtdsL3je0Sqg2ZQ8aLfN4x4is61+RWErC6u6T3dgIlQB0oopSzPevYR1Ux2nveyINjmkEPM3u4S5UcOnBIa0Ukj8IqQ5zKedFg8u9eyNBZKwZGuooCeehgQEas/AE8MqAgT20XgaIfBOXRef//R3m7WJlw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI3PR04MB018611.eurprd04.prod.outlook.com (2603:10a6:800:375::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 15:25:01 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:25:01 +0000
Date: Wed, 21 Oct 2026 10:24:51 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org, robh@kernel.org,
	thierry.reding@kernel.org, jonathanh@nvidia.com, kishon@kernel.org,
	Frank.Li@kernel.org, vidyas@nvidia.com, cassel@kernel.org,
	den@valinux.co.jp, marco.crivellari@suse.com,
	andriy.shevchenko@linux.intel.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] PCI: tegra194: Check for 16 GT/s capability
 before programming
Message-ID: <atjZQ7IufvjYdXcs@SMW015318>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
 <20261021061349.1265704-6-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021061349.1265704-6-mmaddireddy@nvidia.com>
X-ClientProxiedBy: PH7PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:510:174::8) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI3PR04MB018611:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb4e9a2-6a74-457a-680b-08df2f877992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|23010399003|7416014|376014|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tDTCGKZlK+zCttkaUCJ0hwhokWJbufTMiM1xLMa1YtRdQu2pKk+3LwHrouT320VRt3xXVLzohfyRce9OBq3RdngC5FkWnn6HXkwtT8ZXc6LN7IWeOONJOe+iDH0gUD0OEmiY6DoCmrWZ2w7UdiK2lqHLcTmwVDcPw9y+1cHDvMrPVfmV7OG+CYbdReBNE5Zg6CD5xZ3gslr0MREAwlrE/W9xYVukdQf0P/Aa+dphh+dyQIot6Y0bqTsDbLQ2tA/VPGjAJXIWpR0XyGIc9zhATMcEHBQ0aVry/CelU4ChlANV4OoLJAaZ9AdNwrCBEEi03InvCffNu/Qk9AtNZVDy60Dprmzuqpz/Bg4tXkd9JHuYkumQo7y65Bdj+KNX1RLgNg5z83DGkBueISzcWAHe9xVUgWfnTD/Je7O+MYbyKC+KLm94+6F5uZsK2XEieJFIgaQExxVQPRjCndV6XgfvvNHD5uu08ex7VVYjr5+o/rqgtVPYe+eyq9cL96jJmS8//baZkP7pXV3CWwXkzX56BIc2I6lYJMapprXvd6En/ZYBnkhL34152nAM2dhciXjU7MGiy1wKZGgwtPBcfXwhi0mulurxJyLQfy1bf1al2J+P1PUwXzR4z1G9y0knVQn+wNjHe8ft0qlpzfnU0mCIO28tPRXhIP7OS/aR3BaD++0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(23010399003)(7416014)(376014)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Tpu7GSVZCEe2GSM6VOy0nCe0Yfqo9pQdXLSn5py7sWAhqyQuE9TsQu2VVgL?=
 =?us-ascii?Q?MvoLM6b+u7CUFvqDwPG+aevoraOzasoWAuCkPRheA439y5bKN69DYqhqnOHC?=
 =?us-ascii?Q?z1sLSfLCZGQQm6VXNBhiPn5NwOUyg4uT9kQRRGd7SwWIFhqzSV/0cDBgFSLe?=
 =?us-ascii?Q?ognhjZw1TwCupdBlJcco9lE4PPpBDO/8IXbXUJXVx1ouBWQKbWROJ6ZByiV3?=
 =?us-ascii?Q?t/1jQtvUXrmQ/BbXqSwJLkww13KkL3T7Kycr6fCqUYkuA2qa+xtbYVcQ1O1P?=
 =?us-ascii?Q?gL8QPqV36GHaqP8nXHjUHohiWTMzsXioTIoUKJnkj9GG6iTMmT4OoQQAZLEP?=
 =?us-ascii?Q?MQgNRAnT2BqvPzofK6FVf4XRo0kZg6yZBlV/Ew7zmUj2Oh03dZbCKwpW8h3q?=
 =?us-ascii?Q?xQIwc2V/XgT7sIlu+Hhd7VMBd+iQfqrQv4a/wbc4EzioL3Zt3ZfF1xUXz+US?=
 =?us-ascii?Q?kqRh/8RVYmZONLkR/uqBhIhb0Hu4LsQFlvVsjsydmtxRERP7nbktjdXyWdkx?=
 =?us-ascii?Q?Tyc1TdDyLxz32mwks0r0cr0Mq3BS/LMVHBapRSrH08JCR9+3HjVDutofoP7i?=
 =?us-ascii?Q?OmcbP57W//2p/feWPQQ7qNyAhqoPeGc+kWQpTt+hAzIFY9bqUOc5DEDlxF+1?=
 =?us-ascii?Q?zc3ZlSC7HhNhN6QxrMn2wEelkgGxozewWkoMGv8HiKuciYaSFX14gWYF5Mxv?=
 =?us-ascii?Q?irrUhwZrQgZNAmNDfT2qWY7hy+X2cofP0Dab5CNHg6v9T41ce+aKxrJLoa8q?=
 =?us-ascii?Q?jwtaxryonnBasHO1A4mKAfiIA7poOUYUPe6+TUB/t2gZaEOUq5LYTUwPr0TS?=
 =?us-ascii?Q?FMJQUW/Mp+jXHQiRyrniuEzXa/Pujh+nESViTr8ga5Avj9dEcbxSws2AwLHm?=
 =?us-ascii?Q?WmlWFruFZSetP8aWF+UMYbpe3309h0kNAePBQuyf16MGPXQl86L4lRSa31bJ?=
 =?us-ascii?Q?0QsrpOiPAXEzACbnhK/RYQR+AewjFZKkYR68/WmL4ALHbY3E03AgJSqJWXuo?=
 =?us-ascii?Q?422g2TgzTgmFQiQGPc/wXH3LjAiV8ZVvM5J33FhEp/NTh07ojl5/7SCoqqGV?=
 =?us-ascii?Q?KhmELCXNWKusqM5IcaBKICQatFG4h3jJUD+HCTJR7vPcD0jOHdaDpG0g8nB1?=
 =?us-ascii?Q?5c9JcVwS9EcZ/wddV3nPYIzSzz6ZCY+eyYuLXF/2JrWPlqhAZu86Zc0PNT/Q?=
 =?us-ascii?Q?pSLFAYz/Lg/UCFQBrZsCkWtQWcUvEx9RYS76U0OI51HkDcsg4V5gUpMIagxJ?=
 =?us-ascii?Q?E/rG0hAs/ODQDeaV9dfVJsiwKZVNmBnzWzS6j5IOATt90ih9Apop3OSpG2B0?=
 =?us-ascii?Q?Yy0szGZ9PTT1tAo1ywuNmceK+5sh3LDMuZh9bB6eSKznuwpsNuSXDERg5s1v?=
 =?us-ascii?Q?DKHZCZHTs58gnu2UrQhik7PT3CI9/xldNvqVDZgGbq+mV5tN3DbORY9REqiY?=
 =?us-ascii?Q?Vns1i7cp7i56nPxqK/yOUaJm0CKIVdolAnpocYIe5wEnxWsVbnonCiK7INA5?=
 =?us-ascii?Q?r/ezcFA7Jf46Ak5oxaHGaQVPYI2oadFwlCJwVU9Od5KLIBI2CRkSYg7CfTCe?=
 =?us-ascii?Q?7qV2G4aWu8TbkDBV8swOgx7YtBZLBtzQCou55KIWgCnwNL/BYSzU6k8yw7Xi?=
 =?us-ascii?Q?6R8D/fKx8ODeDyY3G1lDKdA7rhs2ah0i02GkUW81qYbOXPujNdA7d4E7IVpz?=
 =?us-ascii?Q?UbLy7lseqXqaDqr5ioNlzYlfqeTYOQDPWcdal9MmKQbEkgwwfIEg52QY7zxd?=
 =?us-ascii?Q?rXzPuHSoMjH4lrzWNrXOwYbrZwdzjjIkr0FojpjSA/ALmHEpI918?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb4e9a2-6a74-457a-680b-08df2f877992
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:25:01.7782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qN8IciFM9ibsZRhtgR78+7Id4fYYs+DQjzRmUwd76qLgZWy3M6SifDUggoCAB7vCzdzZ5f5DD8beNcb1s7jXq1SPtKssitY90qXkeTsI8eDUwEZoB6LF0TFh075XDOvE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR04MB018611

On Wed, Oct 21, 2026 at 11:43:44AM +0530, Manikanta Maddireddy wrote:
> config_gen3_gen4_eq_presets() added PCI_PL_16GT_LE_CTRL to the result of
> dw_pcie_find_ext_capability() without checking whether the 16 GT/s
> capability exists. If the capability is absent, the code writes lane
> presets at an unrelated configuration offset.
>
> Look up the capability once before the lane loop and skip the 16 GT/s lane
> equivalent control programming when it is absent.
>
> Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes V1 -> V2: None
>
>  drivers/pci/controller/dwc/pcie-tegra194.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index fb8084cef38b..14031cfaee8b 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -840,7 +840,11 @@ static void tegra_pcie_enable_interrupts(struct dw_pcie_rp *pp)
>  static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
>  {
>  	struct dw_pcie *pci = &pcie->pci;
> -	u32 val, offset, i;
> +	u32 pl16g, val, i;
> +
> +	pl16g = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PL_16GT);
> +	if (pl16g)
> +		pl16g += PCI_PL_16GT_LE_CTRL;
>
>  	/* Program init preset */
>  	for (i = 0; i < pcie->num_lanes; i++) {
> @@ -851,15 +855,15 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
>  			     GEN3_GEN4_EQ_PRESET_INIT);
>  		dw_pcie_writew_dbi(pci, CAP_SPCIE_CAP_OFF + (i * 2), val);
>
> -		offset = dw_pcie_find_ext_capability(pci,
> -						     PCI_EXT_CAP_ID_PL_16GT) +
> -				PCI_PL_16GT_LE_CTRL;
> -		val = dw_pcie_readb_dbi(pci, offset + i);
> +		if (!pl16g)
> +			continue;
> +
> +		val = dw_pcie_readb_dbi(pci, pl16g + i);
>  		FIELD_MODIFY(PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK, &val,
>  			     GEN3_GEN4_EQ_PRESET_INIT);
>  		FIELD_MODIFY(PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK, &val,
>  			     GEN3_GEN4_EQ_PRESET_INIT);
> -		dw_pcie_writeb_dbi(pci, offset + i, val);
> +		dw_pcie_writeb_dbi(pci, pl16g + i, val);
>  	}
>
>  	val = dw_pcie_readl_dbi(pci, GEN3_CTRL);
> --
> 2.34.1
>
