Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A644C51A;
	Tue, 28 Jul 2026 20:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269042; cv=fail; b=RSpsGU5/YSRa340QBz/j7iRnt1NvGz+4hzzOGTUZODykQdTDZcXbX+nTOeVP3HbHXbzqawvo4c1e+GVFVCarv9eQqtAageZlDuGdIZEHnZd3P/vv4sFZIZejwjzJMAgr51FQqgd3J0sBPzTj7JLGwCDl+nmbboEDTBwQJeh5TNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269042; c=relaxed/simple;
	bh=0Ww8C3COR8mXc6LbRjUMV7UDl1BPgvTQLUN0CbiIUb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aEPSC9pvj9ZsYtuwhUAFSalOBByKQMHng+Y58kku6sRRePnO7zcMJrIHvuDVtBcZlK4Q86VkLcPsDNBKs9T292BtsiPzjeMWPb/PtZ/XjpR52cx+mpxLeupdIGWyrEOMfqb8ujaVG/coIx5yZyVXLo3NLKpKlSWtYav8tRUH8Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ozVOwboK; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ozVOwboK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPJ29mL9lXnIgI58OtDSg3T/MJn5uzigPuf2c3H74/nPsxewD7O+w2s7mUyM4rTIVF6b67c/unNN4hHfRNaThtWWNLEmKfFV++8nMrgn6bYGJ5t2wi6pJAd1VHTFLnUNSHenoqtLXtWa4V3/7nozECYpSm3zpP396y0NXxoYYAx7pQDosOiDHZ/dzl6wwk+I0k+epLSw17cJJb/S/wRi9RYuediJl3QoZQo9chLe7XZLzyJUJUFMarnrOJR/hGTenPL53F+vQEKvNtX9tSMrKIIBpuDwFqf7p/SFVPIyjkELZqG9KvDJItO3ifEPlTH+gjjGctbGnVVwenN1XjVzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFBXbAX1y92IAvNjMAdPo5OmTgSMm8oBAqdn/3EGIuw=;
 b=DueTFAK/kZr45HZSw38DtPSiVIlROb0go64ngRlLlkSIS7cXg8EpTCA8cjIHvPsPtXs3UCYfECny9ZLsetHyxawk7Mll1J2gJKxSLaOWlClH3N+aReg8hjTB0037WI6zfMh3O5jUWCK7gYtc0J+NA+utTV2wNmZmMgqExxGuS7S7X0JRp4SswfXiDczZPpmpmGCq96JzuR9U0yarCHUmVBibrZlsYxL+XfusAe9354UFGcP15MLEnJtYtaM0PN+DeQsDWF7VEa20CME9Fzwuc1ZUvQaELT4xFlwc8UD32Nv4TssvBvl4OnlT6WdXqtN6mS6Bczas80ZKjVlIpSmiAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFBXbAX1y92IAvNjMAdPo5OmTgSMm8oBAqdn/3EGIuw=;
 b=ozVOwboKF+PfQnscB6jXfUgHSAzHh8Sq3AwK9ic1bQNnVIK4l6vrZQwVO9CgcEq/ofdg2lGBaqnfKL+IOkfX9nQycMMivVC99LpCdBXnfqyx8d107REIESisxt/O1PSsFa2cLBAkVw+AtmPgyk5HQacAzjXgyWkC2N1/YZsPSAI+MuQjP6OZQW72j2hIDznqSbjjaokFqsqxkzlVHsm1Q4BVYvxH5RHqzCiNK9SqcD9OksCmgViUmiiuFHc4z6MtdFbHKz8xX1wVZBOgtAODeDmMdTzRpLR8tBIg2k75nTpOjmTHig//c+fc5XWtWeC2MksavD2cd5iJ1gezOFW60g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10673.eurprd04.prod.outlook.com (2603:10a6:102:480::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 20:03:57 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 20:03:57 +0000
Date: Tue, 28 Jul 2026 16:03:51 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, Frank.Li@nxp.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 4/8] i3c: master: Add helper to query bus wakeup
 requirements
Message-ID: <amkLJ_sbc8AoflzR@lizhi-Precision-Tower-5810>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-5-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728155308.142713-5-adrian.hunter@intel.com>
X-ClientProxiedBy: SA1PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10673:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d1ebce-d253-49a0-9737-08deece35bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|23010399003|376014|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3gMLBb1qIQPrXT58wu+eLqYlwB6GQXNODnOsEvFK1Ljb5vZT0dOAdoe6wAj4mbx2X1Hce2KYlSrt/TB2yjQmGxFE+FNZWbK5rq1xY4mgEKbHmTevVitx39LoG3FzWsPmgo2+UdVgEFiolrhcy5lSRnD509hCUPsghGfV24ABCWnkdaX8cHVUvfGkiNC6shtPkPALvSGSA9rRv496a0g7sTjak1O/cVotESymmrAIXpS0wJGnOOfPPdP70xWNJ6jensRJCYTmeo/xmX7XK7tjjpyEFCBTQ5tXAFNIENLepzUpPqAdP1jaOwQz3+zBeZ2x8aM84x6f5zHgFYDDtP4qslvU+YIkSMoTFcYxtBnHKvAdLH+y95RaBgcRJLESDO9lnPsmV0ZJHzU8Sbes9+IHb+pH0rZXYTmmMjjopes5NSo9X/TNP4zXKebEsM6aZIjkO870XiI81SYELGaLwH0wfhELsu9r43yI5wGAnryPBzS43TUibp1ofd9u12uhVLcjca2UbGUfGMsmGAYuh4ezPHc9a/L0++csOgLeh77owtO540NBRtHL6p9CDoM5BIsDV/Pebczp+SYSbhefNUK2TlCSnmNDSIIHcuhvdq70Esu4VjG1vL/P9VanhRN5IBe6OHtY20/rkZoJqMIwONnixGRTvFmEVuppZ/Wmsh3teoY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/MfcDmYNCCLSwababpKb9I/5MxVLawcWIpdPbjI2hMTLpZ/u9btQa3mv44jy?=
 =?us-ascii?Q?QTCtgwDuUJu8KfAK/hJbQpxNITXZ9xHNofjome0mAI+dAqQf4voGPpOBnlQT?=
 =?us-ascii?Q?iCzDjzV/feXR1KltiCehnGL+lJhyJcmFzQQkZJxKOZusgafsynTz3gbgz1qz?=
 =?us-ascii?Q?iaDQrGhHYOAWtvWCqNSsP8QjZTLXPV09Xt3WrSvgePe3XN7T8b9ARXp5dyjh?=
 =?us-ascii?Q?CAmUCBbU/4h9MSJGIUnxlX6IBIm7+pbDU1QnxTk3M05+uRXBzmkcnD1tXnRF?=
 =?us-ascii?Q?FAp1epWmfV+nsFLqGuFr67Gc3rS1228GE4foA7YTpFfCAfqVjpw9Q22x+Sqs?=
 =?us-ascii?Q?mnilIF3a5MrBpwbYQ4R4XMCf4BXRic7bDR18r0FzNLg6wks8qtqW0XowslFQ?=
 =?us-ascii?Q?t3NyeDs/2myqrqTI5A/Olbg8dwFsIWI/4kIQcwCmmkTP0bcNPw5VqRwjaE/f?=
 =?us-ascii?Q?JzmpBY+brMShJf+waJcFDOqq/Zbk7M20Wn0/7y9y5hgmV8ayk28abVvYJ5oZ?=
 =?us-ascii?Q?vO7pw7YwznGNoCMv7RE1DhU23Gupi46XdPHmyrxGwKTsNcsagT96+5Bb32Ck?=
 =?us-ascii?Q?K2Jb57MWMLnwk3xc7AB8FzP13XEFQkOWwZPsWrW72foSXVZwHOkbGeYwViwu?=
 =?us-ascii?Q?Gq3PraakRzv/SfAp6N5VxpqlcKzQDBJinfN/cOH2XRW+r4v1r01VI+f7/SKv?=
 =?us-ascii?Q?dS6VNOsd51dCMtBlIJ3A6wmWokz+CaPh73+eFzXwe3A39orgVO1No6idTGIy?=
 =?us-ascii?Q?CfzbE8I/tBtsiXkcaAsV4JqnjVayVw4d0p7qb4e5aS/LRjUP+9nF0M0Tpp99?=
 =?us-ascii?Q?MUqdCvZZaVn4fcHoAmFJUO/GIesnDvzXgKc5d+WOu4BiL26ayukZXo0cAIff?=
 =?us-ascii?Q?Sp0uFO0Atk3bEwhk6JBXrRRXPHoIKhI0iGmnBTz9oIKowgUU5E0dZx88PFXd?=
 =?us-ascii?Q?0BLE/QYocT/U+GHS4vC+56xhw80i9jZ7nKF8ZAGISiA/8Nw39mB4KWKElMOm?=
 =?us-ascii?Q?xfyYWHq7NmPK8l1qJe+CrL3XhbfeudXY1PgX9r06YT5ogo+pubGL4kgyWtXq?=
 =?us-ascii?Q?1b+RE7A230cguUtAFEVC9GlcPQMdBEOS3SqEhF+ORIgGFigSVlz1+xgsGV0z?=
 =?us-ascii?Q?KcbrWbX6YnB2GmouBuROd1aBV+Bx5pd3FeJUl09A8sUNpsMstBgQDrV/fLyL?=
 =?us-ascii?Q?7hpHB7HKhZy2o3B3zVzvQqSw9woapJshpcLzcPK3k4vxdq4mMNZbj58GGd2r?=
 =?us-ascii?Q?9GUItJYVnta368mX4LqdQhQDVzxPZVdFu7GV3qGRSt5mRUWIDZ0+VSG2KmUB?=
 =?us-ascii?Q?kTANyYwENAY3MinpPfe7VKCN77v2q9F02weOxgq1LGGJhhqADX6q9AJW6id8?=
 =?us-ascii?Q?ukrtZFloybz/nogIiYQ5LB0iIMAKScIHJPCRKr2mTo6GBGjBPtRjMr3Gg42z?=
 =?us-ascii?Q?978tRnTMlPLBPa9dbHYXamsMXk23pDrWIcTvAVjAbwAqtWokkjOr1m00EnnM?=
 =?us-ascii?Q?F4AGcMbgTvkZnuirkKRG4rK5NCq5tpbTkbjDkCS6CgErYVj/OG3za9ecZvdJ?=
 =?us-ascii?Q?jI/h53ZO6FeJzh0ix2HQ7cCXWVCVQ0oSbAkGAUDmY+GyO+dh+z888LZahX2N?=
 =?us-ascii?Q?c+dnfloxRMd0MjnGeP4f4pSPLXW3n9MpJdzLzcLFAe7G4I8zsvluCUlDLPW0?=
 =?us-ascii?Q?bQhcIma6KcVf77WESsuSoGb8PsapjaeJdls3X6X2y6Ppm4Lry4yVO8lyfJNy?=
 =?us-ascii?Q?u1POFQTsXYkCm97srqqv1AU1+xSDgJTxeGbmVKjUl7ZYNUauzG2q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d1ebce-d253-49a0-9737-08deece35bc8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 20:03:57.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fm4xegOLCWMgEf7KkIVamQkXrLsXVo15oS+TdxGbyBpqXV4009AFJ/KaYyGq653ziCWcGMjWXAaHY0ZjjH8YVkYGCLtMWg6JJTulWdzd15LIFa/tCZQ9TlQ3bLCNoPz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10673

On Tue, Jul 28, 2026 at 06:53:04PM +0300, Adrian Hunter wrote:
> Add i3c_master_any_wakeup_enabled(), which iterates over the devices on
> an I3C bus and reports whether any of them are enabled for system
> wakeup and have IBI enabled.
>
> Controller drivers can use this helper to determine whether wakeup
> support must remain available while the system is suspended.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
>
> Changes in V2:
>
> 	i3c_master_any_wakeup_enabled() now also requires the device to
> 	have IBI enabled, not just system wakeup enabled, so that a
> 	device with no active IBI request does not keep PCI PME enabled.
> 	desc->ibi_lock is taken while checking.  The commit message and
> 	kernel-doc are updated to match.
>
>
>  drivers/i3c/master.c       | 30 ++++++++++++++++++++++++++++++
>  include/linux/i3c/master.h |  1 +
>  2 files changed, 31 insertions(+)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 9d56ca08569a..dd49652425b4 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2048,6 +2048,36 @@ static void i3c_master_reg_work_fn(struct work_struct *work)
>  	i3c_master_register_new_i3c_devs(master);
>  }
>
> +/**
> + * i3c_master_any_wakeup_enabled() - check if any device can wake the system
> + * @master: I3C master controller
> + *
> + * Iterate over devices on the bus and return true if any device has
> + * system wakeup enabled and IBI enabled.
> + *
> + * Return: true if any device may wake the system via IBI, false otherwise.
> + */
> +bool i3c_master_any_wakeup_enabled(struct i3c_master_controller *master)
> +{

This check most like introdouce rise condition.

if (i3c_master_any_wakeup_enabled())
	do_some_thing()

no lock protection, so between check i3c_master_any_wakeup_enabled() and
do_some_thing(), condtion may be changed.

Frank

> +	struct i3c_dev_desc *desc;
> +	bool wakeup = false;
> +
> +	i3c_bus_normaluse_lock(&master->bus);
> +	i3c_bus_for_each_i3cdev(&master->bus, desc) {
> +		if (!desc->dev || !device_may_wakeup(&desc->dev->dev))
> +			continue;
> +		guard(mutex)(&desc->ibi_lock);
> +		if (desc->ibi && desc->ibi->enabled) {
> +			wakeup = true;
> +			break;
> +		}
> +	}
> +	i3c_bus_normaluse_unlock(&master->bus);
> +
> +	return wakeup;
> +}
> +EXPORT_SYMBOL_GPL(i3c_master_any_wakeup_enabled);
> +
>  /**
>   * i3c_master_dma_map_single() - Map buffer for single DMA transfer
>   * @dev: device object of a device doing DMA
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index 99f89fef7653..d8cdc7ff2459 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -748,6 +748,7 @@ void i3c_generic_ibi_recycle_slot(struct i3c_generic_ibi_pool *pool,
>  				  struct i3c_ibi_slot *slot);
>
>  void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot);
> +bool i3c_master_any_wakeup_enabled(struct i3c_master_controller *master);
>
>  struct i3c_ibi_slot *i3c_master_get_free_ibi_slot(struct i3c_dev_desc *dev);
>
> --
> 2.53.0
>
