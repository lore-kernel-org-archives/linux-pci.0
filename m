Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=40.107.74.132
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793456906;
	b=5blXZhPve4iJTJtcicEnyvBQj9WDFSAirkG24cIksCs+8ujVTQZ3mBIUY5Zysht1eZtL
	 x9s1IPOqKzUsrrCFFbn5M8Y7I8+gyTg+sCb6ufzZRS2iRs45g2bVEmLXtWXpRM8hytyQp
	 IrABQsOdF0X6Fbzr1JH9A7LewxNY4u1DpoTrH0O5FfTmEy+V8kwN/OzzOu7jo3jZBlRKx
	 hTthVo+qWOAWziRx/mxmNRGljZCEOTs96mK7cQ56OarelSpb5pHsX7LyY1f9Bmhgxa9Ug
	 ngPwuE4c4sE19vFG9Wh6UaUzWZ+iWe8lQCLP6Yb2HKr2NCWdTHUmNkIgl++PMFZvtUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793456906;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eDd/+BFYmGJA9KWgSKx33YIrjSeRfij+nblu6Wv7ERU=;
	b=vqObg5TOnh0eX+f4Qcn2IVhCONRXOWNrOULts0HwI5ODvbUM9PKn2r448BHq8BisXnMd
	 Hc7DxU22zxrKS/w/nZXFd1C5fYnkYWTUB7zWwtldlKUxdc01zRTQ1HC2oy7Pm+tGfJVS1
	 umezbgtMsCepP00zfKQUslB8ZaZeQ3Kk+UBnoXULxnfOkh1Y0aRewl/6wLfvnoWs0Ltby
	 Mtq4VXCmF9FoOoEAvnlE7D6JFSRuT7UBDdlee/o15RXwL8xnRj8bxyeQu0qIhHJJZnAmu
	 pWBt81qvmzIRqEbGukkzYmKy71T01NE4Rj9AWxCA3MNvSSwjU5km0H+SPx0aGOKrP2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=fail reason="signature verification failed" header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=TYt25UDj;
	arc=fail smtp.remote-ip=40.107.74.132
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021132.outbound.protection.outlook.com [40.107.74.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC7606A31E;
	Sat, 31 Oct 2026 14:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BFC7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=TYt25UDj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JN87c3CbPQWXTQNzhYTfVYvzoSSf7po9Lfur5N6nd0aC1J+58eq1aYrngsaXDumZ+ys7GJd1S0aplhPa6AmnV9jugq9gp5AUDnzqSKxSSlyKg2taYbdV+tOLQYEhar29a7UaIVxnmHfZMl1J9OYJMjGPf8n0QPBkOr07Y7GeROMOdJCDwAdCnHhN0uQyKjR+pAJ1xnPEADl1FUMWeLfgOnBIg5VyrBHxIcHKMCPDUgMBXPUWHWdLcORkr31UpEpUmBTm4pUmp46+RN9qStIGclfnxbe5ER7Nz8jvWuzgSlqWAEDWZhpuWFztLEQXzx+2zakNFBJM+OVXJ3COdcre1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzAydaUdDBB5MAeWr11Ir2r6qucY7Ou6Riv0ZyMpwBA=;
 b=rpwJ8yLXFYqtyrEBx9i4TbiFE/+t0pInsw/dnYyVFJ8pOApnR4okLrE6JHlRC0G/bp1HuBD94EovfFtvcwzH6aNy6lvNKibt1TK3wpp2/j9FWK5rcG5JWlU3UNbuuo4ZYQd+IkoMcTOT5DroFxL2L2NnhnqV9newF5qfUP0myyCyWYJHLNXNWF4I6UrE3WSAoimx41bhcAHIlZLjHaLKoR2gB4l8sBqDOQGJHGxikLnfI4rKnKrrdulvIDfMfak25vDDgQ2uuMU6afgU7/QyDfCT3vN221gj8Lioi8AHhi9WGRdP4GZSNtLaPi1QOaeL/CreYAWQ0ZWoZJ8XZ7oDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzAydaUdDBB5MAeWr11Ir2r6qucY7Ou6Riv0ZyMpwBA=;
 b=TYt25UDjygpbuygYvshbS1F1SOJ7rSmq/+UW/ZHFtQE/JTnW0lmqgS9hhYCVfTB0YxMtqwFqcBYLm+TXuZY4EGn0aZU5KAYnuQTtU7hu+pHD3zoyZOPIp9mCbvVyiYQMW8TKqapcTfXEpU0xqK9AKbmxwwgfKx5pRcL8rmHrLLw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSOP286MB7865.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:47a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 14:28:22 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 14:28:22 +0000
Date: Sat, 31 Oct 2026 23:28:20 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, 
	Frank.Li@kernel.org
Subject: Re: [PATCH v6 2/5] dmaengine: dw-edma: Reclaim LL entries from
 hardware progress
Message-ID: <rbkljnmrf4ctc7rj6qlwhvhemvzvxx6pdxjxsdc2bmicez56ms@bgshyuvsjuqh>
References: <20261030150742.2586776-1-den@valinux.co.jp>
 <20261030150742.2586776-3-den@valinux.co.jp>
 <sashiko-outbox-191180@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-191180@kernel.org>
X-ClientProxiedBy: TYCP301CA0017.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSOP286MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: 522dccea-bc1b-45bd-6d2b-08df375b3760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|366016|1800799024|6133799003|10067099003|22082099003|18002099003|56012099006|5023799004|4143699003|261021121427099003|261021123027099003|261026121527099003|261026135527099003|261021135927099003|261026140227099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|27256017;
X-Microsoft-Antispam-Message-Info:
	/ZwWOX/vzkG0b1ot3eTWldIrD/+Sew7MU6LFFzuHVeVFvuYukLmtAm/bsR7/2dwBQ6W69kWo5vGvZA5UJ0O9ITYjzyftLjLrhczntHTfuV5lRZ9ExD/EVp8GqoZ7hRU3Oz1I00Q8ssld/YfFDGU2U5gtXPTbpNPu2GJ7BtvunxkviRf18ASxEBpiDHo/RInQ9DBrYS/r7IqWOWsQNlfTEMLryCV67u+idhjGKdVQyDV4jEsO0sUxSgRcjORKfZsyVXDQQrD1nmOzzKMjscqDvrHbBYTH0BM4wMdh9UfDBvzdfGh/h6c3Ix089yvVglTqbk+F6CzP7iuhvUT2Zgrt1pLLfTp9LwC2bGuMtF3bCtXxnG96EfNoKQgZ+UDEShiUGRkyqDleR4ynDZBOG3vWnri3x1HzkVIO3AtWM7BdW73NC7ajs/ENVZwbmperPC/Yb5/ixSiiPjqdfk/cNNRTCmWBlRlW96A5Peg3/ZrWQNFp1HS2TE84rgB/qZE5qy1bw4k/keCyIrLkUQosrNrOOSGkAlIWRkO3/AnJdaPOrueosCxQ0XDNVVNVhHg3/Fg/k5mzjIyuxuUJIo2G+HnmX0DA/mtAZe4Huo+Oov2D7EIXKlankXxhvoj/mA+qxjazTMKo4p73i0wRi1wPa3ZQKG+7zkCchdu8BZifWZYrX6Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(261021121427099003)(261021123027099003)(261026121527099003)(261026135527099003)(261021135927099003)(261026140227099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?VjXE38AAswxV01Y95ZP6o5wnmVQoiCARucPj2G2DMQ5yDoamDVthirHNS2?=
 =?iso-8859-1?Q?y15VjPm2wcyA+9wz2RGlYMxtYO31Ru0mLlCR6amFlfMf5eWhaBbWEtcyIa?=
 =?iso-8859-1?Q?kiKtopCTpNePLEydRWE7gGK211JtYYqegeJ1y2mlxxpWqzygKxyezTw1mC?=
 =?iso-8859-1?Q?dP0nrOjfLAcn5ckFsyyEJEXk5cPxJ4ob3WtBri7PBSGE6NsYP/mo970+A+?=
 =?iso-8859-1?Q?tFsxvrCcITIzQpEjuh3Vxi1rPVtIbSW20e11eHWFVgEBacrn12kd4Ej3qM?=
 =?iso-8859-1?Q?c7RF59e0PJ61BC4b658ohI5m3F0/LLq7xcEmg4vtRVmerp+i6CCrYl4sp7?=
 =?iso-8859-1?Q?8N9z+1Nd5rOXjLpIpc+F3eKv9Z+GNsbtpKodGpN+cUEClkZIhDrQbDdTph?=
 =?iso-8859-1?Q?DpdGskxoIxtO/5eRs/RdMcUofYGUXP9si5u2pnd9x11XmVA1hDLiJxJCKD?=
 =?iso-8859-1?Q?7Sa05ovQ6VQGMwTjgfTB4tksLrHavaqNr9I/5yD98HPZSTO9rFG/0ZO+E/?=
 =?iso-8859-1?Q?Z33ptd0dxNFie/FzcjjUmHi9HrszlZBU5Y9DmAXk/FwZeGaRi+0uuw/ASV?=
 =?iso-8859-1?Q?1GgCQMDF8o3BZI9B7Lazz8HhP7LVJM7p1uq/VuEBspHBzcbPKtFwRTVgaN?=
 =?iso-8859-1?Q?yXMXpdy5ymK8XLilFeh91MmGkyrYzZNwcuhguej3zoWiaGitQ1H5j2lDpN?=
 =?iso-8859-1?Q?n6fPDP5DolUIOTdJV+aVCpMBIj0a/WhjlNaNUpjpAZ2K+3k8OXdLdVH07c?=
 =?iso-8859-1?Q?YBrMuQIp5DGQrpeFsGnQfhZE4GRhMNFuftGCpFTf6YyJXL3z3X2H3BCW0j?=
 =?iso-8859-1?Q?qUfFDyar/PEHCA9SFCRXriw6aAGvRVEQeMp2ZcN8XTW7WaEXCp83SHKm4X?=
 =?iso-8859-1?Q?3nDccJc30+GYJAFTtq8ebcMYh6S5jhaHk/r7MC3kimC7Bq41Y/tItSVmma?=
 =?iso-8859-1?Q?bTEwCXOaV4Z1vhsliE2v1I8iVmjOcr8La5AfiDUJIwNAjAAdt5nwz6Shdn?=
 =?iso-8859-1?Q?3POl5wEd4W8rFe/Kow6SiprcwstErCxxltbFmqs6wrYZckcSA9WIQ9C2mw?=
 =?iso-8859-1?Q?m4sIDMNrDKmT2ZYMrYks3pWVEJESZZpn1OSDz8Ht6N1yRfshDaZYzMIlf2?=
 =?iso-8859-1?Q?F1UlA4z1ZIPcxktb3v3dWrkHgvLA0gMQSr2rJa0a9xclC7KCokOacMhvWQ?=
 =?iso-8859-1?Q?9LQQ7uOglHxJyZtvhu09GATQ92D9QmQ/Q9H8t9+F2q4ECU7zpobrEVqL/2?=
 =?iso-8859-1?Q?SlaWnxny31uKQ/cjyEOspNb4jT0w9MZjrqqSszK/TNoTxbrxAFNwIXxOju?=
 =?iso-8859-1?Q?Ij43JRNgyO0g0P/3XjiDvjdxhkJvsTRlZGBOFs07/+WUEUuWqYZwPCMfHf?=
 =?iso-8859-1?Q?Eq/gy/Csv4MG8/gSFBfJrZcz0kOpSn1ZVWDOvmZBOSr+Nxp8MCMCJEQ99E?=
 =?iso-8859-1?Q?VOdWMJOhTSruEfAoQgtcx+Q52cNVIun3ao5Ca24w2vEZxqRW3j0vd0C/1j?=
 =?iso-8859-1?Q?YOKogyDMI0ammhnFgX+7RTYTMqY1kKvoFjqCObjWb6NWppufqUH/Pba43m?=
 =?iso-8859-1?Q?GcbpO16XpR2NNOLjnJwBUy5F9INltx0E1BRPi/rh0FN+5uG4RUNdRHJEvj?=
 =?iso-8859-1?Q?ZRAWOu2bAzpWSf0LTBUEmZo1vDgJZmsmBjHwdk3kUBnjqQgDY8ueq49pjg?=
 =?iso-8859-1?Q?eoF+icNOcSfwk/e4X/N4JniKFU8hUUU7svQEVCI0PNPLRZ3JQKexY7NIaJ?=
 =?iso-8859-1?Q?tpJ0z5t95GMOxNThMFw83n04f8mCSoGsgOL6O4RBe2nIVBWt4o/RhOh3Q6?=
 =?iso-8859-1?Q?pNUlU70qGAfJRC1jRXlzUaHZq7NVTw19eNyJKSlk1g9xqygc2XBY?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 522dccea-bc1b-45bd-6d2b-08df375b3760
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 14:28:22.2454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9IcVc16L+7OBeiitm3EIr6mpHN+blPD6hpnsNxO3lY4jku+MnzLMAjnSInRXzKOOJRe8Cg6M3aH2SA5/oKN8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB7865

On Fri, Oct 30, 2026 at 03:39:11PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] dmaengine: dw-edma: callbacks scheduled on STOP in dw_edma_ll_advance()
> --
> 
> commit cb11666c731e633531785427e3b24bbfbd73eb2b
> Author: Koichiro Den <den@valinux.co.jp>
> 
> dmaengine: dw-edma: Reclaim LL entries from hardware progress
> 
> This commit updates the linked-list completion handling to use DMA_LLP to
> advance ll_done and reclaim completed ring entries in issue order. It also
> defers STOP and PAUSE completion until the channel stops.
> 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index b08bb31657c9e..74613c95ae112 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> 
> [ ... ]
> 
> > @@ -283,6 +345,45 @@ static void dw_edma_core_ch_maybe_doorbell(struct dw_edma_chan *chan)
> >  	dw_edma_core_ch_doorbell(chan);
> >  }
> >  
> > +/*
> > + * Must be called with vc.lock held.
> > + *
> > + * HDMA does not update LLP continuously. Only use it to track running
> > + * transfers when handling an interrupt.
> > + */
> > +static void dw_edma_ll_advance(struct dw_edma_chan *chan, bool event)
> > +{
> > +	bool stopped = dw_edma_ll_stopped(chan);
> > +
> > +	if (stopped || event)
> > +		dw_edma_ll_consume(chan, dw_edma_core_ll_cur_idx(chan),
> > +				   stopped);
> > +
> > +	if (chan->request != EDMA_REQ_NONE) {
> > +		/* Wait for the channel to stop before completing STOP or PAUSE. */
> > +		if (!stopped)
> > +			return;
> > +
> > +		if (chan->request == EDMA_REQ_STOP) {
> > +			dw_edma_finish_termination(chan);
> 
> [Severity: High]
> Does calling dw_edma_ll_consume() in drivers/dma/dw-edma/dw-edma-core.c
> before checking chan->request == EDMA_REQ_STOP cause completion callbacks to
> be scheduled on a channel that is being terminated?
> 
> When dw_edma_device_terminate_all() is called while an LL channel is actively
> transferring, it defers termination by setting chan->request = EDMA_REQ_STOP.
> When the interrupt fires:
> 
> dw_edma_irq_work()
>   dw_edma_ll_interrupt()
>     dw_edma_ll_advance(chan, true)
>       dw_edma_ll_consume()
>         list_del(&vd->node);
>         vchan_cookie_complete(vd);
> 
> In dw_edma_ll_consume(), any descriptor in chan->vc.desc_issued whose bursts
> finished before the channel stopped is removed from chan->vc.desc_issued,
> placed on chan->vc.desc_completed, and has chan->vc.task scheduled via
> vchan_cookie_complete() to run its completion callback.
> 
> When dw_edma_ll_advance() then checks chan->request == EDMA_REQ_STOP and
> calls dw_edma_finish_termination(), dw_edma_terminate_all_descs() only cleans
> up descriptors still on chan->vc.desc_issued and chan->vc.desc_submitted,
> leaving the descriptors already moved to chan->vc.desc_completed to invoke
> their callbacks.
> 
> By comparison, the non-LL handler dw_edma_done_interrupt_locked() checks
> EDMA_REQ_STOP and calls dw_edma_finish_termination() without calling
> vchan_cookie_complete(), matching commit 99109a51efd2 ("dmaengine: dw-edma:
> Terminate all descriptors without callbacks").
> 
> Should dw_edma_ll_advance() check for EDMA_REQ_STOP before calling
> dw_edma_ll_consume() so that terminated descriptors do not schedule
> completion callbacks?

Good catch, thanks. Moving request==EDMA_REQ_STOP check and
dw_edma_finish_termination() ahead of dw_edma_ll_consume() should solve the
issue cleanly, and as a nice side benefit, the code look more readable and
intuitive too.

I'll fix it in the next revision. Also, I'll consider adding a test case to
cover the terminate path under active dma load.

Best regards,
Koichiro Den

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261030150742.2586776-1-den@valinux.co.jp?part=2
> 
