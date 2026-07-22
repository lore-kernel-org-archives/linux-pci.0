Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C135F185;
	Wed, 22 Jul 2026 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784682373; cv=fail; b=pLbf/+wkWS0ZWigBagalvt6P9/+3yKM+t6gPmGMWGC4RW6fERvbIbWRxnFxcQAZu+QlN+3DCZftJBLdLsoypOGregaSC4of8eM9UT5cEuBVKHgbUTlOR8CrdaY2rf+W9IuqxVBtrdn6eXA1vLoUhkZTkHCs1ZuC45e7YZ7QGZO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784682373; c=relaxed/simple;
	bh=gDeDLswOLzFdSlreHK+NxbB8bPI96iNN4EbWgYvLKJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a7dqpY5cKzZoRhlp9NS9kVGMu63golAST2bThnJVNelanzIg7OCgTuFFz0QJUtedpq/DhK/VYWHgNoqHBOHQc4lpMyJpMGmm2CciNhf9LHh7GYDo+8bRrDSiyKz0N5Kma3Mwv53XRLpcuDnpFCAFF/fgWag/IPl6042a7JU9adY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ucpgRdl+; arc=fail smtp.client-ip=40.107.162.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ucpgRdl+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpG6RnsTa6/lGT1xm/T4O5Ry6RdMf4qIJ6+ArMhnMcqXKX9ej92GPc7cZRStCzVEsYpvjljswYQax7IC02XiR/kf4Tq8EVoHWvNwhWU//LMPTy9hlVhoEij/ExWLi+K/26JVLI2ur1/j2u3w1YsRgyvQwPVXZ/waypSIoQOl7GO8VxEgSAzVSo+A7dmkRpR5mvrbZnFA3jP3KTogcGj9FjIFB53+dJR+hlgUU/nCDuKyTb3cucLAzJBoG5ZEnnCeXeifgM9gKOCqpy2F5i6XO05F85sjqusoidpECluKA1Q8ilEAaWXakHSqzT3ojjgp0gSRdtGch6FlhbDo5m2Ekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jORHLbWySc5I7bdtjr63ds5bTw5hmcKGwL+fEi9see0=;
 b=qBfFZNElxactNdhPn9Isxnt1uTRhwWNExu2HTUu0w1wLPXm0dwUrxBboBey8o9T55FQd+OBgmlvq9yZCQOseDzb6UfnZGDMFl81E9lDDMEwRUEh1qC6NjTTt7X55XPsa+pg8N8/7FOIPougrCzA3bMzPOF3Kp3TsrsMHKCMoBMWDfTrdQGOyYeBIhhqZJQnxmi5GTp0oI/0HIVWbo00QMBD7U8v4eJX7ReYB91byFjiUw7LXT172yMM+uGNU15M3/lZpT+UZ3x8Rycx3CPbVHJmQfcJilvUaUM/CiEfn4zvHwD0MmGY9nAv1rJ7TpXyfgyJpi7wbZZpE70GfZAgo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jORHLbWySc5I7bdtjr63ds5bTw5hmcKGwL+fEi9see0=;
 b=ucpgRdl+Y98olcFKYUL/yipKtmItVxXlqc8UUYsRKVfMGNsnuSm1QdOch0Yw0WBy2pNFL1VkPvJWFudFF0r8ZEjD1KzCGqMvhwjm3VhAEUroeb/eukBQJqyleqjKK1OmWFN78PE8ToOQEta1+MjFKXUS9A16vFKlcS0uIwZ3UAgbOcs4RTKnTS/pHkXGOsSh3HVRpROPwboZe71UTYFDZeDFi8CTIP5dFtfAow2mbpRH6tUy9tY3WlIcXWjr/DVf/jrwBsnjwI0LUV7WJkZiBaej8TnZ7ow0F6FnvMFqWIPWDv10w9BObAgRzCaA6iHwCl64rI5eJ7bVuu23So++/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB7075.eurprd04.prod.outlook.com (2603:10a6:208:19e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 01:06:08 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 01:06:08 +0000
Date: Tue, 21 Jul 2026 21:05:59 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dmaengine: dw-edma: Implement
 device_synchronize() callback
Message-ID: <amAXdwI_pYA4p_0P@lizhi-Precision-Tower-5810>
References: <20260714-mhi-ep-flush-v2-0-b6a9db011e85@oss.qualcomm.com>
 <20260714-mhi-ep-flush-v2-1-b6a9db011e85@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-mhi-ep-flush-v2-1-b6a9db011e85@oss.qualcomm.com>
X-ClientProxiedBy: PH7P221CA0089.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: b90293ec-c621-48d2-b2cc-08dee78d6999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|23010399003|18002099003|22082099003|4143699003|11063799006|5023799004|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	cQ+iouyNXGi41CIqIcH+5JazA7uahtT1qBqZf4+hL/oDIbp8eoBaLnx6zY1iAm7BD9V5vSj4kYwAmbtfCZnLZgibyzI9MOnDpHErXECO//pgCuSx5l5HSY53ku+nGKfURPxiFa6zoekO3VWLPBgZ/JAX9MZMJLaHjBDK8KtMy6cc8giXza/z0Xm1bMT7fpafXTqA0cFkl2hUfvstv4wWE6n59zEeTm3Xz0M0FBXVk27fCTB+golOno6d4UhtH7ryxaMlMa0YYcst/s+JsfxPZ9NXk+xrQXqtQWanJpAoG1Bl5PyZ9+OpTmKlJcoUFYZWziF9g+QfpqUFROOOMcbgoqtGeM62VmhjZ3EUyPY0ljdbuiuvDLt6Ov3DAtxxQoooQlGYSrEcsGTw6TLTdLw+yOXXymSdeFapWrf2L3UVvXwc48OlSIgtocG11A19PKbQhM2Guhbau35dcP3Jm/vLQjZdCeXUULfljNqh0ATOynnpmXr+C94oz8cjZ6RMsh+1WGzPxSBHmflmGOwBbWVqYiCrWB3MZUrDS6Ftk5i333yUD/9qpvYgM+yc8xWMnNN2H2QSPc8Yrrhj9BAihkSbIkW/+qQYSIe/nd+vSxDSPH5L7ldwVthxCt4gYrEsphdg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?15iujArnXSFz5rd136cfha1xsGNcEr6PgUQSzOPCmJspDKo+QjR3PiPSIp+r?=
 =?us-ascii?Q?+Yxy+kkH0B3j6528tJ3YKWCVnA+ldN2XPVcGAs1zcQy43J0oKgiKDuhR8xC0?=
 =?us-ascii?Q?f3amXJkazxxMUZW1v729wG3akarxaeKlwzicdaQnU3OFOTAy7UAfoHR/zTbL?=
 =?us-ascii?Q?Un4I2QWjTFDFvdr8qHTdhf3byzLtgbRcs9MAwe2pHGAdUKMzz8kHXdcCXE/G?=
 =?us-ascii?Q?yTUzsSumXcvAJZwy/Ri5ZJdjtnEtSE8ULmNB4F+NPTzM0GrLEli9B41vtWa6?=
 =?us-ascii?Q?dxJAQrqGRZPbapMu5SovFXfHknus2EYXD6vNMGsLGLpP3ZiXwQgzG/G8XoNi?=
 =?us-ascii?Q?ufZclq7qu2p2eedfQ1noXrr4hfTN9y54xPsGHIxnpbA+ndRhdG8qg62LPYxm?=
 =?us-ascii?Q?DnsWLJyDNHe4Oi6dvid8vcjGwWVj4lC2hYm5hDR6NaRvHg7tU/cV98SFSPHA?=
 =?us-ascii?Q?Uefv2YAwMAlIy118Kh6376gDEIOZBs3DtnDZiAHKHSz5crqLgHFjNGfhehlp?=
 =?us-ascii?Q?VM2k8sxEKX9MDX7eOVIdJ5q2dYE35NqzMskRLOsxujlcK5Phlv60Klpz4seo?=
 =?us-ascii?Q?rLfcnPp/MzCJ/ndGg0O9styzKezovgKIeq27MvcMzEiuzSLGTk8Es9p5bK5f?=
 =?us-ascii?Q?2/AZ22tSWo3PIVUBnYNcoFnP0/diiDNESkCGFVuX7HN0WphbUQ7V4udhCncD?=
 =?us-ascii?Q?TeuzNsLORI4DITqTtIAESvi8zeXrS8zvN+1fr9OGM6V/NJJ4jNz2OlAz8Is5?=
 =?us-ascii?Q?Z+3WuuvWLCHFSp1qYgEXf4ogNcJWXtzgsL7AjA2GDdJp+C1LToXmEeeVZn6D?=
 =?us-ascii?Q?7059ah2Dh0A1gOI3T1+lfeGTmxz8ZBTPqCVHICQYD6YOpgpaGHnYTCo82AhA?=
 =?us-ascii?Q?c57rrbPvW+vSFiJgtlPPXx7oR5g+9II9UiVJY9aSodlezqhVQt6nEfIlJH4q?=
 =?us-ascii?Q?oayf5u8n8t+CByma5YE17w4guD6i44ASbp7kMphrqjmYNZCbpkG9sNbhuiLE?=
 =?us-ascii?Q?FwD4YN+uABjjWUQOaeuVoX0zte5Rohujez46hOEa1IHL/YqwD/cJPrENUtL2?=
 =?us-ascii?Q?7hx3lOxvMVQ0iU0VDi9IjzZM7tFa329qmtLpHCirI3ts/UT88DFZwCsRs3mn?=
 =?us-ascii?Q?Tw7/sm3UxHfHzbzYGWI4IcpK3YlFVcYe3BgyXG2NKa+PiMfZ2ZHz6AFn27rF?=
 =?us-ascii?Q?IeYn6Tl3iwDMPMCEpF2Fc9PGdIWcn7cM998OjTJY0yQUhgt9Y8ghdiN+X9Y+?=
 =?us-ascii?Q?lj+lwIj5kWgJptk9UuaDcP74O8J2UlnFWoUpbRE/z4Hy8QVdGZs/BltdK/Hj?=
 =?us-ascii?Q?b+lIf3a6BusSjpWesN0+vm7cvPwU0z7aOKUOQlIxAP9EEcStr1D2vGRDH9jj?=
 =?us-ascii?Q?Y3iHChQZN3mBLt9iejR4j0NlDC7TmRsQAB8WSyTbcokpws2aExZWcS28UvMz?=
 =?us-ascii?Q?fzTIRo6Vns6Fz5hcXEM3gcTQwxdntO8+8pJSmhY1yThMmMtWTS0Roj1iSWi2?=
 =?us-ascii?Q?PqXBuNhWsPVCv50eE10Fuv3gQtgEaSssTK0hA8tHRVX0Azll+EtRCC0jNXn5?=
 =?us-ascii?Q?f6hxaVFaa3lTJSdc0SuEj1assoRMJ3RtyKtnLmvLlKHEeSPcOZHXSCVUANCc?=
 =?us-ascii?Q?gDauZb8Mx3WhXsuD7OqpVoxSxnrlM60u3OQ1RSpTBeKWxGFti+hDArhCXgI6?=
 =?us-ascii?Q?hqv0pzqqkW5UlO7PRvLjDwqZZhjA2sgGiv+MZiax25fUV6zOos2+RI5QpRbt?=
 =?us-ascii?Q?Kny+r6+ZFV5xfFpAbYOVQ/axu0ZWKaBQqmmmjVAoFa92jBGHJCQu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90293ec-c621-48d2-b2cc-08dee78d6999
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 01:06:08.4194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpcJ94IYDC5I2+fFxg+HIKvjUT8sdDaiixkY4VPaYD+AOEewboq0wOlcm1ZlAtt5plCRHfkoFt7y6IEmWDVrHD//luV26G/W8U9GpyIVJ5gmz65CK1WREEY0NmnZyOc/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7075

On Tue, Jul 14, 2026 at 02:08:32PM +0200, Manivannan Sadhasivam wrote:
> device_synchronize() callback is required by the client drivers to ensure
> all the DMA operations are completed so that they can free the memory
> associated with the complete callbacks.
>
> So implement this callback by first making sure that all the in-flight DMA
> operations are completed and then call vchan_synchronize() to drain the
> DMA tasklet.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Similar implement already in linux-next, recent many fixes and update about
dw edma already merged in dma tree.

commit 99109a51efd28c9a661fbfb9469b023c517b31d1
Author: Koichiro Den <den@valinux.co.jp>
Date:   Sat Jul 18 03:06:32 2026 +0900

    dmaengine: dw-edma: Terminate all descriptors without callbacks

    The DMA Engine client documentation says in the "Terminate APIs" section
    of Documentation/driver-api/dmaengine/client.rst:

    "No callback functions will be called for any incomplete transfers."

    dw-edma instead calls vchan_cookie_complete() when a deferred STOP reaches
    the interrupt handler. This schedules a callback for the active descriptor
    and leaves other issued or submitted descriptors queued. A late callback
    after dmaengine_terminate_sync() can dereference client state that has
    already been freed, while leftover descriptors may later restart into
    reused buffers or leak.

    Move all issued and submitted descriptors to the terminated list whenever
    termination completes. For a pending STOP, do this from both the DONE and
    ABORT paths. Complete their cookies in order without scheduling callbacks.

    A STOP can remain pending until the running transfer raises an
    interrupt. Make device_synchronize() wait for such a pending STOP to
    complete before releasing terminated descriptors. Reuse it from
    free_chan_resources(), then release the remaining virt-dma resources.
    Sleep instead of busy-polling while waiting, and warn if the existing
    timeout expires.

    Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
    Reviewed-by: Frank Li <Frank.Li@nxp.com>
    Signed-off-by: Koichiro Den <den@valinux.co.jp>
    Link: https://patch.msgid.link/20260717180639.2643243-3-den@valinux.co.jp
    Signed-off-by: Vinod Koul <vkoul@kernel.org>

Frank

>  drivers/dma/dw-edma/dw-edma-core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index c2feb3adc79f..df0d1a946ed0 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -12,6 +12,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
> +#include <linux/iopoll.h>
>  #include <linux/irq.h>
>  #include <linux/dma/edma.h>
>  #include <linux/dma-mapping.h>
> @@ -331,6 +332,20 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
>  	return err;
>  }
>
> +static void dw_edma_device_synchronize(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +
> +	/*
> +	 * Make sure all the in-flight DMA operations are completed before
> +	 * draining the tasklet using vchan_synchronize().
> +	 */
> +	read_poll_timeout(READ_ONCE, chan->status, chan->status != EDMA_ST_BUSY,
> +			  10, 0, false, chan->status);
> +
> +	vchan_synchronize(&chan->vc);
> +}
> +
>  static void dw_edma_device_issue_pending(struct dma_chan *dchan)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> @@ -968,6 +983,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  	dma->device_pause = dw_edma_device_pause;
>  	dma->device_resume = dw_edma_device_resume;
>  	dma->device_terminate_all = dw_edma_device_terminate_all;
> +	dma->device_synchronize = dw_edma_device_synchronize;
>  	dma->device_issue_pending = dw_edma_device_issue_pending;
>  	dma->device_tx_status = dw_edma_device_tx_status;
>  	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
>
> --
> 2.43.0
>
