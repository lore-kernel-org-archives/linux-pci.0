Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794520463;
	b=ZOQrIAZE0jDwjeeYbjiRNc+UbqoU4XC9miRngSGeW9dX0GcXqlQO9tU8ImyAr52GtmLA
	 ORkesLtjxzZWWw+DAJCf3Z+RSN8yae2p33onKwgOmeyBWU23FjtZDjzaQ+ecWugcKbbAa
	 bY7asRH1ytN6qYpQyymS9Aw4dRgnYcdJBD85bEAHsn0dBKm9B3AjVq5sBuIYRTbGLcqZ3
	 qem9A/Mtp9r73ThdGpPEg1o3Yfv4JIilHpNCYvkd09p3aDD8QIMF8uPwniCLk1SeXsuYL
	 aL60fSn0j+yBKAid4/UJcDOmYz73actPYpDi8MFKVXKJFzjxsLY+TgzmUpatQfySmug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520463;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=x/mzNU77AmR7C4GXU33r/VyKNLSOYr9HDyIxEgqbPWk=;
	b=3JYTAsZ6aYewN1fBOSI+tb5HvEeKRUJaj+eVMREwSw+j1oJnFVLf4Xsq6jdWdOoY0i4A
	 4pVhVQyrjp3IuhsEF/csr+zjsyQu2teLc/WkLqIX8rAGIalhrDb/HsmwdXtvWRgvYSHtk
	 yi8+5hhnSGvXd6HjLGOZ66GeftYOd30rWw1nfxRkk0t161IIegO3Uhz6yx+f2q1SGlR+R
	 B+TJLH9972P1SJSMH3cj7qGA8j9A9dN751+C0Eawp9nxtSoqWGwoBYZVkbkf7nc7OtMjp
	 zUoo8zh5Z5EoFhGXqb5nLXhxqx9AYBCKe6iBX3+MteGlkK7s47vuzydd1A4zMKlogdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kh8QQDV+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.33
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C9606A323;
	Thu, 12 Nov 2026 21:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B6C9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kh8QQDV+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FI5damXrumPe56U1yuqbOMR6qV4AniiOW76G2BSsqzBMwhIQB9lh0oav/EA54WOKsbLSDl2mXkG4lWRaV72uVOaq0Z65f3L/jWKOtauz1U3DhMmVlg/dKW9QpTKLlGk/HRUvU0y2CmWzDyNYU1jv+f4rv8hiElygkYnuM9dne7R7JpEw99t2IKj16G84CNnFfvtgv4jMxk9/Fap/2sdp5ZHKdTNw+uSmPKdQuuEnWPqV9NYrwDv/nHQ+HoZwnf+BdQEJkAPg+woPMOzlLTuYkcgfvoVsjXm+65Gt9NPx6nKr5ueGvpVNya8VLCi/6G26aBPHzf9UeO9YPZMKwJWt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/mzNU77AmR7C4GXU33r/VyKNLSOYr9HDyIxEgqbPWk=;
 b=A5+DOVqErVrNrrMll0F5dYxfSoGhyTdIcm5YJvjQCXk1PvqyKl6wMXhg7B3Xo5PnAXgKNzs4GUj/F3qJaMoYbSHhRKEVSuHE16yZz01Dk+JNdb1OsyAyMXnWkOGp6Iy2iTDbWOfbTIyuoQh5TV/3Ux5efiehyfmhBYa2K73ctFNXPXa2UUkTiyk8CNgiICMcIKG65zTVAx3Nf2DxWDthIRsprPRJqQHRwHpY6n3WaGZ7RM3zJPtcEgd+UeCLoz0gvFEdfv7j/4eqVk/HGlQxDkFxdP3J6y5vcB2D7gD9QDfN6iEBrSPPB/cBJoSPDsxhhK63ZMkD9NhkvUuBmVBHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/mzNU77AmR7C4GXU33r/VyKNLSOYr9HDyIxEgqbPWk=;
 b=kh8QQDV+MQdHiEyK98qxFQsszASlC6yk+iyAqGEt0FPlp/boVqVgTfIKftRssTUPyO8JDF3HQMidYj0o51mDwl7L9JK0SQ/mrhMThJY4OKBBBGR5pokxcHsi+e7WOPjrJ9l8GPL+UUT8NjW5z5phNB7GsMyX3Kj1dLUaqhul3yz1GHSHh3wro+dq/NanthGmkZosyb4fBYQFZdQd66RYQzdaRBDgof0+8LPgcWX1QFEiOTsL9yWYbDn4/loLv3PN6JSPYg2o4bqv7Fn8cR6NTDnPuPt/XQc1JD79SGp1/JULx3lrzvn9LI9JeFUnaz8BifneIDQ36I8gb7cdz0SRaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS8PR04MB8118.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 21:54:19 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 21:54:19 +0000
Date: Thu, 12 Nov 2026 15:50:33 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: nathan.lynch@amd.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Jonathan Cameron <jic23@kernel.org>,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Tycho Andersen <tycho@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 07/25] dmaengine: sdxi: Allocate context control DMA
 pool
Message-ID: <avY0qVZZl3it0Rq0@SMW015318>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-7-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-7-3668ccc7aab8@amd.com>
X-ClientProxiedBy: AS8PR04CA0103.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::18) To GV2PR04MB12436.eurprd04.prod.outlook.com
 (2603:10a6:150:343::11)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS8PR04MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a59c99-cd3f-4c0d-5c57-08df4107802a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|4143699003|11063799006|56012099006|10067099003|261102123227099003|261102130727099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	oNyD/psYTR2OGzf6fDLJllREJwVVEYzStL+UQvAjPlSQk9J1/FQjKWdVQiFm+GYDdVi56cSFlbOzhNnoqJZp0uAPsDzH1zIQXRxgs1kKuOm5QQMvBMGtRuYgJX+qN9r/jrrbimeScIT3i6bUR4YqHdHjA3yZgFOJ1W0fphV7bmpJuWcRxMrzhn9jgQtpg0g0UCw8x1/vXiK0lQh9yYR3oiZLN6+XHxcp0K9Ht8QUKAPvCr1l/U6V5UChuQwavDNtY6XpzFIqfFItXpLrnxVtSIjrRm06/TBANUcN3e6cRx4TildAPHhpAVtYMOMXbTJQAKfTP9ZT5TKJJsq8v4++9KciFFdqoYc9QCOjbhAIQtGt6fqsEKw8CG0g10BrKnRZq8y0sRXf+lg9E141RyRjj8OJOwDKjJLGVTpCLyY5BVwMYgtekry9a02UEyZpsUk3kwaZVomSuOSEdJL7yTmkNseP7OFidUKqxx6rcLTm0Zw2vJWtTUAbGS/YipEe1/CbkfA7JSVm9/CRawaw0+OPIRfRS1gbDJupQQ16y6KSuGcj18if3jHGAxTc3nr2jMqB7ptquLpSWQkcDlazsulktDyDYGFsZl9RejSdalErbhdvQI3fMW5evyzq7hR51tvaqKgbHsWt+Hk83RojRC21GeNETBGAZQ/eFNgB0DAUZFA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(4143699003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261102130727099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x0S2EZFvTGNUerLj1ieY2pPcgl9S0wWhCuFGNGL+/4GQDTRqEMMKmF+eXRa1?=
 =?us-ascii?Q?kQirk0qs1ESMSRKwckEDEQyU7dWRaTnRDkGDkks9ncWQXNAHDqK/oEba+QcD?=
 =?us-ascii?Q?i7OfVM26RDXxWZhLMiy4IEaNmCT5JggT81JzXn7x/+j65o/zWhtQovgTCWqu?=
 =?us-ascii?Q?+7C3v5X51biHxJ2sVzh2uiLbmK12Ij4OyCJk4W10/6K34DwpVn54PoFUZapq?=
 =?us-ascii?Q?jJwI9+p1mUt80MaMoaT43QI5jrPZk3T4FroKPPHV8hW55LEYXD3f0XZOOIeX?=
 =?us-ascii?Q?IN76zeIDOzJhiXPbTt54DFydYaA0PzKXbgf2074qAtKGS80gShLI29XZvc28?=
 =?us-ascii?Q?8SRcafCXwAl4FVvEKBsk0D3MwGXdvqHuJA+k9zwIiGESH+4LCUOAIueftmRy?=
 =?us-ascii?Q?NjVMg52M+PcYCBHgumRkobCtAKNfO6tyhnnBscn48tzBsrUngEIIOCz9qFOI?=
 =?us-ascii?Q?LmToZrX1bizMzQ30SI3aVsRrOrvYfn8X3EJQvbkKBUNb3/MQveNfWRNJoTei?=
 =?us-ascii?Q?FgfSZCI6icK0GebL+PH089mAlZfPk5lSkmP4Wg6JBz+Hp2yOhRgbRfa9842d?=
 =?us-ascii?Q?kZzqd0iNQUt3uUnfJ6tnvm4Nrn3AJN6w3EXjai4Rl2dijtGL0nVPmMYRz01J?=
 =?us-ascii?Q?iNGL3NkHoQkgn0XN3JqyaowvT+p/wwCq7V0UQVCSOilXQhoxPBpeXw5zUzhs?=
 =?us-ascii?Q?tHEWeFYwJZ4fnEL+krDA+6y5fyYlY2TNklDrihf5Ov33DYumvvoRbWvtxqsw?=
 =?us-ascii?Q?UnMB0hhLXIuHGq1dMWCKr5MSYlOER3SnBDyFlrm6BQqK/kajHGwaUQS4qFIT?=
 =?us-ascii?Q?LKdFA6+snLoPmpC29D6DDHRqxv6B7/QYvuxXNFs1enlhT/z4aRCkniGKbdWh?=
 =?us-ascii?Q?dEC5qm9uoqGhpbSQJbCrtM4BsDdk+D2FGpK9WhBdG9t6MsVH0lLbbRX/mUyQ?=
 =?us-ascii?Q?vqaoQvscSDAwlljAOGy+m+1/uYyawaymX7HtfW1F5LvqWCEy4+4ECfouakK8?=
 =?us-ascii?Q?qwiAJyVxlp4oOEvysiHS2hlejvfP3FXfTLIuuutxVs6xRjER+jilIWMXUSbp?=
 =?us-ascii?Q?4DicqTOv9lBeMyeAWz6ZiyhZpAT4uiukUK1EPek++G6YQLBJgQQ/vNqbu5RW?=
 =?us-ascii?Q?H5s6Kn7mzYpWA3J4+92ZcmEvO3m9vMlWA4MS6gwS+mPvLyIdIE3Qt4FwBaX0?=
 =?us-ascii?Q?fyK/oO2lWYkbf2z/Xi2ysmVselLlnESU3t8/ohAKVXJ4QjlOedT2h34cf+qL?=
 =?us-ascii?Q?i8g5YagcrUwE2TWi3dPJOBRX8SJKRX21yJ8i4YsZni+QF3DnrPyok/HF8xnt?=
 =?us-ascii?Q?D8eEje+GQt/LWfa+c5IsdM9XySJ4js5ciaQqBkJHMuhbwfljT7YRiitS8TtV?=
 =?us-ascii?Q?rbnmaQwMOHwB3ZVYm+sNbYFm+zutFVSLaUBt197NwSH2M6vXxfnSJtQBZyGj?=
 =?us-ascii?Q?xkzGRl+gOxe6pBc2FkD8cRWLQnrbho9Wseed+dINXK7KLGC2yM02Wv8MhSs9?=
 =?us-ascii?Q?bF5Eulsyr7IEh6IijI1urv/3AQUKac7/OQGuFecT2TjmUE7+QeUANgVbqq2g?=
 =?us-ascii?Q?qPyCQCFyo6Xw4ekcY0N2Pp7d4tabrRLCOfufLiccXYL4UwZQei3cEC2IyrEV?=
 =?us-ascii?Q?RZdliHy/kMXpDnQPcEsppPAZe06Q9d+LUFa/lCA+TCnDauhwDpbBtst1+AIA?=
 =?us-ascii?Q?GzbSJ+BxmkZ7xmWHEsAqzM/HFCuzzNGSJ8cHvz3qXoBaZnWJ/KubAdHeILqD?=
 =?us-ascii?Q?juX8i+82g51BmeC+joSYYT56aO9dThk2MTQ2yL8FyDDR42fMQOCf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a59c99-cd3f-4c0d-5c57-08df4107802a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 21:54:19.2178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31826GnWG8LlzKbSbkL3OBexVG1V1khKAg0Ix9NCwm3vdqtOwWt5+IFW9EZ3WfUUdxsuAkPxSevG41UZ+n5Oe+FK0UVg21W58TTeZHpS9b1tJVZMs+AmbJHNeyCJDZmZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8118

On Tue, Nov 03, 2026 at 08:49:48PM -0600, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathan.lynch@amd.com>
>
> Each SDXI context has a control block (CXT_CTL) that identifies its
> descriptor ring, context status block, and write index.
>
> Define the CXT_CTL layout and create a DMA pool for them during
> function initialization.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/device.c | 21 ++++++++++++++++++++-
>  drivers/dma/sdxi/hw.h     | 11 +++++++++++
>  drivers/dma/sdxi/sdxi.h   |  2 ++
>  3 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index baf55f6b6826..acc955b088ba 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -9,6 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
>  #include <linux/export.h>
>  #include <linux/iopoll.h>
>  #include <linux/jiffies.h>
> @@ -351,6 +352,24 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>  	return 0;
>  }
>
> +static int sdxi_device_init(struct sdxi_dev *sdxi)
> +{
> +	struct device *dev = sdxi->dev;
> +	size_t size, align;
> +	int err;
> +
> +	size = align = sizeof(struct sdxi_cxt_ctl);
> +	sdxi->cxt_ctl_pool = dmam_pool_create("CXT_CTL", dev, size, align, 0);
> +	if (!sdxi->cxt_ctl_pool)
> +		return -ENOMEM;
> +
> +	err = sdxi_fn_activate(sdxi);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
>  int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
>  {
>  	struct sdxi_dev *sdxi;
> @@ -372,7 +391,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
>  	if (err)
>  		return err;
>
> -	return sdxi_fn_activate(sdxi);
> +	return sdxi_device_init(sdxi);
>  }
>  EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
>
> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
> index 0551c2b52980..82c6b4a20cde 100644
> --- a/drivers/dma/sdxi/hw.h
> +++ b/drivers/dma/sdxi/hw.h
> @@ -47,4 +47,15 @@ struct sdxi_cxt_L1_table {
>  };
>  static_assert(sizeof(struct sdxi_cxt_L1_table) == 4096);
>
> +/* SDXI 1.0 Table 3-4: Context Control (CXT_CTL) */
> +struct sdxi_cxt_ctl {
> +	__le64 ds_ring_ptr;
> +	__le32 ds_ring_sz;
> +	__u8 rsvd_0[4];
> +	__le64 cxt_sts_ptr;
> +	__le64 write_index_ptr;
> +	__u8 rsvd_1[32];
> +} __packed __aligned(64);
> +static_assert(sizeof(struct sdxi_cxt_ctl) == 64);
> +
>  #endif /* DMA_SDXI_HW_H */
> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> index 856a3838eec3..356a47ed39da 100644
> --- a/drivers/dma/sdxi/sdxi.h
> +++ b/drivers/dma/sdxi/sdxi.h
> @@ -49,6 +49,8 @@ struct sdxi_dev {
>  	struct sdxi_cxt_L1_table *L1_table;
>  	dma_addr_t L1_dma;
>
> +	struct dma_pool *cxt_ctl_pool;
> +
>  	bool has_mailbox;
>
>  	const struct sdxi_bus_ops *bus_ops;
>
> --
> 2.56.0
>
>
