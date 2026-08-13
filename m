Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB6D3368AA;
	Thu, 13 Aug 2026 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786649442; cv=fail; b=LY9LljmEUQ+VKxlpUuNtoJ/DpnJTJu4nTjwEQiuR5E0Z83pRcrPcgLp4HFrJFB26/dUisTZjXWnDUXAsxizI//T063sLR4iCArlIRDLqUTKOfOVVp+X9iWEc9sYDftJDynAH7NANsTOPEl894W9G/PQ6nPxmeb0+DP2soMSUTAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786649442; c=relaxed/simple;
	bh=YZQpaWBwXeRMouZ4l1kWjAxte8qYaFcdCs3Gl4YGlYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ii64ojPLCxtwB7IaXfD7U0g3Zz1Fi/1XDsU03rEqF6KM3q1qUP+zcOOdilCxc7r3Xvhf1VINIspsvr4go63CVUzboNJRQHEsgVXLtaolTDGk6+Ij59kMJYO5ujj9FEP8b23c/ekEtBi8JWEiliQ6e+3PWVKbpTBD7+jErYUGgSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aE/wlMGW; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aE/wlMGW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZ/PFHUmgu/yhe8ImVSr1IIelqlIwBVfjK0qC/L2Y6sbyy4JGVmZ/1y/9Cf8C/7MHGNXc/SlYOkf8MXubYTTsvbqZj7m6bd7t+GsTYp7qPvoeaJeHMWJHRAk4M5GKq6vmC2V46gtGroOpeB4tJAfuzjqijLaJPUt5SsQMz8aWohwgW7B2NBGN8Au4g16DYuNjZKSOogrOj0V9bRgHO5AQymZ9sS515GhfcNO2GAS0PO30UJf0fwVBYxAG4/xP4+Fska2A8cX1MKe6L7p8IXdwM4J8YmIIL3l7nDV9gVSxybtm0TC/jWaMtnnpFYyI0UPcvdfM//loWQX+wAO0OCcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZQpaWBwXeRMouZ4l1kWjAxte8qYaFcdCs3Gl4YGlYI=;
 b=SJt3FCzIsPdnATfJWmq1ZPjf4sAzyr+wRAiq3Bm3db75RFF2QQz1oI8e/eTd5hVnidKsPrI8MlR3f3lLyNIMRjl6kAfq8DU2pEPqrV8l54Mv5X6vw5LhTa58/A8EcIR61vLTdm9qv4C9/9dXDpwaAEG2zSDQ8VNWRQVQ723zkdH6ctNeIdvCwIr5Umtv9Zcw+m1lFMBsVSOgLj7vNZB+42PsXG40AvDOy2p5oA+/YwHovEf36PcFTHPBtNqUhvOkf1Iq6mhzRsBCksgVYyoeltfsquwTldCM9WEjObvKo5OjQR8Z38RvbOd2F+gCH1KFdzJAur+lVDZ/4WFzhE+dIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZQpaWBwXeRMouZ4l1kWjAxte8qYaFcdCs3Gl4YGlYI=;
 b=aE/wlMGW+6f1euyUqYoLp4JCytkKlNz2tR/wsshy2V6uAiynr6bAY8ySOK1noU4EEIAaJ22BM4Ch4+H75rJ5mYyeDx7/h/xGjE5VhIyXQi5D4uCQlWkJjIjDLDmOnuxM24LPZ+Z2pQFeh4zIcUgQvzJ4n1IJTwEdvada4BSSvISWSyzItihGeNUFYGb7kTp2EhM3TKTg09IbcPfwrYzWLMGrU3+c617kO3YJRoKjCxBGmkyDQqjtYcRRydg5IVSVnDGJyAAwU241/EoHsOME/H8pRQj9FnTiLQAY5uIt0yUfdgV+jeBLZo87kB6Xc7MHC/FbmllJOrAXrk/GxILpxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB12630.eurprd04.prod.outlook.com (2603:10a6:150:36a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 19:30:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 19:30:34 +0000
Date: Thu, 13 Aug 2026 14:30:25 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 00/10] PCI: endpoint: Add PCI DMA endpoint function
Message-ID: <an4bURIXbY5x3TUL@SMW015318>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <an2uf5mXzGq1Q7cj@ryzen>
 <zoed4wtc4oxiyni4o5qpj3li3cmlyy5kfutp4r5g4d63u52625@j6rvbbehjgov>
 <ztn47y23ctbjrbkmgyyhc6d5x3i2lzz5txotpgtbjtcsvbsvf4@fzadsvt5fl4d>
 <an3p_j-F10e9x0vM@SMW015318>
 <tmkvdia53pu2p7hdfmhwcw7rurjx3yf672xoxrcu2ubaz5gmrd@ypo76y6fuz7v>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tmkvdia53pu2p7hdfmhwcw7rurjx3yf672xoxrcu2ubaz5gmrd@ypo76y6fuz7v>
X-ClientProxiedBy: SN7P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB12630:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ed4a27-67e9-408a-2638-08def971582b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|23010399003|366016|6133799003|18002099003|22082099003|56012099006|3023799007|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	zmDqYQOGHd28iKqzlMep905+zXOrF2WzvuZERaKVtHNQIL0n1fDs3bzyhEHTRd+tmqDQ8Xh6xiOgkQ3KXDzvE33K9pbNF2ioy5KPQlKEzlOVYlnsrL7BhhwOMrHiZIeUB0P8l9y04ilXg3Lc6FaAAfixJbinpBqmpbYFzqjuuPxstWLXXPMUSezbSL0Q4r6ROpo+x2nq2gr9yOVx7JH71IGJt0bqDdRCej3bjVoxYIchA0yXGvAOpWmHHVUjuA5p51SEyLKbE4B80Ia+fmiKXD+j+FvPCYyo19NKdwNaze+opKHEIwMUItMJUeM5M9NFt8JX5NjNkRt/egXAuhdX6g8MYta/bv8aQYrS7BHI11I/ISW2dBveQOQRTAr9zlD9Y21d9IlwhBLApXYr45ez7xE66tcAftRVcjWiQQZTCiMJhiMblnVW/tJEBHpv9MB6m4dYMBodQMIAG05DWyLl7FnemzanMbo+gnq6BtmN4PqavmJDMS6fjerO669Of/83bbsnS3W6LxdTevopv2UWcoNaPTRnP8e5kVlO49VEGpzsZ4dRlf9l+9sXFx5Q8vUNdhtGX2owRUaK3yiB41lHkHZY8gzKoXDJDdPp9qqlFidBsLcmM9JhY8zWIuYvcSe+lA9L5GhXTILkCAolIpk3dExaCqe13k3k/RYlkJ/fHt8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(3023799007)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTVPcUNtVzlnYVJ3MzlwbmJPWUVYRzJrMkdOdFVQYmNlS0twWkF3KytBOVNI?=
 =?utf-8?B?Y0FCcmVKMFRCUEY3WEd3SVY0dmk0SkJLYXA2ajlJd3F3NmxBdjZDWVJEY3I4?=
 =?utf-8?B?OFlkeTFBOEc2QWNJY1d5R1BkY21XK0xQMUlMN1VqQXdEUDZpYnpvMXBHM1Rj?=
 =?utf-8?B?emN5UEZMT2ZaNDA5RGx2TE9kMno0bytPYy9sWTJPdSs3MWgrRkhoQjU2S0JX?=
 =?utf-8?B?NHZLSXd4Rzh5Zks3dDNJcExJZGZidmRLMHJDME5PZ1IyRU1ZaGRoQXljM0l2?=
 =?utf-8?B?bFF2a2NhUGJDVWZZZm45VDhZL2RmK3h4NklJNVl4N0tmaERNbGhDVGVGRlJq?=
 =?utf-8?B?Ty9uSU1vYXIyY2xwYzI2WWV1c3BDM21hUk0xUnhWV0J5d1R2ckdsK0xiaURH?=
 =?utf-8?B?MkRhNjlBMVVjWTNmdCtUeEgrVUJaNnhaVXJrQlo0Q1djajYxVzB6dmpEcDhm?=
 =?utf-8?B?VnVBeWtCRW5SOTlOV3NtR2tqcVovRUErNG8xU1FMRURTajdrd09VakZjcXU4?=
 =?utf-8?B?S3o4QWJJUjdET3R4TTNIalF5RUw5Rmc2aVp1dnFCKzdZZS94aVZBS3JUbllG?=
 =?utf-8?B?VWZnL2FFQW1vL1pBYnVLSzYvdnUvT2Y2S25HSmdVYzQ1ZU8xSk9nbE5CQmVu?=
 =?utf-8?B?Z2tacHVWZE5sTlFnWUVEYndDNXJvNFROZTlNRnBrbHlybVBkL21WalBoWHJ2?=
 =?utf-8?B?S0t6K0lZOVkzOENvajVmQzVqRnRLNUl4QjF1R0tXS0lhZW1SaDM2cU15MGVa?=
 =?utf-8?B?eEJLQmtPNDdQdTViL255UWIzS21zZGQrbVlyQmFmYnc3OE5jTnBwMjQ1c2xH?=
 =?utf-8?B?SGZPVERRZ2wrSDV1amk3Q0xPU0x2K0xpWkhYMHFTWGtOb0ZpL21HbFFnY292?=
 =?utf-8?B?akY1eEU1MWl4clRIb1ZiWXlHL1RySzB3V1A4QmNodWJjUndhS0pTK0F0TEl4?=
 =?utf-8?B?OWEzM3dmMDBSd1ZSbWJRbDZVY1NMWWFFa0x1VWh1M3ZlNklXWVZ0bGlDa2kw?=
 =?utf-8?B?eGdBaTg3OVVwQUYxVHM3aitrWU9udmVxN05XWVUwRGFoZ054MWNLemlsbU9X?=
 =?utf-8?B?TnBjMDlIbDQyNGU5dmJ2UEtNV29MaStNeUUxaU8rN0NEem8xYmxVQ2hadXoy?=
 =?utf-8?B?RmpYME1UYzE5OGlhMXd0T3NiUmVQRHlaUDFva05JZEdQSFhTMExTanQxRFhD?=
 =?utf-8?B?UE9yOTFZSE9GVVlTSGdiL09LOFJhMW40d1I3YUJ4dEZBSHpIY0tnUE45bWlZ?=
 =?utf-8?B?cG94ZWZBNERFM0ErZUt0K1JnQnIzaXltMXNDYzQ3UXZ2KzVBV20zZWcwcm8v?=
 =?utf-8?B?WHBWb1FTUEVvRDlycEM1QzdOeGdtTnd5YU5NRWMyQVMrNlBFZ3NqbTdUeERF?=
 =?utf-8?B?dlJ4K0FJQUNQdVlGdG8ycFNpY1dkaVdBSGdUQkg2aXVjNFR1YjNkK3BWb0U0?=
 =?utf-8?B?VkNVeUpQNDg4cTJVZlVtMkJYVGZWR0pnaU9FN0twOFlHL3ZHcXZoaFk5MjNo?=
 =?utf-8?B?ZEJOa1dqeUFKYlJCOHJHQm5iNFkrcVA3ZDJLMUNoOVBMMVo3dGJ0T0N5Z3Qz?=
 =?utf-8?B?cDFIcEhpWCtEL2xlUFZmUTBkWkNUczJaRG8zeVhRWlN5NkZSQ3NYRkdyRnpI?=
 =?utf-8?B?aHV2NHpYWnBnNnY3TmRGVFljOXRiQTNxU1NPYlpDcTVqQklINStJaE0vVDFV?=
 =?utf-8?B?Rk04VTNKUkZOS040OEJWTjMrMXBwUlRrTXFrWFhXekZQRmJjdzZ4TGFTK0ln?=
 =?utf-8?B?OG83aENaTDdiSThtUUUwUzNmWHdYa3RYSjVvektmUEM5VXpNeGltbnpRWEN0?=
 =?utf-8?B?TWhmT2FUYVFoZmNEWlpKcGltdG85dnBvYWtFK2crU01sVzJad2djNFdzUVd5?=
 =?utf-8?B?SmF5TXZTNHZ5ZFpLVDNmWFZ5dE1LRkduTEllUHY2Y3lTdFVBak84UnJHcGhW?=
 =?utf-8?B?QVVhVWRXVndsRUhOamNRQlVXVXp5WVlXaFpNZFQ2dDc5RE9tSDVpdWFzdkZR?=
 =?utf-8?B?NFRBV3pZQm9ZZ1NkdjVheG4rb0xXVmVqS1l1dDZwK1ZZTCt3UmlLd29EQ0w5?=
 =?utf-8?B?Z1JWR2V6VXpqcnA2ZDE1RnhwZmlhY2x3cmE4RmttRnRiNmJ0QnlYejd0T1hL?=
 =?utf-8?B?eHI1M3FtMkFkU3FyZlpGcFNtZ2F0Z0t1S3ZYMjBaVlVuYmNCRkQzaVY3TUN3?=
 =?utf-8?B?YTZDYWcwVWU5dTAxMzRLTTdRSmZMeXpIVVgvaW5EQUFlN3BhNXZBdThxSXBJ?=
 =?utf-8?B?dENCYmhYWCtHajl0SmNUQTNBMDFxNFVEVzhwWXZnVzBvSmJNbHRWRWFadG40?=
 =?utf-8?B?eVdMM3ZOQzNMT2ZCM0NaeWRYWU9CQUVJZW02VElWNktldUQ5UXR6RlNteDFS?=
 =?utf-8?Q?gFRMpBDWOM4mTy9YISjnOPrH1KcIgrAMYjC3E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ed4a27-67e9-408a-2638-08def971582b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 19:30:34.2454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dU8vSV9Oq7NVpR8E0sWtMni9DK1otpbTHzq30hdsaqZE4o/f7Qev9glxoBauoaSd16E38QvNdGDo3dyjaw4sgWI1PkpShEZkLyP4HLTsdxTWtqrahi/Tmhs7CXLl+5dF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12630

On Fri, Aug 14, 2026 at 02:04:17AM +0900, Koichiro Den wrote:
> On Thu, Aug 13, 2026 at 10:59:58AM -0500, Frank Li wrote:
> > On Thu, Aug 13, 2026 at 11:15:31PM +0900, Koichiro Den wrote:
> > > On Thu, Aug 13, 2026 at 02:50:59PM +0200, Manivannan Sadhasivam wrote:
> > > > On Thu, Aug 13, 2026 at 01:46:07PM +0200, Niklas Cassel wrote:
> > > > > Hello Koichiro,
> > > > >
> > > > > On Thu, Aug 13, 2026 at 03:37:47PM +0900, Koichiro Den wrote:
> > > > > > This is v7, the remaining patch set for PCI endpoint DMA.
> > > > > > Parts 2 and 3 were merged per Frank's suggestion.
> > > > >
> > > > > (snip)
> > > > >
> > > > > > One open question is how to support endpoint controllers with only one
> > > > > > PF. Keeping DMA in a separate EPF requires multi-function endpoint
> > > > > > support. Folding it into vNTB would work on single-function
> > > > > > controllers, but would also couple the two implementations. This series
> > > > > > keeps the separate EPF model.
> > > > >
> > > > > I see all the work you are putting in and I admire the effort.
> > > > >
> > > > > This is now v7. I think it is time that we close the open question by
> > > > > waiting for a reply from the PCI endpoint maintainers' opinion on the
> > > > > design before continuing. (I am not a PCI endpoint maintainer.)
> > > > >
> > > > > I understand that you want a common DMA abstraction, that can represent
> > > > > different (embedded) DMA controllers on the endpoint side.
> > > > >
> > > > > But if vNTB is the only consumer of this, then why not simply embed this
> > > > > DMA abstraction in some BAR exposed by the vNTB EPF?
> > > > >
> > > > > Looking at the host side driver that goes with the (v)NTB driver:
> > > > > drivers/ntb/hw/epf/ntb_hw_epf.c
> > > > >
> > > > > The BAR layouts are hard coded, and it only supports three different
> > > > > layouts. Would it not be possible to add a fourth layout that has the
> > > > > DMA abstraction somewhere in one of the BARs? ('BAR_DMA' ?)
> > > > >
> > > > >
> > > > > Right now, I wonder if it is not a bit premature optimization to create a
> > > > > DMA EPF, if vNTB will be the only (ever?) user.
> > > > >
> > > >
> > > > Yeah, I feel the same. I haven't seen an usecase to program the DMA controller
> > > > from the host outside of vNTB. This feature is supported mostly because it
> > > > exists in hardware and someone wants to tick the checkbox.
> > > >
> > > > Though, I'm not against doing it within vNTB as Niklas suggested, but
> > > > generalising it in the form of a new EPF driver just for the sake of a single
> > > > driver sounds like an overkill and maintenance burden.
> > > >
> > > > Sorry for saying this in v7. I've been meaning to say it, but somehow ended up
> > > > procrastinating too much.
> > >
> > > No bother. Since Frank has given a lot of feedback on this series, I'd also like
> > > to hear his view.
> > >
> > > I'm fine with either direction, and can revisit the earlier vNTB-embedded
> > > approach:
> > > https://lore.kernel.org/r/sn67hi7kljh7cgmgodatb3naz2astlaklqfobdbxyyzgoohxqb@4nnetbhqwba4/
> >
> > One of the important value is test dw-edma-pcie.c, which generally depend
> > on some fpga hardware. If there are epf driver work as fpga hardware, it
> > will help cover edma remote user case. So more user can test it.
> >
> > Of course, this implement are over complex. I suggest update dma-engine
> > chan_id to support static allocate, which also need be fixed because
> > some drivers have such dependence, anyway need be fixed. After this fix,
> > this patches will become simpler.
> >
> > VNTB case, it'd better put such informaiton into one BARs and work on
> > single-function.
> >
> > I suggest split two things
> >
> > 1 - create simple epf driver to test dw-edma-pcie.c.
> > 2 - vntb support DMA.
> >
> > of course, if shared efforts, it will be great.
>
> Thanks for the feedback. v7 patch 1 adds that exact static chan_id support, so
> you mean this v7 patch 2 ~ 9 can still be simplified enough to make the
> maintenance burden acceptable, right? Please correct me if I misunderstood.

Sorry, I have not realized this new posted patches. let me check.

Frank
>
> I think a large part of the remaining complexity comes from discovery. Ideally,
> the EPF would create a VSEC like existing supported hardware, and put the DMA
> description there. But I could not find a generic way for an EPF to provide
> writable configuration space backing for such a VSEC on a DWC PCIe controller in
> EP mode. That is why this series (sadly) ended up with a BAR protocol. BAR
> subrange mapping use might look complicated, but is still needed on systems
> without a fixed DMA BAR, but the discovery part would otherwise be much simpler.
> I may be missing something I could simplify further.
>
> Best regards,
> Koichiro
>
> >
> > Frank
> >
> > >
> > > Best regards,
> > > Koichiro
> > >
> > > >
> > > > - Mani
> > > >
> > > > --
> > > > மணிவண்ணன் சதாசிவம்
