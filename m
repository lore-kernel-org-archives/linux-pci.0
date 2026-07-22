Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010059.outbound.protection.outlook.com [52.101.84.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6443BDAF;
	Wed, 22 Jul 2026 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734620; cv=fail; b=B7wDYTnnZySS7xkJaXuJdts6hJn4AXeGPn4u1+pNSGSv7Lik6pvcbI5tlUU51bKKEjg6Um8ZWFz1ugHzktC1DT+bKLOJSJBoJ2rBcH2Wdl+sTHZQVLE0Y0n/M1bK41s1qeg7B9aybB+KWOxlkfgrV9KGcs4wd9jauyRVrY7jZWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734620; c=relaxed/simple;
	bh=dyAYfGo8eYC8ACZgfmtjNRCB56X7MrRxO9wItTJ0XHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EsDAF5pf4U5f0TvDltBb7kLuIXmzb4NdDfBjhTTAbINUFIxKZmlaIegP3lBGXeTkL8mmZ8UEED+uqLd8e1Ge8gXAZsjfIKju0r7pzaxA2motcFUs1wMDfcHPnb9rVl1nxUuJ6kN89BjIa3k/AxxtvM7CY4Tr25RMUAtI5bKUwXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iWpOku4t; arc=fail smtp.client-ip=52.101.84.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iWpOku4t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7b7U+aVYKV8TtA9sXiDAGnvSL2szOYq6MgTVwbScG6LpC9IupItwvf4TfUs+cra9zLNjunA6WlQkEwdEO2lq1TMsurSpAPwf88OVDj5PQYWSBeYHXHgMUjo//6axP+bUh/QiZpDYuPRBbQB/2EE4uuMQKWp3YYcL1NqIgnzm9GrnxUZ6lHqsG7XYCELFrUznsg6imAGB8KYM5OkaadGpjma4iE68s8lQ9Ia7FDC21hHu459CPT8fuL8eV7NiTYNZEZocJUn23tP/TA/0UOmQiegRbPD5sYwqP0LNEE3Pn59k76HLVjwuGnvR9SsYPdvV+mqGnEladWkW2x463nfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nrl8mbYkc8GncQ8aGaKUuiMS4We8xXjI9cI3oKPj+hs=;
 b=y7PSPPrOqj91LoFkJFDhZ+M5TkTi4FSznkSY3J63s+TqY+wbLqjI4wZJDwqwe4tNn/1IV0bmRzzIIljy5ERP76TKU6xyUZmK9IE+nxUvhN8iYStA+RJL1e+ERNIboGFnUkIfN6xQZOb3UOEEzPqi0e1D5TDhciZBgDAsh4rGdLDYs+G1pXeWUsO91wktmjDvm3O5GY9t/3WvJOHMvuAKfXLsP3KUAdQz3/ryBZYqES2iuKrlV7nIrjxdbrgCecMqtoCLWQk0vfEl6ECeadJm61aJxMdKbCMwyxJMBDqs1IaK8FVxBMoflc+GTf9w8K2rJF7kK3cy/933mP3yw7pZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nrl8mbYkc8GncQ8aGaKUuiMS4We8xXjI9cI3oKPj+hs=;
 b=iWpOku4t9WC5+ATT2AAQcQ+FliSSi1r9Wh0lLJUg9N+Ms+SZVQl8ORaMFgXEM6xefBa/azoX0tMOEFGDZm8ibTvD6DRzU/cE8xuPg9CLGedp0JeZrQDomfKtsO374T8ZgzMl0WxQqCEN6VZ26iqV8MbYTycXBI3NTJMLsOHfE+ReHrLzvWs7/920INhBsukwbvPvreszOej0M6YGBFUTt/NsCYWCil7z5fiHiEPeWBrczHNKbm+ESQ8n3JcnRpMsZpWFQfpz5gKgSxz32b8e0/livTMRz9V+HjKZQTea3wm8NKM5OqRwlIPqRaFNBKmDzq8QFIoqXMZSYNLcxb+R8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9980.eurprd04.prod.outlook.com (2603:10a6:800:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:36:55 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 15:36:55 +0000
Date: Wed, 22 Jul 2026 10:36:46 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, stable+noautosel@kernel.org
Subject: Re: [PATCH v3 1/3] bus: mhi: ep: Add mhi_cntrl->flush_async()
 callback to flush the async read/write
Message-ID: <amDjjgkVK1clO0l7@SMW015318>
References: <20260722-mhi-ep-flush-v3-0-d855e715264e@oss.qualcomm.com>
 <20260722-mhi-ep-flush-v3-1-d855e715264e@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-mhi-ep-flush-v3-1-d855e715264e@oss.qualcomm.com>
X-ClientProxiedBy: SA9P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9980:EE_
X-MS-Office365-Filtering-Correlation-Id: aff292a4-8c30-458d-2dc5-08dee8070f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|23010399003|6133799003|11063799006|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iPyNGXaN90PN9T9nUiIlk16gmZEHBs7CWOBkRKCIC1hH9w31hKmitqDm++i/FwwB8Ud7q7geWG+IYvFmMbC3RY1zjRDBAielFj32BuWRsV6rXRxZqm/7gZQ4arqZ+f60KZE5Wb82H1c8gP9+YxC/8NWHVwZj1N8W2p45SjPe8ZaOkGyXy5mR3fidXV9vwu+7WBmQjm3urMGq19fkM7jQdpW/7mLscmQ59NM2o+R45QYNS+2sOX/DmquszdRUsbvLMRJyCX+mtr3uEIKN/+nbgZ7TWYFTnOQ03vfPuNF1VzNyKHb6hQk5rkC8CZxc08vvEtYtNv4sAk7SYUmU7TT0NDz6OlIoEl/BKyjEEYwPt2mnA4V/3YsRs6lumgVWL0JfY+SbUnHu/z3Ukw9O68lPADrYrhr7o1PAM3N+HP58gLxuvOEzAO8LYyn8Xockf2clyuHvyyxTpYpjxJrcedgK0stEaOrzr2mAl5V1C4vPI0fJB/OVs4IA+QYXqr4BFO4Yj7mzNV0U0Dy9VPeg+CCDTXmsrW8IkJe/RitQ6Dsitbm+yMA6tn2W18nKN831hBDlc4RJPRvrBET7ih6/GO352UMUpDV8aYXrVYZldup2L46CqgDCTpxKZeqOd8m4Ars7rlk3tKWwJy9XHs5TH92VCOBA8pD+wKA0pkp7YUffiAs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(23010399003)(6133799003)(11063799006)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KZG2HC5g+0xOjBkCzd31/uRVDXTYE8m30xQHSZC2U1pdcfbTqIJuAzal0GSS?=
 =?us-ascii?Q?dpTYTLtyE8CFmKxEUkojcdIo5L6pGv6Q2Z/ImHHNVots5RT1uxlZVG7jWn/I?=
 =?us-ascii?Q?Ws3wKvuDqo9cgk7/z8z+7d1hTrImkJTYEAqGlfNGKyvdTI585s1Z3WZtzwqJ?=
 =?us-ascii?Q?iljAp7GjXxy/ea3qzzXZk/Q0Fo1CfFH00yyvZIzhpw0FD0dPYHHZku5p+FtW?=
 =?us-ascii?Q?v83VRt6dSGR+2TH9GMSLFH/KBCzjtHV/03aA+7NXaMxaT9buMQQO8GyLCeqM?=
 =?us-ascii?Q?cFfZlmZv1c7La8QXD9XWGi5BMYtcnwQbJ0x1qyjuVtd/kQTblykzB5HHxD+z?=
 =?us-ascii?Q?VepcqIkltoAecVNRIwuTTUcA4lPr8V2ldBJ66/YDMV6bpRJpgdlAOR8IF3WB?=
 =?us-ascii?Q?UUw1Jhy8a/OnoCim0ITAxcvXyWUBlKciRyyAjXgJorLO1DVNTUgvQ59jM4QJ?=
 =?us-ascii?Q?xEBMB2pqLGN2XFEfjHR00IizsXCcN/yFOUnMyZp0OIzo/4Fj7LkdfFxPgaTj?=
 =?us-ascii?Q?QZHCbKbEtbJtlwsx2a17hzfW0oQbS3/zQSKZgVvgFS/QAciWoebkaQxntQ9+?=
 =?us-ascii?Q?chdszA4hP4miGVpdTb7dQFZrXylbZTS9tYxn+xTEITRAOdWvN/2JLNGljzJ5?=
 =?us-ascii?Q?5T4XUDnOz10FfetO5V8cxd1j7rCbmOX1G1QW2Q1Cw9Bw1qde9yW8q4/oyPwN?=
 =?us-ascii?Q?561ffc3vLzI122gRQG1NTshjTGw7JStKW/dvGTHvpgAiae1LUt+Egsq7L1x5?=
 =?us-ascii?Q?o9CyN8z7VYzcy6QJ32HF7U4uLpDhyPHHg1A8d5JAOZfVc0zbakNFu9uTwYSK?=
 =?us-ascii?Q?caQ2WfbzOJ7V14Lf3kpRw2IWm3ja8Fz02xzCakNnCAFIIDfnMjfeLxQjRbqj?=
 =?us-ascii?Q?qxXdZxEECHU+lvuNawQ5xCnkjmPUF4rxkgpkEhXay4e1mVjQH73vAvdgzILL?=
 =?us-ascii?Q?2Dz6RvwJQAnaptb1i9Eq6M02Tqjnh3M6FNmuffnjOLcHgGcWD63dK+FThVO+?=
 =?us-ascii?Q?GCIC/5rPOXycevvtMg043qnvNUoWeYf8qNPRlei+yhb8TCPauHHFUYTEEXP5?=
 =?us-ascii?Q?L6kFxxvun4XUv12YUoEQ81wYc//afnCXcAXh71hL5Zbyakc0lQ4L5ZNvbtAP?=
 =?us-ascii?Q?g8wzS/3scQ4vM6JWt3qdq6mb2dOJaikZCAH+bIkAd8SF6qxoKGyBSL9DSJKh?=
 =?us-ascii?Q?rQLkp8+CSqUhDnkmTPW/eeBBXCSC7H8pIkXp+/h8B2N/uScTyFx6JTKlZshl?=
 =?us-ascii?Q?l16/uvnHZX7K6+F6uJlANVpvOPNJc7btCvLpp0W9hkYCa2FNwZCNqDxzvNhg?=
 =?us-ascii?Q?DhVSlB0/5B++wQgbk8C+Q2tUrRsP4D2Hzsrd4qhcIHCNG8LY+X//72xB5U5X?=
 =?us-ascii?Q?PZZ74VTPp70JCp67pCcaKwIR2f50wKz0JGwaJq/9E5czu8dGsX7K/4GDrRw6?=
 =?us-ascii?Q?2qXC3I8o8Ei2bwQBangnK+koyDrrMDfc3HAlXy7BSWbS9+pKZX8SCXFT1Zvo?=
 =?us-ascii?Q?LIM09voMIoqMtKk71h5y6e+JaGo47An6Wq8KEBPbXTPthF9zOCFUWjiS700q?=
 =?us-ascii?Q?EdoqeszAI7fKKNo0NunoW9SaqHYYx74T1fC63lYqj3pzU35IfdD750mHQ9He?=
 =?us-ascii?Q?T1VzYwSPY+PXKFCqSt5waJi30SJVfbjyaioYKZATImaWeRQD5cWfIBR1FX80?=
 =?us-ascii?Q?zNF00cb1qOulR1u9q8OrGmShi1Jgw+rFGxeWkeHaRMdCyTemg6drt9iMR96/?=
 =?us-ascii?Q?3DyG8qObtWi4qh07aNuely1srLh2IZV8hMsvWeuIlsZH9q5d+f2X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff292a4-8c30-458d-2dc5-08dee8070f56
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 15:36:55.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMFjuQOgOgWD6ksvV3CyO1duxNge1TaI0mZjUAsSuQ3OTkDSQfFLT838esDEQVId8WfiYj4XpwPaca+exOlfnOv30wP+JKXWZo9mNGSMijcxBR8p6xwa9pIX6GxkRVUf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9980

On Wed, Jul 22, 2026 at 07:54:44AM +0200, Manivannan Sadhasivam via B4 Relay wrote:
> [You don't often get email from devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> MHI EP stack makes use of the MHI controller drivers like MHI EPF to do
> read/write to the host memory. And that driver is free to use mechanisms
> like DMA to offload the read/write operations.
>
> So if DMA is used for offload, then there is no guarantee that those DMA
> operations would be completed by the time mhi_ep_remove() gets called. This
> can lead to UAF (Use-After-Free) issues as the DMA callback can trigger
> xfer_cb() even after mhi_ep_remove() has returned.
>
> So to fix this issue, introduce the mhi_cntrl->flush_async() callback and
> call it in mhi_ep_remove() to drain all the in-flight async transfers
> before disconnecting the channels.
>
> The completion handlers keep triggering xfer_cb() as long as it is set. So
> flushing the transfers after notifying the client about the disconnect
> (-ENOTCONN) would still let a success callback slip through afterwards and
> lead to the same UAF. So disable the channels first to prevent new
> transfers, then flush the in-flight transfers so that their completions are
> delivered while xfer_cb() is still valid and only then notify the
> disconnect and clear xfer_cb().
>
> Cc: <stable+noautosel@kernel.org> # Needs dmaengine driver fix as well
> Fixes: 2547beb00ddb ("bus: mhi: ep: Add support for async DMA read operation")
> Fixes: ee08acb58fe4 ("bus: mhi: ep: Add support for async DMA write operation")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/bus/mhi/ep/main.c | 18 +++++++++++++++++-
>  include/linux/mhi_ep.h    |  2 ++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 0277e1ab1198..b94c571f01d8 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1612,6 +1612,7 @@ static void mhi_ep_remove(struct device *dev)
>  {
>         struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
>         struct mhi_ep_driver *mhi_drv = to_mhi_ep_driver(dev->driver);
> +       struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
>         struct mhi_result result = {};
>         struct mhi_ep_chan *mhi_chan;
>         int dir;
> @@ -1620,6 +1621,22 @@ static void mhi_ep_remove(struct device *dev)
>         if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
>                 return;
>
> +       /* Disable the channels to prevent new transfers */
> +       for (dir = 0; dir < 2; dir++) {
> +               mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
> +
> +               if (!mhi_chan)
> +                       continue;
> +
> +               mutex_lock(&mhi_chan->lock);
> +               mhi_chan->state = MHI_CH_STATE_DISABLED;
> +               mutex_unlock(&mhi_chan->lock);
> +       }
> +
> +       /* Flush in-flight transfers before notifying disconnect */
> +       if (mhi_cntrl->flush_async)
> +               mhi_cntrl->flush_async(mhi_cntrl);
> +
>         /* Disconnect the channels associated with the driver */
>         for (dir = 0; dir < 2; dir++) {
>                 mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
> @@ -1635,7 +1652,6 @@ static void mhi_ep_remove(struct device *dev)
>                         mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
>                 }
>
> -               mhi_chan->state = MHI_CH_STATE_DISABLED;
>                 mhi_chan->xfer_cb = NULL;
>                 mutex_unlock(&mhi_chan->lock);
>         }
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index 7b40fc8cbe77..f6383a57a872 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -107,6 +107,7 @@ struct mhi_ep_buf_info {
>   * @write_sync: CB function for writing to host memory synchronously
>   * @read_async: CB function for reading from host memory asynchronously
>   * @write_async: CB function for writing to host memory asynchronously
> + * @flush_async: CB function for flushing asynchronous read/writes
>   * @mhi_state: MHI Endpoint state
>   * @max_chan: Maximum channels supported by the endpoint controller
>   * @mru: MRU (Maximum Receive Unit) value of the endpoint controller
> @@ -164,6 +165,7 @@ struct mhi_ep_cntrl {
>         int (*write_sync)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
>         int (*read_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
>         int (*write_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
> +       void (*flush_async)(struct mhi_ep_cntrl *mhi_cntrl);
>
>         enum mhi_state mhi_state;
>
>
> --
> 2.43.0
>
>
