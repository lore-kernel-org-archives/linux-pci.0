Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A72EEE75;
	Tue, 25 Aug 2026 02:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625422; cv=fail; b=VzXkV59nBmCQPiJLH5SAfHKXrKQT3bBWLSjjOcTvDO2CT9YQU+hA4ls9fkg0OK8VPwA213+75eLKWC3akW7qiU5Ozesf2IlzQOvba1HkhoG4mKTnZoGrodwiPH/w2Bq8TUIpm1dq/EBDn8TRHkgv/LZD7Bf3qSPtcObtezNUEGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625422; c=relaxed/simple;
	bh=GMQAzrtGpgtvBHpGJSg+YzdEGhnYyYVaei15JDrcyVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YmJYbxKVi05LPQOlJv0EZKZ9pm7kX3I8JbinKzawzWiQEtZHScs8fn5pTJbNNG7gsPXed9FJZ2OHafwZ/9ULzjprWDedEGiFS1WaTScHnmJ2TCfmhX6YPmch/RYLMrZbiAcCxfvz471j23VYqGwB1Gxy5XwgHCACv5qSN6zuIJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=q1rL/Mrt; arc=fail smtp.client-ip=52.101.229.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="q1rL/Mrt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrT0FHgjSrwZ4OHWihLcG/nzCrkAE/ORzPdyCuFBjujQUH2RMvPYoWkBDZZW7xkF8TwtQZ+v/bBVL4849ilV3yRL7HCVxN+7oXv/SGTgrH6i75eEjKIYkFaVYRL5QkZm5j8fVAR54WXd/JvU7ayYmwS4xtptlIznQZNO4sw4ws/jYXq+66qcKHA+sEZ7rP4S2tqdCFFQrIFA2nnXGQOSUiw8WLVraA+y3TO71pY+3DU2/b038c1s37BabE6ORv4ow2pJ8th9SOycZOypCXT7iza6SXVdOJu19Pw7kJeL2NEBSyX5e1etYlm73+H567m+hMaFHeb+rMh0GMFWBTqiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTmN3U29eeOurhp36bJlCQ5P5rePPyWLZ8JLhQ0R9/s=;
 b=XqSdd+lReZex3dhbwrKEwEoJkcVGMEXZ5ng7oB6FofmdDcIPvUNgy97TREu126D0HhbwORSmo1IRiDpX7jtmujwFcnYLrDA5PhGj3TyrI5FonT6lk7xIKO4ahnFnJEEkiM2NauIvtJb7l+fEDhyp6mXSO35nubuP7Whzx86SKo4ecGVxzFHVhbMBGHk5sv1Jl27ZFP8fmoVTdaqZwcEwFDpQI5e1aaT2BJ0e3ebRe3tyNIhWhDK5exh62WoHTKA4DFCPOSeEi5mLiHNJaUNXD07QwUKbWQbB7n6jlHZpiysAEP4vVDz4UlOc8kgO+pVEzTRXDYcSfqH2c9o70NDgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTmN3U29eeOurhp36bJlCQ5P5rePPyWLZ8JLhQ0R9/s=;
 b=q1rL/Mrt2weJ0yFEv4JL2pyAb0mTG9qV5PEF3dOy7xCsJNnjGZGGmtifIWybIsxBnmh1h8TMkWIoxjWtODcBV4R2PHjlkm8Hj5OzKH9E38UfwstU1hQjjXA6a/H1iD73/3JuU51u46F+AIEKTNREcufmI073Gm1o868Z+owRQEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2887.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:312::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:36:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 02:36:55 +0000
Date: Tue, 25 Aug 2026 11:36:54 +0900
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
Message-ID: <oiozls3u4bubqzfk4hqjgauzmuka2ixs4b44rvmrmosdqyxa2v@crlid6rfy6v6>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-7-den@valinux.co.jp>
 <an4WZkoIxCZ456Pb@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an4WZkoIxCZ456Pb@SMW015318>
X-ClientProxiedBy: TYCPR01CA0183.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2887:EE_
X-MS-Office365-Filtering-Correlation-Id: d26eb167-1575-4b2c-ee1b-08df0251ba80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|23010399003|366016|6133799003|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uIy6SPDqG4OXw0lRyUWwxZICVB7BzdVb3hLFHqsFIU3O5I8EEOv3g3h/rB9awKGE6BSIW4NwVyzMTCIxB5cbFPwbpyljDZ1oSy4KUl1nTrACXjox+I2Izbul0d41XaR+p6+BlBrEGNNyTwD/1f4m5o6h0uzpM6wLzchNC6INZjdbiUzkdURerxv7R90U9r1wv/l1drWRYNDxn00D9Ba+4M7Ra+wPr9aO0nziw2+24qowJ3A/T7uk0aWzKS2kt//DglGG6Vhmkv9xn3c3lG2R9o93shmqOmilIaUfAG7f6podZwS5I/NHGVykEHs/8DLqhGkFRG2ronxTcCLQ/Cx4JyxfFMNGEIkbkW+wwcsgYG8yqR6YOCCtXt34Y5gnAOubXlYJwh4r884pH1w1MgrAlabEa6oj38WPZBCluQ8qKyqCdzl1SvIk7IDfPqFnTmriSXP9EOz2XlayN/M0cuxn48hBBX5Zb34dZ/odPELQjuYaEWaqX3k190OFGyvDTtQ5X9n6mVxsEgIHpS4NB7Bm6kwt/7f2YE1j4bi8hchGmQ8hswDAQgR/LOs0zVR4f0YWICsnC8MlOuZHDH1Qdoant2FZMkgiDb+ney0U9H7r5OZ1Pzab6DhsvvE5lqt96lve6CQa+xi2T29mlqXjUyER950xeD39vemuKwsmbHoJ0HA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3jQC4yKiRvYWNPoqkSUq4aiMtF8nYVw/1YmVk91OlwqDueBmi4YrGogVZLXY?=
 =?us-ascii?Q?Dc3TSa2zYmEqKzbicgTouX6m/UQ+inckCWD6o5alR1CARgrrfLWkmXA4EwjN?=
 =?us-ascii?Q?7e894U6rC34jS683Hrl0a0w2pXTbpo6o+u44E5MN1mNSiHYpJ+AbnfFwq8ez?=
 =?us-ascii?Q?9bOtwsPw1bYh5kHPdh3cVUuiFoJkAi/FzGctHtOQ8+L8eRa6OBCasDCcYjqL?=
 =?us-ascii?Q?XSmIqdn+w2C9Uk400Hc7cezOyOOXgJShmyH9j/N1TjPcNx829WsKlk4o2uRv?=
 =?us-ascii?Q?Xnad3ZyDH+AtM6NzJ4xI3383qLUO+0KsKbood+SaJT+2qd5V1Rr4yn4QMAxe?=
 =?us-ascii?Q?rnTJgEceMluETuJDdu7cIiz6B4JPNeQe4uHPIkqnE45W/oxMNW2GQZLlIxBU?=
 =?us-ascii?Q?Rl8xnywKjBHrmeQoK9Zs6/o6QSCH0Yt5dcULT98vwT8QHvG223sp48xfz3w8?=
 =?us-ascii?Q?RSlWSKx/9igBlYhmvvDri+seksw5thOtnywdnSSOv5uCwYSEMZ9HOtJyH7Q9?=
 =?us-ascii?Q?FC70TWbrEI9tI0x92iRmAF3RnMuRnxu4xPctWBOieM0q7ArV4uu5xWHPctFk?=
 =?us-ascii?Q?KW8kul8UAXnAQbw550qhZkrp0nL/OVZchpeKYO0uob+PFycrnb1JgIW2pHID?=
 =?us-ascii?Q?Ifs5n55ysj1SD0QC8bbYW0olpt7NAdziOZvLlD1HRrpwzjaNS83RaE0MHnkK?=
 =?us-ascii?Q?29quCz7X4X1YDpJRhbLOP+7S710/B4JwKwvJ22O5YmVLBg514hxS62NXDrZg?=
 =?us-ascii?Q?TJuhSBh2DcBKDVB0VdElMFO6BSIYbIT+r+6QO1wdyxthew+5i361uf9oqumx?=
 =?us-ascii?Q?nIeJ7lWBu+DUgbrgnJuSSFvIJpT48v8yxbCHAZCJzguKDf4hnT1xJtt7eUgL?=
 =?us-ascii?Q?D+RiCCbTyAQTP2Gq1rI7bR4DYpy/2k2224C2A/1BUw6/XmZNBoxzaPXlrY5I?=
 =?us-ascii?Q?T++hj2+npRciFaYH7rSUB8A1Hrckn90z0MuU2p8JKPWf+882frATyJhG0A6N?=
 =?us-ascii?Q?eH3sfyf7+rWNDBrRuv/3irpWBAtuwzORsTw9OQo+pe7vkzuPpxu9obuff5av?=
 =?us-ascii?Q?3eY1zMEBjV5feGFJYNuteRwELQDOnGOyN6/VW4pqPb7KUKfnAAleAcMPS3fR?=
 =?us-ascii?Q?eXnTjUUbDVPxMMjN5IDpJzVzv/BxJhf0mV77M+wfonvbJAmmNtPrUo3nZlTO?=
 =?us-ascii?Q?ilcdpMNQSDmcUAKTprkfock0Q+qCaMTRm826JISXAmMyhq5xycYZHEP2DBMf?=
 =?us-ascii?Q?2ZjR2ZoY1j06M/MugaI1Z8Ggak9asglNgCzZTWZnQHre/R58WKmtWWaasORf?=
 =?us-ascii?Q?nq1PNaXRZ8sqHca4N1BpV6oTJaSngidFSj5Pk46x0Fyr8RghYDDn+2nRBk8p?=
 =?us-ascii?Q?JP4FfDn/DRE7N+Im53hVsfXxH8qgEYrb3IZopGYsSprgxoq+IVYNTTtDoQ4Y?=
 =?us-ascii?Q?oGfxyaf1mBllStHJfAZOB6yIzwLokNpsztwakAJCz5kUDf9MhCceHwFOHRf5?=
 =?us-ascii?Q?B1TiFe9ZfiO9WSQKiQwxgCw/Q73Ov8CrWexUciXwDGvfgJ5DVfD9OgtZnxxF?=
 =?us-ascii?Q?AckbKFjr27ScMeuH6eBRsGarXMTegntWA+R9NK13mXvTxxVO+5OFLqDcG3cu?=
 =?us-ascii?Q?7MsL+GPU+fMnfpxVm3ruX4OiMdyFHkMAlSJRs+P7rqoqpkSU13wAbx//cmDK?=
 =?us-ascii?Q?o2eU3cHA/59d2fWNAUyk+z2nJfrlrr9aZrViGHPCmYhhef0Ae1DaRQoBVkVS?=
 =?us-ascii?Q?HdApQ61GvJjrm6DCqdQrmG/Ki50QeA+z0v7+a2LoAb/T9N4GIzt6?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d26eb167-1575-4b2c-ee1b-08df0251ba80
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 02:36:55.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3acvTWpVx0E4FiGVKDsLF8uFDdMnRTVU7fXMVlRC9+DgK2cBEozm0wqdpcB6EhuCQo/zcNwk6XtxJP67xwzAOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2887

On Thu, Aug 13, 2026 at 02:09:26PM -0500, Frank Li wrote:
> On Thu, Aug 13, 2026 at 03:37:53PM +0900, Koichiro Den wrote:
> > Implement the EPC DMA channel delegation operations for DesignWare
> > endpoint controllers. Verify that the DMA engine channel reserved by the
> > endpoint function belongs to the integrated DesignWare eDMA instance,
> > then hand its interrupt routing to the host.
> >
> > The DWC eDMA/HDMA engine generates DMA requests with a programmable
> > requester function number. For delegated channels, the host-side
> > dw-edma-pcie instance bound to the exposed DMA function programs its own
> > PCI_FUNC() into the per-channel requester field; the endpoint-side chip
> > func_no does
> > not participate in that handoff.
> >
> > Reject VF requests because the RC-programmable DWC eDMA/HDMA register
> > window is assigned to a PF BAR only.
> >
> > Reclaim returns interrupt routing to endpoint ownership. Propagate the
> > EPC quiesce request so bind failure paths can reclaim unexposed channels
> > without quiescing the DMA engine.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v7:
> >   - Delegate the DMA engine channel already reserved by the endpoint
> >     function, matching the API and helper changes in patches 4 and 5.
> >
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 42 +++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 0b915824963a..a74d3896e436 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -858,6 +858,18 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
> >  	return NULL;
> >  }
> >
> > +static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
> > +{
> > +	/*
> > +	 * The DWC endpoint databook says it is not possible to assign the
> > +	 * DMA/HDMA registers to any Virtual Function.
> > +	 */
> > +	if (vfunc_no)
> > +		return -EOPNOTSUPP;
> > +
> > +	return 0;
> > +}
> > +
> >  static int
> >  dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
> >  				   u8 vfunc_no)
> > @@ -933,6 +945,34 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  	return 0;
> >  }
> >
> > +static int dw_pcie_ep_delegate_dma_chan(struct pci_epc *epc, u8 func_no,
> > +					u8 vfunc_no, struct dma_chan *chan)
> > +{
> > +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	struct dw_edma_chip *edma = &pci->edma;
> > +	int ret;
> > +
> > +	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!edma->dw)
> > +		return -ENODEV;
> > +
> > +	if (!chan || chan->device->dev != edma->dev)
> > +		return -EINVAL;
> > +
> > +	return dw_edma_delegate_chan(chan);
> > +}
> > +
> > +static void dw_pcie_ep_reclaim_dma_chan(struct pci_epc *epc, u8 func_no,
> > +					u8 vfunc_no, struct dma_chan *chan,
> > +					bool quiesce)
> > +{
> > +	dw_edma_reclaim_chan(chan, quiesce);
> > +}
> > +
> 
> After use fixed chan_ids, needn't these functins. EPF driver already
> find expected dma channel and config it remote only by standard API.

(I've been somewhat holding this thread, sorry. I'm still unsure whether the
separate PCI DMA EPF idea will survive, or whether making it much smaller and
initially limiting it to a test endpoint for dw-edma-pcie would make it
acceptable. AFAICT, Mani has not answered that point yet. Still, I think I
should reply here in case the idea survives in some form and v8 becomes much
simpler.)

I agree fixed chan_id removes the private channel lookup. In v7, the EPF already
reserves the channels to delegate through dma_request_channel(), so Patch 4 may
look like a leftover. Its remaining benefit is to hide dw-edma-specific
interrupt-routing semantics from the generic EPF.

The EPF could instead do something like this in pci_epf_dma_claim_channel()
after extending dw-edma to accept the setting:

  config.peripheral_config = ... DW_EDMA_CH_IRQ_REMOTE ...;
  dmaengine_slave_config(chan, &config);

That would make the EPF depend on dw-edma-specific interrupt routing. However,
if the goal is to make the PCI DMA EPF as small as possible and accept that it
initially only serves the dw-edma-pcie path, I think that is fine. I think
that's your point, but if not, please correct me.

Thanks for reviewing.
Koichiro

> 
> Frank
> 
> >  static const struct pci_epc_ops epc_ops = {
> >  	.write_header		= dw_pcie_ep_write_header,
> >  	.set_bar		= dw_pcie_ep_set_bar,
> > @@ -950,6 +990,8 @@ static const struct pci_epc_ops epc_ops = {
> >  	.get_features		= dw_pcie_ep_get_features,
> >  	.get_aux_resources_count	= dw_pcie_ep_get_aux_resources_count,
> >  	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
> > +	.delegate_dma_chan	= dw_pcie_ep_delegate_dma_chan,
> > +	.reclaim_dma_chan	= dw_pcie_ep_reclaim_dma_chan,
> >  };
> >
> >  /**
> > --
> > 2.51.0
> >
