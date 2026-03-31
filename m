Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021141.outbound.protection.outlook.com [52.101.125.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739F3F786C;
	Tue, 31 Mar 2026 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965407; cv=fail; b=I0CFg5zH9g+rwau6sNQzlVYTpnSACiDDvdognT8gYSyRoT7Zels9CjKZStqKH02QyoulkQfxgOMlDZTfp4JKBHx8zuJpbHPWtGsE9YoBwpFGHV2d1W4Mdhlulh+Kh4ZB6EduhwQh8UILSUyaPqV9hyEOdcHIQhQiq9fIJtmd+bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965407; c=relaxed/simple;
	bh=OdxyxXQHccgQABr+xFpYtLMvzdLbszh8f1Y6m4fQk70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ASIEqJ5uU8DUK0nNt3m+kdjG7SOesUQKhuYAeUM0NVitDaJ6PCqSUUqHLUY6XP/KKqzfr55ItySZoy9z/rAjixykCyR0mI3zhkD3hrXPH2W2ULN5P3V9U5Txo3+ZWZM0WFvF4YcrRSaaFY/RRT0mkY0+bj2Ktv3UfKJ3eQ6geNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MVxLZffd; arc=fail smtp.client-ip=52.101.125.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MVxLZffd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Upuhaz68+OLglyTZHgIF70AsDhyI0HX/IdNB3XThfk3+d+5VmxeOMrTVytXZXOLeC/5/soRkmZXh3krTbUloiGoh/ZHrmS3JqPSZBlVU/2ErU6zx0VhHAWtHLmm+Z53ykvPMtRMAMQaH+mTJnuAQ2VIdo1SUlEuDnIFwUyT9VZnGZV9tAtbqYxtYja/sp1IY3qrSy8rwdy4rEtydWb8fbt8o5qdrKpXSJ+q0acFVTA+wLoecZY00dvWsY+7UrjbqVxX1ARtxmwQrSY002AL5+I3iqCAK0gWhPcnhvgd7I8G9BU1YO6QH3ziIE4te7oS+XwIVsWrJDIYGfmx/Nt70Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jghaHC2tJF+Zk0Q3Ao2Rp2qycfDhfREuy7KAIdHL6gw=;
 b=j/dTviOKFjtx6P/OYMQe+EQ2xd3UkdbpnPXp15tam0NrZDxjPatyE3xxqYyR4QV6+wTJLbfhKEPzvXBwBiaaQ15rsx0ywb8DLSa3xVug9OEmlTRAgZih1U++ajXYj0UypRHeVuLUFnMEbsjutj3x++ZS6xjVnu1lO7QIWyjtrdz9fJagJUFwR3j594qqMEGIaKDR3eQlY1XesBx1+IPB/N9jfCJsxSWjGnB9Bjk67fD/IiN2p/dPawX8Gq5FXlKBK1G/64Wcdu/J+U8TC2jQnNVr05vqFxaR/kGSuTq3ne12WGaNsqsNaOX+0Nw+h6BKPHklS1Nop361PBuE0+RGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jghaHC2tJF+Zk0Q3Ao2Rp2qycfDhfREuy7KAIdHL6gw=;
 b=MVxLZffds88kG05mGKYhx03jk/FfSK1oC9BOCFmt2SDtdzqCc8Ta5cmMXr1E9QTPWpyH2gLt/TRZSkQw8Ill/uDcwWC3wJ6Djb0X0wbBUZUMAXGLUflhBVy9bPYpB90eXIGcgtgBCoS6ZON+8yNT3s0El1WByiOd8DzFDoGL6vU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2310.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 13:56:36 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 13:56:36 +0000
Date: Tue, 31 Mar 2026 22:56:34 +0900
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
Subject: Re: [PATCH v12 1/7] PCI: endpoint: Add auxiliary resource query API
Message-ID: <zzatuxxzrg6yuqprvhgntwspsrg3igk2wqqqamx7xh733ksgef@mvwzcseqvjrb>
References: <20260327035422.4020455-1-den@valinux.co.jp>
 <20260327035422.4020455-2-den@valinux.co.jp>
 <acawzbj2s8P95YKi@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acawzbj2s8P95YKi@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0074.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2310:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b0c702-216e-4164-3386-08de8f2d52d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|18002099003|56012099003|22082099003|27256017;
X-Microsoft-Antispam-Message-Info:
	93raoNxWew4lH2mQbFzLLUhlwYqhdqSdG8Ln07QPvbkkD0IkO8cj+6hK5XnkUsGY6UHEkG/mDyMBbNobTddcbnwSnCkB+E6NWT6EPSdAtF8FAef7xLGArOyNiWo0T6UUqxmkNqWA4uqXItJ1GLFOT302ulGzfBbUYUDCMg6c3uCFc3hRJH5wDaPh6QZKsL/uRq1z4BVAg5LpZG9/GhsotHhiRymR1uLPdDsJtZrgRUBFfidIVRuI68v18O2mtUQQIsFbmgdQC4Yh7WUA3if4rr0KeM4tnDmu4V3wZnkrYz9vXpqMNxywjlY2QfMiPDAxmowmM0zkGPZygePYvg0wfEABFcj0yWUkOAiJSEsNP/m0vT51iIhjskb4FeYSKfYYVKD5mhQicQFDZYBLdKX90w7ZA0cSlaV5eUIpsdePT49N+pxo/HypRjAjiis3Hgljr/f8WOii8UVl6FJjJP7bL2l7m+ZzJkVLbnfxI83QDOiE6bWwm2j91L5kregfTOZ0vpJ41ppIEGpWVPg0I+TvEJGJtg+8obep5Rybn55idKFFVdpP2gUVsE1aiZySnq1SUiubWzl3hV7HDXeL62TKGGJw3DbmZ8Vhuc2jaInKQtEr8Q2JK/UW0D+E/bz5YlYteS5HuMUdyPxldj+6vwluGMFonyOZDvEyYY30g97DsiWrkA1rlKaUnXcx5ZU1VTMeCpfbZF6BtZI7r3WSh2h0GSgtXUnmoslBZgdrUceQxHoX5J936FHmOPAzOkGJXNJ45w7tuQcQeJSvxYlLJYH/U3sIuSkMWJ9LLkL3Rqi4fr4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O26mz2G4V+IgtbVJ7MI8Y9PSVuRLUGl4ntUSkn6eroHB0sq61WV7UW47dLgN?=
 =?us-ascii?Q?687gpRIgdqfPTq9Xpu+DOYNGOIJystgc+kUVNrGJEE+ec87fT5F53eGyONKb?=
 =?us-ascii?Q?sTdwF0XDZd5vCHqu7t9eC8lb8muTbewtJEAzw0Bx5a8Lxf05sABJ+XvdQU3D?=
 =?us-ascii?Q?CCm+sLtFebgp6Og70ZJH2pH59D+LAGqysMYaYq/iZHGt6pll8MNwHI4z7P5J?=
 =?us-ascii?Q?v2XYAx9kglrZdGqhRYSrMfWbbsr2XG1qPBPQFRr8VPSYuSytoSgwF1V4AoPG?=
 =?us-ascii?Q?89+X3CXnv9o0ydT8j+gzmssjmW3nWuJ3ouEEVYa4VNu7hGqfSpDaValo3MFV?=
 =?us-ascii?Q?zlOp/e9uvZfJG92mui9y/Yopk0oJLuvpltMKp35Gmbyet3BQWnvtzO8BLHw5?=
 =?us-ascii?Q?qstpNTXHCu2qFthbqvbO4XkwaviiCFTgbMhQJU2nq9jSw6QeAxsxucOjP/UR?=
 =?us-ascii?Q?R4kHuQuhC5Bcf+OcYJzruB8h+6icQz5b3+X9HM3afzW/Rmu5E5NkxsyLlhCt?=
 =?us-ascii?Q?AS1lp7oJjI+v/1VyADKJyfTA9pzJ1UaxLgW7Ke7Ui3iPy3XbsaArt/dwki7I?=
 =?us-ascii?Q?OyRWOxtfFi4uty4PSmzh9CI1WQ5Rz6PZrHwhYkWke0NLSagk6ceD49AC179d?=
 =?us-ascii?Q?a75jmsf28stQFuZP6ur/84Veu7ddOZ+MMI59jLhFAgHGGGJOsP884UkI4dNJ?=
 =?us-ascii?Q?zny3hOZ1xhpArx7c1Aq5D3UyaBxMeo4Gbs7CA3FPdG189HpV27TWfqK3FPRe?=
 =?us-ascii?Q?m15JdfccODwP1EHzOdpXTiz1T+bBY311nQOgLhj0vlKhdjqLxRSyOyNLdWAZ?=
 =?us-ascii?Q?dj+tsPuMK6J9PazWzgtywDNcaG5L0sFiHoxzzM7zjx7kgjvKsUuzv9wzsR3O?=
 =?us-ascii?Q?DdVr5ujOIesvyZvTTeIK/oXjSwZqyKdbGjndn0HkChXLi8i0cuWhSux08YQ1?=
 =?us-ascii?Q?rt+5ccUDQgLiSWhzGe9uEpu4TbG5TnbDSP6cELCkj+Y7NIxxFrFo2Be/hvw0?=
 =?us-ascii?Q?mcXQ9JMe2lhyRFOGvaLse3CxPNg/i2r0/1apYFBo5peANBJB5Vxn6H1L2iGh?=
 =?us-ascii?Q?QAeCls1AvVZ3pury/7hrwaOfLJOUBlQw4BRPhbszJWfN+syLTtpI/scIWbre?=
 =?us-ascii?Q?zSNKh7tc1GxhYQs70RsT5zk7eDUHE2/ffxn+qkueAXc6Id56Y8kYfES1b9I8?=
 =?us-ascii?Q?1xivjLoJRaOvIeB5fi53H6aK8oWGpGlGkUdAnV/+p6qxhR0DZN+8ELWUNJRB?=
 =?us-ascii?Q?o2X/c+c/jZ+W7Xe0GpsFIUXoNqZKonLkZtfC5zwP0ZSmijhwWSE7AuNW5pAp?=
 =?us-ascii?Q?QDOhgN7E6dxviDqnUD/4nTRiNxrRDJhFZPr9q1gTyxZmlHK4LqkP7XJHfy3P?=
 =?us-ascii?Q?xpZGNuLV3No0EqYjL9Sl/ZiAEVOfdAiwM4sUg/RoAIxwkUoMUlRa89LN3PU7?=
 =?us-ascii?Q?hyU/EWB00eBw/KfkyGPrvzSgMymtUkp4LUSIIWF0M2QMIDu7TKOLYD6ND++W?=
 =?us-ascii?Q?pLV/tmdS4sAHdH0aIPdy70L41w0+3hdtJYuiX/Wo8KIwmT1+HVHEg2Xk9yuP?=
 =?us-ascii?Q?0+BPvmYe3Dw/dsevo6Fg1iTiaVe5M7MVfsWN2k0kWxC+aHvL6AW8Io5U/EYa?=
 =?us-ascii?Q?Ih5IS2DXJEqp/QSIA2amPL6uaUZQ1fAhh8QceImbWTWoqKET9k44otdOjWri?=
 =?us-ascii?Q?/sKqhDNbPVxE+AKlSu6s0S641TrYatTM7Pw/Jsjp/+HUDSviRzMGolDBII29?=
 =?us-ascii?Q?wQ7U8TFQtMI2tx2ETw96kmZxRS0oN77SRl+tQPJPVUntnXErO8is?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b0c702-216e-4164-3386-08de8f2d52d0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 13:56:35.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8o+RErVgVaqL9ByfJn5njSzeWuohsXPc5wEh1087bAU35EykqyXP48E5HyurGnhAqN471MA1wraDQZlLZadZzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2310

On Fri, Mar 27, 2026 at 12:31:09PM -0400, Frank Li wrote:
> On Fri, Mar 27, 2026 at 12:54:16PM +0900, Koichiro Den wrote:
> > Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> > engines) whose register windows and descriptor memories metadata need to
> > be exposed to a remote peer. Endpoint function drivers need a generic
> > way to discover such resources without hard-coding controller-specific
> > helpers.
> >
> > Add pci_epc_count_aux_resources() / pci_epc_get_aux_resources() and the
> > corresponding pci_epc_ops callbacks. The count helper returns the number
> > of available resources via an output parameter, while the get helper
> > fills a caller-provided array of resources described by type, physical
> > address and size, plus type-specific metadata.
> >
> > Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v12:
> >   - Add pci_epc_count_aux_resources() and pci_epc_ops.count_aux_resources
> >   - Use pci_epc_function_is_valid() instead of open-coding
> >
> >  drivers/pci/endpoint/pci-epc-core.c | 83 +++++++++++++++++++++++++++++
> >  include/linux/pci-epc.h             | 53 ++++++++++++++++++
> >  2 files changed, 136 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index 6c3c58185fc5..fded71a19d71 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -156,6 +156,89 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_get_features);
> >
> > +/**
> > + * pci_epc_count_aux_resources() - count EPC-provided auxiliary resources
> > + * @epc: EPC device
> > + * @func_no: function number
> > + * @vfunc_no: virtual function number
> > + * @num_resources: returned number of auxiliary resources
> > + *
> > + * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
> > + * registers and/or descriptor memories can be exposed to the host by mapping
> > + * them into BAR space. This helper queries how many such resources the backend
> > + * provides.
> > + *
> > + * Return: 0 on success, -EOPNOTSUPP if the backend does not support auxiliary
> > + * resource queries, or another -errno on failure.
> > + */
> > +int pci_epc_count_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +				int *num_resources)
> 
> Most like such kinds APIs return count directly,
>   < 0,  means error.
>  >= 0,  means how many resource.

I chose to return 0 on success here based on Mani's earlier feedback on v11:
https://lore.kernel.org/linux-pci/lfbv6sjevz4xtjr6zt2hl3wap3bfwkvigqb6fdztqmutxgcvld@3t4x5gstr4nj/

I don't have a strong preference here, but since there seems to be no clear
policy/convention across the kernel, I would prefer to follow what is most
consistent and maintainable for the maintainers. Of course, I'm happy to switch
and respin if preferred.

Thanks for reviewing,
Koichiro

> 
> Frank
