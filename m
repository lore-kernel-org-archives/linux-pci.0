Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588261;
	b=jZBY+zlI1pdrlQyXKeqTFmnHLm8U6JTMGheMAT3KemCQZ9aifwOHZrUUh/qYpHJsQcwh
	 58DyMLQ69R4ojKx13LqFtLSLTcl7wSKwtH/Z4dakF5J3QdpWhKZJYyBggnZUctxq1c8ue
	 xduwlK4Xw5c5uu8dFbUMGg4ipEEtVbTo5vvRIEl53xPg0Pvf3c9nphGoXz2kNKM+cp6fP
	 VofsmHXc7DQjdy06Fm5BX7yUQeNlG/GWu8RSi2daMozeeytToig3Jue73BCUtlxFiwxEd
	 GDtf/roj4W69A3jNgh3IstiYvXizoF+/xcvOsLIHcRdGlWwZWh1PpJNAgj6HIPpaIKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588261;
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
	bh=zGA1iKDwtG0ayIkbR3p9jIDB/VoqLg2klJAGJcOxB0U=;
	b=bQ3JWvK8TKmiZj4oEVE0CuxvLejzarIDS6oTawYjjwJD7GX6WIjLXmakwe4QWVm6qCeU
	 3tYyU90tjvB1dVmz8zJ1Mhi/KL9yB7IHIspqQCSup47+sGi7zj/VIRzbAA+YWcSk7kc1j
	 PfketqjRXLInLW4fookkdHcMdE4g5UeMRtAIHkhhEIlTbdFsfUmbhgeHYDidF3hy284CO
	 neNuuCO4YjCx/qGMXiyz3agZ9drd4/Q1kwxX8ViUXLnkEjHLYQ6LxVRKHs13wFz5xDSzW
	 3pE+bu3iW1pW1JqGsFEi3ivQH5kQ+GU1hM4wMB/ka312UA3HuC2zm19q/lOkpREtebw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=pFzZFkKG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.14
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39722606A336;
	Fri, 13 Nov 2026 16:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39722606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=pFzZFkKG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MA4PI3t4jwcN9p8YfZyfz5+m3LVxBjJEG083DoVv7eYWeY/t3FmlKItN40LVy9Xwh7mCNPl+24fCVUPXLm2uaIQLXHfh56/pmIrIW0DKTRxTVhoYaPIyjMm2gpYU6Cf0iXOexbfvg0E4H5T5JnO2NgRWsaEGBrc3YfVSO20f7WywCHnyRHCT8sBW3ajiwkx3J6OECLRs3rGf0jh1nPD9r4AI6982FpC6YnV35vK615kYYJKT/NiC/qbsU5Xn4lgFHaqXLeDgKT/66Y9litunsE3WtfLBJ8r3q3gyf6qgH/KjpCIn8GYyteHHqJyaadmzkAPpZe9jWjYM3X9lZzZ6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGA1iKDwtG0ayIkbR3p9jIDB/VoqLg2klJAGJcOxB0U=;
 b=DVBXbbDdIDdFATByYYnqh4r9IwMMnuu5ILAD24p5lOtJPz+5U28sewB51rvgXIRn3Ijbo0cYg9ijxRB3inEnilSgaO23qO5rJq3HkL7pVE9PBCqaTvjBesqOatRZs+3WaGR69aFOTuPyOexhqNdiLjx4qODGxW3F9KZIVsu9VeKdmRvXRbiqxNm+NoQXQH/7N5TT9+KYkrwKR/m4PkSFj3M8Qx52LsIloBtmA1lz+uXeb0+wMothAi6/4JafhtWZewCAakpklGUEFPDGDBuMthWY7TCRLZzG9ju7IQIkoShO2zdA6/RjwW2eo0u3/aFTPH/9MKHEUndikjtlTkt2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGA1iKDwtG0ayIkbR3p9jIDB/VoqLg2klJAGJcOxB0U=;
 b=pFzZFkKGboXf3VrW/u4Fw6rGs42Vl4p+xBSwhCK9dE3q/iatcOPwBa/GbLOWuhSCWrLOJStfXA427LcfVC3/WMi0im0LIRtMacP3U66TiiRu7ZgBtVeKfES5vSmOfc2joZVgofon7IE0qR+n5EK6yJp3eQjuR0yrfKnna3c1W7vrHikCnIEciFITCYJZbVtqZ1+P6W0r2VXFJmuPxI0fpBATiBI1dptBKXZH2GWdxvSzJXGjb7pOhojZo3LJno0BXHCruyO8X+qs3ikLg0g3J1twSFiJ4QUemF4T25NinX/U4lZEDjndh6/3cG7GCCkyHk+EpLw5BCW9jB1EEQ4zTw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DBBPR04MB7964.eurprd04.prod.outlook.com (2603:10a6:10:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 16:44:12 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:44:12 +0000
Date: Fri, 13 Nov 2026 11:44:03 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
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
Subject: Re: [PATCH v4 11/25] dmaengine: sdxi: Start functions on probe, stop
 on remove
Message-ID: <avc-U4-WMMulqpdQ@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-11-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-11-3668ccc7aab8@amd.com>
X-ClientProxiedBy: SA9PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:806:a7::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DBBPR04MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa6036f-5462-499f-8ee9-08df41a55886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|19092799006|10067099003|56012099006|11063799006|4143699003|261022105027099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261026140227099003|261102123227099003|261102130727099003|261028144727099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	FdP/41Dh2MRcR1jY5ilEvRL79Lxx48v8Bqb29lVSThNrTbmY1ZCRmuN8KuDbzs9HXEd9ocPLa1eFwP6l0LOOmqx/UJ4ZQJR3OjpoSAJ8FXqKv4R/V/sT27jANRmwJ8638w0l/N9+GHJhYPIeqASXUYrWAt7olHVwEZCPdtZgKgqQTEEn4TcGAxzpRyYpDtCH36/jLxukUxrmXVDnZedYr8Y3dttqDrYF7hwZvHXHGjvTVby4KkCUUluLnGt579Z1QfXU2d2J0oHMpf5ZwiyFy/F6sunIjEOFqD9gllAm7vicaea3o5VIC7MS86Rjho9ktAqDE2HT5Jr0XW5VE6yFivMa573bxAjNW65wKk/zgZ9MS1vUNG/MxEbCgmMRMQndfOTjSTYaw/C1443K/RGoGRzijOgljxzc/egxe/Eq5vPKaYi7dHzvRAzX7IbNo4TTK3Ypqwwv5z88C7QlvV0VLnUIrjah/m88ooutysb9hSDgzdqMtsa9X5tOqPITntbPK47pohyMANfyGLhIZe1Y1/rnK9u9NxAJRM0ry2OKt7B2MuMwSWH5H8NmJ3Jtei2OsA1LIAn0yME/OFq+FTqU1QK2TphZoiDQ3FBslLMEDuzOi+IH/6hK5YewgKaCqPy0d1TBeF9gFs5kCVP0tNcPbgLMgb/y3cDBq3h7ABRlO/U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(19092799006)(10067099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261102123227099003)(261102130727099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qtaMIGnWg5YvhcBkAdHCx+UblGXGTLqilmHpQK7+z7GfSVkVcrj6IizwnaF2?=
 =?us-ascii?Q?ToXWU+IZKLM9vJoXeFwnv++IkH8CiGbzA5ztphzMcFOctz6Lr4v+TnUi2GjO?=
 =?us-ascii?Q?35Xo2yq37GTij7UCZ+BEIJG1u9JaG/LpRCrXTsTNRDc+SbI/Xrapc165OqYo?=
 =?us-ascii?Q?1F1dZU6CV51fI8c7GLH2Q2MB9NuxZ7HmI5r3vOGIJXCTlHOYE373yhxU2btQ?=
 =?us-ascii?Q?SjCBhejPWB3/kHB4bD2vQ9wI5Rz6rC+68r/FlX2BEdBShdPdxjAwwUyO1w0P?=
 =?us-ascii?Q?6MzEHkDqxXTPau+chf3tX/zo3QP9V47QogGYHa8nwgjWNmP81Kt4AUrOEeeU?=
 =?us-ascii?Q?X4vZG8YfTX88lJYgUem9rlJg3+g+7cqGYPMH8rqHICWRGWd3yiT97DaZju9/?=
 =?us-ascii?Q?Ht3KilDpV+/HGRqZlrQALJu75MhREnpTBpcE+Ulu2o22Ip4uDFEkq8Zt8vTJ?=
 =?us-ascii?Q?gI6MrqpgMwnPIIpc0LmXQXDds3DGGfD3MpcrkQhO8rdWNAoqbiDoh/AWirny?=
 =?us-ascii?Q?NPG+sClEmb9iS/Hf/5QbwT5KYLw5Y3ak+GG3eVqgKVXbLuqpH1N2CxA1c4CU?=
 =?us-ascii?Q?vsry2pTvbZo9l3tdPKrCG+VDOBqTAzo369dfqHcf5onyMVwhIE44q9pdkl+2?=
 =?us-ascii?Q?X/emEXx5p/FNAB1s+af8ynDGgOEf18qOE4b3M3f72ufzeVD7lrW6isNslEVh?=
 =?us-ascii?Q?dqh3WFGYXPcDBRp0DsI3PXQVlSBZ8o/I4d3a0+bLEcy1pA4ea0CQhlBpkta6?=
 =?us-ascii?Q?JwDqo066IEX9pGuCRXx8rxnRBWeMPeVNN3Y10QqFqspQJzOGm5hfLRkf6w+m?=
 =?us-ascii?Q?T/vIXEjeu231cfqIoL2ZZUzpdME2rsWhnNas78/QtHUEg7PrJFkEUUapXyhJ?=
 =?us-ascii?Q?/Q2Sv9c4X4joZXNpqm7kcCYE0fsc+H60K7r2vC0E2K/Sk7BOA8fuWQOIESm5?=
 =?us-ascii?Q?WCEndlztRwWM9uJPef/XF3vx6WH9CwMmh6Rduv0Wx+Wa5turaZQ96NQtc9jU?=
 =?us-ascii?Q?45Pwl8Irb2eLElB9TOKmsBWbSyudIq2F67UWJIAIqOhvzPSdxkwOV9DR2+4U?=
 =?us-ascii?Q?rSqbnZAYDyztl/dGr6Ta97ztH8AlL333q6+tDEWfTCNZskVYNh5Aj7IPV7zT?=
 =?us-ascii?Q?SMGTruHR8JpM9Vf5nSTkhXjIeZXeh2qvlGkkSwvEpFspXfiZJzz120ZocUXn?=
 =?us-ascii?Q?PAHy1JyB8PGV6Yzz7dU8t42FxM/uDAMFdrxiU4iaJO01dA7Z4KnJEIZ8loCi?=
 =?us-ascii?Q?oR2BBnJsCl0PybIXiWm963z4J1KYEAJt1nrO5Ocz5xJmIXd91r4HX+cAuVLP?=
 =?us-ascii?Q?VL4BMXAsodlESVcKJoIex1my5TMVbox2c1QHs9hCA3s4jRmqqccCZ/Uyvzsz?=
 =?us-ascii?Q?rm3ub38mp5tI26DVL1zCWNxxxc5C7TP+V0VD+NL2UYTPAQEtob6dp88W1Ikg?=
 =?us-ascii?Q?g6JVSCJwTOXgqT+kc3ty8JzEACrEQ6u6OG4rp8k3nn/Xf0VOpu+aGCiZ+h8H?=
 =?us-ascii?Q?uoCM/cUgikALEekninVFz5u8iQAT23NT4XtDj3xb1xUOUdYL9iGyaCRn/Sya?=
 =?us-ascii?Q?aSiw9Av8USR4Up1WqXEG3FhVixeYErvei28aUyvmgZ6q2m7EilbZW+bHNwPP?=
 =?us-ascii?Q?+mlx1ZT9URysElEYji6KJkZnclXgdt6NIZzfGq6543I0J11ZzpJZg+ly4DfQ?=
 =?us-ascii?Q?JoIX6dTqsTlV4tWNk9wjcUagp7VQpZ50nrRCLYmOFV7ZAImn12t43zF12cjg?=
 =?us-ascii?Q?d5K9ZDMSUAVahcGmU4Ri7yaZ7onbgXTKPnm7x7ktNrAkdwZgwDM0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa6036f-5462-499f-8ee9-08df41a55886
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:44:12.1170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvTpSyd5Az7YQQN8VjX8KY8ilxtN5eJ/ZQkqJGl1wo7z+uATZ8VKA8R35jhF/7f2eICAAjsZ3awc8fWrcF9f2o275a2khz7c8u5BO1bzgZoOcV+DuylsEhYD9L55/aBv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7964

On Tue, Nov 03, 2026 at 08:49:52PM -0600, Nathan Lynch wrote:
> Activate the function after administrative context setup, polling for
> GSV_ACTIVE or GSV_ERROR with a one-second timeout. Stop the function during
> PCI removal.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  drivers/dma/sdxi/device.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/dma/sdxi/pci.c    |  1 +
>  drivers/dma/sdxi/sdxi.h   |  1 +
>  3 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index f9787d7190d4..d5a5b8d43391 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -212,6 +212,36 @@ static int sdxi_dev_stop(struct sdxi_dev *sdxi)
>  	return sdxi->bus_ops->reset ? sdxi->bus_ops->reset(sdxi) : -EIO;
>  }
>
> +/*
> + * Activate a stopped function. GSRV_ACTIVE takes it through the
> + * transient GSV_INIT state to GSV_ACTIVE or GSV_ERROR. See SDXI 1.0
> + * 4.1.8.9.
> + */
> +static int sdxi_dev_start(struct sdxi_dev *sdxi)
> +{
> +	const unsigned long settled = BIT(SDXI_GSV_ACTIVE) | BIT(SDXI_GSV_ERROR);
> +	enum sdxi_fn_gsv gsv = sdxi_dev_gsv(sdxi);
> +
> +	if (gsv != SDXI_GSV_STOP) {
> +		dev_err(sdxi->dev,
> +			"start: MMIO_STS0.fn_gsv = %#x (%s) on entry\n",
> +			gsv, gsv_str(gsv));
> +		return -EBUSY;
> +	}
> +
> +	sdxi_write_fn_gsr(sdxi, SDXI_GSRV_ACTIVE);
> +
> +	if (sdxi_dev_gsv_poll(sdxi, gsv, BIT(gsv) & settled) ||
> +	    gsv != SDXI_GSV_ACTIVE) {
> +		dev_err(sdxi->dev,
> +			"start: MMIO_STS0.fn_gsv = %#x (%s) after activate\n",
> +			gsv, gsv_str(gsv));
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
>  /* Stop the function and discard inherited MMIO configuration. */
>  static int sdxi_fn_prepare(struct sdxi_dev *sdxi)
>  {
> @@ -361,7 +391,20 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>  	if (err)
>  		return err;
>
> -	return 0;
> +	/*
> +	 * SDXI 1.0 4.1.8.9: Set MMIO_CTL0.fn_gsr to GSRV_ACTIVE and
> +	 * wait for MMIO_STS0.fn_gsv to reach GSV_ACTIVE or GSV_ERROR.
> +	 *
> +	 * We haven't queued any descriptors to the admin context at
> +	 * this point, so the admin context jump start (SDXI 1.0
> +	 * 4.1.8.10.b) is accomplished later when other
> +	 * code starts client contexts.
> +	 */
> +	err = sdxi_dev_start(sdxi);
> +	if (err)
> +		sdxi_dev_stop(sdxi);

Suppose should stop() in start() before return error. Generally function
should cleanup resource that already allocated in the function before return
fail.

Frank
> +
> +	return err;
>  }
>
>  static int sdxi_device_init(struct sdxi_dev *sdxi)
> @@ -407,6 +450,14 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
>  }
>  EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
>
> +void sdxi_unregister(struct device *dev)
> +{
> +	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
> +
> +	sdxi_dev_stop(sdxi);
> +}
> +EXPORT_SYMBOL_NS_GPL(sdxi_unregister, "SDXI");
> +
>  MODULE_AUTHOR("Wei Huang");
>  MODULE_AUTHOR("Nathan Lynch");
>  MODULE_DESCRIPTION("SDXI core");
> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> index 6a293db69199..d196ab5cf6f1 100644
> --- a/drivers/dma/sdxi/pci.c
> +++ b/drivers/dma/sdxi/pci.c
> @@ -99,6 +99,7 @@ static int sdxi_pci_probe(struct pci_dev *pdev,
>
>  static void sdxi_pci_remove(struct pci_dev *pdev)
>  {
> +	sdxi_unregister(&pdev->dev);
>  	pci_disable_sriov(pdev);
>  }
>
> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> index 525473029987..631a605ea62f 100644
> --- a/drivers/dma/sdxi/sdxi.h
> +++ b/drivers/dma/sdxi/sdxi.h
> @@ -68,6 +68,7 @@ struct sdxi_dev {
>  };
>
>  int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
> +void sdxi_unregister(struct device *dev);
>
>  static inline u64 sdxi_read64(const struct sdxi_dev *sdxi, enum sdxi_reg reg)
>  {
>
> --
> 2.56.0
>
