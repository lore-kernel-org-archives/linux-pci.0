Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E3330B36;
	Mon, 16 Feb 2026 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259092; cv=fail; b=XREzrmo9lUhubyMsUZ/uNz9W2CdWhZ2ooOYCD/ybqRBzd8d8/iX4UHt7xh+UUb0jr0JjXF0JluillZI+5SE9Qu7Bo3SP0ci8W++EltKGEGVgIzgFYdVhzciG0zGaX7sIoxDtg1W8WlP7VRfQf2j2dcNegyhNFsfdkRZ+prfa3VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259092; c=relaxed/simple;
	bh=d4DEZtX7E+8b+3zU+/zafq6p8oKeE8ShCBk2XeNQuRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BMFTnLOdC2Lwsff5KKR8rcdPgJiEjOLVsUtyNkgY8rkw/pklER3jpiGsbk4Mi5+nhoK1d8dgQAG9X/aymNFQ9CXNvipqisj5M+jcXTXqJXekZ48CbKG/My0z1eXzUipzmSFBCvN/g0pYkcH9Li6iTp5AL1VjO3KCLgYTwEFmVus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RehVBVvS; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RehVBVvS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwgBfRo3D10A7VrFjbWyyf67Do6AVs8pOILc8vCNjb316pfDIpkTf7yJMgeB3ijW28mpBoOynzuzCTlxM8BMX4dCORz0Yqhmftyy7P2rY+FIsuFPTOzjmKgaEpwYMt0E7wyMkYOhcRb4S1kWcOoUOygyjTEjtDxyw2yDslUr5IfNyRwS25WCnLyJ4PPNNR8Ol2D5Snz19d7dpTYczxb7kSShg8FfwJEr8N5/MqvBNnlF0O5IyBVMNRCaoZDIUBGGBvBl8dIz9w4em7iqb7WUlgN3EqZ8TahdEX/VV0TI6rzkwnXhP7OI3Ale3DfKjcF9g1MP7OgqN/4rplJK7tIYAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ngn9tF5nJ5mpLxM+lcLQmmhrtR/2eJ5Wpj4akTrxygo=;
 b=CAZsj4AczE9Sc0mWMdiphhzMYKGgQ/iQ+OwkLeSgJNkAXKcwgiOPTpkue6OU4vNubvvAcjO9beBrSzjhW8GzRnuvv2VsnIG8vPnmMwg3y1M/C7JSp3uvP/KW6/MEZRX0D7VxjbI+g//3lyjvS86jORzc4vNjEDEt/gASS9tbY9uQVTFK3v8mhZWvgnGsQJ/fBo831y98w92kClvfuqcwwnnvFvtwoVVtgpII8YjfZxY94XOS5yWn7+g833sL6+je1mhGHDCiO3KpD0dcoaaUf0OiCz+uIb/N4mwHncLRf6ha0pQYn73vjYGBxEt17LlLgevec4MYIu3aL2iHaqZ5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ngn9tF5nJ5mpLxM+lcLQmmhrtR/2eJ5Wpj4akTrxygo=;
 b=RehVBVvSUxLw0YNU/8Gurp0mvXVorbQJ3fPw+HbteQ63orcnN03G1IhEliDQt8IYYK7NDCTEUNpSOmzARvGg6mVz747qgIVgAi9gJqYbWxeeS0h+pfFZFrnDms/50hUo/fggDHkTmwsHgarypKtvOU/3wxJIhSy8qDnACg/y1hCy9NAqgDOqIbiz1OiNdyWseBlk/ixFi2xpGuGHofwVRP6r7TUzj0B6ZXKx5G4X1cLNVetbPmthYTKQFEOI6S7LsgvHPOvZBsVuGywFhKadwfZWU7rm9I9qOtDM3DFj4Gqp+7vdzGtMXiwxGbrQAQTaiAoGHQwomK1qWEU5vMo7Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB12237.eurprd04.prod.outlook.com (2603:10a6:150:2c6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 16:24:46 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 16:24:46 +0000
Date: Mon, 16 Feb 2026 11:24:38 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, kishon@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, cassel@kernel.org,
	shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 9/9] PCI: endpoint: pci-ep-msi: Add embedded eDMA
 doorbell fallback
Message-ID: <aZNExmCvCgJ470z8@lizhi-Precision-Tower-5810>
References: <20260215163847.3522572-1-den@valinux.co.jp>
 <20260215163847.3522572-10-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215163847.3522572-10-den@valinux.co.jp>
X-ClientProxiedBy: PH8P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::7) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB12237:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff86745-acb3-4158-0455-08de6d77e641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7EcjDmU8XjRvi9pBp6Idmb4uBIR2IPgB7JgDl6eVefqrW0tT5rXYBdSyiiUt?=
 =?us-ascii?Q?18R1fIBZoUVCn7K0gsZG9XUlKKlbtxmGDVw0VixSQVvj0K5cNHkThgt+yYB4?=
 =?us-ascii?Q?IJHue97Sm5bjU6FgQcqP2AeT46x6tYkZPRGePDsfVHwY9wVVhIo03LHxnl6j?=
 =?us-ascii?Q?vAQ/zZZ/SQtpVKhPJokNTIlOjclntmA35HlNc1sJEvFODV290fcN3LScMUqn?=
 =?us-ascii?Q?AuRz9GPvh7aCPa8uMxoRZt8QvInPqvOZn3lsTYzwFCY2NemdukxQl0EtgglB?=
 =?us-ascii?Q?oED23lCAEGRk6ZAC3Z/YcgTNXayzWMnTs15NwjeS99vhqpOiWDQi5Vm39U8R?=
 =?us-ascii?Q?fO+oBS5awyVP6TdA64MpMGDSA5avI1KGOawfjPFYnMoWTF596saDIfF1fHl6?=
 =?us-ascii?Q?5CMhM8zlIyMJw+0TFF7a1/wDuOunYN9IBqVGL8QDhzbsHIjbLk3OACHwqqcg?=
 =?us-ascii?Q?MNf+cv3fHxyvVpQid5Z6VvB/pmLQdPLg1mcen01BpuMMn0UPgHufxVr575GG?=
 =?us-ascii?Q?CPT1MNcUivcHTJjKaNeeRGx28AJj1LM7n7TjnHJEYYophrSV2FprumfrvEJC?=
 =?us-ascii?Q?SpfJbDG0cl3MgybPYNHOisP21k4tCiywTe5l9k0FKVxkulz+xZhZRbMllTY9?=
 =?us-ascii?Q?DhcxDm1uyWiB9WTOK7BL4FwOlLdTGqbXg7okkIoox/eTEfB9rTXXKZY7023F?=
 =?us-ascii?Q?pvvvYMab6CVWXZbDsgn5npIkVADuXkjWYyPsR9gibPkyCcgcNWOUGYkBnQoy?=
 =?us-ascii?Q?161WGxubUOYXwSgdQva9gXlvZOuCJGyFle5cDpoUMoEttyVWCiU2dm+2k45i?=
 =?us-ascii?Q?GU/CjFBsZPfusVaiZayf1jRgsJjbuJUZCa9OfMuMxKKVd+oeVxE3NYkDZBRe?=
 =?us-ascii?Q?m/YCT6loeY7V/xtLCcWtSTm+61vBAGvCZKaiiGTo+sSkVW07bMTy+l2MjrF5?=
 =?us-ascii?Q?ys7+tev5xd5yOTKe9kJorE9/iMl1pZFbE4rvFujynH8onnGeb0TtK5l79t6N?=
 =?us-ascii?Q?SZJ5M+DpFvZ2Gef4yQ2zPHXVLd6dmsiJnwS4cRXQPNYmcA/o36ylnQj4Yt3C?=
 =?us-ascii?Q?jtb3sk8xSzvqzn6hMeT9MftWT9Xwjulcs6NPumVPUcc+ehJpxqsz8bkrUUZW?=
 =?us-ascii?Q?wBVH0EcY/kN35gApj5Ng74cB+AWepQp3IvgtHR/Kl80qZUfxyrOPqFyS/+Gj?=
 =?us-ascii?Q?FxAvUrZelElBUgMMG8dEC4Bll7G8dGVQQs7o+t/oEJVLbV1nIIEJqbfRGmNs?=
 =?us-ascii?Q?EQzTRB/nHKAe9IWzMWoJL+/BBeT77rRj+5QVKMmcrSC0frEGKXGcaBjr7T1/?=
 =?us-ascii?Q?yrW14zCBZXFi1IQg1fLIRj67v4yGNueh/rdn32Z80OL6m8qeSz97ouLee8p9?=
 =?us-ascii?Q?nvRAZ4UpRHA9I6ujbd85RoPdZx3Y/kcvvG1Du7JNtgR5VP99IhUym2oLX2bZ?=
 =?us-ascii?Q?CI9wAfbWC/A29+8GCDJ6/T5anQFLg/KcMFWyPUqoRhxOQ6Mvp+lj/jw12b/o?=
 =?us-ascii?Q?4zrPLAgz/pggTYMML92J9g4qmEPPMZjQB6wpj8Ck119NjUN+mPHn+vJb62ob?=
 =?us-ascii?Q?Vic2eZ+ASSKohY+CscZdk7FfxvRRFcBIpb40641g2c1JeTacZVLjuDDycTdv?=
 =?us-ascii?Q?iPv4qqbkhi4zxZ0nc54kWQU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vX7JSiBLYRCAoEyPtmQcMYgnlhlwjB4FZk4LGFQ4wioj8WxtckzWa6/sYFhX?=
 =?us-ascii?Q?I9OSLsopzY637Yw2c5cXVl/gEKGrh1Fjiv+t/B1Ky4wDKSr3V+dOBtBEQoB6?=
 =?us-ascii?Q?L8FBRAUqO8K075disJLBtJA6HwbP7yAGP9oYSAGO4a1+zyPOGc1UhjR8ZWLU?=
 =?us-ascii?Q?6K7bE33FmjSVq020WpmdBEcxT/t9ymnEZH7pQAcJT/VSdUoOXxGEIePA5bsJ?=
 =?us-ascii?Q?r7TzdwOe8TQtEWpO7YXvM9U+4I5L40mCDhqvwBwJ4CE4r0MRdbsM/iqc4wZG?=
 =?us-ascii?Q?+ycMl38S/vT3FMSWTJn8o3rH1lEG/MznglZR0qdKuz2RefayBjPQwbRlof5y?=
 =?us-ascii?Q?QiwA80bmN3/1Zm26r0Fg3QPdsUvYHwVxoBCAkbUxxPq1s9W/fZsSkvUQtDcC?=
 =?us-ascii?Q?93rHSh4cN8wqH41cXndjBLIoCpptyvgmRm8UD1Zb+kewpN5ictlo/j2AH9HM?=
 =?us-ascii?Q?zVYwoqqJHy1lg3wF62PXxn2vuEg8t1gsdawq6x2lDguZ7DhmlPpEkxJ8lJoy?=
 =?us-ascii?Q?Z01BqiNo2x9lArf0ntmC+CqGXZG8yuUFXyWP1LNo5ahkAQ0hF1LV5WTw0Hzw?=
 =?us-ascii?Q?OS/iVhTfFVhiY6rXNA1bIJyfblx2GWG+Opc9jxeUttXvy46TOojpKAijP5xc?=
 =?us-ascii?Q?OyHPcug3t785n4h1j4K0AzD4tijxvdgUrULtq/XR7lcGPKvXwFcaALoOlmGf?=
 =?us-ascii?Q?OZqp8AC5xgpMTIL/qvOfK7scj6kXhP+wcNeUyeZOURAYOTb9zpWkwtz8zHPp?=
 =?us-ascii?Q?wWDRyxTWrz5tCWtB1D2ZicAJrKFo4sQFoJD98g7Z5MlaKfgWLKjctAeCMcno?=
 =?us-ascii?Q?aQN5EBHx/7KvgrBp96qMvGTllDd/ZOReI/ZpdR7ywfdYlGZiOdYsqDM3AKyV?=
 =?us-ascii?Q?tkhCyBZtCtRr6e5+JjCjGGWAvaSZ8G+7uEpoy7y0lbiMUMLJhtd/NmFvwHMk?=
 =?us-ascii?Q?E6SvU7gGMnPNLGpBph9gnSfK+b1k2G86kIquVd6N1tmM9NppNrhkEjxreCxL?=
 =?us-ascii?Q?W+4xYJV7jM1/3yKbPmqSI1ygX9G27nS74t99I8igAXe8itaOAXsVUTUdUY/2?=
 =?us-ascii?Q?hTt8sIaNkR30T/RQkriVP04qszp3tQFytK4gcxowZF9KKfn9A8Uk0GsnLRJS?=
 =?us-ascii?Q?OJ+a5mGfcwmrfBFTymIMasg6PDUI5/vmoK5pqne1U/UJ+X7Etlgmi5O3yb30?=
 =?us-ascii?Q?MTrkj8l9fd32cGB5ByM0Y4fGwmRD4Ez04RIRWf6tJ4If7IC6PRQE39ZdXhMQ?=
 =?us-ascii?Q?wTpudYo8hYL4f5LJ4IFR/Qwbpjrn+zIzJL/kEHIBlnOW0q+OGyuLz+GOesY6?=
 =?us-ascii?Q?J5gbVY3AYIsipbuTm4weVAy9tEaDyZke6lhgHh82tkJ0Abgx+nvnbhF57O2N?=
 =?us-ascii?Q?Sq97w7x+TXSyXkNva/XXVSAFiyLuVuVyUD3q0d1aeeMCQznlbk/2+C+HSJF7?=
 =?us-ascii?Q?fH/f5kshs4yo1VZuj95df3nAxBMmkkfRXyPeLStDtGEFCqZbtZgLPpxYD/bW?=
 =?us-ascii?Q?1EIZKK1Ij37cSjkpeAHmfNrLif5DKmfNxWIGQ78Tz6qYCRS0B34H9/MpGVvi?=
 =?us-ascii?Q?iH4c1sWq0pygCQTHlrQ7INnl1SwBbzZNzgNVIrXwS73UB7Aobf3VO+rC58Kh?=
 =?us-ascii?Q?3L8TeICcCyzqW5Xg/tImC0QOGnewQN/tI5Hv1DnQmZl26mh+bdnhZTzj2nnx?=
 =?us-ascii?Q?FLqP/Qzulyxj2wqJP5rExOm56W57XDYOSpX0uGzw7DmDtJU4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff86745-acb3-4158-0455-08de6d77e641
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 16:24:46.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxbSe6OfdUkoMNcfImiMjwivOBk4CBXpra+HSr9NI9rfCQyFAndZVFxsQNG0E5tURgJXSWvpslXFYVGW5obxXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12237

On Mon, Feb 16, 2026 at 01:38:47AM +0900, Koichiro Den wrote:
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
> the physical address so EPF drivers can map it into BAR space.
>
> When MSI doorbell allocation fails with -ENODEV,
> pci_epf_alloc_doorbell() falls back to this embedded backend.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/pci-ep-msi.c | 90 +++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> index a42f69ad24ad..6e1524c2d891 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -6,6 +6,7 @@
>   * Author: Frank Li <Frank.Li@nxp.com>
>   */
>
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
> @@ -36,6 +37,82 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	pci_epc_put(epc);
>  }
>
> +static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
> +{
> +	const struct pci_epc_aux_resource *doorbell = NULL;
> +	struct pci_epf_doorbell_msg *msg;
> +	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
> +	int count, ret, i;
> +	u64 addr;
> +
> +	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> +					  NULL, 0);
> +	if (count == -EOPNOTSUPP || count == 0)
> +		return -ENODEV;
> +	if (count < 0)
> +		return count;
> +
> +	struct pci_epc_aux_resource *res __free(kfree) =
> +				kcalloc(count, sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> +					res, count);
> +	if (ret == -EOPNOTSUPP || ret == 0)
> +		return -ENODEV;
> +	if (ret < 0)
> +		return ret;
> +
> +	count = ret;
> +
> +	for (i = 0; i < count; i++) {
> +		if (res[i].type == PCI_EPC_AUX_DOORBELL_MMIO) {
> +			if (doorbell) {
> +				dev_warn(dev,
> +					 "Duplicate DOORBELL_MMIO resource found\n");
> +				continue;
> +			}
> +			doorbell = &res[i];
> +		}
> +	}
> +	if (!doorbell)
> +		return -ENODEV;
> +
> +	msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	addr = doorbell->phys_addr;
> +
> +	/*
> +	 * Embedded doorbell backends (e.g. DesignWare eDMA interrupt emulation)
> +	 * typically provide a single IRQ and do not offer per-doorbell
> +	 * distinguishable address/data pairs. The EPC aux resource therefore
> +	 * exposes one DOORBELL_MMIO entry (u.db_mmio.irq).
> +	 *
> +	 * Still, pci_epf_alloc_doorbell() allows requesting multiple doorbells.
> +	 * For such backends we replicate the same address/data for each entry
> +	 * and mark the IRQ as shared (IRQF_SHARED). Consumers must treat them
> +	 * as equivalent "kick" doorbells.
> +	 */
> +	for (i = 0; i < num_db; i++) {
> +		msg[i].msg.address_lo = (u32)addr;
> +		msg[i].msg.address_hi = (u32)(addr >> 32);
> +		msg[i].msg.data = 0;
> +		msg[i].virq = doorbell->u.db_mmio.irq;
> +		msg[i].irq_flags = IRQF_SHARED;
> +		msg[i].type = PCI_EPF_DOORBELL_EMBEDDED;
> +		msg[i].bar = doorbell->bar;
> +		msg[i].offset = (doorbell->bar == NO_BAR) ? 0 : doorbell->bar_offset;
> +	}
> +
> +	epf->num_db = num_db;
> +	epf->db_msg = msg;
> +	return 0;
> +}
> +
>  static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
>  {
>  	struct pci_epf_doorbell_msg *msg;
> @@ -110,6 +187,19 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
>  	if (!ret)
>  		return 0;
>
> +	/*
> +	 * Fall back to embedded doorbell only when platform MSI is unavailable
> +	 * for this EPC.
> +	 */
> +	if (ret != -ENODEV)
> +		return ret;
> +
> +	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
> +	if (!ret) {
> +		dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
> +		return 0;
> +	}

here, needn't reverise logic, mostly we put err path in if branch.

	if (ret) {
		dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
		return ret;
	}

	dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
	return 0;

Frank
> +
>  	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
>  	return ret;
>  }
> --
> 2.51.0
>
