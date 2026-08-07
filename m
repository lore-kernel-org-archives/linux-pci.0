Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010046.outbound.protection.outlook.com [52.101.84.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E24390CA3;
	Fri,  7 Aug 2026 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786135434; cv=fail; b=snS+ubH+q758vy3zKyeBCOrEa77M/dI0jhoHl6Q5g+yHB8LiOh+kVaUJPcUVSRnHPWfoQ5SNQ1ALwPXtGkD9CdbO6NpezfnPv80GY8sHMZwtK9fNcFVy6bqqcILVNARUYPnuiXLGj4KbmkC3k78F9v53ESUEJ5xjd+LnWC+wB9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786135434; c=relaxed/simple;
	bh=84H0jQNFR++wj/+CeK3JPs8GzyOcwkOHt9QG7EE22HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IT3wBqZZ4IEjPv69VrmpRlG+GCte+EkD0m6iwoBUSi6YE3xNq1kU/DxLzGdm+vuJRyuV14xPyRu1mJAoRrmxQgpgiImWK8r61F04WRNgjN6L44Hf/Rh8rL5VtsBkX5J+aJ6RmafmA7koIdc4xzfOOUd+C69lseq8tAF/BhOX9rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YLjcJLEO; arc=fail smtp.client-ip=52.101.84.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YLjcJLEO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5nbp72DYaTbSZLWGGgQt+MvTqjxYROwA7MFvqbHq48QWNbYg8oaYyVcplAa/IAbqClrMu7zqHas2gu57+aCU+iD/yYNpGRFb4fRELVNZ8Mb+rl3I903ueM+Jvxvyy+GkAOEs0QM7A9ZFpGEZrcNURVHQf0s7PBQmTCLwvQXk1jvGm2vSY6DCenRUvIFYJ2DJzNl4MeHIxEV9sRiUB/NRwjsD5l55kurNoBccmaVlPk8c7WtNNA65ra8fJCJUiCxqdECkTuFql2LULH4v08+JN/m2lcP+mQY15oN+bfv5x9zfr9CU3Ie3s/8zGwwGohrbUxq/dtoC+svz7deXKig0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfwxDr34Jl8OEjWYFGnuhLq7dXULmp38764JKr26q3g=;
 b=RtLrtViTaCTqaMCYSp9nmCzHCi1X4MY+kN9dPVQpiiCBFKCnYZMkTCYH7K8BH63errTIf0Bxf2kwvMjbgFUzk/L9FNNogeIrRobVregWOQVUjIgztnW63uryk6QIXFg21RA0BgiPWLJHakPzz6RBVjG2Q7Rt0gCJBXNshh9TwPxN3pmpQ/bys6MbV3Afq1tCPc8P3pUSimzZXCH0HbrtpGu87nWO3apgc2h7V9tUMZySsZFtT/Ifpm+gHMuuecxahVSE+F851AUsZ05genq6SNZIcMsn2ik5OOayQdM9CecOdqGhaj+9N/bt3QkFn9opqwzhQktzd88zBKpUgCFmyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfwxDr34Jl8OEjWYFGnuhLq7dXULmp38764JKr26q3g=;
 b=YLjcJLEOT4EHca8oX4q3DAIvVi/alP0ur1Zb0gIvhfcvbe5EDXggVdOq7F2PywEyYpflSmz4BRLVOBFqONBtlaZfrgl1/29zOUUH1NNcyaCSqj01oqsTcCNyvheNVY1vYKnWTrCi9kpBEivVhxope6Cui7pd3ya/cSeRe/Y7B/EIsrr2P9bAUey0rfCNyr0MWkHixjzI4ja6bixNZMJbNoxqLtPR47QI1RSysWNNmLR8vspCG/Ct6Za0Z3WIPojrhcVdKK5H3qJhBmiejApd0IHrbEdEXIsrwldIB2DcVXo+NrAm76YtbGfAP3ZmxLQHgtpKBaR0+c9t9Yixl3ozJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MI9PR04MB602248.eurprd04.prod.outlook.com (2603:10a6:290:c1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 20:43:49 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 20:43:49 +0000
Date: Fri, 7 Aug 2026 16:43:40 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] PCI: endpoint: Expose endpoint DMA resources
 (part 2/3)
Message-ID: <anZDfAvWOGZOU_EB@lizhi-Precision-Tower-5810>
References: <20260804033855.2115817-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804033855.2115817-1-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR15CA0009.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MI9PR04MB602248:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b03332-e538-49c0-25b6-08def4c4955a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|19092799006|7416014|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	3awEhSP3uMPHj5jRcMDq8GCrPDZdea4DzaMFcA4h+QvmyPgI6qAWBkx3dALFXiD2avT5OI/7DcO7ir3YYca9NHf9VN228NfePb8G41r+7+prlDA/HZHt712YiQWXF85xRFBKLDpsfz/3Pk4SxpLTwNe25VeshOH0zoyRghyBb9pRxRbe9PaEZTFenSESnGwSklxJPfH9cczJXsdb4Mix7vhjEo6i2KgPLvopXkURXu7zZD6Pbw3wcC4enf9U57nS4rtR77CR+xJMRPryzlWU6dCzWk+VOlirDyjTYGIX2/I7LyqIQuUGNX1k9GOBosQ1cvYnrgfWvTi/BII8qFxhxKxGpn372MpDP7xVUr1bkxFdd8W+kmkhJ+183/aT+ko92hksXAE85/gq9l45YNV+yBPthfL+bEeBD4PzTKkfyJv4nPHk8uo9TksUjJhLChPJ/S2DsCdhNmchHMETCb7F7TfAz+QN50FSYBhgfW1WQ/F/HW88CeoLdV5lsaXOGskjkBrpeQzNLTEel6krRIJa7IlTT5dAoztGb9RMXNNmcgte1v+TLXPde++ycDrBr3/y5vT3Y0xb7Bm70mLnNRow+UaOjDFryWNTjDPo6tsxgLumEVhpFNUM2HxcJqfE5y7kOUWfgRuT3C5inAjuWCi1MQTLiv5bnpsOKvZKm+uE894=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(19092799006)(7416014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lu94AKXPfeX0vNDrzx48HDAQFnTF8SahlVnJb4MoZKUTEGAynHP/TcjSc9Ob?=
 =?us-ascii?Q?bJf1xXsJ5Uxwfm529ok6qa1IlwefcSM9UBSIZ3c/FmKlO4xbnlCAB45D8fZE?=
 =?us-ascii?Q?7HfEE9PyTs2jtU98U1pZFjLoVErpdiz0VfFECnq0FYY/5XYGH9fXTChd4rdp?=
 =?us-ascii?Q?ml5CzgSprtJ9Lb/SGBPrzBR3ClJ+Z/CErGK/YpbEgQe/Ifz1B694f67DeIIC?=
 =?us-ascii?Q?HsRCvdZCdllg0eHYdmJkyEQb8uPxyR26RWewYPm8x/iE4mipA+3xSbOeiI9g?=
 =?us-ascii?Q?BywjA1h3QGrre/UFwJnixqP6amsSjTE4BqAOhSfDfrKUVLTya1Fh3Lnr9qnc?=
 =?us-ascii?Q?K8FYXgk5riOFFMCWewXD55Dqz3GwfKs1g9BwRsBPRMGuK9dy6pG83r7iHs+X?=
 =?us-ascii?Q?wDCLfqEql9n3kr2AZsYaETev25+XH349N2KJoa6xxNrN0o42SBP3kpyKL/WR?=
 =?us-ascii?Q?+yBuP8DksI9q7FGm6F/cReTOSU/tW+lKjcS+J47cvxwO9zIIjl/hMpXcNcG/?=
 =?us-ascii?Q?3wLoPKaZ4kHq3ps83hBNcTltPl3LzB9QCgHGMtIMh+5nSXKr0svtUAuNaVr+?=
 =?us-ascii?Q?gezSR5ZwlLv2cRuZBwLRIWv94OE038Mzw4ReK06j8yt2OwV3KQqAwuxCezx3?=
 =?us-ascii?Q?ZL0zu56RvWGrGp3hMOExiiNys9lfZzLk6bOKEDAtuyydm8Qyg7AXz6ZsAqUh?=
 =?us-ascii?Q?iM6MKeH5ZMg++v/A2Xl4v80plNlzKfS1ri2JEm1/h0EJARWXZhUeLu5xCd7B?=
 =?us-ascii?Q?Jqy27Grm2Ly+XdKiA84fxnHVJ+eWhSDba+9Bp0S54pfKmpH+jn9zqsMFzq4I?=
 =?us-ascii?Q?aiHbSFbQDTfAdKCKLtNpUGnr/Xm88XT4iR/mua5er7mMlAQWaw/et/M4FiAM?=
 =?us-ascii?Q?PfFkPNkZ0JHKv8hLC+ONq20RPCrbe2YuUAhX5GDSqrydF6SVgd1/guqhbRvx?=
 =?us-ascii?Q?YgoWQm/42K2vbPnrDbS9fIkj17vHyC/lXf3/dMffYmV+SlvRi6VRsaKga1Um?=
 =?us-ascii?Q?r93DzLqEFB9zhipi7ITGITYvHsnA6fIbck9NIBt8ahcWQXfzcNB4IJ8gMbnK?=
 =?us-ascii?Q?EzXzjXeoElZMiDdgZeOxFyBkRdCq2LihtrI0JgyiHQhBZE116Ievr1drWgpx?=
 =?us-ascii?Q?pklkrBpAISUosVcYFaBzwDWU7oIGHKvUwrtstqZ+ZFmJWzUzBy+AZoa5GiX2?=
 =?us-ascii?Q?Nvea9HDt7Nx3iNAMYk3cYUrDfi3CbFfiIdEAt62ipCpT68rbsjzNSXezaw5/?=
 =?us-ascii?Q?JCGN7h0OJ3ArxTzWIR3d1bcvZqWJF65SY2Lr84eCOdOBCDWMQ2TQanbpeV23?=
 =?us-ascii?Q?DIwRNt3P0OpxoGpwvSvonDNcIN4FnRy8HCvvBWGAmk4rsATL/Tqu3Bg0lvtv?=
 =?us-ascii?Q?cromMVXOffGmtfqtP8TyVnx7j4vNgnImoHKxNxfl1JLF0llxS/dJR5oxlruV?=
 =?us-ascii?Q?2zgS2viO0BTqPOu9Hd/Oju3f93BqZcAA2J+/CVRlG3v3+58HzNX8S88VN/Ec?=
 =?us-ascii?Q?4hg4VZ4Tmkh5iFs+/7fXHjqc/IfpjFLQDGyfgXOJ7NOYAMvHWMeaIhZggTy2?=
 =?us-ascii?Q?Ph7BsGyKLRYtSJVkI0rSqyvAswXnqAgb19bTFwi0OniTJawLuNj7r22pFiYg?=
 =?us-ascii?Q?x07EWimMgLn+tm1d/6rS1+m9QGPlrecRsUfBuLpIVIcnUkrhrckR4+QUDHzi?=
 =?us-ascii?Q?QJvYmxj9gnqVnxZlme4T9I48EgdJfoWAm/tanvTliEO1G1KqbnamnQfpB9Xa?=
 =?us-ascii?Q?DorWAckL9UU5DuZcwnJOK29tYW2UVLAdyIU1lbZKRdLPibcbnC11?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b03332-e538-49c0-25b6-08def4c4955a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 20:43:49.1701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWpD+O3AJRH9jfdd/FJyXqFPUNfM93NsXE6xc3/SbAZZGjKqf5SI5p6PGbURG99HkAfg427EICT2ofV06zAVGdGl2STxVvuC6QiW99dAYJS1lZ0LV0Ffg6vBAp+0VAMv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB602248

On Tue, Aug 04, 2026 at 12:38:49PM +0900, Koichiro Den wrote:
> Hi,
>
> This is v6, part 2 of three series for PCI endpoint DMA.
>
> The three series are:
>
>   * part 1: dmaengine: dw-edma: Prepare for PCI EP DMA
>   * part 2: PCI: endpoint: Expose endpoint DMA resources
>   * part 3: PCI: endpoint: Add PCI DMA endpoint function

This part only 3 patch, You can merge to part2. It will be easy to know
overall picture.

Frank
>
> This series defines the endpoint DMA BAR metadata and auxiliary
> resources, adds EPC operations for DMA channel delegation, and teaches
> the DesignWare endpoint controller to publish and delegate its
> integrated DMA resources.
>
> The metadata lives in a normal endpoint BAR, not in PCI config space.
> This keeps discovery independent from controller-specific writable
> extended capability storage.
>
> Part 1 v6 has landed in linux-next via dmaengine/next:
> https://lore.kernel.org/all/20260721062815.4117887-1-den@valinux.co.jp/
>
> v6 is rebased on next-20260803.
>
> Best regards,
> Koichiro
> ---
> Changes in v6:
>   - Rebase onto next-20260803, which includes part 1 v6.
>   - Use one DMA resource snapshot for bounds checking and array filling.
>     (Sashiko)
>   - Move DMA resource exposure after delegation support so every advertised
>     channel is immediately usable. (Sashiko)
>
> Changes in v5:
>   - Keep reporting a standalone doorbell when linked-list DMA resources
>     are unavailable. (Sashiko)
>   - Serialize irq_mode restoration with channel state updates. (Sashiko)
>   - Clarify the provider-defined sharing-group quiesce contract.
>   - Use guard()/scoped_guard() for new code.
>
> Changes in v4:
>   - Rebased onto the new part 1 series.
>   - "dmaengine: dw-edma: Add delegated channel request helpers" moved
>     from part 1 into this series, next to its only users; this also
>     resolves the undeclared-functions issue reported against v3 5/5.
>     (Sashiko)
>   - Lift the v3 PF0-only restriction on DMA resource exposure and
>     channel delegation: part 1 now programs the per-channel requester
>     function number. Delegation to PF1+ therefore requires part 1
>     applied on the host side.
>   - Move pci_epc_function_is_valid() up to avoid a potential error
>     pointer dereference. (Sashiko)
>
> Changes in v3:
>   - Decouple logical DMA channel metadata from descriptor memory resources.
>     Logical channels now refer to descriptor memory by resource ID instead
>     of embedding descriptor metadata in each channel resource. (Sashiko)
>   - Replace the v2 DMAengine filter-callback metadata with EPC-level DMA
>     channel delegation/reclaim operations, keeping DMAengine provider
>     details out of generic EPC resource metadata.
>   - Add the DesignWare EPC backend for DMA channel delegation.
>   - Limit DesignWare endpoint DMA resource exposure to linked-list channels
>     until non-LL metadata and host-side parsing are added.
>   - Suppress DesignWare DMA auxiliary resources when the local DW eDMA
>     provider is not available.
>   - Reject VF DMA resource and delegation requests because the DWC
>     eDMA/HDMA register window exposed to the Root Complex is PF-only.
>
> Changes in v2:
>   - Follow the part 1/3 v2 channel-claim model: EPC DMA resources now
>     carry DMAengine filter information instead of raw DMA channel
>     pointers. (Sashiko)
>   - Update the DesignWare endpoint resource provider accordingly. (Sashiko)
>
> v5: https://lore.kernel.org/r/20260717050635.2145014-1-den@valinux.co.jp/
> v4: https://lore.kernel.org/r/20260710082156.2395844-1-den@valinux.co.jp/
> v3: https://lore.kernel.org/r/20260620170438.3756593-1-den@valinux.co.jp/
> v2: https://lore.kernel.org/r/20260525063129.3316894-1-den@valinux.co.jp/
> v1: https://lore.kernel.org/r/20260521063405.2842644-1-den@valinux.co.jp/
>
>
> Koichiro Den (6):
>   PCI: endpoint: Define endpoint DMA BAR metadata format
>   PCI: endpoint: Add DMA auxiliary resource metadata
>   PCI: endpoint: Add API to delegate EPC DMA channels to the host
>   dmaengine: dw-edma: Add delegated channel request helpers
>   PCI: dwc: Implement endpoint DMA channel delegation
>   PCI: dwc: Expose endpoint DMA resources
>
>  MAINTAINERS                                   |   1 +
>  drivers/dma/dw-edma/dw-edma-core.c            |  91 ++++++++
>  .../pci/controller/dwc/pcie-designware-ep.c   | 205 +++++++++++++++++-
>  drivers/pci/endpoint/pci-epc-core.c           | 105 +++++++++
>  include/linux/dma/edma.h                      |  14 ++
>  include/linux/pci-ep-dma.h                    | 170 +++++++++++++++
>  include/linux/pci-epc.h                       |  62 ++++++
>  7 files changed, 640 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/pci-ep-dma.h
>
> base-commit: 9a4cdc958dd79fc6c3b20b51a10debec6ca09fec
> --
> 2.51.0
>
