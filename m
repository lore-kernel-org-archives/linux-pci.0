Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011042.outbound.protection.outlook.com [40.107.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BA04963B0;
	Thu, 13 Aug 2026 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647408; cv=fail; b=fVKV0Te05me2cx5TX1nGq5itVjAp63GsvjkTYbfvQy8FnSZ8lPgSLpyXJ7AHD6cNKcX/p3ProfIqxasG/fM+xsG7HoCDLy7Pzx13k12tjdH+m0EuFo6bov/ZWJOlySB+tAaEIV0m1QMfs7v2aCcVWk1PU0uw0rRGmFZYj6JTbLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647408; c=relaxed/simple;
	bh=vH3q2HBwp+JdcEd0dHoyJ+rCO67I9UCKA4PFEEWhqs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CzwrNCJ6VCwtAHJ5coSxjAUkY0ZizB7dBigH4KZAG/7t4lEwVtkZ6SHk72PnJ8tSm5auDS7S78SIl47WC7CAAjoYGYwTVyv1O9+Uxb95iGQR3sAAh4K2E+78UghlL2W99HIMsDW4wYPvZ5tJxOWCxN4nZLE8tTll+SfoQvF7kdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=geMvzi/6; arc=fail smtp.client-ip=40.107.130.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="geMvzi/6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQVJwIc5U5qdeQ5tjlDvQv8OPkKU58dFtHZO3yze6nD/930tWWCelCU8MYI5+6m3w4cnqg9jnX/4tcRVx9TSDOpwuHzMR5GxwCQQEIvpfBEy9omVsIwsyED+lkw34e4ORG7NaTT3bcdS+NHvGJHgeY3iqUXoJwhaEuse+GlykQ50UEyVfXXwNqwoINVfn66uDDnRRa3JAg1HQzoGuTmprmnx4cqXFgZTvEFdqLSleet2Kv+SE4AgjSdZH4vw5uWU/1ZEOpVVzR23KiULCHbTgX1jMEhiYi3rZ11RgNLDmMrYpZcfjEHxNVGizR5MMmy8B/FFrGECnHsCIoNKbzdmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlZJi1OyTrlJkZFxKYgAp44FSKvT8SKq+JYOUK6wQTM=;
 b=mkHJg7XMYok2NT11V2s5WMiLSV4kw6C4tw3TxsxWX0L0XGVS3JlKOXHpqNK6aUsoWSoeXlCXqdYiafJwN5DJrODxORkzAryhVKDLE4gyY5WehbzVA7qqzI9XukcYo2IM8ps6ZYPxK4WkTMaiAG9kw5BsuOMqB6aCmWuZO/5UrzIln9fQgmOBbzhYMkTVH5RzHdpY+oT7bbZwhlO4ZJ06w8i7hXdg1IlnWzx/6dVjiBXgXwxGuzVZuAyOUBcQ6Vv8d8S6nyyeNkJOyacMqhdikdvDif1y28J/2G6gxoLfTCbOTk6QHwxik4ncHyMCFqHQIMZ/LqW3RrlEhHSDvrVUig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlZJi1OyTrlJkZFxKYgAp44FSKvT8SKq+JYOUK6wQTM=;
 b=geMvzi/6fIZvnMQxiH2I9H35DH9/FwQ95PS5BinnKUQ3MN35mdiqDXG3K2gFW5XY7fA97CzfzWQAsqtBKd98avXVCtiWpXJ7mbidha+5ZHDK7cnvRukkyc6M3sjh6CK7GXqCbVZPqFJlyTCQsTPj50DbWuzxmfdBB1TXO46tNiyHGsEXXByAOOHKXhPJTnUxVhR9qPZDzfZJkYdsyBzUjF9PVcXR/eRRJDtwjpOPM0/yWjJS/D7XapEtCAQAo/rM+piDJfafAvJPE7BY6tysQ3y5XSVwxE0OkFZjckuXbTI0oJvTi2Eku5nO4LHvjXTllhiTjJBC64OLmbYSAHaz+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10881.eurprd04.prod.outlook.com (2603:10a6:800:27e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 18:56:42 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 18:56:41 +0000
Date: Thu, 13 Aug 2026 13:56:31 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 01/10] dmaengine: Allow drivers to assign static
 channel IDs
Message-ID: <an4TXwT37vWYEzCn@SMW015318>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813063757.3131865-2-den@valinux.co.jp>
X-ClientProxiedBy: PH7P220CA0118.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10881:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ba6f76-5ea9-4687-6040-08def96c9cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|23010399003|366016|376014|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	/QF5WXzYzTGubIAejhmxebVnE9/fhEBslDD1LIC4aAeo0i2hhYZCnQyc61kXb+sovHQQFU5Gi2Y4WeT0z8LvFWH5aw1fLSNL2QBtJegmqxdKnPrN+HoAcku30lr1XLTVMyNxzZBaeWkFl7OhB1UON5ZUwK0YFaO6Iie4r6B2u5PN3Gzw2gr5ir+l7Yubhrnv4NSFnqq/C/6L85UMUc9LAvVqu/gSRPJmrFLfGFIUljOyN5mBwBND5XexVegwJsmw79IUrq8aFCC1a3kUQRjAwwhFBMu9FMQl49Bl+E3iVV3gnDEFITZib4U0dUrY8UenVha9iP+neBZf4xXTHZSkmbKD59wdTmTjRwoYXXdcCcijIPuHqvolrXu4ylLmhrCG71ikndvuPwR/9u+Ry+FE+4QQN8+JSXQYp5UFMi+NN1yoNL7DFuWiydZygZ3NKNqMf8JhRQJKI48a4XbESswjKt/5YDE2laPW4xeqRcwQDzakjNdZn0sWVnn6hMyiKnZFEpd+sQWtYB9Ie8ExEC6KR5iRudKhdbn4s75EYzMp27x279RyzTZH7aRjJmWFId2ihI/3wAMnmpJZCdi7xDKt3jNAKdUL3rSYcnRWoGBa4/ZJ93/8/NxwqnHyNMqIBw8G0LG/BPJVLhBdjyCwOZG6kutvKokrSF9VzduAkgEyh2o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(23010399003)(366016)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9/8jh0NK1VxsMAhukQB8tDiYG4lgMQk2UYLN3DMeGDDbaR3NArd5kPx/TJeQ?=
 =?us-ascii?Q?AItJNOYiNHgH6uWay6YA65PgHiLft+HiQWmnB1E4gUaLnytQQbfqj8bOoJ0G?=
 =?us-ascii?Q?PVINRVFj5UAtlfwoQmBazhlLeV8uZIPjQJMVFD80Gj1I0lzFtTShahsYIXef?=
 =?us-ascii?Q?V1JLZX5LHN/3fFBMZrKklih4mdUvg//fbLwpjiI6WGxF7c0MA3fOCykzn/cU?=
 =?us-ascii?Q?63ilF+jAX4HQ8xyGvJkk7qXFK+4zffdJsTOf7qdFuMG6PJW6/ML+OBUsVwaB?=
 =?us-ascii?Q?xhqFuSD8DPn+V3pzw3bqe69nbjccoBG9pcsNU1XV8c6b8fKEdbnmT5L24QJ7?=
 =?us-ascii?Q?Ar5IasayPix+FW2TIr6r/cF5fUv0VCx/WNuWTsZNg+QrALUjNjcRRLsio49t?=
 =?us-ascii?Q?2GGWNDmCdIgWji8lKas/f1d0oIMX0oB+YOlBFYXqSWyK1Drh5z7SUz1hfulX?=
 =?us-ascii?Q?6ceJM2rLwjCIVhC0wRmeOvwibTkb5wz/czMthVT+xHv1l5h8aFY5SICq/Zd0?=
 =?us-ascii?Q?fqYhZDt+29e65ObLhW2fJJsGylptT0IDnellPMJ68mRUV+spJTzp6goDvkbG?=
 =?us-ascii?Q?ViT1sN59Ei2gtg/3l3ExOOWaXDYVmW40TJrEVpy2mjYsnXa5TOBat/2k6wKK?=
 =?us-ascii?Q?mOD/ncRk22Wm3J+3T8U8+6S5M6Kfc14oZ6ZIW8pdHzLeKfvcSjagUJV7zo2I?=
 =?us-ascii?Q?6ur/WG65PBXVh5s3UpjB6Lvo/PjS/R+69HFrQL0SIYc831JKo7xZLanTBRgC?=
 =?us-ascii?Q?wgc+1ErwGwwQlGnB8KXdmff+USEFoKJUX7FnIW6r3S7UPaCdGotE2WiR14+g?=
 =?us-ascii?Q?6yi2y419RSWBleDhxiECnXWFQ/3cSBr75uOR1yUHPYdmzPMaBq+geGmJ9phc?=
 =?us-ascii?Q?pYyPFmn4RtRdvlhq27dYxLDfWXzrsAYIUWYt2aDAVSVRRNkyhkjsO9xBlL8E?=
 =?us-ascii?Q?r81X9vnlhkE805nWNu2Y/rO0nHo4plVmDKXtmePk53uLG7c37baQoFOxhGkY?=
 =?us-ascii?Q?AISljYqtfQJusC41XJSk6EkfB3V2SCBIlp/POrL4IvLp0LHMXmnUQi5TsgEN?=
 =?us-ascii?Q?Dmdmp604TssS1ZXs1tBOhM8Oexwlz0K/lYZK6LNF3+HfsFTJSIQmpyfZ4ggD?=
 =?us-ascii?Q?IEzK9A7hLJn+9ETPigFHYI0bzNb5cbdpGJ+PiAsTWPAYzCAel0NLJjBn7PZb?=
 =?us-ascii?Q?ryRyRh7SvHEBRgpuvnMnDcISJ1ACmF0MxXFJSDk4Tb77BFf0DAec3qY9c98Z?=
 =?us-ascii?Q?ff7rYJX5aDPi2knkhRRPV31EZw+vJaVRz3ZjHGBhw/1FC2wdIb2y1rYKImWo?=
 =?us-ascii?Q?Mx57fQuqNgv/iQgrg3zZuGSHXtgeiZpU8XZnPVMbUVMwnOLkjqlC8VLRPue8?=
 =?us-ascii?Q?dIr/VgsGaU2aSc8pQeJbGcs3xz7gVB5ZvB+5ookM/TlL0GLXRlLEzBiKgU55?=
 =?us-ascii?Q?Nf8Ef3SaFwxwHz2CXSGFABOR+eiq4BcExMe/eb+xDV/YLNPEVNTgXmSRkj3y?=
 =?us-ascii?Q?UwlmwSK/DE1OgMxIBpeOgxr9Pxd4ZHwxDC5OalY9SbRUh4BAzTXe51NW2zpO?=
 =?us-ascii?Q?03bVw1yvZE1OGyXocFboaa4NqxuelMDzvBPryWjC+I86ok8xyWSyZo3Flvle?=
 =?us-ascii?Q?mm5dj8/zCUB4ie4uu8Ckh3gIeltdVtIcsAEKzx419NcGbmXs/g/STyJTBVsW?=
 =?us-ascii?Q?YYczIEwKMEF6qLQx4b21yMXejUVe/M4sT38ISz4W16vLk5eqxPnbV+k0D0VN?=
 =?us-ascii?Q?YVebOuuJDnMq4e7/BmGupGG3hI70PH4Iy0ALKlSLsqr3axeNOsS5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ba6f76-5ea9-4687-6040-08def96c9cca
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 18:56:41.8376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/EgmDGhHjakEUUhjHtou4SfYEG/UOud7lAnJdKCBinD/7BEVdLKxlIG57BivYqLEuMqUPH0/tGhjmT403HSH/raIB70hDiFqlZ5ecPc1ABfNpYB3FpTLq4J3ywXUPM5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10881

On Thu, Aug 13, 2026 at 03:37:48PM +0900, Koichiro Den wrote:
> The dmaengine core assigns channel IDs in registration order. If a driver
> skips a hardware channel, chan_id can differ from the hardware numbering
> and a client cannot reliably correlate a requested channel with hardware
> resources.

Provide an example, show DMA enginee use chan_id to locate DMA Channel
hardware resource.

other look good

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Let a driver request an exact channel ID before device registration.
> Reserve static IDs through the existing IDA so they remain unique, while
> retaining automatic IDA allocation as the default.
>
> Use direction-flattened IDs for dw-edma channels. Unlike the
> direction-local hardware channel number, these IDs are unique within the
> DMA device.
>
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v7:
>   - New patch. (Frank)
>     https://lore.kernel.org/r/lm7tadnxsyrypu4mypptlkx5qkytex4qxsijdr5ydud2n3anvf@yakjfjg5ng4u/
>
>  drivers/dma/dmaengine.c            | 13 ++++++++-----
>  drivers/dma/dw-edma/dw-edma-core.c |  1 +
>  include/linux/dmaengine.h          | 20 ++++++++++++++++++++
>  3 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 6ffd8bd82154..cc64a4679e6f 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1078,6 +1078,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>  					       struct dma_chan *chan,
>  					       const char *name)
>  {
> +	unsigned int id;
>  	int rc;
>
>  	chan->local = alloc_percpu(typeof(*chan->local));
> @@ -1089,11 +1090,13 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>  		goto err_free_local;
>  	}
>
> -	/*
> -	 * When the chan_id is a negative value, we are dynamically adding
> -	 * the channel. Otherwise we are static enumerating.
> -	 */
> -	chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);
> +	if (chan->chan_id & DMA_CHAN_ID_STATIC) {
> +		id = chan->chan_id & ~DMA_CHAN_ID_STATIC;
> +		chan->chan_id = ida_alloc_range(&device->chan_ida, id, id,
> +						GFP_KERNEL);
> +	} else {
> +		chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);
> +	}
>  	if (chan->chan_id < 0) {
>  		pr_err("%s: unable to alloc ida for chan: %d\n",
>  		       __func__, chan->chan_id);
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 1f893dc54c79..d214df55da3c 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -987,6 +987,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  					&dw->chip->dt_region_rd[chan->id];
>
>  		vchan_init(&chan->vc, dma);
> +		dmaengine_set_static_chan_id(&chan->vc.chan, i);
>
>  		dw_edma_core_ch_config(chan);
>  	}
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index fe33a20abc61..f669b79d7731 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -369,6 +369,26 @@ struct dma_chan {
>  	void *private;
>  };
>
> +#define DMA_CHAN_ID_STATIC	BIT(30)
> +
> +/**
> + * dmaengine_set_static_chan_id - request an exact DMA engine channel ID
> + * @chan: DMA channel
> + * @id: channel ID, unique within the DMA device
> + *
> + * Drivers may call this after initializing @chan and before registering its
> + * DMA device. The dmaengine core reserves @id from the device IDA instead of
> + * assigning the next available ID.
> + */
> +static inline void dmaengine_set_static_chan_id(struct dma_chan *chan,
> +						unsigned int id)
> +{
> +	if (WARN_ON_ONCE(id >= DMA_CHAN_ID_STATIC))
> +		return;
> +
> +	chan->chan_id = DMA_CHAN_ID_STATIC | id;
> +}
> +
>  /**
>   * struct dma_chan_dev - relate sysfs device node to backing channel device
>   * @chan: driver channel device
> --
> 2.51.0
>
