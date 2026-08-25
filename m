Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3638B7B0;
	Tue, 25 Aug 2026 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668272; cv=fail; b=i6t5L+rQqTeK53kF68HufNDYCsPgS1BjAbDixc+g/ehpjx/Ox6dH2ZmshxFJOjgltXxIDKZvWCbz81AGxfWRPtwgjmTmDt0zq4enqM1q+hhUhtwGKEFf0bwWBM//QQwg8H5NeIVnnJHd7xilNJyg5tGlRWcDpxe4Xtzv2zjmuMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668272; c=relaxed/simple;
	bh=wAvvsitCGNaokcpQ+TIXGBWjhgAFKo/f5qIe+u84g0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vAhLU1dEfOFd/EfIXPu0K1T35MhkFv0TysB71H+hOfVHCc/Jv7onwFCJv0g+eDC0Gt4bMOlKc2NSCcqcFfvRnRlDyF/8Bla2cRELY/hWuGWSXooPUXwO3Zw/gxitd12n48kiibgZ6BWW3I3VGu1ABWLFtR8+EVJnP2ILcamzn2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=g8oHSd3S; arc=fail smtp.client-ip=40.107.159.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="g8oHSd3S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggMCHtpoY1ae63A/nuBFc8n+aTLdXMNPrTbGB+U65wrW5HzWA7NnQNlgBUJEbN/y8luXfSWMxDSvmBIdbYJZUkyopNyhIFobkHzj1hbkwIiTdrWS857bQmFszbr3AsaqB1qV9XiXrrcMH8OYWcBCU8p3ANTVSmXakOr4ZRwLRLigkKrxAS1kTq7gJ3VjtM/q7otVnTGfMVR3C7DmC39bpQi/AvMx4sfOCPoASPwcb8kNDyTC+agUkMCE3Nc+Q1RuZrxGtoWUCU7ednyEPvnvpKmMC4g9QABXl/ppuVMejgFp446Y+5WhzlycVVVLd++gpIlTaTp1HhNQiqdZZpZddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7LgnhK8BpaN3fEEgwu9woQXFC7835cC0WDAj4KiMhk=;
 b=fc4qi71wWG8XcZ3pnvFvsgmRsNujnw0DH8uQfkv2+ckgNC//hYjCE4cWpaRY1hnjaYnmfc/E4CJ+OpMNT7d/tSoKDbSVnZ7oD0Tu2X8YMKVi9VpEh1qoByOMu6DPYCEc+GONQDYBsI5a/0IVrSaTNGuuejZmPdcZpWjsIAP/wVnBHKRzHsg5BS8QZDfr7qFkioctveDyJdklUklpX2dZBnukoISSlTvzgaT/sMdHomQxW1ufUMhx/BcEJ3l8/rOjhM2yY70mtGQoG51l1HiINleD66nQxdqSOfP85+eIs07lrRYDe/0xBUdvPEsHx5aXNm6ILdzIgsS/NW5mSwXuIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7LgnhK8BpaN3fEEgwu9woQXFC7835cC0WDAj4KiMhk=;
 b=g8oHSd3S89Phmx2IqHPO7St0UeBKcnrPwh2yRK88yEU+4mbUs2ug2j50RpkSCa8AoGriVFRu4iN6nPqgGVebeAH2Dw2hZsE+ouEYS5FxUtx4mqbC6G5mPwjzmyRBdcoJl1hXu6F1SrLFJugm1P614SxlpIN080r9rueM+B14dpUluVu/cZs0w2zLNDJ2rqkSCg1nKgV9NXuOuYZaU4PL+gNPeYslwCgFcJiSUd9cyk07y35n4vMIbwksrHzR6d9ANrFr7LBGlH9zt2mPZOd6J29h9B6LkMgBkzwpS9q2TGLOhdQQDB7Fp+aVF3OQislcD2PUGDYzmGARU0fFkmdJvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9740.eurprd04.prod.outlook.com (2603:10a6:800:1d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 14:31:06 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 14:31:06 +0000
Date: Tue, 25 Aug 2026 09:30:54 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 06/10] PCI: dwc: Implement endpoint DMA channel
 delegation
Message-ID: <ao2nHoCwfTEEiFSr@SMW015318>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-7-den@valinux.co.jp>
 <an4WZkoIxCZ456Pb@SMW015318>
 <oiozls3u4bubqzfk4hqjgauzmuka2ixs4b44rvmrmosdqyxa2v@crlid6rfy6v6>
 <w223tumnzi3zircm4tnv4b7cug2g23z52xris7fcrhxyr6knvr@cw6meanwd5e3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w223tumnzi3zircm4tnv4b7cug2g23z52xris7fcrhxyr6knvr@cw6meanwd5e3>
X-ClientProxiedBy: PH7PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:510:33d::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9740:EE_
X-MS-Office365-Filtering-Correlation-Id: f011dec3-5798-44e0-0ff9-08df02b57f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|19092799006|376014|366016|1800799024|10067099003|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	a/I21o5n1/mSy/NIkfWQFXCFJSCKXIQQIgIRfIvlUUxY7RxwmtsBwIFmwrfkc0leFY1OHQbDioTo1Y8mOlrMyXHpkiCCYiSOotf3zBf7zkkeFEPeNc/pnjxfuAxUiSgRPYvzYw9CAuJS1fs4wudKaFYZ1dXCjruy8jph+/WP4vzoR4YB3ebR2RMjFys2qHSXvAm74dgdtGwUFcsfrIEf1+99t8m/tpehccXSA7cHA5JenzWwmVw9Mvc6dIEKI11wLP1UexmviTZFtonTxMPy2gx2hwS9wrp9PhC4RWHzByW00WQIfecER5NN7NoPf6+cbvP6MZOmfTFvow0xFIy8sdyJ7qHk8/cChk0tGyrxy9t5YyxEiCQjs3/Wm8esAqjbY1NlmwzntJGAEnyJ8PInpNb5ypD2Ay/zrsL5n6HfB8zEpw1ln6HEwuZyI9feWiOH79Bv2CgYrsTeDMv2qT9yMrNMwiToCX3kEKlwTB4uCX0AfIC9eTE0VXH+OMJq2ciyxIjJSZOWWe0sZegJW6cIsstK9aKdtPOLDebpl/0chqfBYvoiP888R5Us560t2xiDwfrhouFTth7nAiapegkFyRArEnilXy2JvH6K7QgBkfj2mAXu+8PKrci1iXedVJCjXZfJgxjCkyHU00fqcP0fI+htjHhzgDCmWprS3Nfj+wo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(19092799006)(376014)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/vO5J1FOsY7ftCV9Hif8eexiBPczHgLgumHJ/sVOR7tvtJgpV5fvgnnhk5+6?=
 =?us-ascii?Q?CQ2ovveHQVKKOJw/BhN3OWLs3SgKyI0HmdVMBnGcZ/7ZK31zn1VVfOd+jNvP?=
 =?us-ascii?Q?oF+i2imhh0ek5BG1RRVAqufquGplYt6OT2DqoR2EsO9cuw6sTTehjA8u5vHr?=
 =?us-ascii?Q?4iWbymgDoQQDnNIbw2frXskqO3RZoS4kpiqjgYi7IA3fIKoyEDUecOP1Vu2U?=
 =?us-ascii?Q?wPrtPQIbKXEFX+x5kzFiJHl/0s5MqOWNX9C9NNdpK4EiI5IKRD7Hf0sjpbzQ?=
 =?us-ascii?Q?WU/BiI9b0UYmElyH/OZWkzjyB7kNT+eJkdkKAAsDk1mJ2IrFnLVkBBzZOL1H?=
 =?us-ascii?Q?mG3GenjvNr+A4MH+4wj41mcI6wmetFxACaCa7cv43+5l1Lf/S889s9DjzCjE?=
 =?us-ascii?Q?iQfCz/NGN7j0fSP7BzH/Pr9M+P7Z0Rg5Sffz6EiYYV2vN4xEueEwzbun+a7P?=
 =?us-ascii?Q?TYLh76MK1QvvvGN/GxrXVzVrmvbmil+/INyMvYf1SBQdGxdikjRjyobrG/Lu?=
 =?us-ascii?Q?K1+4Z/VG59MRl63CgAeg5bIJSFm79sPgdLwvwsebFospuu2Vu835G/Jvgglr?=
 =?us-ascii?Q?uAcg6Q8KEgHQdNOwcOPb/rybYJFZ9xjydQDTR/cs9KWXK2JXOxzaVsnM9AIB?=
 =?us-ascii?Q?FU6CpUD5rvYev7E/GwQtr3F1G9DbApTpiXzUYWQHZmBVIIWLiwCy8wdslCVl?=
 =?us-ascii?Q?QRyBoygXeQb8bxY7C3uKTxG1R0KFqVGYOrcd5C5AccN3DvEstG5/JaVnvtAH?=
 =?us-ascii?Q?oMXI3dSB4az8eo74/cNTZ+7DRqshFS4Ou0ZyERFcPlw52sDqQ8S0p0Gnz68e?=
 =?us-ascii?Q?nxQ5mh4m3muwuemoxgLez52E/xeGVu0DJyDsijw4phfws+5HZU9n3eMXVHED?=
 =?us-ascii?Q?RtI6N4HQGO2smeIfC6qeOE/NWOcmXpxPihydKibtZyneoVL5QFkVf8RDwe4O?=
 =?us-ascii?Q?0sqZpy6QX7+2NGO4+TtFjh5aTFtu/2b3G14OKGwxQ2sbt1oa4i01k0JXNMwi?=
 =?us-ascii?Q?eUn1JxYUvY5Eg9Iheyq3OJDf7Qz7v5O/XfKfY0PqKC+xOZ2uv/T7JDnRNz4p?=
 =?us-ascii?Q?pGo84Auh9+AmodyBtOjKgiP9o9cDanAqr/mRGKy57GkqbSiu1ITwnR++PyTm?=
 =?us-ascii?Q?PxlSyPp0DMDzBMEYMeDvHEdg6aR3isAw6LIoVmF8HGrKKpSq0Iomx82AuezI?=
 =?us-ascii?Q?OtpBHZKi45cLeXDz26tYR3in3f8ndUl7IjFcgS8tgW9dPCrw2WDXdWbhe/4q?=
 =?us-ascii?Q?yYqBtvIgoNUDpDm5TGmrPut+WApa31bMqGNXv/dhzqk5mQg2DeOeA3kce4mQ?=
 =?us-ascii?Q?SlDtjnw5lacfDU7wlMXCy8/wtCZn2GNLQU+A9W4I5gNjNci0CjDfE3DOH1Gx?=
 =?us-ascii?Q?dlFUk1hjT4DJDAr/1guQjg526nbdkriszaZiwv1u/VDTJcp03y+BACTnS/fL?=
 =?us-ascii?Q?/NjTC9k+q4E7IqUC5J5uophCpUgu/hzdJ4ZIR05zfBbZqItCQyFWnHukqrWX?=
 =?us-ascii?Q?o18js1euCHuU4783qYeDgb+WfNejlQwVV5EfCdo14zJ8Mg1+0EEuedW/QvX9?=
 =?us-ascii?Q?lX7XH//nCKmHpjLoaS0EDxUyGIw9cIWVMAKEjJb6KjoknTEGG6p0FjKt9FbO?=
 =?us-ascii?Q?5W9lSfRwiSthT0hDlOE1SKHcMCbXitOAneOqEI6ldf0YwQFxfy40Lal7UIm8?=
 =?us-ascii?Q?HlmRtbrvORm6QEDFnXTtbwEAJM2xx4yb3wH3F0uo4F8o+p1mrIAN6lk52RxR?=
 =?us-ascii?Q?SUN6xKObU8VqZp7FtiqMs6C/4S/W8he2M72G3TvLo8CjjlU+UdDA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f011dec3-5798-44e0-0ff9-08df02b57f44
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:31:06.0728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnOoELTDrllr74JW3nWZAWp1Z1ym4GBRs6YiYB/7pSod0cGeCFjLeWRjoYcJfO8KXhFkmyUWoH9s/Z4vAEKVRROYfDgohGZFdEVHNvchETSmckYmwRzpZxvtj6ZMFFBx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9740

On Tue, Aug 25, 2026 at 05:16:50PM +0900, Koichiro Den wrote:
> On Tue, Aug 25, 2026 at 11:36:54AM +0900, Koichiro Den wrote:
> > On Thu, Aug 13, 2026 at 02:09:26PM -0500, Frank Li wrote:
> > > On Thu, Aug 13, 2026 at 03:37:53PM +0900, Koichiro Den wrote:
> > > > Implement the EPC DMA channel delegation operations for DesignWare
> > > > endpoint controllers. Verify that the DMA engine channel reserved by the
> > > > endpoint function belongs to the integrated DesignWare eDMA instance,
> > > > then hand its interrupt routing to the host.
> > > >
> > > > The DWC eDMA/HDMA engine generates DMA requests with a programmable
> > > > requester function number. For delegated channels, the host-side
> > > > dw-edma-pcie instance bound to the exposed DMA function programs its own
> > > > PCI_FUNC() into the per-channel requester field; the endpoint-side chip
> > > > func_no does
> > > > not participate in that handoff.
> > > >
> > > > Reject VF requests because the RC-programmable DWC eDMA/HDMA register
> > > > window is assigned to a PF BAR only.
> > > >
> > > > Reclaim returns interrupt routing to endpoint ownership. Propagate the
> > > > EPC quiesce request so bind failure paths can reclaim unexposed channels
> > > > without quiescing the DMA engine.
> > > >
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > > Changes in v7:
> > > >   - Delegate the DMA engine channel already reserved by the endpoint
> > > >     function, matching the API and helper changes in patches 4 and 5.
> > > >
> > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 42 +++++++++++++++++++
> > > >  1 file changed, 42 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > index 0b915824963a..a74d3896e436 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -858,6 +858,18 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
> > > >  	return NULL;
> > > >  }
> > > >
> > > > +static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
> > > > +{
> > > > +	/*
> > > > +	 * The DWC endpoint databook says it is not possible to assign the
> > > > +	 * DMA/HDMA registers to any Virtual Function.
> > > > +	 */
> > > > +	if (vfunc_no)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static int
> > > >  dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
> > > >  				   u8 vfunc_no)
> > > > @@ -933,6 +945,34 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > >  	return 0;
> > > >  }
> > > >
> > > > +static int dw_pcie_ep_delegate_dma_chan(struct pci_epc *epc, u8 func_no,
> > > > +					u8 vfunc_no, struct dma_chan *chan)
> > > > +{
> > > > +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > +	struct dw_edma_chip *edma = &pci->edma;
> > > > +	int ret;
> > > > +
> > > > +	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	if (!edma->dw)
> > > > +		return -ENODEV;
> > > > +
> > > > +	if (!chan || chan->device->dev != edma->dev)
> > > > +		return -EINVAL;
> > > > +
> > > > +	return dw_edma_delegate_chan(chan);
> > > > +}
> > > > +
> > > > +static void dw_pcie_ep_reclaim_dma_chan(struct pci_epc *epc, u8 func_no,
> > > > +					u8 vfunc_no, struct dma_chan *chan,
> > > > +					bool quiesce)
> > > > +{
> > > > +	dw_edma_reclaim_chan(chan, quiesce);
> > > > +}
> > > > +
> > >
> > > After use fixed chan_ids, needn't these functins. EPF driver already
> > > find expected dma channel and config it remote only by standard API.
> >
> > (I've been somewhat holding this thread, sorry. I'm still unsure whether the
> > separate PCI DMA EPF idea will survive, or whether making it much smaller and
> > initially limiting it to a test endpoint for dw-edma-pcie would make it
> > acceptable. AFAICT, Mani has not answered that point yet. Still, I think I
> > should reply here in case the idea survives in some form and v8 becomes much
> > simpler.)
> >
> > I agree fixed chan_id removes the private channel lookup. In v7, the EPF already
> > reserves the channels to delegate through dma_request_channel(), so Patch 4 may
> > look like a leftover. Its remaining benefit is to hide dw-edma-specific
> > interrupt-routing semantics from the generic EPF.
>
> Let me correct myself.
>
> On second thought, that "benefit" is really superficial. If we ever want a
> generic abstraction for that purpose, it should belong in dmaengine, not PCI
> EPC.
>
> Now that the EPF reserves channels through standard dma_request_channel(), it
> owns them until dma_release_channel(). Going thought PCI EPC just to change
> their interrupt routing (in the dw-edma case) is odd.

Change irq routing should be dma_slave_config(), not go though EPC, which
is DMA behavior.  Or add some argument when looking channel, like DT's
xlate.

Frank

>
> >
> > The EPF could instead do something like this in pci_epf_dma_claim_channel()
> > after extending dw-edma to accept the setting:
> >
> >   config.peripheral_config = ... DW_EDMA_CH_IRQ_REMOTE ...;
> >   dmaengine_slave_config(chan, &config);
> >
> > That would make the EPF depend on dw-edma-specific interrupt routing. However,
> > if the goal is to make the PCI DMA EPF as small as possible and accept that it
> > initially only serves the dw-edma-pcie path, I think that is fine. I think
> > that's your point, but if not, please correct me.
>
> So even in the vNTB-embedded design, your suggestion to use prepheral_config
> fits well. I've now implemented and tested it there, and it works. I'm preparing
> v2 on that basis and hope to send it soon.
>
> Best regards,
> Koichiro
>
> >
> > Thanks for reviewing.
> > Koichiro
> >
> > >
> > > Frank
> > >
> > > >  static const struct pci_epc_ops epc_ops = {
> > > >  	.write_header		= dw_pcie_ep_write_header,
> > > >  	.set_bar		= dw_pcie_ep_set_bar,
> > > > @@ -950,6 +990,8 @@ static const struct pci_epc_ops epc_ops = {
> > > >  	.get_features		= dw_pcie_ep_get_features,
> > > >  	.get_aux_resources_count	= dw_pcie_ep_get_aux_resources_count,
> > > >  	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
> > > > +	.delegate_dma_chan	= dw_pcie_ep_delegate_dma_chan,
> > > > +	.reclaim_dma_chan	= dw_pcie_ep_reclaim_dma_chan,
> > > >  };
> > > >
> > > >  /**
> > > > --
> > > > 2.51.0
> > > >
> >
