Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B84749FA;
	Mon, 14 Sep 2026 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400547; cv=fail; b=imfGJG5j0/tbQGogl2AVvDcfAG4B4pY/MxVx+YvPXiinJafw8/YB2d03j8/HBXmi4LaRbnUayxtHeIH4OqURuuMTQ2xSAI5NgcWOjdxJs/gqdqdflA69fXTGO83uTIclQyziYgepWYnPrxn9MEpWYJM3JlD4jtFrmZlNshW4nug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400547; c=relaxed/simple;
	bh=ughnMlFCDzaRARnthYSF9qYwG/2g50WUYqnvWnWsZWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C22SxWdBD0zHEqGK4t4+dVtnwu0PhZS2VAwWqGtPd01juUIx4xNeIfX+PPNPGzOZL0arcZv+3kov2RQTv7hy9+hHmqHQVTAN2V/VdhxcInwDl3TjFJi/tFVZsivzMyefhBHfAma9Bk3T3ag0L8gH4ABKLg6788beX1EHHFb/1as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mOtIANWl; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mOtIANWl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lC5tyIDUCsWOInwTXueKyU9K8/LOpUp9Tznz0Q1MScHF8NJKXxPJ0zhUG78Q2S1AfkRP/KiepwcvVcGTgSsbrxEQD/kaQMSKcQQ1IrpCD9XDAYWha2JhbA6dfmf9g5EXIYAhUn1Yw/oxHrWWj45m+p8m4x/d5IcW/CCiF6IF7klWnMy7BedNzoqaw5e6fD0YAk3x3gl7YHO3gOTFa+fdj051hUAbsN9H48xcbPuMKSi+Ip/MV6vyyjnFhKsfWX9E4oIqHeQWmoDjo/0XV2HA7ORc3giF8pcORexdMEBiH9IX28fzjCu2gO/M/kBkRB0X2L3dn84bZJ0L6KQQ7uwpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhpHElnyuVn+gzaCkMPHC69Sx1Tqfy+H5/z2A6+mefM=;
 b=QU5mkuMyAXEI8rW7p1TLvxW6sTm5b5eVIc742/088arg9Ku/dx5hX235PVz2wq5ajDoWXsr+zgnGB9v0Lb+fg7ULhY/CEtjwKAx/NDzAr2OFd1u1AMQSH98GQ+wNjmjnhmAkA/4hRmQc1O2OQ6pJYkgYkf0JWnp5Hl4uYpBz/HZNEM6WylhQrEtTQHJFT66Eo8oL7fJ9j2cglH7tx0PwS51akFBjVw2cX8UwluRvU8BxmRu+gibOKSsklVgFy4gPwyiZK+MCz4bAzzR+0vvXjhcj5v8el8BlWD1xt77/tzBq/6fIqYfITbKw4oBvIYUb9OLeC+aos1nB4XhuV9tDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhpHElnyuVn+gzaCkMPHC69Sx1Tqfy+H5/z2A6+mefM=;
 b=mOtIANWljNK16GBYivOuKvq23zgjpv/qm1qj+dX2DxGi+KmvymJafevnNb8Js6G8X7Xne7B1tesJdASB1TJPQeoQrQhJfyDNprjez2qyTmN6j3H7f3NGJSsMY5Wx5TTdZsbLJG8R2dKW44vPkOtxRz4f6AOga6b/CiaKO+c4oj2qqzPiPqOrS/TdAqiLgE26n7G60Ro02loW8MCwvHvvuX+99yIwf9Rk8siJcUmZ8Kt23dppO6ADkLMo5HzCwPvKyaPytmXszN4Q82RakcIzhmuQuhiXO8A4tyBMoRr/imxD0T7AMt+XRABT4GW8esDATuOeT+0qQ38Ts6h7lifisg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10225.eurprd04.prod.outlook.com (2603:10a6:102:467::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:42:22 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:42:22 +0000
Date: Mon, 14 Sep 2026 10:42:12 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] PCI: endpoint: pci-epf-vntb: Serialize virtual
 PCI bus scan
Message-ID: <aqgV1OZY2fd0_fgx@SMW015318>
References: <20260901063238.631166-1-den@valinux.co.jp>
 <20260901063238.631166-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901063238.631166-2-den@valinux.co.jp>
X-ClientProxiedBy: CY5PR15CA0173.namprd15.prod.outlook.com
 (2603:10b6:930:81::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10225:EE_
X-MS-Office365-Filtering-Correlation-Id: 678f22f3-718e-4b63-1cc3-08df1276c440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|19092799006|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	YTdMYrvr0oaFdVCFHe3eRZ6YOmqkR7c6PMwusgXmVirxQo82D3885ZvwSz3VqS6hY0GotGlhOvwka0cAD53zujdw2lKA/RRQ5YDajJ91kyUCGEUAsD49zy2agxr4yJNzMK7CMFt0dOTsJ/7yZvwF/E5ciAEJVg2RahtELH+aQpTH/rF25Vp6q5p89D+251RbKB1RgXQdzC7PjdCIcgz63iOni1hE1H1na2+cFIQpMghRgZ70x0aaouFhKeOGE1ZZUpB5DcieCUu4DJNMJWkxsoHXFAP9WDLaroXN8l3BHT8fyDH4XzmqX2ahUvPJwfASmtuiVPjeDIycSbu7ja/qwLwatbckhDT25QbpVUTQm5DHJ+8Tq3V9qErviGtlhGzmDtO+hD26gheFZ1tZOwjRWYq4GLFIxDb6W+fA4ottnPS7+0VyE4N7zJNPybUKXoqlkTyaqNd9IhZG9w4ZTbu+hP8a+MJ5loARYEBry5AqINmS7C3w3dvVu0gbSplH9Vg4AJI4ViqbcFI8TkKLtqb+X3gSxXTXcDxs+LofNvw7bJEnRZ63SkBoEMQRgeyXhMVZcws+N5hf1pbAoMWYiSpsjypZxQg+RYNBAtTXYLBJ0tzXpqER25QEpkoKXAGtK0Z8NvVkm09NbrssUN4EnVUbQfjPIngShVTPJaYgWKjcrUE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(19092799006)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KlJewPUZXrDKi2n/dFmNITLzC9jST5KyH7UUa1bRu6ESmYyZlK2c60VLlEBf?=
 =?us-ascii?Q?Xdyn5nDaPooa2MRGwalIzNqcNY68+FMZun1JbukZecbaAz/xPP31Df+wYiOX?=
 =?us-ascii?Q?nLEymf6FyOjCeEa13T7i3eiRVHz0Lk2v3SO2zwKI2t1CcxWch2LyBFITNrlh?=
 =?us-ascii?Q?VP3w9i+W2mIOFnRX25pUymcMPs7Iwpv2jJwr27DOXepRx5n3zJM9ajHOfF9m?=
 =?us-ascii?Q?S7YDXnDbW1HQi7RZZZxPg3OQt+zAbfazKQtD3cJAy/V1Jqj40vbx/umBabKd?=
 =?us-ascii?Q?qTmVVbL5T2GQQJV6jWHmwQZ2wy0KnfqwYvvN/B2t+hEww1Q8k7i0xMAZpcrw?=
 =?us-ascii?Q?WfyyNO8dDAshw0ajPIN/FkH+WVAwr6hJdObAzPIAp8TvdQ+u52jO2HdyDnYC?=
 =?us-ascii?Q?/6NXRt+R3YgdIHmrm/mXOUAA/N5uUozJroXLe2TxhGBPOih2uxX/zwR7vg0R?=
 =?us-ascii?Q?r6JBczsjn7+7OHUktCwEf6iCjtIQxUpRnQWy/0W+H3twbstPbM4nb+lgZWya?=
 =?us-ascii?Q?XHBPIN8uWtGwVj2bN5pbzzjNtpD7xELaIAVqMC84jtcgAyAhyGhMfJk1khAU?=
 =?us-ascii?Q?UcSy1p6LOW4V4x9CzpC3OPSMY9zLhBwEZZ9Tuy2LQ+Asw2VP6sJbTNEmGJZL?=
 =?us-ascii?Q?pQepWPbbvYPDYXa+OdQAwP3Fr3B5ILYcrmopWyydbE26fdQiS5KvfeeFOdxf?=
 =?us-ascii?Q?JBvZpXuQk3XDFNBZr5LChMWndaJcG3JlN+HgELA6E0P5IWSdKTwd72fDVENu?=
 =?us-ascii?Q?I+dNNPVGxzrg7aKPK3aqPH8/wTFgSf9CBA8lghJPFFK59AkHkthgqst/6C47?=
 =?us-ascii?Q?hEp7pGajYc+7tVi4f62t/w2sqo3mo1SpYc9AOfULrFU/IxUL68fLXxbP/LgQ?=
 =?us-ascii?Q?5bbm9clrX+VAgJvDzPdEM0B9WhJhezYLGSEinktnPL8qi0hH+jWuY0dnNbY7?=
 =?us-ascii?Q?eg5OdzmOaxR2JiBzaQJ9pIyxY90oaTi/bHgR4480xyToMN1jTPReysQxxwGl?=
 =?us-ascii?Q?GDNZZVzphB/Dr/PMPNRiwYEC2+9iZqh2GaiphEcekTRy83zWlWNW4NCFv+1e?=
 =?us-ascii?Q?tWCqaqg1y09GKcURZgfbvTv2rq0LQReSmBWu1wJo5/csH7/XS2CHeqTPi2gl?=
 =?us-ascii?Q?z/x5UwS6xZlvMgoI3XV5OTRNuQf8ojb8efX63MAHD80m6AKGk/4lZjy0vr1C?=
 =?us-ascii?Q?rSVUHYYOMUqAq8phaL/Zv8e/rivms4xsP8FC1E25JCZs3VnS+AvsNyTw3agx?=
 =?us-ascii?Q?DYRba0Ee25/oKSRA8Lc7kBdCUdrmIMSqag/Zq2w7xUlmvq0yLhOqkqFnGbuk?=
 =?us-ascii?Q?wyTAnWUs9mXco0qdars5z6a7NwiLaV7g4S4ConbB87bwjF0Bb8ziMeoqt1MS?=
 =?us-ascii?Q?TpeC1iZL73mOwmcR6+CAZelsMWOYk7kvSMUpjZQPfLdL8rvhCpjeWk0hMs7R?=
 =?us-ascii?Q?ZuIa7BmG47i5hs04nzL+CDVO8rxD3TlmMBbgh/EGotku+hMLDqVrz6J+DaRH?=
 =?us-ascii?Q?FUaUSpJeGEenmgQFHVsX6tj6GsAfj9Lv55i439ivOrLpfhzY02S6mBnwaZuW?=
 =?us-ascii?Q?elJyyOrsdHZe3MLbq8jgTKnDen+h33PLVGdaZSUUtj+dMh3aGaWmxAhBGvDV?=
 =?us-ascii?Q?IL8mtBTzS73k+62PQf70v/HoinQFaQ/0Shh5uE4Lrqe+YjBU5iUQpYeoLIyZ?=
 =?us-ascii?Q?XGUhOit7E1NAXBzFzB/Lhq5h7o/g+PYAx22fwPBs8zpzgQ1WIhOMnF2PMnLu?=
 =?us-ascii?Q?8OEq5Bj3bBSNjqt3WcsuSllOHnjYZaUpvoZ0bMia2QAu8bJdY+wB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678f22f3-718e-4b63-1cc3-08df1276c440
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:42:22.0943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPGWMaPS8uvS8eOBKHqFnHBTKB2K2pp0FVQJaFJzjzlJVTO7jzO21gV8ws/rJBmTmiB6YzObd/FICt1FC7ztfEjPVHW9zoCGSIlO7w7WaXD1RbKQJ4MFVf3bV5G4HitF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10225

On Tue, Sep 01, 2026 at 03:32:37PM +0900, Koichiro Den wrote:
> The virtual PCI bus is scanned without holding the PCI rescan/remove
> lock. This can race with other PCI topology changes.
>
> Hold the lock across the bus scan and device addition.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Link: https://lore.kernel.org/r/3tgrcel5fl55ulf3zjya4fkz4t2ms7iwwjif5rnzn2rafsydd6@i4e5etm7uqvz/
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v6:
>   - New patch based on Mani's review of v5 patch 4.
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index c3caec927d74..412e8cc6fb1d 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1332,14 +1332,19 @@ static int vpci_scan_bus(void *sysdata)
>  	struct pci_bus *vpci_bus;
>  	struct epf_ntb *ndev = sysdata;
>
> +	pci_lock_rescan_remove();
> +
>  	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
>  	if (!vpci_bus) {
>  		pr_err("create pci bus failed\n");
> +		pci_unlock_rescan_remove();
>  		return -EINVAL;
>  	}
>
>  	pci_bus_add_devices(vpci_bus);
>
> +	pci_unlock_rescan_remove();
> +
>  	return 0;
>  }
>
> --
> 2.51.0
>
