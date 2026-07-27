Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586C23D5C1D;
	Mon, 27 Jul 2026 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185270; cv=fail; b=WODGcOy8cVpW/NaHkzaZs1U+cJ5+/ZkUtw+rokqSw3R/KzM6OOTgCrEdAUddiwYRw61vbXU4sQ2oJq2xEaLyrj75slYzYjIIq/FQXlgdYtxYiXj+5Q+WFVz16D1SsFWbX4Fns39rLLiriMaKtYwPoqz7l9fmQ02k7w+8MpPc2tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185270; c=relaxed/simple;
	bh=WsnDukbUq1XGpjO4N2yqOG0jfW5PVCGYpzfegEMV5Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CZJDkOOAFvQYY4wY7kckyWWu3Nbk+BXu7x5oTh+UuVsNrJzx5b6/1dYA5UQCXLwxd13Gn1Vjmg5k5IKNoBgEHC1SuazqwvivYJojm0DHq2EcwDE6srx/pMa7UgjzRUY49sxPT6sKK7Lb4qGIKSK1pusIkg0StbgmTIJrUXHw7Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MRPHw72W reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MRPHw72W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTrDEemwbB1SzArA/p+JNIRi24LXPn+kjDpRPlkd2ZcF7ByZelXSt2YL9Gmft2/IoL0tf0vAHaIoyEMrehbSwIaJivhq98AQ2jh8h2yNOtsHYI1YXM1p7UBjZdnzrfXQX2VZVGe+vpImL2SiGsqRbsm2fQ2DFpn4NYs6a4brxYABgsD4YRwUsaNxyZ1Js22iZlkZRamJnocbDCTFSeEnTHFIZecz+h6Vk78L9Bo5wUjyAUkgJJqeKQEQ8UbU6jqJ9u+c52DlhVW6zSG+fOHDnyM/ApFQ9al/vjq9cWlAov4ZO+EbmE77dsO+KV2NqwQYrwLrQNyX+dqm4wxEHdLOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIJK5XbI4Z6LEp3XDXfO3GjKBRyB70PfIKVZ3hV/wAI=;
 b=Z3/8W4in1nXaJKt/g1Rv323MqzoyBYD83+wI+GWNveNgelZX8sXgYKRzDEHTGQE5NFbruXtrDl2/2sTm6LgCz3Dl1/WYbNLGWNCW6FAj5WL8ijYxuvy2Ui8e9a0fzx60VXYcs4j7hSu7Sj6FubJH6pMMdmiEJp3AC0IgExpxqYVw4ehUrCLJhCRrlxNYvEea58x0SDTmN2pIIVRCYG7N+K4i/rxUaCCoPuL5gJ5DHNTFfSrtjNWMm9k3MNpZdP3gG4GuYCzX1F1Ffv18seEhEgEcEv1Zgha/LDgklao5s4he8sbQG3LG1Yvf0EcH1n+AsAY/GwGr7dFFliiyf15OYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIJK5XbI4Z6LEp3XDXfO3GjKBRyB70PfIKVZ3hV/wAI=;
 b=MRPHw72W/uCePClgCixeJxZbrXKkc7NKATBvScPiZ95sjwVEdc0OiOtMCacelH6wyfxCr6Ae2z3h8e3bG29gu3poLfWye5Ok8vVOqCtj9ouDNztFbqipry2Z5O912j9P0PTJ0Pqw5vMsk1mMBFtHkr9BdGLPSC0W+Ll0f8vMytBBnQx+oOiGoWLnMnRoZQVA9Jepu+g+3JDdmOl0O6YHFY9YBreFbngXeInzku7QZTGLRmqJAes5wJ89Isjvv7iEOZ6g6U5er6l9q2bCnMCtBlm8HW/Mx7jXiD7f5YAnfdLK+YwLc4Shq52aXx5RZ1t0aWyOoHNeQzwOEbOC+wdcEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB10459.eurprd04.prod.outlook.com (2603:10a6:10:56b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 20:47:45 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 20:47:45 +0000
Date: Mon, 27 Jul 2026 16:47:39 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Logan Gunthorpe <logang@deltatee.com>, vkoul@kernel.org,
	Frank.Li@kernel.org, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 03/11] dmaengine: switchtec-dma: halt channel on
 alloc_chan_resources error
Message-ID: <amfD6-xlqll-Md2Z@lizhi-Precision-Tower-5810>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-4-logang@deltatee.com>
 <20260727185101.D221C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727185101.D221C1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SA1P222CA0049.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB10459:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fd0d98-37b3-497a-3f66-08deec204f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|23010399003|1800799024|6133799003|56012099006|5023799004|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	coULx548vtF5c2K0YmNt6qOtMjRfWiJ9vD3N+L+OuRmqSO72wYEC7nguTb42YewsZpQK/abT4Z9vGqMvdrYYj23qsoIFr0ncx7q6qdhlirP1KNAS3JBILCDiLgQaFAm45OM4c+iEYlSonCfUyBhXKYb8rWoPr98/EL1IuZwWh0mwsRDnSP3L9PK//kly/7nSSZ+sDpgdBXMO3I1r2R096KZ7LY4GgENlkYnj/igCAx8QzMsD5Z7l2X7rQAWEQ1kQU8a+uOfSwnOg0erYBm4rwA7GOmpme4EGkUZbw0BBfvWsv5zzDUu2uBHO4CDjJKKbNNzc+dmzcoEZuHnab1O8YPgEH+6R7qYt6RwP7ICbSAB/TnkWt/CRF2zreOUJ9y0Adze0bAc3Htg5xIQaNt+gZzQG8OQS9Ha4H4Zo0ArGa6o1RZtkXb8wkfFKidxpgSt5YQQ8VuuOUE14vPjUthlMGXepyz6LwVVbzQ95risK0G1SKigaGsDxLF6StcsbiY/ECz2zZGu/tl6yBckBOeeJW5gH31gClzqbI6KiTcXYdtwyM8UEgYDA4VM4j+HaHB0lTElgt4LvBaqzDrnx0YFA5hrXF86Cj8vtCWeinUazsLo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(5023799004)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?6joNBXNTPdYXKl5EnpOKkYFDngDl58mO009e7lOB0YxV4Hnrx7KZ32HSlM?=
 =?iso-8859-1?Q?2T2ujSCmvGW/moDnTSY2J7aDgeVnX91eKsqTh81t9pUcMQWV1cVTmwdGCm?=
 =?iso-8859-1?Q?GbkXH9E3Rk9ECGT/neu3Sv045ZVRr5Rl4wt3u48QdMvB1Uo6GTCS3N6GaQ?=
 =?iso-8859-1?Q?gexpAaegLBerI0q+02RIObBwDvtdqdUaAKfQzMCh6ZHyNAZop2D/iiHhkn?=
 =?iso-8859-1?Q?pD4UdwXwB/HEmzyHy2fIPlLKJMC9FdWbM7CLZuCPo0rpL2axnDna0TqVlv?=
 =?iso-8859-1?Q?qWQ4JVHiiH116vpS4c3/NEookBDNGfWTu2Ty0yW+gYnM/h2mjYaXErOOGM?=
 =?iso-8859-1?Q?y3TXoVfgE4wYMENVNmZxCY3ykS+NEIj7WR40P5JwznovlJrWSsoo8KTwct?=
 =?iso-8859-1?Q?lxICa0YU+d9L++ecmUbzsHvdeYE5IGOn2Vwy5dZzQY7zxJqcBHmcxljdGQ?=
 =?iso-8859-1?Q?807FvbuA/52QP9LFIwJezN7ddbJdZzRwogTE4lI2+9fuzMJwHEPkYy5t2a?=
 =?iso-8859-1?Q?RgX01e88Z8KmA5FiPUvr9y17xyhyYg+EacP0jb7fIoBYl4rvpbQq+Xh3kG?=
 =?iso-8859-1?Q?XWv184G4/0UZwTTU1oK8hvzuyWHpnxrFH/FxbWBlRUalF6a/m1KAvpkCnI?=
 =?iso-8859-1?Q?TXOlHI8yMopYB/h9pV7vI2oil3LAbxHFbej7lHNia+Vb1LdG8BsfQTTYVN?=
 =?iso-8859-1?Q?yah3+WYdjj4wBzi4Aj1Y8So0mZBkitwXvR/UWC2qS5U0ZdovaxD2SrK4XM?=
 =?iso-8859-1?Q?IrdAGYtTDtyw0K6LFAUzoP+509QJPKccmgh8lZ0FvLJrIyqyJYKCnjT7YZ?=
 =?iso-8859-1?Q?JpgP16oAHkJ0Am2YvJlmlErLFJbW+wxU43gDTiHr7tX73ssfa45Bjjnz0Z?=
 =?iso-8859-1?Q?dJ9UFL04dZ96tipjVpUUmB7TjA6tExgMQeHgg5zBzitcwhVl8plB4XCKh0?=
 =?iso-8859-1?Q?NxpvzaBtu4xTVJ57mZJizLftdBC7jWhXlxP6l4iJtr5NJlFvwcqtaWS2Im?=
 =?iso-8859-1?Q?sqHNQwtHUUYGIYmUe1LHYfzULgjWFWWiQukiLaEIDXG7pQllLwqyg55p0U?=
 =?iso-8859-1?Q?8v/zySNudAHrzblE2XP/V2iosvfUC2Mv9/ao6dart137uA60lMaF7gOW/m?=
 =?iso-8859-1?Q?oOn2awIMOqnhjB9WPKUcsRoSYh++ohAEjruY0SdGgHg2M8Jc+ddOd3Uz/z?=
 =?iso-8859-1?Q?/TV9kj/mksKZJU7iWSHiKr+m8OPisi6u3AX7AFy1rw6Vu+OYN+Iw/TmpR9?=
 =?iso-8859-1?Q?TFmQAeQl/gsSzucz4SH3Fc5FWfbWGpTQq+/TOq21bzwVqT0idHUTaWoOUI?=
 =?iso-8859-1?Q?WnK4fc1BuzOC4ta1CkRkgb5qmsxyEEBVV0GM9uEAmE365F9Cworf11HhDP?=
 =?iso-8859-1?Q?5AGRDLzSPJrurQHPBX85JPFWoqvIgkeR1HHh9o9zBWeWUhppXZK0h3VgEK?=
 =?iso-8859-1?Q?vl4D/DErP/vVzDnhFmrF9Ze+tCnK+5lx1kSt8Db1tm0gCxHz8b4eBiBmxh?=
 =?iso-8859-1?Q?nX+IvBKl1Ahsp1EIOo/P1Hk5gW7TJB+NlciIGCFrNtiMWTNQp6uHZ208f5?=
 =?iso-8859-1?Q?2Cf9wbR5NyftO9GtBj5L2NnR0Ccx/f7Oz3jQ5aVC3rbOnkQ2y86g33ByZe?=
 =?iso-8859-1?Q?Qe+YTD4bdbaMA4JmDzJkIE7uchvlFFOJRuX2eIMgJr+vN6qw9lPSUMVLrz?=
 =?iso-8859-1?Q?AMaNsDW94o4eHWLmQTpr7WifQIIhgk/yqGXbrmFIb06roP/6dP9kxlSjX3?=
 =?iso-8859-1?Q?RF9nbu9DRPQTFollvz2qJTcyqLblMMzv1l+R5g4ULGTTLAwp2+2ZTMaBf6?=
 =?iso-8859-1?Q?yINApF3Y94FCxI1YqeCsDLMbtchsDWIJNhxujDlchoVv1KenC9Lw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fd0d98-37b3-497a-3f66-08deec204f63
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 20:47:44.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lryY5aw2lxpYSoRQVZiDITUHL+IC1+7D60x3vxLx/H9d3dkLFzueqb3zXtabA6gADjra6NRZJVZoi5GCEpRutDcSdZ6BfN7LARamlfUW8hTodqHK1ADncZK/oxU7pD0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10459

On Mon, Jul 27, 2026 at 06:51:00PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
>
> New issues:
> - [High] Incomplete fix / DMA Use-After-Free due to early return in switchtec_dma_chan_stop() on halt timeout.
>

Is it true?

Frank
> Pre-existing issues:
> - [High] Soft lockup and severe latency spikes due to 100ms atomic busy-waiting under a spinlock.
> - [High] Extreme allocation brittleness due to requesting 32,768 descriptors with GFP_NOWAIT.
> - [High] DMA Use-After-Free in switchtec_dma_free_chan_resources() due to incorrect teardown ordering.
> - [High] Massive Use-After-Free of swdma_dev during driver removal.
> --
>
> --- Patch [3]: [PATCH v3 03/11] dmaengine: switchtec-dma: halt channel on alloc_chan_resources error ---
> commit 647e1927ea58080fcbb88ef03dd8a74aa7555178
> Author: Logan Gunthorpe <logang@deltatee.com>
>
> dmaengine: switchtec-dma: halt channel on alloc_chan_resources error
>
> The commit adds a call to switchtec_dma_chan_stop() on the error-unwind
> path of switchtec_dma_alloc_chan_resources(). This aims to synchronously
> halt the channel and clear DMA base registers before freeing the
> descriptors, preventing a potential use-after-free if the hardware
> continues accessing the rings.
>
> Link: https://lore.kernel.org/dmaengine/20260717223647.F0A051F000E9@smtp.kernel.org
>
> > diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> > index f77da31aeb65e..107769cca772f 100644
> > --- a/drivers/dma/switchtec_dma.c
> > +++ b/drivers/dma/switchtec_dma.c
> > @@ -1040,6 +1040,7 @@ static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
> >  	swdma_chan->comp_ring_active = false;
> >  	spin_unlock_bh(&swdma_chan->complete_lock);
> >  err_disable_channel:
> > +	switchtec_dma_chan_stop(swdma_chan);
> >  	disable_channel(swdma_chan);
> >  err_free_desc:
> >  	switchtec_dma_free_desc(swdma_chan);
>
> [Severity: High]
> Does this completely resolve the use-after-free if the hardware is
> unresponsive?
>
> Looking at switchtec_dma_chan_stop(), if halt_channel() times out, the
> function returns early without clearing the DMA base registers:
>
> drivers/dma/switchtec_dma.c:switchtec_dma_chan_stop() {
>         rc = halt_channel(swdma_chan);
>         if (rc)
>                 return;
>         ...
>         writel(0, &swdma_chan->mmio_chan_fw->sq_base_lo);
>         ...
> }
>
> If that happens, execution continues to disable_channel() which does an
> unflushed write, and then switchtec_dma_free_desc() unconditionally frees
> the descriptors while the hardware might still be accessing them.
>
>
> [Severity: High]
> This is a pre-existing issue, but can this lead to soft lockups or severe
> latency spikes?
>
> In halt_channel(), wait_for_chan_status() is called while holding a spinlock:
>
> drivers/dma/switchtec_dma.c:halt_channel() {
>         spin_lock(&swdma_chan->hw_ctrl_lock);
>         writeb(SWITCHTEC_CHAN_CTRL_HALT, &chan_hw->ctrl);
>         ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_HALTED, true);
>         spin_unlock(&swdma_chan->hw_ctrl_lock);
>         ...
> }
>
> wait_for_chan_status() uses readl_poll_timeout_atomic() with a 100ms timeout.
> Is it safe to block preemption for up to 100 milliseconds if the hardware
> is slow to respond?
>
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does this allocation strategy
> cause issues under memory pressure?
>
> drivers/dma/switchtec_dma.c:switchtec_dma_alloc_desc() {
>         for (i = 0; i < SWITCHTEC_DMA_RING_SIZE; i++) {
>                 desc = kzalloc_obj(*desc, GFP_NOWAIT);
>                 if (!desc) {
>         ...
> }
>
> SWITCHTEC_DMA_RING_SIZE is 32,768. Iteratively requesting 32,768 allocations
> with GFP_NOWAIT forbids sleeping and memory reclaim. Could this rapidly
> drain atomic memory pools and fail on slightly fragmented systems?
>
>
> [Severity: High]
> This is a pre-existing issue, but could this teardown ordering result in
> a use-after-free?
>
> drivers/dma/switchtec_dma.c:switchtec_dma_free_chan_resources() {
>         switchtec_dma_chan_stop(swdma_chan);
>         switchtec_dma_abort_desc(swdma_chan, 0);
>         switchtec_dma_free_desc(swdma_chan);
>
>         disable_channel(swdma_chan);
>         ...
> }
>
> If switchtec_dma_chan_stop() times out and fails to halt the channel,
> the descriptors are freed by switchtec_dma_free_desc() before the
> channel enable bit is cleared by disable_channel(). Could the active
> hardware continue executing and corrupt the freed descriptor memory?
>
>
> [Severity: High]
> This is a pre-existing issue, but does this sequence cause a use-after-free
> of swdma_dev?
>
> drivers/dma/switchtec_dma.c:switchtec_dma_remove() {
>         ...
>         dma_async_device_unregister(&swdma_dev->dma_dev);
>
>         iounmap(swdma_dev->bar);
>         ...
> }
>
> If dma_async_device_unregister() drops the last reference to the DMA device,
> it synchronously invokes the release callback, switchtec_dma_release(),
> which frees swdma_dev. Does this mean iounmap(swdma_dev->bar) will
> dereference the freed swdma_dev pointer?
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260727181526.9672-1-logang@deltatee.com?part=3
