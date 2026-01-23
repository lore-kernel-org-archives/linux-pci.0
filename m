Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021100.outbound.protection.outlook.com [40.107.74.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC63346A08;
	Fri, 23 Jan 2026 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152276; cv=fail; b=FIH/9zmMep+cFjWENXHPGOtVMDICl8157ZCq3Rg1nuHrEFptodCNWKpJnaFjyJGxn4ia9zgs3cTn7IaNcHn09QYI0hhSFZycNJx7t7nz9eCow5MWsi+oJNkwvuz2w6a+rW1EsGUsGGgOcEfnlKM+T3i6E8N0cus6U1t5VhF/+xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152276; c=relaxed/simple;
	bh=PD2zaDueUPSzZ7sE945pcZpdVm8nLqsbf3p4RELxV2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eYqpGKH84F+ILoUiSLQTm/3nejvQagS+HEVUCQWp60CxSwBTXsTA9WTqlkBumgxMvoG8RrwHmnq9BaqpuSwQVEe0GUAHrO7WjQm53G4Rhe+qGBj/cDYr9ncwEio2FHp69uxFwU5w93rgzqgwj2wcfaVZ5xhs3TuL+8NxNTDMvgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Jzvves44; arc=fail smtp.client-ip=40.107.74.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Jzvves44"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUss+JSCn5mYiECPLTOl16o1LlzoD4tQWfGat0RyPXYRxzz/MmS4z8eSnDiLlGIQvi4IcRrPG89xOAPHaDOq8747qYiHAXjJUh0Pirb9XJd4ZK8xdfPFbylDps9sy50ZPIw5SpIWhcWAR73uXEMDpNhhNNcbrRMfdgFX5Mt6NetmxNpPU5PR6ymIXI7xrRim0r1DIB+4AkMCxTh6xT28RxB2dnJwxbLiC9A8vFk/q5r4g4+HZsiCeM87E8B3z/jSjOS0++jie5VI6k8au3vLDB1b84ePQplvtKi563pAAEq0HNmnP3T2kvU2cJ+9cxJlEDdisRz60tf11lmrGwgcXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Zei8yQkGMwZCJr38tz99mhLtU9e2/Mov4NBqNjJHiQ=;
 b=mBdPdTsPeQONg56oo7dO508Hp73adNZSzSG3qN5kzegFQ5AcNCzmqVdPFwRURrp3k/OUvjjOG+jY8kgeFynTKCYDao8EB4Nusg82Nl0SOGXID4ueYhNp9709N52lxI4yXFFIUBDsLRIGFPYSBhD2UdTn0o2wwnC9X1Trlj4sSJQDIqcwXfyUnCu1ytE0787UgaMyd0LN3u8GEVUFC5NTDS9Lge055nkiVktXtolmcaMI/HhA8gLn3kkxusHm5Ilth2Rhhs/5camoYcnoj1CI/Gwg63E5ZLcaPwO/FOarB4YrCpOCR+kL4V1IL16S6ljxwnpCi942KQ50nw/FUJOuQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Zei8yQkGMwZCJr38tz99mhLtU9e2/Mov4NBqNjJHiQ=;
 b=Jzvves44G5Mk5b2XUru1NOCqkdizDpb9zNqnL7OyWYesGTQ+HfGth3vggHqm8amKVZ7irSzHlJEKxb+z6HRGwGna+xwQ4ho9ixyTfNrxb2Gei/6SNqFDtXtpP7IrYEFqVAPeQ2bq/pyjRC1qw6KppUFySmpi+PO6XPzabynYzZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4713.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 07:11:10 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 07:11:09 +0000
Date: Fri, 23 Jan 2026 16:11:08 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com, 
	kwilczynski@kernel.org, frank.li@nxp.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <nrvamhbpi4372c4qmb2q3h74irrqkntlb2rwfasiorgavylp25@rx2lp6ldk64j>
References: <20260115084928.55701-1-den@valinux.co.jp>
 <x64g63zkz5t75vxxlzd7rhbvpus2mmhz2phyvxykuax5wm5cnh@zgpomauf75pv>
 <ugxohcm4tvtjwnhkkz7jw226upm7o5hihohzn2f4eoamhkd77v@mjefdgxneghm>
 <waapztvy6jyjqtfcoo3rbgvagi4z3p5afw6x2acgf5bxatcui6@nkodhtqqtetr>
 <aXHfUyd0EPFnoVBO@ryzen>
 <tvaumsi4ahosz4herbxoc636fj3lhetjzqlwp5n4e34tthmn26@bld32k6xntmw>
 <aXI_ny1-5NlN8r_z@ryzen>
 <ajuq5dpbzzoghd2hk7cz6w4t6jzcxfmygbyiciqjjhhg6ipkoh@usuhzmne6cap>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajuq5dpbzzoghd2hk7cz6w4t6jzcxfmygbyiciqjjhhg6ipkoh@usuhzmne6cap>
X-ClientProxiedBy: TY4PR01CA0108.jpnprd01.prod.outlook.com
 (2603:1096:405:378::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4713:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a232b3e-0dd9-473f-3151-08de5a4e955b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cIPMc+7sWjVqf90rVHrwsF4nj3+J0FX+pDK0CMytCnZd/2o5YkYyySvH+MPP?=
 =?us-ascii?Q?GoTaNDcr0w5jamg468uu4DtrCtErXxj72V3TaDQnp8gpmpDeI96Mh70PA2qC?=
 =?us-ascii?Q?FjO+NelliKsvk8L0LJJ1B3dLNqTR9CdxAwSSkKEkn+Or1Mc/QL7k3tXlWLjx?=
 =?us-ascii?Q?3lg9hO3omhh4yyEQn1Dyif/k10Uq9ugsqsA/orUC6as/qrKTSJZzsOM06InL?=
 =?us-ascii?Q?SnZc5MW/yeTV9rcWJG0jMxgbNXMEdvybwyp7EvdHf8bfg09dzDxDcG86A3Xs?=
 =?us-ascii?Q?K1qc0gQsBr4CHr/wHnla95jyYYMkmI9A+kp90M6y6IZrfTuR4qtn+CK4+468?=
 =?us-ascii?Q?dtJCqbZ0mMoZ4ANMgXDLnSjwQMqXMp8dUpOOUcYSp6T+YZhlRsNnAdflpWpD?=
 =?us-ascii?Q?OcoeHJbxTgYxAfBMl9hLSkBZmeatsqJXTELdIaq6JWUDVpkeZfRhAN6pWASH?=
 =?us-ascii?Q?1P33n13XJfKK5P74cpN6WP6ZnfDKx8Zti/BYz76hf3TgDilm7zlnUXDD4MtM?=
 =?us-ascii?Q?zDCXRQNbyUIKbp5h+fBrPxAVrhesLXJqUJ9db/Dzt0N/VjiMpZGpI307q4LD?=
 =?us-ascii?Q?FdX6UpjpoyenKtu6ouw2cEddx3jaeeuzsf0/zo3izxsKrrm9L4ol12T+qaur?=
 =?us-ascii?Q?s3wA/ZQPWiPOQierm8XBXFQaQNvz4VLbqVpTb81ePbR0cOm2ebWeqCzAH8rA?=
 =?us-ascii?Q?4kSig07l8FS4TyaNluxQ92c+vbD419YFVo9q9pNqAyHNZloVmLRHJBj4V6rv?=
 =?us-ascii?Q?9sA/I8kyAzKPffi7429YG2/Q95Wz383kuP5jXLx3EPM4jWWQTEbFGghcxpiU?=
 =?us-ascii?Q?Jix+q4QzVt+vLI5LvhfSQhiTmI6Su+Rsq1tBhQ6iLZ+CFn8nyWkslQG5rRCV?=
 =?us-ascii?Q?n7wVBPBULJT06fQlw15XoM4oku6NnA/5cdiednCvPTZB4EVtFN6vl/i/Cjs/?=
 =?us-ascii?Q?1ZW8/zON0zMQWhm94eHUgwdan7C27lF2VoR8aLQp1dV1dr/hUW9wPv5xzFgJ?=
 =?us-ascii?Q?EY4J0LiGaDGsBSVHGhWh5jP9OjOIxu/fR+jY+GYhzjLo0c5WuemkrN6CPpqn?=
 =?us-ascii?Q?ETkasHVJwQhVsxqnKcVOHiZY/ruIbtSYGwvc2BSkdy9HBhi2dnOElH+8KHmx?=
 =?us-ascii?Q?Oswd8Y4sox2zPTIBBxpJajD1abOb13uzJRdDStCyVK/YCBrUfsFGpLlPNv3x?=
 =?us-ascii?Q?4L4St0tsDNJu/zj6Ga9aNqp3lKbhYsiKj4JaQIvq/nfhYj6nDr/JdYgpSse5?=
 =?us-ascii?Q?CBLAtqujEgClvQYZ8/Nw1y5Lz538WiteYxr1kBPOHgIRKkgqT2J48PGpbc2m?=
 =?us-ascii?Q?GTrJk0I4xcx2DsVyNHfyHj6xWeAXdN7rXyCxObckN+6neo5790YFE1MxuzbT?=
 =?us-ascii?Q?rxoasr7bYd8cjtRNJFG+6QU3xd8jTefmCglstf9EP9tAltPZ5GwYzLazlv2W?=
 =?us-ascii?Q?4hpYOi/9BdLoFtb9HhvwrqGQqzKWSvdwrEJr8ZW0nu+sg0Ad5iliaPUBrSxR?=
 =?us-ascii?Q?PrycUSMyGECdjfhzGPNsqQcD96yF8BYzp3mAjYvv4PmcoJIcLI9oNd0xUL/Y?=
 =?us-ascii?Q?AJnsj0Uq9amligG5Mhw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tW+RWk7yfqk1FYMwbAEzFBUObO0iGGZWwahktE34rbLE6VW1kPnExoh3BQ5W?=
 =?us-ascii?Q?68AaMfdAY6p7I91kDTsMt6Ox5mG/hwEfNQzh2UTeTgfLNkcicqLI8RTSxjjh?=
 =?us-ascii?Q?hyq0HD4Foa8wzkFl0PAPu0c0bourjZsI3JVu4HwxgJficrSUrOqofO++7jwt?=
 =?us-ascii?Q?9Cuxj7WPJ9Nj7ovXWNhTTdO48nUe1GRLUJdH8Wt7d8CB/TIlhncEsybOw7lj?=
 =?us-ascii?Q?uB6Qp+C/XtAMN8vV6/wPMUAjAOi4M+GEqTVve+dgOGi0rCzdwB4nz7v6H7CE?=
 =?us-ascii?Q?JXY2l1pg0zuwIn1dRxjBJfE167LVzv0DfW9ET/zT1Qoc3KQMqHHx2Yk7skrM?=
 =?us-ascii?Q?5aY6jsD32b8RiojLL1n9uCoaDMAq1gSLgAXk8y+eCLACXAgiPx7Xqrhjbny9?=
 =?us-ascii?Q?v0dXvEuQ5f3RaCCjmRZZILAIExBbHZRormv9tGCzXtCjLc6vyvwaQsEp5z18?=
 =?us-ascii?Q?PSlJEiYV82KIdrNa5C1ZM4kLnOog61mlFsVQDqEnlm3RtdlTbgUgEjAA2Ixo?=
 =?us-ascii?Q?vj2Uq5ykRJrldKZBWFVuADo3HvnMX42G84At1IGnfy8npE+NJHUktXlkNSs9?=
 =?us-ascii?Q?7PeQyCsqqKjYnF46gn9F3dwEYvx2skz8PcIWqWuy3WFYgeI0wjgakB300NeA?=
 =?us-ascii?Q?qso/2bHeFyOi0APNiTWpvXoS86DKGTue9tKezsAt+dcetL2ZEJ3Ka912QcEc?=
 =?us-ascii?Q?5/MJFkAzLQp6v69N5vzf51MZPrvi92Ao7YK4+VNW4aFp9SE/Zl9Y8zvlEbVG?=
 =?us-ascii?Q?BHdWbeeuXEkXOPK6Lb+RFUpCwoyKxNjM0yCHBsv6YxlJrT85LlRqfuFM2wp8?=
 =?us-ascii?Q?Ccyf7ACxCWlL5j8uy96jmiCukVpxqX1J+RhbH8MKbnN0J1tvl4dyUBuDO1Hc?=
 =?us-ascii?Q?Idezmf0Tym50P5yFgIgbiLPHfXwl2D7oV5unO4GugiFsEZctMkOvF7IaRjSS?=
 =?us-ascii?Q?6i0Mi0rGkWrIEcboGVD+gEH9GU5NXDMA1Bv1qwlciifMXVGFQfWdVQXL74Zv?=
 =?us-ascii?Q?LFQfUNo9lTZtsNIujjGwn5CruzKUmqe1Zfy1qzPmpYCYKN4QtqKlATV0CMHl?=
 =?us-ascii?Q?jWE+hGMZWXQewPL4NeF18j+g6z2ALSDeDwuTX1AL3uf4dHi4fQ+MVOe/smpR?=
 =?us-ascii?Q?8/fP4oV6BCSWTgULyrPdlhCGqv6WsIXsC4va2nXq/b9trY9etVOvRoQA9W7t?=
 =?us-ascii?Q?QwhRXzFxqA4HPnO0eH/c1SZKpUZzSKpXuA2j7h15I1RqavLoKOxoYiGBmvD8?=
 =?us-ascii?Q?cUGT53IlVdNsRs5y1iYIuDuZVlyMqlL2DFmc0l3rZZDxWl96ujXkJA6I3iBy?=
 =?us-ascii?Q?A9jwKWiAatqGyfFwitAr/j4mAPKO1JemXeiknEdusAVCvuGMHD838ZYrxeXh?=
 =?us-ascii?Q?lbqXfyUD+7GY9T8yjv/Ot85uifqiGSknH3DFB9hem1Ld2hbIsLZl9pvVb1PA?=
 =?us-ascii?Q?/u/WzKzbQWD4m/Ixad6YoJnseldf87/kGNarTBg5okbhBhzoX+nL3dmO0qbK?=
 =?us-ascii?Q?Nj3LZBQ+WcTK/Xmb5cY7MkboEb1VB77YrxZQ4+3G/5lRRoFcw0jH0m6iTkop?=
 =?us-ascii?Q?uiyB9xrl3IxZ7dRsO6YFneOIR4QneOKJoh4wZV7S2OzS2WzQrYy3RAYXruQX?=
 =?us-ascii?Q?gMbgvC6JydSRZ0s680jeNnWhS31S39GLYuzqQmO/QmRpnOPNJuqPqdzw8E/d?=
 =?us-ascii?Q?rGj25LamqlPogbm+1BL90QVXjk2sWvgBuasQtphzjUUMQ30CtV1hr508E48z?=
 =?us-ascii?Q?3mfk7ZyvhC//qe4wCwTflukvEo432XSJYhn75IDWDBB14JvMrMll?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a232b3e-0dd9-473f-3151-08de5a4e955b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 07:11:09.4117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzhwziZTWU9WOIXLe90l7nSD+p/43Y8B4OCx2gR9viujNqt7YhHn40OP9KZGa1guZvAT3g7/QacELMxykPoHeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4713

On Fri, Jan 23, 2026 at 09:36:27AM +0900, Koichiro Den wrote:
> On Thu, Jan 22, 2026 at 04:17:51PM +0100, Niklas Cassel wrote:
> > On Thu, Jan 22, 2026 at 11:02:42PM +0900, Koichiro Den wrote:
> > > On Thu, Jan 22, 2026 at 09:45:13AM +0100, Niklas Cassel wrote:
> > > > Hello Koichiro,
> > > > 
> > > > On Thu, Jan 22, 2026 at 10:52:31AM +0900, Koichiro Den wrote:
> > > > > > 
> > > > > > In this series you didn't add a consumer of this subrange mapping, which I
> > > > > > believe is the epf-vntb driver [1]. Even so I don't see a justification of why
> > > > > > the BAR needs to be split into multiple subranges. Can you explain that?
> > > > > 
> > > > > Yes, the first consumer I have in mind is epf-vntb / remote eDMA-backed NTB
> > > > > work referenced in [1].
> > > > 
> > > > Another consumer in your RFC series is pci-epf-test, specifically:
> > > > [RFC PATCH v4 35/38] PCI: endpoint: pci-epf-test: Add pci_epf_test_next_free_bar() helper
> > > > [RFC PATCH v4 36/38] PCI: endpoint: pci-epf-test: Add remote eDMA-backed mode
> > > > [RFC PATCH v4 37/38] misc: pci_endpoint_test: Add remote eDMA transfer test mode
> > > > [RFC PATCH v4 38/38] selftests: pci_endpoint: Add remote eDMA transfer coverage
> > > > 
> > > > where the pci-epf-test exports the eDMA registers (using subranges) over a
> > > > BAR, and then in the host side driver, calls dw_edma_probe() on this subrange
> > > > and uses the host side driver to control the eDMA residing in the endpoint.
> > > > 
> > > > Most of your patches in [RFC PATCH v4 35/38] have NTB prefix.
> > > > 
> > > > Would it not be possible to simply include patches 35-38 in this series,
> > > > so we actually have a consumer, or do you need some other patches as well?
> > > 
> > > Sorry, I sent v9 just a few minutes after your email, without noticing it,
> > > and then I was AFK for several hours.
> > > 
> > > > 
> > > > E.g., perhaps
> > > > [RFC PATCH v4 01/38] dmaengine: dw-edma: Export helper to get integrated register window
> > > > 
> > > > Would also be required?
> > > 
> > > Yes, please see the section "Patch layout" in:
> > > https://lore.kernel.org/all/20260118135440.1958279-1-den@valinux.co.jp/
> > > 
> > >   [...]
> > >   1. dw-edma / DesignWare EP helpers needed for remote embedded-DMA (export
> > >      register/LL windows, IRQ routing control, etc.)
> > > 
> > >      Patch 01 : dmaengine: dw-edma: Export helper to get integrated register window
> > >      Patch 02 : dmaengine: dw-edma: Add per-channel interrupt routing control
> > >      Patch 03 : dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
> > >      Patch 04 : dmaengine: dw-edma: Add notify-only channels support
> > >      Patch 05 : dmaengine: dw-edma: Add a helper to query linked-list region
> > > 
> > > Patches [RFC PATCH v4 01/38] through [RFC PATCH v4 05/38] are prerequisites
> > > for the PCI test update, in addition to this "PCI: endpoint: BAR subrange
> > > mapping support" series. Note that this series is described in "Kernel
> > > base / dependencies" section of the large RFC series cover letter.
> > > 
> > > For this reason, those test cases cannot be included in this series.
> > 
> > Ok, I assumed that some of those 5 patches were either eDMA optimizations
> > or things needed for NTB.
> > 
> > But if you need them even to just probe the eDMA driver on the host side
> > (using registers from the remote eDMA), then perhaps it is too much.
> > 
> > I was hoping that we could at least have a very simple test,
> > e.g. pci-endpoint-test only supporting READ or WRITE using remote eDMA.
> 
> If we were to add a simple test in this series, I think it would be
> something like BAR_SUBRANGE_TEST (beside BAR_TEST), which dynamically
> triggers subrange mapping on the EP side if supported, and performs
> read/write to those subranges. That would keep the test focused on
> validating the subrange mapping functionality, and would not involve remote
> eDMA. What do you think?

One additional concern if we were to add a subrange mapping test is that
the EP-side pci-epf-test.c currently defines bar_size as follows:

  static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
  (see https://github.com/torvalds/linux/blob/v6.19-rc6/drivers/pci/endpoint/functions/pci-epf-test.c#L105)

The values 512 (BAR0/1) and 1024 (BAR2) are even smaller than the minimam
CX_ATU_MIN_REGION_SIZE (=4KB). This means that introducing
BAR_SUBRANGE_TEST would likely require one of the following:

  (a). raising these hard-coded values
  (b). reserving a dedicated BAR for the subrange mapping test
  (c). limiting the testing to BAR3/4/5 if available (though, for
       example, no BAR would pass the test on R-Car Spider which I'm
       testing on, where BAR4 is fixed 256B).

I'm wondering whether there is a clean way to add a subrange mapping test
without significantly reshaping pci-epf-test.

Regards,
Koichiro

> 
> Koichiro
> 
> > 
> > At least then we would have a consumer part of this series.
> > 
> > pci-endpoint-test could have been further extended in a follow up series
> > if there were some eDMA driver patches that were needed for more complex
> > operations than a simple READ or WRITE using remote eDMA.
> > 
> > 
> > Kind regards,
> > Niklas
