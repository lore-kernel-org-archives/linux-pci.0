Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021098.outbound.protection.outlook.com [52.101.125.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F4638C421;
	Tue, 24 Mar 2026 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341933; cv=fail; b=nDd7ftIQTnWzU0UBtTpluZJBSKFtdSQ8YBWP4SlHDJUyu3QJLn/nM7Rk6AFc97wvjzKn+xuUvHOnCJZAUugJk5+4azp+0hiGMBZUFosCkp0PdezFzMur221+EDCpbyoa4BPJmH1kzLWSaPmG94mRiZWQODQ/MxIjeI1/s/xRWZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341933; c=relaxed/simple;
	bh=1lEozsdcXvJichglQkcpMgMXgFmqzhXpx3RQEeCyDLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tJBDac7zXFiuk2COz/QCo5S/+krLwQVG3Q6w3AeQTDLmMh0Nl+QXKd+Atwt4jeYp28Gk5Gx3rDPN2JeZd27DXWK9rF9h8/LN7r1rfXnpHpDzBBzMi4wX25+NzBjyTM3v5CQF/tE1ajYbHAr7PloVhIuqTYDtpJBiHOowfPiwU5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=J2zi5RzJ; arc=fail smtp.client-ip=52.101.125.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="J2zi5RzJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5TsH0bfhGKo93EHJ7f4NmFbGcT8KduHD6s4HDUAoKLDHGo/jrc+NkffrbOJ/ymbn2gZCXB7iD8XZp9CLwY9wFvbZSivF2jBJubEPFptLZx9Rnfe9v9lIR/5k+VCs0eGFdVCQWBNRwxLxZFb+t+t9YAcZGk4YBtHX8pdtZkbNUcUUibxgrgZDUvLwyhzRsjsYxyx052EuCbHG9hdofk40rJXUMwNSLTIIm8ToASojGSCYO62xJ5PSALuLqA+zSFFyEJi1/nu74Bz+7YKqi7nCMPsThP1fNK/Dba0lrvV4/xBWG4MnVC+Ve+c8CfoWUR31Vp0JVwSWBu7iRsqCAkpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJStz/t/8lND7trVGR5wn8bf3cO2Q8gx0ptQS1Oun3o=;
 b=FLAT6p9+530VkGNjKDayTNoiHVhOyFNNbLUqtqiv0+xCyFy/FDqAfNQbXlk0hllayJPhIzyo5FoC/rSB9nyEtLYCTatyzVeEdw4V9CuZRQU9dkCkmypFYuI+pWUSkDK9XD4dJk/hgd3Czb6kgecN3kf1BlZ+bXypS7lSg7C3A9ZGqA6QAijuNYQp2S6e32kCSjSk1r8zs80ifeAaBbVo1k0k3MDu2+XQGqotZMw7PzwGoO0+0AaCtuytZcire+NW5qoHgqJl9fiRIaZ+sLuSzBIXp/TTllKVlr+/rTwZBnH7co3rvTtCjXLB+6Fms/uc5Xg3i8WdjvcBhLtMvegl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJStz/t/8lND7trVGR5wn8bf3cO2Q8gx0ptQS1Oun3o=;
 b=J2zi5RzJJVKsNksc2s/NCP0LaNmmPT0H+isBFa0DBgA8Zt+epkbJV8ZznEJ21ngeKpPc19I+cZ3s3z+FDHelKBUKmG9KPa2YbjT2JJ+z+r5Rw1kNzV3S/frGrS5BeZh0HFfhvB8cAZqUC5r4tsJrpi58CDmzAAd/9Vj/HDHoQSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5244.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:167::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 08:45:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 08:45:26 +0000
Date: Tue, 24 Mar 2026 17:45:25 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v10 3/7] PCI: dwc: ep: Expose integrated eDMA resources
 via EPC aux-resource API
Message-ID: <fudugm4bf6yygjl7nr63pljd54hcb23gohwi7lngtcad4dimwa@xxarhnvq42pe>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-4-den@valinux.co.jp>
 <acGIG70bIHTD2bCu@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acGIG70bIHTD2bCu@lizhi-Precision-Tower-5810>
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
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff5d871-b4c0-46d1-51fe-08de8981b211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ba8gLIckCyIvgYPgfWWP+HiYfZPO9gzcpLcWnZvV0NN0OyZldKF49otENGnjmY/SiIhTZKS751HuKmLNOwojgu6QNNUgS/O6L4gcbvoFzFi2DGYRigrOi/VtxmQZtGDT9QgRBOZDNm/y1NNpfALLzpzPnAnRBcM6c7mJZzP2vnc1H5m1+79OnMfujUGl2fDXGaziwZlQNdAvOiq/FuCZu+u0FRLVNBpyenIc3Comq8vGC7KK8go3o8ZFN+BVJhUKwBGWM6YJbE2Cr59slfTt274OsRg/Pmh2B3Lu/oGco7sBFvHyQ8dwRaI83fJ4doO+d2b6IwrwjhpD1Jww5I01GS2rvfzVXoz0k7f9eDRkTzca4Gb8qPxdQKULJKANFW2FZ8UC9rORu0UG3gvXj3Uz/Jiknt2vYX+bCdGHP+oFHxiLa/h0wqwa1c+182GPmaB0Twv8IUxE6fL8mr5fGpDLVRvRmg19qFtMeoeYv1eifbfBOEp7Yb5Nj46vlap5AXNnU6IGun/6KUgJm/yP+E/tpl98O1sGpLHX/Qcc1xddF8sGO/d8vtAiuS8Sge5CI+J9KjBaKbZ0vrMVZEFGi+COkYMrXa0AUmjEwPIcWqeJ6bnSFrRFarWuz8wW/1ztNAg6Yo//eSqlF0CZOdaU6xNnOYdvOjFUEvg2weny0Q720q9809lyNeH0uqNjj6M+2jMRC4iI/VPOsE/TZHqqvroFuasmwm4gQa14A9FUm+h7bew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nT2Al2Qk6GPO4nIu60XbIA2e8WpmP3nBx9bNbHc9voqmlDseQSqI5W81+NIK?=
 =?us-ascii?Q?iNuuwuvgafIaSwg/B9wWK0PPTIenCAN86HnOWyGZFVSQMx531Uk23ZclVGuQ?=
 =?us-ascii?Q?VpnWCZW6D0blAaA8LjGNpwqugZBuUl4rAdJXcx9caezakMR3DULj//YPcrMf?=
 =?us-ascii?Q?OuCR5f7kAmqYAnFCzFwZnK48EHmN/eZF+h6GSbcLj3MgUB98PZ54c0hI/Tad?=
 =?us-ascii?Q?oPtiKcu9ySJI75zsLkufU8Z0/HlSxPG6pjmydZZKu8Y1O/DysRRNvrVnnVW4?=
 =?us-ascii?Q?gxgh5LEsoEKqMTfzErB3sFwzZmo28DXIgIk3jUc7DvcU8iJQ92X4EjrJGUJ9?=
 =?us-ascii?Q?EPhaHiZ4MuVyh0YXmbW+XLbXjBUMngUnSEWgzi79H6aS6j5ZGljv1DI9yWB3?=
 =?us-ascii?Q?zZ/Ct3C8cxfdcDBbb62INrQrsBuCTlcIkAcFW+qUNiDU/TW4s5ynD4enGHKK?=
 =?us-ascii?Q?tEEVOkQahUL8r1xvzqaKI+68QMAU3jZPEFGWg9uHNwCZyerUMBUC5ilYwNc1?=
 =?us-ascii?Q?0ByqbwSvGoTai18pJBLstMs1spSNN/kj1YVVJFD8iwGvYgWABqi9hcBy8ADR?=
 =?us-ascii?Q?8Oc2/ZKCy0zHAkguUo9cMuTMLYLkqPEpHQJNL520kM0mu9YFDw6XFThqlRF0?=
 =?us-ascii?Q?ngiQVamCsEVWQdVCoP1BRnjhWNRXRlkopoRnNa9aIXY96ITDUm9UYQzAR5PI?=
 =?us-ascii?Q?SIgRWAsSB0jC5e81C/0rkagZXU1Y0T5ztyVA5H6g+cj66pmujSEWiN9ReD7m?=
 =?us-ascii?Q?1sh01zSBUv8sqMevL9Cpd48QJ+JnAxyRRFwZm5jOjraAc1gFEwfqN7VnxkjR?=
 =?us-ascii?Q?XxC7/lO0Q/5UiiEpuL8YpYqra2GKUlFnpCI1pxcfoej9khMQkMrz0MNgLn14?=
 =?us-ascii?Q?kfh+7vLvC8/jV+Wg0o144iL0lJwX8kDLew8Ra9O3dCNsLcJA4QAouXxRsveq?=
 =?us-ascii?Q?zG68Ol3sBxdi95uaU5xIWnHkQh85mrfN7yrKY1o2RNQBtcV+2iVa9jgOWqQE?=
 =?us-ascii?Q?VQhdFUeQjuCLfYuouHKJjtcnPXXVFuebdDHkiNZj2yufSNePiKXtsBSRPLbv?=
 =?us-ascii?Q?WrnSUs0EK7CufDwxCLFuw26YCAO373gYOBgB5OKtgwpQ48+nqZrglvolMYQJ?=
 =?us-ascii?Q?VZ3BgxKmWOIM4T6SHxtGPH777XVFdN+rp7/FNwB9Cw1PBfiS6iFAKno4E8Fp?=
 =?us-ascii?Q?jCLChva0uaYeKv3dEeBHWqAhsWGAtDxUbIhDL9VUQjLep3VmmLk/UUnZ/4S0?=
 =?us-ascii?Q?wmBNuKGWfzJjcb2Q7T2K2ogYiTj1L142cAtvVaauvi2LFzLE5nUDF9RE+Wmh?=
 =?us-ascii?Q?BlYpA7TE6hqC/R0Cudkf27hWj10Vzyi2h2WlxD5Fs2rOUpcpOZsmh9g/KKSd?=
 =?us-ascii?Q?tyfR212EH8uxWFJ01jgas6j/hht3dg+/4GiYeVyNhYTde7Way2q2n5IIPH1c?=
 =?us-ascii?Q?3VqId115XinCFwPLWuOtlD05ZTB2IVFCXgi8cgPR2ACVWo4J465ZQ6z106S5?=
 =?us-ascii?Q?HEXL4teLIkf7h7c3JcyObp2dv0cuyIRgFSLFr8nJUpugG4TQ/mSL/rbo+DM9?=
 =?us-ascii?Q?8CtmLdSjThsCwefku1GtHruedciPPAIdyUlpNfLfg1tJoZML30FP7LBMuvjp?=
 =?us-ascii?Q?qE9q45K9LkzOXlrYiqWWmfNscCrb53cntE8pvQBQ8iifnA1vpaLRalCQubUi?=
 =?us-ascii?Q?fYgEjo6Pg/O1Ktu4nuLM3xPJL/apME6fjRn/RjYcYV3HrXaqTJC+hmhsIbQW?=
 =?us-ascii?Q?KzSeMZCtMjW2G0MsQDvBnNUSozAjjXHJmi/OrnBHJRgT6ppJR/30?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff5d871-b4c0-46d1-51fe-08de8981b211
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:45:26.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmVAsH7JoEegVT2VzACZNXhMIFgRwAkm5oZ0gvBI1iy0IGP9F0e65EYlfMtvPsIExdhH8WlFogu4hpBHQwy6Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5244

On Mon, Mar 23, 2026 at 02:36:11PM -0400, Frank Li wrote:
> On Mon, Mar 02, 2026 at 04:14:23PM +0900, Koichiro Den wrote:
> > Implement the EPC aux-resource API for DesignWare endpoint controllers
> > with integrated eDMA.
> >
> > Report:
> >   - DMA controller MMIO window (PCI_EPC_AUX_DMA_CTRL_MMIO)
> >   - interrupt-emulation doorbell register (PCI_EPC_AUX_DOORBELL_MMIO),
> >     including its Linux IRQ and the data value to write to trigger the
> >     interrupt
> >   - per-channel LL descriptor regions (PCI_EPC_AUX_DMA_CHAN_DESC)
> >
> > If the DMA controller MMIO window is already exposed via a
> > platform-owned fixed BAR subregion, also provide the BAR number and
> > offset so EPF drivers can reuse it without reprogramming the BAR.
> >
> > Tested-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Thank you for reviewing, Frank.

After Mani's feedback at:
https://lore.kernel.org/linux-pci/45yj3oztsa4dpy2nyc32td76umhd6dxxkmr5tsqtqvlgy6v4ju@6o4ov7nck7ca/
the code in patch 1 and 3 has changed in v11, so I did not carry over your tag.

When you have a chance, I'd appreciate it if you could take another look at
patches 1 and 3:
https://lore.kernel.org/linux-pci/20260324083728.3744734-2-den@valinux.co.jp/
https://lore.kernel.org/linux-pci/20260324083728.3744734-4-den@valinux.co.jp/

Best regards,
Koichiro

> 
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 151 ++++++++++++++++++
> >  1 file changed, 151 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 386bfb7b2bf6..eec20800a745 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/align.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/of.h>
> > +#include <linux/overflow.h>
> >  #include <linux/platform_device.h>
> >
> >  #include "pcie-designware.h"
> > @@ -817,6 +818,155 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
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
> > +		if (range_end_overflows_t(resource_size_t, db_offset,
> > +					  sizeof(u32), dma_reg_size))
> > +			return -EINVAL;
> > +
> > +		resources[idx++] = (struct pci_epc_aux_resource) {
> > +			.type = PCI_EPC_AUX_DOORBELL_MMIO,
> > +			.phys_addr = pci->edma_reg_phys + db_offset,
> > +			.size = sizeof(u32),
> > +			.bar = dma_ctrl_bar,
> > +			.bar_offset = dma_ctrl_bar != NO_BAR ?
> > +					dma_ctrl_bar_offset + db_offset : 0,
> > +			.u.db_mmio = {
> > +				.irq = edma->db_irq,
> > +				.data = 0, /* write 0 to assert */
> > +			},
> > +		};
> > +	}
> > +
> > +	/* One LL region per write channel */
> > +	for (i = 0; i < edma->ll_wr_cnt; i++) {
> > +		if (!edma->ll_region_wr[i].sz)
> > +			continue;
> > +
> > +		resources[idx++] = (struct pci_epc_aux_resource) {
> > +			.type = PCI_EPC_AUX_DMA_CHAN_DESC,
> > +			.phys_addr = edma->ll_region_wr[i].paddr,
> > +			.size = edma->ll_region_wr[i].sz,
> > +			.bar = NO_BAR,
> > +			.bar_offset = 0,
> > +		};
> > +	}
> > +
> > +	/* One LL region per read channel */
> > +	for (i = 0; i < edma->ll_rd_cnt; i++) {
> > +		if (!edma->ll_region_rd[i].sz)
> > +			continue;
> > +
> > +		resources[idx++] = (struct pci_epc_aux_resource) {
> > +			.type = PCI_EPC_AUX_DMA_CHAN_DESC,
> > +			.phys_addr = edma->ll_region_rd[i].paddr,
> > +			.size = edma->ll_region_rd[i].sz,
> > +			.bar = NO_BAR,
> > +			.bar_offset = 0,
> > +		};
> > +	}
> > +
> > +	return idx;
> > +}
> > +
> >  static const struct pci_epc_ops epc_ops = {
> >  	.write_header		= dw_pcie_ep_write_header,
> >  	.set_bar		= dw_pcie_ep_set_bar,
> > @@ -832,6 +982,7 @@ static const struct pci_epc_ops epc_ops = {
> >  	.start			= dw_pcie_ep_start,
> >  	.stop			= dw_pcie_ep_stop,
> >  	.get_features		= dw_pcie_ep_get_features,
> > +	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
> >  };
> >
> >  /**
> > --
> > 2.51.0
> >
