Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DED46C4C8;
	Thu, 27 Aug 2026 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858653; cv=fail; b=Bui9l+FxLUjYizphRq7/pGoUw+pkICmMKKE6Mw8TnY7vvF4qgclCH5o89qAakifQkIUgf1+bOuGSpn7KHvMxk87WskCUWrnqAwmIJStXZmZ10raEu7ahxX7kQ8qN2QNrL1ewOjx9NXJyq37/6yofO/5XasDegvZO771tuxj0cwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858653; c=relaxed/simple;
	bh=E1sF1sf+aa8MC3sl0rKvYIftOuDCkxo4O2GxP1AMZ8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B/tFNOGZPbQxiKPCoI43+iWGo28ZUfdgbFvmxFTS7803WoFeUPmHCMiBwePFgpoIHHvzBkBT6TGsifcPAk+01jERvXAOWWPbcO7TJnep7aOKmPHewCVZvnfPbMzkRezfcfRIOi7kwM2rOL0OW1Jp8+8ZDWWA19I7Xq371+tRoKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fzcTHySg; arc=fail smtp.client-ip=52.101.70.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fzcTHySg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfadOrGR1KxacE/jFRiTnvftxglpsl3TH2kzVWr2FAFGkzi3dEoIXEkwFVfzvhbpoRO7qUycAehwzxiB55wdJVwUmnIMgPYyUaggK6PwkSk+BQ9aTLfWNQ52qB9C8oX3qXI0Rhl78JhWeCJ9htK/Qgrqxjhcy2jQnrEvH225bV4qkm0s2UPGhngBekBCjGw13pmnrW6J4eycqmBAUR1iyVQ6rEbuWMC3zI/JygEH8e2KMRGyDz8K9ZFvDYdjot3y9xIzvW/x7mss+lsVdPs/CMWfKSfQyKKO3sBM/CP4QGhJgwonUo6Ry0MfUQFY7jWkJG2WWies2QI10JprhPlktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2udzpdgAe7uPvAfHTCsWfnzTvUPTkNUrpMKtgrojuw=;
 b=P5JIaLYHF9Jq6TdeauVPY0hIBffO6/6PjyxoSNdCbW/zjLPuE2WZxAPFFn8TPtFSuwNrIxTokLbSETVXGObfwGGb6/8MThmI4CxXtqD1qLwSnAqjVvMI0xC85YU1aBdaIVvxFhr4P92aHkagTbwBJtxAGtUEa3pl8lPa9kxb35QMs+oRgfo8gHyIrylvaaKTLTRkOndbmL2DqLvnrTUJAa23m2OfCyM2SNiY56IilaXcaIDD761b2z+dirnNW1vE6KfjP1+3mARg8K94IoplLrNgIUXT/9dHQ/lY0dFQQi2/bXjm0qWZM1etVxNdrO1edm3jLJSauCeR6QPqtsdo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2udzpdgAe7uPvAfHTCsWfnzTvUPTkNUrpMKtgrojuw=;
 b=fzcTHySgg+vj37UdEMO4oB6P9lkBDei7L2N24GCp6ux7gdkaZXKVWuU9mlXLadZysqbRL/3Kr40XAXtpy8j42vgn8TmiMzMnbNqhWhAqChyeo62uFxAXJ8XX92yxEMchVeU+R/nccinuNE2LIBU+g0ykXBBPUPHn63V+R7VRCDdUibg9KvxOMoUz0rmgY4QC/iuHZ1lB42WwjYx9whnEcEw56h+xEq9D6WqdW5hgBXPfVgHKkymuHYzxf0/yvLx1WXCY5vMg1XI1cIXdRtUVJhHr4n9N74yFFZ8S0tbLm16uBGvYo2MzC8NvFh/OF5jTSuukNMcakd2goUEGgLq6Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA3PR04MB11203.eurprd04.prod.outlook.com (2603:10a6:102:4ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 19:24:01 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 19:24:01 +0000
Date: Thu, 27 Aug 2026 14:23:49 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Aksh Garg <a-garg7@ti.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	ntb@lists.linux.dev, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Message-ID: <apCOxer4VJpkeKVf@SMW015318>
References: <20260827182012.1984960-1-den@valinux.co.jp>
 <20260827182012.1984960-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827182012.1984960-4-den@valinux.co.jp>
X-ClientProxiedBy: SA9PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:806:6e::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA3PR04MB11203:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf78294-2ace-425f-6aa6-08df0470bfae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|19092799006|366016|6133799003|10067099003|56012099006|11063799006|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QLEKbIr7ua18CaDkdKRMbHUNbDp4bDKuX11XBMwm9kI5fFK8xkXoNvXz2gIVb+mlEsKXm4YhO6Mu+cgztcz4u/ncKtDvpKnj27cGwgUfJ7vkeDgpWbof0K9FgNBpLI+qsIeYrsdFHgzRImm9ndwRPSJBux6cqDxLc7sOU6AhUzusshoCbjKo8ngJo2FGRw5B4e0ysxr2PJY4oomveMUajAmvmhX46wwO+vCFe0KNkG20teSylPOzt3YrTggerwdFC9OD9XZQ2qpcXH5CJopZFSwQEP0RwyJv8OQwYbEVZxxiT7aPpPGpHkaojir4q7CowyOuvxDw0qfoVmPOaFyMAWdygrpKiOeCMA5+upiO57L0DlHeug8GRgZcgDIOkV2u7uDc66dneLBwfcdjTd1kJX3Yizcy2BkmgL1l5U10PZe6QkszyUt7ocGLGSwqxeGtWE1O6F3QKFElVPmPbqtditjLtT3bZeMPj0k12yq1Hdoo97/xJ7hJbNUw5XXU57Q3HJIImRp2nRMhEdAG2RemIG9vzxAw8nuY1wueNDRWCbY25ef3bPL9flCeMYjSsI7JGO4EnmgWp0m1hdjoemHGdqsuiWKILmPQThCgB/ED5euW2shJEg4zaWHMHVpPG+pDWjTZS1R37AyWyzzE/7HUFqgAARJXb9ZT3lygwJnEdGE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(19092799006)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LSrw77cTu3CVMD9ROBbuAUK0AmiTCsnHHJxld44yJM9Dam7yF3t5stDN2cA9?=
 =?us-ascii?Q?1Jg6RcSXiP3uaiHHJVlQXROEqIO7uEwOilxM3tDbBGXXrRNsSINa2wmy1ouF?=
 =?us-ascii?Q?Th8OqLnO9DGJUXmIZjlbjkRQCE9RGRxBM/rnbfpIihRxEWt371mPl/6VMqhX?=
 =?us-ascii?Q?2qGTddAe038CF/SFx4NcRHsBazi/2peDIGXZSCke61hTIPom3Ai+LVFRd5nm?=
 =?us-ascii?Q?br9WdsCYWZ7QIVlHaEUQktH/JVb0zgQP9l2lFiHa/VPpy7C7cU3AoD9mGmz9?=
 =?us-ascii?Q?KRwWUUPCIlwvbMsMJPW5nx/F8M/iyprAqV8wYd1a9wLqRS4OZTnLe0Kjwd7G?=
 =?us-ascii?Q?+sB6fKoumBiGWBW/DJwBg8bRc0xmgFe1dSaFhonJFrjb3RlonPxCyDn/krzg?=
 =?us-ascii?Q?1nGWOCsCRMQJnDj8Mg0dp3L++xcGzqD1XhBxavLWnJkQRoTT2qxFCrSk580I?=
 =?us-ascii?Q?6Ld4KfGMGGzObelt0/qfiAxJer+lZ45GYXXNyTdpjS+ktRIb0lc7y6pVpy3G?=
 =?us-ascii?Q?u6Vig6jiADB/F+6SjOvHnWTjZjafEdCPTjYEXxTivQmWbRw40kyHK/0dsc3X?=
 =?us-ascii?Q?1ApT9PUdn3WOIctSPYyTc66aBQYZHvH6h+qlUfkp31Bn3oFM6wSZvkQfXUen?=
 =?us-ascii?Q?M8oL01JCtuoNudbAwWGSXOYCggScIJ6sT8DibmywyhNi+SfiVLdeVlbereD3?=
 =?us-ascii?Q?os9XRoQnbVAa/22lgMNiByEHpG32P4WlGMVC7lg1W8/E5ukicXCykN4+Hs7W?=
 =?us-ascii?Q?p0mKgmNM2Gg+grPmctPQfjQmALxn5SaG3RgPFhi2yuVGJnOiIPOFu3mTnwYA?=
 =?us-ascii?Q?WD9U/Kvys0ZsK7vs0YkPooxAclCKAtL7jTCX0umn1cVl+N7cBeNhrObcaISV?=
 =?us-ascii?Q?fTqhilTGtSKOV6HcKP7abbH7QlJ2lQDkOX3phH5TPRvHGPLs2xIlzQGNGK9Y?=
 =?us-ascii?Q?OqwiqCs6/JUZB6zKlPtJBJEvABAr7XOIJTVU/KKW7Useh6BGd1EnfNr1+8ww?=
 =?us-ascii?Q?9WHmS8DfkGbgxJxkIx3PGogLa8SBh3QYi6HYKf61zC/EdYrn7R/v4tgojBlc?=
 =?us-ascii?Q?aGuHzk9vSK6TuHVb7dXwVybR3V1LDh2B0acN2SpohuL8Whda4pfLOyozlY5b?=
 =?us-ascii?Q?hwqh+Mx0WGV7fbjb5JAAx2UaLPr3cjSNqmZ73+KHLiJbtZlDfX0algJCbgJH?=
 =?us-ascii?Q?PgbqefmYZviudiuwvd8svc3h7ZnVZaRPkZfOyXzW+ql0pIy+FjUO67nRRCBw?=
 =?us-ascii?Q?Em/QlSvjv0PRp6A7lwCnXfMrbj+KtEqXeYJ3Vu1Vr7p/+RB0lO3SlIC15WEf?=
 =?us-ascii?Q?rrdFw4/+gYnIcZacwjInPTdbPgy7z2SspJZhloYelcL9GeZsMYJI0zbYPVwI?=
 =?us-ascii?Q?DRoTFq/Ow5rWrbrSc+jWOlSmqUxthwmnlnBZr8cvYkB/33L1g0xixW/SlonJ?=
 =?us-ascii?Q?bt3QxOsFhlZ1adrGl2OL37SZun7ly4MYk9BnZNMkfGQ3uYAbyhsBHpVZSNpi?=
 =?us-ascii?Q?J0XAVPHOEMLoQlIbdE1wTQMR/ZUBy75u7IG+7uOKzFmlfzF7ue24nvzAIPM+?=
 =?us-ascii?Q?OFLklGPhZzJW724DONrxK6vQ1WlHjqrG9Pv7wHrd6SRqphtc+ct0Uy5q3Cxa?=
 =?us-ascii?Q?aixr/kSen1KNe/stLTnyEvtlhPAZEickKc3uu5eokHAxsq60495Nrcqy1usK?=
 =?us-ascii?Q?vqktPTpoM2lhqE9nvnVbq5sOjA4yb3d5zPs0lYsz+aii0bNgK+1q6XyedunV?=
 =?us-ascii?Q?c1VXOFha+IyVA7Q4DPIvIdv05RpoMZIC4aJAieiqEMH0EDeMOn1F?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf78294-2ace-425f-6aa6-08df0470bfae
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 19:24:01.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RxFKnrvhI0ByA3fewAU91QiomJ7vpSAOg3cXIe+rd2qbca9mmkN3hxmxZn37Jystooful3s9QmYftx/pQDnYzmNLkMdv9rHHZvNN8ZJ7KVOzIcXwAmHBGJHZFVw2PI/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11203

On Fri, Aug 28, 2026 at 03:20:12AM +0900, Koichiro Den wrote:
> ntb_hw_epf tries MSI-X first and falls back to MSI. It reports the
> result in COMMAND_CONFIGURE_DOORBELL. pci-epf-vntb ignores MSIX_ENABLE,
> configures only MSI, and always raises peer doorbells with PCI_IRQ_MSI.
> When MSI-X is selected, the host does not program MSI, so raising it can
> issue a write to an invalid address. This was observed with an IOMMU
> enabled on the RC.
>
> Configure MSI-X when supported and use the selected type for peer
> doorbells. Use the hardware-owned layout when available. Otherwise
> allocate an EPF-owned Table and PBA in the config BAR. Configure db_count
> entries to cover the link event, the reserved slot, and the doorbell
> slots.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 67 ++++++++++++++-----
>  1 file changed, 51 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index c3caec927d74..d9622a5d4710 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -148,6 +148,7 @@ struct epf_ntb {
>  	u16 vntb_vid;
>
>  	bool linkup;
> +	bool peer_msix;
>
>  	/*
>  	 * True when doorbells are interrupt-driven (MSI or embedded), false
> @@ -155,6 +156,7 @@ struct epf_ntb {
>  	 */
>  	bool msi_doorbell;
>  	u32 spad_size;
> +	struct pci_epc_msix_layout msix_layout;
>
>  	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
>
> @@ -303,6 +305,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>
>  	switch (command) {
>  	case COMMAND_CONFIGURE_DOORBELL:
> +		WRITE_ONCE(ntb->peer_msix, argument & MSIX_ENABLE);
>  		ctrl->command_status = COMMAND_STATUS_OK;
>  		break;
>  	case COMMAND_TEARDOWN_DOORBELL:
> @@ -439,9 +442,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
>   *   region
>   * @ntb: NTB device that facilitates communication between HOST and VHOST
>   *
> - * Allocate the Local Memory mentioned in the above diagram. The size of
> - * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
> - * is obtained from "spad-count" configfs entry.
> + * Allocate the control and scratchpad regions described in the above diagram.
> + * If the EPC does not provide a hardware-owned MSI-X table and PBA, allocate
> + * space for them between the control and scratchpad regions.
>   *
>   * Returns: Zero for success, or an error code in case of failure
>   */
> @@ -454,7 +457,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  	struct device *dev = &epf->dev;
>  	u32 spad_count;
>  	void *base;
> -	int i;
> +	int i, ret;
>  	const struct pci_epc_features *epc_features = pci_epc_get_features(epf->epc,
>  								epf->func_no,
>  								epf->vfunc_no);
> @@ -462,6 +465,29 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  	spad_count = ntb->spad_count;
>
>  	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
> +	if (epc_features->msix_capable) {
> +		ret = pci_epc_get_hw_msix_layout(epc_features,
> +						 &ntb->msix_layout);
> +		if (ret && ret != -ENOENT) {
> +			dev_err(dev, "Invalid hardware-owned MSI-X layout\n");
> +			return ret;
> +		}
> +
> +		if (ret == -ENOENT) {
> +			ntb->msix_layout.table_bar = barno;
> +			ntb->msix_layout.table_offset = ALIGN(ctrl_size, 8);
> +			ntb->msix_layout.table_size =
> +				ntb->db_count * PCI_MSIX_ENTRY_SIZE;
> +			ntb->msix_layout.pba_bar = barno;
> +			ntb->msix_layout.pba_offset =
> +				ntb->msix_layout.table_offset +
> +				ntb->msix_layout.table_size;
> +			ntb->msix_layout.pba_size =
> +				BITS_TO_U64(ntb->db_count) * sizeof(u64);
> +			ctrl_size = ntb->msix_layout.pba_offset +
> +				    ntb->msix_layout.pba_size;
> +		}
> +	}
>  	spad_size = 2 * spad_count * sizeof(u32);
>
>  	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
> @@ -502,6 +528,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  {
>  	const struct pci_epc_features *epc_features;
> +	struct pci_epf *epf = ntb->epf;
>  	struct device *dev;
>  	int ret;
>
> @@ -521,16 +548,22 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  	}
>
>  	if (epc_features->msi_capable) {
> -		ret = pci_epc_set_msi(ntb->epf->epc,
> -				      ntb->epf->func_no,
> -				      ntb->epf->vfunc_no,
> -				      16);
> +		ret = pci_epc_set_msi(epf->epc, epf->func_no, epf->vfunc_no, 16);
>  		if (ret) {
>  			dev_err(dev, "MSI configuration failed\n");
>  			return ret;
>  		}
>  	}
>
> +	if (epc_features->msix_capable) {
> +		ret = pci_epc_set_msix(epf->epc, epf->func_no, epf->vfunc_no,
> +				       ntb->db_count, &ntb->msix_layout);
> +		if (ret) {
> +			dev_err(dev, "MSI-X configuration failed\n");
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>
> @@ -1512,6 +1545,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
>  	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
>  	struct pci_epf *epf = ntb->epf;
>  	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
> +	unsigned int irq_type;
>  	u8 func_no, vfunc_no;
>  	unsigned int db_bit;
>  	u32 interrupt_num;
> @@ -1523,6 +1557,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
>
>  	func_no = epf->func_no;
>  	vfunc_no = epf->vfunc_no;
> +	irq_type = READ_ONCE(ntb->peer_msix) ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
>
>  	/*
>  	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
> @@ -1536,16 +1571,16 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
>
>  		while (db_bits) {
>  			/*
> -			 * pci_epc_raise_irq() for MSI expects a 1-based
> -			 * interrupt number. The first usable doorbell starts
> -			 * at EPF_IRQ_DB_START in the legacy slot layout.
> +			 * pci_epc_raise_irq() expects a 1-based interrupt
> +			 * number for MSI and MSI-X. The first usable doorbell
> +			 * starts at EPF_IRQ_DB_START in the legacy slot layout.
>  			 *
>  			 * Legacy mapping (kept for compatibility):
>  			 *
> -			 *   MSI #1 : link event (reserved)
> -			 *   MSI #2 : unused (historical offset)
> -			 *   MSI #3 : doorbell bit 0 (DB#0)
> -			 *   MSI #4 : doorbell bit 1 (DB#1)
> +			 *   IRQ #1 : link event (reserved)
> +			 *   IRQ #2 : unused (historical offset)
> +			 *   IRQ #3 : doorbell bit 0 (DB#0)
> +			 *   IRQ #4 : doorbell bit 1 (DB#1)
>  			 *   ...
>  			 *
>  			 * Do not change this mapping to avoid breaking
> @@ -1556,7 +1591,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
>  			db_bits &= ~BIT_ULL(db_bit);
>
>  			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
> -						PCI_IRQ_MSI, interrupt_num);
> +						irq_type, interrupt_num);
>  			if (ret)
>  				dev_err(&ntb->ntb.dev,
>  					"Failed to raise IRQ for interrupt_num %u: %d\n",
> --
> 2.51.0
>
