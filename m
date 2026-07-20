Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2098.outbound.protection.partner.outlook.cn [139.219.146.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3E388E74;
	Mon, 20 Jul 2026 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534343; cv=fail; b=JOhQeRxFKcO5ANObhxdYM9N2xmTmufMMi8j73K1glFTGdqfUmPt1KR/Eyx9B3JHw6jm8aRzY9MdQ7UkOnv7OtHhhKwAUgIs1db0tKLyX1QqlCq9e1yLM/UxwBxknA/nhhcLuSku/Hhf1daHm96LivVSsrSSLVPu1sgkGwTtEm+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534343; c=relaxed/simple;
	bh=4SXk8DdNF980u2t1l2zs3CK/doAKSdhytYGmr1gEO6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=laJNkqC5c5IoAbzGdJUVQhf0IkQtczgHLfI3Ac00lXgUR/ZpqKmg/DGJhyTn2IRGHjLI58+YG4uWjSvYxK2sbtGzwV30Swt1yVxma188jln8sIc7GTZtOu/OTWKxD+Zu/9oyYxKFS2rhIiuXDR699i5yoWN7DNlnEbJM5DV7Xh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com; spf=pass smtp.mailfrom=lecomputing.com; arc=fail smtp.client-ip=139.219.146.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+yoIHaQ9Mugh7ZhSt+oe1/wO64T2BNcvb7hvyVK3YVOAtpJovcMy0nIHkaGwtpz/d9kbTh68Q3mnBY4bDetDTGReG7dDIIgj00LD68cbr5B5FcXsfFQ3pVNzrFabQeR2qteN420fs3fy7LDkvSZQQ87IFbOzb3TobRQxjZmrH16nzMpfrQk92UTE4unZWeM8FI4ocQf6KVnEDU7ydLLzNvpDciv9StSczvpOMxk3JcYFnUL1xYE7Fg24CG/zpLfUI/KeZ2K3CfLesq0O15zq504yp7sB7BXDRtCsbgMF7W9G4HQrw2hj0q/E8J9Q2aIA6XlrKrHBmMTx5+1UPMtvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxesa9pZ2aN1yufsh9Wf5KwJTMzLhWFCpYiziTfXhNU=;
 b=Smj2x1w/pgk8FYbIc5OTUikcv7AFK7jSAJkYH1BqI0qzMf/l4a12OwRFI57dpDlfZBll8t5D7Dviz+hGn+1qJgg/fIejduM94Xa4w4hkIRg+Z2EJ9Yd8gEyUr7iXfoyOG4htQBy6Nlsz4iKVJpIhy2r+A45cwmD2ppOA5urqI07Tw7zs6DcohHOZm2/V3leoQd35TAb6D4vLJpZJYcR0NhLoZ2XeDsdDCHmOiWmr4mlwuVxgyKiMzWAIyRi6LuJ140feOjTzFy6Fmy++Ds/p3GvW7ZQonofmwOqpVpvH0lBCuehjTYugv0g6iYDMtfEElQo3/oqjliknJ2J3e8BhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lecomputing.com; dmarc=pass action=none
 header.from=lecomputing.com; dkim=pass header.d=lecomputing.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lecomputing.com;
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14) by ZQ0PR01MB0966.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 07:43:24 +0000
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 ([fe80::9e88:7d6b:fd6c:cc6a]) by
 ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn ([fe80::9e88:7d6b:fd6c:cc6a%5])
 with mapi id 15.21.0223.013; Mon, 20 Jul 2026 07:43:23 +0000
Date: Mon, 20 Jul 2026 15:43:15 +0800
From: Braden Zhang <braden_zhang@lecomputing.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Braden Zhang <braden_zhang@lecomputing.com>,
	Brett Zhou <brett_zhou@lecomputing.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 v3] PCI: dwc: Add pci id for LECARC pcie pmu
Message-ID: <al3Rk_bPzfEpFTnc@arm01>
References: <20260713-pcie-pmu-v3-1-5e4a8d82248d@lecomputing.com>
 <aik4muvixggxmphxjlpsr4kbfw3sxuh5pj5u7g3olhlg65shfp@kaqahgep3kdu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aik4muvixggxmphxjlpsr4kbfw3sxuh5pj5u7g3olhlg65shfp@kaqahgep3kdu>
X-ClientProxiedBy: ZQ0PR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::6) To ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1206:EE_|ZQ0PR01MB0966:EE_
X-MS-Office365-Filtering-Correlation-Id: a527dbc9-5da0-4454-7acf-08dee63293eb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|23010399003|376014|22082099003|18002099003|4143699003|3023799007|10067099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	+01sb660W/l/cmQs19JTqVn1/V6/dlvIFMew6lwb6B+v4N6S4rKx+T0A/rWwIcnqwgBymooz4wW8RO4OM4lAj1XnoSVmYfKorllGyKHiS88Hung1gMR07ugisocmVkZyc7C/9hu/bfkJiAKTugtHcE7wWvhuY54x6yoVfGdftu38sxAYfT++HWruMTBQLVJL0TXs7e7PhMLCXoZW4xykaQb9bNu5+Y3xuiIj15Bei+N1ryml2ssJ4Z2vg2OjsHuG0kgyif/C3RGIADA1CWp/+5C7j4+2R8H5hnhwp5sW8ZNrPWOTZ0/2j74KCO3mmIV7BJABJA21Y4IKJ8DoLU5Crwyt1Mt+xo2MrN63/OwkfTn1CnedCemp08qETP5aWTEvFg5lcpbXgtVc7ZwzAGjUBC6o1kh8b2L/Pt40tTo3xvTx6C6rl9rAQCeHxRL39FRFQiQ+sBPhYtDREMYx5d3h8D/gfFbynrVpuYJjEmhRXXZ6TZ5/aLkdZjavuW0WKYo5zdMMw2APeVh3drSSeQHgpdjR1tDkfGq20aeVjCtU2Lrcn5MfXbEnibFXy9mWJ5E6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(3023799007)(10067099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bs/DIFz3ILarTQn46lm7+sZRzUgw8KKUSIgC2yX/vU36sGhqbuEGJsCN9dLL?=
 =?us-ascii?Q?eQWtbCjga5eT1wsLjrwmCTtPhVTL6UF/EJzJ73DydRTbAKI4LftWcEvPaqyl?=
 =?us-ascii?Q?QLRwSKNIyEVcyYDhxSbeOkiksZ0fYiQzjc1ENntVksObksdmC+JzRfp+K8Jf?=
 =?us-ascii?Q?Y21z1TWSz23oyPnMP5Mgd9CfmZ1D8Y159htaQ+iY1wMKg6lpLoIfDH/vqe2+?=
 =?us-ascii?Q?5AQPRzaVjseVJ1x+jxvXeapkg8kF7i6aaIZ0qtuNV5WSbbFuwSiEoRhUdert?=
 =?us-ascii?Q?jWs14UvYeiXUuKZFd9WIq1Q+H/wEkUVUh897qL2l0N3FofRkjyDlapveG2rC?=
 =?us-ascii?Q?oqTZA/x9gSFvUWggpkj0UQvToySkbZSWnRLHqsieEj3NCEZADYIloDw2b/a0?=
 =?us-ascii?Q?i1lxfwAXoNBsg44WPfGgxV2wBVB/UW118iQGAYslrMMi5/KixL7PZeeLaZrA?=
 =?us-ascii?Q?liWw+Xzyre6OUuxkYZ3au6z4iaeFOlFZS4kcmSgeHordbS2JvZh25Eqz8Xe9?=
 =?us-ascii?Q?LN7zw49N6zqLg19x9V7yv6rDuq2aKDQNpdQ7+cnisbRJuaQ5eN7a+fN1Dw9R?=
 =?us-ascii?Q?65bnVrOXfp/z1SiDMqZzGEgDYjZG1rwgXvhbMTVSLAtZbKaYcWQeoQIZUF0w?=
 =?us-ascii?Q?S9RDNQk9iUSxEsSV6IIQAbozOdgdZ/lCLW+dfYclLxK8m7RJRh4NO2YFgnpM?=
 =?us-ascii?Q?Sd75s88PE7D65uFeh9pEjBy3iFQBV0jGryWb0wN8dbWFG6tK+Lmyx3qponkN?=
 =?us-ascii?Q?TIdhU8OXDXBmER3y68XMiRCACwdsHzwPC6WczDHTwZ5eA7fGM0R7P2FkiBqq?=
 =?us-ascii?Q?VxFWsKzOVjrQsXHK/RuQwtpyQRxkwGsbVRPZ5BmbVRd54pD6I4un4eX1//qI?=
 =?us-ascii?Q?hT3eXuB2a3nuP0dvZ1QI01QmLIXcyw2csyCWq6eWjazyoxn8kdFyxADQj33b?=
 =?us-ascii?Q?DSmdQsABlqOoHQwXzbq82PMsIkrd8Ac+Qv9sc/V4pxiFs526Yjs3kxUCkIAc?=
 =?us-ascii?Q?HjUwXfRORQOdRV3dLbM6MzsWUUJoeXveEcQiR0BqMLlV4925eHTwy6nOlOKe?=
 =?us-ascii?Q?bn2pk6lKz4OQ/qpfLmxj+9cnvwQcHtdAUsnSPW2PaXKHFRBQnYGEeuw8Zggf?=
 =?us-ascii?Q?T4VYOYM9lH9VBFnZHH/oTmMYt7pDPy8jdStD/GI4TWxI2NyTyvwJMvgriq/S?=
 =?us-ascii?Q?oQ8EvihlIAH4KmDRFOZtMkM3LuIHzK0E+hsCE65OrraBbujvgpQ3BcJRhD81?=
 =?us-ascii?Q?OEtXzf7xar/GontWHORr2B3cO+XU5WKNVk38zNdET7zNEHs2YWvwnEXoQ34T?=
 =?us-ascii?Q?V+8KOPzm0WclO/SbdZnThcO3pbecfewWg/h700DbaX/qvb/uKFoB9rxieJ+0?=
 =?us-ascii?Q?2eubEzN7aXVE03qapQgNm5+QOQ24SEc/aNRnt0sUXUeo1h451w/GMHwG5vPw?=
 =?us-ascii?Q?YFquQqgzJd63PZGdtu47MJO7tQ8fweobvQfft4PjVYFiDfKH6fptiOlq5NoB?=
 =?us-ascii?Q?zMpR3315NiotZcSzWysIv+gQ/vblXEKeK3ur8g8085RP+j8aAYbI4d4XGYal?=
 =?us-ascii?Q?kB3WkZiQHvHcZomb43pn63xBOFLsdhFJSaO/oa9Zy+mq03na2Wa6djTMbV+Q?=
 =?us-ascii?Q?zdjmJVYxWtFGDfp3hWytTggkm1bMoOKiImDn6au+7ZQydvzU1W3p56N0lfmC?=
 =?us-ascii?Q?/Y/UXuaezs57HYzLJQ4ltLW2BBqQLkoSC+LvEO4dq1RQOV0GjAj5cDbRodHN?=
 =?us-ascii?Q?QJ1BRr6eq4LmAWHW1Q5SnrDZAejfdD4=3D?=
X-OriginatorOrg: lecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a527dbc9-5da0-4454-7acf-08dee63293eb
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 07:43:23.8572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3591a018-3909-4ea2-aee8-843d5abaed8d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+C8vKPLCEvmuHE0xKks01q9ghpDQOUCMBWCSBsplD50VBNmtC9r3I4RKLbPnKHzaMJu404Oz/DO7oPOr/wrFzeFOb5/aOrBDLdWzbVK1AU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0966

On Mon, Jul 13, 2026 at 07:14:25AM +0200, Manivannan Sadhasivam wrote:
> Date: Mon, 13 Jul 2026 07:14:25 +0200
> From: Manivannan Sadhasivam <mani@kernel.org>
> To: Braden Zhang <braden_zhang@lecomputing.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
>  linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Brett Zhou
>  <brett_zhou@lecomputing.com>, Bjorn Helgaas <helgaas@kernel.org>
> Subject: Re: [PATCH v3 v3] PCI: dwc: Add pci id for LECARC pcie pmu
> 
> On Mon, Jul 13, 2026 at 10:10:13AM +0800, Braden Zhang wrote:
> > From: Brett Zhou <brett_zhou@lecomputing.com>
> > 
> > This patch adds support for the PCIe PMU found
> > on LECARC SoCs, which utilize the DesignWare PCIe Controller IP
> > 
> 
> LECARC looks like a ACPI based platform. I'm wondering how you are able to make
> use of this patch without adding the ACPI ID support to enumerate the DWC
> driver.
> 
> - Mani
> 
> > Signed-off-by: Brett Zhou <brett_zhou@lecomputing.com>
> > Reviewed-by: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Braden Zhang <braden_zhang@lecomputing.com>
> > ---
> > 
> > ---
> > base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
> > change-id: 20260710-pcie-pmu-5ef78c56c3b6
> > 
> > Best regards,
> > --  
> > Braden Zhang <braden_zhang@lecomputing.com>
> > 
> 
> -- 
Hi Mani,

Thanks for the review.

LECARC platforms use the standard DesignWare PCIe Controller, and the
existing DWC driver already handles the enumeration and basic
functionality through the generic PCIe core. This patch only adds the
PCI vendor ID to the vendor-specific capability (VSEC) list, which
enables the standard DWC RAS/DES feature detection.

We don't require a separate PMU driver or additional ACPI ID support
because the PMU functionality is already covered by the generic DWC
PMU framework. The existing driver infrastructure handles the PMU
features transparently once the vendor ID is recognized in the VSEC
table.

Please let us know if you have any other concerns.

Best regards,
Braden Zhang
