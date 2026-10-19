Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792440664;
	b=icXjyXxPS/7oa4Gt50ijA3iFLfMDXvrchC+2iDgaXGxPvGY71FEl5ULfWBgqVa3L5L7s
	 7CZo8H8fUeXZmnpZn6PMi0wAAfdATz0n5XxlaLnAYseXcuTbXxnH/Xfndovpvi80LOCwu
	 6cmfVBUadGHNqWz6QTGDupf76tNmaCuQ9QfO35eGC1iCCF4f3msV/5rtj8akDlYR+9imT
	 lwpLcMZXaSn5Q0nIIH3iR4R0KIc8yKFiUCAjfC9dtdyASzNQJZ5it/2e99oPg2YyNm3Mn
	 hFIYmbCS+3J+xpVSOODCoVT++Yk3F9k2cP3zF1eRXG26pGEnkshY3UjLItuMixZg7DQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440664;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:X-Mailer:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nzoxcAu/KB3ED2ZUJM4kelf0Lc72NmRPbDCLQByeHiw=;
	b=H9kGXnFt9O05EJenlEyDM7d//+ZfilGnAJtDWMVvbc7JMt5I67KLlno9ccU6OO9DHD4H
	 UhBOhVBWjcgH2QlAHfNm7dVU+SoWG6d9kdj7Rg2esvHCuWovx5I6dddv40SmCTihkZM9e
	 QGE3AiHQViCcKLKmCvt6/XuwElCF+Ne2ZTQ4GMeWM+/kfQTsRbNDbfflm8sDO4xjfdkUO
	 lFxCXsoLct/gN+1wUNDO+7brRjOX1IR6sn5mMGIqBABE3xnrkBPH5AK2EUUEOWbs6M46J
	 5Zmj3+1ehuTPrY9Mf44nHiYqgUjJfnitGAbm+AUkPHmebiDsJVAPFcIW9aHm/lJG3qQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pNXgYDqw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.57
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012057.outbound.protection.outlook.com [40.107.200.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE0606A319;
	Mon, 19 Oct 2026 20:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FDE0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pNXgYDqw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDEyxx1uP0IJ9nVyuIQJOTyqCdPFYgJ9DNIFtRkAKZPYFUXu5lEY+P/NADt++eEUzCMinmulfw4evVWDTSyctKm5Vnv9vvfCJztPls6WquT+GdGQFs+pGvH2xGo6ajG0F9MGwLdK8ytB2pqPtKK/5gVeJNFD6/Uu88ZVGIYT87hsVzEIpVDrEHunURRIVjjD+CADxhyJsXYt/XRJW17tOIhDrXAKk4lZ4lQhLKerdgQTU3WckHr34ZaYkrH/0TzQBwwKkTwGWqA9Bb4xhIAPnG471mW0zWOYOE/MUkViytqM564LH3Gx1H7Pu6tMxpNjWp0hOGvgtutNfQDU5SAxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzoxcAu/KB3ED2ZUJM4kelf0Lc72NmRPbDCLQByeHiw=;
 b=evG6Jr1eYp1gJBe9WlW8lSepNkZOlJVSA6wLzTeLGcW7LP9lPUzxu1dfShISZcq14q73rsI7U6KKnhtpzp38IYSRwF31ubcWwHHHziL9dqZuL42Nkj8QWWALVdckq87iSONqcBz6Q2i8mrqIwe0p/Ul0xvXKidCGgD+SB7q11kgKZCnpPk2R/XYFzyuJnqDkHss2OmdpBz7s+BQwydL6zktyLJCZ3dxGFaHt3RGiUVE0WikzSdB5nIGvWjEnr08OD1BSSNkBrD3mrBnZ8iChX6+6uAoTEETGcEPnlQJzDhtSjYLCpw1m01SsPiv1uq/pv5que3bB8xAneMSdzb3Ufw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzoxcAu/KB3ED2ZUJM4kelf0Lc72NmRPbDCLQByeHiw=;
 b=pNXgYDqw6weXEecHEhNjTvv1rOC2nMqSLm2OUKBPHb7KdFVnJyfnsW3YpJRTDZ75tlsCMNeQbWK2nltuL2fqoIlbaPa4H3sD5H1gt41GNgbUGg5eO9l9Ja3zHKHJYaoh2efSu/36JD8jNYJpET6AaT0M8PIcEeZmKLxlbmUMjbpHHz2UNPUf7wpDc+8kK45MBHY3yuPJNcyij1EJQnDj7/5E5ZogG8Pa3DEKCtDZAQTu4rwLt0NaRAP7EF8wKu+P/8p/5MxssI7OTlO/KPHoVpQfRMQ0G5N5Kcy5l7pwR24r2R5zv2pMCqyNRflOhJuVA4jB2NSUuhNuSnABMbPPYA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Mon, 19 Oct
 2026 20:10:59 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 20:10:58 +0000
Date: Mon, 19 Oct 2026 14:10:53 -0600
From: Alex Williamson <alwilliamson@nvidia.com>
To: mark-ship-it <williamwoodstock79@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Avoid bus reset on NVIDIA GB202 and GB203 GPUs
Message-ID: <20261019141053.7b2d8e23@nvidia.com>
In-Reply-To: <20261018201727.96924-1-williamwoodstock79@gmail.com>
References: <20261018201727.96924-1-williamwoodstock79@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:303:b7::19) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 474d2e08-ae1a-47fa-529e-08df2e1d16a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|261009223027099003|56012099006|11063799006|22082099003|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	y/VhbIkNvYkA+qoOKExY4I14adHdFGkSdCyljX/wNWjrsz/i8gj6BVOHjZbsd7Dr22n2+po2yf4+DoJNAPSb6DhuWyrw3s5aEd6KbeCpL9fNpeA4hMEpIqGMy9fNOG/4xeqdUx3N16xra0fALZLBdejqNVNPWOIUZRVUzRkrS+uS/aCo2PtRE9R3nMmFsXKBOsfhd2OHoShvLK1l+XVnsT2o+Zip9lmZfM6tSGAwJOHabWUHdJ2StAS9FUqsTibdGKeNkdhwDNKQhXgWvlNSU6kmsx4UbJm+WAD0fXmwc79MRB4uiay521+dsBCAvbVsb1Hr3IzPJtNkCrkXYrZqqE8cEq+XNWY/k+EJy+feRE35kkGps+OJLGAmyjJQzJdfVWDLSlmVvVIMm+eyXPHTrYYBNrD/YGsi8REuNlEMFgODgyE7QAbVWgn0nh60Tt6fg/Rzq10x0xgO6r7S4Qm1Ql6r382dp9604UMoMChpAEfkCO2ypZTyXfIeFnpak/pDH4nzt6N19yICTQTJZynleV0MFyk6QW70pzsGtpWRz/jflG+qleYWlRnEc46Qxk2sRIHvLnv0UUNJoTRDGw7u6cRfuUV72xaBprDcJnFVdohXkN2pthNYs1JlRYOp7ufiE1Gpp2glMOrMQFXWqGi2HspBspTKd39ysDTAYzJAOxA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261009223027099003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5uYg3tw5VgwDINbsPS5xQ13KFbk4FfiDyFp3G0igczOAOkn46Dhzbt9TLD+Z?=
 =?us-ascii?Q?Mq5of6tuD0iIj9giFSRGI8CJFtJsxN3WfClCOkDMeTO2E3EAgpLSflpEfEFV?=
 =?us-ascii?Q?E2R/s9gx7m0jM+k/egYycWZcdKUuPB59684krPXJmN0iIdu5QhO2mtwQmYHU?=
 =?us-ascii?Q?TzPbTGcapy36t6ekK2EZMzBaH5jU7XwQ9rFW2mdCS2t5MxSv9KnA2a7pbqyl?=
 =?us-ascii?Q?gLhdHusCx87SS6c5bDt5fDPdT69ZaliYAs8tjqEkS/oAdzDMSKI1k4izFKRS?=
 =?us-ascii?Q?mSIiH+k7F0x/oS3wWcWdI/VUrSoCjiCNWZsi1FhwMKjEQxazecOMhtKuUE6a?=
 =?us-ascii?Q?Hy1BjwN3Nh0Z+CC0scq+1xJr2DnrNRqbVLSh48Elp/I2VsuwN6OlADUbfso3?=
 =?us-ascii?Q?GT45gT0/ShpmA+pdk6NZR1D5RHYTt7ru/nKdwBAqW9pqFduawK2DqzqPj/vm?=
 =?us-ascii?Q?7dx7KMujVncXn6RXQkj+Akyo0tzqYPJGrm1AL01pu0dJtvAnx/t0Mq3TLMrr?=
 =?us-ascii?Q?na5pubM2b6iIZMrjnj9j1ZILWIs0YTVLbZEtUPvA7fYCEstMKW44O8dlMGfK?=
 =?us-ascii?Q?j4RwQUYoCnyzOHPkQpdJE5tRV9BYu1ISRZolKW8a0QzOEFJXmdrhKM5YMbyo?=
 =?us-ascii?Q?PEyCsEQBbYgjObl4f4KBkmKEQEk51iU7TVD+M9bQBdzibB4iWHdrUzXFO9X+?=
 =?us-ascii?Q?+kUUpNE8yGJjlPeC1YAkYFucsw8aqHG7Lwbz5XWEESLBufJiPMQlHk25sywY?=
 =?us-ascii?Q?TsvlJVCMHQ1/Cl3kccwxE4SySPgJgmQvQfKHzNbXqgCpLwnWfa5ECMk6PjyV?=
 =?us-ascii?Q?YOsxWFS/RvlYoVnyNbpZfudIZzdPbMAHSLU8EtWwZyatY1VAchXSzwfQIL3p?=
 =?us-ascii?Q?aqwPwHbIF//noyy6QovO/W5kkWzFEAEwQDLDvAjhLIQsAeb2VY80M0unAphJ?=
 =?us-ascii?Q?zYLIX2+EuP2b93qHrOJ1xCvXgifg69zWQUFumtehnSjA6LAdMiwBjfH5uKE5?=
 =?us-ascii?Q?KVOgHRFHk7Qm9Mx5ltSkFPzLyDEUIa5f8NNId45J9wgiluGX4qYVrAST5Y6K?=
 =?us-ascii?Q?CcnrQwiAAd93d0I1l905WUPjWhbXbCBGlOcGRcLlw7CB7Ypp4pHiG2nsPLZY?=
 =?us-ascii?Q?xi+zStSeX+vpgKmHZ5ITiHYJfw3Yl8bW5xgmGK+C1zn8P0kQQmPk6DBzq/pn?=
 =?us-ascii?Q?KsaHHPyrdOd+0Ip7v9+I2om09Tx5SsH5DHVxmsWENw6ZSQ5P2OmhiXh7ELVC?=
 =?us-ascii?Q?1zE//M98DvtRApSKqkGYKkW85KstjgB2bFi/Lo0QJAutKn8vousXJxb5kRUc?=
 =?us-ascii?Q?zvl1pDap6DZsJkJvAMDgFPSJSugYYaQK2G8mCwy6WyM/DBPuVDaGrPQbD3+J?=
 =?us-ascii?Q?SWXBbBtSFjd39JP8wOsoBmo04Dt2CQB41iFh0HhWyUioUuFmfhBUf9MhM3p0?=
 =?us-ascii?Q?sRJ6M/SMio+YEscGb0Klg5S/v6YokzDLiuT1YTEqapw4akDMqefIyWnN0CD2?=
 =?us-ascii?Q?gAwqeXuMPFuyoMGlSeTnsebawnMKd1LYoOYT23ndF6JviLVrkkVD/KSOsiOE?=
 =?us-ascii?Q?A8IHH+XMYzMlyannQKuemmMoamX8qqu5yny6KfYZIMLZ6zql1mlBrrzxeCof?=
 =?us-ascii?Q?nMnf/KnlvBafKcfouN6Q8vgxXSBQ0EdjLGGr0+X09/bUXL9aWfbvorMdQiFw?=
 =?us-ascii?Q?0ZQnl/vdT0s0LsUjX2WGUtU2QyKfNSqJIaVkgSRbTP4UGyKcJbXuSn5QhZBL?=
 =?us-ascii?Q?yEWAsUfBOw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474d2e08-ae1a-47fa-529e-08df2e1d16a2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 20:10:57.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hnEIVsl80PHH3sZcDTJQN7WWid5fZluvnYnyhz3jG3rTByFTcXdaMrGwsAiI3TfKxsmGWpV+VD6WP29ZzwB+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663

On Sun, 18 Oct 2026 13:17:27 -0700
mark-ship-it <williamwoodstock79@gmail.com> wrote:

> NVIDIA GB202 (GeForce RTX 5090, RTX PRO 6000) and GB203 (GeForce RTX
> 5080/5070 Ti/5070) GPUs train their link at x16 at boot, but after a
> Secondary Bus Reset the link comes back at x8 and stays there until the
> next cold boot.
> 
> The GPU's HD Audio function (e.g. 10de:22e9 on GB203) has no reset method,
> so when both functions are assigned to a VM, vfio-pci falls back to a bus
> reset at VM start and again at release, and the GPU then runs at half
> width. Assigning only function 0 avoids the bus reset because the GPU
> itself supports FLR, which is why the problem is usually reported as
> "passing the audio function breaks x16".
> 
> Observed on an RTX 5080 (10de:2c02) behind an AMD Root Port, kernel
> 7.0.14, Proxmox VE host with a Windows 11 Pro guest:
> 
>   boot:                         LnkSta: Speed 32GT/s, Width x16
>   echo 1 > /sys/bus/pci/devices/<root port>/reset_subordinate
>                                 LnkSta: Speed 32GT/s, Width x8 (downgraded)
> 
> No VM is involved in that reproduction. Stepping the link speed through
> bwctrl (Gen5 -> Gen4 -> Gen5) retrains the link and the speed follows,
> but the width stays at x8. With a VM started frozen (-S), the link is
> already at x8 before any guest code has run, so the guest driver is not
> involved.
> 
> With this patch applied, reset_method for the GPU is "flr" only, both
> functions can be assigned, and the link stays at x16 Gen5 across VM
> start, shutdown and restart, with the Windows guest driver working.
> 
> The same symptom has been reported with an RTX 5090 (10de:2b85) on an
> AMD X870E board, where passing only function 0 was the only thing that
> kept x16.
> 
> Link: https://forum.proxmox.com/threads/asus-x870e-pcie-x8-bifurcation-bug-with-rtx-5090-vfio-passthrough.178461/
> 
> Signed-off-by: mark-ship-it <williamwoodstock79@gmail.com>
> ---
>  drivers/pci/quirks.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 1aa87a3ef..a4adcc3e7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3769,10 +3769,17 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, 0x22D0, quirk_no_bus_reset);
>  /*
>   * Some NVIDIA GPU devices do not work with bus reset, SBR needs to be
>   * prevented for those affected devices.
> + *
> + * GB202 (0x2b80-0x2bbf) and GB203 (0x2c00-0x2c7f) GPUs train at x16 at
> + * boot, but after a Secondary Bus Reset the link comes back at x8 and
> + * stays there until the next cold boot; a link retrain restores the speed
> + * but not the width.  Function Level Reset does not have this problem.
>   */
>  static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
>  {
> -	if ((dev->device & 0xffc0) == 0x2340)
> +	if ((dev->device & 0xffc0) == 0x2340 ||
> +	    (dev->device & 0xffc0) == 0x2b80 ||
> +	    (dev->device & 0xff80) == 0x2c00)
>  		quirk_no_bus_reset(dev);
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,

What's your RTX 5080 vBIOS version and system information?  Is it the
same Asus X870E as the other 5090 reports or something else?

Is the issue still present on kernel v7.3?

Disabling bus reset entirely should be a last resort, it has
implications for device isolation when no other reset mechanism exists.
Thanks,

Alex
