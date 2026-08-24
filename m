Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DCC2F290A;
	Mon, 24 Aug 2026 02:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787537537; cv=fail; b=kpjKLOPpOJ2HxAftxcllEUQ1CI20eZuICXGFeNdEDwZMoOt5nUSmNP/EIP26G+Iq5L6AsgqjhqlsmyVq64Xtgo7XFldJGwHSVsdRXANoZlsL65TuJe233cxCm+dXdbOiLl26FkBNy13p+0Xw06FjgFok7+7HTttCGsaLRzD7FtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787537537; c=relaxed/simple;
	bh=E2o3Bh2fS9OMamMsBus88SPXIL0NxliRbnDMjEJXTpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IEP5bvGt/vc2J9E1cW0Nmyx/kixZW0SrJcGsI8SK48qTY2Y+VWO+062qzYqCQf9v9iA6ZfkAdarRwEhs708VVGFLuo7DIcjxdYmeGPTWfdiZ5BOg9PR45zpRDcQSsKpXfvRxYqTKIS2kdXH/7LsovB/tzNVjIbCvFM+SzrFpxJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=M6w/R7l+; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="M6w/R7l+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYH8XMKh5DjjlBly8Ngkn7pHzZCW/UlA8mlJBpglWI/RR0+CTtY/dKlHB+cdlsvxd9GdWpJjTAKIPRkHoIeqhm1UJ2lf4kT4osEhVCw+iCwl5gOc8boA8ubiGvghcNamPyHb4AAf7fAEi0Rh+qrEbGgCK/f8uGOvFz7N7zioF49i/5yPslantXBaSYP8rJ2gsrXEUR6nJyeo0qNdDqldEMQnluA+KPt5gMZvo+EsyzGKl784AhmjvT+a0hQ8bB56SnU6Ri+wbAeAasNuWhXmJ0rAdVLUD2LNmUJ42p0mchEHGM/qHA86DvZolKHw76QcEyY5dpCcyJCGAJLYt3ovdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ciWGRLkmllCTtYA8KVOx/JLq7r9YCXClE/DIixKo3A=;
 b=LY4x8PlD7nPcFBGgagEp4/x6Z1xmSwYEiO3Eny007pqOPR7sf423e5Q1nt3HuDWqB+VUIjgxuJrfMPF6FhYnu6VLbXZOCCynTEUN54dfd7ngLgE1dsLA1jhoIRa3yFrmS3tff8zTnVSkjJ4aHDdOy1qrz5eXR/z1QgvA2taEwSSycITTG0xLsDNzMEgszfJHgZjNhdNynFNfaLctkP6MNhwP7hezZkAoRQHrzNayPI5DHcrnWqyHw07vys0kZi8B4RClWQ0VPbZ5/m7Smdn1ELQgUeMtugrnecGgsrsjNS0yRYzCJ8unpgQ5QnyZ/cd1XWX6OPHIk2zbxUsKf6vSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ciWGRLkmllCTtYA8KVOx/JLq7r9YCXClE/DIixKo3A=;
 b=M6w/R7l+mF/uN7bWBIkFd02t1sRB6fOikl1FWR13Skk10tQ9M7hyX9z3aWkSbSx1Mh0reLokeyzk8g39xpKw4qw3m+lQXWCACA/5cE9TCpWoPGF0tsc25ZUKpFTxzlJ7DRB9OzjECtzHRUIzoNnyVNZ8oYtd7AVTHEZLX2GK5Tk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB1997.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:18e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 02:12:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 02:12:11 +0000
Date: Mon, 24 Aug 2026 11:12:10 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.li@oss.nxp.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 00/10] PCI: endpoint: Add PCI DMA endpoint function
Message-ID: <qrudm537u4y5reylletv2ovx5bynosonipglx4sdozpdqeoxg2@kq7f3dtvtspk>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <an2uf5mXzGq1Q7cj@ryzen>
 <zoed4wtc4oxiyni4o5qpj3li3cmlyy5kfutp4r5g4d63u52625@j6rvbbehjgov>
 <ztn47y23ctbjrbkmgyyhc6d5x3i2lzz5txotpgtbjtcsvbsvf4@fzadsvt5fl4d>
 <an3p_j-F10e9x0vM@SMW015318>
 <7kzvkrbc6w7yojufwekzjubndgg4ao2o65gnla6mjwhwn5ji2d@vhrj4kg6uia2>
 <fg7cma2ccvdgjgcref7qa4q7ocvvume5dteekedikszebkq7rd@uhrjfp3nmmwh>
 <aoh05fY66kKxvxqD@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoh05fY66kKxvxqD@ryzen>
X-ClientProxiedBy: TYCP286CA0085.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB1997:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b7e880-0635-4a56-a63c-08df01851b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|23010399003|6133799003|10067099003|56012099006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v7/KYqdWV0RSEv0lhg9UkVxPF5rlYjRk0TOhX7h/kHiLQ9fWrRoVH5uXvU74SAp7pkCDibtMlL2xGL3m6gE8vKvpxrOkdpsSfStOXhu1Y+gYbiTSv9uNKMWqia3hH7ciQnB/y7jz/IRbK5NuWwGKrfK1lZNjltR3d+1DoK+1gi4mCSPi34axXH21UVQwooxMQAHK8SLM3tucV8vwGNBX6vSE1UOArNqfXV4r7UdKVmo/DOPBOe9K8P4nN9VYrSI5uIHK99yTJtN4XxNl+5W7AmxBtS4S52cVf/reLWi/L/6pSA90gBlLq6P6eqRo/ENPBDVEBuzHVhiLjX5gn/riofgCPT7UbacFsRw4xw4aIjmPZw2vi+U98WY3Uf6fnPtRgT8drlVa9l+CI5jnq2YjnL6XlkMQ4qMnDNNYVdAF8EsvvTwhdw/7J82bzboxMytKQANin6kGuE5MOYWz2cv3hylsyTH5BNiyu8iJombIZXJa2cgD2+m9XtxqIHHIli+3Mm3oHUMQAZ+dVsXYjF3YL3h0sGhXFiOMoLjZKy2erg3vxR3ez4Z5H4/afOwjDZ2Y0OCZJE5QrwNouckFzK/fqiSO07qubfM0JK8ejD++nMPmLRyN7txXEIHgE7wLQrBu1DoJIKs3vS2NatNOuu8xNs8b4P5kbt6YBoK3UP36W3M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(23010399003)(6133799003)(10067099003)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?atGx3MTkiMaw8bpOiGBFPM0bO0pR5705sHp+9cyYxfBsLxtJNNE4laIar7Xe?=
 =?us-ascii?Q?ssej0gaWfOys5wBcEnRYRsz/Bwp1VVJ5FruReyRWB0+TWOFNRl5UUdQxP/1K?=
 =?us-ascii?Q?05umozmd0lfcw0S38E0ll0L/EQPPG1R8zrt9AZnF6l4itxs1+3eIPFFS+cBs?=
 =?us-ascii?Q?WnBn00q5w94NUxQ0kI9BeJqPFmvvyuHwkCwLAKw5v3qboE4F5OxTStk6DTyb?=
 =?us-ascii?Q?aaQ0zO7HhBwtCjoIfoKQsj/28KZeIxq5Ch5i7whRAY6bc75V1VXyOorq9ZZF?=
 =?us-ascii?Q?Umt6yc+vlLgLafCHOe+Hm2DUV0hdCYaavAr625eei9S9lTVT9kdeFSyBrcVE?=
 =?us-ascii?Q?eToOotU/LFI8kAJRnfXkCS6ryNau8zZQa5IyS3hKxuks2c1hF6Q7KExfuanf?=
 =?us-ascii?Q?x5TSiJKlGXgZuRVPZuMOiutcR5+kmThk76QmDW8QCKMwmOMrfoNUWV9WtYiv?=
 =?us-ascii?Q?+TiKNx1VgZdsBlwwFnmisxwvlfDbphTnwifBfmLenrtJOm2ySjLRYpeercEO?=
 =?us-ascii?Q?ulFvPgjKEiC3GJqJAO7BsV2DG0PbULbXc6fcSn+wkXyTMjHejWj1MPnWPoCV?=
 =?us-ascii?Q?MtnT4jW01VP7ga3c/NZCZ5PyGqr3Xt+VWKVGYdtRiz+o5ISidYxpl6wRmAUp?=
 =?us-ascii?Q?DF5Hktps1qjdpMVxRYNydnA3SO+PvbA0eZVnuv89QE1mpKxilCbmFsCVoa7V?=
 =?us-ascii?Q?vteKxaN0IHwoaNBaM//T4VA1mu3YL+Pegh8zg4XckEqfFl2F5asCguxRGPqn?=
 =?us-ascii?Q?9gTUNXoVIVLibWyMoCXBKH+lSVNtjpLN7hP3O+MA77dZFSGbcsswBu4IHjuG?=
 =?us-ascii?Q?cWdl/PgR8hZ9+qxk4nQSWrOpnYqNwg+A6/DXlxsai8pPEX0k6UHaEkjpwsBL?=
 =?us-ascii?Q?nXyFaYJ4BlBYOxAxIR9eeC1Rpr+5JhgqtLtZe4AV200fEcLIgILFMXlLKs72?=
 =?us-ascii?Q?x9tNUXjUZECbhSQReU/nJRArLwhLU70lVBHUGnLxyeMFwz37+BeowN343oud?=
 =?us-ascii?Q?3S8jO7VMY5v8QLvHIuLcX5Fuk8epWuQmsIeU11qJ9B2OnJ159oK1ll1ZAPrR?=
 =?us-ascii?Q?vuKfGS4DclaFt20oN7rbCYt5pJJbG/qIzwWfmyFYKdhPhh4jVZSR2yuIxoD+?=
 =?us-ascii?Q?Gc7T9iEfOfImnLtKrs1AyJUjxaFeYjaLt1tABIav/rXkpXElVRvqZyfTsSsf?=
 =?us-ascii?Q?jl9dQoGjOA6Zlt8E+9dSq3aCr7s9rm5fqYg2NuB18utjefFzdsFCx3gTGy7C?=
 =?us-ascii?Q?VneQVpGUWr5AA1At+F6WFQenicloDtT1Ab93fe5zfJqC+j1rZB89bkUmS6zA?=
 =?us-ascii?Q?WqAL92v7RKdEhn345GKD5WZlM/OOsX2iA1FN7g0TWbs979pHQIl8LZ8ePcaq?=
 =?us-ascii?Q?zVlEbZ0pzgUX5UULXA5KRuGaNyipNm6XIBb5G57zONgBEKC5HIfKTGznsXKI?=
 =?us-ascii?Q?SQUUmtIVQ62xFI00diZkl7RuhtPLXDLaL0bZ9uxLWf6nKI8xDckhjCoymsIx?=
 =?us-ascii?Q?edZ1VqiKnIgtuFjSkXoFdSlEHtqz6764BwIw3yEjliHhD73OLadDoL/Awbcb?=
 =?us-ascii?Q?UT4Y39KZ1uwLdLyzp/4KBH+hb+j49pZN6GVU1lvbwU7zLMd8vJy67EtYqGMs?=
 =?us-ascii?Q?mPltbllrkBi8t/LoAvISt+glwB2zYOsmPoDRmO/YBhRN/DMM1jX3IbyqyMjb?=
 =?us-ascii?Q?UFGPqf4W3QSYn5YapJtW7M8NEa6WqnBsvKjz/E4QycHnNa5pqQCW+88Wb+Fj?=
 =?us-ascii?Q?OWNIEku/+rysrSN1NEOsuJ3CsnsAriDtf3y++nsmFyKLb/I5hR1k?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b7e880-0635-4a56-a63c-08df01851b80
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 02:12:11.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1z1BGNu8rThaz1A2+47OnIPiJOd6LCg1a2bTGshO0hNltNUxTJ6EpKMT0cu0y0n4w30SxABOyaGlTR9rHt2tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1997

On Fri, Aug 21, 2026 at 05:55:17PM +0200, Niklas Cassel wrote:
> On Fri, Aug 14, 2026 at 02:57:12PM +0900, Koichiro Den wrote:
> > On Fri, Aug 14, 2026 at 07:27:10AM +0200, Manivannan Sadhasivam wrote:
> > > 
> > > Testing is one thing, but using is what matters. Are there any products or
> > > use case based on remote eDMA? Or even dw-edma-pcie.c?
> > 
> > My end goal for this work is this series:
> > 
> > https://lore.kernel.org/r/20260810165136.2292436-1-den@valinux.co.jp/
> > 
> > It now depends on the PCI DMA EPF. The host side controls the endpoint eDMA
> > through dw-edma-pcie for one direction. This is for an industrial use case, not
> > just testing.
> > 
> > The resulting ntb_netdev/ntb_transport improvement is substantial:
> > 
> >   (unit: Gbps) (UL=EP->RC, DL=RC->EP)
> > 
> >           UL UDP  DL UDP   UL TCP  DL TCP
> >   ------- ------  -------  ------  ------
> >   Before  ~0.6     ~0.6     ~0.6     ~0.6
> >   After   ~19.5    ~17.3    ~12.3    ~10.8
> > 
> >   (On R-Car S4, PCIe Gen4 x2, controller IP v5.20a, eDMA)
> > 
> 
> You have an industrial use case, and your performance numbers show that
> remote eDMA can bring great performance gains for your use case.
> 
> I don't think anyone is arguing about that.
> 
> At least to me, the question is if you need a new PCI EPF driver to implement
> the code for this use case. I think the answer is: No, it is not strictly
> needed. You can extend vNTB EPF to support your use case.
> (As that was your original approach.)
> 
> 
> 
> The question how you should test remote eDMA is a different question IMO.
> I'm not an expert, but from a testing perspective, does it really matter if
> it is the host or the endpoint itself that programs the eDMA hardware?
> 
> I understand that you gain performance by having the host program the eDMA
> directly. But.. from a eDMA hardware verification standpoint, does it really
> matter which side that writes the eDMA registers?
> You should be able to test both dma directions, regardless of which side
> programs the eDMA hardware, no?
> 
> I guess what you mentioned earlier, that the existing pci-epf-test tests
> are not pushing sufficient concurrent data to trigger certain driver bugs
> when multiple eDMA channels are used.
> 
> I guess you could have a test suite that does whatever you did to uncover
> these bugs... vNTB + iperf? But I guess it could also be interesting to add
> tests that push more data concurrently, such that multiple eDMA channels are
> used. To me, that is basically what dmatest was designed for...
> 
> Yes, we know that dmatest is currently not a great fit for DWC eDMA, because
> dmatest uses different dmaengine APIs.
> 
> I think Vinod is best qualified to answer this question, but I guess the answer
> is either:
> A) Extend dmatest so that it can use the dmaengine APIs to fit DWC eDMA.
> or
> B) Write a copy of dmatest that is tailored to hardware that uses the dmaengine
>    APIs in a similar way as DWC eDMA requires.

As to dw-edma performance testing of dw-edma, we already discussed it here:
https://lore.kernel.org/r/tau5svk3bcatzeapqeb6mun7dxi4ifk56g5ltkk366ljozjzit@vepneiac3f26/

I had already said in the first mail that dmatest did not seem to fit. Vinod
agreed, and Mani suggested an eDMA/HDMA-specific kselftest instead.

Which side programs the hardware may not matter for IP testing, but it does for
driver coverage, specifically dw-edma-pcie. Whether that path should be exposed
through a standalone EPF or vNTB should be a separate question, I suppose.

P.S. I almost ready to start reviving the vNTB-embedded approach:
https://lore.kernel.org/all/3ef3b7wdwpf364teperxcjc2leycxwke77cejjfzd5w4pnbmik@vlcbizvbxv4m/
but am waiting to hear back there in case the maintainers see something
differently.

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
