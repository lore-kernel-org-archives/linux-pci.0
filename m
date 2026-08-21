Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020072.outbound.protection.outlook.com [52.101.228.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351A376BE4;
	Fri, 21 Aug 2026 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326901; cv=fail; b=bTVt1DVewS3ei0kxMfGnslgN6IUeRajEJqZJDqw2BnD0Jqs/3oaWKgXrnm8KTxoGtd+XQ9WDB2pZ1FBS94dGpHohrtub8h6KNqo703GayHiO7zkTml2oLYrMT0+RS7X3PM/OIENGzDTNJmPGtiYzBos7/klsWOZ9KhpclTN9PEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326901; c=relaxed/simple;
	bh=BgfrShlqw9CVEv9Atfj4P3CXzrlosU8IUn4wOIr8d8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tyI9iA/KNJtX55H9IrnlOY9LS5dcBVSU/XYsoSM62XfvZOy8kwJztzKgxjiMVsBX/YR4ru4Tzg18FDDXsUvSYv7tRirQ/1DUm9+0lQkX71t8Eaqt6E2zwumn9wAxSkLJ5UKgKIEGE3/MzVvlE0m7IaMRpnAAWPZmT2EV9q52w1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=WjV5qSM0; arc=fail smtp.client-ip=52.101.228.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="WjV5qSM0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+fuiRfyEh+jyM/AwxhiktBnge2FezWRlTmnlsA4ssG6NK4M8sRfTP2T8WUCHvQb4P9fFA+DEoVf84L2/uTdryDkKzt9Ema4vugsVaS7XiJ6STa8TQ9ZXgQ8uNHP74WvJ7GQd8DQSsma6Usdiku53YoZMQunDqWSYq8AHaIMOJBjGvx69j9W7PwuuLrxGs3mAbujhpVV0qeNs6Tn9r3VMgZtYUj5Z5HoYaP0n6bUU4JiCwiP6dA17VXmYtwnzFjSe1BmQeoK0iiLkxpHsimQktEQLBsDsBHNUehszu9TEDyXToxaNRJFCYmoURd1bNNhgajpUtyfqesqhZnYZH680w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJCzAZujmKb8GTdnhpJGm+NE0U03JZGP+P7ySraqJA8=;
 b=HUU02VdDJMzKv742aNJ/eGKLqeF16QdTm5WNUUIYV3MwMROv3b5DA5zOZewlcVqDgFLvi73HtqaTQzcsO826LTej6+K4XiNU2iQHpGOcElTaNpR2B/ohuGNRLGEh/ZitDmT+Rf/HPMDpSDtNinGHAJ+Hd2/0wNjNJiCPHhjHpbT7nQwQOFo0GWourJnWclTUAXtPtkw1EyH9QctLC5GuDC2Ce6JPZoB6Sl2LLRzIHpBt/9V8A5bYWPAg7K9DGU0vQjWQY/AmMiEAQB7jGzMz2gl1ld+33niMgZxF/7zhb4YJVnjCBf0H1PMoJeEQ1GMsbaq1ZMebqAE+rw/nmSbMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJCzAZujmKb8GTdnhpJGm+NE0U03JZGP+P7ySraqJA8=;
 b=WjV5qSM0HEzDtpnWIk0yHh9tO2AaXWepKQ+6GLp8qtRkuEypkA6OBUqX89Av42ofjGjfedZ5/IAuJYB4CtxAKONgVddTpULuqV7DNGhXYg4QWaBCLW+GfkhcVrR2xVhgNVLSvrMOH7JCJbDG9N4SBe6pAk5ydDnSkCFeTf6SK5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6987.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:41:33 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 15:41:33 +0000
Date: Sat, 22 Aug 2026 00:41:32 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/15] PCI: endpoint: Add pci-ep-dma helper for exported
 DMA ABI v1
Message-ID: <3ef3b7wdwpf364teperxcjc2leycxwke77cejjfzd5w4pnbmik@vlcbizvbxv4m>
References: <20260312165005.1148676-1-den@valinux.co.jp>
 <20260312165005.1148676-10-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312165005.1148676-10-den@valinux.co.jp>
X-ClientProxiedBy: TYCP286CA0280.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1220a0-019c-4c51-5aa4-08deff9aad84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	OaHFMc3jbTsAZP3wS5fNhJgjB07DFk3RwHWpjQW5/2j8Eido+5oenoTEHwLBR9ADH2HDqxz6cCIzzWslXdrNpg9v7zu9HEWmVtS5YpmpuMoK7tsWvPDl79arSkpRhfLsVWY26mj0jipfARRnGbDElgU8v3P6J4P6BgOkrjPPG0BM8/a+Jj7rbRhxkPoTu/qHmMQlgDslZIJCPN5n9dEHad6Ta64cTdRzq3upxuJ/iMDaesxWSVZPqV9vWQ1acN334bqiCriBtuebmk2NnEkXhictCUsuZRnSTzXbZa/SQeDKtvCuTlxTcxIsg3cJY7mwtYG8wKIyxcD3JPbwJkiKQ/ik+UU6BO/2I47JBFypzj1BM4sRmIf6oT+BMdDGO8Lxmo5fsSISwoT3hE9AVql5PEU0dreQvZGxaGFdOYQ/n9ECirYfcSCENwher0LZHYpN3ONN6tNl0ttjFLyA8gICJ8uZ55jWdVZP0iTJ9ulvUHD+o3yp8QZcZFfBy76Si+a+67gAZx8piym/RlnJS6NbnOFI/OYtUEEKlPkHo57PMlduQPJeuBNpHz9FnuQKutMe8q0i9oS44r4uwN5wRzdQzktZBZ0TuVDp/Ql2UteKFjQhvn800fZwVNHFIwVnqVhIlyu0yL4jk0+frBG0D3QbvryMCSmgiq7wXFIH35PGDUY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RibrAxeiaNN+48k2T7cGOvnLuwGaHjIyCD7pXfvWSAKOTZrEYOnue6e4Mdjp?=
 =?us-ascii?Q?FWIcysY5umLAjEw/zFk0yq7nwLqMmzepviQo54BQKiBbXJU+ASqoQy370NGb?=
 =?us-ascii?Q?qOH9XeX9IJzK4Yzm9oT3lC5r703otnxsKFvS/0mQAyv9ueI9LJp2R0H3bbLB?=
 =?us-ascii?Q?4jRW3cpTGyErg/sEkzaylgx3PXhBMoQQRL+IgEOpIHsWMUeVaylFYVEt0wxA?=
 =?us-ascii?Q?d3CFbl1J5/H0CaG8Tkj4YrRdzpK2akadW+bWB+BjCAvlzd5VrgCe49TSyENp?=
 =?us-ascii?Q?qRBZJX0fEUUNucqwL7u57c+BtGIPGjLcck95T3MmpsOQDj9YjOYPVpdPg9jt?=
 =?us-ascii?Q?lWOCBcRNo8gf/IoRuviPmQaf67kl7ETU5GaTN47FLWZv2FAuDakNcd8T9s6z?=
 =?us-ascii?Q?UeSNtNUWnaQh4D0ZqzeGvOYe8ZoknqHbOgvFj01wL23dZ80g3HBXTDr7m435?=
 =?us-ascii?Q?p8Q9WfSZdlEMUK9okcSiTkp3m43zkDYCLdSD0jAWq17KhX1p53rHwb6lwLsX?=
 =?us-ascii?Q?Kgp9tx39UM2zc1NprrS4+gL7FKdUrZMNW/pvhPQobnXLWT1T7EPA4WavG0Wf?=
 =?us-ascii?Q?a44NMUCtAxfBif2wb3IGZNcpnHQ9SgCd9sErrgseEzzPKSxzpDtkdtgi3R9S?=
 =?us-ascii?Q?0S5AfP66fWDPPBBaiP6aojwwIMpp7h3slYKdw6zAQO2rDMyMDT+iikRAdilX?=
 =?us-ascii?Q?htlDi0g0Act5R8hwVvPa1XjmnsfPTbG9Ylu4C5xwqxmyMi7gBKyIWvxW+Enn?=
 =?us-ascii?Q?KP6bFzHf/6R68asQJAdAZ+oAa0la3w5LKohHGwkU2FvMIutpQEtQGR9nnEE9?=
 =?us-ascii?Q?Jdm960GewYilH8EVZ4CnrBENTZ0B5/IZmU2u25n4teKultU8EfsUb/N18C+4?=
 =?us-ascii?Q?l837J/6eb+OKJ4VKYUMmV2Yp4A3LnApt60nsE84x/kchq26sjOi8BVmu/4wr?=
 =?us-ascii?Q?HGHB/+Wy61Tv4uddq0708Hh5cx+IJSD5Z4dTv6VYp+sxB/evm6kuNb6C26D5?=
 =?us-ascii?Q?4Ip+7DU3Z0CGaFgPWjC7CQVCYBxg93O5kjKqJW5l3m6xH/10y65rVkaroP3j?=
 =?us-ascii?Q?Xamw+sjgeXf+H/hw+tV26DnjB9iER8X2m8ApfhTb8fl7+c/BwGcBLgJgJJFl?=
 =?us-ascii?Q?Q4p0MxIqjaWK43MoOBYsNB+8ZYe/Anu9M2kQoa0mKVIS6+A51yqf0ypNqqxX?=
 =?us-ascii?Q?TOF9bmHjhKXhBtqHbWHVtSWejpbUSsILoJN7J+ImrQAMna+wUft7/lug5y/o?=
 =?us-ascii?Q?pTwvdyyy5kQTEVCgXGB5LKWwcGbfqvnQtbeaLJ4WPjXd9BN3maIRTI3XRdFG?=
 =?us-ascii?Q?GrzbuWUeBSdr7kc/aK7XnNcSLqCx4J2p0TtFnfvBpVRo397C4eY6NjOb67IJ?=
 =?us-ascii?Q?Z4PGnOo3QYPWCkSeTaB+Np+RmalfUwcNe/kG8nJi8+VwbDwIR0EnrpBekRAi?=
 =?us-ascii?Q?1IB9UK6KkXJUQLAVfTOU9375OtXnijsWOETkkruPEKWzDmS8Ps6TdEIYjmED?=
 =?us-ascii?Q?z7Y5Izyqdq0NV8ewKIX3dCrwjJqXnMI8Z2A7o7ubCnpY59nwGhj5ESGNTThk?=
 =?us-ascii?Q?QS3YZD036/f7YPs302mX3RiLBAJwZYEjxnQdvplhNH68iglRpXveG6HQnZee?=
 =?us-ascii?Q?FNYrul68O3jTsTMd/Cy+PlF+YWhoqsBTg3OenSl3Q+DqHYspdn7ZAZRO+SvN?=
 =?us-ascii?Q?PM5L9E7QRL0Ne69qQXq5npvIWUS+5KTU+VCAwAgzBeWEfhoc6ftXO6YRMqqM?=
 =?us-ascii?Q?jKNLXKQHXZXFjaUidH6jCDr5Sb4gruyprqHoxRB/SSW7tDDqVTG9?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1220a0-019c-4c51-5aa4-08deff9aad84
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:41:33.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOXppswFYCGtx3POYmxwTIb2vJqIT0DsFuBJXS2UbNY+5a855VTFny1oYimg1FIT0b4k0wneb2aMdA9JXbg6Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6987

On Fri, Mar 13, 2026 at 01:49:59AM +0900, Koichiro Den wrote:
> Add a generic helper that packages controller-owned DMA resources into a
> peer-visible BAR slice described by exported DMA ABI v1.
> 
> pci_epf_alloc_dma() queries EPC auxiliary resources, delegates the
> requested DMA read channels, builds an ABI header in coherent memory,
> and assembles the BAR region list covering the header, controller
> register window, and per-channel descriptor windows. If the controller
> control window is not already BAR-backed, map it into the exported slice
> so the peer still sees a self-contained layout.
> 
> The first ABI is designed based on the DesignWare unrolled eDMA model,
> but it is intended to be vendor-neutral. It exports delegated READ
> channels only, which are the channels the host uses to send data from
> host memory into the endpoint.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/Makefile     |   2 +-
>  drivers/pci/endpoint/pci-ep-dma.c | 342 ++++++++++++++++++++++++++++++
>  include/linux/pci-ep-dma.h        | 130 ++++++++++++
>  3 files changed, 473 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/endpoint/pci-ep-dma.c
>  create mode 100644 include/linux/pci-ep-dma.h
> 
> diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
> index b4869d52053a..94824f3ed5a1 100644
> --- a/drivers/pci/endpoint/Makefile
> +++ b/drivers/pci/endpoint/Makefile
> @@ -5,5 +5,5 @@
>  
>  obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
>  obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
> -					   pci-epc-mem.o functions/
> +					   pci-epc-mem.o pci-ep-dma.o functions/
>  obj-$(CONFIG_PCI_ENDPOINT_MSI_DOORBELL)	+= pci-ep-msi.o
> diff --git a/drivers/pci/endpoint/pci-ep-dma.c b/drivers/pci/endpoint/pci-ep-dma.c
> new file mode 100644
> index 000000000000..2a996f9b1424
> --- /dev/null
> +++ b/drivers/pci/endpoint/pci-ep-dma.c

---[snip]---

> diff --git a/include/linux/pci-ep-dma.h b/include/linux/pci-ep-dma.h
> new file mode 100644
> index 000000000000..0ef6f9eb8593
> --- /dev/null
> +++ b/include/linux/pci-ep-dma.h

Hi Mani, (Cc: Frank, Niklas)

Perhaps it's time to reincarnate this series, with much of it reworked.

Following the discussion here:
https://lore.kernel.org/r/fg7cma2ccvdgjgcref7qa4q7ocvvume5dteekedikszebkq7rd@uhrjfp3nmmwh/
I am now thinking of dropping the generic pci-ep-dma helper and
include/linux/pci-ep-dma.h altogether, as I understand the direction is to keep
the DMA export within the vNTB/ntb_hw_epf path *as much as possible*.

The old wire layout was consumed by pci-epf-vntb.c, ntb_hw_epf.c, and
dw-edma-aux.c (see patch 13). That is why I put pci-ep-dma.h under
include/linux/. For the rework, I am thinking ntb_hw_epf should decode it and
pass only the resulting resources to dw-edma-aux. This keeps the wire format
between pci-epf-vntb and ntb_hw_epf. At that point, defining the same small
layout in both files might even be preferable to adding another shared header in
include/linux/.

Mani, does this direction look acceptable to you? I would also appreciate your
view on the linked discussion when you have a chance.

Best regards,
Koichiro

> @@ -0,0 +1,130 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Generic exported DMA helper for PCI endpoint functions
> + */
> +
> +#ifndef __LINUX_PCI_EP_DMA_H
> +#define __LINUX_PCI_EP_DMA_H
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/pci-epf.h>
> +
> +#define PCI_EP_DMA_MAGIC	0x4d445045 /* "EPDM" */
> +#define PCI_EP_DMA_MAX_CHANS	8
> +#define PCI_EP_DMA_MAX_REGIONS	(2 + PCI_EP_DMA_MAX_CHANS)
> +
> +enum pci_ep_dma_abi {
> +	PCI_EP_DMA_ABI_NONE = 0,
> +	PCI_EP_DMA_ABI_V1 = 1,
> +};
> +
> +/**
> + * struct pci_ep_dma_locator - peer-visible location of an exported DMA slice
> + * @abi: exported-DMA ABI identifier from &enum pci_ep_dma_abi
> + * @bar: BAR number that carries the exported slice
> + * @flags: ABI-specific locator flags, reserved for future use in v1
> + * @offset: BAR-relative start offset of the exported slice
> + * @size: total size of the exported slice in bytes
> + */
> +struct pci_ep_dma_locator {
> +	u8 abi;
> +	u8 bar;
> +	u16 flags;
> +	u32 offset;
> +	u32 size;
> +};
> +
> +/**
> + * struct pci_ep_dma_region - one physical region mapped into the exported slice
> + * @offset: BAR-relative start offset of the region within the exported slice
> + * @phys_addr: DMA address to program into the EPC BAR mapping
> + * @size: mapped size in bytes
> + */
> +struct pci_ep_dma_region {
> +	u32 offset;
> +	dma_addr_t phys_addr;
> +	size_t size;
> +};
> +
> +/**
> + * struct pci_ep_dma_chan_info - per-channel descriptor metadata in ABI v1
> + * @desc_bar: BAR number that exposes the descriptor window
> + * @desc_offset: BAR-relative start offset of the descriptor window
> + * @desc_size: descriptor window size in bytes
> + * @desc_phys_addr: physical/DMA address used for the EPC-side BAR mapping
> + */
> +struct pci_ep_dma_chan_info {
> +	__le32 desc_bar;
> +	__le32 desc_offset;
> +	__le32 desc_size;
> +	__le64 desc_phys_addr;
> +};
> +
> +/**
> + * struct pci_ep_dma_hdr_v1 - exported DMA header format, version 1
> + * @magic: fixed signature, must be %PCI_EP_DMA_MAGIC
> + * @version: header version, must be 1 for this structure
> + * @hdr_size: size of the populated header structure in bytes
> + * @total_size: total exported-slice size starting at &struct pci_ep_dma_locator.offset
> + * @ctrl_bar: BAR that exposes the live DMA control registers
> + * @ctrl_offset: BAR-relative start offset of the control-register window
> + * @ctrl_size: size of the control-register window in bytes
> + * @irq_count: number of IRQ vectors reserved for the exported DMA provider
> + * @num_chans: number of valid entries in @chans
> + * @chans: per-channel descriptor metadata
> + *
> + * Exported DMA ABI v1 lays out the peer-visible slice as:
> + *
> + *   [header][controller window?][descriptor window 0]...[descriptor window N]
> + *
> + * The controller window is optional in that slice. When the live register
> + * block is already exposed through another BAR, @ctrl_bar/@ctrl_offset point at
> + * that BAR directly and no controller subrange is embedded in the exported
> + * slice.
> + *
> + * @chans[] describes a dense prefix of the remote hardware READ-channel
> + * space, ordered by remote hardware READ-channel index starting at 0. A
> + * consumer may map @chans[i] directly to remote READ channel i.
> + */
> +struct pci_ep_dma_hdr_v1 {
> +	__le32 magic;
> +	__le16 version;
> +	__le16 hdr_size;
> +	__le32 total_size;
> +	__le32 ctrl_bar;
> +	__le32 ctrl_offset;
> +	__le32 ctrl_size;
> +	__le32 irq_count;
> +	__le32 num_chans;
> +	struct pci_ep_dma_chan_info chans[PCI_EP_DMA_MAX_CHANS];
> +};
> +
> +struct pci_ep_dma {
> +	struct pci_epf *epf;
> +	enum pci_barno bar;
> +	void *hdr_virt;
> +	dma_addr_t hdr_phys;
> +	size_t hdr_alloc_size;
> +	struct pci_ep_dma_locator loc;
> +	unsigned int num_regions;
> +	u32 num_chans;
> +	struct pci_ep_dma_region regions[PCI_EP_DMA_MAX_REGIONS];
> +	dma_addr_t ctrl_map_addr;
> +	size_t ctrl_map_size;
> +	int delegated_chan_ids[PCI_EP_DMA_MAX_CHANS];
> +	u8 delegated_num_chans;
> +};
> +
> +struct pci_ep_dma *pci_epf_alloc_dma(struct pci_epf *epf, enum pci_barno bar,
> +				     u32 offset, u32 req_chans);
> +void pci_epf_free_dma(struct pci_ep_dma *dma);
> +
> +const struct pci_ep_dma_locator *
> +pci_epf_get_dma_locator(const struct pci_ep_dma *dma);
> +
> +unsigned int pci_epf_get_dma_region_count(const struct pci_ep_dma *dma);
> +
> +const struct pci_ep_dma_region *
> +pci_epf_get_dma_regions(const struct pci_ep_dma *dma);
> +
> +#endif /* __LINUX_PCI_EP_DMA_H */
> -- 
> 2.51.0
> 
