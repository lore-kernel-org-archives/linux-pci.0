Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021089.outbound.protection.outlook.com [40.107.74.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ABA3DCD9B;
	Tue, 17 Mar 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760479; cv=fail; b=Y1dwja4k1JA0W9x7WmgTAGSYsLfhyUaGUpobrz+lzTKw824Y1xvZpTPgNud/jX4aS9AnhdmdhSwdZkfVWjo8bLkWT6EYw0U8LR1Tt5Id8OPkm6WaHCdAXhbxAIhx3SRfrsPDQBvqyd2BISmP4U4c3rND7YfpkqVsBzOv7nxfWKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760479; c=relaxed/simple;
	bh=HBNT5wXVrf4v4adIuL3KOwoQDtlXYDYTp+XfBeNRuPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D1eDhH0RoFODekuNMK6rTOqKfsxj4Ny3iuKPHbLDQjaj2DzrD3LCyktvLQWRxI13CixWz1pkH7dqLsr2dMhhyv4xKrLsDkk0iOBOuJkLOzFDtV1DMlInHC2xLzp+oLujEgIA4sNrc7R9CzS4qOPXZOFnj0bwTv+2wv1So1TF6J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Ftfr5h3Y; arc=fail smtp.client-ip=40.107.74.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Ftfr5h3Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoVpqdu/q8BD6uYJnvNaAKDr+36CKGZo/Z5nxKrzYbSf21Q0XGcsxEwKKHpeVRTDuIbbI7KCoxeYD81WafkpBdMsZyjKi/2k/so9iWXD6iLFlHqf+1IPHDqcgSWpdUbdrv4XerwRFPP35lcMnlhMQAALtnnw8VuZ6GcNWCdbWxpYFBCzt/aQZgdpNsho1jWjDNqq8xK4cXISoQf/+1GxAIsathcL6PwqPJIIsIf0oTSxNMIXQ9FZ0YTUkicSD117XJvM7RvJOHlVcw01SYyWQqxshiRRHy7R8Htu1xS+tXgA3MhmXEiz9+WTxTv2+c5ct38Mpd5WyJnhFmZ+SRn1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXBueXDKBXDqL8xpImOTHHIuQ1Gx9lOG8ZvX2owEUxQ=;
 b=bNnZ7Vlx/QllYPTefkx6YtIXuuyPOxDKLAbTDvwDh1VChrdnPT+f581+aMMGJdSwaLXwca/nHho79WNWlm3eupchOFywH2GjQAQi6c4khNnc0r7xl4sqlp9CBOdWtCIyBmW2ZGjaPpiR5gkY8F+QIPyCQq21XxhF+enH/oChONW+9FsdJEr3a+Q743FsSu0nvQPrvkXOUwbTDvse8a3CsNjI0BLsvDBWI9yUuAI99V8T5y/TlKn1K9bT7UMnhvns+a6bCFQ5ZkJIRhlMJdXTaZxo3IK1r2/kHSD3Qz77Jrg0+R5vqh/tj1PLtyKVnfYNYZfWIK/kfjUTUUkvYXpOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXBueXDKBXDqL8xpImOTHHIuQ1Gx9lOG8ZvX2owEUxQ=;
 b=Ftfr5h3YwcQm0E91D5ffUSYUysgjpxzBVVSFS4kSklL81nAOWhVM5uKUWVif0o+Ph0A5IsYzlbDmFhNVUnS3WwUlCRQxijQA1Uy6eb4GOV5fKL57N5wZv8fd2B+90J+RBekm7t5S6bYEUF8Cgtd6QMEHVvoKyb0lgODPJ6asUFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2693.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 15:14:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 15:14:32 +0000
Date: Wed, 18 Mar 2026 00:14:31 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Christian Bruel <christian.bruel@foss.st.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
Message-ID: <gbpwik2ad4cuqg3h3wbahhnvvudai3uesmrqinrzknluw555ff@rdkc6i66rge4>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
 <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
 <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com>
 <abkdu_7n_lePaTIY@ryzen>
 <c3039068-1868-4a08-bd0e-0a9e85b85943@foss.st.com>
 <c9278648-1ec1-419e-89ee-0868a4c7c86d@foss.st.com>
 <abkpFpD3cM_cI_nB@ryzen>
 <ee9b1b8e-4bc8-4fd3-932e-9b944516e114@foss.st.com>
 <abkw5dltSWVThJYA@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abkw5dltSWVThJYA@ryzen>
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2693:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d04736-70e3-4e5b-52e1-08de8437e4a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MaM2UT6TWqFkeSpck20eLGdYWx8kBsTOjtoPYpVQschhwbKOg4+1faVje3l6rLf4cAVfG7crB6ZPLWErcT88pdHBocJLnF0+CknAGIQPtpNa3ufUnMlD+UsXlxp/Ecyd+9d8HRjftV17LDVrzmzTpN7UzjBGI56SfkTYRrH5ixn94vDK6PB7O/ChVPm5d6GlERs1QEHPOLmN8G99WqCiCyWQ/Dozok6eglhRoL2OQWJV4DSahZ3XdsaPggKbsLRKB0M5P3vKyJFs1AuextGjqS6MxutG48+5M20Z8L1Vs2xVvgHxJpMEw7NMRTiSmqDBUr2w3WvRaQ665ONNkQSJxs96nWh1vG4YzFb5atvR/Tvn6Mqo64FFTD4Sq3EYN6A+wSilx0GZ5qGUXwkrYJzQhyuBNaGCEpyvhfcGEBQc3GmRDek89tPyQ/FP51m6AHv1FcUs991115AxUimEYMLgt8rwDW0k7SKYnSLworinA0WdxkoY3c/sG6NsU4KlD/y9noc6RboYOYR++q+b+mG3ZG9bP1N6tZ8EFQeXTNiPpmZVUSv/6t4QozbtCOjteA3rOZuzGLLsjXZMi7NS8MMg7pYVRVm+gspZjrO1OF5XKh40RSyBCpzenN59laYMISVvXAhL3PFxhUtd3b3iAWl9TycH1ZnKNCbOLVY5v+iUzF6WCpjiGdbTuJr1uKAnFx8ftxiO31ubj5/c0vWTka/0krqxEmgEII+VjPL5HUT9FLX0noPak8Ly2uHkkCjChOme
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l9cVqQni2ZjcEniaeoaEjWcEYOOOAmOkVb0CXZ1dbaITaYnMPEG1tjGov1BL?=
 =?us-ascii?Q?cmUtGcvhCdq8YpWTbswM/WT40eLlr4CyHPEcp7vbh0XZH3tZTtttiSdPy9hB?=
 =?us-ascii?Q?GvbwluL9FgXIFm7G2oG55LXlReHd8XI7rsN0B/VkBtDnOUfAAmKj50mmvz/4?=
 =?us-ascii?Q?t6gxBpL6peluZKnBPda/3zTyxPoAZdA9oMrJkV75BiBxXXoyhq8L9ObuY0dF?=
 =?us-ascii?Q?tRZxg6gh/yYEOMMZHXvIE+fhhAAMJiIrY1eiBfi924eHcjhg+qjIyjmFufNU?=
 =?us-ascii?Q?i0NXZefJ4JeknltgW/27gXnVlhK9CIWT4l1IkGJBFAvTUEFJJaPwP2PbfVkS?=
 =?us-ascii?Q?PnnN7Q1nGK6PQX0SFfGvzvvShpRlp/BKzG6LDRUFuo0QobnhrC9R/IfGVlf6?=
 =?us-ascii?Q?m7HktNCZGhO4eClSVGj6DL7n2KQFvyns5PGBRissCClsvrwjeqcUgpOaJ993?=
 =?us-ascii?Q?2RX1k3j2IWgeibN5gMqYAI9UstUC2ufEYeF3qViKLr5H/SqhtybkgUWVvtt0?=
 =?us-ascii?Q?A6+bRYvyKiZOt35CpqQwyXuCzNKpKeu6296VWggSjU80NrFWCQfUHzEmV2gA?=
 =?us-ascii?Q?3YyvsQc3KrH+XdjWPGdbSjjd3DHWM8V6KZgp8V7ump8R10cF3ORBuMI3eOC0?=
 =?us-ascii?Q?ZqGiQElKfA3gN7mUDR1LGaLwhIryQromgRi4QPhfYJmniWWj9U5Jgn1x7COp?=
 =?us-ascii?Q?WKG6krgxTffHj10V9+UdCk25LhAPUgPW/8byJRr92icPaVyvCfYGl8Eamtq/?=
 =?us-ascii?Q?fVj8IdUTIc8nbQm8jOYLHrb5N1NUTm0MVjApiJEkqQOpqjprb5PDtZ7j7J4R?=
 =?us-ascii?Q?p4MDEICKDEk5SDWaGNqrzOLayGVGKzLFEEW5xONSXoky5H1+eO7HAknA0dIM?=
 =?us-ascii?Q?y8+c9enl6rNpbFaGspXcT2SbvcCgpbFeaZNfPu9LLe2DJh0PtZZzbtvh0wEc?=
 =?us-ascii?Q?DYLEdHIhwVsg66Y/2PMLuYixNC5EAwyjuTHlnwvu4ps6bKuEML+HMeCAh/9i?=
 =?us-ascii?Q?iEkLlbzOZFMfTqDnZu56blLcl0Tvraospy5BgObNZlUP6aQD0UKwIr5a2Vub?=
 =?us-ascii?Q?H4PDtMm6xzjuuX0BMG/0RPZiwdhWQi/zMA16Wd0otGn+bYSEYQ6HOjIb/zeN?=
 =?us-ascii?Q?83bqwaf3H0RY0BymQelnmYPFxLrGa7Hmw0VVTk4k9UIjl1yj8EwzJuCVgeaM?=
 =?us-ascii?Q?X5MTRCU8g8ZgSQQbxIbqZDe/qlazdJDOz7Io0zNxESCyDcI7k9NuLm/9ktzC?=
 =?us-ascii?Q?S5mrxGbL7S5LAZfy8yWWDczl1IN//7JQRJhtal9sCVMA66KDr/YtsmMB6sfg?=
 =?us-ascii?Q?k7eG/GNbjDZkWqdqtCLjeekM5jDZptdWx3Jn5YaaphMwYZS/j8kzHSFeyLJ0?=
 =?us-ascii?Q?7bfr8nOOVnAMSpW8klD3oYOx3WeYUA3xFUKKkU3Kf2ypgHPyj5yTZB8GFHZT?=
 =?us-ascii?Q?5VzTBMjuVdqaZK/Ga5FP6rgWd7X7uXQlPeMjBgdxyK1Z8kOLzFVoa817T51/?=
 =?us-ascii?Q?a2OG2bgzQXKThBoDy3+efm9J7OfOLzMLbkhw0xDLZLt86uAmaYiz0IvQNFML?=
 =?us-ascii?Q?HteS5MXJZBU76y/6Wi8sLTwws0gvRu0A+Gpx4n+s32Gz3mVDkJA1sDRorH6j?=
 =?us-ascii?Q?PB2n5BGff1T0wnfFBJfhB9jEO2k9eTlCkNHLNe6eUGZ6byU+dlGYcRWyV1A5?=
 =?us-ascii?Q?cpuRw+OJCADtKkEaOJ0VjDFjQshKD4jaDCOMiS+8g+CubQduGtLDVSjI+6gu?=
 =?us-ascii?Q?y8WsoctlKo1v/8650rgMBW+3jikpBIZ/LwuIfykzVlnnP4SheRV6?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d04736-70e3-4e5b-52e1-08de8437e4a3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:14:32.8392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyWzgGCo06xo3azTHLuhSgSfuUOTUFQgbkWJ9DCQLNoQ7Ql4iNfgecp+wxr8oJ7kcMjZbarPXcGfA84+1WmNjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2693

On Tue, Mar 17, 2026 at 11:46:03AM +0100, Niklas Cassel wrote:
> On Tue, Mar 17, 2026 at 11:29:41AM +0100, Christian Bruel wrote:
> > 
> > 
> > On 3/17/26 11:12, Niklas Cassel wrote:
> > > On Tue, Mar 17, 2026 at 11:01:28AM +0100, Christian Bruel wrote:
> > > > 
> > > > 
> > > > > 
> > > > > So we will need to add a SKIP ENOSPC case in TEST_F(pci_ep_bar,
> > > > > BAR_SUBRANGE_TEST)
> > > > > 
> > > > Re-checking this, no need for ENOSPC test. The real condition would be
> > > > EBUSY. Which can be handled nicely in a stm32 ep_map_addr helper.
> > > 
> > > Are you sure that it returns EBUSY and not ENOSPC?
> > > 
> > > I would have expected the error to be ENOSPC when there are no free inbound
> > > window:
> > > https://github.com/torvalds/linux/blob/v7.0-rc4/drivers/pci/controller/dwc/pcie-designware-ep.c#L307-L312
> > 
> > dw_pcie_ep_ib_atu_addr() returns ENOSPC. I was thinking to overload .set_bar
> > with a stm32 helper to return EBUSY if the subrange bar is already reserved.
> > 
> > So whatever is best
> >  - modify TEST_F to SKIP if ENOSPC
> > or
> >  - Add a specific platform .set_bar helper to return EBUSY, already handled
> > in the test.
> 
> I think "modify TEST_F to SKIP if ENOSPC",
> since it will solve the problem for all platforms that have few inbound iATUs.

That sounds like the right direction, though I think we would first need a way
to propagate -ENOSPC back to the host side, instead of just collapsing all
EP-side setup failures into STATUS_BAR_SUBRANGE_SETUP_FAIL, which
pci_endpoint_test currently maps to -EIO.

One question is whether it's always safe to treat -ENOSPC as a pure resource
limitation, rather than something that could also be triggered by other issues
(e.g. a bug).

That said, if preferred, I can prepare a patch (series) for that.

Thanks,
Koichiro

> 
> 
> Kind regards,
> Niklas
