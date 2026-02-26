Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020096.outbound.protection.outlook.com [52.101.229.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8D533993;
	Thu, 26 Feb 2026 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772067743; cv=fail; b=VDHiBjLln/dVU/c/oSu3TGKPAcAzMpuvDkDGtHr8Q9rITinNXLvq90wT/cVGwdWvGtZw+b1SzTJguFVNmRcbDaEP25zHjtPVMDMG292jT4yZanZvnWNbXXzlgBGSKRBzzcExfD/PyYp8O28IFftMgQxXyqwjzRC39c+FDFFZmMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772067743; c=relaxed/simple;
	bh=6cAZeFSE3hEGm0W/mWbI8hHeSdAC6QE4DcqHdGIgShA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hnSsJcGIlVNXFzGYXahvfEz7HTQUnaskJT2gnWoA6WTf7YPJRupJBUV0pc7Ywko1COua1Dtp0ZMPwnFEuV0k3snBZ3qF20SWzP3Ao2fnjrz2jgLy1ok051X7UTGZrklEzx3C3/LNPk9FIO1mUQY4HIWIEW3pvR5kO27Rr8V7ti8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=b1o30vid; arc=fail smtp.client-ip=52.101.229.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="b1o30vid"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCj7BW6SgzZwSz0bRVzxTHLEBbBkQMcM1mPZDmxPd0MwxBDxT6ib4qAgpR/tY8IH86DQxBtaBFmryvR4yUV66hMzRPfAqzWxRZ7FSoLOxm4NpxQPOAEpTt+0FDqaN6xOjtxEpM+PeNEqCmBs5nn7S8ZtrPq8WWdaEMSbecTUhtKxXPG7mHA7JfpVVociKzN5gEccgdypuKzWttEHAKnCncSj/c5O8om2kXJbpK8XYGyK/4hyajEy73/UpxBeF4Rg/4x7vDIbUopkb1lkALOAi6Ix6y0gmty24iTf+F26qZ3ECVAflue7emXAD+PaHS9Gez9vuLtQ7KejxyAXsVgQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAKDlJ7jLgw9w0myVzC7EKJ+YMze9RdY6ywceN27Hiw=;
 b=S/MisqsHaVuArXElISEpsry8RnR/MmovU3RMlemiRKKDi5ABwfVqaS9cL0TQSoKTbkxRFUBPqKLpJTdurOpQS8j9vkH+SeqvdiS6mPdgEMUfCoU6iL1c+3YIZh+LHXCWanGWYk+jK9vIapvOm2Gwu0GBhHTsWwkZhyndSXQt5LjhqmS+p1g4ilHy3oCo+3Ee/2jNzQo1N2+W4xHTrIxc04P11DGjFFSmunhdv7WwfpOQ5iTxD23VYH+oYfbJTgBS2sQDI6kHbhN3AOT+nVycufNge7jqBhuiKwd6eMh1Dw9DQGHhQ6hjXZyjKrcP/Oy2LDm/8ryp3M/XnamcFwHShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAKDlJ7jLgw9w0myVzC7EKJ+YMze9RdY6ywceN27Hiw=;
 b=b1o30vid1279ySQJwKQIdDHSnaGuWsGD37w7AtmSP4u7gbb+cfNJc9xvsRxieCoQmxWyIfQCwGemWVn5Su4piGIjVKJn4kO7+SZO77n387DdCuYfz96wkLdeIUeG0hY67YY9JvaMlu6lC4O0dZjvffaOZUtOw0DjOhmJGJkA75U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB6001.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:436::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 01:02:19 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 01:02:18 +0000
Date: Thu, 26 Feb 2026 10:02:17 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org, 
	dave.jiang@intel.com, allenbh@gmail.com, kwilczynski@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] PCI: endpoint: pci-epf-vntb: Defer
 pci_epc_raise_irq() out of atomic context
Message-ID: <2wkogsnqaqwu2luhpgcxlm3zvvyb2mtnllrropdmfoughtha3z@ximfi7yeblm4>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-3-den@valinux.co.jp>
 <aZ9dNc7ENkqDV-KK@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ9dNc7ENkqDV-KK@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYWPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d35ac2-339a-480c-d56e-08de74d2b07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	mL+Fz+O8HOaYW60fRjgc6htKho1MY9fKjdBV0Rjx3qXC7l90qqveZMl3wTcQWN8h1KIoGfKhZ9zeMqgzx4M9qb0oLEogutOIECAW5YZX4u54N6zJ1KjS6kk7YEH5FXjK1jXcqMZex1QzbADmZLV6B689TEmaWHb6NhwzJ4pMgcLnUYsGDtEcu2/I9SHEgVrTGcBgtQlxEjXMYloKHnJywvaz+6IDki7FqwntdXAVB22aS+wTNWGvMAHem5x4VdvXygtAjlcfQIMMu5QYqOlabpH4uvFy+gIPFqOP1eRClnNfpt0QRKLOyv445xi+2iv2CJexOdxnl4qN/iqolc2L+n4bAFNp/CNOKx7Kzto/GwG9/TUdOX2sAr6LIKwNpg3wveLvK0SwPjaBJRzmtQo/+kdG+Nfy/2q1zCTDIqOqXcIseM0IMii3fWGnjvpc6574+R00/aMp68jPAXfHg04Zxujd/VXNhj6Lrwm5g5L+rR3oEGTzkzP4EUq75VrBODdEok6t6qd00ywtItyTUhBFaftOM7mPmHZYLpQbaejCu7Pq7xJK7Og5TDRTaNSIvw7gBdLyGEdOOM13y/sZ5JEeptIqtAdmYlb0jJFNsaEYX61IYhIaKTlt3oh93rAbr1hWgruUB/osHSp30/ozrXTVhqOU5larmSH4KA5x15KN6jl+pzohX8KfK0f6hRSniQ4qrmYZIyTEBJS12sadVDdFKeFzqp/2wLNPb0NMuMyR4RI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LxX7yiAVf8Ow+RdLTR/lYH+wH2VsBEYqgYz5h/Crd3ZUSRZoV5mKAn2wu4Ud?=
 =?us-ascii?Q?aUR8YlkSjG6ZXfFhCyN4oEWaeHk7RYzDrirdHHj/SeJyzCBG4mlrYzoEr+Vb?=
 =?us-ascii?Q?kJOmljKttH5zTZXpD5W98I1U/5zu5DNprzhhC9LPQ3vjHF3yJTRPse/4tS6B?=
 =?us-ascii?Q?+Szgu/0zX0AsETY28yDpXBmbD1/7v7gpomLBLdcJHh9zJYqswKFqRrc9kSI0?=
 =?us-ascii?Q?xfU2YpCR1X/jeQgn68c4vqwrPLbZtW6OW0jUD5IQlV2+LNjEhENYbx26xiED?=
 =?us-ascii?Q?WKtVINiAuvolA1eTTzOVwh32WjtoC/USu2i+F1nt5oYU5cZn+GRepRxX2ZOo?=
 =?us-ascii?Q?4kQalf9eesIzRSW4MNmaR3bphyBK8JlyVldh11fHoudWYpKoNP9Dy3kK/gax?=
 =?us-ascii?Q?0JGQZEO1tzYHrKKflO/IB+b3chtgDjBFfVb8yIUXsSFihXLqKIttaSwGAXUh?=
 =?us-ascii?Q?Y9uCTkkY7vdZl/OdoL6vIdHUEhvWDHVNlTNWbQM4y751LOwzfMaQyb2gKB/e?=
 =?us-ascii?Q?m133i3+cCroZvLIeh0uCPr5zA1Gd/6Z1rlLjv7kw51JhMAB+qzN5RdJ7M3jc?=
 =?us-ascii?Q?9V7W/pVijWAwfMgEiXBIC38F8W9spd1+TQrjw/Jf9Uzg6+vYzgnsSQZfSPP/?=
 =?us-ascii?Q?8YBle6/AtMUZq4RceLkx96SpquTdaOg92nR2kYm3rn0kLPAlCZcShBlp9mLR?=
 =?us-ascii?Q?7J+MNSAQBUa3CGXnVJd6IrFySM2B05Co0aqa0CKargh4HG9chQVHxNyUazEO?=
 =?us-ascii?Q?xoxmCVrqV5QzW6978zJUPoakwoXUJPAEC4cqpUA6Mq19YQ72LHGT/gpbrcKE?=
 =?us-ascii?Q?UaOCQxMUESEhld10eIIf2iBj/VXhSOXH+1NN4ukzQ3uNHYR3aaxORmdpJzfe?=
 =?us-ascii?Q?2y1Vf2/JFYlTLUFgo2PSQtux9NlcsebnvaCcRrUbUgsTA2p8rvkfU9zJXaPM?=
 =?us-ascii?Q?iBHBt0HXz+Bh3x87/V3Gt6AX0aQbL/KxuB5etfxFIIWw1vRMP3U7J+4qMs/N?=
 =?us-ascii?Q?t6dIi/ln5gX1X19g8GAjsnM8N2YPMQrbvzPlDZ2qsziAVPhXAOP2DQ06TbD9?=
 =?us-ascii?Q?sGEg/X9gsgYaVwfVInmWnU4W7MOaVi1UMzV3CI8pTwFk9lars8FkWZsOcAWo?=
 =?us-ascii?Q?t6psdCw+L3NTLc0ogHFjrCnYagWYkz8vUJaq8FTZKDVdkr4kRWeW454oC8tI?=
 =?us-ascii?Q?rH2fBO0RH6se1cv8HW1MQM7Zwm0MbxY//sTKTN5N6y2apptgCqgkVujNK7ZQ?=
 =?us-ascii?Q?ecKx/2B8z2qPdZ5SwxBf0HgkbCwQ8KdiSRWQH6qIMwCgCfP1Md2SZ1k6oIyZ?=
 =?us-ascii?Q?j3zZVLBlYACvMZ2ZdR4UGaoheMRkj4tdUmJlRgRw1vFyb4qtwUhTFCZ87Tin?=
 =?us-ascii?Q?mQcm9Kz7OLwwpbiyDXIQxPy5Rz4Wqbqyjlb6tXCC/D4oI4FyVOlrFMpUV6sr?=
 =?us-ascii?Q?Yk4upfDOv+ZgbStrZxIzk1HStq8HTOPodSt72nY6BhBXyk1GiHi64pLvc1zx?=
 =?us-ascii?Q?doe0lCstIaXego4TxK70x176DWTQqMstNENj7JKjqZsPmdIDreCGvhtz4njd?=
 =?us-ascii?Q?/1IQ/XfrSyzuB+ZJLk7NOyx2qDCgvXGVJCohflkyPpLTcuIQqS0bhSI/yKED?=
 =?us-ascii?Q?sJKwZ8bvMhfkXhczqEXq/J5thRuQypDnlnKcIGwD6zvT1I8rW+dzkbYql/Tp?=
 =?us-ascii?Q?CWXQx8Hq4FVaUiTKISDS0AfxmFBeyDPAZ5rm+5byLMSCMFBQ7KwaHyQeUSl9?=
 =?us-ascii?Q?BCrDzhk3+sEjmymGhATL1YpWYaPuNtbTSblkHuQELW/YfvleT5Pp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d35ac2-339a-480c-d56e-08de74d2b07e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 01:02:18.7276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PweOsZBj8sDfAv2ZU6KYuJD6SxtDQHZ7DED3jauBkfFX0ynJrD+YbEhXp6qVO+SMzOpSF55InGxDRhkx6GoVWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB6001

On Wed, Feb 25, 2026 at 03:36:05PM -0500, Frank Li wrote:
> On Tue, Feb 24, 2026 at 10:34:51PM +0900, Koichiro Den wrote:
> > The NTB .peer_db_set() callback may be invoked from atomic context.
> > pci-epf-vntb currently calls pci_epc_raise_irq() directly, but
> > pci_epc_raise_irq() may sleep (it takes epc->lock).
> 
> Can we use thread irq handle()?

I don't think so. ntb_peer_db_set() can be invoked from softirq context.

Thanks for the review,
Koichiro

> 
> Frank
> >
> > Avoid sleeping in atomic context by coalescing doorbell bits into an
> > atomic64 pending mask and raising MSIs from a work item. Limit the
> > amount of work per run to avoid monopolizing the workqueue under a
> > doorbell storm.
> >
> > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 109 +++++++++++++-----
> >  1 file changed, 81 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 4328f05acfe6..c00898ac8269 100644
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
> > @@ -1365,41 +1373,82 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
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
> > +			 * interrupt number.  ffs() returns a 1-based index (bit
> > +			 * 0 -> 1). interrupt_num has already been computed as
> > +			 * ffs(db_bits) + 1 above. Adding one more +1 when
> > +			 * calling pci_epc_raise_irq() therefore results in:
> > +			 *
> > +			 *   doorbell bit 0 -> MSI #3
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
> > @@ -1641,6 +1690,10 @@ static int epf_ntb_probe(struct pci_epf *epf,
> >  	ntb->epf = epf;
> >  	ntb->vbus_number = 0xff;
> >
> > +	INIT_WORK(&ntb->peer_db_work, vntb_epf_peer_db_work);
> > +	disable_work(&ntb->peer_db_work);
> > +	atomic64_set(&ntb->peer_db_pending, 0);
> > +
> >  	/* Initially, no bar is assigned */
> >  	for (i = 0; i < VNTB_BAR_NUM; i++)
> >  		ntb->epf_ntb_bar[i] = NO_BAR;
> > --
> > 2.51.0
> >
