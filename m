Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C03A8737;
	Wed,  5 Aug 2026 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955680; cv=fail; b=Kk8YsjgvJyEyN6K2OLlUL6bty29gmkpO6kkeSLebsb/Zmi1SUW+rHsm12IQVBsDvfVyuDQSZlfCv1fd903lvBNyRfB+Foo7ScI4Rw7ypUqZDVzL+/RjWG60WtacNrrW9aDYdVybNLiCkMujwZk2azOvp9D7kZuaZ0kuDsb3713Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955680; c=relaxed/simple;
	bh=OqqbjP0whX4ff13UaeXqggVAg2ALlhv5JGveKw50hTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YQCVHsXxk0TrpP/klWViEUHTjG+6c+N1o/JTzIGXUKwqee9VPInxPL8tPuTnn7ezsMU52c9b/x1UddUNihZVXhkq221LzcWBT8ZIJ7dDlgIe0yDfFUvkAg2GDrX3jAJB+rEtZZHee7AlA+LuSBA7oGzIfrOJP0m7xBc4tQxQLfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PkvgfgP/; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PkvgfgP/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ooxv3EJBVHHZrB6Fi959yMa/0LeguQVlJdLKX6eUIyLRLXvRtrW6SSwiOrPMD2J/0h39twXLGIrMJ/G2QguKQ1xogoc1f3VOAwocxzAa8bYrGlxewYKyKMqGpQhGPlbRvL8yZX3eoYv/MctO1c2u/w/HPKDFa4zAiTMOzph5Hp6Rzcs52HzBXc8pyAq472tRVt8PEHWv1V00FlFxgvJwhFI2+lUJLjIVVoyVf+awZDwZmi7mHIuUftIKj7NOoZIsSrOC4tn1iTbzABTKmzi/pQfkvpgOl+WGXO8nTRuRhMTJFNpZV7yWWohP7MelT92KYI25F0OTvEuCGqCpATAOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4LVx8lfJaKhZZDSZJNMQry0arKLYVtpOVbzSYqtI+0=;
 b=KFKbT9kjZk2okU0exvSN9tET4z7YziB641IeXXFiPhSkKJQ4LR7tbHYt9Nylnhol1DABlL+RKgleQErfn82k42yMRx5FZoRsHdFCMVfGEx2E6j0iOEMSUBw0XIpdZDo4h7vWAIE3kMggFnewFcMkspoB1Hkj2DCpD/AykfoUgTqHnTBLYcG3RF/rEMiSJVohJvyEv5c9kCW0oHKjDH462foDzpzz89Mk8ypyTWnfMXk/ON5kv9TfdvqUvauq1HuWQ/bGK/Aqzp2iKN8nHFVuoqIq1KZtMViadtM1QQDHiSW2DlQjSsY4KlBMxbT+P6XvG4Xs+ZYzuL0AxYySWyVJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4LVx8lfJaKhZZDSZJNMQry0arKLYVtpOVbzSYqtI+0=;
 b=PkvgfgP/g6VLDujULYQnXV3zRmYJvghipvZISrKqx4HhFX0WCNUn9SiJpk94wseyACFaRedRCvdrs2G/qHVm1ewPsoKGgp4jgEie0g6hu61iSXDyHQ/w/KtsHwrU4aonQXvzoBur+BIJEC0XrB733tSYyReFIugJZXdjg7vddIOwCn0UebPT4j8npe9oqDxGyo00FiQWuAPkUK+Vdx5T0kZHq4sVkpjdXZKIpfEcSX6FWWK94HRBRmlGX1/g4QRvXCzwqoq0kHhstUEE96C9loy/qjUidBKjjkvwgiVv5PtMdRL1d58n/hi3QywvuNbER/ublFtBrYjLy0yRy+uv6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8074.eurprd04.prod.outlook.com (2603:10a6:10:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 18:47:55 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 18:47:55 +0000
Date: Wed, 5 Aug 2026 13:47:45 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/6] dmaengine: dw-edma: Add delegated channel request
 helpers
Message-ID: <anOFUSDiDjD0jvei@SMW015318>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-5-den@valinux.co.jp>
 <anISE4zj1odwT2aJ@SMW015318>
 <eu5iqhvvnpklaudcb7tkbjp3hpzecyzqxdbf4u7fnh6bjjgcqe@6hpimw5vu62m>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eu5iqhvvnpklaudcb7tkbjp3hpzecyzqxdbf4u7fnh6bjjgcqe@6hpimw5vu62m>
X-ClientProxiedBy: PH8PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::24) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: f84f5f03-a1e5-48dd-ce03-08def3220f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|19092799006|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ipkqhgB0HK9iIdmNd9j/Ln2sMPN1pue1+HzENU/XdE5Ry43UZ9UJibkRJpibAetUZuLUOwT5hYz9v2WgTNtHm3MUa9J30gGMgQTsKMvmYncRPwc2FE5D1yq/90Ix/3vrtny+e13IrNnG0LIMEx705OmpAB95U4iMW5KasGqcGM+wMeVbtVThrRoutYPqBmDgfOxKkt6IvHfpNzfYJ4/nyHJFZd8xAr/MirFsIzh88WeP+BLGP5HYZ4ldqux+ZIFBRJF2cZ9s2CnhRliNsUVW75yvA32Ji56maOpYA+Qc03iThM3BjYp/TFH9olQKKwVHGyc2PIh+W7rXhG9lBxiV1G/z5kM46MD+JXDFNwHKl9oWAe+gB5p+wNAAm3sfWANnchnM7B1oWvVf/CKnbse1q/b1aKQSBaro8DVBvS3BEnLKtAAjWEnXfKfIqIK0/abaBPWBVtuoo9AdkiJnHbsJl0HKfO3fbrlQPPw5om54HuivsQL2J5/D2ZY4xDlDEdxBcAewoW3cbZzTMmttGqlH1OATB35H3noxQZhe8oBvnx/Jcplb8ItjdQqTUZNE5kyBlqyRE2VgkBzG78Y7sRQjljjhejXjTXmjVHoT4+P5WwK5GRQgklT9Hs4TEuxkqG+8Lgj4jb4Zdot65DIs4GWRnMxc8LyIU0xJGfpkxEwMidA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(19092799006)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xR8Bee8XwPQTZC2CML2HD2/W21XK6q9rDWnTUvQpAijgV1B2M/1VOUIrghGo?=
 =?us-ascii?Q?HkiKZdW4pIKiNpU9o5J5yaAWpdJu0BRDp75F67KKklJzwCMfY76yrQEGh+y/?=
 =?us-ascii?Q?Fpcd4FX1AVx9Zz2iORDXn7DXdVbah/uq+4cla58tjRWQtW5OTOr7L8hoFSV8?=
 =?us-ascii?Q?yuJCs8Oq0p9x+DJpiFaUG3GRnQGn630c1ehEShZOStKKIYWoACknzMbikKK/?=
 =?us-ascii?Q?hOaPeR3mbh2rSfOw53Pjr2gRq7y+/JlQTV2BtqOWu39OjUJdyxX50Yk5dZrg?=
 =?us-ascii?Q?JQZViEbF/LtUB9ZuuUKp+3x/yjZOY6e1YGwW6Z4+Q7E/fE8LEdK3IBZ4p48w?=
 =?us-ascii?Q?oYQegrbLPJP69yh/bdZL3egVXgaX2sB9PNGwkFW6MIPijK3ke2/4NunqvgWJ?=
 =?us-ascii?Q?jSRjni3PiikqUo2BrN3PAgpA7WHxYL/va0xCNshnnam4YK2c2TWZ51tBQ7/n?=
 =?us-ascii?Q?YwWzV1lw317P5O7GJD91uaF+32dZve8mPGV4+EVCYsA6iFF+tFSgxidiW3ey?=
 =?us-ascii?Q?2bBtPqVbsxOcHMsExcG+IQk/s6eDBEjMVp6eUgYiijKy2RVcAyhDBaCOHJSD?=
 =?us-ascii?Q?K7vVANaquk8DI784Qzea/waAJLt3DDXNA5j9OOpHvY/unKdvhdGnJUa5P2HZ?=
 =?us-ascii?Q?eW82SXENCrKtV8Uq/UHNJidsF81k/zqldqqwEdkIscjhkm3whpZjrjzjGD1f?=
 =?us-ascii?Q?szQvkC0eCI0XDQcB59uSoNuYehM2qhe0ZB4etlK9hSWpe/LDEmlpVS1zskBZ?=
 =?us-ascii?Q?J7U0+3oiIFeJID2OJswWOFPONkqnbiwPsgbPnNrQQgGfX71zFGFUXwf1rqDn?=
 =?us-ascii?Q?q1tXhkHB1fnX5Wd1rJfDgy471I8d9zqBX4MkpR4RGFTBgOS4v4ZXbTydMnWN?=
 =?us-ascii?Q?jTlFhgMdM5afb89UicqM6x4QNLsUse/qlYAZ4zyUhuj8EEb7/s84fGS3OYAf?=
 =?us-ascii?Q?WJzDRN3Fs85InZHjW9OpI8b2lt30/4ZlsjOVxlAhm2erBiOYQlISDINWZD5Q?=
 =?us-ascii?Q?BtofoP40GIoEPYyw/ikErEvEJGFgvhaNwqOzl5nxFZcx6aVNVNW9mWmqzh4a?=
 =?us-ascii?Q?Mmxjh54/jBIkUELEBC3irUivgRMEAJR372M1D9cjglkluoUHqTOVJhm+6yYK?=
 =?us-ascii?Q?liJoHU46edxcZVJ88mMuFP3hSXkYxl2Xhm7yadrQOFk1oYc0ODJ3HyhORnaF?=
 =?us-ascii?Q?w4NOtt275wZTtvXQ6xM8NCA/eWerF8TdO8vvE7IhkVm2iMZYaPUMEKyCPsvq?=
 =?us-ascii?Q?XMaDkY9NolNhN0xWuU7xCcrsM+nQqfLaOYRX3BOt7JpIliUSRcwN3gDeJZ31?=
 =?us-ascii?Q?VTADg4ERexYF0RujM6o5NkLN59oj3Jzy+DMsypTr+AplVQG10LUuTvoGaL1p?=
 =?us-ascii?Q?HchR+dSvinf4ZaMfgvxzcoxL4bHY604ij5VOxisR6XJu2+peTbhiYot0qTQO?=
 =?us-ascii?Q?fCVAiYh3IdNjLZE6jfVFoxqdQCCz5hC62fE+ANwxKJx1blCqGlXqffpnAyfB?=
 =?us-ascii?Q?FB+t+6PU7TUak69cQxymQqdnbOqrQpnCWJd/ZzmKexMhBV5v11d+WWaZGU7n?=
 =?us-ascii?Q?E5ck9ppxyMHYVtY2lIxcH4KKEHCg6RKuw8PGjrBXzvupabmcvPJMVcHDDv24?=
 =?us-ascii?Q?swqDl1ueV9PxC9D3F0Vg/LxZFEWqj/D7uQUitRbpwQCS94X2hzwexkxf9Ezw?=
 =?us-ascii?Q?PsrodhO6/o3ya7fTTkin1ABO83WEhQ8oqx+Ztq1DAk/ieInpzV/+mZO8qO8i?=
 =?us-ascii?Q?TmmR+J6leFxODkvoaKpjM9nFvywHCvR4kUCLpI+kCwsFJjFS2oPa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84f5f03-a1e5-48dd-ce03-08def3220f0f
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 18:47:55.2199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loEO561JGZyo5+hkjVEoXe6ZaSVhOdrwayZOtqA15rmU6NgX0wxCqJgkwoJg5uAXfDqNWcB32repozKIv+vq6RUtLs3W2xFzR9zWRn9Kf8JBdZTlsgJ2YeS9nTImj6wr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8074

On Wed, Aug 05, 2026 at 11:05:21AM +0900, Koichiro Den wrote:
> On Tue, Aug 04, 2026 at 11:23:47AM -0500, Frank Li wrote:
> > On Tue, Aug 04, 2026 at 12:38:53PM +0900, Koichiro Den wrote:
> > > Endpoint functions that expose endpoint-local DesignWare eDMA channels
> > > to a remote host need to reserve exact hardware channels and hand
> > > interrupt ownership to the remote side before publishing the channels.
> > >
> > > Add DW eDMA-specific helpers that request a write/read hardware channel
> > > through DMAengine, keep the hardware-channel filter private to dw-edma,
> > > and switch the selected endpoint-local channel to remote interrupt
> > > routing after the channel has been successfully reserved. The matching
> > > release helper can quiesce the channel while it is still remote-routed,
> > > then restores the channel's default routing before releasing the
> > > DMAengine reservation. This lets callers skip quiesce when unwinding a
> > > reservation that was never exposed to host programming.
> > >
> > > Release is best-effort because its callers cannot abort teardown. Report
> > > a quiesce failure locally, but always restore the default routing and
> > > release the DMAengine reservation.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > > Changes in v6:
> > >   - No changes.
> > >
> > >  drivers/dma/dw-edma/dw-edma-core.c | 91 ++++++++++++++++++++++++++++++
> > >  include/linux/dma/edma.h           | 14 +++++
> > >  2 files changed, 105 insertions(+)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > index 1f893dc54c79..4c0d2bba755b 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -1302,6 +1302,97 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_edma_remove);
> > >
> > > +struct dw_edma_delegated_chan_filter_args {
> > > +	struct device *dma_dev;
> > > +	bool write;
> > > +	u16 id;
> > > +};
> > > +
> > > +static bool dw_edma_delegated_chan_filter(struct dma_chan *dchan, void *param)
> > > +{
> > > +	struct dw_edma_delegated_chan_filter_args *filter = param;
> > > +	struct dw_edma_chan *chan;
> > > +
> > > +	if (!filter || dchan->device->dev != filter->dma_dev)
> > > +		return false;
> > > +
> > > +	chan = dchan2dw_edma_chan(dchan);
> > > +
> > > +	return chan->dir == (filter->write ? EDMA_DIR_WRITE : EDMA_DIR_READ) &&
> > > +	       chan->id == filter->id;
> > > +}
> > > +
> > > +static int dw_edma_delegate_chan(struct dma_chan *dchan)
> > > +{
> > > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > +	int ret = 0;
> > > +
> > > +	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > +		return -EINVAL;
> > > +
> > > +	guard(spinlock_irqsave)(&chan->vc.lock);
> > > +
> > > +	if (chan->configured || chan->status != EDMA_ST_IDLE ||
> > > +	    chan->request != EDMA_REQ_NONE)
> > > +		ret = -EBUSY;
> > > +	else
> > > +		chan->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> > > +						bool write, u16 id)
> > > +{
> > > +	struct dw_edma_delegated_chan_filter_args filter = {
> > > +		.dma_dev = dma_dev,
> > > +		.write = write,
> > > +		.id = id,
> > > +	};
> > > +	struct dma_chan *dchan;
> > > +	dma_cap_mask_t mask;
> > > +
> > > +	if (!dma_dev)
> > > +		return NULL;
> > > +
> > > +	dma_cap_zero(mask);
> > > +	dma_cap_set(DMA_SLAVE, mask);
> > > +
> > > +	dchan = dma_request_channel(mask, dw_edma_delegated_chan_filter,
> > > +				    &filter);
> > > +	if (!dchan)
> > > +		return NULL;
> >
> > I forget, why need export delegrated dma channel to dmanegine? If EP
> > driver doesn't report delegrated channel to dma engine, what's happen?
>
> This just reserves the exact channel against any dmaengine clients before
> handing its programming ownership to the host. Without it, a local client
> could request the same channel too.

why not epf function driver call dma_request_channel() to decide which
channel pass to ownership to the host.

Frank

>
> Best regards,
> Koichiro
>
> >
> > Frank
> >
> > > +
> > > +	if (dw_edma_delegate_chan(dchan)) {
> > > +		dma_release_channel(dchan);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	return dchan;
> > > +}
> > > +EXPORT_SYMBOL_GPL(dw_edma_request_delegated_chan);
> > > +
> > > +void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
> > > +{
> > > +	struct dw_edma_chan *chan;
> > > +
> > > +	if (!dchan)
> > > +		return;
> > > +
> > > +	chan = dchan2dw_edma_chan(dchan);
> > > +	if (quiesce && dw_edma_core_ch_quiesce(chan))
> > > +		dev_warn(chan->dw->chip->dev,
> > > +			 "failed to quiesce delegated %s channel %u\n",
> > > +			 chan->dir == EDMA_DIR_WRITE ? "write" : "read",
> > > +			 chan->id);
> > > +
> > > +	scoped_guard(spinlock_irqsave, &chan->vc.lock)
> > > +		chan->irq_mode = dw_edma_get_default_irq_mode(chan);
> > > +
> > > +	dma_release_channel(dchan);
> > > +}
> > > +EXPORT_SYMBOL_GPL(dw_edma_release_delegated_chan);
> > > +
> > >  MODULE_LICENSE("GPL v2");
> > >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> > >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > index 3c8e2ef9dee0..944469258b8b 100644
> > > --- a/include/linux/dma/edma.h
> > > +++ b/include/linux/dma/edma.h
> > > @@ -153,6 +153,9 @@ struct dw_edma_chip {
> > >  #if IS_REACHABLE(CONFIG_DW_EDMA)
> > >  int dw_edma_probe(struct dw_edma_chip *chip);
> > >  int dw_edma_remove(struct dw_edma_chip *chip);
> > > +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> > > +						bool write, u16 id);
> > > +void dw_edma_release_delegated_chan(struct dma_chan *chan, bool quiesce);
> > >  #else
> > >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> > >  {
> > > @@ -163,6 +166,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
> > >  {
> > >  	return 0;
> > >  }
> > > +
> > > +static inline struct dma_chan *
> > > +dw_edma_request_delegated_chan(struct device *dma_dev, bool write, u16 id)
> > > +{
> > > +	return NULL;
> > > +}
> > > +
> > > +static inline void dw_edma_release_delegated_chan(struct dma_chan *chan,
> > > +						  bool quiesce)
> > > +{
> > > +}
> > >  #endif /* CONFIG_DW_EDMA */
> > >
> > >  #endif /* _DW_EDMA_H */
> > > --
> > > 2.51.0
> > >
