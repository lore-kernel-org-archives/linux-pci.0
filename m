Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779784C6F14;
	Thu,  2 Jul 2026 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001465; cv=fail; b=Svih6fihvxHWqvCGTD4+8tnLSXHaDv82pwy0TfV154RYrc9lJaNmB520tcIeHiFVxRG2eTQt6+42YBwb6sqlgMbjrsDccK5Qa1ungkQK7bmp490btuFcOtPZcGHz4J/EPwStM2UPuhgwvQUU7F05N0DPDN3vn8m0/OjO7XcqRzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001465; c=relaxed/simple;
	bh=YrkXb2PhIO7gNLgUXWsJi9L069CdOczl0rCEOw+KFf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DnSubw3tzkedKo6TEzNr9VACC/UogHxqu1tlw3P0Zvz1oCF0H4zHRnSzFT/c0VDe/uzjA+hYaM7ALKN/gBJtDwB7dk9a7dL1r4gUy0m/fVYgz28/50/Mp/pKFEIk55ngp4aQVDaV9Y6rcsWryjBRXYysV9b0nkBKbvT1Dg2kwuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BR2IE0C0; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BR2IE0C0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdE3G+l0C/vgIePPYA5RCHhxbxq1QkjyuEEM3bh8XOuSK0TNJS297Z1ZJ4GGcdg/4R1e3Tuv4Wyz6NF8cdu/koQm4wtakFwX3B+jL/PbpNM79OeMJscdaHupVuMpda1gGqI5Ir5is1QWdiLaYMX/0MrmQdBTy+EaRF+/+Ubx5IjzHWiN4f2Nq1fzTbwvzgoZ2PpjGR+tyx3UwsA3sORHxesz4z+qlE14QCV01EetChkKq2XAt9c3JY5LE2YSrZstRKB4HRDbrfaMbAvpS7e0iVzRUItcnblzDhdnfMuasVidYyZqNAwgeks4u8ZU3ubpxh7OwmHLN9JBRByiCchCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hC+/iJTNvC/QU9ZPI5g5br1RnDzK5PEdAaEvRQBwEn0=;
 b=ZEx5wBYfOo1WNx8oqR6HWoRrIKmu9kW5kbrMkHPCr7Ub0TDtut3nm4/rb6qs4BbVoma1D4+EgozJhDx2MczTPu8WWw3szP+nKOzlytpv99HOHfb6+7m/xxHCTyGZTsG9WjoNgU+IVgCENmxjg4ocnahrf1IaJhGXz7VDTJOsU16Q4fS3XYPuc2f2TMNFO1brxW6SyIdV2TQqUVTF4BVCYJrYQSca8HpcVRV4VreAEG7l3FUlXdcZh5/d4k0mqiSoXv+vT7vR3FO0yLoWf94POmNDDzEH1gF3OaZKuzQCPjvvij/8eCLrOsWL7YFPKn7A7J5sJfuokIyPTCyr7X1o0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hC+/iJTNvC/QU9ZPI5g5br1RnDzK5PEdAaEvRQBwEn0=;
 b=BR2IE0C0i5jzOL7lI3dDYUCkD70QygbztuMVMPUDYmhGHYyR6Lt60MsRbSed6CDYgV6ljQW23spnVHz+xWSu3gAiY8xee9HD3hP13V3Jt7NTj8oYwQSzvvQt1fFv5uB8enE9/gwxGULHVJk44NH9t03yPb7yZNH07HnA/A5FnhJGdPfjgTX4YM5OXfP5nzTrQSrtuhWlRXMGQHr1AMTwML3ObQvgsAEthosPnmnCXslBQcO2k6jsSS6eZBVRRIY6ndkNCF4sd/3jUi6erydSJcwxRMuApPer+1L1ksaYcStGCvuTO7r40KbfwkP+8pUjecmlcVbxBnbeln2CRE3rsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10797.eurprd04.prod.outlook.com (2603:10a6:150:20d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 2 Jul
 2026 14:10:59 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 2 Jul 2026
 14:10:59 +0000
Date: Thu, 2 Jul 2026 10:10:52 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, Frank.Li@nxp.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC RESEND 1/7] i3c: master: Support IBI-based wakeup
 capability
Message-ID: <akZxbOvAwyVwUPgl@lizhi-Precision-Tower-5810>
References: <20260701201533.220818-1-adrian.hunter@intel.com>
 <20260701201533.220818-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701201533.220818-2-adrian.hunter@intel.com>
X-ClientProxiedBy: SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10797:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d479496-091b-4337-fe9a-08ded843bdb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|1800799024|366016|56012099006|22082099003|18002099003|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	qlkScWh/YbZxHAibBJivfACXi5K+iV0bbsTRZB9A2Jp/tKIT1kz5mjWTzh5Lwn0LOwmznZaq1TaROq56abxHReEfLss1R16gghCViQwmt+Z9my+lCYDRwD+Mi42uE2dKZF1PGFqn6qm8LarpC0XAyf6FBYTdYBqxYc2bbTXrUdy9jaO0Rn0rSmWCr7dTAQ6Ivx3LPw6f6+SeyeVa4839DXWPVDuY9ZeKbbdgMmX5Vio8ChoTw/OSnlr0PrVMmHsM8vymrkNOvzN6+dbcwbv+ZUUMlnIQ7TaIsamFBA5v75vIpNYHWQh4m/vNUuzO2pp53CUzm7XWSC56P09rWz4HuMvUTyei6aTiLD9me+XgEv22WJD9WdmYCviRjKB67ePS4VFdCukVMS5tjkb4NTnutfyeJBd9sVR2HT0jbxgcTXkW7evFkzjrfmp6nBV0QzKzYQALmhYqPB6NSuRLk28x8Q7mFVnucWldp8pgkrrHNOT9D161D1DlFHlM72U99QLOLxJPPd/F+SkopDTFrrft9+VQaiIuI9yIXzLcspBwaNxJM3qiNbzifXvxgbC914SNMg4b6/srapM/SppRQuRRPZC7JqvosGrMmLlh1M5rJmrs6QIbeWDVQWU3UENLUPPE72XuEeCi/AQiMRuwX6UIPUTZ5ooMthVeMjz6Q6jlyFE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(1800799024)(366016)(56012099006)(22082099003)(18002099003)(5023799004)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B3e4Gw4uoIMv3BoLO+krcP5yfhgSs1iB9DMc9hWv3N2rJRTZF9/KaVqgVxIJ?=
 =?us-ascii?Q?TL9qt+rWIcxw0rMMupHF+WUTPq2uRr8R/JWSOgVpH0ZDPGzGqLEl9w7bG+62?=
 =?us-ascii?Q?niSpIb0yJYsOrFf18xNbeCpKEzSBHa73dvSROyRYib151Zs20mV1W+YT4TfX?=
 =?us-ascii?Q?ATbeKJkw7qclnrvjWqJGyJkEU+DB2lq3IHO9kFzHklS1OID8SbSZCclL13Bq?=
 =?us-ascii?Q?S3qEMa6MBL/iOSdmiFOOSSY0clT0lnqd7EsFWQ6yjcALYJ+vLbB5SmtI8R52?=
 =?us-ascii?Q?ZJhXppbU3+/1Smo089L3dg7ZahxTDEmmpMcW4t2U+LReHOh4j/m6W6R+ob6Q?=
 =?us-ascii?Q?9b/eXLDAOoM+gj3plqiBZuP/UvPMo0IgYphbgjSp15sd/+kxzHG/Vn0WxP01?=
 =?us-ascii?Q?vF0xep2McVTeLnyw8qSaAW4oD9pijwzHbQbPqDPMspqUGXqocZh/DnrKY+0x?=
 =?us-ascii?Q?64vRFryj2mKH07/PhalMZe+/PjLqYZi5RaAdABY8M8QGqIaJlgzBDY1dK+uc?=
 =?us-ascii?Q?NtIUgibHs/AR+63kzNl4/B/56UwmOcyp7Az5u3ZYbZNS8gVchM/kkITYSKsT?=
 =?us-ascii?Q?rZ+OQXIQxb/Nij5dI54/ThWCCUwETf3vsQrDB2iU6PRsCsLv9RJPB2VWf4/r?=
 =?us-ascii?Q?vLZDJ+O1AovfBeslnbp2JHuIPmwo3cb5CMGL2mXV6r5k3jBHkOzfkYrW0Q3N?=
 =?us-ascii?Q?xc5cTsukqy3D5jYO2P+BSVM8IEGYPtTmNZsa9ivu8A4uCkOs5gDNyPYYHRzl?=
 =?us-ascii?Q?/kJbvq8nBx2OXm0GavVS3mopY7/KOTa/kwQGFH5GVz2PeBg6A8OfD6HTpQZt?=
 =?us-ascii?Q?K41hbJTmhLi1eOzWW6IQR9cMpcVBobhEHCnD8Pf+a8tXuEiE3pTwzKz9rkXi?=
 =?us-ascii?Q?UEeVWVgyI6U2JE5+QXnQkaUp6x44DwFR2aNpgcRUsW0uxYeGqwJEW97fYa4T?=
 =?us-ascii?Q?krzH0YW56cc0b4/z+kFsWKzXs+2KvhpHhKUY4X6C2JAc2leZQiO7FA0BTGNt?=
 =?us-ascii?Q?QGQCISpjFQcTnCEnZfIHhhyu6n58Kl4ukw7Tfrtt/9V3JV0HdnHfz/AIDMez?=
 =?us-ascii?Q?va+EBphaZYPYgzWQtnNsqdbroPtBfxsaVbE1G1ZgGCFJCyvm/WT8TWYt8+Bw?=
 =?us-ascii?Q?Ev9etePwxrbG7egRJhizOr1ePyW6m4qg57fjISavrDQvAbDy+lLiIIGQuJt3?=
 =?us-ascii?Q?70JDHruRvivTB4UoQeN/ChxlyEx1tyYCl7HrC+6g63PRW5omZkwr+ITgB6gn?=
 =?us-ascii?Q?Vq2s2z0dqzGgLfq/tEV8D65Xa3wySEKLdgmmzujz86TzoTD0Vyjnu/r5/B57?=
 =?us-ascii?Q?XJAVeLtR1YIQRol/U5chXEyFrsEOKLxpnxah9uS0yfXs8shu4A4tmtFE+BDL?=
 =?us-ascii?Q?nN8Qih+XzDUlFeqqs9UvpsrrUnP1ZutYFDLum7ef8oIckTX5jnsT0ip0ktSy?=
 =?us-ascii?Q?C4gOsUSJB5L8xCuLU5SAnxkvU7f3OTza/sL3+f5W77geewWBws2ecAueDsRA?=
 =?us-ascii?Q?YRTK1l9h04evwdTPNM5JykmHFYVAyEXw4VtxiahGMRBubzni+tuEtOBfwtbh?=
 =?us-ascii?Q?DixF5/MzBCE8CQES6aAimTneVk/rJbgmOa793bPSzqp4fNfU8rOMV1NJO+N5?=
 =?us-ascii?Q?Vp8dbKHe6E8rt8FHJfe0GsSZewf58uTf9pN1EdoS9W1S5L1I8jVOgAEaX1cB?=
 =?us-ascii?Q?iK2ObHnyvWvjXUZCJl7W+1WrHfwJn4XmxkHC97E0/QUi53lMBo1GBx+IkQSC?=
 =?us-ascii?Q?59inhUjza04t9Sl83HNrbJVwR6tzs6xaG7H8U7sdIBHbXMH6st7P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d479496-091b-4337-fe9a-08ded843bdb2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:10:59.4258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFecfVmeBtCVNnVO7FeOyiYF7WWvfBZ8sKcmt/2XrvhTon1AUlNIzLyk3E3EAp4HSMknqHBNdUcZeFg+7zyrx6TD1w8ZALyfp3JLVizH+AT2SSw0zL9y5hiLCX1V2cTX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10797

On Wed, Jul 01, 2026 at 11:15:27PM +0300, Adrian Hunter wrote:
> An I3C controller acts as a bus controller for one or more I3C devices.
> If the controller can wake the system in response to an In-Band
> Interrupt (IBI), then any device on that bus that is capable of
> generating IBIs can potentially be used as a wakeup source.
>
> Add an ibi_wakeup flag to struct i3c_master_controller so controller
> drivers can advertise support for IBI-based wakeup.
>
> If set, mark IBI-capable I3C devices as wakeup capable when they are
> registered, allowing wakeup management through the standard device
> wakeup framework.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/i3c/master.c       | 8 ++++++++
>  include/linux/i3c/master.h | 2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index f1be38a640ca..a47e2924bb70 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -17,6 +17,7 @@
>  #include <linux/list.h>
>  #include <linux/of.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_wakeup.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/workqueue.h>
> @@ -1930,6 +1931,13 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
>  		if (desc->boardinfo)
>  			desc->dev->dev.of_node = desc->boardinfo->of_node;
>
> +		/*
> +		 * In the case of IBI wakeup, any IBI-capable device can
> +		 * wakeup.
> +		 */
> +		if (master->ibi_wakeup && (desc->info.bcr & I3C_BCR_IBI_REQ_CAP))
> +			device_set_wakeup_capable(&desc->dev->dev, true);
> +
>  		ret = device_register(&desc->dev->dev);
>  		if (ret) {
>  			dev_err(&master->dev,
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index 4d2a68793324..af3c35a8e7b6 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -511,6 +511,7 @@ struct i3c_master_controller_ops {
>   * @hotjoin: true if the master support hotjoin
>   * @rpm_allowed: true if Runtime PM allowed
>   * @rpm_ibi_allowed: true if IBI and Hot-Join allowed while runtime suspended
> + * @ibi_wakeup: IBI can wakeup the system
>   * @shutting_down: set to true when master begins shutdown or unregister
>   * @boardinfo.i3c: list of I3C  boardinfo objects
>   * @boardinfo.i2c: list of I2C boardinfo objects
> @@ -545,6 +546,7 @@ struct i3c_master_controller {
>  	unsigned int hotjoin: 1;
>  	unsigned int rpm_allowed: 1;
>  	unsigned int rpm_ibi_allowed: 1;
> +	unsigned int ibi_wakeup: 1;
>  	bool shutting_down;
>  	struct {
>  		struct list_head i3c;
> --
> 2.53.0
>
