Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC7311967;
	Thu,  6 Aug 2026 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041243; cv=fail; b=pJPcLIm2KgzW9DORcJZ9+zCmvlwJvDYRbZt7ugd/ycOniLQRGqp0SDV7BYddRvTnPCQnydaJgC+Hux5IHxhaHplCh1qAk156DFPGkggNz3rweenM7iwGZbMwwsfHNm2MBP+lRmCkZEDq1rWZA29FnvE/7u/h58d5mUZEkOnTVEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041243; c=relaxed/simple;
	bh=QAQLMk3ZvIFhXwxvkhWqnUvcHDEOpgqVucVLt3ZcT94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EtJAih9yUmnhewhNR5NCKlsR1QooCWb++J4+2YxOErxiK22zherkDqcll7x1vR8MJt/951LamyUp/NHCvLYRaw1Yw58Cd30/WCDPVhMhdaYa2fZRMmaYI3wxt2IQBz2lFQxmKPYmtga+9dlwzhpnaAiBw+odU2/f6mafQSCQGMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MJ84U8Sm; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MJ84U8Sm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEW856qqOxla3ev1Tp40ga+EcCu1qAIN5bCO/iAoRY9B6tHHfuY3gYSf12kONBynFtumkmkgHCO11YmSQwHMQXEoBY8CugCpuuyQhvnnBzL9F71KmIcwnAfaCCwjZcGYNjAXiHpdmmb7SjCCPx0vR+f6hcTTKaOxdr00T96DZewr+Dp5CYGKTgN4xR/HnwuhfGva55ZMtf9MqCD2DZEalDavqaqh/3gezR7dCZH38bfFMP66r27CAx7A37l+r205NmkSm2DAy2a6eWXVsNAftk3jfkWCMCedf9h3iQ8DDBPx6lk3Tpk1B1WZWVC0hbiqLmluewTiGGh+HUfZd03o6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfldCtsPa2Ntj6yQczYRbEHf8JiFhgE2xiry9j+Ge00=;
 b=Ji0Ka8wUQQn68cWdfj40wSAio/5ZKhCW/iXbsSFHGjRFlWUY/oYZyvKlyH/lesOML3Yu4TJ1Y94ZGG2CQaZo6LzwJLSPVTdYX53A47VmRiqBbJV/MpdtWHZuMHXMBYXetH0zCSZ8MF2euaRUHEqh1UmS1H7ZCtCqecIUZcIjh5SkIPPVmMuaODtyenNbouZILIj9MOGTPvXGaACvC9CQnN2eR23uDsIDCMS1Gq+6aKVWpUzKqgdJnn17dYTji0QFMS8x/Z+uqtAyz2+UjEbyqXjIhA826OmNwFqZdjxh/HDRRZ1uV+WsJINVyir2UvNun2TxrHE8bHSyDQDJ2Vc6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfldCtsPa2Ntj6yQczYRbEHf8JiFhgE2xiry9j+Ge00=;
 b=MJ84U8Sm0wG5rE2fUhI30cTONzQPdz8t091YFt4R5rlRaYyHjJEVRbK2vFWMHO6Qf9E3NcQ7yZqIU+xKqf8pCszx/y/ubRaM+O9Ehx+b8Fqoze3ZZyrEXXjI9eOGK9qZTTwhjapQQOhgcVLNC4zZ9E8iJZxkGvY+98g3tI1Yn1hgdC2A3Y/krnAUP9G1Hh3jAsi1dhSwoRM+q1GIJE/hbSGdm0Az6NhCvTKAva1llPC+/Js5OnEVwPZisMWi9017CEF/q77SR+qBg44Iqid01cF1VmJLN63u+u5DBwEfa3U9o+h7KtvI3kP0LOWEsIjNlDbLUCcgEA2GSdUMbD48Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11722.eurprd04.prod.outlook.com (2603:10a6:800:2ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 18:33:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 18:33:58 +0000
Date: Thu, 6 Aug 2026 14:33:51 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, Frank.Li@nxp.com, akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V4 06/14] i3c: master: Fix potential UAF in
 i3c_device_uevent()
Message-ID: <anTTj1y-vlmqQRcl@lizhi-Precision-Tower-5810>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-7-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806131857.119830-7-adrian.hunter@intel.com>
X-ClientProxiedBy: SN7PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:806:122::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11722:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b1a0a2-a345-4093-a084-08def3e94764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|19092799006|366016|1800799024|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DWrQbvSsmGKx62qsPw6APUJSNJ+2liPKFR3Pf7MhAMdtamM9dx0Ycp9o/fXjHVVNKM40NLqNP9Qfw4HPMrsrOZbWDiqP2O1OrDIOGnaW0tD17xit5+URzYKco6VikZ/PuHlksvRZbJF/iCfhaC9X5gUoZ/DCO11OXZZkXa5Fqdjojd89ufWgu5gGiEvrnLY7tgxCgl1up+a3XscTSQFtSCiYfcGLc1561MfPfxVAxkimCgAW5274OKLncAWtqlLAnGJZwWDWm7xyotTUT5XPBlt5v6vRfpJLu1HEooPFAgJ3uI/AjAmsJFfXT7z6cpyzZI27pU7/huTBjHkB8Sfyte9W7SQOCKGxnPYNjTW4mNfa4mUYARt1VwV5PEDeaBwpy1oiJXJQQsHFInjMXmeQw2emeOsJ6KipQfYO0rKMvdu770Cmmuv9rvuUFOz0fRkmRutkU4DuE9ED7jaTLsEt5FaFOdUaUk9MSiyOJFHgEKB5bjKJkuOTr6t/brfn03JRNOttoKYvC0JA/NsvSpPWz67T2sDKhLjjE6Vn9brVX/DRvn4D4DFGlFB/BXpxlggs7BeaSljjKTSPTEZ0pKX/o7pct1I2GkhVTs45mzYWU5xyLxWLEtcJZF9Zm022Bcc/iboffgMw2goZSlfn5WETtfdFzVkQyskgva/ARcTIvPs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EWY0tksF9Zdzhnza3YJwPJuVccuGRE8sokrx42Oh5uhyFf0q+kyRexoDt7Wy?=
 =?us-ascii?Q?MJI/UUON2U7Onig0ESg4VUxt7YRxbetb7Hro186VC3qVx1tAYUglXIdZ0MOt?=
 =?us-ascii?Q?VGzu+tkjUJ/lPsjPfAKVzyrbU+kiBeG2EoheuI/HGjOOWpMG5l0XLOIfrV5U?=
 =?us-ascii?Q?pcQLM+HBLzURBSUG8yeFVRMMSZprZJjwLVyoQeJANb3yshy44JK+F7MmqcI9?=
 =?us-ascii?Q?HhTNVMjy5WjES67dfAkSOXLnEFABR1azWKYvtcO1cvie6WbjUETRUbKKmMqr?=
 =?us-ascii?Q?CUwk29vDbrHsTBqtDVsn8EIZXKkCr/18LO/JdmfFaqfZquY/P8DT/xtj2a90?=
 =?us-ascii?Q?EqVZ+zGv3W+vEV8V8Ok8rkhekygB8ZLLPQwhTCW+VUbm5o4JUrSxnO9Hcktd?=
 =?us-ascii?Q?FXsKHiEYwILAYv5+98qJZD4fCRSstqCE9PTpOso3rQgt5Ny/IZESoAXVTwvR?=
 =?us-ascii?Q?rnvvkc2JcbShBc/KYGHmKsKIq6wNCSfx82NbG1HpJOLuLeJxikWXXcYAa3dO?=
 =?us-ascii?Q?tl31ZSUReKBdRQez761hOBYmaqY22UcJtk5L40zJj7ol9RzhHFjgqlCVJqww?=
 =?us-ascii?Q?0BNYMlBe1lFs7IvF4SL63g2ermt5bMuqtwWxlX8jYyzfFmPCjFLAfFc1u6il?=
 =?us-ascii?Q?ORkyDCIeCGBwB0kM9L3z6yyk8voeRX/zPFZaEeTkMoCRFzDNZj5KHV1gS3H+?=
 =?us-ascii?Q?gGcwNlDdwrzbDjixu9xsumyz+GUlDrNaFfOd1Y+GA70bnACGQ/xPx4oHvqep?=
 =?us-ascii?Q?H3hltwMD6Gy36mNPymx8z6tF7SYdp0NILuEW9VBDNzNYRA8CccBdlO3UWW8f?=
 =?us-ascii?Q?LI88VstxkqE6NpcjYWJZdaM42XUEZn1iw/vAJNYIPGeOyGtBRURVDZfOXJ6p?=
 =?us-ascii?Q?p8pi7ZZdrFMKWd3Vhd1WqPnk9kiA82qHsC7aXGNrEJB4VwmaZ3RYaZyCbwyF?=
 =?us-ascii?Q?DRTuDBql/qmo1/ngribMAlJnkIYGUcx+lP7wVN0m2QojW+zeOhwSruWRTqLu?=
 =?us-ascii?Q?oo/6w+mV0pNrBkJJqwaaillpMYsHbmXd8bpbWyCAHXjTCnaYeHkDXFo8vNUR?=
 =?us-ascii?Q?ykIc7ucv6y2q8BFrfOLVBvqrOcyqYTHGDlkyrK+pwiPMoa7zJCYX8Nw20c4K?=
 =?us-ascii?Q?6YgzhnQUqkPHAlGTqMsHCOxFtJF+hXCvsKihbBKZ4xgm2+GRNM9ySg8I++mk?=
 =?us-ascii?Q?C90twA6ZFcOcfD43spvaxFG8KPKRA1HTeHP66Tviyoz2lAobxj5Rf4x1POI4?=
 =?us-ascii?Q?7pVJWw38yzA06B2mOfd9UTeKEgMfAc8y9avWwWrhofM5PoGrzSWNmlc5cm+v?=
 =?us-ascii?Q?R82aX2n4woYEtr8sSDWH9bHLBHjYCSzMq3A1j+CwgKZZxKpSlelybAwOq5oM?=
 =?us-ascii?Q?13YroHUkPtTWg7y2P3rIJcj6nuuSyBDtMQV9rpGagxhR1L4wT9sdzVAfSztF?=
 =?us-ascii?Q?hkgIBLE2xCjVcAEN8D6RMDBUvNickdAahBmnG3jVY7Q6QgmXO5l66rO0udde?=
 =?us-ascii?Q?Lv9wJPf++M/4rTVwkWguXPAyD2M8jDj7V+9bEdyzi/9vtvuJIfEdkt21D4bH?=
 =?us-ascii?Q?qWPAUf5B7dOFStHbfl1pAujr5eVzma6IOPO9wBcQsqUdlmiUqWHsJ+VowKAH?=
 =?us-ascii?Q?g6koC4oJYUMinBBbcs7X/uhXjvK4+fJjWZXOtrKzbp1kcKOy3FRDbH+cZuML?=
 =?us-ascii?Q?AzORyhkx3aMhOeR/G3cTjyddKkUUHxL5YKJV9OcQUI07RB5fdp3aAzNBl4pw?=
 =?us-ascii?Q?NZAN7vrEPrYKflwDPixSn2nE1bkqjxq5QuLNsNeGoO9D8sfcm/kM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b1a0a2-a345-4093-a084-08def3e94764
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:33:58.5816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmcInSfvaSc6OGvl5kHw6jKZAyX80sFg4kcDWlZEsVwCcYDyzN47e5cK9iBO1BOtVQlpB1TdkbdL1cW+WjJDcSBuKV7thJpG8eLiko9PErf/VYVGdVa1jNSq7dLVepIV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11722

On Thu, Aug 06, 2026 at 04:18:49PM +0300, Adrian Hunter wrote:
> i3c_device_uevent() dereferences i3cdev->desc without holding the bus
> normal-use lock.  Since the descriptor pointer can be replaced
> concurrently, including when a uevent is generated from sysfs, this can
> result in dereferencing a stale descriptor and lead to a use-after-free.
>
> Use i3c_device_get_info() instead, which protects access to the
> descriptor with the normal-use lock.
>
> Commit 6cf7b65f7029 ("i3c: Use i3cdev->desc->info instead of calling
> i3c_device_get_info() to avoid deadlock") replaced the accessor with a
> direct descriptor dereference because i3c_device_get_info() would
> recursively acquire bus->lock during device registration.
>
> This change depends on "i3c: master: Fix recursive locking during device
> registration", which moves device registration out from under bus->lock
> and removes the possibility of that deadlock.  Without that change,
> restoring the i3c_device_get_info() call would reintroduce the deadlock.
>
> Fixes: 6cf7b65f7029 ("i3c: Use i3cdev->desc->info instead of calling i3c_device_get_info() to avoid deadlock")
> Cc: stable@vger.kernel.org # requires "i3c: master: Fix recursive locking during device registration"
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
>  drivers/i3c/master.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 2357874bb9d6..ee771ac0b203 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -316,8 +316,7 @@ static int i3c_device_uevent(const struct device *dev, struct kobj_uevent_env *e
>  	struct i3c_device_info devinfo;
>  	u16 manuf, part, ext;
>
> -	if (i3cdev->desc)
> -		devinfo = i3cdev->desc->info;
> +	i3c_device_get_info(i3cdev, &devinfo);
>  	manuf = I3C_PID_MANUF_ID(devinfo.pid);
>  	part = I3C_PID_PART_ID(devinfo.pid);
>  	ext = I3C_PID_EXTRA_INFO(devinfo.pid);
> --
> 2.53.0
>
