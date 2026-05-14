Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A4391508;
	Thu, 14 May 2026 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784850; cv=fail; b=DuSSpG4z5zVcW9s9IUImN/jQ5bf21frQPDbVkLziXiSHqcc0k5EQY7CSrGIFl2139bWlOeVIcbk8kwNZnP+8PKe0A1EUECESb7W+39Shk+o6tA8RM3wDmAwWA0Wk+gCaRm3XQ3EL14fx2JNG3CAkSoPH5tBSfFI7iZOKkIncAqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784850; c=relaxed/simple;
	bh=VdHNqBCfU4tOFKcslNFsjD3UY4msKczaPaSofy4S5Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YaPtENm581u5LEfaizuNRAVrQle+yy/Oz6h4XbSF6HeRkYMYToyUxW1ufkgdm68Q9IQXXLdaipXNMwJHJgDFIMAswzqd6lZYA1E23JtrhhoV56lFtugFdzY5lMhywAjAgNPHjCsLQHTfXak9t3zZIuqrUhJ9MxrzGTpyK++RVhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KCGr41aV; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KCGr41aV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHvvO9e+/M1rYp+bPL9Ka2W+CezDkP9N0Q/ahIrUodfUHrLhX8h8MgXudUBIbuY2PSJJa0+Qq/a9DLBykpCqOtNk5pLDNJ4T62rb14yWZYeS5taVnyFT1H+zckUQ5rgyEUDbEl6E1BqGXBUN34YvKO4ULCDsY9DM4caw70MsTfvAC+1Lny6exPM3oh6HZvt7nLAm4fDj5wXZitEWPib5u1PCMNJ8yxywvj7Ax0uzvj3c4f2I8Rjs6C6ebpkRZ5ScQKUR4LVN5/dWV37lZI4cjkB7wEtwlk08Ewkt4gLz6ydtqb3q91XEtLh5sohl3sp3eyqXjtWmIVwCwCfx/zP0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpU/UnSrp6gogJpSTxL08jz96+kGHjOqeDI0gX/Vujs=;
 b=oJs1+M/vTsNYvzqE9MNSXM417lN3OYfImT7iADiTz8mW6a6TDn5vK0jQ4lnva1f4JfNI02UdJtabi0ulmc+xLmJsx8lYGhjMAH38ksrMUOO4TJSI24urld+EaL52xRfSAt80X7rQHdXLKQ8L4Fhlo5xrhpyJ6Mk6kdWj3vVN2GdzYm/R5Im+YUVTfpDMHTECKJNodmt+F5oErpUhJVLDG3eLr9uzTjMRe0oy8ZC2PKlJV0K09YJqS2ZG4Eu53PuUpHHiXQeA2hE7oMVnVNn1p2+mv8m2Ve+lj8NbLDtRgRx5fW4Sp4inbcUxJtN/FqPRyPISMQiHB74v6VVU31DhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpU/UnSrp6gogJpSTxL08jz96+kGHjOqeDI0gX/Vujs=;
 b=KCGr41aVyKpScnqKF9WxyVfivtI7gKvOj7MbcpbwRAnhCaAlmCv+GrIPFHBArlq0bVFRdmsbb9+Rj+c/6V8o9dLsPjIhsApt6CL153PV7r0A156b5bsdBNJ3gPuF5R5Qla70vq4UuNolV3ZG6ZZYL+lm2lFJBW4S1+YbsfLBeHwodiE0zepn0DTMs/abPWrGT+wvXxRaeIi+Z/ZWVwnjFychG3355iBr3IVkj4PAxFLrws/VkJ5wezv4RC3d/flld2Ssiz5U9KPuyiJex2qH7FlLh/FQa4fcq+vCACAQ+p5L042cUqol6n7nKMd7U4JulTGUIsA810+LfvJpvSDBZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8355.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 14 May
 2026 18:54:04 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 18:54:04 +0000
Date: Thu, 14 May 2026 14:53:56 -0400
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
Subject: Re: [PATCH v4 02/12] PCI: endpoint: pci-epf-vntb: Defer
 pci_epc_raise_irq() out of atomic context
Message-ID: <agYaRIy41Nn0SreN@lizhi-Precision-Tower-5810>
References: <20260513024923.451765-1-den@valinux.co.jp>
 <20260513024923.451765-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513024923.451765-3-den@valinux.co.jp>
X-ClientProxiedBy: SN6PR16CA0067.namprd16.prod.outlook.com
 (2603:10b6:805:ca::44) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f619cc-dc43-4d3d-c077-08deb1ea2b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|19092799006|38350700014|22082099003|56012099003|18002099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	in6jyaFfTbOrUET4pZFkLKbXk43e8wAk+jcxLOTjBVRsSC8ZyoaZJ5QEeu7qXkOcrh6ZyghHa+1Rx2SptTYWoG36tXFIAGS+jyY/2U6hklvsum9PLZAsazgt62Bs9VjSgju7I7E6j8Sxo+N0Ic2IsWYpLitSxJDD1aZJPXA96WdlSc01Bcx3bAMLzPwgRyjv2eu74tsXtXV0DAW3m+ZDgGCeS5LrsBA72iasmyZWUGJ6wX7zYG1e9GciQpFNgTQfaNm9UJ+YLqTeWkg9rk7AM/IBDmTIMye4wyt65lXLIk5tg37GY4QxeVzWCPhoUAGYKrI3mizSS2Jv+Ufv/5ZR40TvpDp//eM1mwSSN5MNwI95WgVlB9iN6coiOtJwMRBu85u+AkGF6fpmlxr1jbhmuaG372AycnBkXAPSIRa6FiCXqqToaL5ZGF1bZOzVzVsI1Hq45+VhEBAoQ4t/srXvayZ9ZiFucXQuI77jgydMf+CqYprHqxlI1JjBYuvjASQxrPlc/yU880rLlheBR0GlLwObhPg7OGIMCSSF1Jx+sNv1Ae4sgox4c9L5lk0RX8kBaTKeDk+hlSUNw1XMA1d+L/LkuHxu67syWlkAEanefsCvRkgoH/lPK5xm+1ij3I2G0z5zPrD46UQSgWf4do0W231zaHDorNpm4kc/RqPwmQSngaYya0Nr8/VXMP3rkZA13EADNjk6usdv30VReanZI1mSeOQjIaWjvlrFYXj21rIwjBPkBjM/2ckEoX6YCJSY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(19092799006)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0l/CiNin7VcarkVuihtf7oF+esJ+t7dVdPfwSl3IxLSHQ1Me/Y9FIjI6n0QD?=
 =?us-ascii?Q?nMAHCQPhbUGATcCyHe/xAv1Y2VP24WVrsylBfNNCfWWLLgqaZ3/BhtFHfiUH?=
 =?us-ascii?Q?4NC6C90NYn9xp0DXOQuVSGvwtHz4yc7+5FrUnLhgSM+MrAnskChpq633gIRR?=
 =?us-ascii?Q?u9thma9AfUJDNJGvBJpHTAxTuxI1sssrkY6TwNyBgt+SA/HRKE+HteC+aCWS?=
 =?us-ascii?Q?bbukK+fNLo8ts3ZgKKNv9705uphzAcBLY9pCuwc8IE6WJu9HJ3s+Cr2KBKrH?=
 =?us-ascii?Q?DJEmEl37kZh6z2ett5+bWgfkW/IdpKrh7ZBDMetJSXRE4JDvxE3Y2/UuCjFa?=
 =?us-ascii?Q?lm0HtFWpILjX52fAGO3PM44W+Gt2Nq15CeZVhyI//xwOW21BWc0/NEUwjVvy?=
 =?us-ascii?Q?dA6rD8e3nUh7+5w2DTiB3FNGTtFrXMVy1VU2KLQWzVPHaCaxQUiippZAds8j?=
 =?us-ascii?Q?dwIB3lXMWrZDguXsjwyLLSZRBhmRa18zLm/iCAUZqWbpfFbMvM/bUKCUZDsI?=
 =?us-ascii?Q?F0FEZrk9mVOfPBU9PS1Mu0EM40VoQbL6F0//SZ3OsFXS+bPHWb4AyPOWYYRF?=
 =?us-ascii?Q?6W7GHOFsdXtO5zT3Cy17k3bLww30ThpYxxYK5LuzLw19Y2EZKxBDCvjn2LmC?=
 =?us-ascii?Q?bgIjx/QqZIrle1Y+ZzR4sXu4NNWU5I+bOLLsYyCPDgvuwj82eCoOaqiQzlAa?=
 =?us-ascii?Q?OEkrhyd5UubLm69iTnVqkAODqUb+LiMfDnjsoLDdTHZ/QlPpQkGIby6huP1/?=
 =?us-ascii?Q?x9oRqXdyWDSY7DJtan0oSv4ygOEg8JTLUXczdU0YrnPDIDmRFPVCWFGGcONK?=
 =?us-ascii?Q?+Kh8k62O++13lW261t/IF9ayjGQpWSxtN9iu4WHMgyBmNgBj4+8qHImC68Nz?=
 =?us-ascii?Q?GRZPydebvnb7QjQ0dXJNU/NwAfZ9dvLqefKuJKO47CrkWxLHLMsSCy3ypnM1?=
 =?us-ascii?Q?Atz283b4vtCEQAi5I99Lr7gyqjbj3ZkpQhOF9qWNjMX3KBZDjyTKYwZXVGqy?=
 =?us-ascii?Q?sQkz3U848TjSW5JOXojTmVwNtNt3O/eGH0nr6y+GmLgdiJ6QMgaPS70cICbd?=
 =?us-ascii?Q?HcajQyglBVd+aQ9tuCyYiY6VxCY7jxryJ72KCuGBQLJn13fbjbXqs/Lz/U3k?=
 =?us-ascii?Q?+EqymCT1SjtvHDA5+lH6/Fq6F/hiJh+Kk7pU8/gwT/uTYNam799/mflRdAP1?=
 =?us-ascii?Q?aa0apHxS8r5AsO/Ahh1uthscbBCQl2kys2fD2HMqY6guslYOLqyfesiK72S7?=
 =?us-ascii?Q?G59AU29hFaFcqMCYNlyEE9NdSEPaurlTAbxfyphRd5Uzw/ojn6NMMd3n1U0j?=
 =?us-ascii?Q?ZhG7AitzS8WPOq157baL4d6HlxFQLvrNt3Sss3Piv4yKoVfORiUkJceWLMlw?=
 =?us-ascii?Q?ZojIaJqqPeiLO9f5DOyWlEgUwb//30fli1eVw0WhXnH8c4/PbxXUSCvA9W5i?=
 =?us-ascii?Q?pqxXmFRTvLH/YehdC3m2+ibWuT1k1HbpEiN+lrbzp21P63KWZ11B/gwd6Tyd?=
 =?us-ascii?Q?Ix/sOoe0LdytNfFMAlaw5sW9Ue0UUyREUBNo0BDr5rYQFX/Jv8nMW+zk9yQl?=
 =?us-ascii?Q?NpGMxzK5+ieSOpsbdPt5IUJZQcBmkfc9RaHS7cbmhV7jHf5t5IoKiyLViw43?=
 =?us-ascii?Q?OH/pWHJtFSfXmKYj8GhPffmlIqnEGBxy+nU5D6OPhDuzf/VtI5k/5kNsaSs8?=
 =?us-ascii?Q?Ez2P/0YzstGSSk9FA0tNkggUjFxTMhlXSPz7L3jNST35Jug1rZt6fiUMj+J+?=
 =?us-ascii?Q?iqVAGx2/DQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f619cc-dc43-4d3d-c077-08deb1ea2b76
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 18:54:04.4499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ih2M+JkJSPX7KR/vLfa7hs+EgCneIiCAQwHP/kDGZq6EuT1Gss28jRwq9X99JkqnpHwDLt6dYTGwrcZExh/11Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8355

On Wed, May 13, 2026 at 11:49:13AM +0900, Koichiro Den wrote:
> The NTB .peer_db_set() callback may be invoked from atomic context.
> pci-epf-vntb currently calls pci_epc_raise_irq() directly, but
> pci_epc_raise_irq() may sleep (it takes epc->lock).
>
> Avoid sleeping in atomic context by coalescing doorbell bits into an
> atomic64 pending mask and raising MSIs from a work item. Limit the
> amount of work per run to avoid monopolizing the workqueue under a
> doorbell storm.
>
> Clear stale pending bits before enabling the work item and after disabling
> it during cleanup. Also mask requested doorbells against the currently
> valid doorbell mask before queueing work, and iterate the pending u64 with
> __ffs64() so high doorbell bits are handled correctly.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v3:
>   - Clear peer_db_pending before enabling and after disabling the work item.
>   - Mask peer_db_set() requests with db_valid_mask before queueing work.
>   - Replace ffs() iteration with u64-safe __ffs64() iteration.
>   - Not pick Frank's Reviewed-by tag for v3 02/10 due to the added behavior.
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 112 +++++++++++++-----
>  1 file changed, 85 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 668d25abc7f2..cc0b356973f3 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -37,6 +37,7 @@
>   */
>
>  #include <linux/atomic.h>
> +#include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -69,6 +70,9 @@ static struct workqueue_struct *kpcintb_workqueue;
>  #define MAX_DB_COUNT			32
>  #define MAX_MW				4
>
> +/* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
> +#define VNTB_PEER_DB_WORK_BUDGET	5
> +
>  enum epf_ntb_bar {
>  	BAR_CONFIG,
>  	BAR_DB,
> @@ -129,6 +133,8 @@ struct epf_ntb {
>  	u32 spad_count;
>  	u64 mws_size[MAX_MW];
>  	atomic64_t db;
> +	atomic64_t peer_db_pending;
> +	struct work_struct peer_db_work;
>  	u32 vbus_number;
>  	u16 vntb_pid;
>  	u16 vntb_vid;
> @@ -972,6 +978,9 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
>  	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
>
> +	atomic64_set(&ntb->peer_db_pending, 0);
> +	enable_work(&ntb->peer_db_work);
> +
>  	return 0;
>
>  err_write_header:
> @@ -995,6 +1004,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
>  {
>  	disable_delayed_work_sync(&ntb->cmd_handler);
> +	disable_work_sync(&ntb->peer_db_work);
> +	atomic64_set(&ntb->peer_db_pending, 0);
>  	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
>  	epf_ntb_db_bar_clear(ntb);
>  	epf_ntb_config_sspad_bar_clear(ntb);
> @@ -1409,41 +1420,84 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
>  	return 0;
>  }
>
> +static void vntb_epf_peer_db_work(struct work_struct *work)
> +{
> +	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
> +	struct pci_epf *epf = ntb->epf;
> +	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
> +	u8 func_no, vfunc_no;
> +	unsigned int db_bit;
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
> +			 * interrupt number. db_bit is zero-based, so add 3 to
> +			 * preserve the historical slot offset.
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
> +			db_bit = __ffs64(db_bits);
> +			interrupt_num = db_bit + 3;
> +			db_bits &= ~BIT_ULL(db_bit);
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
>
> -	func_no = ntb->epf->func_no;
> -	vfunc_no = ntb->epf->vfunc_no;
> +	db_bits &= vntb_epf_db_valid_mask(ndev);
> +	if (!db_bits)
> +		return 0;
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
> @@ -1690,6 +1744,10 @@ static int epf_ntb_probe(struct pci_epf *epf,
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
