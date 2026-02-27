Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020081.outbound.protection.outlook.com [52.101.229.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA609332624;
	Fri, 27 Feb 2026 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177555; cv=fail; b=mwUBQqXcVfO4r81O2QhB6JgHovLAb+/S/WicAnhwc/LHEpjrvrJ24YXofXfUNDpyBjAsI2xqHekssh00BCmwLz/mZu5YClSz6K8DddsYzVcqKE1NAm6uw3wXQIwGV8Lm5j2FflyztPjBl/L2s87bYp8/xwD7bOnp/9gTNpYmjEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177555; c=relaxed/simple;
	bh=VsWHBQjGYo/FB9PYNnxIoVDvz08hfbVcKjywoI8C4vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=syCHqePV+0xinh0rNTRmkVA7WKfEiVYz5dbfJxTZQKv2prhLijAhU4IjvRMNXYv+5MFNiPDq+nYsSZ38tjTTLR/0C/nR2WVnxxIfsCClhLJ40nmi5D0bzEvLELr81l3oVPZ7la/d2DAursnA9r2mXhvK0GU5AKqm5YuuiOyP3BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FVd+g+yy; arc=fail smtp.client-ip=52.101.229.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FVd+g+yy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzDX6VyTNDQn/HGDvzMBv3f7ZXbGgoLoD2OcYVA1mmpotVA63oIu0VpfWz9ZGDvglgQ8nXMW4kZkiBIprY3zQ9DGOwgV/jn29Qzjw0vt+tiW9M9dS71+0VyWdPm8VSqoqUcPoPN9TjdaCYs03aCzYvyO72OXFClbgj3nybtDvh7BFQDVKWeGapzLEMcakNGBkQ1krrcSxjtjCiA4CFRytNF4qC09RIqBiVhYn9LI785nGtnigJ0sy31eap5RsVykeZ5To0yB2qhuZTfpHfuwGhuaqSSIdI2Fd0BXlrYrmdHe3V/1WoNSpKrL6VPvAzxUmrc/qZ8NwqyH1srTUHJebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBtnTWn6ptji2fyxLcaXxRGeAa3JqfhCYcF/+uuUFTc=;
 b=QQO7Q0G0DOiWh24D+2wkhfuz+RTN4XD3E+mGNoL83ahH/L9e1KgyScuyeZ2rbmpq6b2NeaXuLVpDZTvImlO7YWvDktwKZPoAu+pnjT552QjAQhpolt7U2BGINWcJQXZuXwnBA7V6D98xno0n3jZY69bth2mUmbTVpzXCXr4q2lpMG8/7/5S92KOXlJHZLZjDauLy22X8ePnb/sTkBVHa4lVpSh9FOChScJTkaVZ7mDP/gHN/sjr2kMjGNI0Ys5dNBsnPbVz6G64RcVcN5b6Ay4d5H3fwNneztOyvPeGwax3yvenqScPPB7sFUVXirB/dNvZgvFj9P4b39aPVtM35YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBtnTWn6ptji2fyxLcaXxRGeAa3JqfhCYcF/+uuUFTc=;
 b=FVd+g+yyft9rlemjqX9sO8wo2fnzOlgFo+38mVqrg5Ym2aU4iAYA3zhHhAz7RowkJOirCe+bHq0wUYUJ2zR+VLT3Rlc+2fKf650dIm00rBuZXo98Ao0kYJ/aPCoaUra2Z0wwo3aRHJHgxRknfao8uF2ZPmuYvJYR4YkIFhjfl2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2521.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 07:32:30 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 07:32:30 +0000
Date: Fri, 27 Feb 2026 16:32:29 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com, dave.jiang@intel.com
Cc: kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org, 
	allenbh@gmail.com, kwilczynski@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] PCI: endpoint: pci-epf-vntb: Defer
 pci_epc_raise_irq() out of atomic context
Message-ID: <vg4xjeq72djep3je5w35nuxtt3eixl2ppyc6wayj7dgpmwodkq@inn3ozg3p2zu>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224133459.1741537-3-den@valinux.co.jp>
X-ClientProxiedBy: TY4P286CA0057.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2521:EE_
X-MS-Office365-Filtering-Correlation-Id: 337875b5-cc78-4539-ff3b-08de75d25d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	dV1mRioG/vhVQcTmvfghX+Z+qtm4YB8pWmLa5Tnw9PXLAGB+oNr9rKasDAUzPduxs+oZ4SLp/pb81mHcanPVDz2ptoqNgLxHnsiLJCi3vl5amM8jRniId2J3LmdjUpi80KE7wk3TXxRVj/ALMbxeT8QT0h0XDmqTbZWiDulioZIg0xjnBMPYCmMBDceBv+Ammy6G5GTzTwtZYlPiZeZuixCpZ0gEPW0fIxyhkJS+mEgL1d79waQYIqUHthTxCf6/imnOx4rHV6CYAUIMtQ7NTbpDn6nl2MX4IM9TGzLqK/fvhpNvXOKg73Hrt6192hPLJV99bDZM1S+F9Kg7djcdiSaLlQ4sNfsaBdrupMy9H1cIkEDuAe59QZnmbctXpdhLw3vZbkUfhrnzJIkKt2TtVbBT+eYfCthB/UcG8lfZmSWjyZOoeqV4/L8gK3k37BUOrLqVMqLvO0Bzyzxzgsqz+ZHBi6c0PQwf7qicZDJCu3+1fLpE6HNEwlbLwvqiRI5taFwGiC03Ph5nm9ybEEbYvfo6Rp6JJChrVJA/wG3L1/VHKgEkspl354r4Qxh5qtjfQ0pOKAnTAthhpfSWxgrBJkMIS7f1MZXADVYNDMuqsjM/mCErTxGl9o6ZOxR43P0RZVkHvB+rl65G+8MfdVNaIZ++8xM+pH70Wcy/m7wNoUG4HeSHq+er3me4QPamr7o/i6hkeeJvjvYCf2DK3MeGLZVnjCpT1/T6fo6H6QT054I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PEOSIPmCHui6XuOuo11ouh/t5u2Jw6lGMl6TtAbpKsjxd+g7EfAOd+IeMR5W?=
 =?us-ascii?Q?3WIAmO7reZrT+q9S7lVIQVE4l9PPR8Kgvug1LXCU0wRUkbsYUVVocbMrRMwr?=
 =?us-ascii?Q?+YkDZ8wUIM/eEuRPEwUIq4RY9/vLS0MuOQvTO8IJyiHTPSWHezCcN5/nlVs+?=
 =?us-ascii?Q?BmRMr20iGKid/r9Outr5JCvw4pJ+tsd/KMLww1llIp2fuhyj1p/WeOp22iOp?=
 =?us-ascii?Q?uXyKB/dF3yyCgaZkNGeZpDaPpaPUMUpEUASTTgojMqrbczXDPbRYTjW/bPi0?=
 =?us-ascii?Q?iEtICWZsga4qnPzZTzG2k3u9z8fR+RW6AQeaD0BQ2/b4Ys7gVmUuCmQh70tN?=
 =?us-ascii?Q?JpB3Ed+ooD6WXJTra513tWdYZ03QN87ZLcv+bmm6my6kC/mothcEFuuxTcdh?=
 =?us-ascii?Q?rAS0aeIq8JMghjIW5j66q5KyN7LhKX86xonL9ACPvan1977Swbi5P5X0kQJ7?=
 =?us-ascii?Q?68wyX1peDkUjj1NtTLGaxRgLyromMMsbx/NTNWWwiPslp4UQthA3oF9FvZi6?=
 =?us-ascii?Q?2qHchlyqxci47Ey07+wZ1J2KHNaupdjqy0CbnmXUkWHSyqvfWyEHtkUguURr?=
 =?us-ascii?Q?RRbGnKEw/Te5tqVQVfqFR9navgxuY0F9fjBxKuFBz8LrUD0Wh9E5kBdCxCto?=
 =?us-ascii?Q?vVr8iLY056HSsb0bIoOuL13CNkLCZqIYbyYKvEAraFX8anW3E2FieU6m+yuz?=
 =?us-ascii?Q?W53dThgqmecCosImx51XqjU23wcqJZ9/mjpfF0TqOqiut6C9YcDgOmmIyJxO?=
 =?us-ascii?Q?B09xPgd91ScKItG0Wb835BVHhhDMKzCTHTp47p+D4Rb2R445FxR80wz/iQAc?=
 =?us-ascii?Q?7JlSwPF64Pz9XDEamrw1GVRfYbuXo/4qT1uitDyEeOYLZlcLws+q95RJ+jla?=
 =?us-ascii?Q?zFuyzwkFofPtGzU/1Ld24fTt3C3upgZets9qh6ARdIT+aeoJlK/dKsLEyMQY?=
 =?us-ascii?Q?Q+vHknbDrziTEhWVjN42+rTd+/6G2KXmDiO4BeMncDnEC69n7eQl5znZByDI?=
 =?us-ascii?Q?J1KfQLmJMfeO9D0dw3NyeerlI4GodUjnmD12eJ5lMtIHi3CbXj/wuCA5V0Tm?=
 =?us-ascii?Q?RjWk4WMjYKCwuzT6AeKsy5j0onvYkWA5Q3Egf/9R/Crn8xGkaLH4IQq6gTPO?=
 =?us-ascii?Q?vlfqS74IhpAEuPNSC2jl6iRvZOwR3fmeiGPTZ9+oste94OaTDZFt+pnZ4/KS?=
 =?us-ascii?Q?3JczbVyN5NuZLqQZKoBEy+CDq1ze7rjRG/BaE/Z70T2NAkHHFhhkj+qgE5Ch?=
 =?us-ascii?Q?s/yL9qxzfV+47FBlNeIWCGHjv18afD2s0mDnzeePx7hLtkicmXcVE/QFGEhd?=
 =?us-ascii?Q?vdjOwx92rDw4wvYwdZU/gRz6vGrMeL2m1nrHY6sMRQOqJpbUB+D4MmgkUkIE?=
 =?us-ascii?Q?DPUuHfYVbodzZGLUtmcNJCJo7ZR4T2Hskw7KJAvjY3AVL4GCp+fYSWHjFQBq?=
 =?us-ascii?Q?UFuMBQNGCMwy5NsPWAWmUG5zV4G67q+2UMYYKFG8tUghMPMHZ1zsR2r5d+L+?=
 =?us-ascii?Q?5LuRnnpi/IHtZeyzIMQlXgub3RT5QZtkoT1e/JtoRPPQeEJiY4OPd28FoULr?=
 =?us-ascii?Q?cPYMPFBPIZBlFJCRkZgnalkqn0RsDybORASSPaMsaDcJZLPjjx6fD1hKjt5u?=
 =?us-ascii?Q?p4tCIKf9Te0f1qMk/qOAGt1v+deYEJoWbMIrtKhI8PicX2oVjlARSZ0bkonU?=
 =?us-ascii?Q?4YkURPRL19UjszZoOwmWfcTlw/bzGPhYIRgcszjZ8XW87MpvrK3SMACEclMt?=
 =?us-ascii?Q?xVXMH2RBr+E2smaXMZ+LEtPx7XPFHlId1Q5ReVWqrpMvD007pZRw?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 337875b5-cc78-4539-ff3b-08de75d25d75
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 07:32:30.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSp3SshJ6cxarS0M+64UboH+AeERH+QgAgnQAJm8UPe3TQIXWFkfRhc4pEvE+G2cEC22O8Yg8XW2msvvXvHQ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2521

On Tue, Feb 24, 2026 at 10:34:51PM +0900, Koichiro Den wrote:
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

I noticed that this kept-as-is comment from Patch #1 is stale. The code below
uses "+2" for the legacy offset, so the explanation no longer matches the
implementation. I'll update the comment in v2.

Koichiro

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
> 
