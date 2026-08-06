Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BE51ADC83;
	Thu,  6 Aug 2026 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041105; cv=fail; b=SrA0pMN2w/clB4ht61BsNLFEpH4pu9q+1m4PGX8GW3UuWE4mnCU85kSm3A4apNIpoc4fyeel4iNuBiMOgCkBI464YFaM9WpfQzwvXx+b86J3PoQfEkdiw3hGoBgwXh+Cx3Cq3FF1o4YHi+y8X6DyGM/U62qTzTyphH3Hbnb5Xvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041105; c=relaxed/simple;
	bh=rxDnxwimfRQJEeh0JD1c74L0VtNDyLOFlx+NxVlC2AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a+kzsKgZFnJzNMkXC5BqJEfhgDnXkVnUic3CKm7DSFksTnVM1L5FnJjRV26PYT/s2zOuraZkqpwBOmt6PlhNWht3GWGRDkhgYvozwOWm2EhT1CSTEKaqaJqjUkm9wjwfJ9SiBoNCD9zMjLGthP+tncXYUpFOXmNbOeOWwhAZbgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TmxjRCow; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TmxjRCow"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdB0AWLGEGWxBRLhdOwNlf4lFT5F3KkTFvzKW5Qf8lqidFVUEsFocF/sZJbXbo3FY1FtwoRh60Dmffi5U/rhe/VqIHLD/j0SoIgerwSuWmXl4hh5rIsGXtF3fsO1y73N3LPfsoYY35FTFpc8RrjDrGU5KW9RDRTkoIaMMuQgrXogJxeN2gppI+KelxApeJEyxh3ew1oIsdvc25tRa6PxMSmTd13/nqzUj5LSMdUrKsrXtRRuHEE/yYE6eH+10FvjY3V3T1sGHzdUSGwpqRL6DZ93mlio7bZQQQSjXx4mqX7cfH3hxtV5EsCsj2KUdqb4RYv8SLBQx2+bO7YXL7Dcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tndxCp7YIQHfHOXDhALNgYuhpQ+OvN7hckUWQTXpH9w=;
 b=ljQozuQDKNEiiWsGvSQIpt0hfRaVRqF9nl9KF6j37XCTxoRyLkMms3YeM88Ag/Zn8dxgdj8ii/wEaAoEIOGymK9BQCV8oVfaFZZeI7JKlhFgUZXg7SDWe6kFGoL64HhH6bYCR1ma2hmD4MPkz4wOK/v7ffMzlhlAckjWTCAf5KLr8VBUm/6npGZ6jqZkGT+xJhIT1W0vFLGbMXWtvCiVSFBBJDApJuuGKl9rFi0jeykTO/4a8W18ozTW+FkvpMD7YtsA+E2euYalzE3ixW2vSDTKwOTQFkPNGBLIUmY15SbSI0QrEaaP7/XiQvLhuV9yj2AdfX8ILyJP/JhlafMZRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tndxCp7YIQHfHOXDhALNgYuhpQ+OvN7hckUWQTXpH9w=;
 b=TmxjRCowo12olo4EJ4DOdDVUq+Nym51YooOkMT8y0R8aT4dtxAlLLvj/f0/WVoy0tjzFp2hJ8K5CyS7D4ge/VFXSfEMi1uPYFm46sltj93DansrRxAjsheS9sZo6Bt9XphvCwPQSRwOhcHbP80uS1lFwrL23TG0oA4zYi0WxP7552rRwWcp4OOtTNuoFNibNMg7dHJU0f+g/jCQNi+XCQ57frFrvOM7X7MCNnDopojBoh9JL8BwoptuoURnAXKxYpGC+o7Arf/a7MgNezaYKiuKey4fEm9M7kpdmUrTcp9cwNJjud802NzYggmdjGuJGPFb5jUwL1GyfAxX7txg+AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11722.eurprd04.prod.outlook.com (2603:10a6:800:2ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 18:31:41 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 18:31:41 +0000
Date: Thu, 6 Aug 2026 14:31:33 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, Frank.Li@nxp.com, akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V4 05/14] i3c: Make dev->desc locking assumptions explicit
Message-ID: <anTTBUOuS27V0z3e@lizhi-Precision-Tower-5810>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-6-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806131857.119830-6-adrian.hunter@intel.com>
X-ClientProxiedBy: PH7P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::30) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11722:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f831c65-c79a-4a28-f358-08def3e8f57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|19092799006|366016|1800799024|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vjHf70M6ZZ+yDiyIgkUX28Ry1thVXszV5tfk5L9a2h2O5+Op2d7FDA/+2Cbjrpi7pXydW3gfWFFCY1MYh7X/FXAiJ5GHsdR/i2piZE5gP+e99wKeyYmnBZXUBwxv5YdqyEnZ57bg+WYHy9L7MiMgqkWl7eUbLva4d07FsgeA2jywH5QRWCZjbnrtsBVU1rROeSSePW7WxzFyY9OeMVS1TgHhXpdoQPI5IWA1HMgmnRrgFAb3XFi0eSNdwb9TerxrhOYUZ/yWJfaosNEu8eBD+fawOhfE6oyvHaOIg2nQdqGeMHElvQu7maPeriH8hzFE2rMKjn1M1q3Nu2GSZs7bH8+fZqg01Emuei9HiNogHKKD6pCkcvQfsWNVMSAYMrAskuYzVByA0it6Rbhzi/ayfVBAt+dMRPu5sWFHS5giYcBQoaKJYW4j040XhuItZHfW4ELqFyiaphtMGrSQR2B0SZwaqN8KWyNSdo2clN9mhQ0puf7F89lcO/BGsFDzm2L8qLCKa48kd/w618UvEvfWCXkizANut4wPwtlNtAZ/x359ACUlYoFZAiQS9XpouYS0Oza/AV4FaZmHewgEWUEsmZH6v9cP5R2KoxOj+6pecqmsmNc2EfyD6BWYfUE/zxcJYL2nnCwCMuAE+MQOnjI5OljISsultv3scxnYi920cPQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xe5WqN9BcyQjfGTJowG6PYyCHn3Xy2y0V1sMEmpoeOjTjwBG8BbC25Mw9L6y?=
 =?us-ascii?Q?1N8usB2Yi/xwKGpJW9Loo+2CahgNK+xUrKVbv8wTtt8KKZakAYzWeEiAnlli?=
 =?us-ascii?Q?sAht/tJCYRBQMNUAVvwBa1vvo7Y09eOYpEPfUIE/Wawo1TK8aAvU46QqPLjC?=
 =?us-ascii?Q?CJsIlKHped0XzlU4lyWO2ccWzu3KvkIVqY2QvDJ+DE7jAPR6n/2iJY761nuj?=
 =?us-ascii?Q?Y80ReKXkYQyhwAkdzdsZMGuJLqmzv1GOB91tXb3CjPl4Uz5DVqTW1RLDgKai?=
 =?us-ascii?Q?D+sRXdf/qI2N78+qhQX6wd0FZAuZnz00wKF6akp5AFaIbK3ufcPt7xaGBwNy?=
 =?us-ascii?Q?2y2vcPhgXyjno8boMLTba5swBOLjLtb4B97cloQa7+sbOV9ytbuYwfalT4v4?=
 =?us-ascii?Q?qcxGjCSLkynIGgPGuHULeho8K+UzODvTXvd7F95ZArM2Ga/xiKrh2vUkiG77?=
 =?us-ascii?Q?BtkJZ6sXfIUaoCGdVmgAukn0o/alf85RULaBAl5O+GaJaYZtaxMmsPrvP2N9?=
 =?us-ascii?Q?zEqF6owcr4JToweuf725wTnyh9ME7h5o1w4VXK2U4ZW0WgL1RQLLGwenBLj4?=
 =?us-ascii?Q?2rDxMJ/b8ulR0qt4OD2mSrK5GaPIlsTWORVJVNM/P6tcYKlG3LkxLSPc8MlX?=
 =?us-ascii?Q?OYADwGysZtEG+Iwv402eoJyc4ht0AWP5rg7ssM7CFUem0iy0Q8h7/Yrc9sD+?=
 =?us-ascii?Q?2Lg1W0W3/3gM1QmCW/pMR0SjSa2RVeb5EKQgNZ1UHvR8NjWQWdu7jOyemHXa?=
 =?us-ascii?Q?Mzj+fHjKHTkCx+7ogMQpp/NNTfruzuF/5xFv4Vd+ua15z3bgMQF6j+n1nHMG?=
 =?us-ascii?Q?MNe4uIo1ldrV6ScHNj7KW0xnb3wUCKc9HKjDVyWf/F/UQnoLmP+H0eAmUd2b?=
 =?us-ascii?Q?2foJwL3mMCnnxqeaZVBlqh+Qy+7HCz4J6dUoB7PM7vZQN95871RZr5/Cji7d?=
 =?us-ascii?Q?fZ7EIC7PTHSGbx7Vbqvcm7B34GjENtJVyeSzDQEvqhmvSgYp+U0De8/zE5+A?=
 =?us-ascii?Q?Tq8SQ8l6h9E6ITT8trI7GRybDLIWzvesyGQn2GtIg6cgqbyYBSY0AYogX6zx?=
 =?us-ascii?Q?V1UgiierVaQruh87Tpj+9CU9iP0vI4KApJEeST5gQWzvLIsYcH3tQ6i+KmKU?=
 =?us-ascii?Q?PU0W7LtnkC/GBsZhR4vRydMBfdWSW1lI530FAWmVeJ3LcrF+zeuQonkX3BMl?=
 =?us-ascii?Q?lvgU10r6mDQ8NPCXByiZOcHeGrV+CbUUZRFee/5QWKAVcaiKRzC9zRCU+63O?=
 =?us-ascii?Q?ZNUv2ubr+d8Wx6KOTJIV/RqcMDnHcDJ3FcBUdSGsAca0o6QwL9zY89PcGVfO?=
 =?us-ascii?Q?MbhzrrhpzOQ/ZX08netW4sL3cPdfiS7KacIHHuswCqJiOFAGlB11ENxiKIoc?=
 =?us-ascii?Q?YE5O+qrmbjKOpkZrrGM0TsjlLdaXwIo0stCd5wf+9eKVw6f8Zc4waxeC53b8?=
 =?us-ascii?Q?slVuMu1uHAuEWuaXoj686EnocCU47h1eoz9ynjK3DDIVxB+m08ctsYAThh9C?=
 =?us-ascii?Q?XoBDkowdOe59osJFAN3+45J3v3PL6Wzm4UXiUpyS+r2/P/fdQIztWS7A96Ir?=
 =?us-ascii?Q?H+1iM6h+Qa5HXHknaMFv8Nht/MDSsGwya1QmKg2kaOk6ImwEz8l0FPczklvR?=
 =?us-ascii?Q?5soQmJYPs2HEQlwugZrhFLal6MMju9lsdKERQ7Ou7HKGeJ7hYJUYgPCi3R91?=
 =?us-ascii?Q?guZb8ZVktgyCsagUDPVzbz385Oe6Kp5grtRWc/Sg5RKlviN06Yljtn2JbK4M?=
 =?us-ascii?Q?tBI/8QvOUCcNjoApiFQGgL42LB2i/T00sp20jNSL3DPXfpQSxo5z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f831c65-c79a-4a28-f358-08def3e8f57e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:31:41.1153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbORBP8/UFQRqtCiHjm33QmR6ZkP/jw3evrVLdynCYUPFrAmOP2rneqlD8OOLBXMN1J4Pwaai/XfA3wJak/S32ZQwlHZuHlgm8Wp9Ai0IehOeC6L8ZwXxw/zStcc2hu+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11722

On Thu, Aug 06, 2026 at 04:18:48PM +0300, Adrian Hunter wrote:
> i3c_device_get_info() takes the bus normal-use lock before accessing
> dev->desc. Under that lock, the descriptor pointer is guaranteed to be
> valid for the duration of the access.
>
> Remove the unnecessary NULL check on dev->desc so the code more clearly
> reflects the locking rules and expected descriptor lifetime.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
>
> Changes in V4:
>
> 	Added Mukesh's Acked-by tag
>
> Changes in V3:
>
> 	New patch
>
>
>  drivers/i3c/device.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index a3778282e84c..5e6df6de0283 100644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
> @@ -101,8 +101,7 @@ void i3c_device_get_info(const struct i3c_device *dev,
>  		return;
>
>  	i3c_bus_normaluse_lock(dev->bus);
> -	if (dev->desc)
> -		*info = dev->desc->info;
> +	*info = dev->desc->info;
>  	i3c_bus_normaluse_unlock(dev->bus);
>  }
>  EXPORT_SYMBOL_GPL(i3c_device_get_info);
> --
> 2.53.0
>
