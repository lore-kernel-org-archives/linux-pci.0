Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010028.outbound.protection.outlook.com [52.101.84.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B5313E36;
	Thu, 18 Jun 2026 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781807282; cv=fail; b=HASszYHyfgkq1DdXRD/mrJwegvSKoFHA1PPdrhexi4Or3DKUKLrGVvoDlSyW0wnBYVA6dUUpgKSnPhruDMa0Xc27lia27mX/Q//oUYxRLdwEZxXz4tD4roe7lkdnk6UjDEDEEeZVCUbO4hyJsGArCCAIne4u0hWuEIHmZbTwYms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781807282; c=relaxed/simple;
	bh=OPeT72ChdZ0UDIZ6gsdOWwxC/W1Zpb4RWg20rdno+xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C/+8MAHjAN+gvmrpgEkDl3o80Z4K2j3dk9LzNDXTa9Ag12QQrW2fcPfao0oKEQqz9xcYPE4XcU3m0gZNwF76Y3E6rTj6MEvDjUc4jlyPXM/YvxX7dUGNjGdtLXjfBrpjROSJPwDWy7ZC7mm+lAWVVVsJg0fmdULzR2Mx5f5jQ9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IUwWQNci; arc=fail smtp.client-ip=52.101.84.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IUwWQNci"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t38IyytGeEdHYnK/lKNjG1/Vimsm69dVWq3i6a3KVtdSO+ulHEwwkcvZ5v8JRxbuVKQh1SkFAqM4uqQv+9ZhmpPJc2DBeDuJAiLmnHQFSc+5Ejn86YsTfFr1+o841dPVP3Wn5s2Iclnvh32mc2c5Fr95n8JA8ZdoB3l+XMitnWxMA4lW1rmvVih4iLDecFxPL3D4IxAWlVIzV7cv58kflKfwTd1D3Ceusil7qYjOkh+VvadQzbRFKgZXVpQPpCToBGspML3a3MtJLbp1EWGM9D5zSqqcdAi6gh3G05iYyndFZx35JvZgkBxg6bWjuT0ySZcIfFwAzfjpjEwOFw4a9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsMrI2dn7tTTdZaVpQJTLvKyKpGZvBN59tO5wuoO3rg=;
 b=ebqBUMbB0l6lVxDVbQIMTFDzKa3xmsdxbnPJ/XafANytKGqmB43Wxq69NFYWw3qul27PHAJU8GNaLYmK65kZDVyEryyAc4Ndt03vnaigilgWgN+T/1meaTO0bQMR/PvNUySSY11Xjn8jwEaJL1qfldIJhBldxHi/EIWZzWA+VLUv5Zj58Yq1Kuz0SSx2ONl9cKB2qW6/ceg6SN45s9iVbpAR4D1j7BmU7B3CYorVtjkJ+m4w8xpEqtQnYqxTYZ++jOod9NVpvffMbyDH9g0ZZCUFIDwfNLLttdb/deYeMVRMsYzhrbHyBOt5k+VNeZO6Whr0yFY0XWGiTyMZ1xm/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsMrI2dn7tTTdZaVpQJTLvKyKpGZvBN59tO5wuoO3rg=;
 b=IUwWQNciLdgZa1gCu7QRiQrlRVDZZai38cS/pYYEkbX+5+WrVNJ9r2+vhVksJiarVgBbGL8lIY4hnZzBJMDwkXY27gI3MkP87LC23MYKb3+5QSFaSH3PSpw2amc3/O9FZ0fCtxI561Omi4yFRPotnq/ldpvU7YBHViAO35VMh7DWuwXf+QfjlTroKD8AOC1bVBlTyFqZQstrwphv2G6ohDkNrvOAjlWcMmtK+obt1/3C37bmJbYVcheVprE/qxQ5QV2S/0aIfalCO9kwJnRg2rMyoXuOJ38lhvD6oq+zvJY7ejSJIeMCq/IW9iffyiVHYOPMKIHEOMUCUOKU0qQvUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB11859.eurprd04.prod.outlook.com (2603:10a6:10:61e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:27:57 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:27:57 +0000
Date: Thu, 18 Jun 2026 13:27:44 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com, marcel@holtmann.org,
	luiz.dentz@gmail.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, brgl@kernel.org, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: Re: [PATCH 3/8] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
Message-ID: <ajQ4oBUNGOrhcPX5@SMW015318>
References: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
 <20260618101047.4185497-4-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618101047.4185497-4-sherry.sun@oss.nxp.com>
X-ClientProxiedBy: SA1P222CA0137.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB11859:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a6b907-cfa9-4a85-5eb0-08decd6751eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|19092799006|366016|56012099006|11063799006|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	WuqNQ65M6z69oqiSoO2ON0JGNytZja3uF1uGMcwnnQ/lJikwG2xQyaYR0rEQHayZGrSooAfRj2Gt6qcuBVlgy++tX+aS64gKSNYRgjXJEggRfuekF38eK6k2GAjxQNRwCeZxL6oxXcb/xeiBodo2IuM9dNgQLjp1gRy9z+HQlqNCqrdkziCfm7bypXE9LONBB8/bOLodql1O2ZZZ5eA9n+KeA7cOl+GWKJlXsqK8MLE1TTTDsKvEjxbgGtE0QZ/M46bFNT+Su0+NPGL8Bx1MuDvJ1cX1O2fMBfedfHsv1uiP+ujc39Q3mzeGGtJ8mPng3AuqAHE4oFa/t6mIo2ihWiToDhGRT7s2rcLF0EEHF9WnV5WiI7zABIi9wiQWtJemIUVMKoPDNK3N42OwgUwXG1yvF0iYqgNIaeImepSKLpkQgLHpQC0eTLS+tcaC65AmsT/tRwWdtDmhbCPb4QO9VFvvjrsbQMGWx3kwEiicvYHu40TRjptg9qQvk+o14Ww4PUxORlzBUyNKmrPb1sdURX8I+SAplbnL6i0kpkzZQWMMgnRxj7aJMdeYhE5GzXdcz2ZxmQzwLnond0KdmAru2VbOf3vz+BXHa/Rg1k6bPEmL0MA53XtSSIzpJnT3PW1nJWomo8yaa/kxHeQdOViwNcehIP+vVvwnTFKZLcGS3mAX+ZLJoMJKSJsmMsahgKXs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(19092799006)(366016)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oGtI889TLc7jPjCtfk5oztb/8a8bM5HiOiY79jzzKHct1+kOWwf40yLY7d1/?=
 =?us-ascii?Q?dWdfHKRQjmqwy9LTis4X5fpsyEY8j+k/XcLDK2dex7mUWbPtGS5JIBf9ySIa?=
 =?us-ascii?Q?9zXlWMGEnkJwRNRKf5o30aqIuVvPtBhOxFHr+O6sHmj4vS5DQkDSbQe71Zjh?=
 =?us-ascii?Q?e4Hk9V53G+aeERoGCBc5wD+ymaRxyxykK0YFP2JRHE5CjyJILm5m+bmsLHGO?=
 =?us-ascii?Q?PdAtfFHQidAv4/5BAZws27tsoYo0ex6/+jPz0lOrSc0CVvT6bK9af/9PG8rz?=
 =?us-ascii?Q?fGHqkXBHhkr/X75CLF8uNexhW2SSe9gE4YjchJ7/29g+WEo6K1BfWrblVhTH?=
 =?us-ascii?Q?tqaQf6tqlimW18hrIxcFRMvhS+8UQ/C4FQ4gcrXqdIbPh1ZwvW8fQqTLAAoF?=
 =?us-ascii?Q?265wlqx3qsagf+U4W06cR1XniuaHh/8eTk0sB+YDHDVW/n4Pi4ppZ2DgLJUJ?=
 =?us-ascii?Q?V/qsL0sZRJ/Bo3jGMkOwRbpVqhqzmhzYQCcR3z8EAVMSd/3wDaVkc0h8cdL7?=
 =?us-ascii?Q?dvlYW5BLIhIaF3s8DOB5Jy9qpfZeXoq+YUIlt7YuTaIHRjyvPaocbUbE7o20?=
 =?us-ascii?Q?LaWHmJdzxJmM0VsqOIp9GG8EWDEPYtzR6Aqor7rmYmgX9zFMA6Wk0m1f2Hh2?=
 =?us-ascii?Q?NDTiiJ6Z4SUqzdeD0sT0awstGBAAQulj60iy8rJ/5k7w8BzaLmuOxSJmwrbi?=
 =?us-ascii?Q?cAChC6eqMfxPVidFGcngcq0tcVqOF7EJZ9idGRPMdC0RbA8O8iFk34sObULv?=
 =?us-ascii?Q?TillO2DH4ZkIhtaiwT9sQS4FIG8UXVfMywHmhn/HEqgwRJ9aaZgL6v+oOIWs?=
 =?us-ascii?Q?Ed8kFV3nA/JkvQRmIVc1BioHFsUIJpBpwWPqeNnEDBTC4o2HH6JcX3KvGIY0?=
 =?us-ascii?Q?Q02pquE3umb7gBZ8BZI6JoBxLvI9yy51gPCIhGmSyYGFRRNAhj2KApVJlw5f?=
 =?us-ascii?Q?e3DvsFabJpOm8nT3pgmKJWJVEuvfOPJj1QgYfzsC8Kj2krcBH+n4Gr/Elztg?=
 =?us-ascii?Q?ijiYNYWtlgVeQjOC8nOuwse+zj0fEjW15GI2KgMJhKT2/qy7arusTHSqgJBk?=
 =?us-ascii?Q?KzcbKPEgvg5ky2aRe8DpDE/ZswdXfDxFEaBqERWBNGu52fOZOcrebhZ4Odsp?=
 =?us-ascii?Q?h1Z0Cr38Hm0AaFyoGk4qBddNmhM/+EqT+gShYRawND91lcYWDPn833Hgt5SW?=
 =?us-ascii?Q?dlmXwR3rE85CRc3qYgJ59/A+O5xrV/zz8J0a3qOHkjPVZP6U0kGSs/fxAUxv?=
 =?us-ascii?Q?5T5lrNwvk+bQs/R+Co7PuFj2KG1WKZU4O8wszB4XvzPVhQEIXUWJ4WhaQnST?=
 =?us-ascii?Q?bsERPVSuURNAgDWkRo2cTWUR2UHC+axgxM2YxMYAPZe9Q8ZVtI1w/wbBoMcJ?=
 =?us-ascii?Q?d7MdLEfsReZugUTw0I4A04im1DHRvilirC2J8q4I/Xp6yscPprv3MYnyf3cZ?=
 =?us-ascii?Q?NKmVr4MUvQqEKAWgoehUbPn3t3ivePm+SOw2CTQ/AMeWzinuWq6YQ2ax/Qb6?=
 =?us-ascii?Q?VyVtuaVfWIpR29P54JtTaVasLVpZD8SXaXEwB+aLgpEWOKuGP+bQyiGsX+Wj?=
 =?us-ascii?Q?+Cdr+mDWL6T1JEtQqIxQneESXpIpw1jzODdp2LZQKmgAjyISSs+KMJZtJ0gr?=
 =?us-ascii?Q?8N4bdsDPZZpvz4wgTZrf3hg14Uv60uflqcBZDgGhu+AvqGafOkvpoAdUH75z?=
 =?us-ascii?Q?jLrh3d8HFphbQkIvRy05mvvQ46sejjhy0AhmFRq/1NL9LLF8MUJGP1NgLfeo?=
 =?us-ascii?Q?cXxDJ3vRogKFTSlK6iAQDx3zVzKVMHJQvLDpgrP/XzcH9qyURZq5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a6b907-cfa9-4a85-5eb0-08decd6751eb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:27:57.5710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ono+KRcGbyaDN11y6gYwQM5EnVjQvZcwQgqWCxCRRDixzCObl6aE2CHCfJJhrCTorTURtiNPPd36vmCY1CibRmviXISEAxEObvIQ28URZHzrlS6Uut5OrVNyFcu84M9u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11859

On Thu, Jun 18, 2026 at 06:10:42PM +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
>
> Power supply to the M.2 Bluetooth device attached to the host using M.2
> connector is controlled using the 'uart' pwrseq device. So add support for
> getting the pwrseq device if the OF graph link is present. Once obtained,
> the existing pwrseq APIs can be used to control the power supplies of the
> M.2 card.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/bluetooth/btnxpuart.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index e7036a48ce48..1aa8972f0dab 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -9,6 +9,8 @@
>
>  #include <linux/serdev.h>
>  #include <linux/of.h>
> +#include <linux/of_graph.h>
> +#include <linux/pwrseq/consumer.h>
>  #include <linux/skbuff.h>
>  #include <linux/unaligned.h>
>  #include <linux/firmware.h>
> @@ -211,6 +213,7 @@ struct btnxpuart_dev {
>
>  	struct ps_data psdata;
>  	struct btnxpuart_data *nxp_data;
> +	struct pwrseq_desc *pwrseq;
>  	struct reset_control *pdn;
>  	struct hci_uart hu;
>  };
> @@ -1866,11 +1869,27 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>  		return err;
>  	}
>
> +	if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> +		struct pwrseq_desc *pwrseq;
> +
> +		pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
> +		if (IS_ERR(pwrseq))
> +			return PTR_ERR(pwrseq);
> +
> +		nxpdev->pwrseq = pwrseq;
> +		err = pwrseq_power_on(pwrseq);
> +		if (err) {
> +			dev_err(&serdev->dev, "Failed to power on pwrseq\n");
> +			return err;
> +		}

Can you provide helper function like devm clk get and enabled?
like devm_pwrsq_get_on()

So simple below error handle.

Frank

> +	}
> +
>  	/* Initialize and register HCI device */
>  	hdev = hci_alloc_dev();
>  	if (!hdev) {
>  		dev_err(&serdev->dev, "Can't allocate HCI device\n");
> -		return -ENOMEM;
> +		err = -ENOMEM;
> +		goto err_pwrseq_power_off;
>  	}
>
>  	reset_control_deassert(nxpdev->pdn);
> @@ -1903,11 +1922,14 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>
>  	if (hci_register_dev(hdev) < 0) {
>  		dev_err(&serdev->dev, "Can't register HCI device\n");
> +		err = -ENODEV;
>  		goto probe_fail;
>  	}
>
> -	if (ps_setup(hdev))
> +	if (ps_setup(hdev)) {
> +		err = -ENODEV;
>  		goto probe_fail;
> +	}
>
>  	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr,
>  			   nxp_coredump_notify);
> @@ -1917,7 +1939,10 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>  probe_fail:
>  	reset_control_assert(nxpdev->pdn);
>  	hci_free_dev(hdev);
> -	return -ENODEV;
> +err_pwrseq_power_off:
> +	if (nxpdev->pwrseq)
> +		pwrseq_power_off(nxpdev->pwrseq);
> +	return err;
>  }
>
>  static void nxp_serdev_remove(struct serdev_device *serdev)
> @@ -1944,6 +1969,8 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
>  	ps_cleanup(nxpdev);
>  	hci_unregister_dev(hdev);
>  	reset_control_assert(nxpdev->pdn);
> +	if (nxpdev->pwrseq)
> +		pwrseq_power_off(nxpdev->pwrseq);
>  	hci_free_dev(hdev);
>  }
>
> --
> 2.50.1
>
>
