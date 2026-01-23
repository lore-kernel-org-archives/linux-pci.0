Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020115.outbound.protection.outlook.com [52.101.228.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8282D3738;
	Fri, 23 Jan 2026 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769128600; cv=fail; b=WtddH3Q9QwXVmu8HgYN1W5/Q3go2Fs0zO8WzDYhdV5CHJ8yqLnrecbuqojNOTMPDU5qWvCTGZ+N4uAsL0nTfKXRdmJwxCGs2yN8Wy4LSuLl2fuQS4A0rtp0tIqQmNBTN0KyyIC7Ztj6CvIqoKudqzFRP6M7ah5nzaMitWWYoThI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769128600; c=relaxed/simple;
	bh=1DljpANJJZq44j7k3Dv8jQB0VVZdWvtN0VVVHcyFufI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AOTBWFyQ/KnuTi+KW+bZWfLcWEnTYtWWxg1mZDKubPVg5m+Ri9p8SYg1zxguIGDssSkste34B1N3nDsSKx+jxd1ozVSA6My72hDEU88foSpsqMAN/9bB2qU2P3p7fHZa/RLqm44RL7QeZE4riUTgagidw1uXSBpCR8QvubyRrEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QneiiNB6; arc=fail smtp.client-ip=52.101.228.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QneiiNB6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rilxOTOpSaKr4KQ+j5x4alZm37R2Hz6ZwpAesf9G2O/YXTo7pJr/PpRUYjjYYxF8OIsy2GrsYBd9rJ56aveSFAMAKyW3ZWoSrItyf+k7ZdAD/ZOZhSe4W5nCc5ICgAr+ehqVFkda00752B2IHq8AqsP6CNjoUNKoBoDnn2TYUy7x9Y5A/twRrwfixMs1Cu3oGR6S8zMC4Vl4LJCkdylyLcTTk0CuVihltV0PgN2/0m0VK6SgMxwj1US5cMmReuDByqZ6FmjHbdVEVGZT1O2LgAuCyxhX/9oFNTC9bAeF7Qvkr/3yNFDBWTCeiTFsKzIxTRjAJt+A1wE36aRr98sVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMluQeUmsTbZJ4NP7jCwpGqe2xep4WorxM5qtxuLrzQ=;
 b=BcRQ41RudZgvWoHf4AMMBiBX9cTCT8O0wZnHzJJFg1jP92PANyLAVcXp7ieEiSTijjOjJPnOPdsIb1WP8Gk/nQ2SUegnpquFjgPIPLQR3AsQjMaDbi6zTf53La7mCXBtpSRK/nkjfs3r9eOpXmhTDSS9xM2gnf1ALE1BOT2Rr5GpXISkSLHri10OwiWxEl3Vq/e6yiWlmUJlQmtokY2XV6XNk5l0QyrCRo/AS2zVwXJGUpGZ3GSeF3OFKQg2ZN3JNuw06ctza/swBiGAl/A0BHZRlcTwdXmUovKud7fNGzzKd53x+vpf5sXmUAVjj7p9I11kx/NDC5t9MNFC3CNn+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMluQeUmsTbZJ4NP7jCwpGqe2xep4WorxM5qtxuLrzQ=;
 b=QneiiNB6hBuePabY92fzhvXru9OneWIi+s0eq0T6fhhq91ysx3aCg7HRaaNB7K7G4CB9R1d4Np91rhSevoTtXMgjGpU7vitp4hOrwZc8wPCDkdEmqYfi371nvBNgiQNdyxnWIE53sXois9wE8qqzO839u7Z2DRaYytRLEbAmbLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4874.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:145::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 00:36:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 00:36:27 +0000
Date: Fri, 23 Jan 2026 09:36:26 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com, 
	kwilczynski@kernel.org, frank.li@nxp.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <ajuq5dpbzzoghd2hk7cz6w4t6jzcxfmygbyiciqjjhhg6ipkoh@usuhzmne6cap>
References: <20260115084928.55701-1-den@valinux.co.jp>
 <x64g63zkz5t75vxxlzd7rhbvpus2mmhz2phyvxykuax5wm5cnh@zgpomauf75pv>
 <ugxohcm4tvtjwnhkkz7jw226upm7o5hihohzn2f4eoamhkd77v@mjefdgxneghm>
 <waapztvy6jyjqtfcoo3rbgvagi4z3p5afw6x2acgf5bxatcui6@nkodhtqqtetr>
 <aXHfUyd0EPFnoVBO@ryzen>
 <tvaumsi4ahosz4herbxoc636fj3lhetjzqlwp5n4e34tthmn26@bld32k6xntmw>
 <aXI_ny1-5NlN8r_z@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXI_ny1-5NlN8r_z@ryzen>
X-ClientProxiedBy: TY4PR01CA0080.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4874:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b116aff-c3ef-422e-8e46-08de5a1771ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oF8WQp0sKiKlY8a9vrA/Xjuviq8FmkBnK9E2A4JtSb+0Cktd2N4WTBKulDaM?=
 =?us-ascii?Q?Rul4EGsIAskueNw6f8pVTekv3rMgZr5uqep3prfdqx+Tqjgp4505IITgvYxi?=
 =?us-ascii?Q?5B+awBb5lOzWg5Iu7dkxXhuXCdL6DpaBGxTH9+0fKxrnUZU9bUz9MdN6tv0Z?=
 =?us-ascii?Q?YBTPk4CQQ+M6ID5T4teJnNBW4LqKsMcsl75VLPyPzKjWArdTyAyT4UxcnWmC?=
 =?us-ascii?Q?lF3snImghEqMAHXL1OHhAiBJb4jnx41wTtonbiaDnkneef04/mrWNBzOl3Ig?=
 =?us-ascii?Q?Rzlalz6k6l67x2t/RTvTOFKASc/Pa34wvzca8Vq2K7P7N/hWpcvR/Pd0prqK?=
 =?us-ascii?Q?VdGif7hI/Z0pcTmvKRu2XLsAyIOIU3DRHLkpXOSnCWt43Aerl/jonXerZVQ+?=
 =?us-ascii?Q?FCEaL8f8MrlAqH7eJNCKHlEbAdjmXjIsSU8guAyxAOKXntP80FJhCLXrTI05?=
 =?us-ascii?Q?bdALJb6ax4eIlSZnIBZBI/7MtDBGbNRRuBnCKrEEtZptIQgZXQDfXDkWga6i?=
 =?us-ascii?Q?VIt/srbgSJELVElomOJc0Ypfm50zULbKEPGC9dSWcRVH+JtR3PiviLZ6KHZ0?=
 =?us-ascii?Q?Wb4mrrsFwUWlNADPRJLrqnVYfX0IjktM9x3C2esLaFXBY/2zIJaUXmtDiwnY?=
 =?us-ascii?Q?4ah7rVDv6hnj97HgZr3FflGQgE6IAA3pjI3LbGXfZnXOnKflrxDzB8tpwpVr?=
 =?us-ascii?Q?H8O3wWghX+Rkm3jyyfrBd3fttNVBsmCo/5fyQgxGrgUDNzRA2AHj9pX+X+/7?=
 =?us-ascii?Q?QUWIrNnWq6RCrUXTIIfAX2iASEEeeBiAl9lz/AeTJj5fSOt/gYEVIOH2bbk8?=
 =?us-ascii?Q?99bGJNDrnuAkFoNcp9jiQTGx0QbYX5/8bBLUyqqjp01lUjZrrwzfNvoL/iyL?=
 =?us-ascii?Q?JkjcekRHzSW8wMm83+IXs82OTxVW0Pcrzf3B3q7soLTWgkrLZsyW+Ios36Yq?=
 =?us-ascii?Q?T2qDPytq0v6tRbwI+Fg0mywm5KhQ36heGKXa5rlRLE+h2pMQJTwqlm0fvmR9?=
 =?us-ascii?Q?tisl2isNcMjeEfn1h6veOcMuG7riRAnOi7iMg9ver+o5WE6qlH0hTf1SKQv2?=
 =?us-ascii?Q?kqI/hwpof2AYVObZ4JYJFbvv9SyKSIZpiTbU8KWT66+Sk1pbb+P28jZJkQK2?=
 =?us-ascii?Q?L8/LQAKOeIQJZ4HV1aCgicsDXx3kztC99mbW7v42IL1eIwJYQFD+4DTLVsbG?=
 =?us-ascii?Q?AgWmKL8PObEWVvPTQ8Opr/OkMlIUz0r2Cn86LeCrlpmfde34a+ByGOosAvc9?=
 =?us-ascii?Q?26CyY5OyH9v4qBMv+O9/0adDDc8JZ4aIfVfFwAOtUy8cYgwSjQ6KURVLyguw?=
 =?us-ascii?Q?yYp89RxgbKQ2ntbCwYZcC5TPgzXRO+iItR3p24J0KEr5Ue8NYJ/o0SD1bA0y?=
 =?us-ascii?Q?ekGvTltZICO9odRoVa3+VC82xsPFGCekCidQ+Q2Pj/ob7aAqf4Na8VWcwJLa?=
 =?us-ascii?Q?vYgTGb1sTDf7/aVg2wkronkJIUvEqJE30z1EPRnMnr+fgcFIgmagqf8lQLmM?=
 =?us-ascii?Q?YouD+73MyNcLCgcX9+75HXFV9LrvemzT/NSe0M48/lXbyfyGXfF0VdKYrbt2?=
 =?us-ascii?Q?o3GxTRXisbpkYIC9Pj4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XumQKgUchiato173WG50StRTAGI6yu5zUTTHZloW6Pl8yCKq0aTIQf8kGRiZ?=
 =?us-ascii?Q?IWKOpVwLnTeLepgqPpPJdEaBEjlCqdQx7xobip+ZIlkzdtrZalCmNVUxuHRo?=
 =?us-ascii?Q?IYSFfkCFd4o7PyUFDcDtjRwxNyZ/DTBPybcgSJF/YzZM3Tf6QYlQx3aeU1MA?=
 =?us-ascii?Q?Uh4PAwYh3/qRVlNYTziNmQ4lAxj0k7XrK4yXsrVBQIW7ltZb9Vq1ORLVdr8d?=
 =?us-ascii?Q?Dqo+OKwtkho/YfK5/A61EFAjSIJzViND1pB23UgAfDICJhqdsR8v7sflzCjv?=
 =?us-ascii?Q?Ms8kwuPQY+971E9B0qNtYVntuu1k7XItODmjv4Ej9r0L5t9xAE7yf9C4I1rC?=
 =?us-ascii?Q?HFYBhJgUMGt/o/J7J7gTi1SG3Udn4Jt/6E4oFRcLC57+5p99XSKaVpINZOAM?=
 =?us-ascii?Q?xHq0dPeA72XYFyQk2vpwtZz6ZrDKlLtXXrIUZazNGegvahbcfgjvkBvsJ13B?=
 =?us-ascii?Q?Pyxm45JwYr9uYoQ2IKkl9K0yUcbzFtiK0Tdq4xtyhXkZEdcZeJfDbJLUZby1?=
 =?us-ascii?Q?gTU4fi0mS2s03QeA66gAJd4I1/jMdYrfsdea5K9rw/vNYTiwxBeqxv1gEBaJ?=
 =?us-ascii?Q?KhrQ/Q0XLOeaEDqfIf3eK2T47HMx6OlDD8yA7piogH4j0TWnHN1f1zKaIBS6?=
 =?us-ascii?Q?+Cbhxmk6ym/hUJYwWskbmsCpCESWToLFKSrBYhAdQJ90VKKPBIVhs8OwG9Wx?=
 =?us-ascii?Q?YkCe50pd7h0wt0WvVOcnHY6Wzrw3z9VYZXm2fj3Kl7qXHQFKHK7ZRfSIPGjG?=
 =?us-ascii?Q?fHYGeU20wthu0D0wDN0MXx535nZuc8cnuSnkMxLaobzJtXQofPYn48tlW8uj?=
 =?us-ascii?Q?a03Ta25ajfFMxSDmwTlYF1diWl69YcmdDUumYWzo5Me+T0rXeWwuYKFmzC5X?=
 =?us-ascii?Q?RCExY7iSErHnD68Aw24O+WTj4CAhBuQosfSXE81pA03t0XZPWbwJetTqwsMq?=
 =?us-ascii?Q?/atAqaM5QMTJ+VAV5rcKwqzLt9VsolIdphWmxC37DMZyJmA7zRMQ3DFXLzNq?=
 =?us-ascii?Q?0w0eoz7uEcqn1isjTOZ3+kkgS98wv6p63ir0FabdKPtGIqf3X1YodEI98hMY?=
 =?us-ascii?Q?EaI72SYyFdvR+IgPkKAaqCNJ2BK5I3cj6LS6S0tKckdAoIZwNaZ2UwGP2gYY?=
 =?us-ascii?Q?ZDGCjEtCprNwSzewQv7CpHaekYSlgTMcjxaK06tJTv/Qv8lHXgsJUN1Uo67c?=
 =?us-ascii?Q?2u4t8viI9GGvUnGB5P0w7kflDwZCVEb/gumHR8MV+kCSI3bUlcCU8VM4aLlJ?=
 =?us-ascii?Q?Rdr8LHcclm6twtJrOg+5/FRri+G2dGGigtvdx6Jf0OAT63bNzHINY1YP1QhV?=
 =?us-ascii?Q?whYF0DzTK+QcYnzil9sTcKst/DPaC0qrHal8rpAexoumlWIxx3l9QtX+MbIB?=
 =?us-ascii?Q?NOLTiwec914RC1RX5kI4yT1MCU8BGpm1v5rxZPrBzolemF9DqIJpDA5bBjZX?=
 =?us-ascii?Q?Lqs82adcMOni7j/R4a4parCbBwO02++oQxBScJuyHbPq5111IDOzICshinO6?=
 =?us-ascii?Q?TOOxa5AD+NGO/V+UmcqPmfowHTBLrFA0AOxa/ejaG7n+4kB44AiPZEvDkQdj?=
 =?us-ascii?Q?R62SvNbsWM8c3DPypuQud54T8htRtmFxKKk8BJH9yqwaIkHA1QRVVQ/aXOOw?=
 =?us-ascii?Q?zjMn12s6HgDxKjRRLZRywzjuhdz2uE3nJRmsbi6Q1t4A7gbfRWdFE5g4CKXQ?=
 =?us-ascii?Q?25BccoMHpwv3+mpRY6INJblrCqvxKwOqRy/kFLiykjQqXnwELFWKJnbKC+8F?=
 =?us-ascii?Q?JIV1UboKDtbNbqRS1d5ObjcvrNGoBucKcMu8qJRLYIEjoWcgvSHM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b116aff-c3ef-422e-8e46-08de5a1771ea
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 00:36:27.6354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMJcoRVJvZUTFYM+amUUzv44xmbve6r2eYyJme40gocAydxHzdY8EwiGfAN8gTkpKFINLOzlRRp5ddEFOStyKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4874

On Thu, Jan 22, 2026 at 04:17:51PM +0100, Niklas Cassel wrote:
> On Thu, Jan 22, 2026 at 11:02:42PM +0900, Koichiro Den wrote:
> > On Thu, Jan 22, 2026 at 09:45:13AM +0100, Niklas Cassel wrote:
> > > Hello Koichiro,
> > > 
> > > On Thu, Jan 22, 2026 at 10:52:31AM +0900, Koichiro Den wrote:
> > > > > 
> > > > > In this series you didn't add a consumer of this subrange mapping, which I
> > > > > believe is the epf-vntb driver [1]. Even so I don't see a justification of why
> > > > > the BAR needs to be split into multiple subranges. Can you explain that?
> > > > 
> > > > Yes, the first consumer I have in mind is epf-vntb / remote eDMA-backed NTB
> > > > work referenced in [1].
> > > 
> > > Another consumer in your RFC series is pci-epf-test, specifically:
> > > [RFC PATCH v4 35/38] PCI: endpoint: pci-epf-test: Add pci_epf_test_next_free_bar() helper
> > > [RFC PATCH v4 36/38] PCI: endpoint: pci-epf-test: Add remote eDMA-backed mode
> > > [RFC PATCH v4 37/38] misc: pci_endpoint_test: Add remote eDMA transfer test mode
> > > [RFC PATCH v4 38/38] selftests: pci_endpoint: Add remote eDMA transfer coverage
> > > 
> > > where the pci-epf-test exports the eDMA registers (using subranges) over a
> > > BAR, and then in the host side driver, calls dw_edma_probe() on this subrange
> > > and uses the host side driver to control the eDMA residing in the endpoint.
> > > 
> > > Most of your patches in [RFC PATCH v4 35/38] have NTB prefix.
> > > 
> > > Would it not be possible to simply include patches 35-38 in this series,
> > > so we actually have a consumer, or do you need some other patches as well?
> > 
> > Sorry, I sent v9 just a few minutes after your email, without noticing it,
> > and then I was AFK for several hours.
> > 
> > > 
> > > E.g., perhaps
> > > [RFC PATCH v4 01/38] dmaengine: dw-edma: Export helper to get integrated register window
> > > 
> > > Would also be required?
> > 
> > Yes, please see the section "Patch layout" in:
> > https://lore.kernel.org/all/20260118135440.1958279-1-den@valinux.co.jp/
> > 
> >   [...]
> >   1. dw-edma / DesignWare EP helpers needed for remote embedded-DMA (export
> >      register/LL windows, IRQ routing control, etc.)
> > 
> >      Patch 01 : dmaengine: dw-edma: Export helper to get integrated register window
> >      Patch 02 : dmaengine: dw-edma: Add per-channel interrupt routing control
> >      Patch 03 : dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
> >      Patch 04 : dmaengine: dw-edma: Add notify-only channels support
> >      Patch 05 : dmaengine: dw-edma: Add a helper to query linked-list region
> > 
> > Patches [RFC PATCH v4 01/38] through [RFC PATCH v4 05/38] are prerequisites
> > for the PCI test update, in addition to this "PCI: endpoint: BAR subrange
> > mapping support" series. Note that this series is described in "Kernel
> > base / dependencies" section of the large RFC series cover letter.
> > 
> > For this reason, those test cases cannot be included in this series.
> 
> Ok, I assumed that some of those 5 patches were either eDMA optimizations
> or things needed for NTB.
> 
> But if you need them even to just probe the eDMA driver on the host side
> (using registers from the remote eDMA), then perhaps it is too much.
> 
> I was hoping that we could at least have a very simple test,
> e.g. pci-endpoint-test only supporting READ or WRITE using remote eDMA.

If we were to add a simple test in this series, I think it would be
something like BAR_SUBRANGE_TEST (beside BAR_TEST), which dynamically
triggers subrange mapping on the EP side if supported, and performs
read/write to those subranges. That would keep the test focused on
validating the subrange mapping functionality, and would not involve remote
eDMA. What do you think?

Koichiro

> 
> At least then we would have a consumer part of this series.
> 
> pci-endpoint-test could have been further extended in a follow up series
> if there were some eDMA driver patches that were needed for more complex
> operations than a simple READ or WRITE using remote eDMA.
> 
> 
> Kind regards,
> Niklas
