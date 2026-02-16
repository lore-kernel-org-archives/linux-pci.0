Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020082.outbound.protection.outlook.com [52.101.228.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27CF311950;
	Mon, 16 Feb 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771252249; cv=fail; b=OSbY5Sl7+sNNkJ4eNhUcA2LNHtR67vLymLVEVJX7LFSTy0u5dgWGm9vYxo6w5qCyQquAbrIFXGn87MAE/+eS9xIOLir2s2IA6SQiuipFVRa1WlRDQraHl5Cw0uy7LBO+xAhHgCFaSlzkILvDRx/UArsnoTm5U4uOpZlIToxnjuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771252249; c=relaxed/simple;
	bh=w6TuvId3Jw2ltK+FIKNB9dbX92zLIPfEjZD6CwekHAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q9gazbYsvPDs9+dCa2IbG9mp65D8sHBPwE/woqmufCBOZHYDmTP9igz3fNn7d3g8A4XCd1oQ7+kHHLv56nv4TBTHN6e9iDZ43S7+MUr2WxxoCUm0OKXcKcUzbb+Vtb85tdk3XKl6gMGQZlCAYV9/hnz9W/Q4YU+oZpTqgRuajIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KUemeplt; arc=fail smtp.client-ip=52.101.228.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="KUemeplt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=td9ktBF/DkgnedRD9rJ9AJiUBf75gJOfESDm6tXzcxfPhh7rWifdMFhrEsRw8CaN9ELrX4bSFqPYJdhXSN4stCBakzGr8pmbqW+p3hPP0jL0LaOtnwGQ1YxoTxumXvYftwUksGkcIfamOZ/jo5GmfuIqanxFxNzLq2A48zi7Ht2rpds++1IYXUd8fwe10O5UdyH6Vc17UBFrNbWl2peNQMrhMLv1Voy4VrUo4i/HwI7ZmSB9ycC7gHAGt5M8sxwDAVl3uqI+betcQrzT6Uyl5kqGfEjL2qfQikp2V1os9GimDplgbHd0EsxUvJaw258ZgRotRVywgc6aJyPr/rrkRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=290wpGauWlabYYpPxMpob963OUFpDGUxPnmEA2yIe7A=;
 b=UWy4qw640cVAzd8raM3esniA+yMcGnrgwqrTzPVsjkMfRR/+DXUMxcVoCN5zmXmelkSYvJXK9IAIzbZw4KaQgBJzUv77JXvXPp5jxW8ztvh2ePYQUwyEpeOdw7U9KaxpXMEEuektlSHxPt5aoYlxoVFJL5DOaGghpfZLGpvaK9/nzfiv4P2BOY8WdYZkXzDL/q8pKeu9/NG8NnNOD08yPoi1sWbEzvvhHKsB2XxX+S+srKpIaY3JXRWq4NJpteACUuft48049RPiQI4faGX1mG26p0Jwdas/SjCfgwsqFEUIkBlGZ3764FaGZ1NE6v6fvuGFZK2xZv6TJ/shdNsISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=290wpGauWlabYYpPxMpob963OUFpDGUxPnmEA2yIe7A=;
 b=KUemeplt+zvU6hhkUO8pT6Ys8x0snIn3T41Z9GvCh8cbXqTU+W5QU9DU3g3fMOt/wImuAt/vTRz50E15xMAxdDQIVs2/pPKFbPioHxMVvCCLwKu+IulTQhdZpRl8XpF05Mwf/Szjz1Zs9zl3YQf8hn1li8H/hxom29agiIbdvRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7295.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 14:30:44 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 14:30:44 +0000
Date: Mon, 16 Feb 2026 23:30:42 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Frank.Li@nxp.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH 3/4] PCI: endpoint: pci-epf-test: Don't free doorbell IRQ
 unless requested
Message-ID: <p57p2nsf3csq5h3v2kgiubiqnl2bioewrofnyszmcvzkydlxl7@iyxbzrogccvn>
References: <20260215150914.3392479-1-den@valinux.co.jp>
 <20260215150914.3392479-4-den@valinux.co.jp>
 <aZMBHNd5zOgDGYbu@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZMBHNd5zOgDGYbu@ryzen>
X-ClientProxiedBy: TY4PR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: c88c42be-0c72-47ce-2de1-08de6d67f801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dBr8/Rnf6Vum2Bo51Pr852a9F5A4PLmeQlrwFcG+6vOfUaqCBdM1HVe2lLKk?=
 =?us-ascii?Q?Ym3SYU7gMO1404+hM+uZNkHMz+XW2PSZDw9w3o2EgzNPJ4Jv840uiRJBIm59?=
 =?us-ascii?Q?fYw57TM15BuV/83e+J27kDWJFb9nTNzkl49t6iOCx0F4Ku5N6ke+yFO+P49w?=
 =?us-ascii?Q?0h+cEMk21phcy8fvVPOolZYC5e7yD6Mjfns6cyKD1Ssd4jVdeBamBo7YVATr?=
 =?us-ascii?Q?z4fwx2BO/1nAan+k/+oiOyd+Xh/+uAWafUNMXCOVc/iWpOYjWjElN3HZdXJn?=
 =?us-ascii?Q?onjHOYpaFpanPPxwx/voqFqodZXdQB0W28VpAW8FDldI5xg5ova5RC0QbBf6?=
 =?us-ascii?Q?6bwVOnc+2ShC4x/TurfOxX/9M0+dxR+yuNcCJamBEel0TSKZEv+H0eq7IVWG?=
 =?us-ascii?Q?RqaYm/m9r1JyGDbCxAZYGceZ11F40s+lGuGgh2B7EhqxxuTErTfsGtb5piTH?=
 =?us-ascii?Q?ldPJYDrw7DjCSH8+9e2Apz9FI/w/FagHuRuNCyJ86LD/HEqwpSbHoMFRWiMJ?=
 =?us-ascii?Q?d86sX++8omq3wSgGVQgtaYwcBG+8smZ8cLvayaTmF6bxN9Ob9zUeM+zrA9Lu?=
 =?us-ascii?Q?BaNfXKCWs+9r9Qahi5b7WM1FvhgEZ1tBis9juN6CFOXZo2lAlh+fbjN2h9yT?=
 =?us-ascii?Q?Yo/FOFE/Uz4srz6mB8K+QLWPWc4eRgT+xpyMJpQoF/eXUAvJ54t/10BgPVP4?=
 =?us-ascii?Q?FithR7uqJX+raW0t23gUME4sIjrs4vlAks/7c2iTRQY46iiJNRkM1kmCjlHb?=
 =?us-ascii?Q?/RQhZubZNqpov5HpNhhy2qjxLgiMZQG2LhaW7tezzsTE2bG+9cZhVYxTalQG?=
 =?us-ascii?Q?K2O7CXUC2oJdPWdgvF7sWVi8F6cYS6izkXEpteK8me6P5YcnQePVaDNpgh5+?=
 =?us-ascii?Q?wupvrKyrtnon62QoNmmurBpYdnEginkYYpXquTXnlH1cB1lIs6Qy1brjaqjv?=
 =?us-ascii?Q?XINuyz5ZvHf/IcpMxGzF3j1Bie7cbTdkcdL1Xbp1bQMDRslTPOGIDD1ZimJo?=
 =?us-ascii?Q?RSd14URrKhKZX7fobvRAHBC/e8J0a/BVkteMsnuiU77mw9JjZQPHla3Dzz01?=
 =?us-ascii?Q?PWhc+tpOtb4EcGUuBUNqbw3lYinaJ+37PwU685L1ml+yiu0xtk856wKN43He?=
 =?us-ascii?Q?NAsoztZZotwsm8mCspIllnxHSjF4c8FbKJTP1Y8mL3P9EYYz33eJs3krNI57?=
 =?us-ascii?Q?pfaOKLu9plv07x6b3xT2OWVLuBFVan1jHbt7E+XCZQlZ1hqannDmXSmzOJCU?=
 =?us-ascii?Q?mOeSKtmSubM8zi3/83ORoQOwrp03pRVHCpjZnKl+GTrro3RFZ05tpcNwH2nU?=
 =?us-ascii?Q?l1/goYn7cB+xv5BElLCd+zNskd4HiYZSwdQ9c/Aw5Ak1hMTwO9TvZmXIQhOf?=
 =?us-ascii?Q?EWAWj9LAlCwG/k/KN7v8uHMehDrLqAy+sUDCNFaTCjtI5cGsCQeNMrPvPKDC?=
 =?us-ascii?Q?QbJuUQwVsM2mkMgyGrmXNX/Mv5H4qKkpl0d73M3lIxS1GwgtHKITtqX9uM2X?=
 =?us-ascii?Q?Vc2syL9ALzvDNHyMPnd2O79UKvZin5df1Z5u3x96Z9VzDKhWIMXjjXlxlWPX?=
 =?us-ascii?Q?QWyOHZZmu4KRewb1nOCxP/umGLZ+PUOYnvPk4pQPFDMbR1w2MnH2gHaD+fpl?=
 =?us-ascii?Q?w2F8kQa8KqHUwa7thN5sR0w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ohBtjXBnW+qeIqhI2dv25hkY57NgRHQr+KIWfivuWvS+rjQ5NTUzT+WWyvj?=
 =?us-ascii?Q?hYV4rNHwGeK8dJnYLYU2dNTMDSFuKIoB/uoOM614kOyCqxwUXmYLhp80+Mfv?=
 =?us-ascii?Q?N1Vkj5ZSYNyqr1ByhDGJ1xBgtqkQ9wxc9WS7eFXsIas8DAcGWCtm/TxYuxbR?=
 =?us-ascii?Q?17MfQyXL+QbEfO32DouXlJlxLCT73mHmSSnFFD6YANZnkvCLFM90yqW033WM?=
 =?us-ascii?Q?6HgW9TnyGmTuFFROSyCkCz2rh4oqY7rk3bI3dRIjgvkDeRfk3HIF6T0txkK5?=
 =?us-ascii?Q?56EnOktD5mNCgXwgz0wecRBciJcTT+DQ+OGyHlPLx+dhKQjPVsmMtrh/gsh3?=
 =?us-ascii?Q?Au//T2E4EwXKDD7Yj1bOkg39gCDo7gftQFkNxp8VhYAW6XYTDfo/RZitE+44?=
 =?us-ascii?Q?geyB+vjuuOdpEJ+8iHhj7YfuUVFNYafguoyyoQF1vNx2HoVMMYNicSEQnSy0?=
 =?us-ascii?Q?oWUvK51olDwCmI+UyWAdC5QwYMRYK5yp1ewBr+VDeD4GruI/R8UDp7c44znh?=
 =?us-ascii?Q?ca3hdMrFtZfFDSnN6whkwcZBLUKl4kR+ji6OUTpgZdsIVPSQjpoVFXZ4A+B9?=
 =?us-ascii?Q?RGHEfVBVgbvUAZZsP5JLydDP6IBvgofjK829FBxMrhM3ry2oPtbV7+KDgCHo?=
 =?us-ascii?Q?G2TlPSIm9ywInj1FypfdK8lFMcLjKzv1XYd9aDT+SVWZeIdLsxrrumouRuIT?=
 =?us-ascii?Q?2TpVDH46JMRQ/JKDB+XkhfbSveF7tl3a1qR03eBSAa5qlcA0cM89r97nDVys?=
 =?us-ascii?Q?PlicIkZYzeZ2ss9c3wMhMt5Hp6I2tkjLhTvqiISXTLZKlJKHnGQms34AeoGW?=
 =?us-ascii?Q?Ny5kYyH1JB1FWLBnMfsmhoSPXmMmheMU0vZ9aZYsAp3kwbb/wPMo/vwWnsRV?=
 =?us-ascii?Q?sc1j7ytkl8dMx+3Wv9AJO0Yf/k4fhtmzTEubiwvROsovERI6MXtzLX4Ez6y/?=
 =?us-ascii?Q?D7mz6bdci7JjvLwvDMUC+9RSyaiufRnapHD5rKxm3qNEQgFywdt8VMD9+bIn?=
 =?us-ascii?Q?LrAEwQimlXZ49cuZdc0Jm3r/5Xgyj5/hD2AcNaldDzj9z9KXmaExI88cYAdU?=
 =?us-ascii?Q?RBRqWomXgyd6CjXGek48d+xJJv+A4Yk1x/aZb6RH+25BwXlrkU2BRj5nFurD?=
 =?us-ascii?Q?QCqyyokKlVHL+p3cLecOeduhuzSWwJCJf98inK2b/xFWlDedAwUkpjme7RRi?=
 =?us-ascii?Q?wS4bz4r4sM0fbZ8RbN6Bo/VRNcXBBVfPgqQZpt708RtYh8GoGWzki9EmGgpZ?=
 =?us-ascii?Q?+VPx2SsfVJMkYQPyekXiINDsPhmODKjfj4PWy2Fz0PacRwMWkkSeh0+nCgeU?=
 =?us-ascii?Q?Z3lqBElkUjvMTebt5sw12E1DPF2NH64zd5M9oMOQMtGByIJOVM/HdOtG8qfP?=
 =?us-ascii?Q?TZpNLie38YKv65q8gU/EeOOJgKaxJBB+dHR/fUKoWQl7Nn0EM/9KyNlnAInR?=
 =?us-ascii?Q?1ZXml42KynHicJAHKn9xgsucVpMg1xLnuapm6BHRKXsvkh2Il+YUNtA2ZroS?=
 =?us-ascii?Q?0hH1nqEBvOa6dnVZWY5NeMXsbPUntUwFy/7xi9xtmoJ1o3EvGXwCe381rf4b?=
 =?us-ascii?Q?QW5c5hVJzkytfrMB/akvRt2zeGqA/ukanCi2etoc32o8LRmXejrNx5C/WODf?=
 =?us-ascii?Q?pfdIi6WFKMv5HhQx/It4Fu7TgxebKbK6L1/u6ZPhJRuPJ2jBQuDjKxeqhxdi?=
 =?us-ascii?Q?aUj+zMEg9Gpz81Oih6VOxj5vsWONKHIgk8JREIKIoBEosW15TUvbBnhQzND4?=
 =?us-ascii?Q?thkGr2UDE9g91VHNxWobAIoPSvbcD/BDgPmzk+KMtnQAIWvKsqKP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c88c42be-0c72-47ce-2de1-08de6d67f801
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 14:30:44.3595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8d7WZYoVWlw7d5vLaw8geZJAC0Qg/Edk9RM0tOl37VzpLwcu/DM3eI60qdogCwXwxSV6fx6UuhE5l3Zqn2tu4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7295

On Mon, Feb 16, 2026 at 12:35:56PM +0100, Niklas Cassel wrote:
> On Mon, Feb 16, 2026 at 12:09:13AM +0900, Koichiro Den wrote:
> > pci_epf_test_enable_doorbell() allocates a doorbell and then installs
> > the interrupt handler with request_threaded_irq(). On failures before
> > the IRQ is successfully requested (e.g. no free BAR,
> > request_threaded_irq() failure), the error path jumps to
> > err_doorbell_cleanup and calls pci_epf_test_doorbell_cleanup().
> > 
> > pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
> > doorbell virq, which can trigger "Trying to free already-free IRQ"
> > warnings when the IRQ was never requested or when request_threaded_irq()
> > failed.
> > 
> > Track whether the doorbell IRQ has been successfully requested and only
> > call free_irq() when it has.
> > 
> > Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 148a34e51f6b..defe1e2ea427 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -86,6 +86,7 @@ struct pci_epf_test {
> >  	bool			dma_private;
> >  	const struct pci_epc_features *epc_features;
> >  	struct pci_epf_bar	db_bar;
> > +	bool			db_irq_requested;
> 
> It would be nice if we could avoid this, it looks a bit odd.
> 
> 
> >  	size_t			bar_size[PCI_STD_NUM_BARS];
> >  };
> >  
> > @@ -715,7 +716,10 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
> >  	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
> >  	struct pci_epf *epf = epf_test->epf;
> >  
> > -	free_irq(epf->db_msg[0].virq, epf_test);
> > +	if (epf_test->db_irq_requested && epf->db_msg) {
> > +		free_irq(epf->db_msg[0].virq, epf_test);
> > +		epf_test->db_irq_requested = false;
> > +	}
> >  	reg->doorbell_bar = cpu_to_le32(NO_BAR);
> >  
> >  	pci_epf_free_doorbell(epf);
> > @@ -732,6 +736,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> >  	size_t offset;
> >  	int ret;
> >  
> > +	epf_test->db_irq_requested = false;
> > +
> >  	ret = pci_epf_alloc_doorbell(epf, 1);
> >  	if (ret)
> >  		goto set_status_err;
> > @@ -751,6 +757,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> >  		goto err_doorbell_cleanup;
> >  	}
> >  
> > +	epf_test->db_irq_requested = true;
> >  	reg->doorbell_data = cpu_to_le32(msg->data);
> >  	reg->doorbell_bar = cpu_to_le32(bar);
> >  
> 
> Can't we do something like:
> 
> -For all goto's after request_threaded_irq() success case:
> jump to a label that also cleans up the IRQ.
> 
> For failures before or at request_threaded_irq(), jump to
> a label that does not call free_irq().

I thought this would be a minimal change to avoid the problematic case, but I
agree it's not very clean (the "db_irq_requested" flag looks a bit odd).

So I'll split pci_epf_test_doorbell_cleanup() into two helper functions to match
your suggested structure.

> 
> 
> 
> pci_epf_test_disable_doorbell() should probably return error
> if (!epf_test->db_bar.size)
> 
> (before pci_epf_test_disable_doorbell() calls free_irq())
> 
> pci_epf_test_disable_doorbell() should probably also memset
> epf_test->db_bar.

and I'll take care of these suggestions as well.

Thanks for the review,
Koichiro

> 
> 
> Kind regards,
> Niklas
