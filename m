Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7558D30B52A;
	Wed, 25 Feb 2026 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051776; cv=fail; b=GtHCyIOWeVyWq4umvdr0HoxRdpGDS3dJ2Tfc7Bp4AflO0Q942OqiQdd8J72f1jx0P3NufxPDoXYISDwWRykNIsR83xy0mgZ440i9k08oIb1PzI9BQJJNYp0SWVOiNbdEyjvThKssfz0oW1rztvQVL9rWgu4h00WHBlDxEE/8QAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051776; c=relaxed/simple;
	bh=+szTu7kodC+LJ6TqWR4E2t7GNwshtYudUAgi3jjKYUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dq2kmXv1m55BhC7S9GxW13xPOowc0unFSndIVj2plS1wpNk1rdh+MtlLps3QEi/WZokgjiJv1Zc8si132IRmZr7sHWHs8mVaUeENMvjel4ets8uRje1u5GAmpme0CnAR1aaFnTbNjlgzjKDtFlXdvOIcDOYSwWVdNytbZmO7ihA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RRzQZ148; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RRzQZ148"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3DzV/BHp4qg4y7oOV38tI1D49qxVy4eo8Sx/l++Ess1Dlk6RiNUyP04c1W2T+MSegJX09OdGORnl0pYBGJ6HUBXJoChLL3JU902BSVB4Z8QvVrgY1jNG9NF4nH7v7CNViHIAuqcO2n+RPbYxlv5WQ0zrmUVkCmgGrCmycG/OHUQHRcRNHaWeeOJXxce2hqYvfvtmwJxO6cZLDjACGoZMQeRPYmkFAkpgRo0VY0hupWSKQ4X/IyBHflzrZVhgkAHMxigtBnYnawzAj4TqxPHoXBE/rWAv46Maj6CkPrb0t6GFFOPYjPVSH222eecD6UWbK8hTeMrC4K7t2RUiOBKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1oZYQNpJaOc8u2HS21F+bR7+pHPUl3+QsgL1+rgtlo=;
 b=qNt2kNz7Nao1GORu21iMpyRXyCunpnS/WCrTcMY0BPkMk2VvmvKqftuYecel2lkilExiudx9q4t7Osb5bhLXRVH2MUR+TNYwV6IB3/io9fTXnChuPcjhqvo4mceMqvWcD3GCo6iz8S8Aa197rOKcvbspxFQ5rNoSC72YQ18ek5Atrr0YYf5sFBAFt8FCCa2vOcrxgH1cabfB0B9VhUxN+ERxCPa/RFuSPa4JbvnhkXmz4GEYpkHmklYDNYRqeGyBxnh7QgI7pCq5OK5uwnHvOEFDNzLHz7haf+aWuHGlTHH7wNP4muSZpi4FG1fWGi10fmOQojLVIJpNHWG+3J+Xbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1oZYQNpJaOc8u2HS21F+bR7+pHPUl3+QsgL1+rgtlo=;
 b=RRzQZ148MRYbfLyFck0GoQWxOktAsH/AeVQI5kKaycTYzwKuNLUNU2hjeFvpavBlIc4q+6I7fmIm9BCSQ3JSvtkwX3blYFSY40S83e1LPuQamTpzyo7fUlCUog2yQ537YyxtOKwkRAa4DX9pR8MH0H8mj+aPw41BLb2fA+S3My8GVC+yxRALBWRsqPM8ou7vymX1hEDba46LeTQB5iRtLytzTkJZMVMyLqZQLgDgNwQ4KzieqAOYxCtI++WXBXf0qv7I02qJuSJRj4OYavYCZhWbRoqbLtZxQ3tVnEmEZt5VJjQG9sZ8CpFtmUh7Bf2cXm0FjI+Pr/LKH4pr8m7l5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB6817.eurprd04.prod.outlook.com (2603:10a6:208:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 25 Feb
 2026 20:36:12 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:36:12 +0000
Date: Wed, 25 Feb 2026 15:36:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org,
	dave.jiang@intel.com, allenbh@gmail.com, kwilczynski@kernel.org,
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] PCI: endpoint: pci-epf-vntb: Defer
 pci_epc_raise_irq() out of atomic context
Message-ID: <aZ9dNc7ENkqDV-KK@lizhi-Precision-Tower-5810>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224133459.1741537-3-den@valinux.co.jp>
X-ClientProxiedBy: SA9PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:806:24::7) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a152335-5d80-4f98-0d87-08de74ad8391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	DppmrPKfaxVtjP0oq5CGjzWFfzB78mG4M4JFARlIA0ct1FdZo2bYuLe2sBzyfWDWjKgrv011WZK87oEoTR9Nc5CEbW6/OSs/hGCrqk6XX7EU7sVtIB2EZ3M5qNvq3QxDa02l+udTlcNiz7hy8x9H6o7ydc9j+MA3jH3Hqxi3qIE3OBkAt+Vg9o1zqHENNXRXfQt/cGJn9vqWrcvdIFli6nvWglrH62gXmSmbCJIv8IwCDczx8xoBLSbtASS90KzYPkjeQAV2UwhGe1Nu6cKDeAPRsSa67jVKjtnZEPFtWpTITyqpG8x4InZNlhL1XyYH8SD2wH2MeH6HTXN8tsvazQaSb/fr/Ac//jahVcGBKx4tj5p11/xHm8LsTUbGUsqYYJ2qUssfOasYY5rJaiF0Z8vlrlIBkSmXs7fCetO2sgH3pbNj2bcWaJFEo5w67KHAEO+k9YK0MAwYqseI7jtR2ISuTyEnVr+QbwpJrTjr0FXWD9yd5IyEEZ9M12FPntNx4ylUgpf2szlmiqh9LFK1UFLSn3mgVdqwVSxuJ1rUT6QmxVdAsuiHz59SKfH0CiCgfsgMkAmXfQDCy1LWjfIDatl0zuCgnaGfYs0dhP+j6ZYvB6yf8fa0NR/aLqTg/zMDEjpr/efqYNIQOYoTs3BmKtOBtZZHip1Sme40q55A95SwIy28rZkZhXHOzv6BTq54HkTx2LfdkCWSJvvXT/AAf9KaqgRpZNezsevWIH0Lsis73zrbPy8YDZaFgcDVBZ4tdjQ7xy0W2tyEwtSoRftKZ2DudXIF12giQkjdZOMGD5M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KcMKRULNwAvSt5w04wr0EoYXxCDP223C4s4escI7GGRNVHD31ZgVvzMmAfol?=
 =?us-ascii?Q?ughXFN+aapJAZut51EXhsMuJ/ItkgvjWHppNcoO1JR3iZEDxaFXqBe6DIEx9?=
 =?us-ascii?Q?TIZI36ZWbz5NAVhlwi/qGE3+uhQQ4IGGMCEKLA05oorOqkOf9OPcbGFAhMBr?=
 =?us-ascii?Q?zAQMaKHOrpjjK9SjUvmQCS0VUhTZ6gL4UD7G2XRSU1Ntyv39XHyTt7ZPFuav?=
 =?us-ascii?Q?t/t8coE28eyQ//OeQ0UhVISIPVChiLttiCwo5427Q6Tw2BmukJN2upSpTppN?=
 =?us-ascii?Q?wkQidtoutSg2ZDJplcBsyUNj/CscE+vbmFt51Q9ZDYZMCHux1IZ9cGUGs+yH?=
 =?us-ascii?Q?EmI6Rvjy+i3M+ZcvoAZfRsF4EkuM7ailfy52l25tqXeAb7CMsx32qWc8Qe1W?=
 =?us-ascii?Q?IvbUAiPXdxLNrSwp55uKsR0Z9iTc97TcBqwg1ArVTxMNy7xvKoYPPdZwjD6O?=
 =?us-ascii?Q?KItx6LNUV3uv1jqtwNxOmRSXTN1VbOiDJfXlM02yBACp3lwrqkYv8iAvSpZt?=
 =?us-ascii?Q?pETVJdIKCG2bMr86lKw/OM21+bWCpd8WEddWufZWnIYw//rLmZjm6lGGa2yC?=
 =?us-ascii?Q?XeJLREUz3drbxjDBD9ASa4+NBZPl4XC49s0UdJk6N3GJ1nq0O/hE3K7Ls0uL?=
 =?us-ascii?Q?VOejjIhiHndp9dD0ASK7QdwFlRprMijZamT8SaOjzm2jjwUJIQiBQDwhVig3?=
 =?us-ascii?Q?UsY/t2qUl4e99l6k2nD/bPfLms/UUZrpVPGJ8jUbT/7eDidVPYRoeWQ30/gE?=
 =?us-ascii?Q?XLb1ZJzjKa66JjRb+ATpunMxLtIY8l8aHWHlqr8JINyR1/yiYNUenPCD/vF9?=
 =?us-ascii?Q?0X5Syb1moU5ABIzvI3i0qaK63+YK8pzucCSJV01RK9LOtcyLIVHf53ZvU1Oj?=
 =?us-ascii?Q?AzC9z1Foz1xAApxj/k1hhykdLTBpUdSV3Z+hK1Ude8v5N/CAw3bUU0QRoc9B?=
 =?us-ascii?Q?ds+tLf6gykAMe3cwoy1ArZRBqM/xM3X1T/kD/cw9WGpDEqnQtBxYmm2RM9FK?=
 =?us-ascii?Q?DvXnLZsUjzO1FDf5SgLZnHLgjpUCteHCCHDxcsWYfIFqoTfTNkjCPxVDW7fO?=
 =?us-ascii?Q?RwpggjbZ9mrq5ztajsvPeNEXnISXfYRx2VRI/7n/KTv9IhJYQb5IIKVzQBtY?=
 =?us-ascii?Q?516Vd0/O8bxFop06lE128VTnak1ikRJUgUJVZNueyEkAKUfiQW7jNtWYk+ih?=
 =?us-ascii?Q?yOHYZ6+IRqCAiSFlGs8CEaJiJe1wTkL/kqHIEmjEqxquX7iyX9V1ZeYoeBa2?=
 =?us-ascii?Q?a6Fri7rHyAHYlDX2q4T5714NO3nDWrnDd8Km6E8s9VF/jHJInVpz1Mu3+VTA?=
 =?us-ascii?Q?aDnxxeSVNkHwKYusoFB4AhsUqNsfVP/qI4Bo2kqGRbyyUFIw6NrC5uN5rQWh?=
 =?us-ascii?Q?3iU0jRiQ6R8uVxW6fnN/eU8KB0LZueHCHpepJL8wyoneDhQ0OZDXZA2PQIeZ?=
 =?us-ascii?Q?ToiUonqOZwO1frHKM69M8PUs/VwAVwdYxuZaW5tbcUmXAFTlPnf/CnawQmck?=
 =?us-ascii?Q?piY53sisSyEFK22W/VlynmJDQt/qKzulqvBJynFj1TeLR4N0QyMLMfcZkbvB?=
 =?us-ascii?Q?rlfsaH8NUxNas4lEk1xRhlk9wMZ+K3QiQ7lp+PSIm3uE9qGrIzlE9NP7E9Vr?=
 =?us-ascii?Q?omwiUH8Eu1MUG3WsbLohWUbpwA8DHukfaqo93J7gvReZtml8ywqRjmXiGN9U?=
 =?us-ascii?Q?sAMSxkbZSTTaLKfuQdRsGjGv6V2Vq4ehTTc9CMlOoszmEl2VjrupAvBU8O+g?=
 =?us-ascii?Q?KUgVOihq+w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a152335-5d80-4f98-0d87-08de74ad8391
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:36:12.0056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZ7khS44EN0gbexb1lVZcgns59sxZEuHmYkQzTbAtp8i1zyJMLi5TiVEC1Vx5NztzfKugA19byKKN8kU+9CMkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6817

On Tue, Feb 24, 2026 at 10:34:51PM +0900, Koichiro Den wrote:
> The NTB .peer_db_set() callback may be invoked from atomic context.
> pci-epf-vntb currently calls pci_epc_raise_irq() directly, but
> pci_epc_raise_irq() may sleep (it takes epc->lock).

Can we use thread irq handle()?

Frank
>
> Avoid sleeping in atomic context by coalescing doorbell bits into an
> atomic64 pending mask and raising MSIs from a work item. Limit the
> amount of work per run to avoid monopolizing the workqueue under a
> doorbell storm.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 109 +++++++++++++-----
>  1 file changed, 81 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 4328f05acfe6..c00898ac8269 100644
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
> @@ -1365,41 +1373,82 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
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
> +			 * interrupt number.  ffs() returns a 1-based index (bit
> +			 * 0 -> 1). interrupt_num has already been computed as
> +			 * ffs(db_bits) + 1 above. Adding one more +1 when
> +			 * calling pci_epc_raise_irq() therefore results in:
> +			 *
> +			 *   doorbell bit 0 -> MSI #3
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
> @@ -1641,6 +1690,10 @@ static int epf_ntb_probe(struct pci_epf *epf,
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
