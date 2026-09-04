Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020140.outbound.protection.outlook.com [52.101.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A233EDAD5
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511209; cv=fail; b=g3pd90zMjhmCrNmrGD4sWY3o8s/TFucGu4VFU/V4JCcEnpjxFiWy+/R/JI0Oeo20ZBg1K2xc35eKVwTSBhGnQiB8oj2/kckobMuRTleVlyB+yvXZ75qkqoilSqw7o7ae4ukoSpEcwrL6Zm+MBwBtm28vHW6om9nVg84mA5dubhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511209; c=relaxed/simple;
	bh=dOwbQhqjQqgQnFx9d1WDh/PJmtSchcL9jVsbt9bgUfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Em2OZRhIkkD/chV5B7gWFvlS0XVUJlKwWZcII3YhzpnDgGusdWY+C9pk5ew4KLVrjGTB+avcBeJr9vVfDyhhQUWsxEhNGT9uqtyxLwW6CqxSxeRp9MoDBV0T6G3P7vqNe09S6JTXNH2SgntfsXe6rtg5xH9Tztw37tDU7/mZ0Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=RGIY4z/v reason="signature verification failed"; arc=fail smtp.client-ip=52.101.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="RGIY4z/v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSaLHTHZ6xslsyszU1BLywJsREka38vosrwq0/jQUUq+RYkvXkVsEIcD7vB4dD2gnQUUxKVYzknH9AtD9wlvEmxoYBpUHmmgSVwkOD9ZscMYbGGLMKwD8SRT/RSpQGb2TWtn0UQkLT3vk6/F9U8dt5Kq+hglXMP5FUvc8lmNaBjoQFGlY4ieIUOvlZlBCwDnIBRbuiqMAnFQLEKWsyf7PMdkWlPVN4nUrcMde9GLpfna2STTE8kovrESwKsRkEQ2rkLldQFZSXLzCpC1Wuebkqq3tu7hjzzi5gfiiCm5Ur/UIeC93P9QjC+dWY8ZVYnP+FgBCIr841HVUBKVNNCcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QUaLcRBFiE6HgohOndS7qx6b1255lqPtDke2NF3guw=;
 b=PUbLN+lY6KGju02X9n3sXbqrzfVTkWMeO0XRIMJ9nHpXV+ZiyeuhP5WH/yx4m5cJQjn3hJ/u0WRgsEreMIoYCUp11hB1nnHFo3CyvNid28URhYgjXxD60rb3TVP3R2QTIdMKYinYVrs/EVQbebGSDbbYCrG1sF8wa/dQaIatEaO3xh1NilB4e2CI2YtuaUXAJVmRnxzPe3TB9v8QRG2Lh8jYNkmkfG4gAugndT86LeeKn3e9LvzH0wXYrdQ0FRB0UCN80x1GJV4zWCS8nsZH7pvbTaufvEgnTiDEKGnUtSfm5pIKJhUvgFLKfmc6EDlLCHDogOW4Gcy1xFFGczbyOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QUaLcRBFiE6HgohOndS7qx6b1255lqPtDke2NF3guw=;
 b=RGIY4z/vJqSucBRIrs7KhwOegCXTTfDdoVxkV3uL+FUjOPE0VQSQkfBaTKXiRLghUz1mF4v24WZ+FwSJxaVysUrHLlb/pC2w/ikzau6pq+FIHS1G5YNf9+NREXJQJ45VWTWSnrWogxuVeVYk8yS9S9v36ubCAyodWGJXXxJlp2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYXP286MB5613.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:40:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 08:40:03 +0000
Date: Fri, 4 Sep 2026 17:40:02 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: Track link state from both
 sides
Message-ID: <o773msmbvvst2kterwvcpcb6tcyyp5uehiozaofjmwc6t4hf4y@dxs3wpgd4eas>
References: <20260904065335.3059625-1-den@valinux.co.jp>
 <20260904071321.974AF1F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904071321.974AF1F00A3D@smtp.kernel.org>
X-ClientProxiedBy: TYCP286CA0220.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYXP286MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: d579f6fd-57ec-4472-2040-08df0a601d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099006|6133799003|4143699003|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	MZ64kv3JsusJSc/HCZ+XfUlQ62QzmZpeavSr9fIv0JFWE+k48QPDDXBK/8Bg+aIDqiGVloW6YHpTOH8TQYMdXsXy2VF46BZKrBx2iAzqeH9Me2L7JX+yhNp+OS51OFJM8ILpT0vOlJ9HKxJbYyyfAB/sN0yi4rq5LSlqlCMLlZI4F5fpcvIKhoI2H1hDvopYGrrtFltmKF9v+i6TZn6vn+zUrl1G72Qwoqkm3I8roUAZWStITNRqTK3bkRxHseEdJfnSrxRYoxNz+MKi/cr+XTOzTLcl/PFLniHZg0Wtqx1JCxsSGyDyxksTEcdCMeZHwIeo/QR9SRcLYDS3YMs8N70HA5cdPQop6SxOQpu28oDEWC++x2p4iGo7Yxj4jAA4lbc095W9L4hLAIRVgSkAlXTQju76tnkrtg/7ogMx64tYcsQKf+T+zMkhcLGsbl05/S+cAFc+uTUg8Y98KejhIyxSdlLjxyWZjTNpgQoDbxKhq6bqmOzGFG0k1nzo4ENQ2Lesg3r80p+dyJLGDVD5vtSamn2BR/DSRqA9eL3DPTuTjjJxOx2D3x6IR/mi35TdeWVQ6Go9rQXjHPfORDQ+ZoMjnIOJj8nqPyMVdDiZQa0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?X4Nwm13nq/DqSoe6VIK8NhY/v0BOkZyNxw3abZqcpPK2SqityrvvFQ10+5?=
 =?iso-8859-1?Q?1SNF8P6JaFmVy50YRlStoQFqb/K6Inzp85ajsbeeQIM7Igr0x/JohvbcLH?=
 =?iso-8859-1?Q?PonMOUVqqeEBEli/OanmipXKNPaOuLmcsqpYsbX5PhsJ90yG1nU94lycig?=
 =?iso-8859-1?Q?vP4C/DeDSwHgBJq5ELfCB+zsaLup16NvDdTxpL6U0Et5hG0iQHdMe3u6pj?=
 =?iso-8859-1?Q?DgDtLzrAT8QhnSJDVu4XKfNl36ocL/jox7TQ1Jn983J0IfmqQZXQRQ7/jm?=
 =?iso-8859-1?Q?idgzjKpEcnwNRK2260vaBAZljLjlfcRXg2h337AAHgk6Pn5pJwOg4i0dwz?=
 =?iso-8859-1?Q?5w5ciQO6nVXncPu+nrAR9Lcrr2yT7FFkdcXBNU6bw1x5Hi734PZn76FORh?=
 =?iso-8859-1?Q?4nPeVS3Et/zZbjT0+VbErwBECMgYdv81FwlYHnc1VsAwdmezZM4702lMI6?=
 =?iso-8859-1?Q?zdUvkaT4VB2mIf6IQ7pemM5Hz8JdpE/BjXnj6PTcerujnxBqay6HXX24i4?=
 =?iso-8859-1?Q?EJBtz7YmLxZFk7ZoWRnYiQ45VZZNAteuqiUZwWnC2D9xR6DYqGnfDz9j+f?=
 =?iso-8859-1?Q?LbsCgfY7yXnJBRtFtFBxs99slHCSGzsgD8VmHjd6jSiU9zzNNjDG7Kx1Sb?=
 =?iso-8859-1?Q?nToH68hCMSIgLkja4c0hntkUdLf1wBysZi59LranVe6R+bOdZGwyBock41?=
 =?iso-8859-1?Q?qe0GxkQmipIfLhE6w9yN959C889wAHK0mSEVJMMFPBnvR8Y+9VqM4xqic9?=
 =?iso-8859-1?Q?o6Hy/UBKkD5iAhLdZflNETHqtqKVgiky8KbIct7OcLyWqQqyMvKoKk3fm+?=
 =?iso-8859-1?Q?QLo1QGipBuI65Z42uGdsf/DXUWI3ONPaiU5B6gV4krAOXQ7OPyX2fhgs71?=
 =?iso-8859-1?Q?d+eX/PHnXJEpmGtVABEP/ssnOCgbDj2qXCJqp0hczqbOM8UmRd0EqfRdK3?=
 =?iso-8859-1?Q?RFxSb2L++ollY2BYov+ZTsZVlh1IXOfHUd8KP/N5BPbUsZp+BTurmN09fu?=
 =?iso-8859-1?Q?oxWmaxrPHLamOsP3kgyPVE7HeGh9EkHOa+m2nZ7zqvBCCyvFi7KgLnceBQ?=
 =?iso-8859-1?Q?fyGZHNaew6U3/WQnOTUA/F7Vf88Lq97wy0n3T2PRT/FN5wKG09kXM3pBF1?=
 =?iso-8859-1?Q?14MPCfhBoNJDtWj/cuU4/0GbRd7WUfugeztEnl8P1KNjLyCNwb74P/bSNX?=
 =?iso-8859-1?Q?foIdhY41fatMpM3UnnQy56zvuPZdD46ql0IEyRfqu349od3SLov2jBmpib?=
 =?iso-8859-1?Q?BGPs+VDMVmPeNVocKF3NmgmH8uiMIWMjpA16HNoFXTKmblfOt673eUUdgc?=
 =?iso-8859-1?Q?SPjC2VwQcwAUYMI/r0PmLmHcyW9vxL7ViJr+RJ2abgBvg0XlllGzrxO6fZ?=
 =?iso-8859-1?Q?Op3bBLHf2HjAT+6uYW0CEwrR4QSzUkVybXzkVZ28uSc+FvmxA/vrt4SsFr?=
 =?iso-8859-1?Q?l9L6TKPKEy5a/6eknK/MrI9t8FyYlC8IxHQqz5KFVa0bOSW2t1nNazEkXI?=
 =?iso-8859-1?Q?NZN7auuqP8G3I2RO9BbrnN65TFfl4FKHoxXUUQpUkE700YtAmBSblpFcfY?=
 =?iso-8859-1?Q?TJvs865ow5yDW7K+fB+pbMap6Qy9H2mmNpbsgOMe9x26/icZhIFIVaJHIz?=
 =?iso-8859-1?Q?8euEgdWkGZJhHe5COmj33BhwPI87D2IaddNFxjCbaDIow83jFhZBIu5OPp?=
 =?iso-8859-1?Q?oabkSGSJEwjI24Zj/+u27fi2xCQ7BRdAKHUXxZF1GEv56dOZV61beXraHH?=
 =?iso-8859-1?Q?oMNiQ2KjqhB6DtJLPCgGJBtmBMo6laG0zsB27Cc/C+hwTpvbdMbammpU5H?=
 =?iso-8859-1?Q?KzNSK2NUwzuTjbEXqVfs55HJRFtTwcRYTpfy1gujXycdYF/+5cnF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d579f6fd-57ec-4472-2040-08df0a601d0a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:40:03.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+oF7l1S2r5GW2tpb62LvOnLSua4iGWTbDoT7bwgA1t9cSyiTPqgx1cciZq+ratIVvuUtr7z/9POfmGNmTb18A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXP286MB5613

On Fri, Sep 04, 2026 at 07:13:21AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] The driver fails to mutually notify the local NTB client or HOST of effective link state changes, potentially causing clients waiting for link events to hang.

Good catch. This is a pre-existing issue rather than a regression, but my patch
only fixes half of it. I'll cover the remaining notification cases in v2.

Best regards,
Koichiro

> 
> Pre-existing issues:
> - [High] Missing endianness conversions for PCIe shared memory.
> --
> 
> commit ca462c18f2f26ec109681df8452341853193267f
> Author: Koichiro Den <den@valinux.co.jp>
> PCI: endpoint: pci-epf-vntb: Track link state from both sides
> 
> This patch tracks the link state of both HOST and VHOST sides of a virtual
> NTB device separately. It reports the effective link as up only when both
> sides enable it and notifies the other side when this effective state changes.
> 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index c3caec927d748..8af3dcdd893c4 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> 
> [ ... ]
> 
> > @@ -178,24 +182,42 @@ static struct pci_epf_header epf_ntb_header = {
> >  	.interrupt_pin	= PCI_INTERRUPT_INTA,
> >  };
> >  
> > +static void epf_ntb_update_link(struct epf_ntb *ntb)
> > +{
> > +	u16 link_status = READ_ONCE(ntb->reg->link_status);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but the patch propagates a
> pre-existing structural flaw by adding more native endian accesses to
> ntb->reg->link_status.
> 
> Will this cause the endpoint function driver to read and write corrupted link
> status over the PCIe bus on big-endian architectures? The PCIe bus is
> inherently little-endian, so it seems this needs cpu_to_le16() or
> le16_to_cpu() conversions to avoid breaking device functionality globally on
> big-endian endpoint architectures.
> 
> > +
> > +	/* The link is usable only after both sides have enabled it. */
> > +	if (ntb->host_linkup && ntb->vhost_linkup)
> > +		link_status |= LINK_STATUS_UP;
> > +	else
> > +		link_status &= ~LINK_STATUS_UP;
> > +
> > +	WRITE_ONCE(ntb->reg->link_status, link_status);
> > +}
> > +
> >  /**
> > - * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host (VHOST)
> > + * epf_ntb_link_up() - Update the HOST link state
> >   * @ntb: NTB device that facilitates communication between HOST and VHOST
> > - * @link_up: true or false indicating Link is UP or Down
> > + * @link_up: true when the HOST has enabled the link
> >   *
> > - * Once NTB function in HOST invoke ntb_link_enable(),
> > - * this NTB function driver will trigger a link event to VHOST.
> > - *
> > - * Returns: Zero for success, or an error code in case of failure
> > + * Returns: Zero for success
> >   */
> >  static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
> >  {
> > -	if (link_up)
> > -		ntb->reg->link_status |= LINK_STATUS_UP;
> > -	else
> > -		ntb->reg->link_status &= ~LINK_STATUS_UP;
> > +	bool notify;
> > +
> > +	scoped_guard(mutex, &ntb->link_lock) {
> > +		notify = ntb->host_linkup != link_up && ntb->vhost_linkup;
> > +		ntb->host_linkup = link_up;
> > +		epf_ntb_update_link(ntb);
> > +	}
> > +
> > +	if (notify) {
> > +		/* Publish link status before completing the HOST command. */
> > +		dma_wmb();
> > +		ntb_link_event(&ntb->ntb);
> > +	}
> 
> [Severity: High]
> Does this code miss raising an IRQ to notify the HOST?
> 
> When the HOST changes the effective state via epf_ntb_link_up(), this notifies
> the VHOST but fails to raise an IRQ for the HOST. Could this cause NTB clients
> waiting for a link event to hang indefinitely because the event is never
> delivered to the side that initiated the change?
> 
> >  
> > -	ntb_link_event(&ntb->ntb);
> >  	return 0;
> >  }
> 
> [ ... ]
> 
> > @@ -1455,11 +1475,34 @@ static int vntb_epf_peer_mw_get_addr(struct ntb_dev *ndev, int idx,
> >  	return 0;
> >  }
> >  
> > +static int vntb_epf_set_link(struct epf_ntb *ntb, bool link_up)
> > +{
> > +	struct pci_epf *epf = ntb->epf;
> > +	bool notify;
> > +	int ret;
> > +
> > +	scoped_guard(mutex, &ntb->link_lock) {
> > +		notify = ntb->vhost_linkup != link_up && ntb->host_linkup;
> > +		ntb->vhost_linkup = link_up;
> > +		epf_ntb_update_link(ntb);
> > +	}
> > +
> > +	if (!notify)
> > +		return 0;
> > +
> > +	ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
> > +				PCI_IRQ_MSI, EPF_IRQ_LINK + 1);
> 
> [Severity: High]
> Does this code miss calling ntb_link_event(&ntb->ntb) to notify the local
> VHOST?
> 
> When the VHOST changes the effective link state via vntb_epf_set_link(), the
> driver raises an IRQ for the HOST but fails to notify the local VHOST clients.
> Similar to epf_ntb_link_up(), could this cause NTB clients blocking on a link
> event to hang indefinitely?
> 
> > +	if (ret)
> > +		dev_err(&epf->dev, "Failed to raise link event IRQ: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260904065335.3059625-1-den@valinux.co.jp?part=1
