Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020132.outbound.protection.outlook.com [52.101.229.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156112882CD;
	Fri, 14 Aug 2026 02:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674682; cv=fail; b=OR3lpQAwytD8M4lkrOAH5Blbhb2fCB0+GofgvsoK8IkZJNvfqVuoHCmWv4nzwf+IyoG+81aLakjUsmP0EHqbw7nq4SrN3eyr3IkhsymB4TVdIqVfbEv35vakzaKJ5BJiHhBbs9a59qXXwKNPZNv+mOF21oXx9ohbLzBFW/+ZV+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674682; c=relaxed/simple;
	bh=aVdZONhU8cd5GStzz9Kz4XYJ8L26giBgKWcP/LoDJQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=igs6KnjIBDR7den2Z11LtQymGBfnB6RdxhDTHwtkdItsPcSIpG+zn1VgIAvysHyViGFkov7bBrOcBUoVzuM2Qe5N7wWKm5LNjSAyPunh6NQobU/UkohfQ/+yOdJ7nssteCYwxXh8A8+uQcrivWchRDUUdHBtwmSnoMKwSGDEvw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=abRnxN45; arc=fail smtp.client-ip=52.101.229.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="abRnxN45"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jI0V1QExiC0m7T1JtDAB2OqwWKYQ8bZO31Bn77ZX8GMaEs26o/919NQhJcVfq+su4gDIZlS6eUpE9Tf5Ttqys2PkqvKCeuL4aTcNCWbgZlACEmlLtgoxOe8qIXa1jCCvMsZ45WHh+7sr5yUI+BE7mUuSJjix2OMLpNSCdGQPvs9Gl027XEmzr2BwC5G6apfX/7VvG3fZjtimW6LLZ+VkVOb6dwjDL5I+3woLjp2UN5FmWOE7ef4ji8kuaZ3xni6pZ7z7fn5nRFx15KanW9G+teWm44VffFtAlXy7sF8mUgf8K9Iw88R/g6iEpGmzsuVZbMsrShEcmKyAeM13iKTnPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oskkx3//QqW481C12Tb7vH3Z3pdSzgMKdCcMZf0K8uY=;
 b=NYicEKLuRb1dkhxSkNNQVjg28GpUTtzZ8vlXw5UA59jorKlcTH4SR1j1jnjOeZdI5Ky0CbS39ARTlToRwNHTwJa04LG4wv0NCBJDWsSv1G1ajL68G0wYtR+yPCsKUyZhyFNyKd12wt+JLToQ+kOyXMy6sWqIXlFN25XmZUsxNigfMnRiupV9m3Llcwk35c65fi3NJxP5go9l/Ne0tPbDTZXOuD4BJl03khgwStzE/92/xRUBHEcU817qYhLRBKeOn1ZIFwbYKPXvklSdZ8wjoq3WDcVRWKMqCMRMnJiRyYf//qX5Uhw/F640ZLEP8MXUMU72if18TM147b5/3NVZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oskkx3//QqW481C12Tb7vH3Z3pdSzgMKdCcMZf0K8uY=;
 b=abRnxN45usQHNmNNjXcaYZ+P5Sb2memJLhRcvT6p9TWIQHid3GssvqNu+9McNGQfSCiJmfI8datshXRf7L9wtYLGCOqcveHARWf9k7gGRveS341qwUncrA3d5slmOJpOByAngd7LcBtKDIYgoeGD9OKBC2Kh457QuHMnLnJWNc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7916.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 02:31:17 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 02:31:17 +0000
Date: Fri, 14 Aug 2026 11:31:16 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Vinod Koul <vkoul@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 01/10] dmaengine: Allow drivers to assign static
 channel IDs
Message-ID: <e25tfpz2yupm2mvhc2npr22uh2lvbhjioie7uv6ehruaxplyvg@qp62dlnvcyig>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-2-den@valinux.co.jp>
 <an4TXwT37vWYEzCn@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an4TXwT37vWYEzCn@SMW015318>
X-ClientProxiedBy: TY4P286CA0089.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 2737148a-7897-4d8b-c3f8-08def9ac1e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10070799003|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	fl/Ng36H1eokINR3d+CllGeAjLPAKZW82KJdINCaMnyl2l2cMzwUi7GzCgPUC915gtpfCKsOzNQ/D8guUdfx0MX2YlcwH/l6ZkGl0Y7eIeICV8oRXq0UzE5t5GOuki2jb4ndlb6WGns7GHtj7AJsdvaO4sItsD1r532dAyJSnKyBsQ9HrK+Jhz9sS9RlrzhP8JiNjgNYsnfCae7YEaUfzVWTWc/rsZlEokpGWYUa5PP4IGDuRZz2XnAz5L3ClN7obJa/sSjIHLIAI0Z2B0mCOvtvushYHBXOHmB89Lj6P4RbFx/dmxqiNI4p8sYXokdWM+1wqVOkNYniMBqpIeX4fzZrsfiz+jb4zYwZWEOdXBxMZSlppgzeHWHXri/gL45WgAN0C752zRB6ZqceQw0zFTrFjxo6mhZeZmMUsQLsRACjYvnf3HdHEqS6WZtwce24lNeAuEo6k/F28/+k+wdvaDWpkgZnecCm57BrWyl3PC/F1C8k8AIOXb/CwrYb7+wEC7RCPP8z+1JwnOTYMazE6q8fGAKlBE6OgvomIVk/WXNWHTpYxHTwcE1EmwOhTppLZwf1Ttn/wFNaqukU/0Tay6iuqEX2QY0SoJfvaEGkKvLrtBUr4tqPFMRKjuwTHXO4q4qpPXqhTPDZgYawaNz+2H28BG2y0TFofBPY6ZKJbhI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10070799003)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pr6GGHysSJPUIJyLXhPqZzc030U71GuF3ersD2HjHiHNgNpoVO0ncumXssP7?=
 =?us-ascii?Q?FYOUSn/5rEa03QLrOZp0YePkfr/hRREF4fUABhXGVsF85Bl5n5aF/v+IriHI?=
 =?us-ascii?Q?2z5n1MMveOyJbO1kXMkzfy1dei+i71wcT0Ew+ZY/mS8xHzO4hV6tpSn1/QRr?=
 =?us-ascii?Q?TsfuQ4kQo6TgUTpHutNMJZAyNjz/O5GrI3ufwpKgwS8iZMFfGKzYURuZYjUq?=
 =?us-ascii?Q?f33Ms7kSwF3oDPAaxS6ejwKjq2yJd7U63OaVmxYOs7f/def4JzfgOnAnqRLd?=
 =?us-ascii?Q?/Nc+rlhO2X31+SNf40zqvGAQAF1OR3OeegCmQjyGnjr7yr8NyFhRoQ0Dk4Vd?=
 =?us-ascii?Q?WUqgxZexlZxqw6bQtcUgTeH39FBgICg4HwEk5slErm+OCjWa4x/fMBM9236h?=
 =?us-ascii?Q?PCYIMes8dHnQXv4sHdkfysnhAhQRwKZgHx44Kxg9XqpNff2d0+avki+nfWxx?=
 =?us-ascii?Q?BwdlSHcEuYbf6dkMT7MntDlvn3mq5anAmc+uEyfHuXCegd47ny6dtCthzD24?=
 =?us-ascii?Q?wyqknqscuAMEptfleSxP5jYuaVJsydTB9TNouc051VFuLYYFnKb36bJsD4La?=
 =?us-ascii?Q?AfR55WCKDMMl6xHXAQrna3Gtljo40dvTCVPYN9uMO2odyoz2J42Ub7UymRiS?=
 =?us-ascii?Q?5nibKF1cqGm8LGQUQBVH5ig3xQm6/E5SfBDoIrw2Tbhol2vYBJ7BK5bMqcRW?=
 =?us-ascii?Q?Xer4LVHv5MDdSU+o8ocwREdHoUAZSgD8UVk6B2UXgZaI4Tfa3/W8bvWmxV5p?=
 =?us-ascii?Q?NgE9fwhS3z1iMEUzB2i4q8A4Fihr5CyMOzQnduaDPLg0bVoHoBt0wFz0b/ZQ?=
 =?us-ascii?Q?qQNw0US+sRX8jKPzTjywr33W7TuvE+l8l1rfD2xfXSdxVMf3zSuI51gYT2BK?=
 =?us-ascii?Q?1wgCcgDQw2xPze5X7wgu5b1sLR0SrwjpOvHfmsWnp34eJJBYBoTg3c+9D+q6?=
 =?us-ascii?Q?lceIh/j2+e94R34oErFU2qCohdAnS0C3lQr9+ji9MSloFEQM/Fmk7rMz0MYO?=
 =?us-ascii?Q?Jc0khAARBV+B0JQ1PobLY8Gix3951BKizDuvYdfr/Kt9m8lwb9cMnank0luJ?=
 =?us-ascii?Q?TcG9hh/N056NAigoYc82+/W1vxJi+Aktr+A7LDHO5a4v1O0vkEPrpJp3NgUs?=
 =?us-ascii?Q?ZFFuNxV1DlCdZ4LMAMqOhQ31Nst11B7ncFf7qKnN/lvjSI1uYe0EtQli2a6S?=
 =?us-ascii?Q?KThvWQ+FqRPk9WhLeeVjS+RswJoe1QWeD/5HDC4IKvhq1qoEf8ZQGy3M9sVH?=
 =?us-ascii?Q?tZKOU0SC5V0VIXYwHrDAjiSkds10F9f4c1ojXwEYeEE1plIx70Nm6GVO07IH?=
 =?us-ascii?Q?KU9KpePvI38XR4gg6ZzKUTYKU7aXZQmSsQ9pu6zOTRdm5lEZTVwZcxvwVD46?=
 =?us-ascii?Q?n5el2P+C5LXlUlax7WPoibnS+JkRt1BwxXFhUPN1eXeGTcI9betVwByyBRwb?=
 =?us-ascii?Q?KKl53zPzQWsnQIUV5eQyXUbGNYgBLINPUAUdOhoVnupErwmt+8J3KfywiMTS?=
 =?us-ascii?Q?bbVceiVrNU9eW2lNo6rbjFMVDJh9q/8eiQEUkpAI7rITREL4QdII3Vs7NMqu?=
 =?us-ascii?Q?JClY/fsUE+4OylMEVWtWLEkCjjWVjAUGecL15skCou1vlstHijdg6vU7k8p7?=
 =?us-ascii?Q?dPPceRzhn/Q30gqZ3wubV8iqW5x9sSSRQVlHB1NVxHRB+qzj/XDrJJs4aFiA?=
 =?us-ascii?Q?VcdeXmCbCrmYh/3XuG+/PHnUxf6NrMzFHvzQJMY3ZscD9a2jnfaeMHe7Sy8M?=
 =?us-ascii?Q?JtRhbJGaktIjrloI5JLMYmgVp8M0UfgMGVIO4wfGxK9GaGB61Q2L?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2737148a-7897-4d8b-c3f8-08def9ac1e58
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 02:31:17.3401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L70pSvhJ9bc1vMhJ3MtLuartL9I3mz406g44nG0JA9MsBEnkQqGY3rZlwsg5s2Z5sthTEsqaR161PlYdoU3C0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7916

On Thu, Aug 13, 2026 at 01:56:31PM -0500, Frank Li wrote:
> On Thu, Aug 13, 2026 at 03:37:48PM +0900, Koichiro Den wrote:
> > The dmaengine core assigns channel IDs in registration order. If a driver
> > skips a hardware channel, chan_id can differ from the hardware numbering
> > and a client cannot reliably correlate a requested channel with hardware
> > resources.
> 
> Provide an example, show DMA enginee use chan_id to locate DMA Channel
> hardware resource.

Got it, I'll add something like:

  For example, idma32 uses chan_id to select DMA_CTL_CH() and DMA_XBAR_SEL(),
  and therefore implicitly relies on its fixed ascending registraion order to
  keep chan_id aligned with the hardware channel number.

If you meant something different, please let me know.

Best regards,
Koichiro

> 
> other look good
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> >
> > Let a driver request an exact channel ID before device registration.
> > Reserve static IDs through the existing IDA so they remain unique, while
> > retaining automatic IDA allocation as the default.
> >
> > Use direction-flattened IDs for dw-edma channels. Unlike the
> > direction-local hardware channel number, these IDs are unique within the
> > DMA device.
> >
> > Suggested-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v7:
> >   - New patch. (Frank)
> >     https://lore.kernel.org/r/lm7tadnxsyrypu4mypptlkx5qkytex4qxsijdr5ydud2n3anvf@yakjfjg5ng4u/
> >
> >  drivers/dma/dmaengine.c            | 13 ++++++++-----
> >  drivers/dma/dw-edma/dw-edma-core.c |  1 +
> >  include/linux/dmaengine.h          | 20 ++++++++++++++++++++
> >  3 files changed, 29 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > index 6ffd8bd82154..cc64a4679e6f 100644
> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> > @@ -1078,6 +1078,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
> >  					       struct dma_chan *chan,
> >  					       const char *name)
> >  {
> > +	unsigned int id;
> >  	int rc;
> >
> >  	chan->local = alloc_percpu(typeof(*chan->local));
> > @@ -1089,11 +1090,13 @@ static int __dma_async_device_channel_register(struct dma_device *device,
> >  		goto err_free_local;
> >  	}
> >
> > -	/*
> > -	 * When the chan_id is a negative value, we are dynamically adding
> > -	 * the channel. Otherwise we are static enumerating.
> > -	 */
> > -	chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);
> > +	if (chan->chan_id & DMA_CHAN_ID_STATIC) {
> > +		id = chan->chan_id & ~DMA_CHAN_ID_STATIC;
> > +		chan->chan_id = ida_alloc_range(&device->chan_ida, id, id,
> > +						GFP_KERNEL);
> > +	} else {
> > +		chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);
> > +	}
> >  	if (chan->chan_id < 0) {
> >  		pr_err("%s: unable to alloc ida for chan: %d\n",
> >  		       __func__, chan->chan_id);
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 1f893dc54c79..d214df55da3c 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -987,6 +987,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  					&dw->chip->dt_region_rd[chan->id];
> >
> >  		vchan_init(&chan->vc, dma);
> > +		dmaengine_set_static_chan_id(&chan->vc.chan, i);
> >
> >  		dw_edma_core_ch_config(chan);
> >  	}
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index fe33a20abc61..f669b79d7731 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -369,6 +369,26 @@ struct dma_chan {
> >  	void *private;
> >  };
> >
> > +#define DMA_CHAN_ID_STATIC	BIT(30)
> > +
> > +/**
> > + * dmaengine_set_static_chan_id - request an exact DMA engine channel ID
> > + * @chan: DMA channel
> > + * @id: channel ID, unique within the DMA device
> > + *
> > + * Drivers may call this after initializing @chan and before registering its
> > + * DMA device. The dmaengine core reserves @id from the device IDA instead of
> > + * assigning the next available ID.
> > + */
> > +static inline void dmaengine_set_static_chan_id(struct dma_chan *chan,
> > +						unsigned int id)
> > +{
> > +	if (WARN_ON_ONCE(id >= DMA_CHAN_ID_STATIC))
> > +		return;
> > +
> > +	chan->chan_id = DMA_CHAN_ID_STATIC | id;
> > +}
> > +
> >  /**
> >   * struct dma_chan_dev - relate sysfs device node to backing channel device
> >   * @chan: driver channel device
> > --
> > 2.51.0
> >
