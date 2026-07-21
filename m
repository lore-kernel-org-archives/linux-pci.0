Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B734A794;
	Tue, 21 Jul 2026 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621531; cv=fail; b=uKr55jQz9UTe2gKQgcFFquT78j2tjsvkabHxlOOiwLDAKoJWEafCTBCwcA/a3Fo4MjBgX8S1DQQkqrXbSHDm7covHI/F8xMwXd3alZ3usaJtiCQ/zMQ3UUkPUnkZ6cCKxdkd9DrkdUXxj050M2IXeItMMUEnIEj2vAj3N8cdgKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621531; c=relaxed/simple;
	bh=GUUA3re34p/Hf+IVkTRYk1xTtWagftqrJ4+6LF5nhJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GQ5ZrsP0fUhWAFce6dsB8YYqCsssa9UxKuYY93Y1EkLOzrYdYRqx9ZNeS1zcrmqsu7fh34KxU413oUrNozt4jYLu+L5G2oX6cZu+MU/x7fDInKk1bRxlQPXrWPNqIKc5rbUrYvaaPUcGb3cONAc5rvqyWj7zWncbmCDS5yI6hP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wzv1oeBX reason="signature verification failed"; arc=fail smtp.client-ip=52.101.52.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wzv1oeBX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7iCm3oYn7a5xEYhvGTNYpwjbwSlJ8cR2EVMWl7Oa5Ea3+c+7r7NinEEJelomH8a1HvX4z5yPKH8qr4WaC7bX1DDqLADHum9SPZzR7s9KmKewzCfQya88lIp1zdvxWKEpHOOXrfMqti353BdsHGPqtlVWekGwofiO3KIMxNQ9zeXq2j5ZnPYMw0iJLCHIvv3oqXSgyq/YzBBGAwOl02Y2A4lS1hJcg9zoarvQ9p+O7KtmHQfltLVSWkugSw8zOKx0D1maRpvs/GY+RFuWyzn726qXYP3Tm97j3L1KcIgbY8R5KcAAbR2tD+G9Psojl9rBqCeL8qTBRiIKfZ11SF/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDSPHcCMguPhfG1g4QOLoYOVo8FWY7i2kSRjTNadU7g=;
 b=mWl2ablrwKuQWxXviD6i0+Cw3DxjrjfdcM6ojsNGTcc/wtsPzPrJ2Kg09+cNl7J9HoQGTulhcYbHcMze0v0e9INpiTeGVGOgJa9whBS9f2TOccQyjR1GtUF+PxOgP3yVMFZfxWkESZlUmVU+PpfRODF4Couj0iWo7jFFLktScb+fLHYZNmIkvVDg9JrnYM1Gq1rbAcFvUXLAvor7O1zpKkefPDHV7rBykQ7tq5DbIjn0qT/cLJnaIZgttBwezM+Skei1XZN72/Evm6qgsCFUCTAIFgn/I7nqHmNRmJmPgTzXkPp+yglc7mcNZg50vr5wnVfVYglUrl/nrVgk8yYRTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDSPHcCMguPhfG1g4QOLoYOVo8FWY7i2kSRjTNadU7g=;
 b=Wzv1oeBXjxWTdp4aNzoOZOZLFgWPEYiIVpz6oi7i+YTE+xjZLUoiEMgMrTJPj0JMD4MmY/MPtCSICMUHe/Wsw/pj1EoJMnR58wCA3W9tpndYTzX4mgOHleRK0znQdeLESpd2+GTeLEwwuI5jKUrsKpCcVhA6TsPg7QB1wkBz1nltTp25Y1Y+orNRbenzmk8Bcy62P6XozW8b1YjAKMTYOYxFbU+MzLDm4WW0LmU8aisrPElpfNmPEnIURG6YkbXeVzwyboq/a3xTSG4EhNC1xUMpjv/PBwG66XQpBAfkimIPlbxGuIDLTEOpB7UhGOEDO3gNaBmAFVs/kGrYLJ/CZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 08:12:06 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 08:12:05 +0000
Date: Tue, 21 Jul 2026 16:12:01 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, 
	Li Ming <ming.li@zohomail.com>, Lizhi Hou <lizhi.hou@amd.com>, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v10 00/10] lan966x pci device: Add support for SFPs, PCI
 part
Message-ID: <al8ppbyhnmTyjxKN@MWDK4CY14F>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717145147.823749-1-herve.codina@bootlin.com>
X-ClientProxiedBy: TP0P295CA0015.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA0PR12MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: f7078971-03fd-4c95-5fe7-08dee6ffc080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|6133799003|11063799006|13003099007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	16xWH5SkeIGg27/wXyWxtlumq820r3FODJeXY6Fv2hlMVZusrzJPUID0tlok7GAGEjffAWg7Vnl2EnSZdIxSVMUV6F83uHhVcCoNgXFAAZEXOe1iDWXR/ZxgiazG9g73sfhDmk3WaWg67vEvm2K6KxLXdeDl4C5GoOD8e69YiyyUJryEmjaBVhn0149auaBy70zjtTZjFcEZFmT4IZZzhL3MVyFLEfC/bewaB8q2Zz6BtX/w6pBmRxdjCKVYp5Q65cJbiPoBlnMTaBwHRnEHx0eX6o/UnF4wYJYJwMuok/Z42/9T4tgQdX2vOx9T7pF3LHKQwJfkIcMv5WbKHkvXpCGFu9fRkfwxijwCjclY8ZplK4P8qRXx05iDjBE1gM1eamtMAFWft68pAzSS3a56NBETPdaHERvjE1X1bg8OHyHouI3Rka9iUmvGn3pzsg01xJOeoYpwHbEDmkx7dceEvgCSn70H1N39Hmv7tT1r5AES+IcSTiPG/DllwQVpyHLk2PfQu5abP3Lbs3AhiyCjVnSgz1oMCL1wT/tDBVwkSx7EXhuCg1ScAteY8vf1jhJzrNkC852472lrGG2j3g8F95UlT+wfECu3qY9vkHKJ2d7WuYmiblwdYngbw8fac3iWpVUdm71g2PM6jOz+yZGV4ANz1C2ge6AaYggioOJkOJ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(6133799003)(11063799006)(13003099007)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Wn/MHurUakLrdNPzAAqh2mhFiCKQKpm2xU851QnDHoDqgvz6/WcV9MZs1a?=
 =?iso-8859-1?Q?JpWyVUoIMm7U4tl6ATg9jFd4UkMC+PUWtoJXHpmgKACsiCeOJ2XBLdc9tW?=
 =?iso-8859-1?Q?9yzkNN/42EnnUG+Q6WbkoKQTiskC8KeensChdvOLgFXR0T0M65WtUOugVm?=
 =?iso-8859-1?Q?Xdd+2jhA593+IELp2uK5ItM2DeSO5VnX5mtx3+0o0FBW9lcBmNmVOQTvr8?=
 =?iso-8859-1?Q?ijPibLbKUxbRz8fHQwiRmRtqjuZsnEBSOYAVqYJ8zdJ3hXZcrjwmiN2mhp?=
 =?iso-8859-1?Q?VdmygHB792a8B+MF+zZrPZjc076jB32Rp6VGG/c6PR8cs/MtKb0hAKB7If?=
 =?iso-8859-1?Q?gp5VaLv+eMPXBKYy7rAX9Sfv51lL/oBr+T84QmhOIPJakQxfsKsEo6hf5m?=
 =?iso-8859-1?Q?HcjuMNLQ/WYSz3EyOSBbTpO+ZOdUctlPDg4c17w2brIAvcrReE4n50qv/5?=
 =?iso-8859-1?Q?xSOKTgJOsdlCHearUyWdJXeiEHc5H032TdR1JtEQZGI4Z/j2H/4dxWMAaW?=
 =?iso-8859-1?Q?8hTW5gfVwb/jHLJ2NjcHfI3DA81i9dFGldLLAkQrgnq4imwmQvtxn8ikEK?=
 =?iso-8859-1?Q?jF7jYGYuOCODFErelOi3g0Jv7RTkdR8d0h0fFIw0wa5hm1Y6EnjrgnKLlh?=
 =?iso-8859-1?Q?NyI4by0oxP6rwF3iWukUMa7qx8Qz65wA8ZlHe66Wnv1mYGzoHBYjOTDdwN?=
 =?iso-8859-1?Q?rNR3Ku/8ScVi5eBjV4+4xrptFhEqG71P2pNKDZmAw+0s8jSN/g+bqr0uhO?=
 =?iso-8859-1?Q?cIOxl+dRl1SNfDnRBqJCJkwpybsAFNs5mkQJMX+6tkS6+k6d2F7pxPvVhm?=
 =?iso-8859-1?Q?vv1C/CTieoj44yFcjj95E8KWI74UhBohPjKjHMzceu6gqSrOAwyj3/k6KE?=
 =?iso-8859-1?Q?XGikmR+KcT8J4BCtl42EPzD4itRsi2OJKDg6WBomlhLAyn3N6bHHFAd6Ik?=
 =?iso-8859-1?Q?wR+o1/OnrXHKYkvsR5JCX9wMTwo7rqyhwqp0IYleVL4zV4u8oCcrq828tT?=
 =?iso-8859-1?Q?pJJqZxGIZyCeJqivxxPdaI+wZzuQvjFmAYijRXVzTwNhUYwHSbNhjjp6qR?=
 =?iso-8859-1?Q?0qZoKSeUn9x0xZPBP0oO/y0hRp/EHYMi32BE+bA7P7FcYQZvBYi0e8/9PS?=
 =?iso-8859-1?Q?hfubWUxA4PYgpFdcYJzvfN+mHDfcYcX4Rt1/VML2hK05uNi+aB9evqLtiD?=
 =?iso-8859-1?Q?8XVd89cVWpAFbpddtz2294NnTTIylOyVCTnI279KmrYJECKalRnjT0Bwwi?=
 =?iso-8859-1?Q?hm5KSumPX8ZGLaDmDDRWHx2bYmcJ47o0UpQQcyhjSUy8KLfCXPB4ObN0zc?=
 =?iso-8859-1?Q?DhquPYp/k4uTBV0u1UrbjBNcxbGZlwhVkZYJBIcS/GEG3SyuO5dU/SKf6u?=
 =?iso-8859-1?Q?0zlbufWTOyfHOuld4g044M0NOYXyRHb4J9PJ4wic4fo0yBjQwbuq7LRB6O?=
 =?iso-8859-1?Q?sjoduG81U4jZfIhEVKm7IkixXZl4/iz6Fo5o0OagN7+saGx1h/4r1vU+TA?=
 =?iso-8859-1?Q?74AH15x8746zjgUpwX+qI4Bm8tpvxHrlztRmB2ZGhflw6xRZLJSb19RZl2?=
 =?iso-8859-1?Q?C4SSJNRB78YTdvZvPTOIzssuQAZvX61viZhXh2OasLBhUR57MxqcEUaRcD?=
 =?iso-8859-1?Q?/EmLCs2Q14Qm0alDMjCiZbof6gCgwOsMam+8LgNc3SgNfwfPmtmAKLSYa3?=
 =?iso-8859-1?Q?liUOnSrMv9/L9NVz3BFOzkd6kJ5PAXMC7ipggdkzePdAYLvuUuhs0VMEPw?=
 =?iso-8859-1?Q?iODS/4X1th+g0+isQox3k3QyX+qv6T5mHuPlxRQ93+e2H21P2zCYVqmIay?=
 =?iso-8859-1?Q?reE7pUpgbg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7078971-03fd-4c95-5fe7-08dee6ffc080
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 08:12:05.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUlIchG5XamWKNEOeUOSLEnTitJpFzmrTFb8Le0oKng9HQ8ZgNultywUqr11aINU+pvG8m24IufnkAloE1Q66w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349

On Fri, Jul 17, 2026 at 04:51:35PM +0800, Herve Codina wrote:
> Hi,
> 
> Previously, I sent a big picture series adding support for SFP ports
> available on the LAN966x PCI device [0].
> 
> In this series patches touch several parts and sub-system in the kernel.
> Reviews have be done and it makes sense to split the series and send
> parts separately.
> 
> This current series is the extraction of patches related to issues in
> the PCI subsystem. It has to be seen as a continuation of the big
> picture series but related to this specific core part.
> 
> Patches 1 to 6 introduce and use fw_devlink_set_device() in already
> existing code. No functional change but the introduction of the
> fw_devlink_set_device() wrapper.
> 
> Patch 7 avoid a dangling pointer.
> 
> Patches 8 and 9 fix fw_devlink issues specific to PCI and the
> device-tree nodes created during enumeration.
> 
> Patch 10 adds a guards to prevent incorrect node removal.
> 
> [0] https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/
> 
> Best regards,
> Hervé
>

Hello Herve,

Just a small question in patch 10.

Otherwise, LGTM.

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng.
 
> Changes:
> 
> v9 -> v10
>   v9: https://lore.kernel.org/all/20260708100302.517792-1-herve.codina@bootlin.com/
> 
>   - Patches 1 to 6
>     No changes
> 
>   - Patch 7
>     Clear fwnode->dev also on error path.
> 
>   - Patch 8
>     Clear fwnode->dev also on error path.
> 
>   - Patch 9
>     No changes
> 
>   - Patch 10 (New patch in v10)
>     Guard against node removal with incorrect np->data.
> 
> v8 -> v9
>   v8: https://lore.kernel.org/all/20260630102804.413563-1-herve.codina@bootlin.com/
> 
>   - Patch 7 (new patch in v9)
>     Clear fwnode->dev during root bridge node removal (avoid a dangling
>     pointer).
> 
>   - Patch 8 (patch 7 in v8)
>     Clear fwnode->dev during PCI device node removal.
> 
> v7 -> v8
>   v7: https://lore.kernel.org/all/20260511155930.34604-1-herve.codina@bootlin.com/
> 
>   Rebase on top of v7.2-rc1
> 
>   - patches 4 and 5
>     Add 'Reviewed-by: Andy Shevchenko'
> 
>   - Other Patches
>     No other changes
> 
> v6 -> v7
> 
>   Rebase on top of v7.1-rc1
> 
>   - Patch 1
>      Add Cc stable. Needed for patches 11 and 12
> 
>   - Patches 2 to 5
>     No changes
> 
>   - Patch 6
>      Add Cc stable. Needed for patch 13
>      Add 'Acked-by: Bjorn Helgaas'
> 
>   - Patch 7
>      Fix a typo in commit log
>      Add Fixes tag + Cc stable
>      Add 'Acked-by: Bjorn Helgaas'
> 
>   - Patch 8
>      Add Fixes tag + Cc stable
>      Add 'Acked-by: Bjorn Helgaas'
> Older iterations:
>   Patches 6 to 13 in the big picture series
>   https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/
> 
> Herve Codina (10):
>   driver core: fw_devlink: Introduce fw_devlink_set_device()
>   drivers: core: Use fw_devlink_set_device()
>   pinctrl: cs42l43: Use fw_devlink_set_device()
>   cxl/test: Use device_set_node()
>   cxl/test: Use fw_devlink_set_device()
>   PCI: of: Use fw_devlink_set_device()
>   PCI: of: Clear fwnode->dev during root bridge node removal and error
>     path
>   PCI: of: Set fwnode device of newly created PCI device nodes
>   PCI: of: Remove fwnode_dev_initialized() call for a PCI root bridge
>     node
>   PCI: of: Guard against node removal with incorrect np->data
> 
>  drivers/base/core.c                      |  4 ++--
>  drivers/pci/of.c                         | 24 ++++++++++++++++++------
>  drivers/pinctrl/cirrus/pinctrl-cs42l43.c |  2 +-
>  include/linux/fwnode.h                   |  6 ++++++
>  tools/testing/cxl/test/cxl.c             |  4 ++--
>  5 files changed, 29 insertions(+), 11 deletions(-)
> 
> -- 
> 2.55.0
> 
