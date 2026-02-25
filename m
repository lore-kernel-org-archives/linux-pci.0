Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE126C3BE;
	Wed, 25 Feb 2026 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772052951; cv=fail; b=lNbUFn+K2qp8ifdVJNZPvGNHaubNQil2zy3Q2/2mZrfGHtZwWysVUCHhfQSRhrYRHIp8rsoHMCjRoqL5XxHFOF8SXiX9Xca7Y6xgs03kTRwJzOXSHp3qNMJteDjycCaXwPBWvG9GmC6jWpm7CWqPfEIsPWqGQdpGVfdOFBaoSlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772052951; c=relaxed/simple;
	bh=vu+Xlvjs+MqCP2UwCP26yGbBDAb1WIqVpzeKlwwgYB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mDCk3cg3Qb9EHzmG2YCxIl3BrLWO7ySwfoHCs8mdVXtZ8NDSr/NJBnboX5oWPHD55ipv5/UZfTpXVHDl6fU3f6+jKzV1CgU2roIG1oTdWY5uc2q0z+WUCHguVk+pJh544QR/r5KA7yesadVr2p8XTQi+sQZYavjeSXytNLFu8eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CNmCHOBU; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CNmCHOBU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoY7sQj8QR4WSWfNdTnW03z1xfifCOUrgZTDrQ2C/o3x985M2DQZmNr61ZiHm3pVYfPajfOlZeNcZ4PoxqgUUU3l5BseEuWo/Z6cFgMoMjl0cmt21FazZ3DoVB45z1FrsMw8D+DhQ4YRRINM4ZwilNSGCBNHgQboVOlyhYqhhODUOl/dGI2lb7LqpFi8aR5VBnymhRowNyIbdcYdxsvRiKOEiAKs0Jd82MzIhXH4kmh3HyeJ8I3K5tpP5M9lWd9oE/Xh6bG7yEVk8pQ2On4xV4bKAZMYo2iaWoJ13p5vAcuktWxlW6CUlIa/WA08p8v8/tsGQVzxez1RRS3x65Tknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/yuZPyVCrufSh8JBQxgUfmAq19pqjv6pjJsm0wWqEw=;
 b=MdkrxDNXTL6VB7pBnXbeevwM9XCzS3I8NVRD6LHVCax6ifBaznlZi39pg2CY0PuC2LJWF4yaBqxUDHKP8RUbEhGA0L05J3jOcFBCkHgIzFOLWDtgK8tSJ5sbHC6ih+rSvn3toFo6lKCrFClgNyAcDkhNwVeLh1MImwN6tMeb9fzxz7O8wY6er8o8lKcCBSZWvOdU04cIL0vXTlWN6nGDGAjVgqH+qumcqMYxew6D636v1TT4Ymfob7n2njpUjjJZWvaj8s0cfAYUkCBipZTWi1LZnZnVvAFgB+KLE1i9wqj4YiHRDs50KCPsDO2z+zImFnA62MrwblEOFiPwb9TFMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/yuZPyVCrufSh8JBQxgUfmAq19pqjv6pjJsm0wWqEw=;
 b=CNmCHOBUYbWT8T4ajb1yuJHHFKwBSjknF/1QhrHH2Q9V/xYjbUqRToQf3LWt3kZogAcKCsOHL+0SpoxgtxhmITKzkXm9C9YyDbLs9QJi2CiyXlmASUmOjukkIG067orSHXmpABiPuFtQeB1JVtThviXcnHsSJ2Ai8JoH8XQRr9IsiIEh0XS71ZusTr1EGnBD0NbHuDOtwcsWib5lLqE18I4rqA0lqWV/YqLbpAf0fGsJpHVutZtkZiRhGTZn1EVDofLuj0OqNWRFYLzMxAgbYUFRPqf/Hn68AZPLK98TeyEOxIhhmNkWnheF2Kwx8rXFnPCjS6z2fneWnPg5P0+mog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11328.eurprd04.prod.outlook.com (2603:10a6:150:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 20:55:46 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:55:46 +0000
Date: Wed, 25 Feb 2026 15:55:39 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org,
	dave.jiang@intel.com, allenbh@gmail.com, kwilczynski@kernel.org,
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] PCI: endpoint: pci-epf-vntb: Exclude reserved
 slots from db_valid_mask
Message-ID: <aZ9hy9RKR5pblGSc@lizhi-Precision-Tower-5810>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-5-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224133459.1741537-5-den@valinux.co.jp>
X-ClientProxiedBy: PH7P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::25) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11328:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b464b43-bcc8-45dc-f76a-08de74b03fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	yLVVTMK+bThE3YWAN5ti4K/hM1ik0vzPAYeCsH4W6i/oIr3/yzXEwL9/llhzLoSVF+Z2CUAodbj5A8XRKZrQGt0nP/Qj9DfwzQAnOrshL2KxxDedyDD8KSK1HxQF9AeV6fRmqaKB8VsqT951HS2ZQcTnexoe4qKH1oGEhyhMWpxQTTEw8FWvAIgl5YfuQXtecwcNlvDxhx/TgpTS1aYt2VRkjprC46ZOtskiY9CKh3Rzfyg7JgnxPIu4DndoM/TWugjmnLDP013ChEIL0SE4OiCH/SZdIqKP7hEWLyBNTQEGNs+1lboR1woT51YOPH+8LydPOc4M0/yk5JeoxBPpB5hhnGQ59E9HG4Xx4iVQZqFNFPZvIdhuC7BmvMPv3/FWo14R7wjvUFEeuCyzwgwICdd6FBD6fkAEge/PABEkrAAFCCQF4I5pDYbq8iWox6cN9r8C8gdPJGe2640NjM91MJrM472kterZ3JzQJ58cpXoA+kQYNc18wX1ZAoRynEMGcS730YYFSRsY354HGKRd+1WuWiFJMYdezDT5Fmsz4PSPWyvDq3t77OssTbLJFBPp3CuO6TnmZHoE1r1oDRh+SH7fl7T3P0V6RCJDsmg1xEWkpgfVzoz2CMT35jC7LcsdthGAcE9IFSD5F63C4bohy9gTEc2NL/rQ8YGNxegvGo4bxBj8qtefOz9nStCyRr7cGyija9PjNT3AO9IvVPO4KSYI1dB+E0DqD85MIXB5HZ1aXLCMqPuzI76g4/Fq8FVebNGJZxa2+/Dr7GYFsUU6ss3vvevsAZf+toWF9+tXvms=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xt2V72hUehROSuiTauFucVJrm/WZLwNL5WlPIaM+764nX+W7CEfpOM/qQmlI?=
 =?us-ascii?Q?OWHZnJuNEBz3UZcqrbQYooECIQmrb7bV7Qa7PZfJqVC3W9ZL0i1jUuP3thnh?=
 =?us-ascii?Q?uD2VfBIKSX3EpsFzC59mOLQnmlMV430lpKoRDP7iL3EQbMmb5gyTJp0UM0uy?=
 =?us-ascii?Q?Xkg7CUnTsqiJX0r3SdZoBdkG3vu6leL4RzPaswgwUXP/q8rcXf0oU3hVCyZf?=
 =?us-ascii?Q?al2SAZeFXylXzZw0ODwqCWxxZQuzVmB6V6cB/nQ20wM6dagZj5HacWBuYcx2?=
 =?us-ascii?Q?OveNHmWkp8RBvXhnlDICE7CPrxKHgNyfMc3sk328QmSDoedsCoC4O32ZDe2s?=
 =?us-ascii?Q?IerujZ57JBkIp1B8GSK0Vti3LuLNxtJU6kp6UHvSAK2M/tl8CqrrNVQZgmfp?=
 =?us-ascii?Q?1YAjz8zhOOA5BsnOMwu/AJ+PyC8UvueJEtPzhxUGBTjxQkMDT86v24LZvVTU?=
 =?us-ascii?Q?juAlzmuQkKZWRnSEJ46/JNIp6/gzdx2bmUOvHI/3tZdAQ1peY2fBGVJfWwzL?=
 =?us-ascii?Q?FO8sZVHagUZkcfiwiNvnrYmqxAcz56QxBq4+Tuo/PMppsPCBki9Cb7ErXzVG?=
 =?us-ascii?Q?ZOyHAgQQefwSGGWgfy5J37nwfM4E2cB4ujpEzq3D7ggMYpBydXH6Jvbw2i88?=
 =?us-ascii?Q?VVCTEqJENfx/NjeOch95fFAF4fISa+WjRjqugbXl3RNRsxVC7AVjETVJhkxS?=
 =?us-ascii?Q?2x8SiFd50Krb6d8CO39rkK8zzjoNAAL5Ln95jkXFBDPGhCNfFkQj7XUefGJa?=
 =?us-ascii?Q?vFU3NXXsP6xeS0vEVQqA2QTD+1FlCR7mCINVo+AyQEPu+d43zNCRHgjEovK5?=
 =?us-ascii?Q?Aowc/hfjlpweEzKtshH8Rvr2xdPYw64JtRQ1x4Fu0D6QFQ9jCkJ8J7amVVrp?=
 =?us-ascii?Q?hUdHoBSHlrbtE0p3gP4Jq20DDKBZ8GQhkAAuLUKM8HAlePtninzXGqCpBKxf?=
 =?us-ascii?Q?8h6uLn6SppaiZLvBYh8CmCBfam7NFrFfsze46dos+5pzoSVn/OukYS9XU2hV?=
 =?us-ascii?Q?DY4npCEZfl3kZQfaNJV6MVWm9npxt0M2KLwbEVFLwZrT275CRvdzYUIxso7c?=
 =?us-ascii?Q?WiQFPUuMFPhvg6WsvGFJw4gT9H+bVCcGOTvhpQYRxscpdCE6rGfr4tCeSIY/?=
 =?us-ascii?Q?u3+5y3hUD55WEeLXQumS4EqeBK2Kp/dUAxuuhoiyJhsJTuXrh7Rs9U63nscf?=
 =?us-ascii?Q?kS0SVur4Rt4PEjte1iDlYwa0OeEwohgKtjX8M6/Vli3tSv4nF+j3yP883nnA?=
 =?us-ascii?Q?8hokTLFIvBuyNIwP8gsJ6kQGoiHcMPcFhbPdsaqyms26Oijk5Eel9PjZTZ6m?=
 =?us-ascii?Q?YJxTDeuziERxY+oh6i4Y1nmCgU5bIdB5WefY+MYC4zc4DvBrvwZOXaveYR5Y?=
 =?us-ascii?Q?h6Eool6GUMqfgFgcolAqAYqdBs/9KklZPRGhygzwE7nG4uBQwzVBePJxy2Pq?=
 =?us-ascii?Q?YrGOs/4R4qt73bDF98M8XFoFbpW43jaCHKLAXTSqLp63gvpLrVCsyI8jy1QV?=
 =?us-ascii?Q?FTxH6Ojl+zjco3D2stWOacoBHUJsgVAO0WXkOM1hhepX5HZASaqLKcDfVxbA?=
 =?us-ascii?Q?+oRQm+EF1W9RjV02JeBBOQ5hkMuYDDwOYf73tjtwZO4V9gSfenFUP4/vgj8f?=
 =?us-ascii?Q?X+pnfDOAbLiX7HpDlSR2g/eqRZw23cpCP1TT2HWXHAUP8f6B8OFXcXSVZI/r?=
 =?us-ascii?Q?tQS7N9qpMZckmb9I6J3sMxAlQIWj/SpDGOqu4Bnane80o2+O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b464b43-bcc8-45dc-f76a-08de74b03fa9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:55:46.6117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byN8Y9BjT5Fh9tbrfW6zh9hTrZ/dEuXQjOH/yPBf3KHTBvhRvkexosaXr0R+rC+gkTpkdSytvsnj4fqEV3Y2Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11328

On Tue, Feb 24, 2026 at 10:34:53PM +0900, Koichiro Den wrote:
> In pci-epf-vntb, db_count represents the total number of doorbell slots
> exposed to the peer, including:
>   - slot #0 reserved for link events, and
>   - slot #1 historically unused (kept for compatibility).
>
> Only the remaining slots correspond to actual doorbell bits. The current
> db_valid_mask() exposes all slots as valid doorbells.
>
> Limit db_valid_mask() to the real doorbell bits by returning
> BIT_ULL(db_count - 2) - 1, and guard against db_count < 2.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index cbce50afc4dc..2eb3db035644 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1269,7 +1269,10 @@ static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
>
>  static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
>  {
> -	return BIT_ULL(ntb_ndev(ntb)->db_count) - 1;
> +	if (ntb_ndev(ntb)->db_count < 2)
> +		return 0;
> +
> +	return BIT_ULL(ntb_ndev(ntb)->db_count - 2) - 1;
>  }
>
>  static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
> --
> 2.51.0
>
