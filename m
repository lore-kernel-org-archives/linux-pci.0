Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D61B3BCD17;
	Thu, 13 Aug 2026 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648320; cv=fail; b=K57/iz2yexPXzdSdzyOn1mRKhNO3VCwoVANi+ZLTp1YLUXV2FzCET6uE7rpJua0UJZ8Ez2gFp1pl2hGCMdfsiRaVGiZPkA+61iqistwiSA4K4Gf26Nso0MaZlCXMOKX2PQgxP/HZ9qnmdypx0fdvktHaa9Hn2ti8nRtVML2aLxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648320; c=relaxed/simple;
	bh=99hArorSLEpfNXfZRZ9ayysTggS+fSb7V0PvMDSYwCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e/Fxk56TZVt6UxBY7tGHNkOPwmhV/a+5eYwHCojw3qZKZirCQ3vp1WfwG8lbZ9nI4tFhikwIaD1xf5POcKLvx4coB55jncT23u+u/mu+LykzFbhfcKXJWDe1bcQ2eIvyXXRNKkWfNnhUe60YpWkJqrbp84B6GnrEXMBgfbHhDKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IHhRa5cy; arc=fail smtp.client-ip=40.107.162.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IHhRa5cy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKLg/8vRzUjEwuhEZyBCY0h/DaIQ9HNx0wzMqI4s31WhQFREp5Clu6aGcU1nvxOaYwJCzkNrejidG3v85J7kG6C6xtTGjaQOVzKskbG3pWEY13Jz1sViL4rpozTeZuiUFb9XI2wu4+HaVP9WfGyjkb9z7FYBHpDSDLDfwVOQcPojZFYDhxZxqb41zDjlxpCeh7A3/y9T5fvgXtXHAu3v/tf5Xk64i5nb739MDdq/QKeDK5QWa5fjmL6zUlpO359g/23fPhOR+v3yI5BYD//0vOAXgPGGd7Skyuu8+frC/edzf4bgRTlxElkfGv8Fgtkn0KdFQUHrQF9PZCnQNJEIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnEs0PKL4DN9+yfczOT4c+bV7Ey7PI+rydKf2XiCF1I=;
 b=RGHHaNUYh9BbpL1k2JayUwoJHCXB+KXlPVH52ndSN9KHxQH9+QAClcBK+3Bp53LoN/pXH264yfZ/eO5U2gkWYD+OFm6WjgN8RAtG6rL3G8Qb9zU2UH1GY+LM+M+HThTzbqxKh1Gp5tIH4iRo3efAwrQ4sb7GIgEHgITsy3PgyAT+aQATwY7ukC4iLRry8+jk7FoNWPlU9ySvfW1sJdQZrfpqBuAqe6t8ca3gJrLZfqT0X0bnAB1Gx3/SIoIjQ38HlciRlaA2165+15rt7RwXvKoohMSTdi1Vye0zMK1ulc+0DCeHqm3T87hT89+BvYayRGleqB2pOOyH6kUvoyC0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnEs0PKL4DN9+yfczOT4c+bV7Ey7PI+rydKf2XiCF1I=;
 b=IHhRa5cyPYhp98szJgHJK6Rb5btt3QOEfqf3y5ZRs2jzdzHnu7VhKulC6EOt3puDj0ZZ/cim97c3rbyFzBXiIfZpQbvG6LqWutTutEmBuMGR7PdR4bMIMFn0v3mkyAGYI4D+RWGQyAb2OknGQ6P+6uAe2nGfXERHtEEtw/jcsVVICtKKCIqZ5SthkvaXuWMgjfbIRsm2MFgTD5CZO+uR54uTi2m6xQ8qg1il17ikCkN0y5F1ALZSV1vL1IBCu3L4McKveXagmBV0S9y8aCzdMiye3HtQMvr58NsQmHLDt2oHt59LE8OhWx9POagI4Gqa9/raIQsXdoKXOaI5DVQqbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8326.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 19:11:55 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 19:11:55 +0000
Date: Thu, 13 Aug 2026 14:11:46 -0500
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
Subject: Re: [PATCH v7 05/10] dmaengine: dw-edma: Add channel delegation
 helpers
Message-ID: <an4W8hK3ZONZsVER@SMW015318>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813063757.3131865-6-den@valinux.co.jp>
X-ClientProxiedBy: SA1P222CA0070.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: fe032dc6-a1e7-4506-c0bb-08def96ebd40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|6133799003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1+ZCAXPGzd5uMqb5jLnafIZvIvjDjHtGg7gCwX1k/KdNBrNq2Pj/QU2M3GGx33XH5dayVH/Kqv08KdwUSJNH8Wj73Czqu0yrOLwkoAzOQMc3OtJx4VDR2r7qkEbg4v4r9IeSTV+MFMOwigiItogt0foUl1+5/T9ltH6o3E5wBe0yaOqpifk5ecKteRCM/SWTNeuKMTgFu72OKp4mtvZLVlt4BLv/SsjEP6Bdw1X+PWmANzYNEafZV155y+U3LEyBNTuMiUH26U8nHb/emwFcl8DBdoxrZ2YHIW1WNWrlCbD5E9N1i0IPV82uQcQeOI1cU2FrATSwJv1JGCAVjH2kJgYBAIHz2aU7P1BZaQRNyW4x8ww6/qchKLJUsMz5g5oL79i2Nf2pQ+Pueys2Fu6fHRvkQqXg0a53GwD94xXccy4Zjj6MrU9R72lpiflIFkevYG0DHTIiTeK+hiAf4O+Cv71lAcSWbfJ7oSVzhDEW8iFvCbUxdXN2I8azIBXYn2txAFCwjkVq1ABa1fQVtRpldib/UbgkRkBZSvq93GK9+IgTHvQr/6HHNdNG9kvjcOXSdG5CZPrQmDIxId0tseI6qm6NNqaI9yW7+RsgwZvHmJ0jwBxtsADJC0I8X6PhLvtV7/t2jge3oAXSbF/whEH7HHOZNbCClS9Xa4QDNzvQknE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lRpX45P+cvvilvK+B6O9Iu9YOLrHjqgwb2f+U/hX6iw+543l5MA//zuOPloU?=
 =?us-ascii?Q?Bwngln/VCRAIC0JksVsThCQo9Xtjb2Gmk4ySNxYRaK+pXR636ZmvvMv0MeYT?=
 =?us-ascii?Q?YZeEXeqSanlkVQaVOXZ0LFe8G37EFoWGdpWZq81xmUNKyttyX3Yn9Xt3fZTM?=
 =?us-ascii?Q?9AnNQcC5Glwd5qm1kiNjKgcoh6/2iZjwRGnpX8+NT/olhruuhJxWZtAsZZBi?=
 =?us-ascii?Q?GBuG+nPiiCkuAGdbl9qoyQ3NG13tFdi1InxalGDV80yNF6Z8jl8vDA2N82tK?=
 =?us-ascii?Q?sC9J0KqHAMG5G4ZQ61D1XCj5EVCJY3/iYUhZFTGBgKTjiqxYMjfiWbOJDELf?=
 =?us-ascii?Q?o0NZ+VjnuXD38DKKGVBZU+GWmswRlvN2NGAh++8mQYSpkCRLfcJmNcthyA8n?=
 =?us-ascii?Q?hkhz0TnoxBEHmFPv2zpIJ4EykWx/Db4utto8mBXjAP6PueSbncFQcw2uf7pp?=
 =?us-ascii?Q?cqqULpIDf7OvZVKCS8ib5sI/ANoKZxKmqTUZMmpOEsHkeRG55daKbfSXl+JU?=
 =?us-ascii?Q?OeyzE+dEYw8jKSnWyYfPZb67uQH1Jq2AygUWWthSxDdzZLBG/jaaFpMMHGXy?=
 =?us-ascii?Q?sGg5vRn4Vd4lNQU2wCGBhhDo8LOaPQceuIb3i5GqQ2txgJQkefCSwYau/Rf3?=
 =?us-ascii?Q?ou8nlQjZOn1yJ7W+werTE+ZLxyFdr9rgyjSHtgYgkzi8N6vdWjtZdTXwhrJZ?=
 =?us-ascii?Q?SY/C9mvYvbMcssJ1cjlARs1dacNXuUnIDceiitIXN1c4h7BCQ922eEV4Ep4T?=
 =?us-ascii?Q?ah/rbOvdfeRh/0Kd1x6U/fXm/7YzH4ebUdOcC2JgGrCcGEtvoadRMahNgfYr?=
 =?us-ascii?Q?23AcaIIq/xBqiD5XGQDiWExcMj5lOkYS/YkMfTepcme3MtnxuZatV7GZW5gE?=
 =?us-ascii?Q?QD9MpgM7W61afL8oPv4+v7qjhLAiy651owevHKooHvjIEGlIckfYYsmqxEts?=
 =?us-ascii?Q?atWifWgLBJ6DQPj5Juxepa3rMViG+Icfb8iIMlzvCUJyjzataksb+ntpYvWU?=
 =?us-ascii?Q?kT4KmAnBtlOasEWDaikHo3GojWODQBriT/96k7wpcv9s8+chiJGb1pBLtxa/?=
 =?us-ascii?Q?/qGmfD7yc1DckYFZH1rVqVeUIYeRGzY1Uqdj4dgvWSxfJnK3uyLk7nGWcrb8?=
 =?us-ascii?Q?Qthq9kcRSxRk0Il8wwvV445HiJb7GLiPK1Qg5dwWf5VZwwN7qDuuxNM241Hc?=
 =?us-ascii?Q?C2gHWvAaLX0jKIA/XrkFhvbzBz26Mq2eSWa60H9mC29fENzxVl2/OpyQWCFa?=
 =?us-ascii?Q?uhhD6l93ljwGheuxCv+ADVrdqOku7hOQf1+QjeYUJT2IHyxqVHKGrutKA39i?=
 =?us-ascii?Q?C3879wzQdb/Za/XY/lbyqrUwFZyXs1anC1LhKgqp0/obnOkq1EaqeqfICKbn?=
 =?us-ascii?Q?ZjQcrRrhGYncijFfTPZ4IN/UOAj4r0JIYQKEVfXETvtutHLAAB/CJdSHvjTs?=
 =?us-ascii?Q?V90/5PHTVSNq4kGf28UG5aZL4H2T37xsJpH3w1/WFlmToehDbxlon5gqtsTG?=
 =?us-ascii?Q?myjFq42qKW+YURGq1hqD1RPeY+YwCg1I//Y4xbTqvhaUzxIBAGYLhetqn7Sr?=
 =?us-ascii?Q?Ga6q8z6bvd6GW694oGX4zHfSnp+Tb2mSfHqB70D+0jEjOdvMPb86V3wDd6xb?=
 =?us-ascii?Q?asyZbRhPishxP2mtbOUhiDfpzTr0PBFKxk9YB4VhXlLliayPkoSFkYG+ZR1y?=
 =?us-ascii?Q?XP2cQMmN38BXD0bxZeBnT8vLFVA9w3UxmWzm1fhCbk9uUpZsrfMwtFYTGtug?=
 =?us-ascii?Q?v+yMd2XdmSoqzrcfOHKY4d3Zf5w2sii6m9VTRypBfNzQ46Rm1QH5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe032dc6-a1e7-4506-c0bb-08def96ebd40
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 19:11:55.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzD1Qg1W9nJQpHyEocsbG+r5wuNR3sDVu7EXq54R/VVSWYRHR2ynv9bzNQUtmyk07FmmFq2eAVONA563O6oNt2ZIlBg6aXY19r16318UnvY20xIimxMY7FPzjXYrfcS4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8326

On Thu, Aug 13, 2026 at 03:37:52PM +0900, Koichiro Den wrote:
> Endpoint functions that expose endpoint-local DesignWare eDMA channels
> to a remote host need to reserve exact hardware channels and hand
> interrupt ownership to the remote side before publishing the channels.
>
> Add DW eDMA-specific helpers that validate an idle, already reserved
> channel and switch it to remote interrupt routing. The matching reclaim
> helper can quiesce the channel while it is still remote-routed, then
> restores the channel's default routing. The dmaengine channel reservation
> remains with the caller.
>
> Reclaim is best-effort because its callers cannot abort teardown. Report
> a quiesce failure locally, but always restore the default routing.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v7:
>   - Leave dmaengine channel selection and lifetime management to the
>     endpoint function, per discussion with Frank on v6 patch 4.
>
>  drivers/dma/dw-edma/dw-edma-core.c | 39 ++++++++++++++++++++++++++++++
>  include/linux/dma/edma.h           | 11 +++++++++
>  2 files changed, 50 insertions(+)

After change to static id, needn't these private API. You can get expected
channel and use dma_slave_config to config use DW_EDMA_CH_IRQ_REMOTE

Frank

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index d214df55da3c..1582ecfc2965 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -1303,6 +1303,45 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(dw_edma_remove);
>
> +int dw_edma_delegate_chan(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	int ret = 0;
> +
> +	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +		return -EINVAL;
> +
> +	guard(spinlock_irqsave)(&chan->vc.lock);
> +
> +	if (chan->configured || chan->status != EDMA_ST_IDLE ||
> +	    chan->request != EDMA_REQ_NONE)
> +		ret = -EBUSY;
> +	else
> +		chan->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_delegate_chan);
> +
> +void dw_edma_reclaim_chan(struct dma_chan *dchan, bool quiesce)
> +{
> +	struct dw_edma_chan *chan;
> +
> +	if (!dchan)
> +		return;
> +
> +	chan = dchan2dw_edma_chan(dchan);
> +	if (quiesce && dw_edma_core_ch_quiesce(chan))
> +		dev_warn(chan->dw->chip->dev,
> +			 "failed to quiesce delegated %s channel %u\n",
> +			 chan->dir == EDMA_DIR_WRITE ? "write" : "read",
> +			 chan->id);
> +
> +	scoped_guard(spinlock_irqsave, &chan->vc.lock)
> +		chan->irq_mode = dw_edma_get_default_irq_mode(chan);
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_reclaim_chan);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
>  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 3c8e2ef9dee0..61ebb808981e 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -153,6 +153,8 @@ struct dw_edma_chip {
>  #if IS_REACHABLE(CONFIG_DW_EDMA)
>  int dw_edma_probe(struct dw_edma_chip *chip);
>  int dw_edma_remove(struct dw_edma_chip *chip);
> +int dw_edma_delegate_chan(struct dma_chan *chan);
> +void dw_edma_reclaim_chan(struct dma_chan *chan, bool quiesce);
>  #else
>  static inline int dw_edma_probe(struct dw_edma_chip *chip)
>  {
> @@ -163,6 +165,15 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
>  {
>  	return 0;
>  }
> +
> +static inline int dw_edma_delegate_chan(struct dma_chan *chan)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void dw_edma_reclaim_chan(struct dma_chan *chan, bool quiesce)
> +{
> +}
>  #endif /* CONFIG_DW_EDMA */
>
>  #endif /* _DW_EDMA_H */
> --
> 2.51.0
>
