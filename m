Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021137.outbound.protection.outlook.com [40.107.74.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CE2265CA6;
	Mon, 16 Feb 2026 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250583; cv=fail; b=NndoDTNb3aR1UA1fLLlIrgvw20/pu57s1qM9PW/AqQ79XvbtLmrMqdMJYK5r25oWQC/FitqKb/69ewrLyp2PIEtraVt7e/HhS1rIoVbV6qWZ7HT+ssvaiSxFGX5+87LpPFw2VBO7nFaNe0d+/onMrDJYIjWp/8Gng3bD40jG79w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250583; c=relaxed/simple;
	bh=KBkfGZ8R9Phwn/fEY/y2AKsN6LIPUPTxKGqFZgZlcwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hOVPkWHPbQqXOccsFYr80wXLfPQ2HXtPWTsNjn6eNVfynF0Px3fv3Wak8KetzlImqI2vRX4yLrwG7KnRagA/ITaqFZ7ru8SRkVsErTdaDzx3Dr6Z1f490Wb4DBrUYhNAToWtJ6AJtL2qf3e2KX3u4os/4IQi4cSdtOMcMHOUXEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pozFPQO/; arc=fail smtp.client-ip=40.107.74.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pozFPQO/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e46L0iFY3sSeOhtWde/YcJ7x2TEtCLPUMUhyudLHefvM212KN+p6lN7CZudQH6XrwsIh/dNmxAP4XXh1HkEBj2jG316qLGkMdIFZ0F+nrQdhCI0lkI4vfQTWR7IBps2Mzv4E0it1h8gBG+vA2uCugFyHD8V3ZWNTZhzXUNeIWNwHb8Ot9GLY2MIPRvzm9ukpraUNGAedwJNm6z/gfJYSoUgoksfxz3qhWIW0znOq/NcthcFAH+YN70tuMXwUdalqOK7jofB9p4ZiURRKABaDOgxfU5T1a3GxG5nODhxb9LBBpMhPLsktoyuToFHY8LULOOh/Owo+i5Hslseskvl5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMZGgxsAIFXmzShbygDnRVCs2okEmBfdZmRglS2Ygis=;
 b=bKsZ2UVhrGb2Ivmcy8FSoMIagGHxyAYwaOgEAnXhEliMGHCOqZVmjjBOwIZDzhcn0LKupzWbA2Xi3yTt9Xncy68QbKIODXg35TYL2hxjOjwO7sQP3X4C48Rc6Nbqh0bzPri5suMRcCDLwq8ydcRWkmbc1s9g/wcFpfBkR/YFK/ynmWK9aiDwhEVJAvF8xgFMltEsQ0R05D2O0QxAbGbosRwd7pjtsEcd+yaKSQxPvhkBkeB+ChhqH6ibqp2IUUIilgx+yNzH1eOt4ho9s+4R7jCqQ0s20MnXD26KjPANucPIEPOb7YbLIRs3q7mjhXdcE9bXXh0zJUwzy/SmbMDofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMZGgxsAIFXmzShbygDnRVCs2okEmBfdZmRglS2Ygis=;
 b=pozFPQO/o2XDAGq2jviYhXZ1RQfks8GZzCPd64FDaNX82ktIyMFu0giSbNusf5PEYlsnW9XRYTitr1vby4HEbBM2MHCjUEf5fp0Gir/ajy1fpvwzsJDeyuwN6w9a9QfMEmSVIMsaz7S1/KqT/4jnah3xKRn3fjOW4hthBMBIfd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB3633.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 14:02:59 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 14:02:59 +0000
Date: Mon, 16 Feb 2026 23:02:58 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Frank.Li@nxp.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH 1/4] PCI: endpoint: pci-epf-vntb: Fix MSI doorbell IRQ
 unwind
Message-ID: <pl73ufwrz5xmljojcumc6trc5ezwqq4rn6ecz44xizyihkpw6f@oy7vt75fw6d5>
References: <20260215150914.3392479-1-den@valinux.co.jp>
 <20260215150914.3392479-2-den@valinux.co.jp>
 <aZMF4hsBT-v3fPIW@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZMF4hsBT-v3fPIW@ryzen>
X-ClientProxiedBy: TY4P301CA0069.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB3633:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2fd74a-5015-40f6-d71d-08de6d64176a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qfM4/2e1/aN+Z9HUm6IafY/kDFQZAYKbP6waDFGMVxKrw9W9CkxZh5XEM7Mu?=
 =?us-ascii?Q?NCmURgK/x8yaw/wHahD4MYBegvo9qB1i2CCWGtfN6BAg9EP684+Vhd6aZFm1?=
 =?us-ascii?Q?c8z7XqnxTzQEnpiT4n9UcxS5UR7rGB1HxgfNHRgTvvMgZZPvyEcBedZK3cUZ?=
 =?us-ascii?Q?0yA/O65HiF8iO/ZN4gOrSgapKZ7aI2wyeogv4yxzuvcGUxuhNuC2Yi4p1dQV?=
 =?us-ascii?Q?g85Zn6hU69Z1aFzwLj80kp6GBQbyCHq8MS1bPvsUbRNgb+gZA1HUzCQrA3t9?=
 =?us-ascii?Q?D4gL2xmnwEPszIwQI9ptyq1rtakracVs8yyWEepr8tLi03j26TWh6y06PGRr?=
 =?us-ascii?Q?o+gHkjyK/LKAvdAROsnR7g+3sM20wseHHenjmkkdbVMhJsxUcKgB1nsSk03k?=
 =?us-ascii?Q?p2FNaMbLBbdqcJVnQ08G6cHOosjZam4ipFmPGy+u3BE3UT282AOX+b2ks+Dz?=
 =?us-ascii?Q?bwWTmryxnS7DfOo2CB08vzRP5Py7e/XfDGbuqYP7vUifvABKnmMoU6VEGaxN?=
 =?us-ascii?Q?qaBIQMizEYsRDErkvmID8JUaJyXVbfAfuo8CZ504kGVYsC5YL+643MH9nwwJ?=
 =?us-ascii?Q?kXOBgJqfJAt5dzCu5DSafJBvFtzOLKTiUSjhI4kzu3sGfY+3swonGXx1rvUV?=
 =?us-ascii?Q?I+oHhEDlq2yxi6vzTKw8A9Ayc3bH1/tEbAL+C9J9qT7eKUzETpsb0cffdKxK?=
 =?us-ascii?Q?abtbkkxcNtmSK1JK8fWZIgMiVc9bWBqAXf1ZdHAh4nzgCSbN6aO2BG5cX/PL?=
 =?us-ascii?Q?ihT+/XVxKJaBUxgO6wSDTw0SgkKw4QuVLiUaMmYuSaDo5tMuoxOSpz4dNkyX?=
 =?us-ascii?Q?hbxeCvBhWcXo9RCwC6ZERGw5rkCNBFDsJStJgk14Z7TJgjuRGoajOkAG8yB2?=
 =?us-ascii?Q?OBmkRbO3ofVXqq3lOatZj2hgu0cUoEodmFXfrrRZuhMNeLSvjUczZlpJXuZG?=
 =?us-ascii?Q?9MDtgSUUaPHwSe9cGEy96RM4LuGEmRt9NiMyYKknjo3658ufcz8zzPQpJGwr?=
 =?us-ascii?Q?MyUXOG084y1LcD13yv/xQdb/3pn9bJhCv3ne4qtNu615Dkp8BNQtWFNLftz8?=
 =?us-ascii?Q?qXdssNSBJlWSbvU1s6sSWXLOOR4x3csOtF+uqXgdE9tPEaitD9Fpw1vBM3o3?=
 =?us-ascii?Q?q9zZZH4y1ByeHziAkgytVxjLbS3ObxQSFm1TyBIIs2L+an7RsaLB5A77VKms?=
 =?us-ascii?Q?CqSgWxRhDWtFdjxT19KNi3iOZXVBtkSY6YKw+zc6pos+GjNnAIcb1020b3YQ?=
 =?us-ascii?Q?wqx9sSmHlE1lRu3uGACp7YCmyRmwDrzZBDQHYJRYHhlFhf4u+ZzQKF9vI6+i?=
 =?us-ascii?Q?bZugTKYGUx+vyV+ZNtSFXI6Mjm+9dL6CtSd5zAm7HUfn7qrivBQefoc6qAvE?=
 =?us-ascii?Q?S8SdtprP+8PSsjvvLHB+PqUV5iZwlq4vHMrkLER4ig53d7SlgpePm0gbDERD?=
 =?us-ascii?Q?jF2So96wzvjitUEK6xs7CaX7WN2XCAuqDsQgXIL/zwMbdVZ+JrRtGDgzZaVQ?=
 =?us-ascii?Q?LWC+ILBQAom7ZbMC096yxr6cRSuhGq14K1rLMdW9N305cihI+L0cYm1Cizue?=
 =?us-ascii?Q?sdLpbKS0AHz2RJKmJqc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fVYRD5q+n98oZ40b2XG9rVwkQbDjjxJceOxQxigySJ7whmUTTr6E7zPidE/q?=
 =?us-ascii?Q?MAIcSWsUjGllG0Okz5rlD3HqDggXCKE2uldIJT0umukh8Ay8QQAE+gdVT5h2?=
 =?us-ascii?Q?cpgnzXft6Vf/xaDw//8/3XTNPvNqsWFH7mfSG2MJnS+hZyOK6Uq4n0fg7uT9?=
 =?us-ascii?Q?Ajep7XCGzIfjJXnEGa/aC1S9vwYCF3rj+Z8h63FyweiHOS/rNxtfZx63psMe?=
 =?us-ascii?Q?Sgq9BYwygPZmgEMNMI6kU0GEeAEzFJitVo7OIDNuCV0r75j7yPzEVpZc5nv8?=
 =?us-ascii?Q?O6D+GQ83eZilxVJi/aSu7bKsiEmKZabHwZvpCf7MYKN4OL09UrtrzWGMoGBm?=
 =?us-ascii?Q?9bZoGST47hkPxVUvM3EEQBqyKuHxP2c8BcFCWNZ5GTCYI5M/iPehT7l1uZOY?=
 =?us-ascii?Q?pS1c5rM6YjFxk+a+omfhMCvzSGb7WQQ+6Yd6rAk/UFXPSKFBWjnqoh++5wpK?=
 =?us-ascii?Q?88dN+uGcfu50BlprjnRZ621MgDOTvZr8n+MGVURBZv+gEZqN10BPnFfPEJ8R?=
 =?us-ascii?Q?Wb5Bmvp4yusn2i2ZxRM+zHAt3H/Ghc/OGzDmTdp2DbJuqry9XUa3oDB5rmOd?=
 =?us-ascii?Q?jk+rkuMj11hyrWj3o2mwHLGEhCx8MOiYYEubtYLgGXzlACyJEv0NbOZujkTP?=
 =?us-ascii?Q?e2SBQ+Gdn3qtZOhWdC/wlpWTa32vkxkq2YJ4jCRvkee+UyJLJbL9iHKEV96V?=
 =?us-ascii?Q?g6ut8EvmHKWd97WfFJZtXf4rW+hMMpjaoo5O0TKIAkIf0aGCZKqKvGjFQzex?=
 =?us-ascii?Q?NKV6J7PJLZvFeyj9ayO/Vwxk8LAX7nzyeoEiRtGWvzb9IGexSFlp+fGMkQ/1?=
 =?us-ascii?Q?hrM2GCMGoru6CzXZS7YbYxLqEx0ttLyD5HGLdXMKDrZMI+gS8DarIO/M4C3Q?=
 =?us-ascii?Q?NiM02Yx5IXpVdO+4yJFf7qFBTpl7FJ3pQaS/iwh0KrO79Fngu6v/o+X6TNfW?=
 =?us-ascii?Q?dO0h7fBP4NyiCqUAIIL7X23axOPZqfsSNIvWFWD43IeL2OSdfhZNVewNp3Yp?=
 =?us-ascii?Q?JrFLdr4sp0iibs8z3vRj3X/RI+gH6cz1AXvyNeTZ/+yYGqLbpoVJh26Oj4V7?=
 =?us-ascii?Q?QyHJ8Y4MwHP8GJPQrcob1alWOGjXIBS0rQLaW2+AJyXFSkO1yhXdITnbkqT5?=
 =?us-ascii?Q?ZKPAXFjuPoSYtIW3ylizMJIdsoMzH0piC73lAdeGm4KmyhsK8dXIktGxAWTT?=
 =?us-ascii?Q?+aoMxp2cjtkAzkSAA/3oy22m8HVc+kd4RhofhaztSmc6MPLxGRupQLXrZIbV?=
 =?us-ascii?Q?gbZpWDE7sMQiL3hY22lBmXAEKbOvbhAbvLE1n5t/amsT4U91YSKJc80PFAvu?=
 =?us-ascii?Q?Ur4BpATH0Co+6wIV7B660R51LQrL9yJyfs9BZ3z6P/XOHpQoaJgpPysSt2Cy?=
 =?us-ascii?Q?rE/kcsld4sAg57fxs6U6h7oSlkhL6ZPauFnbGRHeNScrAnwtBcAOcChvYvJ8?=
 =?us-ascii?Q?v+kynn3QtybCsmoRicnRMh6C1IpLyq/kstsWIMHmhx0Fo2N7cVAViczS3mY5?=
 =?us-ascii?Q?CChdWwCnx0/+gUI3pBl4gumn5EAfjk27z/dnIFjSQOeWSfjVHXJZXjn1EG6X?=
 =?us-ascii?Q?JHANiUZG3aBw0lyt80OcS3l+HRC1vQGzlr4sL2ZFv/HzdQAHumu1VB/EuIOo?=
 =?us-ascii?Q?vK0ELEBT4aeUlmLzt2mLLykQzPqdXn6MnNVYmlLz9FqPcjnjnM8Xy+AwrBxK?=
 =?us-ascii?Q?NAmNSE/uZiZNdzs8sFM+4jpyh6mzJzQwF4Nm0WmDHL0qCft+U8YLYq+VOU2r?=
 =?us-ascii?Q?fWDu/vKRmykZiYsSG6F/U2yVEM9+RrXJZq2csfj/kXNjiq6z/oPO?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2fd74a-5015-40f6-d71d-08de6d64176a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 14:02:59.0685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PF2SdOeVCRt0GQytn4fpQJ///5CRjpnOZi9lQGLTZz0PUY1eJscWhpVQOuC1u9pIBwZLYkWdskUtuUE/AOdHSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3633

On Mon, Feb 16, 2026 at 12:56:18PM +0100, Niklas Cassel wrote:
> On Mon, Feb 16, 2026 at 12:09:11AM +0900, Koichiro Den wrote:
> > epf_ntb_db_bar_init_msi_doorbell() requests ntb->db_count doorbell IRQs
> > and then performs additional MSI doorbell setup that may still fail.
> > The error path unwinds the requested IRQs, but it uses a loop variable
> > that is reused later in the function. When a later step fails, the
> > unwind can run with an unexpected index value and leave some IRQs
> > requested.
> > 
> > Track the number of successfully requested IRQs separately and use that
> > counter for the unwind so all previously requested IRQs are freed on
> > failure.
> > 
> > Fixes: dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 20a400e83439..20efa27325f1 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -523,6 +523,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >  					    enum pci_barno barno)
> >  {
> >  	struct pci_epf *epf = ntb->epf;
> > +	unsigned int req;
> >  	dma_addr_t low, high;
> >  	struct msi_msg *msg;
> >  	size_t sz;
> > @@ -533,14 +534,14 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >  	if (ret)
> >  		return ret;
> >  
> > -	for (i = 0; i < ntb->db_count; i++) {
> > -		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
> > +	for (req = 0; req < ntb->db_count; req++) {
> > +		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
> >  				  0, "pci_epf_vntb_db", ntb);
> >  
> >  		if (ret) {
> >  			dev_err(&epf->dev,
> >  				"Failed to request doorbell IRQ: %d\n",
> > -				epf->db_msg[i].virq);
> > +				epf->db_msg[req].virq);
> >  			goto err_free_irq;
> >  		}
> >  	}
> > @@ -598,8 +599,8 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >  	return 0;
> >  
> >  err_free_irq:
> > -	for (i--; i >= 0; i--)
> > -		free_irq(epf->db_msg[i].virq, ntb);
> > +	while (req)
> > +		free_irq(epf->db_msg[--req].virq, ntb);
> 
> Please keep the for-loop.
> Or if you want to change it, do so in a separate patch.
> 
> 
> I understand that you need a separate variable for this,
> since "i" is (re-)used in other places in the function,
> but changing the for loop to a while is distracting from
> the actual fix.

In that case, would you prefer the new "req" to be an int rather than unsigned
int, so the for-loop can remain safely unchanged?

I don't have a strong opinion on this. The reuse of "i" is the real problem part
and the main point of this fix.

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
