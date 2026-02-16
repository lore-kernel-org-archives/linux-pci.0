Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021128.outbound.protection.outlook.com [52.101.125.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294D26E6F8;
	Mon, 16 Feb 2026 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254373; cv=fail; b=d2O+n1eD7JfywW8f5TnwZFo/tmKaUK6HieaRFtkPkuEbMKTPYsDVa7AkUaEqtF8iZ3DMLBHRa6mNm+3u0hhHwHl9twIu+cV2vMW1m3opuIvrDxgVMMzCz7TzrLJsafGr1Q/302BuPDclGnfjt+1unmUUS9Ik6Y4mgwjHSuVDsEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254373; c=relaxed/simple;
	bh=FH0eYhA0+VWUvYalxKj4iz/FLDGvvLDZvT2gbLVPhUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EQprU/Ql7ASwliB4b3MC0T1mw9kYRuDZ4jn2LLLzij9L2h5Rc7ImUpBidHZgY494z2pWh1jb05DLMNBoIpL+acBbfBwKft/Aw9gB/ot8zbs1aWHK+rniN6BJPacoLZ+FgYPMmGlAlpAN8e3UIiziqPJSBk06R/lw5XGqCAq9dng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uNt+H92s; arc=fail smtp.client-ip=52.101.125.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uNt+H92s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4Fl2Gan5q7pRS8b+d02Okrf1isfApPIJbjLF1W85IZbDNWyNkeylxgj2vqeRqnc7HWDYrcqDcrGzAZhSBGjk4NarOIztwMG0fkiqG3tZLg2OOWMOlCvgqS4M0WEfeMgNjctJ5h3jqp+vXekdDGJl1RqkeO3U3QG9g6ALYNVb64+QKKhscGQG8ynGIMgdFWshQ8eboA6SVB+a0xWD1ErNqNt0Dr9xeD0Vt822unh6rNQ/BCYf/dRyOsfHCecZxaQ93zz1JLjF8GbAonAU9LwSlkNjq9wQud6K969GM27uZNU7IH2JHxWIK/IS0oPHCDd05Lx74pRJyRgf4zy2BVPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ryuUIiY/6ZhjKLy6l4wzTKf7ZpzxSkYSkY8n5vOYkE=;
 b=JzF8gXaTIVpxYVJxo+PK9ssbdcjkNuepbcmdnPZ9ngGoLpTd2vCoO/zsBdylZBr+D51dA5RIyyVY27ebMW5uFC/sDnZyj9XmlgV1Y6kHCYfcFylpIULbBGZSGQDHtb+NTN0R39SphAwoqp1BgvU/aHuS5kCDdviJcwPoOaaEKS9ZFVJkOYMpjHuoaj2SvuPE7c9odKxhDYwXSFeH2+JlseV1c4VnPdc1fNq8FsFV6yUATMRUyzp25G2na97gy33sylyFY0mOPBUrBww+SJDQjHLkFFvhRAGdZHWyk2EhXmbvxAt1IZNgktAi08HFwIX+G3XVI9U306rvqqFyN71wfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ryuUIiY/6ZhjKLy6l4wzTKf7ZpzxSkYSkY8n5vOYkE=;
 b=uNt+H92sFlKPziZZCYYzw+TWYiDz1Kl/POXvahBnRSVsmZMLYUtjyyLDF5yT/QaDqbBDDaCc5g1Ch6ya6b0BgJR2S7U05bHSrm2wBq8UJG/CWSwlLmZkfcPCcfbI/rMoGiFsGDka+P277NcOvlS4Aljhk4EWUC+j1T7twWAcf1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB1677.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Mon, 16 Feb
 2026 15:06:08 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 15:06:07 +0000
Date: Tue, 17 Feb 2026 00:06:05 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, heiko@sntech.de, 
	kishon@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	shawn.lin@rock-chips.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 5/9] PCI: dwc: ep: Expose integrated eDMA resources
 via EPC aux-resource API
Message-ID: <lryeu64nxxp34mx7re3w4jy2anfie52xtxcxa4ff6dulzcwhjd@ce567iui6piz>
References: <20260215163847.3522572-1-den@valinux.co.jp>
 <20260215163847.3522572-6-den@valinux.co.jp>
 <aZMl5SVsF_mzEsNT@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZMl5SVsF_mzEsNT@ryzen>
X-ClientProxiedBy: TY1PR01CA0206.jpnprd01.prod.outlook.com (2603:1096:403::36)
 To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB1677:EE_
X-MS-Office365-Filtering-Correlation-Id: 23adaf30-ca37-4f6c-6d4e-08de6d6ce969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ciyujluYEapXqI59dchHFoGygI29XD0Q/5Ulgvwzu4EYGZfqdy94e+0vBz5p?=
 =?us-ascii?Q?RF+Ist194LqTSFfcuIkT4mcZ7y09vG1NK7W1Ap3fj7Z7PFBsR36lyV6QljM4?=
 =?us-ascii?Q?z/ZsZebJ9PRptITGy+3tzqgz6rUVz9KHkn5XyYy86icFLTjrLiMDvUMNb0Hq?=
 =?us-ascii?Q?T64EHR9IakzFNkm5lKVopNIOhRf3BnGjIRgfoZMF4QrtJmRXuq/hEj1rPNrO?=
 =?us-ascii?Q?v5YlWcKKEGLuScTmA70mYvQSKWWFM9lBFSt+gZXhrbXpVJVgCLOik+6EGeIk?=
 =?us-ascii?Q?s6hnwSdounI5dnvzZqJr+7LHftSdjeJHBBNkS3rbXK8neW136FeHpjO9cq5e?=
 =?us-ascii?Q?P8WzoTKC9fXiOctXGYQe6sDjJ/C7dCvrJMU0eQQAn7gXuvzlr7gI/ACH7CfQ?=
 =?us-ascii?Q?YhBlCa+w/H36Y9i4zBft+soVJpQF53ago9EVaDS1zMuRMKOvPsUP+bl/ZeS8?=
 =?us-ascii?Q?PP/7KdsQVgIVbShmRsEIGZLUrsL1Snxp7+UpM/EXXb1cXdmuDjM5IOqI5yAC?=
 =?us-ascii?Q?/w4RPMd+xebFbT2IqH4+J/WvNA2rrLtzOrCZh6u4vrBYJ0H/4e9GuFX/i+W+?=
 =?us-ascii?Q?rJd+QFgb+xSXSIm6VaMF7jYUL42CI9/PaE4qkaLZS1B2foI2zFc8okSnUWei?=
 =?us-ascii?Q?oWfU7C9CWxDhHiRyFCTs/XVDGUMipepXjAXWAjhL+XDxTS4XJ8OqlH7xtHoi?=
 =?us-ascii?Q?gEpq7MO67ijWcKPdrhxxHX9M7iVUVALIH/EUnBKZl/NrN8G+r9py65YrVnrX?=
 =?us-ascii?Q?/yyhV+cokgtt2axKwdkXG0Xa+n5aQszGm7DxAeT6IHONBivxpmcIiOp7KERs?=
 =?us-ascii?Q?IadVp+prAW84m9Jp/cnRBrMghi0YzPYE6U1YAyeg3hiczCd81N1ZJpDUx+gA?=
 =?us-ascii?Q?uLF6F6ELTMNh67mILvMQ9WkMB5NCyN1GQgYuxFi2olJuZq44R3CdatoUPvdV?=
 =?us-ascii?Q?ec+9XDhZ9ojkXl4NnOoz6DkPteaqQCg4wX11YZtF1Njmad1GvPFKQEDVscbq?=
 =?us-ascii?Q?jo032mOCOJyc9PTkUZAnwyMEYdxeQa9BQAPDj13z1W14J/7mPoTT5sGoLgxn?=
 =?us-ascii?Q?7fix+heMiTU7TEn/lBjgdyLo5Ms2xg5OHdx1tZb/WTypeLhvZXBd6g2ZV826?=
 =?us-ascii?Q?UgrW53egMYuj4XBFl0PgBif3TjtgfFTE7LIDaGid8p5zR5C6lwuKDYURPSc8?=
 =?us-ascii?Q?Pk8cXGTh1RtiRU5CuSnQAMaPr1LyyctAyxlOTfvLriIL7DuyZEDHHX8mDUXo?=
 =?us-ascii?Q?L8TXT9ISMsYaWq6c19lumatjknSDk+alZwTGMUU+Xj9Vw75M8jdbikDZFWHS?=
 =?us-ascii?Q?cJPdsO3bZPGDtpYIivCxeD3HzOqHwumbDO5VZU9MPR/xfNvb2VZ4Msg+VmQk?=
 =?us-ascii?Q?sASJxxKpOuOfYPLisOAzVYr4SVBWjdbzS9Lr18Qythj95eCQKtRSVjDbyDBW?=
 =?us-ascii?Q?OprpmuTNHbY6blGozaLrnkEgYmA/RPq9UyYY/0zuVvmbvtyzTqGP1iTwj+r/?=
 =?us-ascii?Q?tN0f8h3jefV2ZeyY7pCg5g6IYmbr1qqJPdQpaTOY3YhlLBjutPK5cMLmoOVv?=
 =?us-ascii?Q?x7eLkWZK+XJDIHOINFE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WkUHx55UE+Q8qNUNqVE1ns5lN0W8ySntIH/SdDM26PKmdALky8yTfjoNGOFs?=
 =?us-ascii?Q?cP+7IPebIA80Z2v7cOmKUq1jhrNFdQ+F7KiWdgFIBOK0W264tT//IQ50KVQj?=
 =?us-ascii?Q?HmyVf7n9Zr4kPV5AKkgy/Q+MG9n91b33SEyAPk6iXgNR+gDLgse4tHxhevXN?=
 =?us-ascii?Q?CI/0TvmhdIhEn160ylxdV5sJqonOyCUrdERMDNF8xBknMmGKQDDQIr1YZy9s?=
 =?us-ascii?Q?soDjKB8Fq1g7q3JHf3J7+XYU0I2CuRWIY+RwMIkbim9OK71dmT0PAAOTe7uE?=
 =?us-ascii?Q?/kJCqS3RAYsAglJ7oQI7ZG8ClcIuQhuP60RACuZR7uL884wxtObtG6Mi4Yn4?=
 =?us-ascii?Q?Aed3VCZwo4OqgsjmOPQaxm7yRupB4i/jIJdsQRtnMyTt35TCvbgnoZ31CEKo?=
 =?us-ascii?Q?5JUPnNg1B1eW8FAiCFFmGNLlCyCkoS6WVNjGCcXmDuYN8dTx84Wp6X2VzpCi?=
 =?us-ascii?Q?ve4j25Fbb7UVkDgBiUeL94OhYNykx6gsWAy+mWa5Gs8cA0xXLFuG1KSy18yz?=
 =?us-ascii?Q?oWZxhtPBQFZVwPy29Sreo+L4nPJFuAdZeIUeCREv7DzZ++mP1xicOV7tFtRq?=
 =?us-ascii?Q?f/ZRYtIP7O6XhyEwCsSovZcBV5XHYOOhyrm7s2A/U+CvV21gGM+ugBlKqaw+?=
 =?us-ascii?Q?HyytmNV4IK1k5leHE1yZ21IgRhMnwhrU8u6VqG5lbUcGTxBagPCamTGCzloN?=
 =?us-ascii?Q?bDZ0s0HgM+NbD9ekqzZDCLDumW/a4XY7IWZ/QEKlSFGwRn/1QE8p8AgbWjMH?=
 =?us-ascii?Q?2N2ooBxBcrz/4/c/WdEW86F9d04xJPlr4taaB6WjdbP+kx402dFM7QNVa2/7?=
 =?us-ascii?Q?TzGIR4kYiRTOT87UlPReCvtDFGxlxh+aBzQFbw/cf5iAGGak14HmZgXZUQ6y?=
 =?us-ascii?Q?CXd9QGuKQ428b5oeEjzA+LXlhDoHmCukEVt7OrE8KjBZLzgx30SxaBS2iZ2C?=
 =?us-ascii?Q?6I/5bdLRXW9gghY8hzhOR5mbyKcGmsbu3mMJ9UMjbtfVfzB3BAyZJj87SEhF?=
 =?us-ascii?Q?xHq6nHMIpocNj0ZSLFJJYZrH1hNOjdHr9xwxElynFupBtQOcZjtnXVrOJr/M?=
 =?us-ascii?Q?xIIXzfCJHDAbX7mfZ3HR+0KZ8h1vkLIbVFuicoGqZI1nbMaGoekIqJ74sG9j?=
 =?us-ascii?Q?m30Bpnhyb4QYV2cKg7HGW0gUPUJD+PvEtFR4aj+grnoA2ot+J6bxOMp6hrdq?=
 =?us-ascii?Q?a70yyJYXTm+2S34j5ZTsL5kjN17/hzQ4Ldtt0fzHyyi1XeJObD8iQ/Eflw8h?=
 =?us-ascii?Q?Y01hudX9aq09NYZ0jjmTZYlSE9eJIVsYHLSIDkuQ759JECha2TcVp/ps4icM?=
 =?us-ascii?Q?v1iXwgFIZHvc/QaiyO7mZ8UpFLRtsHsKKY2F6J08S0UfrGatlFriuHSaE4aH?=
 =?us-ascii?Q?inKvTUGXrHwbpVkpzfpHENDebsolFEZJxeW2a5X2Q4bU3vr6RsFb7rC7lG87?=
 =?us-ascii?Q?aYsSRgeMlnwSrGkLPULsrcofAJO0CeETk/jHTz5CyLjvWGE6mB+4m9vkL4JV?=
 =?us-ascii?Q?5ISSHRPqjJeMfU+1QUyp4vYfmRobCtHlk73KrLxTSs6u4itlBaB37vUeLDkv?=
 =?us-ascii?Q?c49VffRhma3l4tTXBMBdGe7wDjSmnELjvm2G1ty1hlPB93+x+05w1XG1YL5y?=
 =?us-ascii?Q?7uC5TlJET/yo6ad5wtdQon9Cdrk9M4ik5FpCqj0OMZczbTYrMNUq15FY9VqC?=
 =?us-ascii?Q?NyuqmXPDhGypXOV7o1Vb75Z4+OTfKKimqZDkgtZ3QgatxafnfCTilGs0+w/w?=
 =?us-ascii?Q?dqK4JFH44uXmddvE7P9JNvH/4SsT+RhMf2skN9TVaxgeKh32dAoG?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 23adaf30-ca37-4f6c-6d4e-08de6d6ce969
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:06:07.3557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kbh4cNNvT1++I1eZvAuJ+6W9BvIOXg+fx9hDD4OYVByRFUcChB3EOLASp3zDnDbS+RUOb83V8xt/c8X6alLY+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1677

On Mon, Feb 16, 2026 at 03:12:53PM +0100, Niklas Cassel wrote:
> On Mon, Feb 16, 2026 at 01:38:43AM +0900, Koichiro Den wrote:
> > Implement the EPC aux-resource API for DesignWare endpoint controllers
> > with integrated eDMA.
> > 
> > Report:
> >   - DMA controller MMIO window (PCI_EPC_AUX_DMA_CTRL_MMIO)
> >   - interrupt-emulation doorbell register (PCI_EPC_AUX_DOORBELL_MMIO),
> >     including its Linux IRQ
> >   - per-channel LL descriptor regions (PCI_EPC_AUX_DMA_CHAN_DESC)
> > 
> > If the DMA controller MMIO window is already exposed via a
> > platform-owned fixed BAR subregion, also provide the BAR number and
> > offset so EPF drivers can reuse it without reprogramming the BAR.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 149 ++++++++++++++++++
> >  1 file changed, 149 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 7e7844ff0f7e..ffd2797b7b81 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -808,6 +808,154 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> >  	return ep->ops->get_features(ep);
> >  }
> >  
> > +static const struct pci_epc_bar_rsvd_region *
> > +dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
> > +				enum pci_epc_bar_rsvd_region_type type,
> > +				enum pci_barno *bar,
> > +				resource_size_t *bar_offset)
> > +{
> > +	const struct pci_epc_features *features;
> > +	const struct pci_epc_bar_desc *bar_desc;
> > +	const struct pci_epc_bar_rsvd_region *r;
> > +	int i, j;
> > +
> > +	if (!ep->ops->get_features)
> > +		return NULL;
> > +
> > +	features = ep->ops->get_features(ep);
> > +	if (!features)
> > +		return NULL;
> > +
> > +	for (i = BAR_0; i <= BAR_5; i++) {
> > +		bar_desc = &features->bar[i];
> > +
> > +		if (!bar_desc->nr_rsvd_regions || !bar_desc->rsvd_regions)
> > +			continue;
> > +
> > +		for (j = 0; j < bar_desc->nr_rsvd_regions; j++) {
> > +			r = &bar_desc->rsvd_regions[j];
> > +
> > +			if (r->type != type)
> > +				continue;
> > +
> > +			if (bar)
> > +				*bar = i;
> > +			if (bar_offset)
> > +				*bar_offset = r->offset;
> > +			return r;
> > +		}
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static int
> > +dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +			     struct pci_epc_aux_resource *resources,
> > +			     int num_resources)
> > +{
> > +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	const struct pci_epc_bar_rsvd_region *rsvd;
> > +	struct dw_edma_chip *edma = &pci->edma;
> > +	enum pci_barno dma_ctrl_bar = NO_BAR;
> > +	int ll_cnt = 0, needed, idx = 0;
> > +	resource_size_t db_offset = edma->db_offset;
> > +	resource_size_t dma_ctrl_bar_offset = 0;
> > +	resource_size_t dma_reg_size;
> > +	unsigned int i;
> > +
> > +	if (!pci->edma_reg_size)
> > +		return 0;
> > +
> > +	dma_reg_size = pci->edma_reg_size;
> > +
> > +	for (i = 0; i < edma->ll_wr_cnt; i++)
> > +		if (edma->ll_region_wr[i].sz)
> > +			ll_cnt++;
> > +
> > +	for (i = 0; i < edma->ll_rd_cnt; i++)
> > +		if (edma->ll_region_rd[i].sz)
> > +			ll_cnt++;
> > +
> > +	needed = 1 + ll_cnt + (db_offset != ~0 ? 1 : 0);
> > +
> > +	/* Count query mode */
> > +	if (!resources || !num_resources)
> > +		return needed;
> > +
> > +	if (num_resources < needed)
> > +		return -ENOSPC;
> > +
> > +	rsvd = dw_pcie_ep_find_bar_rsvd_region(ep,
> > +					       PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
> > +					       &dma_ctrl_bar,
> > +					       &dma_ctrl_bar_offset);
> > +	if (rsvd && rsvd->size < dma_reg_size)
> > +		dma_reg_size = rsvd->size;
> > +
> > +	/* DMA register block */
> > +	resources[idx++] = (struct pci_epc_aux_resource) {
> > +		.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
> > +		.phys_addr = pci->edma_reg_phys,
> > +		.size = dma_reg_size,
> > +		.bar = dma_ctrl_bar,
> > +		.bar_offset = dma_ctrl_bar_offset,
> > +	};
> > +
> > +	/*
> > +	 * For interrupt-emulation doorbells, report a standalone resource
> > +	 * instead of bundling it into the DMA controller MMIO resource.
> > +	 */
> > +	if (db_offset != ~0) {
> > +		if (dma_reg_size < sizeof(u32) ||
> > +		    db_offset > dma_reg_size - sizeof(u32))
> 
> In your other patch, you used:
> 
> 	if (size_add(offset, sizeof(u32)) > epf->bar[bar].size)
> 
> For consistency, do you perhaps want to use the same here?
> 
> size_add(db_offset, sizeof(u32)) > dma_reg_size ?

db_offset and dma_reg_size are resource_size_t, not size_t. resource_size_t can
be wider than size_t on some 32-bit builds with CONFIG_PHYS_ADDR_T_64BIT, so
using size_add() would potentially introduce a narrowing conversion. For that
reason, I avoided it.

If that would be preferable, I'm happy to switch this part to something like:

        if (db_offset != ~0) {
                if (range_end_overflows_t(resource_size_t, db_offset,
                                          sizeof(u32), dma_reg_size))
                        return -EINVAL;

or alternatively use check_add_overflow().

Best regards,
Koichiro

> 
> 
> 
> 
> Kind regards,
> Niklas
