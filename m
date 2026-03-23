Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA2A3CF68F;
	Mon, 23 Mar 2026 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290490; cv=fail; b=NztMN51UGIOon2M1Hr67VL5x2+z8aYNNwxDHiukF+yvWw4SD6rJn/7pSaQwx+UiIFbh58KjtYw2w+TfA9GF2X3PbUkGjdO5SmTf3lZ5LonYx35bhC0ablgXq7jT/47sLqgjW4V0dIOXOowaOYvzPQ4uTAy61qg/SznCrnBCIAO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290490; c=relaxed/simple;
	bh=x5cy77TAnc5ImouFFuF9HdT7MjRGLis/RF/YM/jiO80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aPneZc9wE1QM2PdLLorrDaqY9rfAkXdUF07iUWPgAYMcdQKxDjcQQ599A+abYjSPM68DC+AMwgaNXKgtEmuouQpuy4mrW51aKaKCn+ApSS2xdoSeD9EaqrzirOwVfb2nXS/IzK9n12gtanLjbxkJFCqlsOLEVvY5nca3rvqjxHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=erKS9juw; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="erKS9juw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZtFTZPvyoNPURE4qOBY8pvX8PJ3VuiPs68ItxoQK+zutZZW2ekGuBJpBbkUrWf4zHyyeAekUX/6XgPbtDVH2Ds7IoXnn5rhXiIhFAX+Zho+j26+Y9NYgOicUKKsDKamoVZk9LhqRWNhzLk9Yny/hUF7E4FlZVslDdAzFW0h6okLqpc4gO94TjLE6mLQJPFHZE709LYDGAM/nIqRZK45/YI8w5w3adtO1anbg/yt9lDok6R9tezWZjFNWJhrtYDH7+KhIpaLQeJL0+66UIqwohAroM7mHjdv8bjV4Jy2vGXV2eq10ULG0ApWjYNR8DprcdskK6Isx7Fjn5bYJLk1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwWGMoa+Srw6//kiVpPgWXF0sNfNTRq0K9swKtCdr1A=;
 b=S1CG+OGKYlcDV5sK0PpFE085Igb6VA+lAaSgsLyGTiBOQ2ddxwdtzi9JjIzs3Qqs2CmuVoy/xTNAMxHAZ4TLOn5urKz9oyZkP9z+epFqZk3/+plq8A25wKKT6Sr0It545sRameBEZeM0CTEfjI4bIMZxTApUXpt4FiPT9iygTmx5w0gmLLNVgDg+qovSSATOpntIPWijNLwcS9wWiNk8xXYM/wKMZbpbdugondcRiVg/2elaS6TFA2JVoA7pCXO40fh6uBBJhXTOM3bPTLB0tz6xYcwa+vmS1FnhqFdbj9shnn8c7VVAwJlRWtH39k+PNlFkpLvHgCAcoIfdK1oWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwWGMoa+Srw6//kiVpPgWXF0sNfNTRq0K9swKtCdr1A=;
 b=erKS9juwe360rsoHljVyiXp2NRebOoLZ60gvnP6oRIw8w0tjcWoDBW89bjkPW4RPXBk1bBiAYTytOVhsmn0sQGQ50VUNI+tp08LmlxsJBYpxMj1aWJ7lTiFT9Ok+3eOejp5qxBR3eVt8aOrk7FhHvfyWHvfGF50ZGINkY1TpL90BkN4BjhbkaGUB0EeNZQ5YsS6Y04ggGgGZ3jVAtHA7jbyb48jfkPWJMBU+iWfTsnYKIbyLdzUp1Der0HdKrdkNJw3nZ3bIadmCnO5vO50LXfr3aHcJp2ik4kIib0YXp3NbsE0fntwZKgnyVw0fhzAonrhwf/xOQ1IlKo5molIBRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI2PR04MB10810.eurprd04.prod.outlook.com (2603:10a6:800:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 18:27:39 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 18:27:49 +0000
Date: Mon, 23 Mar 2026 14:27:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v3 02/10] PCI: endpoint: pci-epf-vntb: Defer
 pci_epc_raise_irq() out of atomic context
Message-ID: <acGGJNYh4sw__mWE@lizhi-Precision-Tower-5810>
References: <20260323031544.2598111-1-den@valinux.co.jp>
 <20260323031544.2598111-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323031544.2598111-3-den@valinux.co.jp>
X-ClientProxiedBy: PH8P220CA0066.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::29) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI2PR04MB10810:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f330d38-e941-45a9-a5ab-08de8909e341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|52116014|7053199007|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	NRstdKTtP8MG9YuSEHjgWalJUpILuIjQTJCxCTtlPsLTlCdkq+1Br04D+ZYDUW4MaYVcuUGmvIlvBX0cXGPA6ewPpEVgDnPRULpYfEy7Q8PD4sxOuTmkESUK93ZYAn5WKzD6+DxdImMuo/79zsoh+54o1SxXXkA5YDXHiv8ZKSKPV1n6LsOnzdoclnrF2Ho8Gm0bfW8753v75GvuiRyyjpPaTtZMJ28PFvXsxLGl+dD1toRvNqihfK+vhykyOWxHl8uRMLjDTOVdVGpPCeWQR9U5hljEaFealZMD/GfORjus5EVYA+qd2KLyOo2oTv/UARdEsG9jJCF2P+GlxDDUcth5O5/i3Qp/+DHitH1PueF5uM1iOu1cFK339y7kK8VkdFlygdxkGwOsYKIXeGgbjYEdAPo6Ro/vix8Z6/O8jBgT/+17uNKp//dk1SDCt42sHGo2f6RWs5+fpWtEE6/yAj1UkFGy2M5j+nhsTZIE+ta4VdCrCmUD5bEyZoxPBBOdSlChff4U6LOPGxidieUoiovoom8ZyreL5WLe1ykzzfADZ7xPiiNMgne00KVkuuvG9mQMit1hzbbuTMdYgNChcIUvFeLEOdQkFz5lLRUVPkgljW2GshOaMM8lahffp1NNminne4MrEO1DqwcB0KUpZW6fShG9Ws7Ko4Nn891stpLQ94NwOzfSoyxx2+IQGZ0hEBFQClSS+RmeaLh9jocbIULPtLbvQskR0oy4WCygVNuhICNTB80ECsS3XQtFs0R6YBHUYjxuexjKm+KlNhPiWt9tFjUAAMEJie8sHObzQv4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(52116014)(7053199007)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NdDaquac8ELWAO0Wt+D5YKZJy9BuYDi8OnJzbC9SIycOGkHQR9Zv4EreYCtX?=
 =?us-ascii?Q?7nOtU+YPSYbuJTkDEhL0cVczXST21IqUxAynNO/Dp4MSreS/qr+2tDShmELm?=
 =?us-ascii?Q?fjJo3z+VcmMj2U7OsMAMhOQUZwTcCCp3+H/2hjEFeLXRZbv4i/QKOc9eQy2B?=
 =?us-ascii?Q?O6C3uch8/CSNmLDIuUp3Sl6mNxJO6zdK0G2S9qNP+UsDZtPXfUccNkYgkIQW?=
 =?us-ascii?Q?u4QvIAEuAM1IAVh4tvAeeLR0xbyKOKTJwtfvEpsEIQlqa19m3ZP201kYYBWI?=
 =?us-ascii?Q?chIhhIFR6JB2fxoX6kFilXrX8pvwrwdOQfb2PrZBwFB8hT8plyVdz8LApgz1?=
 =?us-ascii?Q?vMFqN964f/ffHOie+MgrIXlFR95FxjkYmxO3eIYYhwNcn2pY3GUGxvTVYyJP?=
 =?us-ascii?Q?PZ+QowX2xF70oF+GpMPSHnifQEVACrJFyMByk5wz+SbAV+owB60opx9T5xph?=
 =?us-ascii?Q?FDdol8mUq1f+hfqjJ88OatcsTmd+r8eT2EC8B1ZQR3CtJC5br5XfzKoUcbtA?=
 =?us-ascii?Q?ADf7tRxtaklqYex9JSNOCTVheSHvCxlalBfdiE+xvIcj4PaYCQjoxRDUy8Qi?=
 =?us-ascii?Q?alQIY+0g6pWvOelm5CHPSyfTYzRFiSx9VObRC8SDM5tNyyp84e9+3aikuR5t?=
 =?us-ascii?Q?8axLbpv2XsARU7Z2kCM2QFknURZp6QV4nmuZPcH/cGiNTXQ2pbujmR8ixmBi?=
 =?us-ascii?Q?+R6naYeAyr5GPqKOdaz2UPElY25eJU5mSGOk667qyqaZaaoKbdGQ8aYuL0sX?=
 =?us-ascii?Q?J7Oso8X02N+zVhZkgf8O3uwuPxFKm8mR1Rt9LMp/HQd28H37wkw+Ol1Slwqk?=
 =?us-ascii?Q?9WJn3jzG6ehi29RddQT5e4IS2DlbzyDq2x89Lzzve2LfShRz8d0V8k6vRuoN?=
 =?us-ascii?Q?7APGI5Cu8ofV/NW328KXfUaP2QwDMc7o/LRBRWEbh8wyKuYCOuj+vwpVnYGV?=
 =?us-ascii?Q?Dsu8XHTa4TVdodX2ho3k+k8u8NZjWTjnx016F6E9htv0kr5hxHaSjBJJvn0R?=
 =?us-ascii?Q?vtuytI4wBusmMh0/PAKprUTyM8zOgxG//gOkQhMDBWPiUt0BnJMalJDNc7cy?=
 =?us-ascii?Q?71C6ZvNT+92yFNSYj1TZux3jiJ2rVi/uqGbruhKwxO7RZxpgeW6DX/4f+pVT?=
 =?us-ascii?Q?EpEMJkxeIS2VPxKNl431Unk3GKePutgeA/wu+6jQGiW5UVqKlCtgaKx4p+GP?=
 =?us-ascii?Q?hv6Rq9rrJdtU08ibbwFrkOW8WvMSMRu3Tv3kHa5iIHKz7zc53yXoBlb6LFcQ?=
 =?us-ascii?Q?QPQkUpnjPFdAl8CBog5kLTovlzbFq/5yduQ536ya3N84heo6LMquVjBijXwr?=
 =?us-ascii?Q?WtAn3MXr4S/WzV9sDIkS63ajXHTcpp8zRnE+LasM2O8dNYPHCs31hmCidkb9?=
 =?us-ascii?Q?F59S93XxApA00P28A7fmDCBk00xqXEKAHVhSDKkZdNmF3iGBhNx9ADovDoPA?=
 =?us-ascii?Q?yMdEyY6XmR7TZ11KP5LF3xsTgcIIfI/3m/A+PV6+NtLvKDkhnBn+O59P72mc?=
 =?us-ascii?Q?w15Z6+QUwURQbPSmFTamwrBambowKbx3FZamWedzm4ucpodNKH6z0a3X8mXt?=
 =?us-ascii?Q?uHTcWElzVEx6GM2CntaeUuXjY5Ec+x7587eK0QjamTasggZXekuqlTnV3PaA?=
 =?us-ascii?Q?dvL/zgTk1ME2iQD6yPHGXCGSFTVb1jCLrCRARCX/gvAfaobndncce0lgmsi9?=
 =?us-ascii?Q?ZsNPGKY5PDETt2ZEQCtdpf+YCam/zSjwv/Buaiypdx2EMFjeLldD44iU7FNK?=
 =?us-ascii?Q?J785i/SZgA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f330d38-e941-45a9-a5ab-08de8909e341
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:27:49.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gumJiliZNsFpUnld6R0FBsa2LXSsHvTM4lyQxKkrEdp3s0PgjyMuA4Yxiupg5CVImyXTLkv5NOpzcwgnDt1Xwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10810

On Mon, Mar 23, 2026 at 12:15:36PM +0900, Koichiro Den wrote:
> The NTB .peer_db_set() callback may be invoked from atomic context.
> pci-epf-vntb currently calls pci_epc_raise_irq() directly, but
> pci_epc_raise_irq() may sleep (it takes epc->lock).
>
> Avoid sleeping in atomic context by coalescing doorbell bits into an
> atomic64 pending mask and raising MSIs from a work item. Limit the
> amount of work per run to avoid monopolizing the workqueue under a
> doorbell storm.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v2:
>   - Resolved a trivial context-only conflict after
>     d799984233a5 ("PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup")
>     landed in pci/endpoint.
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 106 +++++++++++++-----
>  1 file changed, 78 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index a75f8a30f8dc..bc3b3df53ddb 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -69,6 +69,9 @@ static struct workqueue_struct *kpcintb_workqueue;
>  #define MAX_DB_COUNT			32
>  #define MAX_MW				4
>
> +/* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
> +#define VNTB_PEER_DB_WORK_BUDGET	5
> +
>  enum epf_ntb_bar {
>  	BAR_CONFIG,
>  	BAR_DB,
> @@ -129,6 +132,8 @@ struct epf_ntb {
>  	u32 spad_count;
>  	u64 mws_size[MAX_MW];
>  	atomic64_t db;
> +	atomic64_t peer_db_pending;
> +	struct work_struct peer_db_work;
>  	u32 vbus_number;
>  	u16 vntb_pid;
>  	u16 vntb_vid;
> @@ -920,6 +925,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
>  	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
>
> +	enable_work(&ntb->peer_db_work);
> +
>  	return 0;
>
>  err_write_header:
> @@ -943,6 +950,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
>  {
>  	disable_delayed_work_sync(&ntb->cmd_handler);
> +	disable_work_sync(&ntb->peer_db_work);
>  	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
>  	epf_ntb_db_bar_clear(ntb);
>  	epf_ntb_config_sspad_bar_clear(ntb);
> @@ -1357,41 +1365,79 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
>  	return 0;
>  }
>
> +static void vntb_epf_peer_db_work(struct work_struct *work)
> +{
> +	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
> +	struct pci_epf *epf = ntb->epf;
> +	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
> +	u8 func_no, vfunc_no;
> +	u32 interrupt_num;
> +	u64 db_bits;
> +	int ret;
> +
> +	if (!epf || !epf->epc)
> +		return;
> +
> +	func_no = epf->func_no;
> +	vfunc_no = epf->vfunc_no;
> +
> +	/*
> +	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
> +	 * Limit the number of snapshots handled per run so we don't monopolize
> +	 * the workqueue under a doorbell storm.
> +	 */
> +	while (budget--) {
> +		db_bits = atomic64_xchg(&ntb->peer_db_pending, 0);
> +		if (!db_bits)
> +			return;
> +
> +		while (db_bits) {
> +			/*
> +			 * pci_epc_raise_irq() for MSI expects a 1-based
> +			 * interrupt number. ffs() returns a 1-based index (bit
> +			 * 0 -> 1). We historically add +2 to compute
> +			 * interrupt_num.
> +			 *
> +			 * Legacy mapping (kept for compatibility):
> +			 *
> +			 *   MSI #1 : link event (reserved)
> +			 *   MSI #2 : unused (historical offset)
> +			 *   MSI #3 : doorbell bit 0 (DB#0)
> +			 *   MSI #4 : doorbell bit 1 (DB#1)
> +			 *   ...
> +			 *
> +			 * Do not change this mapping to avoid breaking
> +			 * interoperability with older peers.
> +			 */
> +			interrupt_num = ffs(db_bits) + 2;
> +			db_bits &= db_bits - 1;
> +
> +			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
> +						PCI_IRQ_MSI, interrupt_num);
> +			if (ret)
> +				dev_err(&ntb->ntb.dev,
> +					"Failed to raise IRQ for interrupt_num %u: %d\n",
> +					interrupt_num, ret);
> +		}
> +	}
> +
> +	if (atomic64_read(&ntb->peer_db_pending))
> +		queue_work(kpcintb_workqueue, &ntb->peer_db_work);
> +}
> +
>  static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
>  {
> -	u32 interrupt_num = ffs(db_bits) + 1;
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
> -	u8 func_no, vfunc_no;
> -	int ret;
> -
> -	func_no = ntb->epf->func_no;
> -	vfunc_no = ntb->epf->vfunc_no;
>
>  	/*
> -	 * pci_epc_raise_irq() for MSI expects a 1-based interrupt number.
> -	 * ffs() returns a 1-based index (bit 0 -> 1). interrupt_num has already
> -	 * been computed as ffs(db_bits) + 1 above. Adding one more +1 when
> -	 * calling pci_epc_raise_irq() therefore results in:
> -	 *
> -	 *   doorbell bit 0 -> MSI #3
> -	 *
> -	 * Legacy mapping (kept for compatibility):
> -	 *
> -	 *   MSI #1 : link event (reserved)
> -	 *   MSI #2 : unused (historical offset)
> -	 *   MSI #3 : doorbell bit 0 (DB#0)
> -	 *   MSI #4 : doorbell bit 1 (DB#1)
> -	 *   ...
> -	 *
> -	 * Do not change this mapping to avoid breaking interoperability with
> -	 * older peers.
> +	 * .peer_db_set() may be called from atomic context. pci_epc_raise_irq()
> +	 * can sleep (it takes epc->lock), so defer MSI raising to process
> +	 * context. Doorbell requests are coalesced in peer_db_pending.
>  	 */
> -	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
> -				PCI_IRQ_MSI, interrupt_num + 1);
> -	if (ret)
> -		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
> +	atomic64_or(db_bits, &ntb->peer_db_pending);
> +	queue_work(kpcintb_workqueue, &ntb->peer_db_work);
>
> -	return ret;
> +	return 0;
>  }
>
>  static u64 vntb_epf_db_read(struct ntb_dev *ndev)
> @@ -1629,6 +1675,10 @@ static int epf_ntb_probe(struct pci_epf *epf,
>  	ntb->epf = epf;
>  	ntb->vbus_number = 0xff;
>
> +	INIT_WORK(&ntb->peer_db_work, vntb_epf_peer_db_work);
> +	disable_work(&ntb->peer_db_work);
> +	atomic64_set(&ntb->peer_db_pending, 0);
> +
>  	/* Initially, no bar is assigned */
>  	for (i = 0; i < VNTB_BAR_NUM; i++)
>  		ntb->epf_ntb_bar[i] = NO_BAR;
> --
> 2.51.0
>
