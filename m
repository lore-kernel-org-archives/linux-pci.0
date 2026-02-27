Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099E43C077;
	Fri, 27 Feb 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207382; cv=fail; b=H98IxZf6znwdtCRJ34iEE2KdoQcvgDE5omrm//pHGSHu6AowOl1TgXTf1HtmOv9sCXBYUC1MITJI/8FaI50/gQszqLvXA0cBUc8LD51O1gwKyEYsXU2q0e9tS5B/ry3UnwmPySJ+SgTVe9+2skJzqYJ37w7ezApGF3bH463cCHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207382; c=relaxed/simple;
	bh=omv3VnClwdVoiMCsg0DM6KjAl4WxEseX+WHrTERDzdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cYiNWB/XPwEi4iE5006l2hE/TGgwdAyhDe0VIwqrf5BqkzMYZSQl8fqjnvgEwb/8Z0dhXXrfCkIQWlXPqTcPU8zJ7EdP0v1j5x3DFem3qVQKeNQAsCF0s6uUSOOYIjTHE3BkXSJ74Pejqdb1fZvrf1ktgvAhWBNaLs9L6beIfCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=afESgliH; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="afESgliH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ks0agFcP+u/1b8WghY8cq1zy5/ZU+UvbmtyTxbTe50D15FA6kvE0TjaXSggmGRqNjOZ/92DBFIp8DszPb1OA90N3Dl8lGVasGhOCynDTzrisNzZgcPap/Vyt2q+pVMU6ifNOxcGPG+/0iiQIgAwIftLtoj7R/4p1mzB+y0HS5bnDPwpYR63eF8itZaU3PjunKt2+a+L1dCuOogjt4PvmbiH8/yAbQbe1hbDwJuPtYOlfLUKTR+Ok5Mygxj/aRxQkcum3T9d/HHqH83/M25+XUucT3zUZY1p6AvcLFzfyy71X8cPUFF3T91tdRvfvtC2N/YEHVBM0uM+idN5OU0JxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7Z+54349T2KhIVlcmz+qDdk61GZiNRk2PUUgSQwyLA=;
 b=sEnD3v0hQK5X38bpP4bFMiIuaipC9gKYnQLn6EuiWy6FInum9xrR2KfL1rHLk3gDQG8QGm+9cxrwnbQMZQv8fypKs9N93FFPEYqWzY8Tz4z3UyniyWWW2cfpAymO5C0LlNB9m66FpeQ0/bxgVZY5mr86RCSlK6AiqWutOk5qjJr0M3Wb+0tlnzaTWJz0ZqKxfdxP0UJnHVO6jQMsIpFq57k0ZKLGPQEIZJyEADNACQcOhZeddX12rralUtMguHTyCh3zJjlBfT1ogOT/A2vJfTFjwGBf66QQPYxdXHujugCSHl+zMo5KnzxXGqQVzEwnf+HKeBuLPsCq6KCffRkzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7Z+54349T2KhIVlcmz+qDdk61GZiNRk2PUUgSQwyLA=;
 b=afESgliHDhQi3D7t6h904N6EeazpsI6r7jyLZwbyijsoGpOaE5ljStWpJK7sMnOA/fLp0qrEglInKgz57xLN8d+fILqJieU/VbqAGyqtZwttPSNzmhHbcAjdd3+xT/IZ32wGLl5WIVyHgzoRwPx9Q/6pIdd6HgwhhlQmCBDjAC4rZvUrTQ8rs2QWDCiayny3v87Ygi/HuDR6XcS+w0H8ZmPbpt2KwPOL2u+WiC9RPn+sPfHgKzsaxKbHtXB5/fvEQ2EOgqx/cMv2/Yy9FpYGCIS3wZRVTCdM+2kqWbah6XkplXRGdh7Bb/Elw87RH8nJw/k4QS8XmFK1G+BSYnxTwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by MRWPR04MB12048.eurprd04.prod.outlook.com (2603:10a6:501:94::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 27 Feb
 2026 15:49:36 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 15:49:36 +0000
Date: Fri, 27 Feb 2026 10:49:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: dave.jiang@intel.com, kishon@kernel.org, jdmason@kudzu.us,
	mani@kernel.org, allenbh@gmail.com, kwilczynski@kernel.org,
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] PCI: endpoint: pci-epf-vntb: Defer
 pci_epc_raise_irq() out of atomic context
Message-ID: <aaG9COYXPJamIvTx@lizhi-Precision-Tower-5810>
References: <20260227084955.3184017-1-den@valinux.co.jp>
 <20260227084955.3184017-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227084955.3184017-3-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:332::27) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|MRWPR04MB12048:EE_
X-MS-Office365-Filtering-Correlation-Id: bde71135-b117-4dfa-ffa0-08de7617cf0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	7oSpXyHsGMzVBzrUppe9cD7XW0EblCcRUtVFR5idta8Ct2O3Sk9AbhWRlKly6B6hrIwEJ+34KDMfzOpHXzAo3SZByL4mMMlAmlus9iuBts4jia5v5hLTYwUK+Igjc9QkdlMmE34VDEi5/ElSKY0KBZ0JngmltIIaqfz8CGqxAlcoShUY4NPVBXV/vCJm3WR+lkonilm2xIRtDC/0fn8YATguYsYNU6qlsCxZYK81aLyfBueUKfQ853ydIP5Wzm/Mi35cM2HvSOmS+RFBYmZUZoPc6GOm4M8jjInozPzYsQkK4z4aOIFcvTApa9qIiSs1PUmNjhhUsaCeimfYrSUiOzja1qZZzgewilBA4ROz+zP2u47EA3mVd3B12qpKLDp4niTbkwSuLXDnhZJtsv9BsomV9rAyngmCLG3pyVJmduVFlY2flg1Nl32HE7O+nVgJpr0Z5MPIHgew92X4DOKhqrRGOZHgif+yKMtZWsCBkDGD4Tyblv2ZrDbonFc3Km0Y1OOZUGlaOCYGoeQ/5x2SbJ59nw+w90hyjZ2LHNaoLYAGnNImCd7vL+4m/Ii3B46FEHHxjyFz8hecQDjMtJefXG5tGS7hVe6ttn1RxZDzgXM2Ys2DB4G487DZ5OlI5rmqwiYj6oaVwxxixsHkmXL7o9Y/A6Tw5ldCZUW5xUar/WU1se2w7UbDwpIx+RccH3YQODfJ7CdF2eN7NNoRQjE55c59YWv+X1QoOYmPzPuJGn3TvMzOBi+uXXbDrp4yQ9onqgE+vmQ5NcBnDWKgvLR7BW2h5O54Ahl3alj3WsX33xA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UXklcvId58Djh0b69IBZwgbxB1hC7Aa8AUHqvUdOLSc/BDqlXHehdbWcckIt?=
 =?us-ascii?Q?g77fTIRop4m8o3+kDkiiow4g4ydvnmMYPQ+nvDee1KGNg6x6Fdqe1EV3DiNs?=
 =?us-ascii?Q?SWXLhtT/vX85yD7Lx65TugYrHnzkoLSIGSYokyNKDhg5H4/eVzQYs+sPtgXh?=
 =?us-ascii?Q?E68Viold+Kzb7EKS4l3HaDtGIKUvtf5ZO+C7aYAMjrKhPTE9ul9zqxExsPZE?=
 =?us-ascii?Q?NIBUosWRr1zeY5TIoLtSb7CEabzWRwFksoCgcODbviBkn3v9pMtZzvPSQ5ki?=
 =?us-ascii?Q?zU1sAqh2Mab+d5g5oiHBODfM9K8J78aKvaJG0TRMWNuWZVla8gDoRCIZmtgH?=
 =?us-ascii?Q?26Ai1CfqcuGxuN7aRMO0JZfXnJ2LCqx4Uio8Eb7sMpVskY2CJJ4Xk/POd053?=
 =?us-ascii?Q?xczJJ7Ge+3Pp1RW3a6EcgpfMlei9cAvzn7uThAsLwALL8b/WEfDZNVFwX3kT?=
 =?us-ascii?Q?+zRiSuc/JVcbJnMJDCn3kMEaYl/Q0zqo/4ayHOq6l+BYswfUEdeWRpQL56+y?=
 =?us-ascii?Q?k5bRCCjkLRQ1hC9pUYVeFjotkQ3MJ1NBC57ptb5HUNvb9VNVg0k8O0rWEeXJ?=
 =?us-ascii?Q?owTIF4Av4woQS9pno/lmt++Ca8VkGI2qo83AjvkaqK2D28mGtVhIH4eyvzPt?=
 =?us-ascii?Q?ffkLoBlYv5fgC1/g1Rz1vrHNYxMDwOxNIUBPYLw7yQUR8+rxBWMrB9xDGZQD?=
 =?us-ascii?Q?5rCuNDOta7DS5OMT03vStKfDGIjL4YB0nCil81/aAfzKMjV8c1U0BStg3ND9?=
 =?us-ascii?Q?rU1Va7Ji9zuTrFcAe3jjrkjDqfYwdjt1AqZ3vFJd6lWt8CqA5KNsXnJuD3h7?=
 =?us-ascii?Q?WRWUNFgNgKpbsS7nPpOhkeYm9tJlddp6WhOm6yXynADZNwOltnlBEVw4VjJq?=
 =?us-ascii?Q?Si2Idr5nsqaVzvkMB2HsRaN1gF8BgixEaRMVIB3aKdVUaZwHztxLFYAe7dxO?=
 =?us-ascii?Q?1MyRfrOJrcri3IdI+ZlZm1lhdkInHpdALVhv6pMo1JoUcgEuVGYTpMdMxw4/?=
 =?us-ascii?Q?yEVmMie6KI85YyWcWLoss+9jiPZqzlZHDwhFqh9BSqcYK2C7cf0vWMd6Bg9l?=
 =?us-ascii?Q?qsWAbTFr6wSc/qG3LICyxkbMnW3rnhcEB7K8XEVD6wGiBkwaclrsSajbMwpG?=
 =?us-ascii?Q?qkCfWHuwkDnydUAjg7lFiR7nFaJ/UvcY7vh+ix1cU6gMNCb7HpnC7sPCDYav?=
 =?us-ascii?Q?doVGNIF2u57u4lzeWTMVuTkFuB1FeDGzYLD7+MRjlCzRBFC+ZlxQGJDOJnx/?=
 =?us-ascii?Q?sa33kxjbBrlq0a7H+WV1CKgJ5JgH10edY03GzV1tZKO6QuzF3D35ue8hpf+y?=
 =?us-ascii?Q?y55fYfzowgp9T5GG/zmd1vZ3bqzpZS+hrYq5Jdc3H65/FEdSkXFaLQYCOHFE?=
 =?us-ascii?Q?+fNGTDeZoJF48MyCiALyZCtjuMpaw2f0DOxPJHAZEyvHXw6U0KCbBxfMIsBQ?=
 =?us-ascii?Q?FTzYWpozQvN30EGW93KVsG/A5YZsMZb6k/t1E39vZteQl3vB4aJtfYE/wy7Z?=
 =?us-ascii?Q?YSC1pbvwOWUZWYOUyioSWsHxlpzjrvjhUzxU5Xs54rTHyR75npiQDXhFq6X5?=
 =?us-ascii?Q?8kdTyWqvGf9zV+WF9e3csOHabRumFgcjEm6RwNXpWDBuFkErd5VaqpRUpUl2?=
 =?us-ascii?Q?1lBuRsYIU3aUCLcgISMIcxWqv8JnHU32P/5pnQZc8e/vTDTfmBJvoigluNSl?=
 =?us-ascii?Q?DPgirMLpUvaw0DldWiwZaW9fos3egsO3/ph9F0D2Vxs3FPT0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde71135-b117-4dfa-ffa0-08de7617cf0c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:49:36.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0xFuCM8bASCdMnkzNWP77MZ/b5vYW4d6tSayKtm2q0vWNROvWh8sUgXrL5MiZy7H2RTvfCjlPDZJFQwhajJjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12048

On Fri, Feb 27, 2026 at 05:49:47PM +0900, Koichiro Den wrote:
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
> Changes since v1:
>   - No functional changes.
>   - Updated comment in vntb_epf_peer_db_work().
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 106 +++++++++++++-----
>  1 file changed, 78 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 83372aba5106..e2c0b6dba793 100644
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
> @@ -933,6 +938,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
>  	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
>
> +	enable_work(&ntb->peer_db_work);
> +
>  	return 0;
>
>  err_write_header:
> @@ -955,6 +962,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>   */
>  static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
>  {
> +	disable_work_sync(&ntb->peer_db_work);
>  	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
>  	epf_ntb_db_bar_clear(ntb);
>  	epf_ntb_config_sspad_bar_clear(ntb);
> @@ -1369,41 +1377,79 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
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
> @@ -1645,6 +1691,10 @@ static int epf_ntb_probe(struct pci_epf *epf,
>  	ntb->epf = epf;
>  	ntb->vbus_number = 0xff;
>
> +	INIT_WORK(&ntb->peer_db_work, vntb_epf_peer_db_work);
> +	disable_work(&ntb->peer_db_work);
> +	atomic64_set(&ntb->peer_db_pending, 0);
> +

Does it need call disable_work_sync() in unbind or remove() function?

Frank

>  	/* Initially, no bar is assigned */
>  	for (i = 0; i < VNTB_BAR_NUM; i++)
>  		ntb->epf_ntb_bar[i] = NO_BAR;
> --
> 2.51.0
>
