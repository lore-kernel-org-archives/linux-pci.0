Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013069.outbound.protection.outlook.com [40.107.162.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000037E2EC;
	Fri,  7 Aug 2026 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786131841; cv=fail; b=TBSrOOHYzPVaTyIsU3kTLLSkeVnnm3Ytbun8DYVOjG1IOKb3CP0cLh/+QKqXpl7W+K8U4+QkKVo6DbkkXL5NRuDuLmarQiW6VSdh4ZfZYiMuaRDIsOrfG+Iw3hk2k0ArKkj2LbUjcu2MNn3rfg0Npw90yY+EHj3It1louxYHi7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786131841; c=relaxed/simple;
	bh=8n4Ord594dg3976u9blAShz2B4Bk0Me1yXSlAsCkXf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m394D2vuHfyEdRX6HhGcZQ9rWilgPzZjVyxCj14c3P5qMT/nh0guohzenAbtoEG83S2FaU04xs1QIcE5t4SOTcFy3R5glYtgJtT/xXkVEvbOGZLQUvWMBrbovkqcxRwiIMNE49Mr+e14CUhAXKWwEg81ie1MpOYBSIQFNGEP4ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=H7NkQe4f; arc=fail smtp.client-ip=40.107.162.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="H7NkQe4f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDC24Z5S7XZbFuwRk7nwP8q+I3lB1LF5j8yvvtEwD07RU8hyBexhhoV1fFyDr0Bt3DR0BQX4X+zc/4Epx9VdBqV05eZZ4LJVnJy10jR7qYDEkeVYcukauT3WS8kVm6nxht6opC6OLcYkMZKCjjZBXzyDwLYWK/atTXq8DOycuvZumMNQyK/o1ui+dI3WpnCH9ymLgpUyi5wII/KGhp1ziy+tPueMvYTZh/UO9sBQlobOfaFLjNL0tGcePLnLcyZwSAMSrx0URFHZT0jia5MekyylR855GhmC+28T7H3b8kXxvuU23wPZX9pABo0LWFksJC38fdix4qG2u7Gopm2dwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOg4DXjn1PfGRsjFAC/HuldcXoQ+Rn2vS0Cgs3gNp2w=;
 b=dLvGDmtWgh7AUMNuJw5K9zNVFPWpxYUkIiP85xdl2hGZO/8g/sAGHxREsuYq3FCwKSosPB32KE8IuejvtubglsWmoO36Bu8yPfxCpzwvm/ScLO+UqAFNQWJcCLXBhFc9ltZ0oLznJCcDrJPqhHO2VkCqutTUi5NrpQyVAWS7NVeqC3ie+sye9swB58WEUn7i/Coxwin5Toywe8zamrjkrUj6ELUxhkv5emmmxoDkTqxoKTYruXptssTq75JxjvfCBTLz4uptMjTSOtvlpOMxj9TyBHrDCdkGFBCvgI1YPPvPcUolOIu661SKY2of7cN59khXHfzbFe5hqAI6nCk5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOg4DXjn1PfGRsjFAC/HuldcXoQ+Rn2vS0Cgs3gNp2w=;
 b=H7NkQe4fIu7imw2WH8Q/I157Rrowb4gl0O6A+pYWF/7bAnlVvJx/lg37vaDQ3eS/ywhZQTUO5uNWUXtyWKUNFTu6xf8dWsMaouetqCsSJHPkRjUhwG8HRAsftB5CnBbaCgZVI8DCpbUeAi6Hd2RcsmtBdPpYe7i3wMU8BN8juQUz84iajAtxRtpBWsNiclgMstSmRUWV4DgdZAYmxYdqVntNbwiESH7x7XzC62KFLsYTMOFQVg6cov9Fckf9haxfbCt8XUtXwDg3ACQ8ADmM5n8g/5PyK1rImh9Xzh24LLYJQaXPV2pMw3o8kpeeqymkBpEc53nAUj8P4kggMLisjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMBPR04MB731824.eurprd04.prod.outlook.com (2603:10a6:20b:7af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 19:43:56 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 19:43:56 +0000
Date: Fri, 7 Aug 2026 15:43:49 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, Frank.Li@nxp.com, akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V5 07/14] i3c: master: Fix potential UAF in
 i3c_device_match()
Message-ID: <anY1dU59JIvV-6BB@lizhi-Precision-Tower-5810>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-8-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807145638.168865-8-adrian.hunter@intel.com>
X-ClientProxiedBy: SA9P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMBPR04MB731824:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e504f93-76e1-4d04-99f2-08def4bc37dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	s8sYtcDCzRSvMF5hguOnA/bsFWGWfkWKiR91MFCFwBcD+AW0xfLnMC/VLnn2zxZ9vj7q6gJSbLmLhGYs6JgOWYLdESavia9XcA2ZOupwO45NwyHCMAdxSM5q2KE2XmygWELjJesjaRnHcwLGXVXeIyyqp1GXc1YQwaceSD5a4vbyOMqDky/j2bexgvkhJVAZqnYtPCza264m+s9E5ZWbni/JSuwvk3zKa/1aMK7GL/UrJMqoVltVkWX24iewb+6f+lTiPzZ8Ok9t+4iD3zJ/tQz16z7GZwXMi8VG0eU03U/dHwZn1WG7Rq0dsmHVao4rlN5lMdg29/mUf2ayI7gyca60nB1jjvhpNk/XS79jopi2jb635hXo9vRrDlz/tBIlEVxBZjlGtCUJh+8rFyaWRpio+ltQ8kqQ23nZgVS/qL2HhV9tu1va+/ytjj39i9da1xdJH8pKVMEFL2iEZb6RWFxn7cD9paCLCDZZ+6C2KDwuRoTbdLf+lIIxMXazCfwCyUG+sVkXerNjD1t1ba3MXKIxofjKdFH2BGYrF4WEzopAwAusW3g80B5v5CECDI5G32McEU6V8UU1jzqXC+YMMFggbSErnB3YDRzTmev7WEVilcnHA0/+EVNcwmD1J3jePwO7wNYXHEdhiGhwjf547wPwbEMHAhv2dAoGcyt2PY0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LlMceCuvmBiE+UOiLLFmE+NaZlnDJc3R1e8iaqJvsNkg4w/ERA5tQSh30lUM?=
 =?us-ascii?Q?pGElJaNxWuwdeaWvrmTFGs1AzNrd0xBQzNHx10vsb8kuxHMHQ1d2ICQ4XUqg?=
 =?us-ascii?Q?7PmAuEfug3NvAET9SZ39GNQaMBKEELstpDrUN38BgkwcOJCvxmnV0QvMX0tN?=
 =?us-ascii?Q?uFSNyuC3Sp0QIvVTBm2R6ezY01teUcC+W4dA0/6R65SZVsT7Xo3BGMmNx3nY?=
 =?us-ascii?Q?JKOn+Me2gu8kcOG7Odeb1SmPjdKgWpZAC4/ZSr3en3bwmTSkAKusA4TXyhfn?=
 =?us-ascii?Q?05KSwCfYFelRq8JjYEcN8UJmBkzyvhWjIDk8MHPw7125eDdgYgIUSikMGSMi?=
 =?us-ascii?Q?NIkG3h2vckqwUlukF8rvCeJx2/X125a6r6TUoFp0jSVfC0V6V2r3rrVnpvnV?=
 =?us-ascii?Q?BOreyy+a2QDi1Nu9yj0WDaNMPopV3sAy9ruPtbbqvWECNsh+1NvyW4GGVS9K?=
 =?us-ascii?Q?1whZjFKQLyqOf3FU0TlJRGAQmj8vDo2wNtmMRi/MI4vT/x21J6efB/qV9DoV?=
 =?us-ascii?Q?8s6Iv5ffmmPgLKpyB0CNhfICQB9syzQIy2DBt0ny7PwP0GIXHLvhuzyfH/Th?=
 =?us-ascii?Q?xzvUuXabgmU2ssM0UvEuqz02Pq6wMZGYfLEQRZQhhWb4WfgWqLr8GU+nsoqD?=
 =?us-ascii?Q?0VbZdiIzS/Z2HmaXl9FimLwpYP5/vBPlr++Xhm7psBVby7vifAcZM+hnzysF?=
 =?us-ascii?Q?W0VnZlnfPQEqFW9PHEWUZvrIugZk8Px362E0vU+hT9+cQHlt1ZXV2JRaiQlw?=
 =?us-ascii?Q?d2ymMl2VNPeeCcujenxUFFsE8A06z/UDfkl0sdkda2iCgUM3DjRqjOMd6RHE?=
 =?us-ascii?Q?sBeup1bAeQ1XD9HyWsbV7l0dee1oKkXMRP5+g/Y4ELa3HKPVPJBSawWiLHV8?=
 =?us-ascii?Q?ieyAmGGkmK+VN/VTd0V/clsBvxcCjDOq40zYYW6wK+OsG5sN9kwArhD1VbFh?=
 =?us-ascii?Q?9MYQRf5S1txZ+ykym8ZOw808JxlT/kNxcyMXYVAwVGlvYb65s+bA8GYaxok0?=
 =?us-ascii?Q?HOxcCfcTMkMMmrQvjq5scvaKGGRfbUvUdn+vod3irCC6EF7jn1ldLNgzwugc?=
 =?us-ascii?Q?5hFpI8PyEmHqCdcZjNuBbOF4+hDRtM2mbB2CPR/zqZqo23NP3p3mVpoZyC2J?=
 =?us-ascii?Q?d0JHgnHdIwsz79zpK4M/uasYgHVEMAiRXnlwD8Iuxd7WRNpij4WcwJNLgD1F?=
 =?us-ascii?Q?tJ7dl2zjl+4aFct12X7zp6346BPI47IMUwr3BqnCot4Bcu4LbWKOu7U8a12O?=
 =?us-ascii?Q?KlcAX4qLK+qkELCXUDbe9lQAiJdJcU5EzeHr1XPrPpm+WRKZCwxvdMmXoQh+?=
 =?us-ascii?Q?MKowJ77zGmDZOOz5TWFvHo8KEa34Rpbp37TpE0DCy5SWoqt0/iWtSs5/G2Eo?=
 =?us-ascii?Q?Sx3VQvrjw5Y3nM6NfDQjbXb5MloFCaL2ySsimrtT7JE1Zs4NPpeid8Mf4yAT?=
 =?us-ascii?Q?zW7fKGNRgznE+pD9jdR/SoEWG7QOnCkkYiepIh23zhjfYUwCpNBgs32dFYuK?=
 =?us-ascii?Q?Ul2bqe5WZcOJbBeT2Kd1v9LQzIQgDroVfqmUx4iPa9gY3ITQPuFnQXBrKRRO?=
 =?us-ascii?Q?6lUEq8P3lk4U5yJUjncPKuaa1rrznNYAHZ8FiKpVfF9thBvNIu5TXEGaNp3n?=
 =?us-ascii?Q?GIA5HKBxG9Hq4gYT4I1za5yKthVR8Ok12c9oAUQJS2+gSxkG237YaxFOEs77?=
 =?us-ascii?Q?X5Mji6sxJpIZ9ATTPzvpI+IKI4q0RD6ehy/ad/9hxPBL7d0ZEKMqZQ2tIpUL?=
 =?us-ascii?Q?owNNOtE2ZMkweXxLyqrK6DOgsjxhX3uGKB3nA008PYC6r1fi10gG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e504f93-76e1-4d04-99f2-08def4bc37dd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 19:43:56.4543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zjw4UN+IauXSuENYO1+rgMbh6MlYLu2EbdyI/pfbLuwggPbwUyPR1Dg+4DcfOKsg0JchpmkoLQXJmFc8u2qI7SGINruJUzZ1OQgqDc+3ny2Uv9rHAqFYLil8IqZ6vcUE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB731824

On Fri, Aug 07, 2026 at 05:56:31PM +0300, Adrian Hunter wrote:
> i3c_device_match() dereferences i3cdev->desc without holding the bus
> normal-use lock.  Since the descriptor pointer can be replaced
> concurrently, the dereference can race with descriptor replacement and
> result in a use-after-free.
>
> Protect access to i3cdev->desc with the normal-use lock.  While the lock
> is held, the descriptor is guaranteed to remain valid, so the NULL check
> is also unnecessary and can be removed.
>
> This change depends on "i3c: master: Fix recursive locking during device

Remove "This change",  just depend on ...

> registration".  Prior to that change, taking the normal-use lock in
> i3c_device_match() could recurse on bus->lock during device
> registration.
>
> This fixes "i3c: master: match I3C device through DT and ACPI".

It should be fixes tag, but this patch still not in linus tree yet, not
sure how alex handle this.

Alex:
	Maybe rebase i3c tree,

move "i3c: master: Fix recursive locking during device" before
"i3c: master: match I3C device through DT and ACPI"

Then squash this into "i3c: master: match I3C device through DT and ACPI"

Or simple ignore "this fixes ..." sentense.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

Frank

>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
>
> Changes in V4 and V5:
>
> 	None
>
> Changes in V3:
>
> 	New patch
>
>
>  drivers/i3c/master.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index ee771ac0b203..83e04a2c202a 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -347,8 +347,10 @@ static int i3c_device_match(struct device *dev, const struct device_driver *drv)
>  	i3cdev = dev_to_i3cdev(dev);
>  	i3cdrv = drv_to_i3cdrv(drv);
>
> -	if (i3cdev->desc && i3cdev->desc->boardinfo)
> +	i3c_bus_normaluse_lock(i3cdev->bus);
> +	if (i3cdev->desc->boardinfo)
>  		static_addr_method = i3cdev->desc->boardinfo->static_addr_method;
> +	i3c_bus_normaluse_unlock(i3cdev->bus);
>
>  	/*
>  	 * SETAASA-based devices need not always have a matching ID since
> --
> 2.53.0
>
