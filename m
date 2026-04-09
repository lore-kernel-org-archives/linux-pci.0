Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013023.outbound.protection.outlook.com [52.101.72.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD18462;
	Thu,  9 Apr 2026 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775706160; cv=fail; b=c+070J8A+Sc8W7KWsCZDouajYHiF6dYvUyRM3aROQoRWs1zfDE20bzY5jAFVq7+FvEzebIsVWlgX4uHLWcMqpo8kN+CBLbUYu1ikPMv+FGSrRU6WRSER+wevgcE+RZzjNkq/L2vFnzazdcR+XS134ref/y2lU5KIYN+tQRSwhA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775706160; c=relaxed/simple;
	bh=p/YZh9TPKC8cpSMRXE77P98XacZiUBwrXXjK59rfc5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=REcN2hOcB9NmXf6vTWG/ALj5+UURWnXpa410LO/Ff+m6bgddx2bI9FMhGk97xL9w+IYGjIXhCsP7nDMBn1Jsa7E7hnuvIPA9jX3wS+9lctMMKTLZbS/WWY/Ea3sdDKp63khZjyHw0hSUE0pDu2DHu0FITtmUqCGHKQUalfpDCxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h7NyO0S4; arc=fail smtp.client-ip=52.101.72.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h7NyO0S4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJ2hD63B+UypW/gZlW7QKj5rFaSELfJ+0muf1LCPwFUhdY/wDWQqOHaXP5zhPmQmUALp/zUTNMttgu8J8SuCgGonjSO/DLuAT5wgZ2FuVhEqIdZpREbZPYpL33otKA1L9/0Gxd2uks3F8yZEp7urFwOx154D2B63PmdL0a8oczAIUut0nyoFv1sX++wJT6larw/RMirN5oi5R483lLHoXwM5XK43RHsD/dKXFmbtAdvepHV4M2PCc8ypAo93oXvz0nheEVuK6zMWrcZxI52Jg5CLBC641yfmPzQGC8a2dnR3h9LkL85BEcgYkrtxb+3djcwtVS3l2ADbWUON3gHETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6EwSW+j87gVLmyo/1WGmBEXDxw6e3us+9LCSR2pdHs=;
 b=eMXj6pm44H9RU88ESmcXP7vVS+diCcXeiqPIdPpNeDK5sknkom8/urBIo/ipbGh0tiDOvdv7LRWhZT3GvAmqenvPcvJjKvit8DMQhHRLXQf57PUNGbPL5CWBMNJYgjKc1N+T88Qdi/5b2MSqrf/7iIQ7qx4s9VNyDITuCE6pZWE/DDq1UVn4jcQ9PueRhpmKBTf5uSBssjCpw6gUV829G5YQfVGhZfI540IOfhWQYzfgd206o8gDnhiUSOVPN8d9wyDIdBLVeVD6P1PJLC/9oiew98vuePK0iJpXQaL7baHp15q8t1aA4SRS6k6Vl2Ik/B7XPcC+1ZrR2/OpxU+GCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6EwSW+j87gVLmyo/1WGmBEXDxw6e3us+9LCSR2pdHs=;
 b=h7NyO0S4iP3qztdvgRwvlTJ2lk64dXi7DRvD21aG8yp55zBDsEOPnVJnSb1lJJYOTDsIGrzLTJAymz2rWVEiRU9c0dtGC6eXuFOAHJy0jzikoEYotjrXJ1gzhLMIqZZy0rtWG1zTsUHRdhfUSMTYJwl7HKSn2w429aZitLuSBgUCGh50m5t72jcApGML37G/3VKsQPJPrEhY1TMyZOhmQZjkqtGuy/OfRhu6UiKMjUBpzPjCugSh1GlGhEC0V8cA+ZkTA84CghB4ji7CsmK99/LEhsA3TEy0gPDxKFwB4SEfBA9KtQzWtyMFZoGnsIhw64HZLDAzWZNtP6GAnx7qnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS5PR04MB9769.eurprd04.prod.outlook.com (2603:10a6:20b:679::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 03:42:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 03:42:36 +0000
Date: Wed, 8 Apr 2026 23:42:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, den@valinux.co.jp
Subject: Re: [PATCH 1/2] PCI: endpoint: pci-epf-vntb: Add check to detect
 'db_count' value of 0
Message-ID: <adcgJYlBX5P96QCi@lizhi-Precision-Tower-5810>
References: <20260407124421.282766-1-mani@kernel.org>
 <20260407124421.282766-2-mani@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407124421.282766-2-mani@kernel.org>
X-ClientProxiedBy: PH8PR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::29) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS5PR04MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: 2524b9f4-5813-4293-7ce8-08de95ea0a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|7416014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	cM2kWfRE84Qg6i7LdIVItPbQ6YF7mB3hrKWRZpTCIKm05+WCxwtlOzZgdNLbTDXEFEBv0er6Dn/Tqfq3gETT/jpOG3E+eXhN5jhKMEq46narVPNjhvyHL/tASD247dtzLQMQMmFHgCTNxF06w20yl1Gx+4rLl61+TPX6zEwgCgADFfWUSxzyk9p76OzggH94s4vQD327KbZkhUuLvsgIpfxYVj1qBpdenxS6BcGOQZHGoYw9h0lL3IuOCgmHTvvapTxfWWuygw+TdszFZCPgdP9MAavw5ULbmoKgLK4mchBqZDxm0QgXT6ejvMgyMbPxYjFmJzZSkx8p8SIps5waUoZZROK8n5u0oXTAvvbZGt2c4mUAQ+wVHNBqIYlH8hwVzFRbQsD8vpPap5ms7AytemaUcaeJpj2/gjWS57XCppCITzb3jRf5V0tY5Mv/uuP6f5hD9am3OOta0POmwyI115O8Svf7PdaveMedumBvC4srZnfdJe3ouBs+xbTuiDBUNZrxzSLm88hYIjbYLc2HJ4dpf8HDZoGELWobW/O8+ufsQhotaE7DEgFGsZxL9envVzueB5twwJR96hfl1tuddsreBWdIlZFbsuwMYF6pDn9kBy0vXRM0f3TblDdeP4HYjpypESt6zAHDwIs5ghxFySWbF3DwQfWDz7zx12uxbxNKrL6O1FjhBrJj9qXLB/rmr00yCzovdOaxzjMl4mEPVJxTgt1hC59ouDQM9ih/Ktn1uL9cv9Ga2EjJW3s59EX71RZoOAFULmraF3q1SjSQ5RhWs7r4mg86zvrost8pZ28=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(7416014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pXg2voZrdtzPJVVsavGgQzBNSzp4he+ptlYYdE5qzJBYF4NWDXoPOHTUD+bO?=
 =?us-ascii?Q?O9IW6Pr30x9VboOy4sr/L2AlxraYQFCLKxbuLGTVF4NdJQncSejyensYTZLD?=
 =?us-ascii?Q?Ftn/SYf9knQ7s0Ohx3vK3kqXJNz3rUuMNBinBmrkFFUdQ5HE3D3TEZr8KZsk?=
 =?us-ascii?Q?ViKCn0jhv9nKC6PnOkQPCtD5t5qDdPhKgV9bLwzcRYt/cyWbBILBhi2HNaWc?=
 =?us-ascii?Q?sfMFHrTJEgUnjXRepH0jtfbRGpoS31gVduG/q8eQlsGAQSZY6OHd6ldOv3kF?=
 =?us-ascii?Q?wP2nwczk6VdVqUljI0JEjZqouehJb12iPqSWa5sKfxpr52UWKftQNWYOp8Rk?=
 =?us-ascii?Q?cPighmDKkL7T74usJu3ppIm2XWtWlY+h3ZZaloN255ACHLAflZyL1Q9Ssirg?=
 =?us-ascii?Q?MlE3KJslOT4RmCzA39CDlXdEEyZTaP3hkVV7r67J1petb+7Si4EX+4u59af1?=
 =?us-ascii?Q?8aCgzpya1nH7BF6mqruBhhpZPx8c/f1HZVcki8db9Lf6qwC4PYizNXMu5A35?=
 =?us-ascii?Q?xz40DIzj5OdtHYZI6GUmNFhX8TVvPtihb7xdKmSuVvau5T1oYAJcW7ieKtDn?=
 =?us-ascii?Q?tyy8BPra6h5objkY//LY3Ji11tsnb6cwJhDPsov8tCXBuHATW2Co+dsDxtz/?=
 =?us-ascii?Q?ufnHTeKuzAv+ajsb8CH32qL9I+n4KIhWVRzEFSAyJtb45GnMjBrnZDB8FWyM?=
 =?us-ascii?Q?6gncvUNhqBmqlt9SGlDRuzgTclmn2tpae8AHtHQqtbF5BY0hQGtJ62RmnsLr?=
 =?us-ascii?Q?iFsbf5SxPdGBRX+R9ZnNRt7u49DzWT7Hbxn3wzNfQ6OvbS0YU6Chjopfz1fB?=
 =?us-ascii?Q?cdhr/YThcfYsRwen1iFTOSQRA7UZpFO0SxdUWDG+Wuv0/XvjVepE01YZXMcR?=
 =?us-ascii?Q?2kHBCtQTqpezGKGdM6PGVbQuf7KjHWXMOe5zodtPz8sr/IuMii/34VjaY46+?=
 =?us-ascii?Q?OPDnvaDxmrg+4oFJffOsyODst8SM6B9wNbWgLMzZpqIzdeZEDD/Cq5GFJCD4?=
 =?us-ascii?Q?+f+1+hMJdeweLqlPMr7FDNc3AzvUbjTDX6To270lvee+0mP+L7VqByw4GJe+?=
 =?us-ascii?Q?cR6r2VoUH/ModsVKiGirLHwLpJmX+taTg6/kyyIYRSRP4kTr22rcS0/9Lz4e?=
 =?us-ascii?Q?K2L09z2KHsnHYvP4VsGG/vMZjc53nhvdaE7EBVNTTGI/2a7VXiZYkE9Yl1JN?=
 =?us-ascii?Q?ZriKr+IXXf4Kk0p42iXvOxNfrwa3+1uAhefAfCZmzpdcJkA+34TtYDPHlzj8?=
 =?us-ascii?Q?l1abtwqtAuUcN9fLjvo1AzsdYCuQsWf0GDa3zIgtxCNdZBS2rRYMrfKFk0z4?=
 =?us-ascii?Q?DDDMnXThikj2arGXUa+62ge8UV23N81UhqUDvB7ZIARE2rbWsv5fzs28/wpt?=
 =?us-ascii?Q?bbFJs+Th8QxJSppT0yQOhS+zpi8yHXqtpT50CNgcW+ERDMaE1AfncuO+BOe6?=
 =?us-ascii?Q?zSF0igE2P/GWbfra2NRgCP0o8LKUBtVyw2qjWERUHslTPpELLAP0adRDT52v?=
 =?us-ascii?Q?bpVu7F51fXUpHuVJzfbmRh08KfHlP0cgJXjPvC+W9wK/d11zqRCB/ePT2o0G?=
 =?us-ascii?Q?w9IcKHIKrxLLJCeU/LNXlvaZzpaMaC4uY+Bj7WvV9cT88Xs2DL7wDcbZZ+5J?=
 =?us-ascii?Q?zjT4t/OmwVQl/gvoKE57c6LavzhAuGgw33RruuTSEkgCq3baHK7DChjHoB3m?=
 =?us-ascii?Q?VjTaEWfSeOMfORktCToRVhhZcZzXa7Y0hlG8i8YgrJO8dmKO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2524b9f4-5813-4293-7ce8-08de95ea0a8d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 03:42:36.7061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eXjE1TD0H6GoX9/4CMRdytk4v3CsQQ0guPguhPNNcrTVePtfKzoshppqEZNWnozUAqwCIP2gBxIDNml+HYRcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9769

On Tue, Apr 07, 2026 at 06:14:20PM +0530, Manivannan Sadhasivam wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> epf_ntb::db_count value should be within 1 to MAX_DB_COUNT. Current code
> only checks for the upper bound, while the lower bound is unchecked. This
> can cause a lot of issues in the driver if the user passes 'db_count' as 0.
>
> So add a check for 0 also. While at it, remove the redundant 'db_count'
> assignment.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 2256c3062b1a..3d30aa4dbb84 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -483,7 +483,6 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  {
>  	const struct pci_epc_features *epc_features;
>  	struct device *dev;
> -	u32 db_count;
>  	int ret;
>
>  	dev = &ntb->epf->dev;
> @@ -495,14 +494,12 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  		return -EINVAL;
>  	}
>
> -	db_count = ntb->db_count;
> -	if (db_count > MAX_DB_COUNT) {
> -		dev_err(dev, "DB count cannot be more than %d\n", MAX_DB_COUNT);
> +	if (!ntb->db_count || ntb->db_count > MAX_DB_COUNT) {
> +		dev_err(dev, "DB count %d out of range (1 - %d)\n",
> +			ntb->db_count, MAX_DB_COUNT);
>  		return -EINVAL;
>  	}
>
> -	ntb->db_count = db_count;
> -
>  	if (epc_features->msi_capable) {
>  		ret = pci_epc_set_msi(ntb->epf->epc,
>  				      ntb->epf->func_no,
> --
> 2.51.0
>
