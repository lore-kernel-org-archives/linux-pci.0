Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.125.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794285586;
	b=yIVRKPSwNhS0hxtSci2weR35fqvURdOAkJct3XRTQvFOajyeiVuYZPra60PjwAPmh9te
	 0IQRxRoppNE5L32YhVK0awO1YZW9+ICCR4t2CqFCxBcSKDB4Tdh6sSx3nY7GEbiFbrbu7
	 ULN48BrDGtHMAt2DYqFeGZvAYZf39VFjMdG9tL3xDR6/p7tNGHYALIYLmVdJf+sq40vML
	 pXUDEbg94SVjUXYouqdcsbLy6p0M0SphvK9vPiMTZ4QBdP2cF+2nb+6tvqMgTKRsMyfsl
	 mQtMF4O81d9cHfTpShytRuAS+ytK0xMv7bjeUSahzjButCpJ3FsFXxYhGx1Cd168yxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285586;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ANnG2vDn9typgM+nx/ChI4yxnDb+1iRzRuA5XP+xrrc=;
	b=z/79zl60w4T7Dk5KRYHKX+79uFeqQ74ojF39BkXClahZoTRhTCjs+U+whMxjvlLQgspt
	 cwxu6V4MyNfqioOOwYofAwjphSP9bKKXPO4k2zG/oP3XQVcuf2d+MuYK5Nip2zNILwgWH
	 1A5wXCG8MMPCWXylkeRTSwl4utwRKBO9+7S/0/Q/g8Je3DORAGchleh44f9sWBXGqjPS7
	 Qs4y8y2ONWkKFWJv8JeqGR+6L8UTLu7sm3XJrEu/GP8L7442kCwJ8Wp239PLey9AUQqWa
	 qIWby58xUyY4K/Y6bdJktWyGWQuYDAF5cruCERt+BDSXuNja6WOhmU10cSxdkvsPfWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=fail reason="signature verification failed" header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="c6vKp2A/";
	arc=fail smtp.remote-ip=52.101.125.113
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021113.outbound.protection.outlook.com [52.101.125.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5F606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1A5F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=c6vKp2A/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brgVfPZOIHamHcvKQzdZKGHLRzO0GalQPZrigHS626uMp58aKy6IZ7APMqnnibT7ZjFGuHr2DQjsn6690tIKrB2KRXHLYuxTgKxZxmHO/hJeTp8fSx3agXijs351CD1lqJ6ohXhGOqIjw6e0Z73RXCMSyJBDSEBgi4CeF93kFD4CDiY5ehO9HZAbUFOexgFx2XHYckTKCdVlxO6DuI0u1Jmu6kT6dEq91IXwfYtWgjmD2+zSGLR6ah3qRSrKECmtfNQrPtbZhYstEDmr9h2RHlPc9e8R4vLVHzRKZcGqKX0A72unTsoxzN78IGd/0VlyfFYCz6/w+TWg5pJt8wa39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsQgIvOaaQVuZ/EexQJOgp8BBcbP1A/qctMN/ej6+Rc=;
 b=Lgd9HcRgFJpxCve5JnTQsBxFxZXu8f62MAi1QosJkEEqm7p7ioM/89swIudpInXLXg7xj6pd+v7fqGGbB0UbRSF0sGHFeWsFc5Dx8HTM/HFIrqdcZYrgzmahjTHEztVwQCtoUfcN7BbNoOI5r6P0OxmER0uEeSGbcCuwO/k6UAKn2YmFXv0kg8uOO4AbatXDiUy6XCyqwPlc5oicsjB7IDN+U6p/asAhEofSlnHOGqGhk/CaNWsyDf6n5AJDygEXT6dpm/jLYRSNhwuH8ruEkPvtkj6bawfTggHMgcCv/w5K+VeI85jVka08jrKP5ztxA68H5EcbjI4VhhDm2BLNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsQgIvOaaQVuZ/EexQJOgp8BBcbP1A/qctMN/ej6+Rc=;
 b=c6vKp2A/dFroYUeX0oaZTZeWXIO8y/DrQR4bW0Fs0bu9knbGhLT5HGZo0Lv8bTRfPBbuRKPeoP0ac4Nna1lxy27Exdl3WBUcSuzqkeCMzXZUCkNsRlAMS7gem8GbYxou9ahnWEpx5WZNDDFd1Rca0sKhzxwcNBfKHXBwpT6GDC4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB2366.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:18c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 04:39:42 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 04:39:41 +0000
Date: Tue, 10 Nov 2026 13:39:40 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v8 02/10] PCI: dwc: Expose endpoint DMA resources
Message-ID: <uvq3ukrznnilb5jl5utfvezi25xnmtto3ucormlhrns4rkbdto@t2xvccuuhc76>
References: <20261022082230.3164834-1-den@valinux.co.jp>
 <20261022082230.3164834-3-den@valinux.co.jp>
 <sashiko-outbox-181198@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-181198@kernel.org>
X-ClientProxiedBy: TYCPR01CA0137.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB2366:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0684c7-6555-4fbf-511f-08df3ee4a2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|23010399003|1800799024|22082099003|18002099003|6133799003|3023799007|4143699003|56012099006|10067099003|261028144727099003|261102130727099003|261009223027099003|261102123227099003|261026121527099003|261026135527099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	gkW6Z9+AjfLLJeybVJwuV03DN6g8Gxzo8JMb4u5vZvTaWXRUoTsOJnNNgtfIL0HwBWzcJEV6n7av97Py9Ti4x0mBUiaT6udvIBk+4jZU8zF2v+mldTNoSLeeZh+/WaqJc6r3VbMnfM4hCMaCVExqEuBeKgseIaoP2W6D/+7cbb8NzJ33qB85b6+hEOarvICGfIpxBtOdYVxnU1Y/LMQ1DJe3LTkPms3PLlwvMVU8BSdYh2C73DhouPLFzj7e/v43zq+zrh0CBh3UdRrpXVvrdjPqh84JNTq8NJuBWwG3c7u5Ge5qfWvZTNpeT4K4vPQE0bKHNiKwZnrRi1nypS9/SR4Qnw881fuaLyU60lXWy98a1KYZTAoaFFdBv/FlBU0okfUXa6M4kqedmIYTU9sV5Nu511zpzcp2vB9lU9EGvUHrXJIuyrxsd1zovZoThu4Cf/+rQZejozq7nMGHUgWDa2L5JcRJyH4SCyZZsmCIn3jBCJC1AYk7hp+xdkPh4OULF3UmEndpbENNCbrHy5W8fS1Ehai2YWvhCrBTHD/A+nGoP8SnlZyBL4FEoPg+awZr0WS8YcG+LWz9q3OUuvK5tlTcQ9gVgPfDrPR1E3tL4dA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(4143699003)(56012099006)(10067099003)(261028144727099003)(261102130727099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026135527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ODTKhoVEPtrcaKeOFunZCDlrc8YaiSHza1derFz+B+Psl+jytj+GQnOMZ3?=
 =?iso-8859-1?Q?rz+ZolKHuvo9ALSVW8nkbReaaQTay8q6QmDOs/+6gGma69Z+4wqSvEdD3G?=
 =?iso-8859-1?Q?YCMAzklHDlP5Y66gBZqJxVUdzVhr9APUGmBVKK9oFfIU04XhIFK0JeqcF6?=
 =?iso-8859-1?Q?5gTvWFlY/6hYgYWHQF0wbCRvdFY3PYC5UyBIQi+FblyRmale9MGP1fzbAQ?=
 =?iso-8859-1?Q?le9zDIt5va175OzVQ1PkMsq5Y0MTw1c7/dSfNIIpj2Ys30IWjgX1ac7G4T?=
 =?iso-8859-1?Q?gg0xWfuKG1qpxVKC9wejmQY1V7Ot2T8u41GRMa2WwSxiKFN9Zv0PHOM3Dx?=
 =?iso-8859-1?Q?E202aus2BqFhuB81yG5vebfNrBGbjOclPlQhrjZwk6elaZyxFFXqitRlrb?=
 =?iso-8859-1?Q?l4thJoQ9FJoM9ePnq5R2p4xFAtjBtQq7bOLubRUACmFrSDc7hKbbTLkp0N?=
 =?iso-8859-1?Q?RyPz55z9Sr5ohOl3zO3ouCjfx3MU2HBQ5i2yI/zHAcX8Dof23MjgYHOU0E?=
 =?iso-8859-1?Q?gbD4tn3fQ/s4po2S6DnOCMTlYn9WMovR3xLY02lUM0mmfPjFKVox2dbXuP?=
 =?iso-8859-1?Q?3LxTWURh6uujGZLqflXYTGhZ+4GQRdz1PGaxTiEmhpFYJhIPjv6VlpvqT5?=
 =?iso-8859-1?Q?t9GuL87VXsI96hZxwy8O27zN2Hoeohi7LDnc0JPn8d4qHDjmFL013/dyKS?=
 =?iso-8859-1?Q?f5ooLckOeSE296eKiMYh3BrlHuTJgIbPBEIlL1ClX0nthC17YtQc3OJAIl?=
 =?iso-8859-1?Q?9i3KSxYpvF3UrIsoewz3fGociUcZttoLAgM/mP9v4dOR3MTK/KhCuA84Lg?=
 =?iso-8859-1?Q?i9UtKQfz9y/PXEyk9rzw/CR/9/iXg1H0aqGS1LoF09kkaFPgfrA28QzqQ+?=
 =?iso-8859-1?Q?jGP4jYLWhi5D7KRWfYPoOcyCSr/fbO/w2JLJIeBlRv57JZ+V+VoyGo+JX+?=
 =?iso-8859-1?Q?w9vP29cALeQOklVZyWjhwOFJn9OUtcUHiL6KkHDa8n1JR+6+x8OwYbmhYu?=
 =?iso-8859-1?Q?eCSPpzb29taq4cETtiBhYEhYTp856MP/w98Z3bpbC58LHPuFObU+4IT8E/?=
 =?iso-8859-1?Q?egbkzmCzIoMFp5E9r0qaeebBMTPmrmg2IpGvU0RJoNTH378Lgp+HFEa7r9?=
 =?iso-8859-1?Q?Qku+QgMYeLEA0PdtMw/Zxr3VkdSgBzDBijzoSoRWmjUHcmoeHsezY9o0Eu?=
 =?iso-8859-1?Q?z9K2+9OMp/8RBlSaw0fNTF4VBXmQ+DptN5Ge3BFKmQmuAUJVudyaTgltlP?=
 =?iso-8859-1?Q?/PmfmNoASp8UxKnEEgEwNHvCNMGixQpa/nJwAi5Ov2T4hZxD3PvRltTjBw?=
 =?iso-8859-1?Q?CHzlhpfgl3J/pnVUZ5i6PxWRRulCsLwVAnaYGxZEI9NyoJiX4Q1skF9Rjm?=
 =?iso-8859-1?Q?cazvy7vgafCCDTEJ0qDI83nmpa6z37oRc0HYTKYXdY0xhB2MpfRZfih6xZ?=
 =?iso-8859-1?Q?ZeT+n5nJEyHi78x/q0NahL8jfB/3NbDRy2P0mXp2kSRGRSSAGxO+nrVPwa?=
 =?iso-8859-1?Q?jh4dkHj4UaraNLt1WLZ31qISW13XLxGPVMDiz1S7NgteByTFfCqB7FSfjK?=
 =?iso-8859-1?Q?aExzZD+y8UnH1Mp3y8BFn7XHi63rd9hMnG7xLHAxRDGvXgOAUxhknJ4Pt8?=
 =?iso-8859-1?Q?CiKRaBB7CVxV1ZX2u+RYdTJpvfBw71DVyeyKDVyjg9nleL1m0OJhyhx2kK?=
 =?iso-8859-1?Q?71+ov8CtLGaJ9qsCGspMb/g+nEjrC6B+IH/9EHUhoE66k1BhbG1x+8J6Ht?=
 =?iso-8859-1?Q?GDMG2OZxiP5ETE6pEoAYUqPy2PzhfrS/6f1OgFTefAKelcfUEiu2Bv1EOy?=
 =?iso-8859-1?Q?9fQw16oU7NIH0T/f5R3CZY9ZJm7HwwGFIFr3c5cc3V3j/hRqJtw+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0684c7-6555-4fbf-511f-08df3ee4a2ad
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 04:39:41.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LviDowiHqtYCn9EUGh7217U5IPdOfFdxfd9OJNrQ8jbOOKbgIJf7JJU9V3g9Yuv/VPAOVZq+0+EHVgGACMzGMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2366

On Thu, Oct 22, 2026 at 08:42:57AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] PCI: dwc: stale edma->dw in dw_pcie_ep_get_aux_resources() after eDMA removal
> --
> 
> commit 9475ea2f70e5c9c7b09a2bc537c0f97a6e428f7f
> Author: Koichiro Den <den@valinux.co.jp>
> 
> PCI: dwc: Expose endpoint DMA resources
> 
> This commit exposes the endpoint-integrated eDMA register window and
> linked-list memory regions via the EPC auxiliary resource API. It also
> checks that the local dw-edma device is registered and rejects virtual
> function queries.
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 630ba172280c2..7166ec7f212bd 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> [ ... ]
> > @@ -865,14 +874,30 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
> >  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  	struct dw_edma_chip *edma = &pci->edma;
> > +	u16 ll_wr_cnt, ll_rd_cnt;
> > +	int count = 0;
> > +	int ret;
> >  
> >  	if (!pci->edma_reg_size)
> >  		return 0;
> >  
> > -	if (edma->db_offset == ~0)
> > +	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!edma->dw)
> >  		return 0;
> >  
> > -	return 1;
> > +	ll_wr_cnt = edma->ll_wr_cnt;
> > +	ll_rd_cnt = edma->ll_rd_cnt;
> > +
> > +	if (!edma->cfg_non_ll)
> > +		count += 1 + ll_wr_cnt + ll_rd_cnt;
> > +
> > +	if (edma->db_offset != ~0)
> > +		count++;
> > +
> > +	return count;
> >  }
> >  
> >  static int
> > @@ -885,14 +910,32 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  	const struct pci_epc_bar_rsvd_region *rsvd;
> >  	struct dw_edma_chip *edma = &pci->edma;
> >  	enum pci_barno dma_ctrl_bar = NO_BAR;
> > -	resource_size_t db_offset = edma->db_offset;
> > +	resource_size_t db_offset;
> >  	resource_size_t dma_ctrl_bar_offset = 0;
> >  	resource_size_t dma_reg_size;
> > -	int count;
> > +	u16 ll_wr_cnt, ll_rd_cnt;
> > +	bool has_ll;
> > +	unsigned int i;
> > +	int count, ret;
> >  
> > -	count = dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
> > -	if (count < 0)
> > -		return count;
> > +	if (!pci->edma_reg_size)
> > +		return 0;
> > +
> > +	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!edma->dw)
> > +		return 0;
> > +
> > +	ll_wr_cnt = edma->ll_wr_cnt;
> > +	ll_rd_cnt = edma->ll_rd_cnt;
> > +	db_offset = edma->db_offset;
> > +	has_ll = !edma->cfg_non_ll;
> > +
> > +	count = db_offset != ~0;
> > +	if (has_ll)
> > +		count += 1 + ll_wr_cnt + ll_rd_cnt;
> 
> [Severity: Medium]
> Can edma->dw remain a non-NULL stale pointer here after the local dw-edma
> device has been unregistered?
> 
> Both dw_pcie_ep_get_aux_resources_count() and dw_pcie_ep_get_aux_resources()
> check edma->dw to verify that the local dw-edma device is registered before
> exposing PCI_EPC_AUX_DMA_CTRL_MMIO and PCI_EPC_AUX_DMA_DESC_MEM resources.
> 
> However, when the eDMA device is torn down via dw_pcie_edma_remove() ->
> dw_edma_remove(), either on the err_remove_edma error path in
> dw_pcie_ep_init_registers():
> 
> drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_init_registers() {
> 	...
> err_remove_edma:
> 	dw_pcie_edma_remove(pci);
> 
> 	return ret;
> }
> 
> or during fundamental reset in dw_pcie_ep_cleanup():
> 
> drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_cleanup() {
> 	...
> 	dwc_pcie_debugfs_deinit(pci);
> 	dw_pcie_edma_remove(pci);
> }
> 
> dw_edma_remove() in drivers/dma/dw-edma/dw-edma-core.c unregisters the DMA
> device (and resets chip->db_offset = ~0 via dw_edma_emul_irq_free()), but
> neither dw_edma_remove() nor dw_pcie_edma_remove() clears chip->dw:
> 
> drivers/dma/dw-edma/dw-edma-core.c:dw_edma_remove() {
> 	...
> 	/* Deregister eDMA device */
> 	dma_async_device_unregister(&dw->dma);
> 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
> 				 vc.chan.device_node) {
> 		tasklet_kill(&chan->vc.task);
> 		list_del(&chan->vc.chan.device_node);
> 	}
> 
> 	return err;
> }
> 
> If an endpoint function driver subsequently queries
> pci_epc_get_aux_resources_count() and pci_epc_get_aux_resources() while the
> eDMA device is unregistered, wouldn't the !edma->dw check pass and expose
> DMA control MMIO and linked-list descriptor resources for a removed eDMA
> instance?

You're right, but I think it should/can be fixed separately in the dmaengine
core.

The vNTB path still needs to acquire the channels via dma_request_channel(),
which should fail once unregistration has completed. Returning stale metadata
alone therefore does not let vNTB export those DMA resources.
I don't think this needs to block this series.
I'll prepare a small patch for dmaengine tree.

Best regards,
Koichiro Den

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261022082230.3164834-1-den@valinux.co.jp?part=2
