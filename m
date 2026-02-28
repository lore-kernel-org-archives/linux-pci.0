Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020142.outbound.protection.outlook.com [52.101.229.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58237246335;
	Sat, 28 Feb 2026 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772291481; cv=fail; b=krF29CG0sYvFr1TzoSFYFC70RJXRNG7sRCt11LpiRTnrWX4yeqKDOshm0E+KaueDpg74JbrhnJO3TYL8PDqpktwu5VJHITZQwXsvxYvHOiusb7RlTfLGEB2GkRQZljLHn4iESBf9He/zQVUfJ267nfTctZUKsXE24FnDtAw2Sos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772291481; c=relaxed/simple;
	bh=AAaQfoJT906l8Y8IV+uN2MYqu1nQ3gZuR45LBVon2QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nllRm2KgYJJy9mJ2s8vU8ghPRMLYKoraYSeACv0JdVkGNy6dG7OAEniIrVyc0n8FpJP1kGPQvaWZtz661L+2Ra0R0kiTKL+RwswtDEYNgqWUN1n7aajT+WMm/WHl0bOCj9gcs2bPurQV2L6rQKzuHvuXibR3IRoY4Mg75aKjCjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=h9cCm1gH; arc=fail smtp.client-ip=52.101.229.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="h9cCm1gH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4ybysMKsDkbvUtcJOCa09U3YWddo+mq1DDlWQh7NFstnrhWOP0rHl1gfm1ilW47S26kWDkmQu5Cy5XmZWoe06I1WFGO3BW4cMO7IqxuEdW9YRz5x3bUz3SUmz7zlha2CNXXD+jiWYEfYfUAAUdD2vVKAZLaFSHNAQamd7gyxi++Kruguy/dCHYyzV8Exc3udLEz+Ui85qktje2oH1hLh9rlIodH4T6EwjqkPfOkf4G2PMcwHgnuX8bfiT0Q6OcPTRbWku0JvSdQe37OOTNexkFoaVSEZhrPoTQefE9ZbGbvbifeQSezgJUyjFO/MdKxqP7o1Fm/SqnYfLYjbem4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRYvMM8iqSKISQjXrG8iXWT3W4IVGp42SPSTxmjG5qE=;
 b=pLYgiQUroh0vcqj29yT0nS3jR6YbN7Sxod7vviXNAghyZCxZGCMH5snyW9yKIJYqQYOw2i+pR5BPw0r5Bs3GfxayBkBk9FgLgyY8OOL6koZH0jUHqowPJ4P7SXFCJKZwPewvFksQ8btyQHeOEgCYW33zVI/svnW00k+YrL1Gv9Xuy/b9IYVfy+8FDVy+C2YZ3LuHr7XmOFrs9EPSZgKGuHLhTgWjADNsS8nlA5+aqVUoRnbyAK3JNR4in3SlheMwkV6sNr4oAitmEUDFaHWx44RCWehHCo4x0nWkgsAsvCeXXHgdS9OamvNtm6WNXkm+DFZdzQPs3hMmpwEL1gGkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRYvMM8iqSKISQjXrG8iXWT3W4IVGp42SPSTxmjG5qE=;
 b=h9cCm1gHmBHjrNsLeAxw6ysDfkd+R3LWHN7M2SQEnYW7iLbrjYLS+YGUhp7Itp/FP5N4D8cjL6e748gGrotHk2PV34ZFcJWupFFwmuRyC9CY/2ACFhSj4Fq1cdKGjd+L8H7RGYoowDYOH+dv4tMMdSkX6YMG4OJUNOQv8LHJfoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSOP286MB4115.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 15:11:16 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Sat, 28 Feb 2026
 15:11:16 +0000
Date: Sun, 1 Mar 2026 00:11:15 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: dave.jiang@intel.com, kishon@kernel.org, jdmason@kudzu.us, 
	mani@kernel.org, allenbh@gmail.com, kwilczynski@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] PCI: endpoint: pci-epf-vntb: Defer
 pci_epc_raise_irq() out of atomic context
Message-ID: <mdiegysgm37qjukt46shpnttqxkaep2mbbl7pwlcm5aocn3tgv@2ybxnp4s2oyl>
References: <20260227084955.3184017-1-den@valinux.co.jp>
 <20260227084955.3184017-3-den@valinux.co.jp>
 <aaG9COYXPJamIvTx@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaG9COYXPJamIvTx@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCPR01CA0091.jpnprd01.prod.outlook.com
 (2603:1096:405:3::31) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSOP286MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ad5375-834a-406c-ec62-08de76db9e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	0ckwQ0+LwmPy84sA1hTicKLUTzgjCmFgnTR4vQJbPwlUpNmuqC0IkmyLjKo2ZsoLutP3sQnrCEG8O+RmUxj74AqtLdmN72R/31OMYDvvG6faakGIEsyRznWcywxaG8kD6oSVnpVH0p6wyqr1iRjzWa0g1Jt0b7i+e4kqdvPrF25Oa4iW73Bjuy3xfH2Gv7wI0ymYpad6ucotWPu4KoijWb9RXPJbS/KcMB57lneHvHQEOVrNyN6bxlhU3TaBMf3bEkU+T4Pw+bIKPjvWtp44/qjUQPrTx+nEnm4s/atMWrWxXK9KLy7zgh41YIGSFKhX+b2nSxm3ZSmXgrxjuCo6Srt+oB6HzMsab52ADswXSX54jhYn6Y88XEReYr4bflaa6QFrR+3ffMF4I5hVJeoH9sRX3Ofp7J454JybIQg76PbKIFM6ez1uzuyU0BAvsT2kj/lPlRtRbSTyGwG+nZ8CVYGrzhxNFYKFBVtwAS7DYLIvnELkKJClQxay71xNXe3CP3MZjsImOHXmHBr12djxEyjHZDEtG1GbxK66i+4LJp0ilxaFgqJUP3D/z0mobLRlfVfHuBsfYKCgCMxuf7++AP2bPcTypJVLQUsl79NHb1N45x6Sy39n9/biNnhHvWwKN0Ik70c8EUeTbzbogfmqYhc7Db1Bt35lJnJLoQkU+q2co3dWcELaQiSuVfPd9Sp+3kqkKdru7wKxl4QzbF8AAAPDN4A/BiRqeM3B2Eo+JzM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/y00J4GlUyfpYyLxtdlOKV8owsDYX4EdLIlOCgkiAgBT9Ct/8nIjCZr8vyKe?=
 =?us-ascii?Q?Oma5WK0OBkdkDqqxPHtDwjkfoE1P0+qobC99Y5eIPX3uAj/Ynjg5KJkT6otV?=
 =?us-ascii?Q?ltQbArWr4+7VbAC27Q/5/sG7fyvQRCdPw7YBsG+wb8/1uiOe0G0OdYTKVaXm?=
 =?us-ascii?Q?/V18PACfoj1KuD8CnTLGgb+wvdf8Dvsz+hgsnjIBDj7ee66Tv0XwUrUZko8i?=
 =?us-ascii?Q?7YfWxJnPpiuyvZAmT4ZQ9Da7WquVzSI7jvGVaGKg2pWSg8uh4utMcNrmaP4N?=
 =?us-ascii?Q?zLLOrPnzYCtt0gVukklj7LFgaJ7R3IR0AVjbQ3as4kpKe3bzoEB9PpTTmkj3?=
 =?us-ascii?Q?SNkDcmGwZT1Bq83ZOZ0It7si8izI7Pb/gSz8nTnIQhm/wwhUTWL1p4QPu9BK?=
 =?us-ascii?Q?z01wVb0yE3mbIPL/klCrG6FNzu88AuW82iirB81A1whGGKxbhtJ0fGGuBqf5?=
 =?us-ascii?Q?M/jYFCzKvCZgjZWqQPgaOg4aVtn2O7F5/0r5H4d/O9c1xCrd4oaTv7VckUHD?=
 =?us-ascii?Q?+LGyDqGs3Kv9NPVfpMVGaRKZNztCvfXx2+cHFNch0/0f7sSQSp/66rVHMfpH?=
 =?us-ascii?Q?cMe/JbE2V9qqjs9TMJq1a0jIxpIEFSMCK5/gQHjp7zKiSEl+nPek8/4oWRj+?=
 =?us-ascii?Q?mYBut5YqyJFAZp9Rb6+7yS0RRZJTiFTn9m9W98cgdhSFEn9NjFwYIXB1wbzl?=
 =?us-ascii?Q?sgdgPA0SNUGrTgN//dO7En4Qccqur/o5guTHNed7YJCNuGL2zCFYxyBIri4p?=
 =?us-ascii?Q?GbUrrPLElw0SwKfp5AgrcQ+/kSd5lQzTVdRTPIYPGOw/CHDEUKdduSneHPUO?=
 =?us-ascii?Q?5l9SxfmQmmd4eBcaV+SDTLSMTu0u6e1k1jFymRYFSrZTzzTlFBdn4yS4qCC/?=
 =?us-ascii?Q?hO8RPfN6yS7n8v2Qm4sk3JzGla0Ez4/iZYHsKWCw9CCLaCxrKQvMTPZ0lEmk?=
 =?us-ascii?Q?2E3oWvxcdjHQ+apDB7hNs1Lk+qem1NVA6chPa/3Nuwvd3VbZFY+OwnzHSsbb?=
 =?us-ascii?Q?P8N66jnQPMkerBR0kt7tnLMTljUVn8gVLT335Iurs8HqcRv84DXM186Mvset?=
 =?us-ascii?Q?1JkcEVdzjoXZ25WLPJyl3pFGQ1wQQeHie2lk6apvXKb0anFgE6EkzqCdOeBn?=
 =?us-ascii?Q?s2qTEQAQIp79OTawhPC2JqTC6cjLchJX+8QKfFGdpdan5/lwAaJ7Xiv3qLdh?=
 =?us-ascii?Q?18MDnD3GER4wOmvMBICY+aBFojXG4vjrIx8c0zf1g0C89QWcJvjHcvU6/FHn?=
 =?us-ascii?Q?XeVX205I6W5kbN16ja8IlQSIcBWJUpjenw4S8bO2Ob0+mJYJRwfwIl9D9LZW?=
 =?us-ascii?Q?emSkMadg8d4jHrzTXzBFJlx1GaM4fiJqy4yoYkBoSczaiRIdTure2f69SC+c?=
 =?us-ascii?Q?rFjpGZ16Cn3VeYYuEfjfIVzUA8hknHVGRW1jgQ+domMDjeECOUGJCkitoowt?=
 =?us-ascii?Q?j0mjiW8RFWnIs3KX2uWrFnr6AkXIgJJu6EsFFsWwECZDTvqlDWNEPJ9rA7Si?=
 =?us-ascii?Q?krTrqf25S4R+AXv9/xVsXWDDPx2F1+nJaLydWaeVt99tTLi5i4+3XxrDvPsS?=
 =?us-ascii?Q?I4ph7lw9ZjzJTvORBzDflgX21eSglqcU35RWzyiSH9KV+/QGF4YLCyawrAOb?=
 =?us-ascii?Q?5dQrnqp0abosYt3NlXUPGgAQnnorNzUv5nySKZAROOv1ROPZCS6TZtXgBVW+?=
 =?us-ascii?Q?B2z2RvBTI6GpbSLobau5ZhRo+Cl1BEmd92NcmreGAhhKKi7CokpTAA9+WxmZ?=
 =?us-ascii?Q?pBNZ+JEW+AOHliZnHoBsVPJl3pW6cc+P3u+yMlkgh9Xxoiq+mjjN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ad5375-834a-406c-ec62-08de76db9e7d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 15:11:16.2702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpLPXOfnv9JqwKJo79cMccizaGQ+v9LPeRhLvwwO1EB5dUbjJt3takGQuN6PrNQ0R4i5lu63q8m/FzoTUdGg0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4115

On Fri, Feb 27, 2026 at 10:49:28AM -0500, Frank Li wrote:
> On Fri, Feb 27, 2026 at 05:49:47PM +0900, Koichiro Den wrote:
> > The NTB .peer_db_set() callback may be invoked from atomic context.
> > pci-epf-vntb currently calls pci_epc_raise_irq() directly, but
> > pci_epc_raise_irq() may sleep (it takes epc->lock).
> >
> > Avoid sleeping in atomic context by coalescing doorbell bits into an
> > atomic64 pending mask and raising MSIs from a work item. Limit the
> > amount of work per run to avoid monopolizing the workqueue under a
> > doorbell storm.
> >
> > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes since v1:
> >   - No functional changes.
> >   - Updated comment in vntb_epf_peer_db_work().
> >
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 106 +++++++++++++-----
> >  1 file changed, 78 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 83372aba5106..e2c0b6dba793 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -69,6 +69,9 @@ static struct workqueue_struct *kpcintb_workqueue;
> >  #define MAX_DB_COUNT			32
> >  #define MAX_MW				4
> >
> > +/* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
> > +#define VNTB_PEER_DB_WORK_BUDGET	5
> > +
> >  enum epf_ntb_bar {
> >  	BAR_CONFIG,
> >  	BAR_DB,
> > @@ -129,6 +132,8 @@ struct epf_ntb {
> >  	u32 spad_count;
> >  	u64 mws_size[MAX_MW];
> >  	atomic64_t db;
> > +	atomic64_t peer_db_pending;
> > +	struct work_struct peer_db_work;
> >  	u32 vbus_number;
> >  	u16 vntb_pid;
> >  	u16 vntb_vid;
> > @@ -933,6 +938,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
> >  	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
> >  	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
> >
> > +	enable_work(&ntb->peer_db_work);
> > +
> >  	return 0;
> >
> >  err_write_header:
> > @@ -955,6 +962,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
> >   */
> >  static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
> >  {
> > +	disable_work_sync(&ntb->peer_db_work);
> >  	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
> >  	epf_ntb_db_bar_clear(ntb);
> >  	epf_ntb_config_sspad_bar_clear(ntb);
> > @@ -1369,41 +1377,79 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
> >  	return 0;
> >  }
> >
> > +static void vntb_epf_peer_db_work(struct work_struct *work)
> > +{
> > +	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
> > +	struct pci_epf *epf = ntb->epf;
> > +	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
> > +	u8 func_no, vfunc_no;
> > +	u32 interrupt_num;
> > +	u64 db_bits;
> > +	int ret;
> > +
> > +	if (!epf || !epf->epc)
> > +		return;
> > +
> > +	func_no = epf->func_no;
> > +	vfunc_no = epf->vfunc_no;
> > +
> > +	/*
> > +	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
> > +	 * Limit the number of snapshots handled per run so we don't monopolize
> > +	 * the workqueue under a doorbell storm.
> > +	 */
> > +	while (budget--) {
> > +		db_bits = atomic64_xchg(&ntb->peer_db_pending, 0);
> > +		if (!db_bits)
> > +			return;
> > +
> > +		while (db_bits) {
> > +			/*
> > +			 * pci_epc_raise_irq() for MSI expects a 1-based
> > +			 * interrupt number. ffs() returns a 1-based index (bit
> > +			 * 0 -> 1). We historically add +2 to compute
> > +			 * interrupt_num.
> > +			 *
> > +			 * Legacy mapping (kept for compatibility):
> > +			 *
> > +			 *   MSI #1 : link event (reserved)
> > +			 *   MSI #2 : unused (historical offset)
> > +			 *   MSI #3 : doorbell bit 0 (DB#0)
> > +			 *   MSI #4 : doorbell bit 1 (DB#1)
> > +			 *   ...
> > +			 *
> > +			 * Do not change this mapping to avoid breaking
> > +			 * interoperability with older peers.
> > +			 */
> > +			interrupt_num = ffs(db_bits) + 2;
> > +			db_bits &= db_bits - 1;
> > +
> > +			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
> > +						PCI_IRQ_MSI, interrupt_num);
> > +			if (ret)
> > +				dev_err(&ntb->ntb.dev,
> > +					"Failed to raise IRQ for interrupt_num %u: %d\n",
> > +					interrupt_num, ret);
> > +		}
> > +	}
> > +
> > +	if (atomic64_read(&ntb->peer_db_pending))
> > +		queue_work(kpcintb_workqueue, &ntb->peer_db_work);
> > +}
> > +
> >  static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
> >  {
> > -	u32 interrupt_num = ffs(db_bits) + 1;
> >  	struct epf_ntb *ntb = ntb_ndev(ndev);
> > -	u8 func_no, vfunc_no;
> > -	int ret;
> > -
> > -	func_no = ntb->epf->func_no;
> > -	vfunc_no = ntb->epf->vfunc_no;
> >
> >  	/*
> > -	 * pci_epc_raise_irq() for MSI expects a 1-based interrupt number.
> > -	 * ffs() returns a 1-based index (bit 0 -> 1). interrupt_num has already
> > -	 * been computed as ffs(db_bits) + 1 above. Adding one more +1 when
> > -	 * calling pci_epc_raise_irq() therefore results in:
> > -	 *
> > -	 *   doorbell bit 0 -> MSI #3
> > -	 *
> > -	 * Legacy mapping (kept for compatibility):
> > -	 *
> > -	 *   MSI #1 : link event (reserved)
> > -	 *   MSI #2 : unused (historical offset)
> > -	 *   MSI #3 : doorbell bit 0 (DB#0)
> > -	 *   MSI #4 : doorbell bit 1 (DB#1)
> > -	 *   ...
> > -	 *
> > -	 * Do not change this mapping to avoid breaking interoperability with
> > -	 * older peers.
> > +	 * .peer_db_set() may be called from atomic context. pci_epc_raise_irq()
> > +	 * can sleep (it takes epc->lock), so defer MSI raising to process
> > +	 * context. Doorbell requests are coalesced in peer_db_pending.
> >  	 */
> > -	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
> > -				PCI_IRQ_MSI, interrupt_num + 1);
> > -	if (ret)
> > -		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
> > +	atomic64_or(db_bits, &ntb->peer_db_pending);
> > +	queue_work(kpcintb_workqueue, &ntb->peer_db_work);
> >
> > -	return ret;
> > +	return 0;
> >  }
> >
> >  static u64 vntb_epf_db_read(struct ntb_dev *ndev)
> > @@ -1645,6 +1691,10 @@ static int epf_ntb_probe(struct pci_epf *epf,
> >  	ntb->epf = epf;
> >  	ntb->vbus_number = 0xff;
> >
> > +	INIT_WORK(&ntb->peer_db_work, vntb_epf_peer_db_work);
> > +	disable_work(&ntb->peer_db_work);
> > +	atomic64_set(&ntb->peer_db_pending, 0);
> > +
> 
> Does it need call disable_work_sync() in unbind or remove() function?

This patch (2/10) handles it. Please see the changes in epf_ntb_epc_cleanup().

Thanks,
Koichiro

> 
> Frank
> 
> >  	/* Initially, no bar is assigned */
> >  	for (i = 0; i < VNTB_BAR_NUM; i++)
> >  		ntb->epf_ntb_bar[i] = NO_BAR;
> > --
> > 2.51.0
> >
