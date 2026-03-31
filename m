Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823153F9F4E;
	Tue, 31 Mar 2026 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966186; cv=fail; b=o+ZG/NHp5wojzVk7khVsdschHtDChum2pIpDxzWi0sqGlEYRc7tQc3xByZuy8HGjNxAd7KPZ27U+blECh0NbYFTKPm6GqM3QQc6ikn8yRA0LgEvC1x1+oZYLt91/EAzY9OWy9Y9WyadL6JJ4DEpGLZNfoizXbK3gUxrwu+qX8Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966186; c=relaxed/simple;
	bh=UJF48Itq+3GC6DNRdGFesnxPq8m+xUCM7fJqhosTSB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WVTlW2R5VmjuS7BJOQIPDRyYFY0DmZYh7HvNcfEIM9paY6Z+GCVmCmI20OteZ0bRIwm8YfKZ+30vnHebOxoEpEZbHWbpBvph2qNUpbmt3kzQEyP+d2OhMk05+cmRz93LLTLa7KsfCgdBvlNdh2z3yiYJUlfINFXY4cJZtxZUkVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lWbP/9Oj; arc=fail smtp.client-ip=40.107.159.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lWbP/9Oj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1UyI53g4Ykx2bXtFdpFR4kHbcBySX393lM27uWdXk4RHQBl44KFmB5s4HeIfTkGKw7xCUjKR1Kg5hNh+qKM844V7GgM9tZyq4NYccwnoa/wGcB2O/v93p7NGHvQ0JjqsJV7swSqvihlufu6/11sRS8y7eQe3BVlzLcipJyLN8K3hNQv90J5eJYCmRrOlqVxTMdOMfA+G9cGFul2dRccXjWaxZieL1jGkw3JluF//G+tB5uKru9ubyWltYzdQNRE3kk3hV7Kag6AASkG89aExIBv5XlByPeq7B3lifsMbtCllheWY7jUChFbtXNYm/n2+1VmjL0f4aSm2MMJugTMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPlcsmdIGPsV8tIM4ZOMyCWR3yFmaKQfV8AbjErZsXo=;
 b=UyPmx2skP/Vtja4PSydk1JVyBtTpWFY1t47JjllQ9X1erYwGp5IAFcj9bhGuHbR9E6DqobdRyHRm2t+xWVQRb8SfQiS3PbTfS+9AzJ0EYIO5NPtpb27aK043+t/Vdf1MgaRwx6E41u6gA+1dtRqcBkcJAyUl+iS1Ky/Nymgcp7A3sYRDKPN20oVrHEIHDsfPpLtfZkbQGXr2QeWKbIwsSIg2pM7mr9hcOZDUlPGj5AVxA1a8K1CJ70H5OpqQX8Tru5ECJ1OgZBDMe2uDXCuPt6PiQvGNtdH1XS04dWFdAkqmZo6hs7ibfoGEJFNNHtrUtGXG9CCB0IEPhTUrB3cYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPlcsmdIGPsV8tIM4ZOMyCWR3yFmaKQfV8AbjErZsXo=;
 b=lWbP/9OjP/fCV0k71phfACz9v1WCO7PVzVzn1gdrDH3TOKj/v6vvDz2dbw3XrqOjDzuwfDdYjxEuxOyIMBgCrRjiPd9uQcQrcnkfR57FE9Lb62u1dJPnIMv9VGcRprlvpC3cEbSs3Q/k16T89dyPwKsEj1ttLgLWYT7lY3Xa0iIhsZOcjvfwlVjuGakmylIVcZk+sInS8ORziFZ5QwvkR4gD/3tZmr20Pzzkz7AiBfh2OWuHn4JCIo4rIpkiOujyZPtfaGS5SWupEwF8ZgLFd6vEFOK0QAth1tF0xijIMGwxRcVnOUB8bAnLSSgJnu50cmZrKIZlOchM8CBsxmpjvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by BESPR04MB12563.eurprd04.prod.outlook.com (2603:10a6:b10:ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 14:09:40 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 14:09:40 +0000
Date: Tue, 31 Mar 2026 10:09:28 -0400
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
Subject: Re: [PATCH v12 1/7] PCI: endpoint: Add auxiliary resource query API
Message-ID: <acvVmM-nk73ntNj5@lizhi-Precision-Tower-5810>
References: <20260327035422.4020455-1-den@valinux.co.jp>
 <20260327035422.4020455-2-den@valinux.co.jp>
 <acawzbj2s8P95YKi@lizhi-Precision-Tower-5810>
 <zzatuxxzrg6yuqprvhgntwspsrg3igk2wqqqamx7xh733ksgef@mvwzcseqvjrb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zzatuxxzrg6yuqprvhgntwspsrg3igk2wqqqamx7xh733ksgef@mvwzcseqvjrb>
X-ClientProxiedBy: PH0PR07CA0073.namprd07.prod.outlook.com
 (2603:10b6:510:f::18) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|BESPR04MB12563:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b1e27d-da8c-4fb8-fe31-08de8f2f262b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|7416014|1800799024|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	phgp+jNmr+5quLbWb/q57yNJzJAoYhekIeU977TNIomNDUI83FR9VaNIsmTfpkBViDrTMEoYTNidWslauXDcyN1/kgaZk6zOGczse9oFZl9pxaiiNbMqTnsX5BKI+Srf8jsXbqeUkt+wTF5xVsP/vmrVfTMRd2vp2VX61cafuDT+Jez+q+cvfijcig5Okvoy4FhOqYTAJv8/C2Edjl6lgfoEav+qf2JM9QBIaY5O9rhgAxH3RtM0YVPmxJOQqE28Hz2Ty0xo0gKMd5uSjVcLTslnS5fmq2TMJyaIy5R2ur+vgL0ZHctvhl9Jz1WyaztcXv1VtVOUUI6mZlSci58P4viZyAyuwRqjFUXJNBgZlvSvtvx379o5iQTuxPDCHjWkZCnYEOlh7k++qeI6hoWNvYN7HtGO33ybK+Cw/JUCP6yV3pxU2Cq2p+nOJlrfqdqemt1XlzAR7hRXC6MOwskNfT06wMEvQXyI0qgaw25867jKsgn/AWibvcoFmVCWa1+co9mq9LW8w7htk2GhM8n9+cu3p4+oElUX4ClDIXtBgORNdeT1lUsjDWIBW90OTNaI4avEVv9Byefh0ecRwumZCsAMGW3apyC5geN/GD1RP5A/KmM2LmeP0j7+AqvkfbwhKw15QUk5POIDuciRaTSmT3Jfte0Dahg1Frj2hvGqKm1F+f0/6i1eE7gC5xLhvsLsBqR5DpYC33kVV575JZoWuSwQvNBAn3NaSte2n8nrYJ2mFPcVUp6n5HS/eupG9zFvUHaMjXOnz1PzMPfrkQg1Plxgs+kGQBku4Av4JSJ33po=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sy6yZfjiecxDEbj45BjSGOGrmYygAUvmd4jIkqnhiHddUJ3c6H5BtdZA5Xrk?=
 =?us-ascii?Q?57l1HsRmt0kEvdJLE5D26ZmlPyKNganFrdhPToQgd44C39xPYFnIUARQeBn0?=
 =?us-ascii?Q?2qiJ+sfa5pTDzFU/e6kpyFNcd/oYJEFTyz3PDAm2Gee2BdoOX+/eSgR4Lvi3?=
 =?us-ascii?Q?nTb/vvQBhFiFwZsRhV8Cqm5oqFuUoMSvaNhVLDQv+Lc6nZwMAcCvxB4P7Kpo?=
 =?us-ascii?Q?/sUkweelk1vBxkDvTAoMY7DCBosdXM6Lay8KWM5XXPuGjshTjyAulXNMjSdL?=
 =?us-ascii?Q?OlvQNNLTEdGBqhwxuXdthfPqe06yXfFaHLuIS9+EJHastLA2yiCbfeTEGIEZ?=
 =?us-ascii?Q?Q9vE1lU1A6JF2rTvzW+eHzHQDbgojjiAcvJ2eErixOot4VQbRJgTKI5ukJxD?=
 =?us-ascii?Q?qzMXTDUXy2bGltMss9mcOi1/PXQwDce+0S6uIOVUSehDuE4xuTi3sBw7sdBt?=
 =?us-ascii?Q?8AHv8LZ/e1AbIC51ZnMkgxZRAyBak1T3TkHI9PdTM4qwAXtNUNCUTkp6q99o?=
 =?us-ascii?Q?j/QHyAH/dO6axjs207dUKxt8pFp9HTHL7O35qK6ZkVCaZfHcda7Ol8Ft6XmQ?=
 =?us-ascii?Q?O4x2nZC+8/7NylTIrB8Tx20qcmysqYxkiDcakgbCQzXYUEPLyKtWHw+uAmlp?=
 =?us-ascii?Q?eaf63O5/5qYk27zwN7Ir0qlpeyeSvEMEYv4ff7/pDMsoeXX3KaXiE5Sfv+JD?=
 =?us-ascii?Q?JL/A/F8ggTAXFaNmz8KjK+pdDH6e9z899Xb91cT1mJjmN5AytfYOhLxW/VR2?=
 =?us-ascii?Q?a/ghYtdVIdx3rsQR6BLa6SW37rsy+PSVUKoJU2vE/ELRMgB6dtzyPaHHhjQu?=
 =?us-ascii?Q?I/K93gNkHy/KFRv02GKczxEbk1p8vLK69YK0r7tbPxSWe0RZgqSidAh8Vcpz?=
 =?us-ascii?Q?jlG2NhPqhRL3x6SXTLA8mgrd1ATg2au7ms7KDaPKAh+5h4SU25u5NTIRTjvk?=
 =?us-ascii?Q?W+8v9AZkVcMWMm1H1C56xdnOWMbVnleFis6YoG7aQ0Yt8JBB78+hb6i/JstK?=
 =?us-ascii?Q?8jNgt/JUcTHkk7pgQmjPvpLOpFsJRTJZY0CWierPmplvgO+J59ugtCCMAn/0?=
 =?us-ascii?Q?kTHDyezQdC5jAaQSboQyXhTdHyLACcb/NujXKenMEhcO7x4a1+uUjE/hXfgK?=
 =?us-ascii?Q?b9nD1KBNpQk+GSpoajPVvlIVaacnDVnwy3FugSJe6iClaHrYJpHH6HIsHm5i?=
 =?us-ascii?Q?vE3W057DlZwGzn2GsUC6+Qbaqq3g8lsgoaa8+mwZzZaPsNDKK3x9pZXyg/Es?=
 =?us-ascii?Q?l8eZUC7cHFGFuOLq39ssgqISBTJ2jbBgM6elKjDgBoTlvz9uHQIGuqyLWjku?=
 =?us-ascii?Q?PspZrQQC1l9oYV2z4VNEJwA3gzVIxFldy0cOkV1iiHcD5wK4XcRx3XdqJ4+c?=
 =?us-ascii?Q?MnkTOgLDOY0ZgA4yGbRRT2gOJEMsd7k2Md08RO6qpDmzFfW+HpePjpvk0YTU?=
 =?us-ascii?Q?hfkevXFUALCh0WMkj6ml6vmsd5xQ961AMjo7HcpTSwPnYfDwtcpD0gahO3Vk?=
 =?us-ascii?Q?qP1aylhq87QXnssuk0aRf18tP2s6cpgFydvJVkyIePEVz0gtfMiKyoEldV8q?=
 =?us-ascii?Q?R4GDMGTVRyF/3+ennUK7Lq+YGOF9xaPq+UTK+zzrSK8A2aoMtlHMQgK6luhj?=
 =?us-ascii?Q?UhxoJWQ6Fp7UZGeUzca/W68waY3I7zv6X6mYn+atlhgssC4hwymQxfYu9EU9?=
 =?us-ascii?Q?vZai5n9EbC5gCiXtRGXeu7sugLM0s84F8gDsUVCIqBg0dB44?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b1e27d-da8c-4fb8-fe31-08de8f2f262b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 14:09:40.2308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjC6b/gCRBVa9q40Kdv4INLYII9EBdDxdLDrkH6XS0LbqjqefdvjK9e4cGzT8MiFGYZdvYtbAcaDPNgm9qJ55w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12563

On Tue, Mar 31, 2026 at 10:56:34PM +0900, Koichiro Den wrote:
> On Fri, Mar 27, 2026 at 12:31:09PM -0400, Frank Li wrote:
> > On Fri, Mar 27, 2026 at 12:54:16PM +0900, Koichiro Den wrote:
> > > Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> > > engines) whose register windows and descriptor memories metadata need to
> > > be exposed to a remote peer. Endpoint function drivers need a generic
> > > way to discover such resources without hard-coding controller-specific
> > > helpers.
> > >
> > > Add pci_epc_count_aux_resources() / pci_epc_get_aux_resources() and the
> > > corresponding pci_epc_ops callbacks. The count helper returns the number
> > > of available resources via an output parameter, while the get helper
> > > fills a caller-provided array of resources described by type, physical
> > > address and size, plus type-specific metadata.
> > >
> > > Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > > Changes in v12:
> > >   - Add pci_epc_count_aux_resources() and pci_epc_ops.count_aux_resources
> > >   - Use pci_epc_function_is_valid() instead of open-coding
> > >
> > >  drivers/pci/endpoint/pci-epc-core.c | 83 +++++++++++++++++++++++++++++
> > >  include/linux/pci-epc.h             | 53 ++++++++++++++++++
> > >  2 files changed, 136 insertions(+)
> > >
> > > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > > index 6c3c58185fc5..fded71a19d71 100644
> > > --- a/drivers/pci/endpoint/pci-epc-core.c
> > > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > > @@ -156,6 +156,89 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_epc_get_features);
> > >
> > > +/**
> > > + * pci_epc_count_aux_resources() - count EPC-provided auxiliary resources
> > > + * @epc: EPC device
> > > + * @func_no: function number
> > > + * @vfunc_no: virtual function number
> > > + * @num_resources: returned number of auxiliary resources
> > > + *
> > > + * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
> > > + * registers and/or descriptor memories can be exposed to the host by mapping
> > > + * them into BAR space. This helper queries how many such resources the backend
> > > + * provides.
> > > + *
> > > + * Return: 0 on success, -EOPNOTSUPP if the backend does not support auxiliary
> > > + * resource queries, or another -errno on failure.
> > > + */
> > > +int pci_epc_count_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > +				int *num_resources)
> >
> > Most like such kinds APIs return count directly,
> >   < 0,  means error.
> >  >= 0,  means how many resource.
>
> I chose to return 0 on success here based on Mani's earlier feedback on v11:
> https://lore.kernel.org/linux-pci/lfbv6sjevz4xtjr6zt2hl3wap3bfwkvigqb6fdztqmutxgcvld@3t4x5gstr4nj/

I am okay for both, But may request Mani think 2nd. Most existing kernel
API use return value for count of resource.

Frank
>
> I don't have a strong preference here, but since there seems to be no clear
> policy/convention across the kernel, I would prefer to follow what is most
> consistent and maintainable for the maintainers. Of course, I'm happy to switch
> and respin if preferred.
>
> Thanks for reviewing,
> Koichiro
>
> >
> > Frank
