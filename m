Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560C2E7631;
	Thu,  6 Aug 2026 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041033; cv=fail; b=u4oBig0x0DPstZtIkAHWmi4u0C1cx1VjN2uRy9yp4h8QoSk7RptIkzSHAblouAvQ7CG+yfTqItnTFZAShnT5i6Tupjo+InK5B7x3S3FzDzIkIvN5j3D/0oB92XMW6d2xgLKKOaQLa2CGBbLfwF10UALp+Uv7Qp09ofi9CHLYkho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041033; c=relaxed/simple;
	bh=ixuGpQkpgYbACKOwVnZCwsg9wNROEAS+trz/yDl5Bv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d5BeRuy1dA4EJoTgrPhIDObDJY2PKPZvUgaJ0wirxnvp2JIriyJWqzNS/CB/lupdYt/yNbE0VL84bt1Emi4L0R8mdfMyHgmuymz5j+nPpVADKryHmLMPvaBdONCpnhHNObymm/+F6cu9F0veF+kzDfuiOhV6e0OkpOCRdJKKDbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R1RWkAYJ; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R1RWkAYJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBhRQSj7Nxfd7V81X+Bq9Kgw7+li1FSTra8jDY6kY36BRAOn9PeNhKvsu8HDqGozMmoA6VqoUjXAOAP2IvtmArRHECQdOnv1Za9RWs2p3niV8/ewXLe9nVranIEqHXXGgZDa1bj5s3BtOeBOjqh9hKTJ1+pyPQahsrAmJ0Nfdvev7H2gixa1Bu78CYykAPjDoE+7Rxau8nFPp8YLX9mbOkqyXh8lCgf3R/LeiT4QS0oi250+0+CmriFUrQeQXnP2aO4HQOKkH8VKD4boH04doqd97D3nlUYMfXUEEUxBtbV9NxpUvwGzaabb8nRYVB6HYOIA7wU24grA138tv/CypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av9a0w/iHlAltUEnD3FGc0JpAfNAIPQ0PpoG3A7Jfd4=;
 b=uuLzgbu9dzELr71Tz5dDvn+ReQ+PMylNPGW/rmU8fHZ5BBMOIqXT01HllyIsBLPUfHa5Fyd77PoWIuqAFtd574rayIPFx/3eUt4ehyJPKZdYGwT+uCAo59OdHZ74HocbXpFU2lHurR/G6riBHVP7QZvYcQwIkvTvFBOdEdDn8Lbn+eQa6d79D108kPPfzEqDcEdQ17H6S6iU4BEqOm4Hi+Mxil5P4YETO6cNaIurJtjFrWIrvPsDhZNou84pnJHS9Aw+mD95WXjtvJ2j44dZ+IIouwG2tpsP/2LEf9GQQOqYzqmvKRazCn1WqMFd7CFCsb8kSdGePSgbT4lBPuaVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av9a0w/iHlAltUEnD3FGc0JpAfNAIPQ0PpoG3A7Jfd4=;
 b=R1RWkAYJb+3pcotLhj5GTT20iWEkmTsWXKZEsc/SzBQqpFW3BjmKdx8PP4lajuZ35O3pvWoUIr/qzm0dIeENIEHvE6ERklAKvl2R9oBD3yk23VE+o52BJz2WPhJJbkLCJlHujbWPYCV/sm1qeUSK3ytWsIybEw7ZDJvmPa4B+1T8kC02cXHRtI3ZdhczSAMdPCi3urKvaaFLeVXbErSmxGkB4EGkaLXHmFyRI6j25+nKuekaOsNXA/SOMuuanLPvA93c2rc0k/zsd2Jdvojxz3yMDJxiNy//7NXaQNWnWHGknvg/Z4Nd2s3xu/6mg7NvoPkXD6v5DxSpjX7FqRxtIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11722.eurprd04.prod.outlook.com (2603:10a6:800:2ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 18:30:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 18:30:24 +0000
Date: Thu, 6 Aug 2026 14:30:17 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, Frank.Li@nxp.com, akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V4 04/14] i3c: master: Fix use-after-free of master->this
Message-ID: <anTSuRrEqpm6pAQC@lizhi-Precision-Tower-5810>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-5-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806131857.119830-5-adrian.hunter@intel.com>
X-ClientProxiedBy: SA1P222CA0133.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11722:EE_
X-MS-Office365-Filtering-Correlation-Id: 6acab4bb-e3c1-41c7-f59e-08def3e8c77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|19092799006|366016|1800799024|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bo88XS7lxMf8LTS5hPhsskSgYz/95o+MLQD2kL+neGh4/dtgHLNxSkOVm+DCydTug7O5x+0bIRbLyr/9ohGt2NGfGP/3OouCc3WBvTkMWT3Y3K/QMtpQD4Dlo2C44xOslA4ifhDfPmLrpvgvbvFGP0B6/rOw+TgBHVfd/Ld/hwfEXgEdG6GfyD4S/BZdHZV2W1DEqoKOTzLHs3SikU9B7UTqSjHUZeq/o80ZkPuWwldbpO4Qlix9Fvmd9YLqmTDug82aBKvN8M9i5phLYSDOiGyzD47NX85i6j71iG+WWZAD/KHBHdxjF987OLlpZatgo3lo/tzmN/ZLVS03CeuSqNFOYENIeHJpxzK06/hE0CBHgSrpyq5mTzVVz68I7rms0UQSDwxgNSvYoI62CioMZThYEqUW+PAQn41FK3eUdiwbZ5nr6Tgfq+LCc3OgDFknvNt8n7aq2flxowuz5gaBMkHUQCU08uOrOteFYSziMwZpK6xJ6uzwr46zlRWlL/r25WzPD18TeMpkYRTXcc0jH5Pk8h16bbHD2/5jkTWpSp6M3RjboDKr8SP7saJawODlNrPXcEoEurRhs+y9t70pWl+br84URNQ5CAvCNH3SEUy6c7XqwRywlotpDAXthlLLoJHKl9T73WwJI0zgFtPY1sdqifepGJ+44truyoPWqUg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mxCqULpXsZGg82VtltsqoIfv+I//+U/tiknIhgHaH2rRx5nSR6Ndt8Y6EAvo?=
 =?us-ascii?Q?ANv8B5D8PnX0QfGYhPmKLEHACRK2NwDRFLv1BHFpI4ooqlJdo1EvT/JNC4Jg?=
 =?us-ascii?Q?NTVlJlW9LbwKD9xVQ46eODLpukcLw/Ibmj+vV9GzUuzEpayaVjJ4BmflOTHh?=
 =?us-ascii?Q?D5lR2l/J/DcqGQFCdcH9G8oEVZNehLPUR3TRM9a3GpL6nRw+AEE3vP3JBUDg?=
 =?us-ascii?Q?813UpLF8otXaFmq7I5tAIIGSYm60490aMvAjaOSvO+mN3afVoTGO8j+4fLyo?=
 =?us-ascii?Q?pkp4dJVcYAeiPDM+sVTz5LgjUm0eB10o3kh1IIMqlBq4t9Yz49p5KIhperiv?=
 =?us-ascii?Q?F9smqzohu9vgVOoHj3I9nX5ML5ESupwQWdj+PjVKQJ8/7KFUByBPuP51+bj6?=
 =?us-ascii?Q?Ynl7Zs5Np1q+4tnMHDd4ZA1cAtcJkvtBQ4TLgWv28ludIZgSnb24mWYLdFKv?=
 =?us-ascii?Q?+WdxWTUXxpb6nu7qnElH+22HAS60kacolEtCj7F9chEQp83Ho3bogaGBQkgs?=
 =?us-ascii?Q?qMPqVTFwb146SAwC7D7qdIhBVSa2H7QsWa5ZUuFFivjNQFe8RiRdhtOIxGbB?=
 =?us-ascii?Q?j0pvb4h2kQ9YswNBs9qkEm9TlpP0TnB9VDioT25k0d3/yhVAWE4gCbgfOnCx?=
 =?us-ascii?Q?Cb+y28Bkz9kxzr0yMh4AFqIy0BM9dPNcNwyQk3knyLV8aPTs6HVXGDn1r5ws?=
 =?us-ascii?Q?ZuPzvfAcZVb+4KMZTkyFcuZ7utbQOxJIrtU5T5XaeV4XCbgpVeP7L9mEXrmM?=
 =?us-ascii?Q?9mxWVhloVDJsASyyflMMMTJovV6Hjc3eYgE+AQAa0tuKiv1ydmps/Ww614R9?=
 =?us-ascii?Q?5pgGfUw/WHH4wEKnEMBw8DmfzuLRc7SJOMKjg2CwYUVxttaNd+hrqQJvLxNl?=
 =?us-ascii?Q?i/qi9KcV0+rAk4eh7erfnTtT+QDcN2zSxDDjgi5qf2xKbUbsrJszMWNRbb2V?=
 =?us-ascii?Q?85hVBnO+qdwPMHNlfF+NoeoWYGLV6nr+n+dzApxplYK1pKYOKlbNBmx9slFz?=
 =?us-ascii?Q?GJmHpF679+rsGd0b7hRfokvAXaG+uSWMKgJqwI/rUBEaMTvQvxbNr7TcTYwC?=
 =?us-ascii?Q?w2D+kdw+z+6zkA3mFWLIN6kftECfI/z8Dx9meWhA15w3r1Q6jEdNMItwZ/nt?=
 =?us-ascii?Q?yzFDWEEwe4pYbNKAtj3u0Khrmp/NIOmr6/yr73cKiRxkUkkpFH5RJ9CgZXNf?=
 =?us-ascii?Q?eSSMQqECeIKnWpex9M5V9gHpcbp3ZcHyoLKDlsTjM3z1tVQzqjn+vObqmVeA?=
 =?us-ascii?Q?6spvM+FKMwkRLsTs66/zo6PpQHJO65ruYT7Tj1VsCPwZeCcAusHjjntRzizI?=
 =?us-ascii?Q?fI/ETOH4HkMZkg6i2ZT0/X6hD5QqV9/kSpkjA9vEYUqk5f0LQz6gm1BIH45M?=
 =?us-ascii?Q?TlZ4al1GD//JL+xvivCKdVSFaLV7Y2Sgr6Ch331pWW/K/sBaYfcXnOsMycth?=
 =?us-ascii?Q?gN0VG1eJJS9ofb579kMzPb9+qNE+mvMviHBEWfXY2CTTjUNPkpZKM4WA0s8g?=
 =?us-ascii?Q?MrRuV70r4VRwYpgGGwPocS1HIVfroSYTxISYNcahyRvLZE3Wvrmf0AdjXvhl?=
 =?us-ascii?Q?DDAEFnTRCKjgp8XgafmnNJmqs1VZV70iqIuYbqd4UCGf/CFb+REYq11bszS2?=
 =?us-ascii?Q?RcqShOgcLoL6GVQs18jIML5iJxFDtW5lRzrOhYWp08agQDQrfraXBRs8ymJu?=
 =?us-ascii?Q?cTR8cGwgSFvtvXmxvd4B+Mct3b42ykkd26ioLZO+ihDtht+UR9CZ7EP0kffl?=
 =?us-ascii?Q?2lho4BoyzBNdPc86gvoW9DosHkcT631WYhU5DRtutQFzLkib+HnW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acab4bb-e3c1-41c7-f59e-08def3e8c77a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:30:23.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYt1fSQ70L04CCsEnF+tL2XL+fzEWXXZIINq5YLeQdi8wJE2K6HOIzn7DTGCFycs5i3N6FTyQzy42OLOGx7ECoWNGNTGKH7MADR0giBl3PXsewMfBXklBQKEdhNSjmlL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11722

On Thu, Aug 06, 2026 at 04:18:47PM +0300, Adrian Hunter wrote:
> sysfs attribute callbacks for the master controller device dereference
> master->this.  However, master->this is freed in
> i3c_master_detach_free_devs() before the master device itself is
> released.
>
> As a result, sysfs accesses can dereference a freed master->this
> pointer, leading to a use-after-free.
>
> Keep master->this alive until i3c_masterdev_release(), which is called
> after the master device and its sysfs state are being torn down. Do not
> free master->this as part of the normal device detach path.
>
> On the error path in i3c_master_set_info(), reset master->this and
> bus.cur_master to NULL before freeing the allocated device.
>
> Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
>
> Changes in V4:
>
> 	Also reset master->this and bus.cur_master to NULL on the
> 	i3c_master_set_info() error path before freeing the allocated
> 	device.  Tidied up the commit message wording.
>
> Changes in V3:
>
> 	New patch
>
>
>  drivers/i3c/master.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index abb582645a2e..2357874bb9d6 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -842,6 +842,11 @@ static struct attribute *i3c_masterdev_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(i3c_masterdev);
>
> +static void i3c_master_free_i3c_dev(struct i3c_dev_desc *dev)
> +{
> +	kfree(dev);
> +}
> +
>  static void i3c_masterdev_release(struct device *dev)
>  {
>  	struct i3c_master_controller *master = dev_to_i3cmaster(dev);
> @@ -854,6 +859,8 @@ static void i3c_masterdev_release(struct device *dev)
>  	i3c_bus_cleanup(bus);
>
>  	fwnode_handle_put(dev->fwnode);
> +
> +	i3c_master_free_i3c_dev(master->this);
>  }
>
>  static const struct device_type i3c_masterdev_type = {
> @@ -1125,11 +1132,6 @@ static void i3c_device_release(struct device *dev)
>  	kfree(i3cdev);
>  }
>
> -static void i3c_master_free_i3c_dev(struct i3c_dev_desc *dev)
> -{
> -	kfree(dev);
> -}
> -
>  static struct i3c_dev_desc *
>  i3c_master_alloc_i3c_dev(struct i3c_master_controller *master,
>  			 const struct i3c_device_info *info)
> @@ -2266,6 +2268,8 @@ int i3c_master_set_info(struct i3c_master_controller *master,
>  	return 0;
>
>  err_free_dev:
> +	master->bus.cur_master = NULL;
> +	master->this = NULL;
>  	i3c_master_free_i3c_dev(i3cdev);
>
>  	return ret;
> @@ -2286,7 +2290,8 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
>  					i3cdev->boardinfo->init_dyn_addr,
>  					I3C_ADDR_SLOT_FREE);
>
> -		i3c_master_free_i3c_dev(i3cdev);
> +		if (i3cdev != master->this)
> +			i3c_master_free_i3c_dev(i3cdev);
>  	}
>
>  	list_for_each_entry_safe(i2cdev, i2ctmp, &master->bus.devs.i2c,
> --
> 2.53.0
>
