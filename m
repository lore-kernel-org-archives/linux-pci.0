Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021091.outbound.protection.outlook.com [52.101.125.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290819E96D;
	Fri, 14 Aug 2026 05:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786686397; cv=fail; b=dKFtaqjP+WAebbmklWSV6s1lGnSjDkSQRHY4O/NaxwlrEywa+cdogLZMv71Dv+NHXab1kAYQSeRuFAjJE10boY0lM/ixgE8o5Dv+x1Uhf/Qe/sNu4WaljFrXJOFBjGDltqLXjeuZmY4OOcenuBDEA36irCqkwYctMng2k8a/SPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786686397; c=relaxed/simple;
	bh=higiFvfZaP1O1pZXgRO5/zrkPpwpJIeWpRCua6G+TX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GlheCzBWXgpAux5sARXoHDvu7OME4F/SU4e8lgI26R67hR06c9dTQQ492Fp61Dlw34yyvhiez4Ztpx6szlONi0Xrqzd+LyokVGmLlD3j5sC0hiRgYZts/FPHDxbOdY0gPlSebdXPDgo7HUn5dXaVJhXB9sBiQOXKFe0hjZl7nPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=J9nNjhdN; arc=fail smtp.client-ip=52.101.125.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="J9nNjhdN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQJpn8G/RTEoA/eiW9fiE9bEowJk4GiTyeSTp8DnIQ4p95Ns3q4m43xZH4j/HdGVPwZsYfyaIXXM2QUnn+qRpjDAOJAy5hyefK+IlB3fJTxdTnvjjxCkLCUgT+Z5JlvTBeg+AWOFx8A4MhvXi1Ydo0pg+MoG92gCzI1/s7crmdVsldFNdgHzuRfvb5M0heoh5otoK7SgOWrI9I5VNSuadNzKwugt5VL2z9HDsURIP24WBq43srWjDKOec8mAcg5vUtjIpa3YiTZrt+FC61n+Z+qYtJ3qpaQQ0IWCAEpFz4j3bdTrtLdgumyAf+VcDV9Nz6fomzX2hxXQC8cEvxRcoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0vWhuZKpLzv5QT/tA/Kjnays6lsA8VfoAocaBhGW48=;
 b=bOMoZaDYr0Cxg0USabgtNz/1Erwv4nFYClqNQHoCnDW8xUot0j5gyGLAWcHKcGmP16NZE6NDtHI1I1kFIheWJkgyHqhe+f0rvBdadycj7xGZ9YD1fRa5gqkLv8Oam5/QIwrONpJ3zv+N9aSzjYA3lLbM5GlszLAu8S6ccBkIA9WCZ+9mPG+24fAPMW0hP0ThOgP11LW2Ybwh4djSnD1XiZBNTKPqyx7AM1hNrb2mcIHkcZCSenm4ndbX9d76DkDk3wjY8hg7RkwME2MrWQRuNHyc2zj443BgVqO4NXCjjokcQvGKukZvqbYbdaymJ60n7HzmzrfSFyCcNu0c8CcN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0vWhuZKpLzv5QT/tA/Kjnays6lsA8VfoAocaBhGW48=;
 b=J9nNjhdNst5wUOisJMfHb2Zz7X83eWhyo+AM0HhkPxUB3NPX0lJzrJWwm285srejyOsLprTOTMfvOQgB1VYzIqarJITM/ekwZKuZ9gZJD4dNLzilI548SS4/NpiSHX4CALPOchcI/I6yKBhOuyGePrNiuiRPq3jQn7i+yW3hrCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY1P286MB3328.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 05:46:31 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 05:46:31 +0000
Date: Fri, 14 Aug 2026 14:46:30 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Vinod Koul <vkoul@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 03/10] PCI: endpoint: Add DMA auxiliary resource
 metadata
Message-ID: <acuhxzf5ryoacnpg2sjxual7ots2lz56jxb3d4zirhcyqlafx7@scgrunvclpdq>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-4-den@valinux.co.jp>
 <an4m_U7B_gnJRgcV@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an4m_U7B_gnJRgcV@SMW015318>
X-ClientProxiedBy: TYCP301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY1P286MB3328:EE_
X-MS-Office365-Filtering-Correlation-Id: a71eba97-2a3d-49d8-57ea-08def9c764a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10070799003|4143699003|56012099006|10067099003|6133799003|22082099003|18002099003|27256017;
X-Microsoft-Antispam-Message-Info:
	MyrNBvY58+l+q6s9MAzJs8KhgLTJv/fPfmVnBjga5Lkw0wslKNS+TP0FB6t75T+xPW5hwNTDwUB5lH+xYUW5v6rjnfG+cPFyqV/QvRDwNJOQhlUc0wUmxvAwDWQDbucjFCccewnDaiDLIAEMl60H5uwRBosYHgoD1l255szJs1fEQdfP67FjAhvWaBLzwF/X7pg0pGyzoMRXbNQilMJ9n4ySvbXS9ikwV2wXYrWKoLk+KL9J8OjFBbv1K9sBP5TLVZob7EvPV5/WvGR2qADPfvjOLXPOEsuZJAahJiSR6cg3LDDSxTzU2B0vhXk97AhmwjtUYoZCP5+AeoczR2Dw5KiktxhRxx6jaoPuRFWzoRGC4+KFURHfXTMTqNbG7uRqkRQV16o8dB+YTUcnQ849+pGxPswsX0LUx7PsV+kDQSmsV6XIYQ/4xP6wAcw95GziKmW3v+ZUgiWCvocKHIwRKGXSiEcOMwLRpHCMpJCBh1TBm+qWWRjqGQ+1J64AIgkshjjucQh6CDV/j6gpdXvZwE5gctpR/NeXO/w8taVQPijsaIg324GeVniJevEgo1Zs1mI5b0uv5O6P5EPnEzJv2vQfClLu9FtRYVHlXoWRorDyKmINYOIflE1Rxj+Zw+KUbTu3rzOimSG6du3/OempArLMUvjX5kpPYrMDOKyFiUx7k/A4Pa6Y5Eig4RtB17mzAM7GqbiSJWL7ruipRqgrIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10070799003)(4143699003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?obRm6EZeZlMJn1ERVAZctfb5QCjQ7BYRVOqW8GecaejchCAN/SPgD6yRSVqV?=
 =?us-ascii?Q?G21IuLuDUPxfbr3JtqEUXcCJdduoOViZVtLFmqXKBTZ3gy1Ng+kKcD4/ZwQ/?=
 =?us-ascii?Q?6yogqFeCLkMo+grfsNgXCd2tiuHlnVAYRw3zWdO0Bn9MPnERb2djiZw3Rp2O?=
 =?us-ascii?Q?ZyAi33I7MAgeShfVZPT4fgI6BJbuIq10mWBoiMABO2gJ9jl59h0kitG3AKk/?=
 =?us-ascii?Q?yl7aYN0YeN1qnUACNsfuHIXcie4onscz6JUH4AAD8BDH1aepp1+Wq7lnG7xH?=
 =?us-ascii?Q?3TJj3uw4Yv5skzvciAWF+XMGA+ny6OoMoFq6Qxb9MKWbvB0lnUAMn3RLEBVr?=
 =?us-ascii?Q?mj4K93HzoJXP411F0FxAzFH7fp6rUDq/n5k/svYoVEnyu0VLiQdK9EvfGJxM?=
 =?us-ascii?Q?g12OtpihjqNfU/4HjpgYfMBfUDz8en0cIidpqe/zfUe+qmTuWokoAH/H9nGt?=
 =?us-ascii?Q?xFLgmQ3q4F8tapOAQo/BRCoEi07kKN8fxddu8JmWAY72LlL3zuyG329VdGpU?=
 =?us-ascii?Q?WXNcZeWZjYDGlLxtqMqvQM5zr8r0310NkvnGhaYxF51jIOY+SBsEqeHchbxu?=
 =?us-ascii?Q?TCRiD/qZTbOx253RK4N0Q13SGMtQ0pLyN4waSgdtYhnLihJ8w0UDVzgws10w?=
 =?us-ascii?Q?Emk4Lzm7MeVFFZvDoDB/CfncxLgtDR7HpZZVMogVMidVpEiPCaIs/I0wdRSu?=
 =?us-ascii?Q?iHFJpthbv6yMnWN3tHHb2mbuJh/vLjIu85mHPh1YzAjrYjUbvtonqQWEbUsW?=
 =?us-ascii?Q?bqdGuVAg+1FVkBAQfnz7Fmvt/hNahS6lOnFTlxdu85EbmYfP+IiGhSxQq5ab?=
 =?us-ascii?Q?hSZ2SRjsCiXK05gGjf4Y+aoRO8vzKlRHDfECbMbZOcf0kgEXnjBPYEMJodY8?=
 =?us-ascii?Q?E9iPCCrxKO4G3lc2Lh+CwuPqGfemC1OrbG8zoyhV32zj85hEfyJT7kkzaPfl?=
 =?us-ascii?Q?bEEotJFnzaXVpTycTbOHzPpLA89NDYRV6N//SoSkoVcZZFXFc6n4S3Hgzy8k?=
 =?us-ascii?Q?ba2MHRT3FdfpSZM+G7Kl5hw0PaU77SXZTBnY+ZkSX/yoYLx6IsZ6VKb2LNkM?=
 =?us-ascii?Q?pzifM4rMSYtn4gyIbSbNDiGZQuPIAJQKOoW+DiDgNdj9o+5P9N8yh0V7QDtX?=
 =?us-ascii?Q?z+Kr21KyGBEnL8B4UGKVWRa4MFH+yRakPsvktPYiWpSFDjFe+/+aCSWf9RkS?=
 =?us-ascii?Q?zQdDPFVoWx3WUJEkoXua57u1eu7zHMm9whKDU340Ct2X0RVcZhuN3sVrwfWS?=
 =?us-ascii?Q?UkyufVx/bLuKhrr5LfDljW1aLVVWF+nb66MbUuPQqyCNre4+0o7iOq0vcDdS?=
 =?us-ascii?Q?8kzYH/rs2uODCnWKkgTNwOPtNvLgQ1R2bOH22F/+FID60QK0PLSggHmxdOTv?=
 =?us-ascii?Q?dd9SO2/jbXrLxR0FiYMq5lJhxqey38P990SJvkWDOtD+tl15rG/u+o6hx7/n?=
 =?us-ascii?Q?b6sKGtXkBZ6/T/MFoTqPmJws6OKPURHHf/VgLFIfKb9It2LQwDOu3iPDlUru?=
 =?us-ascii?Q?5mfZ14KoMTJ7BC0flhgqTdtDK+reXN5x6bBUtnVjPwnbBAhBaRYLGJTxYrgL?=
 =?us-ascii?Q?9r0xrT73ryHQk3F5m7r892W3262TD1kJZlsc185c4XJfHMLtgPYpFmja3K8M?=
 =?us-ascii?Q?GxZ+LWb6R6zYBfV6/NWF3m3k3RxQL1JBS9+1TlJipoV4uYIrfyNrhR7jDWog?=
 =?us-ascii?Q?mXGjUT8zT1txZ8EbpywJVEKt4ZaY40pwG7Cc8SSQswMGbvSq+BcxVtMx121u?=
 =?us-ascii?Q?mxpoMaKCyuwRPsXKrTum24H1/NWGnUGWbra60pqwCcQ1tfsiHk5q?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a71eba97-2a3d-49d8-57ea-08def9c764a6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 05:46:31.6359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Zf5LaOqOyEj/Xd5mhfyEZ/6UAw+F2WlKLb/dTSCBAwepWXyufV4x5B+jxEUWQWP/5wvcCnsnt8HLUei/W2Q5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3328

On Thu, Aug 13, 2026 at 03:20:13PM -0500, Frank Li wrote:
> On Thu, Aug 13, 2026 at 03:37:50PM +0900, Koichiro Den wrote:
> > Extend EPC auxiliary resource metadata so endpoint functions can
> > discover controller-owned DMA registers, logical DMA channels, and
> > descriptor memory.
> >
> > The DMA metadata is intentionally generic at the EPC layer. A backend
> > reports the register layout, channel counts, logical channel resources,
> > and descriptor memory resources. Logical channels carry hardware channel
> > numbers, identify their corresponding local DMA engine device and static
> > channel ID, and refer to descriptor memory by ID. Descriptor memory is
> > identified separately so one memory resource can be shared by multiple
> > channels.
> >
> > For DesignWare controllers, reg_layout_data carries the eDMA/HDMA map
> > format so a consumer can distinguish legacy, unroll, HDMA compatible,
> > and HDMA native register layouts without making the EPC API itself
> > DesignWare-specific.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v7:
> >   - Identify each local DMA engine channel by device and static channel ID,
> >     per discussion with Frank on v6 patch 4.
> >
> > @Frank, I haven't picked up your R-b tag because this patch has changed.
> > Please take another look, thanks.
> >
> >  include/linux/pci-epc.h | 48 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index f247cf9bcf1a..3b60cf6628e2 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -65,6 +65,9 @@ struct pci_epc_map {
> >   * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
> >   * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
> >   *                             controller register window
> > + * @PCI_EPC_AUX_DMA_CTRL_MMIO: DMA controller MMIO register window
> > + * @PCI_EPC_AUX_DMA_CHAN: Logical DMA channel
> > + * @PCI_EPC_AUX_DMA_DESC_MEM: DMA descriptor memory
> >   *
> >   * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
> >   * register windows and descriptor memories into BAR space. This enum
> > @@ -72,6 +75,29 @@ struct pci_epc_map {
> >   */
> >  enum pci_epc_aux_resource_type {
> >  	PCI_EPC_AUX_DOORBELL_MMIO,
> > +	PCI_EPC_AUX_DMA_CTRL_MMIO,
> > +	PCI_EPC_AUX_DMA_CHAN,
> > +	PCI_EPC_AUX_DMA_DESC_MEM,
> > +};
> > +
> > +/**
> > + * enum pci_epc_aux_dma_reg_layout - DMA controller register layout
> > + * @PCI_EPC_AUX_DMA_REG_LAYOUT_UNKNOWN: unknown or uninitialized layout
> > + * @PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA: Synopsys DesignWare eDMA/HDMA layout
> > + */
> > +enum pci_epc_aux_dma_reg_layout {
> > +	PCI_EPC_AUX_DMA_REG_LAYOUT_UNKNOWN = 0,
> > +	PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
> > +};
> > +
> > +/**
> > + * enum pci_epc_aux_dma_dir - DMA channel direction relative to the endpoint
> > + * @PCI_EPC_AUX_DMA_EP_TO_RC: channel moves data from endpoint to root complex
> > + * @PCI_EPC_AUX_DMA_RC_TO_EP: channel moves data from root complex to endpoint
> > + */
> > +enum pci_epc_aux_dma_dir {
> > +	PCI_EPC_AUX_DMA_EP_TO_RC,
> > +	PCI_EPC_AUX_DMA_RC_TO_EP,
> >  };
> >
> >  /**
> > @@ -99,6 +125,28 @@ struct pci_epc_aux_resource {
> >  			int irq; /* IRQ number for the doorbell handler */
> >  			u32 data; /* write value to ring the doorbell */
> >  		} db_mmio;
> > +
> > +		/* PCI_EPC_AUX_DMA_CTRL_MMIO */
> > +		struct {
> > +			enum pci_epc_aux_dma_reg_layout reg_layout;
> > +			u32 reg_layout_data;
> > +			u16 ep_to_rc_ch_cnt;
> > +			u16 rc_to_ep_ch_cnt;
> > +		} dma_ctrl;
> > +
> > +		/* PCI_EPC_AUX_DMA_CHAN */
> > +		struct {
> > +			struct device *dma_dev;
> 
> Needn't this information, this struture should only include hareware
> informatin.

Right. dma_dev here would distinguish multiple dma_devices under the same EPC
parent, but in hindsight it seems that we don't need to cover that case right
now. We can extend it when it really is needed. I'll drop it.

> 
> > +			int chan_id; /* Local dmaengine ID, unique within dma_dev */
> > +			enum pci_epc_aux_dma_dir dir;
> > +			u16 hw_ch; /* Direction-local hardware channel exposed to the host */
> 
> should epf driver decide which channel export to host.

Yes. If pci-epf-dma remains generic, though, we still need an explicit mapping
from each local chan_id to its direction, hardware channel and descriptor
memory. (v7 pci-epf-dma has already dense prefixes restriction, but it alone do
not provide that mapping.)

If this EPF is only for testing dw-edma-pcie, we can instead rely on dw-edma's
direction-flattened static ids. DWC uses the same ids for descriptor memory, so
the channel counts are enough and PCI_EPC_AUX_DMA_CHAN itself can go away
entirely.

Is that what you had in mind?

Thanks for the review.
Koichiro

> 
> Frank
> > +			u16 desc_mem_id;
> > +		} dma_chan;
> > +
> > +		/* PCI_EPC_AUX_DMA_DESC_MEM */
> > +		struct {
> > +			u16 id;
> > +		} dma_desc;
> >  	} u;
> >  };
> >
> > --
> > 2.51.0
> >
