Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C863AFD07
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268630; cv=fail; b=csylGNt07Ai6JfAEDG9toGh7CgOdZir5H3sqxTZs9uOvMS+hU94AmKkG03I/0HWY52DnPp8hOJvJAEocJaru6xPluc3VRL3DLWZhp+RTaCkAD++1mc2j9ZV8WFw7sVq9bROCP1rQjDa9RNcLcqfhC9JfFofT8JzoBi0gPPwZTho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268630; c=relaxed/simple;
	bh=MwS0KUFRFoov4yHvGkpTGbWCnVTHuijWdPLWb3Pz84U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TKBnODYfrmcmXYRt2+Ot+4wL3XePo2PtR43jv21e9TTw2Gc+xjFtf2glY3Za/17s5cG9sVHlH0fiAi9DrH9CIDa+NOl/y76xGpx8OCZ/6anbrizgc4ZsroQKa7rZfe92edYkXM4hhwz+uKXuPiW1cdq6t7VL0Jorb8x2ZlRKjzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bIN/PSW2 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bIN/PSW2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CE/vsYn0NCCe2PhZoxOMjQEnV2Va2qjgOqsrJq1bYiabuQLMsDZX2Ezm3E73LB1z5wWgerSry7fK2eJl+M1DIeC7n5/3LNeVfHMNfbRQ+Q7WNlZozk3KQq0rePY9qXrZIQhLWrvziZ5GZySfsBqpqKjra7H3rfn4uodkQsQ+Pq3NYnqzzUlkuOOCeNlXjNTdD3NQ+LdLK7vsdOCJ/SpWahMbrKfc3Ufrd1i1BZEp44HTmFmdfPxynMwMQAPMHNTQKfH5TZD/xF3ceh3Rfd5UbcnFTgUFJwQnz0Gyi3w3hJUBXvWKqeVGtzjRPWmTTjDHNIzR4yaIA+ycRROpD7+Mug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI+SxcU/O46SWTckIDDV3aH7vdDki50aoCxaNopqIyg=;
 b=TvFo8DHIauVLjebZYeyRQvbaSuqwCmqwUGN905nYqcZlChqbuKIOOybkMPRtja+HsvUttph0HrDvZOrDaQd4vAajJsTbHRnl9dMh40FQBCLmdb1XlRYrSHixzRyidj7GDwyHJmYrmu6eCp4P0ZEqoWHRa2m/D2K8/wRWqeV1QUnojKG3MJon9WDMK+6pZwkjExaHHI60fM4kg+rdLSLjOOp5+xJC75iqY5McYa3rn6oAnj+kuIgUzfxIussH8mqhMzJtmu2DpOA/A0V+IFCSs87iUIBeSd5xalmQi2fBNi9SnbJ8CPZyWPgGv9JSK7yizL3L00TskGOWZajHvTnn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI+SxcU/O46SWTckIDDV3aH7vdDki50aoCxaNopqIyg=;
 b=bIN/PSW2tlY/P1ArhAe6QuDscXOszYXxkYJtHtUVfqHQnQMWyIMaksiO6WzGUtnwiy+hYMVh/ZjQnbc1UMO3uwj4phuA1AcAukqo8EVEIqVBgHq3CXpU0cr1/GwhmhjFVZLz6NAzb9w5w7wPcne+OMdZU9AEEXUKzdlqw4+4w5Q1hQXZOvOF0J33FNDn7SCMcd66JoUkCVMEzwJ7f3pJLkwMKwTZjWMjMf73shsl4H938IxSHVKoQIQZdTGHMc0YSs8LKRc6GOUg+dOq8Scpgb9MGba6nWje8g+jvZqRKE+595j64q4SYKGltDf5/WmjOIXQeSKrp7/HbVBUClu2JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DUZPR04MB9745.eurprd04.prod.outlook.com (2603:10a6:10:4e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 19:57:05 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 19:57:05 +0000
Date: Tue, 28 Jul 2026 15:56:59 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Adrian Hunter <adrian.hunter@intel.com>, Frank.Li@kernel.org,
	linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH V2 1/8] i3c: master: Fix recursive locking during device
 registration
Message-ID: <amkJi8010zem-2O9@lizhi-Precision-Tower-5810>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-2-adrian.hunter@intel.com>
 <20260728161935.C236F1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728161935.C236F1F00A3A@smtp.kernel.org>
X-ClientProxiedBy: SN7PR04CA0161.namprd04.prod.outlook.com
 (2603:10b6:806:125::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DUZPR04MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 964134e8-fdb9-4486-f02b-08deece26617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|1800799024|366016|6133799003|18002099003|22082099003|5023799004|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	vdAJR3LFNmqn32PdfjPcK++RH5qrNq9DlZSSDcEkUYguG87bP9wSdclMPKzsFIsB14utYrOm4BE7OyAnQc7Gqz3TKqVHxBsXzoFK4Y0J+UMoIq1/Yo7AFNxL7pp5xjS4xvBylMakx7HfEON0By+OTca7A/MCJqT5uTmVZWP+L5PZMcwUi5FQyFoHQeAPlN4dcUa9lV1RaUcQLToNyOyQikVd1Nlx5hSTEyMyS8h7twtPGyv1kKRaYURieBSItXgnj0U4K4ARx9PKiMwF/67ttcvx66IwymT42SXnWBptrKNI3eOgQA/ZnxNP+23ONiXXxPRWWntSBzEIWFWwiLKO5MA5w4POPcc859XTb+ZqPIBfdqCGMEPEitbDiX0qsnIxuQAzrv6ZOkj3EYUV+YDEpFQVaLaifjw5VixcV/YGv6CS4YEYuInaZdZY+ep91Ec4IZa+DEqlPAkweZPvfUoh85wkq7e51r26Xota7ULu+ouxLEQublsZ9E99Efnsv3PDye2pGjvt+BxSKGguszma44MdeA2oMZuKwCoo97e0gyNZg8rNzYmL4LEiv2pOFub8FUA5VA/wWbolL/D3KzPFbAerFoqBdGCrmDnhpi7tt88=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(5023799004)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?rkFOT39ihcpycXYFKhHdMhr5FabNOLxcXU5U2FRz3zCZV/0JJzGTOnIjlc?=
 =?iso-8859-1?Q?ENUlqJr6FSlzRqcGDS/0mSXB20UYG0GeT+Sz5gEqmuaU1Rtl54pOOcWQbv?=
 =?iso-8859-1?Q?d/doDSEtCgsop39kQQajdQsfPnhoHL6S9EhUZrQVcX6QIk7qH0AQbv7YFR?=
 =?iso-8859-1?Q?KSLn1DxZUIzpindKGiXYY2+QiVLaPpcisIaw7M6KyFwCRGj/ZdtwF8ig0U?=
 =?iso-8859-1?Q?DPPx8t8R0CmXlR2IS1c38KFKXGlKv4B3yTuDoRIPoi+k1xLiObvpbZPsQl?=
 =?iso-8859-1?Q?CBG2HXC3kqO3sqTApW15KJW1eKdC5+yv86yeP24Sq/ZVkgxw8Xu6GDFMGL?=
 =?iso-8859-1?Q?88pGrd9d9Y9uJbcYSzVJDmZUDr14DaSlmiSdHtI8nWCk3npsyaY8rxL10i?=
 =?iso-8859-1?Q?yXVWYGxt2tKI7ARO5fkUYdsuTkOmHyjy3+5Dral1tsdjWjSRFq1x3WAIqK?=
 =?iso-8859-1?Q?tDpTXDLP27DYYvoLqqpwt/cDN1PczdO1MVLg5Ge5rmJzQrN85KrfTNwBHZ?=
 =?iso-8859-1?Q?Rwrs4DRgXtl6nBrDS+7qAjDC6oZpECfMAugYmvtjTB2ZeX1D2bZ8xbcHX2?=
 =?iso-8859-1?Q?RSX7z9lXI6+So9DcOwaLfMfKiRp7aVkbZvhYlMCjFoQonC/67cr5mnNj/L?=
 =?iso-8859-1?Q?iF8U7bytwHYG+KDR5nnpec9bWdyt2s5hY2fJHFav/N9iuMVO6G8QeMuF0K?=
 =?iso-8859-1?Q?WSDF5ru0DFhm+o2/le72VdvNEQsaJFHvjybRt2zwcbjrXXgsv5wcDYopgE?=
 =?iso-8859-1?Q?6C2WJMfpcvexhhRGXynxe39fjVKP3vevP/179WKhaqT2WzrZJN0wWO/tAr?=
 =?iso-8859-1?Q?TYCYKzzGquVuozdYXrzdiKap5jd+fynbbK+nMfE5sAQRn7N3OB1qUHzTMd?=
 =?iso-8859-1?Q?HvyKHVB3E+fL3c+aw50CF/C8hkIwYfZVLi1gwieiNGGTTCc8DUjEv2U9yz?=
 =?iso-8859-1?Q?mweGf1Ms+S5dN1LPRBYKxF7haqyfY0mK15bS521SCWS6OZqFkwOHgoZ20Z?=
 =?iso-8859-1?Q?tAzzJ9vRok99hAc/CIflrKsH5uABPpSctwXBhwK5sKU2X7XhYLGTyO0f7d?=
 =?iso-8859-1?Q?Ork5qLmLPfcOTxapltCtqi2oDQWQJ85scq8CrV0pqeCFDAg7qLH3ObwP4d?=
 =?iso-8859-1?Q?NhJ6hoNiG0N+4q4ZH8cEy6rQlHt3XHqETRTSps9TTlOBJjf8pKKG0D8DFx?=
 =?iso-8859-1?Q?8Rtw67q90bapHbmXsMFbG8XJPeOSEv0gXlEzW0dxdvbSOYdmjZREUjuud3?=
 =?iso-8859-1?Q?HWlvlLtARuCdYSr3FnmRo5SidFgDajmKZ631q32iaxJA0thnZ3zZ95xiPa?=
 =?iso-8859-1?Q?XZS7wgzjPuHuAuM/dggmte3ewUWeifRZ3bgTsH2oO1O+1EdOWdpDYCKLdP?=
 =?iso-8859-1?Q?ogW2jkBIub6EPPerAGJA/GfY2lkaGM/A88cWMb8LNI42rtOdWjrSsnsImJ?=
 =?iso-8859-1?Q?slpPYa1Q+9GNYPHax5yhazXbGpmBP7588UaVeMI967WiL7T4/7VIPNyQGT?=
 =?iso-8859-1?Q?FxeW30mc3LJSSEHG1xHiHtEwEsMxmvUfAo20w7tuPER73kt/Pn68gG/+5a?=
 =?iso-8859-1?Q?COnY8wlmu5TZ0rgcJ4VUKbqsP0CufWiIrkAhUk8ayojaTYCx9U/9xx8g7N?=
 =?iso-8859-1?Q?b+DUHSb9NpxyUiv4xAOUEHfMDv+fttBLmBurGFbtjT98OySPTZEJufizQp?=
 =?iso-8859-1?Q?g1dkHwRqrm+/zTLPbq9CMXH9jfz8nCTvyDp6TlQuXZ3cPOSLYb14iNu1wi?=
 =?iso-8859-1?Q?GrwKzYr69UhE5S6/kNRBpo2L3n1sC+73aTOfC0LY4/tkFmzl7jFKMQEY6G?=
 =?iso-8859-1?Q?BAcbz8WlzeyGUhuRjp394WuNORkKs6ScJVSoc2tGNYnW1kHZqqvZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964134e8-fdb9-4486-f02b-08deece26617
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 19:57:05.5650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOfjPay7mJyg2NyvrTo+JgwPSddcZosuKOZ/g+wqMRkhEX853Igfh2PeSOm4HoAneKkbXA36UrAklbTUJOtk3XBFMNloSxi3mtke4ZTiTye0NLN3Z6l9Yw+tSwx21FDT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9745

On Tue, Jul 28, 2026 at 04:19:35PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Dropping the bus maintenance lock around device_register() exposes i3c_device_uevent() and driver probe functions to a Use-After-Free if a concurrent DAA replaces the device.
>
> Pre-existing issues:
> - [High] i3c_device_uevent() leaks uninitialized stack memory to userspace when i3cdev->desc is NULL.
> --
>
> --- Patch [1]: [PATCH V2 1/8] i3c: master: Fix recursive locking during device registration ---
> commit 33a4dcd6c5626faef95bc7cd02ec4c56c6710c78
> Author: Adrian Hunter <adrian.hunter@intel.com>
>
> i3c: master: Fix recursive locking during device registration
>
> This commit separates device creation from registration to fix a recursive
> locking issue. It drops the bus maintenance lock around device_register()
> to prevent deadlocks when probe callbacks invoke I3C helpers.
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index fd3e79d10c840..874f6e11b296d 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> [ ... ]
> > @@ -1999,25 +2008,37 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
> >  		if (desc->boardinfo)
> >  			desc->dev->dev.of_node = desc->boardinfo->of_node;
> >
> > -		ret = device_register(&desc->dev->dev);
> > -		if (ret) {
> > -			dev_err(&master->dev,
> > -				"Failed to add I3C device (err = %d)\n", ret);
> > -			desc->dev->desc = NULL;
> > -			put_device(&desc->dev->dev);
> > -			desc->dev = NULL;
> > -		}
> > +		list_add_tail(&desc->dev->node, &i3c_unreg_devs);
> > +	}
> > +
> > +	i3c_bus_maintenance_unlock(&master->bus);
> > +
> > +	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
> > +		ret = device_register(&i3cdev->dev);
>
> [Severity: High]
> Does dropping the maintenance lock around device_register() expose
> i3c_device_uevent() and driver probes to a use-after-free?

look like make sense.

Frank

>
> If a concurrent I3C hot-join event or a sysfs write to do_daa occurs while
> device_register() is running without the lock,
> __i3c_master_add_i3c_dev_locked() could find a duplicate PID:
>
> __i3c_master_add_i3c_dev_locked() {
>         olddev = i3c_master_search_i3c_dev_duplicate(newdev);
>         if (olddev) {
>                 newdev->dev = olddev->dev;
>                 if (newdev->dev)
>                         newdev->dev->desc = newdev;
>                 ...
>                 i3c_master_detach_i3c_dev(olddev);
>                 i3c_master_free_i3c_dev(olddev);
>         }
> }
>
> Meanwhile, device_register() triggers a KOBJ_ADD uevent. i3c_device_uevent()
> reads i3cdev->desc locklessly:
>
> i3c_device_uevent() {
>         if (i3cdev->desc)
>                 devinfo = i3cdev->desc->info;
> }
>
> Could this lead to i3c_device_uevent() or driver probe functions dereferencing
> the old descriptor while it is being freed?
>
> > +		if (ret)
> > +			dev_err(&master->dev, "Failed to add I3C device (err = %d)\n", ret);
> > +		else
> > +			list_del_init(&i3cdev->node);
> > +	}
> > +
> > +	i3c_bus_maintenance_lock(&master->bus);
> > +
> > +	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
> > +		list_del(&i3cdev->node);
> > +		desc = i3cdev->desc;
> > +		i3cdev->desc = NULL;
>
> [Severity: High]
> This is a pre-existing issue, but does setting i3cdev->desc to NULL before
> unregistration or cleanup lead to leaking uninitialized stack memory in
> i3c_device_uevent()?
>
> When a device is unregistered (or if registration fails and triggers a uevent),
> i3cdev->desc is set to NULL. This bypasses the initialization of devinfo
> in i3c_device_uevent():
>
> i3c_device_uevent() {
>         struct i3c_device_info devinfo;
>         u16 manuf, part, ext;
>
>         if (i3cdev->desc)
>                 devinfo = i3cdev->desc->info;
>
>         manuf = I3C_PID_MANUF_ID(devinfo.pid);
>         ...
>         return add_uevent_var(env, "MODALIAS=i3c:dcr%02Xmanuf%04X",
>                               devinfo.dcr, manuf);
> }
>
> Since devinfo is uninitialized on the stack when desc is NULL, could this
> broadcast uninitialized kernel stack data to userspace processes listening
> to netlink uevents?
>
> > +		put_device(&i3cdev->dev);
> > +		desc->dev = NULL;
> >  	}
> > +
> > +	i3c_bus_maintenance_unlock(&master->bus);
> >  }
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260728155308.142713-1-adrian.hunter@intel.com?part=1
