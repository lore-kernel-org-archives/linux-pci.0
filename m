Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793902251;
	b=qjR71Ce4WHb5e68F5Q3riul/5dcDRlsna8F2t0D31LvNVVMtOr1KT004yCtSS88/ZLE1
	 TgO49ZnFrutTzqhHb+N6B+QI2ReGCL7R6UlDiPNHARy+wsMNaYRbwq8QXYDpGFQ7r/Qvh
	 PS7B/p7S0zEbJqtv8AVGfoIzS5O6qT3By3SRL31qhYxC5a56JOVpQdYu8rYp6Pf3K90IR
	 sp8+SxhENXebZYWcgG68VIc5KPeTUYiRe/NG9ilfO616ghkIlFv4WL0wltTszbL0DKFl1
	 BpHhW3tqrSMzZddRjlP+JEDxbg1+EFTx3WBuhP7Kf5znSd528hUzAWiqKoxtEq5QTyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902251;
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
	bh=18vLdQBpqQCwRKVQxl3xixZhKvewsvGeWjYMbTzuX6M=;
	b=YuZUcN9HtKr94fPvLPE8NHee07C+nRGJbjFvO7pcNansKYldj/LbA7d09Pk3qSonqweH
	 pOE6gHmdwvvFiot3LTVAI2M2a5uO+xb+bOchO17ycTUOBiYE4CxZTT25SLBK0uLGXpzj3
	 LsRsMRc1grrkEn58V4sioyNunVD6yl6rTa3qSsz6FAzzqhlpbMaYKHxmDTgzd01bmLsmy
	 xXk8iZNUYLZUm3aNNfnxwSuUl9JtWmNX2pT2bRg1hxGC50IV/nkKysa2l8ZQ7pvgMbFlB
	 UDbNPmiTsTlXkc6QFpAZPiwHepSckLRQNd5RiuNt9oRXwCcelRGLke6EZ1GMNcj2Enw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ka1gFlc6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.69
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013069.outbound.protection.outlook.com [52.101.72.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF556606A31B;
	Thu,  5 Nov 2026 18:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF556606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ka1gFlc6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4Wyy06ZI8THt9HrHRWeUd7iFw8/P6AneTs1Ai1L0VZsxMnO4U0T1LBO2QZHToxd9Tut0qQm6XKkGnRDnXn3C7WGbWvL/HAYltOtyTsucfKwe8ph/yqHuEhAKbCeYjvELEd5wQ7ohZnlJG9GCqadifHGcJ/n9bKK0C/mSa7PGUb98szkTE+cFctO4rxsuYmXYoWD/2dJGgUxXsrm1B1MZfTr1FPy37RLRZQpFDO+Y5MD6Aqlp9TmHH5R5Nn46Nkh4LiwFY5LdfvR5lX0SbDgcaCxC75IB4tU5n+H1YCxutXBFUubaPPW6wTwuDw13QUEcsjE8TOWReTg5w9J+mlXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18vLdQBpqQCwRKVQxl3xixZhKvewsvGeWjYMbTzuX6M=;
 b=w3lEG6M1AF8UGw7IQ1d0wSxX7C2Oh5a6sCVcirdPUs5XvqA7EHOYWzS+ThKSWEjLegRuBKp6Oa9wkU9MZ32kB/Uw4BwGYgYhoCcCI3bGJIbq4i9NSsphdH0C+EckeEP8AekQxDA2kXAv/fFNytkbSJRWv6/ySqQaqyQbQgtehAq1lviHUAcCy6uXHoWEhZKvpTTD80CbmV/jppND/RUIMxmustlTmborbQZdePqz3v3YOpptBMkwrd+NYkeG2HKN/YgrGlENQ58A7IIC2o3YLY0PZ+oEYlRFcuM5xiaOoZ83d3cn988tjBH1k4iNnSB+o3+SZCnP2UFWsbRwo38+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18vLdQBpqQCwRKVQxl3xixZhKvewsvGeWjYMbTzuX6M=;
 b=ka1gFlc6Qc33OZyBOGKYZ7XGABklBIx+YulVjDmHYsREFOix/S8B4xVEQS+bhPm3WwefIKi1laao72Lmgj8Z/nAzuUurZsDj5t7GD0cMHR+rgVay8lJgZL1OQ+b2NmP5n72VUrjf7e6RckfGSPEpP3W+vpvY4RptrsYm3o6wWevDaByQlWDrnR8rz85TMhucHoS3uYyZDo7LcI5OY7LZyHCOPi+MsIJYNo10w4J/L2UrCK6Wr/TbHoBTrxC77SCM+gUfhuxG0qMk0UQGmQppyb8baomEkveIuijHGh/1fNaRsKGgV+AruxjBH6hteD22OaQqRE8RbCO1wp59QeTexA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS5PR04MB11418.eurprd04.prod.outlook.com (2603:10a6:20b:6c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:10:47 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 18:10:47 +0000
Date: Thu, 5 Nov 2026 12:10:36 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: nathan.lynch@amd.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Jonathan Cameron <jic23@kernel.org>,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Tycho Andersen <tycho@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 01/25] PCI: Add SNIA SDXI accelerator sub-class
Message-ID: <auzGnNOril-cAyRw@SMW015318>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-1-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-1-3668ccc7aab8@amd.com>
X-ClientProxiedBy: DS7PR03CA0316.namprd03.prod.outlook.com
 (2603:10b6:8:2b::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS5PR04MB11418:EE_
X-MS-Office365-Filtering-Correlation-Id: 910fc417-b23b-42fe-196f-08df3b681e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|7416014|376014|22082099003|18002099003|6133799003|10067099003|56012099006|4143699003|11063799006|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	PlaE2ja0gvpuKtcq92ipL1xUIHpp/nqJGys1i3sEPqPzp8Wt6JZT4mXfACO3NSbt6o+EHrqaPagF6qUCnnxjsITIu1dAdxq39/YDs6kljTsreyilFHDXcK8PRo1X4btp0Hm16TbJUygpsJ0QGQyWoHaqoWMsxV/oJ5utgJiFvWCMMzRbNTOvZ85vnKxyyoFJ7WJN39sB4k9gIcMRvZvQqWkZXeqw1kXAt07aWf7xUM+x+nzV+upRTSEbod2Fpw4xZl4JZwJGVijTkVQlwIAgHWZ1grX3WCI6x9Nyk8rMRQVPoUe4Ulz3OgfA+IaU/hGi5p4RHC/tHwztUhBTV1uABMCyQxkhQJaGv5jhKxmv5bqncPGa5ZoaizWVqbsPLnmMY5R5qoIkYQH7jXkHslxc57I+IiMPte5crUTMYLQklWzv7ZZI6xp7mngq9+07tESwhAYu8W3BmzPWsw/yWc5iAWL2f9ZTQ5MJ+ZXhVv2fKQjX/pWdtePoj8Za0H/WBe8Y5yoyxxQ4pFaMmfML7Ln4HF8Y39SKZlaj+vHP3uT9ahWfjg2260GoQlD85TTTtcWW0NcW2wL4pSteFk7y0CJBs2fyoVhyW7MOU8GsgFJAg1jI8VgMYrxc7A2uOmQzHu0Ntddl6tCy53LDZXTkh2TKBTqyWLpF+luoIMxtJmkE8gA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(7416014)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kSZa3ofkg7PbYkyMjU5A5X7NHs6oayKr/Q7j/H/f5Qbbwu2c101kUaIeFnN7?=
 =?us-ascii?Q?41GBtp7oM2vEYuEsYl2v7maVGyyG1IOdPc8MwOsvJPlPJw7qk/X8XwB6MZi0?=
 =?us-ascii?Q?WB3s0KQBPo5xqZlWI8eWmya4fcHbhpN/UG61AyLO7C1VEo+3fAayx/Ux4G2q?=
 =?us-ascii?Q?4BmPBkd+mHqtNrb671B0jTPFa2bNXcAcR6NtsjcxbI1FE8LaBxoBLnnbWTrA?=
 =?us-ascii?Q?PHHWgcr88KEDB1CrHhek+8c8Ml0ZP5LULq3wmo0WdhjEFXdbH3qJ3pPLJsCQ?=
 =?us-ascii?Q?w4y5jZ/Y16eveYoAwhrc7noDGABe1NJ0asUtUq3k1irFan6PQcUfNQLIGlyX?=
 =?us-ascii?Q?cPvO4q3SVVs/ebtBSW5wkTmPYp63OETryVRtEkcNZk3I6X3t+oLHR7RcHOcC?=
 =?us-ascii?Q?qEfRXYIRkcTRGv6nrG7Mgs/twDWAFCMkoGHzRrw7cZusKAjSTlDcWjGrM+j+?=
 =?us-ascii?Q?aSPvS5iZQpxIWNNazY+HFVp2CZ9ZFeLB6xuINRdDwIi+ptRnf8qKObslTZ4i?=
 =?us-ascii?Q?7hTWLVFz0+vFrOWRixy5a7J7W1VvRgxVqCIj6XzFs8bTxZoV2ihq4Yp7EEed?=
 =?us-ascii?Q?qofHIkyUJ95mxW+YF61603mrKmT8h+Noqw8UkmQ5HG5BSIC/eJQ3/Q0nTizK?=
 =?us-ascii?Q?oIP750M8zqrNFrTMjCwiuYhayikqoQiEsWyS7yITy5iOrKixUMDZqsh452rH?=
 =?us-ascii?Q?vNbi5fGXVNX6t8yFuJxlAZX8WIHkSYVY260lvSQhcEarTffXls/0G0hS8Oo6?=
 =?us-ascii?Q?BC8NJSDKZMwufHwavji6rvBh3fkc7+Lo7YO7Kjf9ZoeVkwvxWBptwLoUFVDB?=
 =?us-ascii?Q?rpOQLflMHBOh4j4YMgn3NUAIdC6sbEOwp6pmjN3sRZ8WL2AQ2+XQAnqoSLcN?=
 =?us-ascii?Q?j49wixv5XTe0aW5f8N6oYuFR53ZQfxbr0UP6jOo0RAjbCvT6h9dLtWGZg+Mn?=
 =?us-ascii?Q?vm2/8m9VoxvF+3OUUEPmR/Onnw402ZgWTNyfJtwFOfuxdAhCqYr16Gxd5oPe?=
 =?us-ascii?Q?K+RfZLwELlIDRoeoYNPhgbXgqnq4j/dJL0jiVF0+vTnx2T74gU761yKLvC77?=
 =?us-ascii?Q?zl8T78+IovEgNSQYX5mpWGMei5dTqyhYukYeBdYC+BhjCOT77BZPov20oY0p?=
 =?us-ascii?Q?yQLvl7daRZSRgUBSSKJKhaMxGfyZzqLL6VZ1F9uAHEbZjAMQEdalVdj3ZHXN?=
 =?us-ascii?Q?IlC3qg28HDXIjUcNpY/TNfaV8/kGWtVEfg1i/lQ5zSmXZvbj4+AopUVRk+r8?=
 =?us-ascii?Q?5PPz3pQVnOdwDSh4ZPyp0qmTNgn/Zs1V1dl4mND7xHMo+kte3O7A1LqwddFN?=
 =?us-ascii?Q?3j0kc+POqbO0KN9pKflke+AtTSjA3EtB8YSpR5OOedLuXpKq6RPn/AAy67Gj?=
 =?us-ascii?Q?n/5V1FgCFTJULys2Z6FmKy16Pwadw8JO8Z4TFrbOLnX42+lEtu1GKIEcIy0+?=
 =?us-ascii?Q?rMvrpt0ZYs8sdgizokk/6e8f700XTfQs1QmjCfbOWOOfjh2UH+aV3Tt+iHMc?=
 =?us-ascii?Q?WSDPooIyEEzQTmjYNo6ULWeo/H6eBib9WoqfaBW6G6umHTvfwtuaem5Ycs0Y?=
 =?us-ascii?Q?tW72nMW1xb3RltoVA9OZ8M5ydMnRyGhyeZ2L475bDrrXtf/6UeDIXrP+4Q8g?=
 =?us-ascii?Q?G9UDIWzNnXY8h/1DF01/mONNjXQOddSytj8DY4m7r774tQBLeYKsd+vJNkOf?=
 =?us-ascii?Q?GFrqK719/n6QRTuCPM7WAXxOEOtG+6+Xn/ALYpxydUvRvAQbF6/54NZxhFP8?=
 =?us-ascii?Q?ZpEClLct4YYmSGiKIlWGhs6JexrTWZOd3/c7dkPi0En2Xka0E/Tm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910fc417-b23b-42fe-196f-08df3b681e07
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:10:47.8071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5zp5eYWKCxBC0dWFkzNBas/vKgFKNrfjbG0Sg9xH3PTJRP3q2Wf/RmJUsvn5DTtDT2OPPw4AH5XIemQcV5Y6kUL6u67MJPoCSN7n6alH1tyQKfbcfQMNAI3jnoZCFGY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11418

On Tue, Nov 03, 2026 at 08:49:42PM -0600, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathan.lynch@amd.com>
>
> Make the class code for SNIA Smart Data Accelerator Interface (SDXI)
> functions available to both C and Rust code.
>
> See PCI Code and ID Assignment spec r1.14, sec 1.19.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  include/linux/pci_ids.h | 1 +
>  rust/kernel/pci/id.rs   | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 030c86dd6d67..dcb26f52b5a1 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -154,6 +154,7 @@
>
>  #define PCI_BASE_CLASS_ACCELERATOR	0x12
>  #define PCI_CLASS_ACCELERATOR_PROCESSING	0x1200
> +#define PCI_CLASS_ACCELERATOR_SDXI		0x120100

Does it use for differecne drivers? I remember PCI maintainer require
Only add new item when more than one driver use it.

Frank
