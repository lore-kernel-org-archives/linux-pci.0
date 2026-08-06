Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70648C3E9;
	Thu,  6 Aug 2026 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040709; cv=fail; b=aLjI+3552qmwXWM7M2Ng7dEDlzF55c39ztRe/5v/QxU2qoj7RXd3achU+RVv/xUHyqg7Y7HYsasLoBEPWwt0F5z7sMXd+vP/zYb9lXNaxcVBowKXU8wgpw5OdriszPS1+suMFEIWttjQv8VudxpsKFq5KDhU5ezjW0SO76OJnO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040709; c=relaxed/simple;
	bh=QUHH78lLOHnZEr+KNPdbG8F4OQErgmo8kPdd/Qy4CAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nHRUKRqGX/GTTULNS+Uu66oHU65mcU87migYZoVMV2miQ1nWRpL+36OT+rujwuPADn+/o06ziskg3ixQKBWCluF9zr00h6fm7geXHUXqZkQdKIGiYtg0y/5Ja7kcbSWDx4S7DN1TywgIXJkMYnD37cgFDXYr1jZs/YcsCP3yVaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oSGyUol+; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oSGyUol+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvmTMxgwwoZC4Ax6vaTjhUKJr3QnpF0KwMLS5w8mDtKb+GknHQvfTYRrBUQqcsMPLauO+APXMAl4Mn32Q7UgwLAhNT5PKDB1sobZWrbhKHbdQOD+cPuRvXRLI7ea9Pb8zhUuiyfAZsecrn1xlnjWw9dPp9zj3cTnTooi7HqvC9dQe2oJ7b1oqsjAbAQC/6aiUuAov4ZLGmTVPewr47e6ZzfpALvl1j1cPobcA14RV0klQcWB13kisGErj15lbhMyl92GwM6QLXn0njwuDUfNlP4uM/NYSgHMUREvVPqRT0RltQQ4N8lJPRYJq8/eXcfhzwjptaCQe/j5xVfejqDmXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdJ3r3k8AotM5EKEAHwMQ9BmcFiq5S3yAPA/31evFdk=;
 b=fxYT3Rzi9un+I83UJ2ygRGd7tl7todlH9Q0DCW99FUUmX7pIizPLN/IUzvnWs8ZQUrODNNiqe6q7LzFrZcWQGeHbuZJ1NeqElxET8g0b5rxDVfOSxMeBfqlek/sP+kBCAq5RLzirNOBrs1hq6JtFi9PM+8Fk/yAsdxtLG7SqGXzVn/jZQXaKYmEkzHhP2/0wN5xs5oFZLaD9kqM7KENTwaRNg9X+egzJYusb5Ua/QlnMCZOsr0k94ieCVy0HhNKhX9wOHuW0ADPIXVgF8ghrZRThahWV0dkn5Oyn0MlDL7Ta51yO+jvTKESCvthpZIZlgme+Y5fD9Gr9cUsSuS3Sqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdJ3r3k8AotM5EKEAHwMQ9BmcFiq5S3yAPA/31evFdk=;
 b=oSGyUol+hSMQXfOhr3GWjyhYCThlnT82r03PTAnd6ZDvtWo5N3+a2N1ajP2VxCtyyI95Hx4hz3MpITLVpfCMU6SsW7wyrEhCZ9zolsqzXYZj2hDik0BeeftWmiADgrCUNKyCrIOYQDoaTV4uvoIjGvP1VBK3xD33xqJ4MVQX4Euooa88nLiSI9k5p0Wf0gFgyrtZUTZwgzTK5EzrF2f/4xuQjmIKBs1XQpXAQMD/st+iwRGBifOgh2EMqsWMmmeYmPuPiVikTnqYo5znMps5PjTfWwdiWAalx7heEn4UrwhkP/vHYmdspejZ0oInXoecPFdKzNBqX4YVH8w8MJZK0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VE1PR04MB7344.eurprd04.prod.outlook.com (2603:10a6:800:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 18:25:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 18:25:02 +0000
Date: Thu, 6 Aug 2026 14:24:55 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, Frank.Li@nxp.com, akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V4 01/14] i3c: master: Fix recursive locking during
 device registration
Message-ID: <anTRd9O59Lu9_h4k@lizhi-Precision-Tower-5810>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806131857.119830-2-adrian.hunter@intel.com>
X-ClientProxiedBy: PH2PEPF00003858.namprd17.prod.outlook.com
 (2603:10b6:518:1::7a) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VE1PR04MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fe1ce0-934c-42e4-730d-08def3e807f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|19092799006|5023799004|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	t55H/gUZqju10wE+iapgNzSD7C8FScqKj5eW6kfoYTB+EO1tNoq032u3Cj704Ld0B6ucW2LLi1YypGakX42EhUNTXIjwumCDax3V2XlKJZeNkYW+XQCim9lL7OvT7+3OCLBWVbN1q8ADIrPQeRduh+0mFFMJLIN+un+K1ig39shzRZCa1JMXKyoj6NQDRa6VvC95ahi0yXfb4udzFTrNKNsQCjfgJt5VtgmH7/AUY9XH9cTrGqnlPUJYSy/tJGzQSCUyxCcoz6vLWiw3RRG91Ajax8QPfOTNmM09Ke8qqOafvH/LPPu8P45cJrGje0LhcH/kZccjkNnaUr5oreFVREpP690ODV9g83h37rng5XAWT9YuIZA73E1QyWKrDgR790Klc5ESlmIlFxXJ5HWw1AB9099dmXIBRUKM1By+9PFFzD5Q/3U4jcj5T1yNSzD8rdRyQ6txDskx8gEt+zNLAeDwgVrUPaNMKDZkesEdmq2BbdgIAJrZ5Zoqe7n4zG9d0vlTpIZg7pVh2vTB8UNzM9qWujK7K384qOOGH0I6AfNMcoEoTxO5DpreoSL+Xezo6Vt/iyLKT9R4CHKpcYpZnbxYB0XJgnb+/7Ajq19KmlrlT4hgwOvX4zdIalwa3fj6PkQDbD+y9X/vWtCnvek35KmwLVKHchef+/h3V5nFvq0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AiFMnZpM8Pzfz9xZ0585BPHeVSZUbSbcDrnLJ3ZrQbWOn4dbWV/PCosogrpc?=
 =?us-ascii?Q?4T/kZ3vofC1hMQJKNKTx34bFQbF25Q8NtancZ8/1abwbnzcsSjsov11mBuXd?=
 =?us-ascii?Q?Sgdq/Y69Zfj6osG2u0z8xVaQo317wnoJAWFbUI8BEYBzIFh2RTaYKdrD8Ffi?=
 =?us-ascii?Q?6CUwm8xPqcZ7VUQjOajRj8B2J/lvv/hwyaG1mOYurGHxOnGrgTx94FwuwUxL?=
 =?us-ascii?Q?b0SD41DnxZjYgb2XBamFKOUu9ZU/M/+CNuEf+lqfPwpl2g9U+HVNWkiD5tgk?=
 =?us-ascii?Q?5SMeilE9fDCagFjLGQkbAuUVTucPG0dA5bptZR3RPvWaPPvKJ4dt7aKreI+D?=
 =?us-ascii?Q?RIxSH3j3BwHlVxKnFbt2iMttajRwprzey/QJgwi+5CtS4vrp93zctuI82dEY?=
 =?us-ascii?Q?FglPtESFBK8aKd5mRAuRhz3H3/IO6tdTiRbhnzt/7Lb3y3PxeSy1ZIl8QH4B?=
 =?us-ascii?Q?jtucmT4A4tIUSeKMvuyGVZzuq8viZz42oAxXtNN6hepkhw8W/UC05PQ7+9xd?=
 =?us-ascii?Q?YZTmwyZf+ssi7HF070tZmOffD7abNSHcqIaB4fCb/jPxSbUJtGdwSLmpZ8A5?=
 =?us-ascii?Q?+2XSv4XSdkW2zmIjhZ5KqYN+clWhxKy7M4sHJmDOKnQATZKv4N3qUNOURw+3?=
 =?us-ascii?Q?DEomBFN0a/llaXjIBnVLwizhk3YNO343G865n7AAbwK6AyfFlcdu+uanPU3W?=
 =?us-ascii?Q?WtI9ImqJchddXxaK8L7/25nE4pPV/RjSEkvuhUVNJlbp/xdhzTIGV3K8dbrZ?=
 =?us-ascii?Q?OJgpbDPrnTGqoWqya2r8MBiE6vBcOYT26mYf2oBIsB+cB9Q7jm0UtZkIkJym?=
 =?us-ascii?Q?VFk58XJt1beb42KxrjP7bqZsGA+k4ix6qd72mwJREoQz5mzllctdQPki2Wjn?=
 =?us-ascii?Q?HaJMzRihO2cYUiNVysMTfABQUaWhECt59zYEaLfRiNcJtvd3ib5pSZFGY+jw?=
 =?us-ascii?Q?a3OliopOSNWuk5fSeXuV4xXmsqEIDy/H27IAzs1Kz1cmPi9E75KTZBVb5R4O?=
 =?us-ascii?Q?3MmJz+A0FdjKXoEpK+cCdwmTrynBGhS5BE2EameT3Nxn6MezQqLbDJ9WH4IC?=
 =?us-ascii?Q?Y2dh1lsNP6XRyUcy6f+F2Ffl3d72UDD/mX3BFi4HnCnzN7yUw0b+X9R4tdaA?=
 =?us-ascii?Q?tPVn1o8y/ZxqTB17UyzbMz9+RP2Ir6T1b7iL9FbO0uYAGTlJVS/CumWwMbFU?=
 =?us-ascii?Q?sHAvGwQkxbJuCPp5mFGTzqzsMd3K0AlL+bOrvc0Z/+dJt9Yu+xW05sbndbDO?=
 =?us-ascii?Q?TqoFH51s2wgKkc6NClaFpa8iXqGrRLMxxINqCgPTk7ObzXp07uzGCRudemz8?=
 =?us-ascii?Q?RkAhMcmNGcsmzvi0OD061FIA+O/rgs+BYlwyDmssPvQywRwYUJuTywzDBMvz?=
 =?us-ascii?Q?+GJDTy3uV1JYP2b/gS324YVKfgVWhzIURiqfYTKkfu9jf+U9jchWW4j7i3+q?=
 =?us-ascii?Q?UZwMAmoEeQ7PuKvCUcFlc6xOx1API0SCpMabquKGQrloo3a8sisPm30lolhn?=
 =?us-ascii?Q?AiTquWpOjw95DICnkZO6AupSpXd9SfnFF5UMA70++b5McbbOS1omgnRJdq++?=
 =?us-ascii?Q?Qtofm2qKkUwGNYCpt/9sZSe3JkOtW6viIMyFzqiQ872zwFB+ExLU6xwLlu+w?=
 =?us-ascii?Q?IZR+cpSt3MqjwT5E7S50b+ebEKzWFoq+iZp3HZ0skChMVVDpJid5RgdfkLXu?=
 =?us-ascii?Q?h0KLlYy9q5wGtAuWSHrTq1XZmBk9i02sMkAOsxNbS2Toq8edOAuLoETsdqNH?=
 =?us-ascii?Q?H7q+zJnn7uSVnr8TeqWN8RpXpI0yMxYu3fF2VtspzVfOl8ecmbhy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fe1ce0-934c-42e4-730d-08def3e807f9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:25:02.8048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/qByJdz1k7kgcEpe+ZD4KkoZmzN6NRjAoNRXJBeGo89ESczz7K4dS4p2gM0bWdK66KKz+0fwuS9r3o3DN2ewSMMF6NTi1ewzQUDAGk/G0mFMpOTQ4kkNFLC++LC/noW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7344

On Thu, Aug 06, 2026 at 04:18:44PM +0300, Adrian Hunter wrote:
> i3c_master_register_new_i3c_devs() registers newly discovered devices
> while holding i3c_bus_normaluse_lock(), a down_read().  device_register()
> can immediately probe the device, and probe callbacks typically invoke
> I3C helpers that take i3c_bus_normaluse_lock() again, leading to a
> recursive acquisition of the same rwsem.  rwsems do not support recursive
> read locking and can deadlock when a writer is waiting.  See the
> "Recursive read locks" section of Documentation/locking/lockdep-design.rst.
>
> For example, with Intel LPSS I3C, LOCKDEP generates a WARNING like:
>   # echo intel-lpss-i3c.0 > /sys/bus/platform/drivers/mipi-i3c-hci/unbind
>   # echo intel-lpss-i3c.0 > /sys/bus/platform/drivers/mipi-i3c-hci/bind
>   WARNING: possible recursive locking detected
>   kworker/5:1/94 is trying to acquire lock:
>   ffff88811c810d78 (&i3cbus->lock){++++}-{4:4}, at: i3c_device_match_id+0x45/0x370
>   but task is already holding lock:
>   ffff88811c810d78 (&i3cbus->lock){++++}-{4:4}, at: i3c_master_reg_work_fn+0x21/0x5f0
>
> Fix this by separating device creation from device registration.
> Populate desc->dev under the maintenance lock, collect the devices that
> still need registration into a local list, then release the lock before
> calling device_register().  Finally retake the lock and clean up any
> devices that failed to register.
>
> Use the maintenance lock rather than the normal-use lock while adding
> device objects.  A write-side maintenance lock prevents readers from
> observing a partially initialized desc->dev during initial device
> population, or desc->dev disappearing if registration fails.
>
> The local list requires a list node, so add a list node member to struct
> i3c_device.
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
> 	Expanded the kernel-doc for the new struct i3c_device @node
> 	member to note that it is only for use by
> 	i3c_master_register_new_i3c_devs() and is not protected by a
> 	lock.
>
> Changes in V3:
>
> 	Added Cc: stable@vger.kernel.org
>
> Changes in V2:
>
> 	New patch
>
>
>  drivers/i3c/master.c       | 45 ++++++++++++++++++++++++++++----------
>  include/linux/i3c/master.h |  3 +++
>  2 files changed, 36 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index f485b98805cf..d2fb1a110521 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2069,12 +2069,21 @@ static int i3c_master_early_i3c_dev_add(struct i3c_master_controller *master,
>  static void
>  i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
>  {
> +	struct i3c_device *i3cdev, *tmp;
>  	struct i3c_dev_desc *desc;
> +	LIST_HEAD(i3c_unreg_devs);
>  	int ret;
>
>  	if (!master->init_done)
>  		return;
>
> +	i3c_bus_maintenance_lock(&master->bus);
> +
> +	if (master->shutting_down) {
> +		i3c_bus_maintenance_unlock(&master->bus);
> +		return;
> +	}
> +
>  	i3c_bus_for_each_i3cdev(&master->bus, desc) {
>  		if (desc->dev || !desc->info.dyn_addr || desc == master->this)
>  			continue;
> @@ -2104,25 +2113,37 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
>  		if (desc->boardinfo)
>  			device_set_node(&desc->dev->dev, desc->boardinfo->fwnode);
>
> -		ret = device_register(&desc->dev->dev);
> -		if (ret) {
> -			dev_err(&master->dev,
> -				"Failed to add I3C device (err = %d)\n", ret);
> -			desc->dev->desc = NULL;
> -			put_device(&desc->dev->dev);
> -			desc->dev = NULL;
> -		}
> +		list_add_tail(&desc->dev->node, &i3c_unreg_devs);
> +	}
> +
> +	i3c_bus_maintenance_unlock(&master->bus);
> +
> +	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
> +		ret = device_register(&i3cdev->dev);
> +		if (ret)
> +			dev_err(&master->dev, "Failed to add I3C device (err = %d)\n", ret);
> +		else
> +			list_del_init(&i3cdev->node);
> +	}
> +
> +	i3c_bus_maintenance_lock(&master->bus);
> +
> +	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
> +		list_del(&i3cdev->node);
> +		desc = i3cdev->desc;
> +		i3cdev->desc = NULL;
> +		put_device(&i3cdev->dev);
> +		desc->dev = NULL;
>  	}
> +
> +	i3c_bus_maintenance_unlock(&master->bus);
>  }
>
>  static void i3c_master_reg_work_fn(struct work_struct *work)
>  {
>  	struct i3c_master_controller *master = container_of(work, typeof(*master), reg_work);
>
> -	i3c_bus_normaluse_lock(&master->bus);
> -	if (!master->shutting_down)
> -		i3c_master_register_new_i3c_devs(master);
> -	i3c_bus_normaluse_unlock(&master->bus);
> +	i3c_master_register_new_i3c_devs(master);
>  }
>
>  /**
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index 2dc139a217bf..26535beb1e77 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -238,6 +238,8 @@ struct i3c_dev_desc {
>   *	  every time the I3C device is rediscovered with a different dynamic
>   *	  address assigned
>   * @bus: I3C bus this device is attached to
> + * @node: unregistered device list node, only for use by
> + *	  i3c_master_register_new_i3c_devs(), it is not protected by a lock
>   *
>   * I3C device object exposed to I3C device drivers. The takes care of linking
>   * this object to the relevant &struct_i3c_dev_desc one.
> @@ -248,6 +250,7 @@ struct i3c_device {
>  	struct device dev;
>  	struct i3c_dev_desc *desc;
>  	struct i3c_bus *bus;
> +	struct list_head node;
>  };
>
>  /*
> --
> 2.53.0
>
