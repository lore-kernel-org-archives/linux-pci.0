Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020141.outbound.protection.outlook.com [52.101.228.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EB93D565D;
	Tue, 25 Aug 2026 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645817; cv=fail; b=gP1fpydteyseKwY5HIUnau1mfO5FOE9PBxFbMbDlA8o3LVKBvcw3N70GHFfLxvK7zmsZWMmBiUjAFuy/AmJWHiQuC6fMVNdJfHWaYywDf+XcUxj9Hz2MlIYwGT9oVjikUlWcaLrk69HueR7v13h1CScHG6CxlkssagELjN9Z9js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645817; c=relaxed/simple;
	bh=7XckuOaPlg7WKnYcagi0M/chjZvqo5NGZcUzagB50Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NHzLl5uU3XoFS0f2pFJnFjLCeZsys3/5+58P9akrkFQZ90E3wn0tKRFLipQTTx8evKzuoHKkuTGZ1BgNwRfhAvVT6bEbqZMEyIiaCYQan4dEaVGV6AgUNsG3kw2Gx3gGHGRMhZL8e+DtRbCMQNiDno5n5I3MTOj6lEmgRNzJ8yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=g5TNkdQJ; arc=fail smtp.client-ip=52.101.228.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="g5TNkdQJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ya0JfLoPkpsPDsAa6p24yJ0AHFo7p4Tzl9MJBu2HFK37h2ei1MrBnxb6b6PltIbZeREc0vadHmKvubYxoL3K+5Y/Rt68OX9ACnj0MKflWeFK7MPBoL7iZx+KzleIDg8yWPQ9E3cpghNDAt5j6U65ahHNvFVimV1fLXXT5N7uPP2x7lwQhpowW6njQ5ibIvTemQM41e2JOltJXKXVtg/fZjmSMOmTV5I/YowU6Dzd55yZCtKwrQl+RwY4STiV7Y/sJnm5bm9K7s155dxgE6bzkAGcT19vljMjJ7tpPmR7btUN9UiNJ2Dm7PYFmqdbSoNm06ilWWX+okJOdfHQn3OOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPRoR1Mr5gui+N7H83JGNjO/Mg43MNjCZunF20E2Xn8=;
 b=djzB6wn+CoZQMs+NJkzOWAh/Aj4w60CZDKo502E6Ii/Bi/2fBuOo8pedByv2+pCxV4dLxcVG24HwAc8c6DUJNbDDDOY9dnwEiHEc0YGEqaf9L5/z7moytiiEOOUWfrfoYXLQSnEwKjjWewJIAQKlZKhJWSZB4GtgJ9zmudI/j3C4niMHyISsukcB5EGJlMg5WIxwa991eCfBtAJxsGgrEh6CsnnaJq2U4kjK2FrHpM0O0Y8ne6vmY5IcwrUZDcds3XiE4zPVSbLmncBLdhHmPFQMaSVM+x7oXg0G8D0wWxMK5NsLg+RGlhSC5AJiuVGrHdEiNAMAsX4X1vX6ebWHlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPRoR1Mr5gui+N7H83JGNjO/Mg43MNjCZunF20E2Xn8=;
 b=g5TNkdQJcngMFXe/6MijwAsTv4uw+NFmRRRySx1H235N1HAMXXsiwjfOQcFYo2Ma60EZ95VEYzhp/diicsaGPnRnoqlRYuwlt74aPHMtKdmVpglkIzmD33JFB4GcckE8iOquQDFvfraksPyKIwbFwoVwlAPh8MMfZnxT0UE0UiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7484.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:35d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 08:16:52 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 08:16:52 +0000
Date: Tue, 25 Aug 2026 17:16:50 +0900
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
Subject: Re: [PATCH v7 06/10] PCI: dwc: Implement endpoint DMA channel
 delegation
Message-ID: <w223tumnzi3zircm4tnv4b7cug2g23z52xris7fcrhxyr6knvr@cw6meanwd5e3>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-7-den@valinux.co.jp>
 <an4WZkoIxCZ456Pb@SMW015318>
 <oiozls3u4bubqzfk4hqjgauzmuka2ixs4b44rvmrmosdqyxa2v@crlid6rfy6v6>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oiozls3u4bubqzfk4hqjgauzmuka2ixs4b44rvmrmosdqyxa2v@crlid6rfy6v6>
X-ClientProxiedBy: TY4P286CA0075.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 54db602d-c669-4457-f653-08df028137e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7416014|23010399003|18002099003|22082099003|56012099006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	QlI5fJ8fvtHeNVmpK7S+vJ+XMGhriwEO1FV9ViKJneFl/A5rOkpm44ccutGkO8WB83CleQw0ebdv+IGt+cAXqjOkdqPJ/vTOqCvHCcfGqrVf9RXtQdv5b5zujG+o7FSLKxl0xYTheoz/SrUj+2gVQwRVDzwT0SN99E8N4aVmUHkIqLFopG4G8PDsK3hZgctSPHWXBWRmWmTV72NdHfidUsCNVRQTXYimy17YAs8OiIoO5TWNJ96rMlnWqW8WboUy0uqUWyisof/T87Ph2VRc78GLDCjaqE/pJskipUNXrHyDj5La7ju8IFca+DzHipsK2RqKp4FdZWOTVmx5a9E1vu6Kpz+7u2s+lxRJziADfbIJt8KMGGL58GL+qfDYNZtmBuolaVgGPtVJss/M3NgKsH2GD0C8DAqkS1lR5x+EnOPwAts9KHxzYfGpZEI++HCxw+oNHvZC7xPUpkGtqGi8IvKtm7VJa0SRHHhAmZ0Fc4dk48hD32VyhtLg2dBoVajR/jWTgW/G8OEwcbFWUYadkzIBo92CwRUncUVtr3/7wr8QLd6KsoHqtgN3kuT/rJ1AtzvO5Czid4qazsCDjWlNdkIyHnzxCWduU7Ud0FElD8u8grtYlrF9qpshV08r9LAbPS8Ouie01wk7p0Bbt4RrJ01Zt1DrLuqQyUx9TDu3jtY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CRetxJh/aFhdWhkneAsPXoufrP40RVEqRf8ik9HYHxM9b+ng00MMsq6kDE6Z?=
 =?us-ascii?Q?+7+WAVQLBkpeWK3R66FblFMogOY+xKkTTb27JYdB4C4aRnuSdrZ9SVQBKPFy?=
 =?us-ascii?Q?v+64IRwEko4WbDp5T6ow21w+Mj1NOi06PHgQlJ1HX3DXjnNLNNk9j9+Af7+L?=
 =?us-ascii?Q?+WpbaCo/GGHKuJL/EGWISwtcuZ3iZh54cRyR1R+RWaSzQyMDqqSNQtrmoEOJ?=
 =?us-ascii?Q?AKvSxuFOkxij8S3uElO98MrAgAqUEcPU6FPXzSHBLWjGWQqgszP3v62HBn6R?=
 =?us-ascii?Q?EHvcXsjyh1t1uYoqIOTmygbXVIyLD64xqGP8SWm366ZLcSOIIiKdmbAAHtjO?=
 =?us-ascii?Q?sRkIggew+vv/yjo8McuvrtxizBYGaFx+CBfiOsm6twDnRZyBlM1mzR9Oyq3J?=
 =?us-ascii?Q?54o0Yl5n4t75Q+OzqkFNswlwyRL+S3VcKFvqDyEizB0ngkUHhjz1voRKJSAb?=
 =?us-ascii?Q?c4bTWzZuh2C83btGcwgPblGrmo2mdLMpl7JYMiCZ1ccWK/A5Ham/ec+e/rCY?=
 =?us-ascii?Q?da6lsv2Ve078g3X3TQ8+tIgT8uYVo0T5GpQ26RDQ9X3UkaFdTGXPFc9PTQst?=
 =?us-ascii?Q?SQScgXEIRSz1W11epLKwLYTZhdUBaNovxsVZl40glxk/hwW+cfZB3pd/VvV5?=
 =?us-ascii?Q?24uY0oaQuKGc7P13Xd5HL7SONp2YCfG/ebqbO03NR+FeXYR/XUQGerS9dQ4f?=
 =?us-ascii?Q?CxLyXGFG3EPRz25VT0mtESYvgKsYnBoVtijin8RZwQ3lg9i2nP/yzHezmiMn?=
 =?us-ascii?Q?ObT8xmthCY5L1VNXxvil7RcdYbZsIdf4fdXCheCmj1z2NpQhfOafUdW3CVcc?=
 =?us-ascii?Q?+6jGra/hDkMK1x05/gTqyneoG9My9mAf+MYMRF1YEUumE7vvbE82cPTA6h/O?=
 =?us-ascii?Q?ZyIKQwedhhmKWY2eDvA/0F94V/ov03QTGCC2DSt47iV9zVDWH7mBsRY94AaV?=
 =?us-ascii?Q?KoqCYp5h4mG+f4Rffdaqcwj1pz0qhaBG48/I3oK1uprlmFWWkKZnnLFezkfX?=
 =?us-ascii?Q?uNdeNxgB5W60RJDgrgA3xWC6yP+zLleq5KAWZldmlj6M234y0B9zh3JZqQNH?=
 =?us-ascii?Q?aCBBmL8Ncnb+4B1NembMB0dkm2NCOmQscEjMOjH6awW9cEhecbIs74jY8Lv1?=
 =?us-ascii?Q?fkDQSD8Iruvur+ExzZ4DQTqXwNz5B/HhNVlATTcRV45g57b/JC8PIRLOtx0L?=
 =?us-ascii?Q?jno+L/t6H7LPZLYSEN7F9i6PYao99snENhBSTxSW88KdGjuQaE8Mpd56ETRL?=
 =?us-ascii?Q?lBUULt7s0mT4h1P+HnkBX48krMKyszCOtBINFaapgJSYU8bpYlvG9EKiN/ua?=
 =?us-ascii?Q?IOdWc+soqppXPtUievou8JdCnbIrw6uINnWBKhWjdjiVWky83/biDSTkvvbU?=
 =?us-ascii?Q?ceJQM9FF1LPkNBH02+Y4WOO/IvSsOgbpOFta5aEQ1i6dVh1F14IQdkhrWRAh?=
 =?us-ascii?Q?u5CE5SGxuK8FV++VGT/GNVUsoybCjMNM+cy830hc+NT2ps0oQ8r3daqKdZge?=
 =?us-ascii?Q?dBdOgstl0Hm+Q+F49rQosHGSsMltATNSoKeE45/sAAXZ5NjJ8AC5WvE5649q?=
 =?us-ascii?Q?JCnMqZt0Wn34Xw7UZxRbHKWgrW5Na7xPwKoyIpX1+KzMeXIbrFDFs4tn52Cj?=
 =?us-ascii?Q?d8xu9iwtoh52o4qe+xW7PhLHR6XOLt8g+duXcvWyZGSmFf6q/DUfSu4uiiYf?=
 =?us-ascii?Q?RreO429qeuB74/ZxnUYuVWk+zbZH1N1C0+X+AhgZ12co9INSsW86jsrjxXY7?=
 =?us-ascii?Q?32MQ6inAXRbiqjFF4V8tZoq8sgh7PeNCVwakUj/Jzelqqq6xw7qQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 54db602d-c669-4457-f653-08df028137e7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:16:52.3207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2+viMKtQpMHlIvgnFbc6hSS5vH84xvZKtNJG8uAL6xcJxleB/sF50ZOh7wWStjjiU2PRBV6nZh9LM8DAZVxgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7484

On Tue, Aug 25, 2026 at 11:36:54AM +0900, Koichiro Den wrote:
> On Thu, Aug 13, 2026 at 02:09:26PM -0500, Frank Li wrote:
> > On Thu, Aug 13, 2026 at 03:37:53PM +0900, Koichiro Den wrote:
> > > Implement the EPC DMA channel delegation operations for DesignWare
> > > endpoint controllers. Verify that the DMA engine channel reserved by the
> > > endpoint function belongs to the integrated DesignWare eDMA instance,
> > > then hand its interrupt routing to the host.
> > >
> > > The DWC eDMA/HDMA engine generates DMA requests with a programmable
> > > requester function number. For delegated channels, the host-side
> > > dw-edma-pcie instance bound to the exposed DMA function programs its own
> > > PCI_FUNC() into the per-channel requester field; the endpoint-side chip
> > > func_no does
> > > not participate in that handoff.
> > >
> > > Reject VF requests because the RC-programmable DWC eDMA/HDMA register
> > > window is assigned to a PF BAR only.
> > >
> > > Reclaim returns interrupt routing to endpoint ownership. Propagate the
> > > EPC quiesce request so bind failure paths can reclaim unexposed channels
> > > without quiescing the DMA engine.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > > Changes in v7:
> > >   - Delegate the DMA engine channel already reserved by the endpoint
> > >     function, matching the API and helper changes in patches 4 and 5.
> > >
> > >  .../pci/controller/dwc/pcie-designware-ep.c   | 42 +++++++++++++++++++
> > >  1 file changed, 42 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 0b915824963a..a74d3896e436 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -858,6 +858,18 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
> > >  	return NULL;
> > >  }
> > >
> > > +static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
> > > +{
> > > +	/*
> > > +	 * The DWC endpoint databook says it is not possible to assign the
> > > +	 * DMA/HDMA registers to any Virtual Function.
> > > +	 */
> > > +	if (vfunc_no)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int
> > >  dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
> > >  				   u8 vfunc_no)
> > > @@ -933,6 +945,34 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > >  	return 0;
> > >  }
> > >
> > > +static int dw_pcie_ep_delegate_dma_chan(struct pci_epc *epc, u8 func_no,
> > > +					u8 vfunc_no, struct dma_chan *chan)
> > > +{
> > > +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> > > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > +	struct dw_edma_chip *edma = &pci->edma;
> > > +	int ret;
> > > +
> > > +	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (!edma->dw)
> > > +		return -ENODEV;
> > > +
> > > +	if (!chan || chan->device->dev != edma->dev)
> > > +		return -EINVAL;
> > > +
> > > +	return dw_edma_delegate_chan(chan);
> > > +}
> > > +
> > > +static void dw_pcie_ep_reclaim_dma_chan(struct pci_epc *epc, u8 func_no,
> > > +					u8 vfunc_no, struct dma_chan *chan,
> > > +					bool quiesce)
> > > +{
> > > +	dw_edma_reclaim_chan(chan, quiesce);
> > > +}
> > > +
> > 
> > After use fixed chan_ids, needn't these functins. EPF driver already
> > find expected dma channel and config it remote only by standard API.
> 
> (I've been somewhat holding this thread, sorry. I'm still unsure whether the
> separate PCI DMA EPF idea will survive, or whether making it much smaller and
> initially limiting it to a test endpoint for dw-edma-pcie would make it
> acceptable. AFAICT, Mani has not answered that point yet. Still, I think I
> should reply here in case the idea survives in some form and v8 becomes much
> simpler.)
> 
> I agree fixed chan_id removes the private channel lookup. In v7, the EPF already
> reserves the channels to delegate through dma_request_channel(), so Patch 4 may
> look like a leftover. Its remaining benefit is to hide dw-edma-specific
> interrupt-routing semantics from the generic EPF.

Let me correct myself.

On second thought, that "benefit" is really superficial. If we ever want a
generic abstraction for that purpose, it should belong in dmaengine, not PCI
EPC.

Now that the EPF reserves channels through standard dma_request_channel(), it
owns them until dma_release_channel(). Going thought PCI EPC just to change
their interrupt routing (in the dw-edma case) is odd.

> 
> The EPF could instead do something like this in pci_epf_dma_claim_channel()
> after extending dw-edma to accept the setting:
> 
>   config.peripheral_config = ... DW_EDMA_CH_IRQ_REMOTE ...;
>   dmaengine_slave_config(chan, &config);
> 
> That would make the EPF depend on dw-edma-specific interrupt routing. However,
> if the goal is to make the PCI DMA EPF as small as possible and accept that it
> initially only serves the dw-edma-pcie path, I think that is fine. I think
> that's your point, but if not, please correct me.

So even in the vNTB-embedded design, your suggestion to use prepheral_config
fits well. I've now implemented and tested it there, and it works. I'm preparing
v2 on that basis and hope to send it soon.

Best regards,
Koichiro

> 
> Thanks for reviewing.
> Koichiro
> 
> > 
> > Frank
> > 
> > >  static const struct pci_epc_ops epc_ops = {
> > >  	.write_header		= dw_pcie_ep_write_header,
> > >  	.set_bar		= dw_pcie_ep_set_bar,
> > > @@ -950,6 +990,8 @@ static const struct pci_epc_ops epc_ops = {
> > >  	.get_features		= dw_pcie_ep_get_features,
> > >  	.get_aux_resources_count	= dw_pcie_ep_get_aux_resources_count,
> > >  	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
> > > +	.delegate_dma_chan	= dw_pcie_ep_delegate_dma_chan,
> > > +	.reclaim_dma_chan	= dw_pcie_ep_reclaim_dma_chan,
> > >  };
> > >
> > >  /**
> > > --
> > > 2.51.0
> > >
> 
