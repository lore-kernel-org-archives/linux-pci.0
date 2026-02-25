Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010062.outbound.protection.outlook.com [52.101.69.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F0311C07;
	Wed, 25 Feb 2026 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053758; cv=fail; b=ZaB7Pd+43jNcE8cEMgFBcLYFzvZnkdvmSfNMdspIl6HUtayORRjZZiIZohn2QcJQ9VpRJLaLwn8D4aRKl/1XwSVeUCfvO5tTuDLDZEBQbCqVOnZc40kYFwYP8nzkoh52/aqDT9Evjft0YyP7vW2E6l8+GksPwlRMY34f0e5+ZzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053758; c=relaxed/simple;
	bh=kwJ1fC1J/RXLUoC56chDyvxEmbD/webuDhm07yaO6U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z1ekDWK/Aq/5vnE5wxJ4/YOh0i7jhIQ2+ocP0NSC6adJh/lxYOsrr5DulssIFqN82y+1rx6FHAcSiHk1sc5g55r0ZJAEbSHs88GvoyBzA8KcQyHAYv+oS5zc7PrML5SQIcm7DcsYdZcEV/eKqFrB0tKOGOJnyYfmi7UquCdvYJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SFfnsU0t; arc=fail smtp.client-ip=52.101.69.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SFfnsU0t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1Nr7Lo4bMqHa8MZfzUrMt7z598q4ul77GlijnH430gMqfI2RuOYPvAbgUysS3bL7JHKQOJjmM8Eb5Mni8GTKc6RGUsr2+sPEHkwoONUiS+rSGuSigOu5CCqH1yNFdosMIOkVhiG+h984l9nfZ7d19lhC0T65gEr9ZUVKmD7NaDlzWmmkldb2sOFYD7IqqPHIaYRd4h11HRTqYNVGGowOLrTl6ilKyzQN5zrg+cHyrspc9/7kdEFVHxNSi2inzdyXYeZelJX26rn5cNfX0kfjdGjwPmfPGw3H16mco57sAyM8JZDFZxJgHhEIEHUTdS2ueIYUCwVAnV42V0ZjugfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KN7m64Bbrk21FQzRW4N7/vMX2uGjxNe2UiELWvjLf7k=;
 b=bh2hVn3xd/Cu8G2Gdqcp9+RFA4tAT76t2b15ewT7lvOVg8qMjnMLLi68/DGMaTTCfHZ3aGI3eGeUzNurEF1RbDXbmAGlwc7YewRBzwC//yTZHynQzbYpw2U/9eqEz3HKDk7BEeJaDDM0zFq15F9PUb/ty6cQiM6PuIF+xVj3rti5V16Qe8imm+cPRSC0DN0ZxznzKhXdrM069OGcvWB0XFEmvzisrkPRfITpRstYuU4lMoSNfEHAvqVtNR8C2jTu5KsED1+Lf1GMJf/9YklqwpwmnDQ0k4gjASaEM4JJr603sOrP2dq4V4r2xDt9JElbSfsDLHLOBwO2eLVE7I2qzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KN7m64Bbrk21FQzRW4N7/vMX2uGjxNe2UiELWvjLf7k=;
 b=SFfnsU0tXHDSo9/hnEQs4rtxQRhQgjES3UVg55/17dXbkBtkdgYWpvQ+hADiOHX2m19VhYKXZN2HztL2b18uFZoDhWwACzI8u3OnotCnsjabb2fSsTyfT9L/7RM9DYvc0rwnT6p5KoBqwM9WpXLkeeW9sDcNDgQ7cX3Ox70uE9xskycxAx9EgS9INA86boxZGRdblho3EDsIvV3M0/MV4xFgsovTZ9rWCTONtUZ6f+joNflcWl4Op0XbDav4dYHdRBtO1KGyTcVhva97AiL81iTAWX8iSNe9TJGXV+WNSE5LJXVE/y330moP3sxYWqnz4RdeqcBBiblmdz23B5b5kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Wed, 25 Feb
 2026 21:09:11 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:09:10 +0000
Date: Wed, 25 Feb 2026 16:09:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org,
	dave.jiang@intel.com, allenbh@gmail.com, kwilczynski@kernel.org,
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] NTB: epf: Report 0-based doorbell vector via
 ntb_db_event()
Message-ID: <aZ9k7bT109TXmklq@lizhi-Precision-Tower-5810>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-9-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224133459.1741537-9-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::30) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 14724765-71bb-46e0-8232-08de74b21ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	kociYxGEB5z4g0egLtryXYK1je2+YgN45TgGOunvi9zU4NQ7zIri2vQFZYe4XWwxKaKgt6o/sEwMoZV9W6mN9BnanPhDefiaUJJi3Ilwg5VA/96S4GWef80ZbE/NBldWQuQ+5qXT+C15FC8HDwKXVhhg49SZ75mTeI5Y+6N7rS5iPlKBdM3j4lzqxMyUaFxH5gTvSAJbox7oJMMI05CD+YkxceLKbffoCaKnxQKdldxpHfynaNdV4ofjPlUFHNnA350rDCKSMGBau8fzpdo8I1Bmrdh3NdmNGWjGsnFgPttTbOF8uVOIF8OY6rLbMtxNnmqEYAzNOYA9r5ZLclYLY1AUrm4yvb+tMsU0sndqH7K45xHA5XvJf0SHBcm5398n0lxmvSqTuL3KrUcbREhY+jXIdmrR/c9J7a7lJFt0H1X/dRL9lt00PxyTvxxoea/DuuJb5anKptxoNgheDIUL/N6lL3RPkaof0+FazsjHUSY0Vp5QiNkD9BzzlHo5Hxi7P+BZBPKpQPZr4bQWpeAnnE4oN8kzfc8YzCkZFe4TqrlKNrGOO4DRRYT++fD0xBg2xuSrKUbusjnh9gOl22M4IRCEKd4y5j4f/1vBUmgJo1zoul5tinBVyVH+NVqZVPHlbFdeUWW02piFeGlEZSaQoUVO2k9mY6qeBWl9Fi6jL6sIE0JcaLgI2klHGoL/L7lFEy9OxCBv5o8ftk5175pNuONyZ7XzF3yBeKdPlOrV4WvL+gQnMinWj1cZ4s2Q0Z/Tv8p1N+BQ9ZHrrifSZSxrzDJerAjvKpLoTZVA6LIvSmA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HB23OcWGGHFwMIP+ymn/mBqqbMAQ3oXH5mYK/sOCJkINhBJsLwE6C4/PexUV?=
 =?us-ascii?Q?v+nPcYzwCqd6cd96gN50d7/PoeHa9bRpLLYoQUvxWPYZEhASuVvC6jJdkbA8?=
 =?us-ascii?Q?FcY7rD4hMbebceQ4g3yk6j9nATtyCuoAbz2VGM3w7fC/5/nY+Cp6xTotMgjy?=
 =?us-ascii?Q?wTx766cyU84YooCXNSmcgIf9VX0KlMKxxqAwxBJL5PMt0PkhrBaH0drAam+p?=
 =?us-ascii?Q?HF2SOyMxLdTJ2/XleOCL+eXDi7bpVnPjoeVSADv6ofF1hACoBQQiwp9HjwvH?=
 =?us-ascii?Q?OIXwVb/Wpb4WJ76+94Dagw27e/mYewVPxVlEudEbTobiLo79gt84cwughdIh?=
 =?us-ascii?Q?5Mg6EJHYfd/KH8n8WGKYVg1TaCZpqe0BeEANrJvicCAjh6j8ctZGxCNh4Akj?=
 =?us-ascii?Q?yy1H2XyY3P14N3a0IYuGqbEJVdHj+7QGBfklsf1xs0+KBJnDYgkOBRJI73Vg?=
 =?us-ascii?Q?X8jp8Xy5eYqgKUsEiNOix/S9CbU/06fDSnW8ELHPtzcngfkdmN4ajwdy+iIN?=
 =?us-ascii?Q?6eH2s12QGiy0AVZC+87sY63bkpXtsAPzvFXY95WgFoBr31vRapPtmMy8TCJT?=
 =?us-ascii?Q?AhQdbcn47ZIIXCT/UuvtlqUMmV1QJ0GMkgExE/TAs4sKFZqSF+RDxMvBJCT1?=
 =?us-ascii?Q?DCZvEuVD08xXvJyggbbqRO94jsNYL8Vfe6l3npLYwTTSWyMh4umC2I1lBzsU?=
 =?us-ascii?Q?48HJZcOJPRQMQUiXyCkICtJVcW/N3cfh/WcP2q/c431/r0LDGcSPE6O1Pvbx?=
 =?us-ascii?Q?p55cDyEfIsETPNlUC5tgNLIkt/+jhlXMlT9NHOwYBCF4xmUwtt8eAFQt92XF?=
 =?us-ascii?Q?ehH9tNt1lG/5fn8KpEN9gaFQURtYh6bjhhXIeDk1OdHqdJt1AK/Nd7AvMBU7?=
 =?us-ascii?Q?7+lKDi3z2b6q9UyjW03HVItMbZzS5iJdvRzab2hOPZmEr8LHJsuGkMqPwXvr?=
 =?us-ascii?Q?LgfEVIxowsYpnRbsEYlF/5P38HEsBCi2pdy4qVtx5Y8x3Sq86ZRzR5sDPMsp?=
 =?us-ascii?Q?rYr2p6O3BIX7sN+Teq7/D0H9jOOvb/8RwliNJIE3fnJKmew4SzNVBZRBJ7Uq?=
 =?us-ascii?Q?7RrJI+kfZAbozKuuNPqyY0gTsY9BCEvNj/MKrLNun1mH99dxqdpUjhQLz1DW?=
 =?us-ascii?Q?Iu321Xj9lJQygQOaPxEuhZEX6PMFR9PUPY0qoHlUFuUOJJncjNCpwI1QcSIn?=
 =?us-ascii?Q?G2AAjTUiRLrhSEciFDrSTul9vvqdqkEuCXrRKojcmag1FBmGd/w+L+3wCUm5?=
 =?us-ascii?Q?KyQeH2UQgUgJt0Km65qnJnns/A2hEP9LRRbWmBLgoaWImIUUC+f0YJCKU/RT?=
 =?us-ascii?Q?QF+e7BzNxPFjQaL4HwqmPvTYWx1HcsUnrSt6LCZKHiJAa6+OhchNbTmL3RbS?=
 =?us-ascii?Q?fzNDKP+eZrV3XL7343yr/WHBcYyq2lg+Y0DYFJAq1SANltnmHQ8mLfW4Kf5D?=
 =?us-ascii?Q?bwR9qCtuXwrL06kXg8ltB/GhHLLoqn7w3mYYrHfJsO61thbue/8is+6R2r57?=
 =?us-ascii?Q?OWlxzAaOOhyoNQ59COiYOnNunWCgoEzS7FJ7LRLqxKxA/itqhUdZytZagk6y?=
 =?us-ascii?Q?W+pl/SBV1rBvcrM7vNrSW4dUKrTq9egsVVtjQlSalyb2dJN8Y7SX+K70uobR?=
 =?us-ascii?Q?XM3M2ogJweifrIN+7lIyjGwfJwp5ISSfrzFOTGHkHkM0Gznnh7Z1eIj9F/Ez?=
 =?us-ascii?Q?93e6vdGQk3d31xjUvmOQWVufxcT57auCkqRNUoNlEbZEeCkc/OZinhalSpnG?=
 =?us-ascii?Q?Xrf+t56g9A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14724765-71bb-46e0-8232-08de74b21ef6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:09:10.8629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDewPqu8P84E+SXdZojurNV81m2nU//Njh68mUoowwqJd5YI63qUAur/gdxLLcgpAe81xMBKeViVVKfZp3/cjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9687

On Tue, Feb 24, 2026 at 10:34:57PM +0900, Koichiro Den wrote:
> ntb_db_event() expects the vector number to be relative to the first
> doorbell vector starting at 0.
>
> Vector 0 is reserved for link events in the EPF driver, so doorbells
> start at vector 1. However, both supported peers (ntb_hw_epf with
> pci-epf-ntb, and pci-epf-vntb) have historically skipped vector 1 and
> started doorbells at vector 2.
>
> Pass (irq_no - 2) to ntb_db_event() so doorbells are reported as 0..N-1.
> If irq_no == 1 is ever observed, treat it as DB#0 and emit a warning, as
> this would indicate an unexpected change in the slot layout.
>
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/ntb/hw/epf/ntb_hw_epf.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index ee499eaed4f3..00956ab2fbf5 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -333,10 +333,15 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
>  	irq_no = irq - pci_irq_vector(ndev->ntb.pdev, 0);
>  	ndev->db_val = irq_no + 1;
>
> -	if (irq_no == 0)
> +	if (irq_no == 0) {
>  		ntb_link_event(&ndev->ntb);
> -	else
> -		ntb_db_event(&ndev->ntb, irq_no);
> +	} else if (irq_no == 1) {
> +		dev_warn_ratelimited(ndev->dev,
> +				     "Unexpected irq_no 1 received. Treat it as DB#0.\n");
> +		ntb_db_event(&ndev->ntb, 0);
> +	} else {
> +		ntb_db_event(&ndev->ntb, irq_no - 2);
> +	}
>
>  	return IRQ_HANDLED;
>  }
> --
> 2.51.0
>
