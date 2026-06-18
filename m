Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DC03B71D4;
	Thu, 18 Jun 2026 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781807387; cv=fail; b=iFZH1LT2Q2Okt2uqiXFiSEsAEudi1f8xy/k7NLfH0BZ0cpqHhRQPA2NsKe6RSmPyi7T05GnxuBTMYnqIxuAKxZgUBuUlVBbDwWi45fMMA47l9eznzbaC7JTLP8V2tq7sNyN0uHn7Kym2a7ay5Apsq/DO9X94x1HtjcDZlxOwuMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781807387; c=relaxed/simple;
	bh=N7LdYMroik4s1xg0KSWLny9hEUWn6iAzmgGWA1MB7bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LE9CQ7nT3KUUCzWPVyLI0gUe95IF1mbyJEy/OMlbT2wt9B8godOX/waoWc6Ec4StW4irsAx9Ih3d8UVYhRki3KD/31Fq6QY1PyjzzavlUoVrMlORO/prdtqUtjovmyRVuVzswwVNfI1EXqn+mfZfhio+DDnwoJTvH8gdI5rCKjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Sgmz5oBS; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Sgmz5oBS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVvuUjfD9SxTZAQxjv/iGHqp93uiV4LjSbmNmmncoCEz0QLjFHD+J9+tU/V2rmwhsEZHia2quFTBbpZ3P9x8mYnlCHHQpzUMnwjvpctU/sCGhJBan5fOzOhRY6XxnkA9WjCFB3V5razpPajiaUen6CPT0Wm1m13HgooMTttJ9H9nIIe136JGe2yfaXrnT3OpSg+s6Zno/TRvX0yW52+Jos88xDbPnvYhN/zpeM2uW65kAJzIBti5p8DewhcwdOuiqwKzV6AIFl8pwRDU/TaVjOi/O2u6VsxSDC1osQWGz1SI98f9i1Tuzt9NWa4Z3QpdhKr5s9RAYoVTBJVvhImTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34Gv3x/1f05PLR4UX2Hcf+xoqNCZKXok7V5erDzvmPs=;
 b=VWxhy43tqxxCBFsY1otX5gSVK5xaTCKpQApjOLNIu26tFdxOMOJAwlMtuYLgZuWvb52XsJ2O/2BQjZP6w7e0qnTQisLCDFXCOZw55uv/bKvtQC8UB9NR3Bz8TLAUxBZ+6ireRU+mWu+BY1I8dqpxM9rPxRZh1DCoV0XGvUD8Y4hvjs7s9okgcLce1YlwnArmFnGLTxKFs/bXdMcySI7OOmHj4JTRdirQHWPeBD1Jd8bnui4DJ9ItRgCS6zOj3eld4+vZ80ON056a4dwOH8SguBQLsO/K6vHbetSuHqgx5tj3e1qSwrVBL/Dme8R1AAzRNBJ+aLNAOBjBbZs2oTcdAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34Gv3x/1f05PLR4UX2Hcf+xoqNCZKXok7V5erDzvmPs=;
 b=Sgmz5oBSDLO4jyc7iOhOd9RoNlDNf0+5gZnQ7/yyrF6DE08QbKmScz5HFww2ZGwXROR2c/f4wquCOoqXN6mAjfnin7sGS8VCTTDgBjV0ivbxFlNA/quz6sFJwxJBZR46G0dvlNsO608L8g1KyiI9kG/10JPlqKnjvVQHA+8uRABdkD9PR4TUqW9DJch0a2IzbyduMUuEA+VmhqkVBvR5hmcW7e9pnqKyGK4f00v/Vlh7RK9bxmAxlKVwPSVL1VrnrocoQOF+WnbEWfTga1KMGHRZg84O3YC9wG8CXfAxLYwFX/CNudb4AYN/lQFb76g5TSp/7dJCt/AcBOCUPD+UbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB11859.eurprd04.prod.outlook.com (2603:10a6:10:61e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:29:42 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:29:42 +0000
Date: Thu, 18 Jun 2026 13:29:27 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com, marcel@holtmann.org,
	luiz.dentz@gmail.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, brgl@kernel.org, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: Re: [PATCH 2/8] power: sequencing: pcie-m2: Add PCI ID for NXP
 88W9098 and AW693 Bluetooth
Message-ID: <ajQ5B0dJt3R76sFX@SMW015318>
References: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
 <20260618101047.4185497-3-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618101047.4185497-3-sherry.sun@oss.nxp.com>
X-ClientProxiedBy: PH5P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB11859:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f503d09-4ac6-4a6c-296f-08decd67901b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|19092799006|366016|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	cJbhhRa9+gEXugUwGVmZ+ATFENpYQ+0ySSPJt7j1Wzz65+W41Ovw6s2+dfsKJPLRqWwyjBvSZZStxIuyqShGX4VtKXv0j/6573hi6h0EKz941nv0IwbQxVgaspUl+zrLZDs5a+YlfySNN0gvad9yD25abRNTD6/xo9Rxq2cpf9ar1v6ob9P5187JTCTReT6tYpOYLStpQSllP1Uc4H3Art+V+lKEg/npxUL/waJAGHlp7wfOVBF9hmU4WV885DIvFAGsClI2oT1XMlTEiI9oWB0Na/Kr3jarVs0xR6fKXvD0ceWZ0CT256cYrNbxeJ7JxHEvE50gg9q1mQ9UZ6f8TqazeK6deBesd4s5o5VDAXs0I9bVwg/RaV2lnhg2D4duwAD4z65g0z9f4PI2V3wuaG7EhcwHOZ6kFvmoatDvSu63XcPEdeUIWsmbDztBQMDrzVfSxngvtChwf/npQnF4fzU7+VrNCuAFxpY1Ia/WvA2TChUqsp+R5KxC6Vp3W05GaYSxaAmF/X8bZZK+Vlqgq+iZJGV4lDhEAh5jQEW7dT55bkPsibczc04req87Nfmvjp4BLEzen4wgaR9qfFJWyYQ/oIW9N8nKG7YbzM/1Y8flU/P7q/++X1TO/XhiHBwFHA8ux3GdYgT1pJZymfgobWUKC2UiGS+mcst0xi7N6boHt4B7e+yjNJ0BJeUaCj7E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(19092799006)(366016)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TGSRZE6m5wg5+qaVNnSF14Wjl9PphAYNG92UR8zPsR1/SmUIHG4rX6vOHr1S?=
 =?us-ascii?Q?Thy9yCLq40Uincg99gaZZ8ZfY3wF7/xPCfki4NwaqZrz2y4yu+9z+/6wFgeJ?=
 =?us-ascii?Q?fr4lO4LDbVrb9l4Ev/xMCCs1709BzSkNiGDW6D2n48Y/0md7JR3WPHfbOd8N?=
 =?us-ascii?Q?XrFUoknKAAc8qEoMfS8Bhc3DRVihDvj6IK31LIxCmwCykBn20v92SjeOz9c9?=
 =?us-ascii?Q?3iFolZYS0PeVlPi1ktV2Bp2lcR1WRCgw++l2uq4j9YFmFXu1sRv02CoG0eFz?=
 =?us-ascii?Q?crTfZr0Xg6JC3Z5f6Ug0YC0VZf7XFN3nt0/J05kBKHUwA41ii9H+ZlZ0G0WM?=
 =?us-ascii?Q?DCsPdV5L8c+PVWugrGKD8qb4o3YE+PHFnQ9JXSeEG9TRUiZryY0q7Jl+VTr9?=
 =?us-ascii?Q?qfdAnoozF89P3P7FdYFdkbsVJxmdWofpj7HgxoGAKV8nt357nA1429SHkXoG?=
 =?us-ascii?Q?1fAmg7zBhq3t3YNL76v0+/PjxMV+zo6O/y2dlPQSA4/bx2XyMM24Gctjh1nD?=
 =?us-ascii?Q?cA1x727GgV9+aAoX5jVZwXyrEjvNi+ZCHRYHPrY+1ypNOJxh6WuTxRitJgll?=
 =?us-ascii?Q?TlFGfmurtzCBN8TzFrRKiPohM/MbsL8KykH4/vobYB0NCCU8wJ8LMSkkOYz8?=
 =?us-ascii?Q?2QTXIyjZeXlPpZJZT5Ldc2kaDxJQEdSsVVjgMAuHzjn7TU8/qGV+HVY99iDL?=
 =?us-ascii?Q?+OaJTkRZXmQOiYWLI/ug1Rh5QEUKCHzV71NPpKkUN2u/eB5Sl100SLj3uaQK?=
 =?us-ascii?Q?glDFv8+oIjUTM5k1fC/oarJFXDk1NNFjIANXg8Qmn5X7jaeVsAgXSVaXBIAS?=
 =?us-ascii?Q?0Sq8pfc3LBY/GiCu7MEgC7ETxjTVPCb0uPZAzL76OPYfjq2yWIvRPUkH26n4?=
 =?us-ascii?Q?QaLzW1rOB70Z2iMMfHlDJGTxLopY+773DXc3HvdpWtnlQs14iei5sBNaumb0?=
 =?us-ascii?Q?ajlHwux41Lc8iY/CeBccfu28GSjN04drrhvTLLFpGC+/Ih8JQdJTnEgzuFzy?=
 =?us-ascii?Q?fzXWIWtuYC5QXOAQ7M6eBBCGI/oy9fjUiIXuMK3yP15IeCLeDhOA1xtLMrz4?=
 =?us-ascii?Q?9b4ZdYXEc52HefBjOCMqX9YdgAq0enVJHBVkOKgbrtkgQTnvKja4re66yOMW?=
 =?us-ascii?Q?3+tn92rz9zEg4VAyUTaiGWo+l5QrUOeda4U2+t2L06n/imzaPap4JR3XlJun?=
 =?us-ascii?Q?EICl1Saf1wvbzgalCtumNZ6iYEER0DawKdmTw28OpsB0dNY7hB1EsEloEIiS?=
 =?us-ascii?Q?6QGVGU+g4x2iYIwLVA1TyAS53q5XwcLuxScXaU4P66z3G42eMe+iOgIMndST?=
 =?us-ascii?Q?JrQPRXybcjhIjakgj+Upy+1X2zvPSWPXq6mkQgRy49567WzbfE0aICxInFwV?=
 =?us-ascii?Q?3kkAOY+vTAHPLoH1++uo2coo118ny5yHtDtaZdx3kJQaHvI6gWh+24T8A4ff?=
 =?us-ascii?Q?1q0LbtAeZRNkvUqd+/UVXX9vVp67zvsrT/n/OceiXx3yTYcvX8UBUXHBx55A?=
 =?us-ascii?Q?znoAmqhvrtF/Blb2qz/j5k/qnQy1nRky9JF/Z9j94UCeiW0jF+fjPBn61/AO?=
 =?us-ascii?Q?CVVZZ9hVXB6z2QbisoRZktQCjhkRo3J3uSTfiOCc6e9BeHzE4LUvwL/7X2dE?=
 =?us-ascii?Q?ODuv8vJ9ahr5hlwM/NIp7LiG9/kAynzygNuiRch9X+614q+NMazn8DLwaT3M?=
 =?us-ascii?Q?SNrN5rurXi0cgMh0bUHonxryzfWZXvJWBhDJXw1ngvM1Cpo+ftUuVKBnKUhX?=
 =?us-ascii?Q?mhXDY9YxIA34LNJQJqlpDeM8fx7Jj3drScBf1h4mdP8DvQeKR/lP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f503d09-4ac6-4a6c-296f-08decd67901b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:29:41.9512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bv9vjsw8nYgEZwOiouAhm/IHSM6W98MtrWzID2ZqzfMZQ7LO4FNrmTGFHz8S2lkiQU/ePVY8k2RjVqQO+3EZiBTCw2iuEuAYbVvfhkgwv3prZQ5kDI+h1Be0z8ZUrAgS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11859

On Thu, Jun 18, 2026 at 06:10:41PM +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
>
> 88W9098 is a NXP Wi-Fi/BT combo chip with PCI device ID 0x2b43 under
> Marvell Extended vendor ID. AW693 is a NXP Wi-Fi/BT combo chip with
> PCI device ID 0x3003 under NXP/Philips vendor ID.
>
> Add both chips to pwrseq_m2_pci_ids[] so that the pwrseq-pcie-m2 driver
> can create the Bluetooth serdev device when these cards are inserted into
> a PCIe M.2 Key E connector.
>
> Both chips use "nxp,88w8987-bt" as the serdev compatible string, which
> is the entry point for the btnxpuart driver. The driver identifies the
> actual chip variant at runtime via chip ID auto-detection and loads the
> appropriate firmware accordingly.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/power/sequencing/pwrseq-pcie-m2.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> index 94c3f4b7ee36..9217ffcfa6e5 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -186,6 +186,10 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
>  }
>
>  static const struct pci_device_id pwrseq_m2_pci_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x2b43),
> +	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_PHILIPS, 0x3003),
> +	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
>  	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
> --
> 2.50.1
>
>
