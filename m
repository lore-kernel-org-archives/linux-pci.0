Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020090.outbound.protection.outlook.com [52.101.229.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17715499F16;
	Thu, 13 Aug 2026 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640665; cv=fail; b=jpwsxamXoLAsd+0qwsA/khuhUjDXfsra4g+OaRlsT5uG5iL9+BL+cOwuEOGnbBYoUrftNGPajui+MeMDEJzIuHQlSDwyhVgT7L9g4vn/YqC9kimThEwXIPWgmsyDQjHNHqWd5LVlZOgnTdyuUZ6O+jyJ9MAeJXqs+JTX0DuWOkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640665; c=relaxed/simple;
	bh=rQ3r36XW8V6Uqv4o7m5HtqW0bNJWDo13YJUiMdupwhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JLThqcjXGiOSqL/52XXs6vE6irYj5PbYzdCs9udBmsq12tgrwg3jTqm9U5SAYegc2G9zCFAx6msMrPL4j6JhevNssOLrWAEOSR1dYL7JraYbXxplY+myFxabQ3DNAqy+6RUSdHWFwxF64grUTxcX+xk9Srm8/8iqTIoRBxsfs3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=acZ6vzkc; arc=fail smtp.client-ip=52.101.229.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="acZ6vzkc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Or2GQNe41OMDUYUdxrsHJqw95X3iCw4v2sJ2oONYGCULXaXZXeRY+IpAjpMsahPr/Aj29eKrUpjcdlHxlu/IpGWDDtJOMKdCSOU5Pu3Mzs+oyjHOybTNHP3z4Ld0zfI2aWAivl86X/E8kI8g2/yiKcR1ldYUgQspKgxQGbqZCvdkNG/05ERhNPO52SnbNaUP5OSyRBdQenyCQbXdd2FMCug7KpF2cuXzT2I0xSLz7qECcgMwuCUpUvwXnEobTSovH08n8kKaK7ZY4v4vafE226IpuiiijYpEqHaykHmIIOsMN7Z5RYDrCw0BtUAno8+heZUzu0AnBAD+U9h7s6w+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSppcntJLJrBxMksTmtdDSgu1OZpDZuQ/YyFZZFnVO8=;
 b=eTIir3yLQCMsQP5vpk87ENwAM1LeFvoqZ3h3K8K6qaGvCCQ8LVkhXJThYdJQ61uG+RAdAgClBHnhyxxhx4X7OV3i+5lQKcVwtlYbhaN9QETQRhJ+bLMf2Rxf2c4kWEkWaGsHlXWE0O77ZX3r17rl/0sLaqBERrXxR0m2Kr7oY1UziGCfDL7GyjesENH1jeP9W5YrOITDwNHsETZ6uXu3DnT0WX82GiGZL0IdNC91wXaWLKcad1T2GMmsupzrZlh9Dpd8QuPgDZ6rMDnutorursc2SiYtgZVCigCL9PphVTEYy6DIC32+PIX4YxOTuQs8PmIpSRkWybYa//u1o2DJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSppcntJLJrBxMksTmtdDSgu1OZpDZuQ/YyFZZFnVO8=;
 b=acZ6vzkc5yoFew2v02dL5wNXbuEv7QSCTNFzqJFbpaPzifAUfNE9+us0zYYNcuIg6V4SK6U95s/6ofuGFOXz4CbdkN8weDHFULs3J8wQjRHRyjLVHiUXW7YTgeBHKNBzOvuBkJ4DxPSg5b00il06vK62o5OvWKdWo/kWC75a9y4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB6006.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 17:04:19 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 17:04:19 +0000
Date: Fri, 14 Aug 2026 02:04:17 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Vinod Koul <vkoul@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 00/10] PCI: endpoint: Add PCI DMA endpoint function
Message-ID: <tmkvdia53pu2p7hdfmhwcw7rurjx3yf672xoxrcu2ubaz5gmrd@ypo76y6fuz7v>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <an2uf5mXzGq1Q7cj@ryzen>
 <zoed4wtc4oxiyni4o5qpj3li3cmlyy5kfutp4r5g4d63u52625@j6rvbbehjgov>
 <ztn47y23ctbjrbkmgyyhc6d5x3i2lzz5txotpgtbjtcsvbsvf4@fzadsvt5fl4d>
 <an3p_j-F10e9x0vM@SMW015318>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an3p_j-F10e9x0vM@SMW015318>
X-ClientProxiedBy: TYWPR01CA0039.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: c403c254-d225-43ec-99c4-08def95cea03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10070799003|22082099003|18002099003|56012099006|3023799007|6133799003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	MFNU6PCJCfYu27R1JOjBJjmKmLqy1eoTJlRymSopxWKol481+c2KuZdS2OvKrpGeM5MX6QnXqn1pmuQRZb8bDsSRIu0FR4hElraxENrpKDeS8okPfQx5sIH68ngSzxr2JalULA3OXLRvq2Izgv7pvKpJsipsMTPwdyD5zfRAzWnuCfYkI4zaepDLtn804H7f0y8E4fyMNiZhtDTl/1wCYbiYT0FDxEbC59PTEPYVNNl7aoTx8juCzEBeX5jRBUNMkuJZXIU5DDQJyek1m2bdRFVbTUKrZ8Hw2gNTy9hmK1tFd8O/iGVaGYb8WzQac9/YVwdBacEYN+VUEt8t4GFgKOFsHl3PwhWcTPqpN10FuC7HpBD/82f2oUdA6Aa+xMyX9friu8zaIT1j/Z1EaK3ym3vIMsvkFZySsgFQjh28wgPpSCTSnjLK3dehaoEd11CQWPKCE3SecQMemQHP4029ReZ4Pch3mmBOGQrDfJ1l4lysZmJdXIAa6WyAxtbA+kdO8JljQ6nSnxoCiUB6R85CzUpzZKm+idrB5oH8ezgbqINosw+S7a6Lzd4Ax/j4OKD8hMCpKVsUu1yeBvS1+Cz2uLkjfQF6++P6bzFI5Jr5CMocChwiyLlNWOdPFDX5map8cYw8BC0RQgc7giUsQPND37TPWppbMitPoL5OTvgfssc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10070799003)(22082099003)(18002099003)(56012099006)(3023799007)(6133799003)(10067099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzFjTXRJVTVpSFJ0ZHM4cTYzZEhSTEwxMWZCR0tEcXZNQ1FkZ0gzSjhMeEsv?=
 =?utf-8?B?elh6ZXVwMmloWUtmc1ZLb2dQbmt1YlFhdXAxMW1leVJ1L0xJTlY3Nzc5WGN3?=
 =?utf-8?B?V1d3U0JRcGVvM3d5T0xrV1B5NjN1WlREbnRHSGJaS2VXT1pMZnRYWDhhWWhN?=
 =?utf-8?B?VDIxZnpNUzU5MGV5L2V0SGRyTUFIYVAwNm90R1M4M3I4OEd5ZnVnMXJiREd3?=
 =?utf-8?B?YTBLSXpZMjZlSXZDNmtxeXlHN1RuanNIbVNaOTl4Z2hZZ28vR1RkcXhnekF1?=
 =?utf-8?B?VTZDRmNCZE9TT1BnZ29zeTRHM2ZiN01MYzBDOGNtbDE1Um1kUmVwWGZJVzkv?=
 =?utf-8?B?a1RSUzMvSEUwS3ZBN011aFVwcjc4S1ZzczhNNUxKK0ptK1lMWFBMbW52cU4x?=
 =?utf-8?B?alFsSmNHK3RDMGRtNnRrTld3bktDTnVNMFYzdENKN3Z6N2c2OWkrWm01U1Fq?=
 =?utf-8?B?VEN1aVpSODNYKzNKY014NmJCY1pQUUM2ZTVBaFA4c1ZqUVFnQnBZUVlUa0FI?=
 =?utf-8?B?azdER21ZekY0SHRhSGEwOFpwMERiRzZXZnlvU1dDU2FlZklac0pBZVJCV0dJ?=
 =?utf-8?B?M1plNkp1cjZva2phalMrZFVPYzJsZjZ2OFA4UzZBa0kvYW5IUlp6cmpXV3Vo?=
 =?utf-8?B?bkxtVEk4YTNQcnpUTnJ4ZHVIWFRWYVFNbUprY3o4YW9rczdQZlhzN2NOcXh5?=
 =?utf-8?B?MWExbnR1SURMdkVmbzRFZi9id1FWR1dveEFHOE53MzZ6di9nQlpqZTRSeHdO?=
 =?utf-8?B?bTVHK1dXbzdrM2xvZGRhWGhxVFdyOFAvVExqRDFocGpldmNvSXUwVjgyOVdE?=
 =?utf-8?B?VHlEY2QvVjVsWkJDRnRWeDR3UHlVV213VThrSzkvSks4bkJnRkRHMFhvTzA5?=
 =?utf-8?B?ZWdSSTZPVmJKWFl4cjRBcmZDbHRjY1c3T3ozbkhZQTJQM2N6UmlFRCtIemw1?=
 =?utf-8?B?dTFBMWFJb3RDWXJPZnJkSHNNRnN0RmpKYkRhSmQyNHgzQ0txbHZKNmltZE52?=
 =?utf-8?B?VDdraHpicm04UmJQbXFSOTdhUDJReHBXZTRwTHBVTkJFajdQU2djQms3TlBF?=
 =?utf-8?B?SmY2T0NlemUxL2NXejk0REpYN0dLWFNOU0F6aHFwTWhDM09HSG16eUd4dTZW?=
 =?utf-8?B?R2tTTUlPZlI3dEYvUjlBaHNUdFM2cjV5M2FqbTVWK2svR09iV2J6TjJTWnBO?=
 =?utf-8?B?OE1OandvZFNXVm8vVkMrKzBkVFU3aDhhbnU0MUZkTWxsMmlBRXZNdUY0OG5i?=
 =?utf-8?B?TGpTQ1ZDUWV5eWY3ZGs0eWRaM2Q3bUVPK0ErY3lCa0VLU0FGWExEenBuZkN0?=
 =?utf-8?B?cXdabVJtYll1M2xWdFpaSEFEOVRObTgzdGN2SWt3eWVtbVdDaE1UeU9taUpT?=
 =?utf-8?B?UkpUOTJVQWU1KzJ1cmZQdWhod2tCZEEvSHZLcTZ1c21vN0taa3Nhbm5waW5I?=
 =?utf-8?B?WXViVko3VHAvRU9lRkRvUGJrUGFHUEZnQTRWcVBKS2FaTHR1dUdBWGhibDI4?=
 =?utf-8?B?ZHpCbmZNcUxYN1BpYXFwVHNuYkRqSzJvTmxhdk8zRHY4RGFYNDJWdlV5dUpG?=
 =?utf-8?B?RUZXZG0wSS9hR0Qzb1ZGRnBEVXZXN3g5Q09SMCtzemJ0UFNCSjQ1WXI4R1Vo?=
 =?utf-8?B?ZDVlWFFic1JFR1N6UXpIUnpQeFpFbklLelRsalRGM0FhQUg4N1pjbkxCb1Av?=
 =?utf-8?B?Z1hwNWJQZGxMNFJuOEZCMHU0RlZJMTdvcm9mU0M3UzFjcmlRYjBjN29OMnJz?=
 =?utf-8?B?Q256SVR2Qmp1NGp4cHg2WDFCck9qeklzeEJBcGU4WDlQM1lGTWhaT012ckxC?=
 =?utf-8?B?T0thSEhjTHdwK3FZQlZZcDc1UTNhQkptUjZQeFBrRjNIcXIvdWI1RlNzM2xt?=
 =?utf-8?B?ZWtQVzhXT2srRkMrdkxPUUJ2OUUwcVpFOTR1enZ5MW53TEhGaHRRVlRTVjQ0?=
 =?utf-8?B?SjBmVmlZSUU1dTZoVmJ5RE00Nm12dG9kOGszL2ptcGlBRHRsOVh4eUFMYkkv?=
 =?utf-8?B?cGYwcVdlNjJWK01aaE1MOVZ0cUVPU2JabU1wSW1WeHplL3JNZ1VjVnFOeE1W?=
 =?utf-8?B?WkRMWlRkRjgxci80eFkrTnpJWEJiUDVRMk80aytCVEY3ODlQa1lvR09aTFhL?=
 =?utf-8?B?aUxnNmNFZDBGSjJaL2Jnd2tTUGs2MjdwMWJFOGZiRWFiT2htKzgrVGQrYzc5?=
 =?utf-8?B?clNqVk5hcXRpeGNKVmF2NjU3T0JqS0d5cUdsL3c3bTU0STFlRklVYUZBTWo3?=
 =?utf-8?B?NmZVak9VbW9pUStIYk8xR3JxVGhSS0pNZ1NVYXFsZitleHlJNnpSUm9GblZ1?=
 =?utf-8?B?dnd0ZWkyWVpkODhVa2p1WW5VMUtuTWpOZ3BiRmEraVMrcEo4ZjFzcW9Sc2Rz?=
 =?utf-8?Q?Qut4nkj5rRxHivk6/I3YhqDQqwVDCi2utK/UV?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c403c254-d225-43ec-99c4-08def95cea03
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 17:04:19.2404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kpc1nUjmS2nL9vuOEZdRCr8s6B+6P3vjSGFnNdBzAMGkru7gyh5ZxD0Z+nMm7VFviuldn0i69BGDkPWp3z8HqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB6006

On Thu, Aug 13, 2026 at 10:59:58AM -0500, Frank Li wrote:
> On Thu, Aug 13, 2026 at 11:15:31PM +0900, Koichiro Den wrote:
> > On Thu, Aug 13, 2026 at 02:50:59PM +0200, Manivannan Sadhasivam wrote:
> > > On Thu, Aug 13, 2026 at 01:46:07PM +0200, Niklas Cassel wrote:
> > > > Hello Koichiro,
> > > >
> > > > On Thu, Aug 13, 2026 at 03:37:47PM +0900, Koichiro Den wrote:
> > > > > This is v7, the remaining patch set for PCI endpoint DMA.
> > > > > Parts 2 and 3 were merged per Frank's suggestion.
> > > >
> > > > (snip)
> > > >
> > > > > One open question is how to support endpoint controllers with only one
> > > > > PF. Keeping DMA in a separate EPF requires multi-function endpoint
> > > > > support. Folding it into vNTB would work on single-function
> > > > > controllers, but would also couple the two implementations. This series
> > > > > keeps the separate EPF model.
> > > >
> > > > I see all the work you are putting in and I admire the effort.
> > > >
> > > > This is now v7. I think it is time that we close the open question by
> > > > waiting for a reply from the PCI endpoint maintainers' opinion on the
> > > > design before continuing. (I am not a PCI endpoint maintainer.)
> > > >
> > > > I understand that you want a common DMA abstraction, that can represent
> > > > different (embedded) DMA controllers on the endpoint side.
> > > >
> > > > But if vNTB is the only consumer of this, then why not simply embed this
> > > > DMA abstraction in some BAR exposed by the vNTB EPF?
> > > >
> > > > Looking at the host side driver that goes with the (v)NTB driver:
> > > > drivers/ntb/hw/epf/ntb_hw_epf.c
> > > >
> > > > The BAR layouts are hard coded, and it only supports three different
> > > > layouts. Would it not be possible to add a fourth layout that has the
> > > > DMA abstraction somewhere in one of the BARs? ('BAR_DMA' ?)
> > > >
> > > >
> > > > Right now, I wonder if it is not a bit premature optimization to create a
> > > > DMA EPF, if vNTB will be the only (ever?) user.
> > > >
> > >
> > > Yeah, I feel the same. I haven't seen an usecase to program the DMA controller
> > > from the host outside of vNTB. This feature is supported mostly because it
> > > exists in hardware and someone wants to tick the checkbox.
> > >
> > > Though, I'm not against doing it within vNTB as Niklas suggested, but
> > > generalising it in the form of a new EPF driver just for the sake of a single
> > > driver sounds like an overkill and maintenance burden.
> > >
> > > Sorry for saying this in v7. I've been meaning to say it, but somehow ended up
> > > procrastinating too much.
> >
> > No bother. Since Frank has given a lot of feedback on this series, I'd also like
> > to hear his view.
> >
> > I'm fine with either direction, and can revisit the earlier vNTB-embedded
> > approach:
> > https://lore.kernel.org/r/sn67hi7kljh7cgmgodatb3naz2astlaklqfobdbxyyzgoohxqb@4nnetbhqwba4/
> 
> One of the important value is test dw-edma-pcie.c, which generally depend
> on some fpga hardware. If there are epf driver work as fpga hardware, it
> will help cover edma remote user case. So more user can test it.
> 
> Of course, this implement are over complex. I suggest update dma-engine
> chan_id to support static allocate, which also need be fixed because
> some drivers have such dependence, anyway need be fixed. After this fix,
> this patches will become simpler.
> 
> VNTB case, it'd better put such informaiton into one BARs and work on
> single-function.
> 
> I suggest split two things
> 
> 1 - create simple epf driver to test dw-edma-pcie.c.
> 2 - vntb support DMA.
> 
> of course, if shared efforts, it will be great.

Thanks for the feedback. v7 patch 1 adds that exact static chan_id support, so
you mean this v7 patch 2 ~ 9 can still be simplified enough to make the
maintenance burden acceptable, right? Please correct me if I misunderstood.

I think a large part of the remaining complexity comes from discovery. Ideally,
the EPF would create a VSEC like existing supported hardware, and put the DMA
description there. But I could not find a generic way for an EPF to provide
writable configuration space backing for such a VSEC on a DWC PCIe controller in
EP mode. That is why this series (sadly) ended up with a BAR protocol. BAR
subrange mapping use might look complicated, but is still needed on systems
without a fixed DMA BAR, but the discovery part would otherwise be much simpler.
I may be missing something I could simplify further.

Best regards,
Koichiro

> 
> Frank
> 
> >
> > Best regards,
> > Koichiro
> >
> > >
> > > - Mani
> > >
> > > --
> > > மணிவண்ணன் சதாசிவம்
