Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013040.outbound.protection.outlook.com [52.101.72.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B813559E6;
	Tue,  7 Apr 2026 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775555299; cv=fail; b=WXATby5zplzIRy8gPwgAQIogpKLRsb8sLA210NEGAVSr6Eev0MRoFXwS4MyWhtPmVOgzi5puKVaVRoQMrV0FoExtNdpxgUcHx5h72Gx96mJr1xCoq+kj9QJulSejB1ZBADLq861WrgRBISEheM42DKwJqTUFjtOQqyrm6UFLqIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775555299; c=relaxed/simple;
	bh=7gV289RFcPtnl70kLZF3Tg+LmFgIlL9LVv0WDMnmL6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eJTgUPIm+2tJYAZDiIsOx+W2ujPlRfKnQRs3SEA7mmpDx0xTDM7YcVCq48Xw1lySNbee/RBQFgwzNBqtubSkM5guVU24jcGaZ+mlEiKz3o64Csym8GWBdAbpsgXuTAVvXPMq7ph01V+nO+EoGV2HZt3wBTlGlgWGrNqC360mZ+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TEGcfjH8; arc=fail smtp.client-ip=52.101.72.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TEGcfjH8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imfIwxb0H1vxY0SHiBPllCatAYwV6TI3m7M1oOxXiZRLJ6WAEIbD2rE9P/wYCF7v3IRuut/2noY1rNqnRSftJf5hrMPxk6uOgFKWf+fckaETHBivyFwuPp2TOZzcs35u9mBW06tGUG1YYokLtN3VX/FEtu8N7T86GE9vKEi9FnOgfSSTz31YZ9eyPhkJt5eTyrcJK0yBPSMh+NZPAjzJ+8fb9dS4yH7n4EMzjVN7DMPwtpUlGIS8SozuIkZdNX1V060q04HBPTUfyYp7NrVt4n2BVh79YhXj4mtFn9c2qgt0Fq/6OmchGQ53HpzXljus/6FGnjNub/tnC0Tf0QDkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFumAhxSOpTYOVhwvEfTshTEQeyOaZ8AkICnT+edsL4=;
 b=gJ1f17cv7q/sZL3w1zgTcnv7jax58Adr39u/9qAW5pMsgxTP6uSPgKKQi8KhpoTkkNL+bwB6UtkqYVt3J0mIi30ZZXRSCi+77OGRFPbpRM5//ir4CADBzQG7Uh7HKXPXcWSULFFwicFqM+QKo704cizeGZgR7boqpDUvgor8rIfd7OblTwv1L5dQPqzqy0rfZOXHOEGeqOcdCTFFzy+bcUM035Ym9mJRRz3tQ779VRTSr5cXqwteH2jZdz1G6DOEQ02+oIaysbvWouRCgE393dvqWENa4m4AeFr6CLaBjUPgjmnKe+9PmjZVNlMMmLeApiSwbdGwkXDGWmcPiEtGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFumAhxSOpTYOVhwvEfTshTEQeyOaZ8AkICnT+edsL4=;
 b=TEGcfjH82Q3u/CRLWgvmOPSc6NHoyHrHKU7gtPVxgdkZGgLtemhl2VYq9nUVsS/XN2VDTFvtnFgt+m72CEllD7lm+9lk5uwZ0gptEFQSvvqfnFkDGrzccGoeMnoo0L2taXk4tCsWbdr07yErA8Ejl6tVFzqFotYn+TY6ooWJw9Xenn+IrBIXTBlST18r1xcEKbNVNZisxASseCiaOFBSp1q5NbEFYojDl94fHNvoMeeM4j7oH6RaFlNXldsl/6QIUfFxf1JEBD/v7w5YWIiH3moXYIESGndeUUFOr0EGp+pz95/PvxV81H1HbDxmyBDJUMoWYv4ElZilVA7e2MSgvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB11364.eurprd04.prod.outlook.com (2603:10a6:10:5d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 7 Apr
 2026 09:48:13 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 09:48:13 +0000
Date: Tue, 7 Apr 2026 05:48:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v13 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <adTS1gj1nqi9DLFZ@lizhi-Precision-Tower-5810>
References: <20260406155717.880246-1-den@valinux.co.jp>
 <20260406155717.880246-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406155717.880246-8-den@valinux.co.jp>
X-ClientProxiedBy: SN1PR12CA0057.namprd12.prod.outlook.com
 (2603:10b6:802:20::28) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB11364:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4a2080-37cb-4301-9de1-08de948ac941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hLD1tZ2tBt5SnQ7+LNdL5aKyl3MjvAHUMgvLUpGgyk+F/5YlxCkjSp9MkjliLNzhbtj7SthA/Ygdg1+qpY7maNDuSe0CDAGQ5njAtUz3b7a6CK3HQThgTlL5VKO62tC1UfEEowzK2UrOjj6ndsKzfnQ8OjIHRthG/7wBxoGG8b7DRVK6AnWJGER1VH4i5mrZZRTzxDFcGtc6eQfc867sQZyMq2SciciThgD0mEM5M2vmnCB/KC8oA6ucMD3BWRPvA+aQcBDw472R1HGKVUFOWmj2fwWtQ6oVa8X1G+C1tN3AIahmNVbc1NNEoJWfBc0ZYM53T5XlCAo+o00C2KvAPigxXIy4LUYYCAQfpYStb1G0PmbYu5eHOI7KpgFz5v9PPpUH/7zjlc3wZzvZcGKApgAPKhE397gakKF+VJq9mqw6SJDXh4x/8M4dy95yO2cTRAUUNAc4HCfD1xIm4z9Og4GxwRM/SEt1wUcLAAgXAhyBUQtbU57VrmbJSg+x4GIeRuzqc6b8jX2o+gsvHp1z794mM1k17H9aiaUX1+bEr7skHbgyPs1idodYWABnbrTM+QbaZe9lypUFK9rBObGIzA5aJoZmMEtj2tPGovIpR9S+rcq0Kp+am7UkBltnD3m0sh+1YfENdANIt+L8q/aFJh3gfup7KsGNEQu78X08dA8GLs44qF56fguUcfC1yc17cxfxyKN8O9qVUWuB76q01qYa+AzdQ9u4jwINEEZfJWMlW2ZOyUZpwEpioejGMkl9eI9nQgKNve+BOzM/+RdRfioD5+/QoEgw2krFwH6BAO8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2GYHwS0SHrleHKEcrzGS5NQhBWIVYm94HohYv9ERhQEAmLnUyAkdt0oAzWo6?=
 =?us-ascii?Q?GjNQ7UJJTHIC55MDdfCbM5m9/5KFEgN5XPn96M4vRZnXchqKUOYjbi9kdWi1?=
 =?us-ascii?Q?C676FkZ9yrwPwlPj2qTh2Cisqxi7gC1dfvj0pqrCB9mXtCuoTDoZAeIm+ktV?=
 =?us-ascii?Q?lwI9hYPZU9yFNju1inPX8Ov1vxc5k6XSjEsLFMQIwg8jDPncPbyESQLQApxX?=
 =?us-ascii?Q?STYp2FLHaZWwaFHcQQppdfU9IaXZLY5FtD4fvrZHx9zSyaeqr2wE74Vir3Yu?=
 =?us-ascii?Q?nCZ8INka5PbL6fVI3rn2cQ/Cp6uwirLW3PO/HbcMhq+mu7quS3gSfs101lph?=
 =?us-ascii?Q?SMjS35z4S5myRAqXQZsvXUGlBM1QGD4ydP/jwlx1av339YtIT757UncibL6k?=
 =?us-ascii?Q?4g74MsDgmsKrLeqzU61CiwSxqSH2VdmXGVmuxWEj4QpFbl+mVkHk2BcV3V63?=
 =?us-ascii?Q?nh4VKfRVeiiEOq4RwIu1TyFMnu4jhMHxnlyh5Cog7o8bC+DbgB4WXi4mtUQ7?=
 =?us-ascii?Q?GFacVer/oZspsSB+3MFYrHGtu17/DYZDoQVfVPGO2QsH0MPdo4H30fPgY/fC?=
 =?us-ascii?Q?9MdaIZoXxhSBwze+2S9eUtWYa2/q7+jQGo4R4FqVINhnMGs6uCJFBa896+71?=
 =?us-ascii?Q?la5SsNXTHkP0U/jVHTe+2vgaz+FbDGLYJGwoiIk7n4dPc7gWRZLab7TjvSSC?=
 =?us-ascii?Q?X0offJ/xCrsRmyU9o/OuUnnlsuAbjLttL3wR3SidFCCMwJjuLt1gQCYBMRYS?=
 =?us-ascii?Q?MXi1CLoMztE8KcdOTyrd3jwP6nlqeBBTGSzEVVUb8Pa8T3Y4Wq3+ZAMfC6WS?=
 =?us-ascii?Q?h2p4576wUXC/8sCkn8EnQ88LlFdXldiC6cgyvBgsVEr+AupLcoKi0NBlg3Ja?=
 =?us-ascii?Q?K50tBvdTudpJU09rjpmNTjY7BMmjz26QRCLvnV1xZ8pBZRmn2/hNwigb/ks2?=
 =?us-ascii?Q?ZS1Y9Y79r6he3wZ7eRCYS4yao/Wlw6aT9eE/m6szwtD++tQ6ZbplnaRbk72R?=
 =?us-ascii?Q?VRzYEcNE/c9Oie5XpWcNG+Azf+WXFsLyY0OuVAnaoAVZvl9X9CH2Tlh7hF36?=
 =?us-ascii?Q?6bjZiEfYWIysqTqlpRrwtqAMnC3J7M9QsmEQTZiNCTnjpS+92MBVSa9v5lcq?=
 =?us-ascii?Q?gK2/JFQ2Nr91IPgq7GQ7z9eZ06BS+bCeE3cPJnRWaHoCWyfGE0MvJgAHAYos?=
 =?us-ascii?Q?Yaeo2LGWNJDUjsVsytwvkJi/qd9rAuFGbKOiQGviSwdTaMrn+DV2H8LvzUG7?=
 =?us-ascii?Q?F/GhRQ4BCqssMXwajy1lThigkXTgxQY1PgX4d374jbZmAcfBv9H1UPpMhhjo?=
 =?us-ascii?Q?jOY8QzPrcuVervDEzcrPan7pBM7fTXQww+rsQzw0WXGXH9njOVnoy1dGsgqX?=
 =?us-ascii?Q?iO27iCXG6KclRKJqfHs0MgdZDEeCwrSjseYBhnASve9kwOLARcPmIX3qJdhy?=
 =?us-ascii?Q?CsutFMawG1wEG7k/ZREO5WXsH7gFau5kXf3NKlDzObbrLH7s+DVDtrBFPs7A?=
 =?us-ascii?Q?NgMQd9ydcK538QZ++7ZDab2NASyFe3K0C5Be3y7q+/Is0QmJJ6KKm0vUl2gn?=
 =?us-ascii?Q?wx+yx0R/uU54nnmU/B+GdB6h63+zYtoey5f0cRbxI/gn9WfvPSz0iachknV7?=
 =?us-ascii?Q?RzF4CugOGZZ/cwM96ZxUv6j/vU11vlVmt+Y1cidbzxGsZ+pWlynpffFiXQrl?=
 =?us-ascii?Q?HjInC6K6Y9PmlQ7jvQBn3I3aKCMwcg6B/oPq8V9WIu4tfapK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4a2080-37cb-4301-9de1-08de948ac941
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 09:48:13.8007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kx0VFCNkpPcjLuGVkQKYt/GppKy7s1qa4d358b6zPpoPzwXHho4JZJbE5x280PsYIHOV40nbI2mUGoNwGiHt/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11364

On Tue, Apr 07, 2026 at 12:57:17AM +0900, Koichiro Den wrote:
> Some endpoint platforms cannot use platform MSI / GIC ITS to implement
> EP-side doorbells. In those cases, EPF drivers cannot provide an
> interrupt-driven doorbell and often fall back to polling.
>
> Add an "embedded" doorbell backend that uses a controller-integrated
> doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
> doorbell).
>
> The backend locates the doorbell register and a corresponding Linux IRQ
> via the EPC aux-resource API. If the doorbell register is already
> exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
> the DMA address returned by dma_map_resource() (which may be an IOVA
> when an IOMMU is enabled) so EPF drivers can map it into BAR space.
>
> When MSI doorbell allocation fails with -ENODEV,
> pci_epf_alloc_doorbell() falls back to this embedded backend.
>
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>
...
> +static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
> +{
> +	const struct pci_epc_aux_resource *doorbell = NULL;
> +	struct pci_epf_doorbell_msg *msg;
> +	struct pci_epc *epc = epf->epc;
> +	size_t map_size = 0, off = 0;
> +	dma_addr_t iova_base = 0;
> +	phys_addr_t phys_base;
> +	int count, ret, i;
> +	u64 addr;
> +
> +	count = pci_epc_get_aux_resources_count(epc, epf->func_no,
> +						epf->vfunc_no);
> +	if (count == -EOPNOTSUPP)
> +		return -ENODEV;

why need replace error code here ?


Frank
