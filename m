Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010030.outbound.protection.outlook.com [52.101.84.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B763B6BF4;
	Wed, 22 Jul 2026 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734721; cv=fail; b=YStwdmmNAmfvap4pHqBq3PCQ11lBPzcjPUV67/uDC447/2XRx4RtubHRTImtA3TjEXTvov5P5nv50cKoPVcd1dXTAkhq328E+1S4rbxGYUnkOK/W9YmUFrfrM4LCySUNBT9G7XdGKhXZynYOgS7irQHU0H3mglby4To83JbocwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734721; c=relaxed/simple;
	bh=We4oVEPiP27yZ0nscDq056BK1Pmgo/Z816qX+aU3NMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E4S0SFGnQzfzMTLrR1073ipAV/QyLXNa2iYosAWBvc+U/f7bllNVqE0Hs6raIDDO2oc+0p9/7Q1QgCF7DA+uBywWJRKhhXBO0So343m9N+BFQCgN6FmY8Iw5IVmNHChX/whGQWfpjp5h0OeawopzNuk5v8miqr5Y+ovXLxjTTUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VKfNxcYC; arc=fail smtp.client-ip=52.101.84.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VKfNxcYC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+z9ZCFRVBr6Ks+lNzLKYdqdD1R+2IBb5y+1OHqLQEtE/dGzhY0sav5osm6LOyouh+YILaMQjfBEkkDC7ZcGyKMzA2YxthrkLpFwQegAcdFCW+BcrHeb+8joF+T44CN7kpkDhhCIuGgOvgV211+2jIHI2X2sBQdSp3D+WRIu2NszlG/1QyL/jpd75HWD1+g67J6FGfxZAEsNF6N2YOifmS8Pw3BU8fuIxar7Q+sXXIlYjbSkKEcN5/YMqm3C/S5jrB72HZaIsdKvpSxGs+Ijxku59amkCWMl8wvSl7jmmiKDeeECV5Q8/KuXvE6cwj5n3LQa3l2ZNtav6KIMtD3OcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usU3UBdE4qZHU2qFpWHLnG5+J8xpyS+crCF7OeoPLJQ=;
 b=aVG1PZuc6RX3D1jyowTXs5tIHNLx8eBEce6pIH6JAL16NnBZpxC9nBWsl3M12d1DKdcoyhmVb3xRUn8GjcP9FQBf0vuA3HGypo/5F8xh9RtHUr2UY3BhEn2vijiYaUg+2o4IvXqhvWB5XW6sSFQAWHXuZh44mhS2RBncvo57liMqTWzmZMI1XIfWeJJ9YKw0Uto+/uA3EJCEbxNnBNHBbSAbIwfR/Z4679YYynV6WjMimtrkt7v+9ez3ES/nuAM59S82dzVZuSxt3tWIcQs2A225ckzoEst9TaLuhvZrFk6cZVrHwpUbNrmtpi6oX+CiFcARWmzd++/iIj/AzuqKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usU3UBdE4qZHU2qFpWHLnG5+J8xpyS+crCF7OeoPLJQ=;
 b=VKfNxcYCnNli27HopeEeHxqUUKBb2F8Z4QWslzi/n5Nr9eG7OI1d+aZfnT6m7nzBIN5ouxRkF7pp1GDXqAFxP5i7hUc+642Ccr6UV1AFDPB3xUUyIOGNZSsK3K3c094jxUZI0oH74sbHggsxHnskz4lETLu9m1qUNFtBfZ3wg0iYHTj7K6LkpPllyo2/Q0uW/WqGRD73O2wclKDNCCnAuVm+s0+BZxB98tlt6JUIxYUXJlpwnQfjxwhvs4LpmtxChZopN6EuGo3ycPv0ei9tZigLqHj1cAxz6ILaWGPCKCq2oCpISYS/cA2oPD0Mi2GFwOIaOzLzp1jB/uOIYmwSmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9980.eurprd04.prod.outlook.com (2603:10a6:800:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:38:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 15:38:34 +0000
Date: Wed, 22 Jul 2026 10:38:25 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/3] bus: mhi: ep: Flush async transfers before
 notifying disconnect in mhi_ep_abort_transfer()
Message-ID: <amDj8aKgZCh8j3wX@SMW015318>
References: <20260722-mhi-ep-flush-v3-0-d855e715264e@oss.qualcomm.com>
 <20260722-mhi-ep-flush-v3-2-d855e715264e@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-mhi-ep-flush-v3-2-d855e715264e@oss.qualcomm.com>
X-ClientProxiedBy: SA9PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:806:21::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9980:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae5be98-7bb8-4d0f-f83c-08dee8074a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|23010399003|6133799003|11063799006|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OiUht2/QldhHug7zNcYY7zkA4o2qRGTF9EmV0Tu8pLKn6+GVEhol4BkiDx8ZlRmEYLBu/2NNpng5SLcHO028FR7C0W2FxtqLLZbI+NwVvyrrdnw8tYHrcqoVNkr0g2VqNbyqNO1MK37zECplYxnuTmbc3tlsJ6bOaIpgRfY2JklqWaiO6MCit97Iho9wQMC7NK4K7EyHnoP5UYt1Prt/akbYYouOJgELwI2Unc8enGtKGh32/pSuxnp5f9i05l8KNWmw8pbYIyF03rDxVtkdE5z2gewhC84ezEs27/Bw6AXs9AnBs+6PlWbYEWYcTOQJ9UltG2On5LjCLIpVwUofqJ0JFBzvFghxEQCKJwB7KT+0gsEs8AJPAmONmWLoa2HpXfDv9ThgZ2YN4zPN/KpHFhvgI6UlpEDYBtAFt2+a+SzbO2qUjQDJ3wagXOGMuhM/yjfQ0bQAjPfvGE/pTJJcBawzQfXGgv2dIcZgraAju/O7k3+/7ZjHcQGHl67fk/DUtYA0O432oh9egok15rn+FR5wEe2D65MvHacKgCXBQ9GE6GADdKdqIuPdH/ukKzQ3lYhoDjPqVJozyLFLKcTsXu2ZuhY4ffcvKyLJsed41y9/RhnkJPB8Y4S4DRlGrsnEAMD/tOd0kzIdrZ/ADQIox1O84NEXSC0Vgsfp8UAab4k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(23010399003)(6133799003)(11063799006)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NUGHGJ7k31Y28vP/X9eMsY5flfHdMhTDOtVj6NvBGjytNoedFstWTO+QjqlG?=
 =?us-ascii?Q?WHIMWZ2SAubCoadC5uTs9oDPgCW3pU6Th8PEa7iPc01O7xs3PSqNc/xCHKzs?=
 =?us-ascii?Q?2J0460pK1EYEJlKFvp9OewG070gOfWQ/vfSPTX0ZczprzQ3ZBRKR89Cjf8Nz?=
 =?us-ascii?Q?96OEKHk01+8fs+lB5fFaj/yqIhoy/opuMrMruhEA5aEdFKkc9PHEbI46EiC0?=
 =?us-ascii?Q?OtGTRrCc9AlwnnTnEqqbkQ+kjDj+K6znny+ATpvRGH86tbaH/i6fra7wUsjN?=
 =?us-ascii?Q?mhNbZzayjSCjTr8+lwNwiSurqHPksfidox3aUnaRipMJdb8EKN7x+iQPCmuQ?=
 =?us-ascii?Q?8oKOqfB1JKS74o1yFlXrDYKTC9KIfju38y9WwVcBUgEVYmM3ia+nI7rR1iod?=
 =?us-ascii?Q?kY0TAG+P1lmxCAzAY1CsRm+dxrdavUSEUI2ZCM98x5elg4SHrh0zgNQlTAG/?=
 =?us-ascii?Q?g42R+W7lQikIHqku9lLuG2MDYK8Wgrw+H8i/mqZ41rN/Js2ELj3y/PBjBZch?=
 =?us-ascii?Q?4/AHNGDR7RhsxutACoFOLQeRNKPXhh3u4Ve06QuxNRcS8hGYhV7CudR3F/5d?=
 =?us-ascii?Q?pSMjRYgsoa8uOomXNbS+eqWsBTPj38+ZsUq51M/JUcqHfJGpbqXOcEho/h6A?=
 =?us-ascii?Q?gVmW6WFh5NM+D+RJhXDRoe4jTCp0fLIthlb9KJZzdWJDYoBuEmKuMUt0uc0T?=
 =?us-ascii?Q?ibmV9eEPn4I1NBzWYb2ogDmJ7YT7lnNBiObRlTTF0FLNe+vaJefiDAPmpWCg?=
 =?us-ascii?Q?LAuTo8SLh8UO+mynhZZOPT2cJ299cxevZdRuQICW9vFjRg2REFG0/xA9m7Kb?=
 =?us-ascii?Q?EbARPe9kze7LpBE/LfUrDIo21uSONYw6txZJOazR97yv6e/5zKU4ZyCXcHe+?=
 =?us-ascii?Q?xteJmNKfR8zfFhSJmJYL++vmdL+FKd6iXLU/2kvcob21X0dCcr6JbjTNfqMv?=
 =?us-ascii?Q?BAR3gRmUTdY78rPgEVYlq12cK5YF5gI5Yv2odZjP434LfS4i/B6CeKHkJSsQ?=
 =?us-ascii?Q?FHgNKZUIitL4256J+8jBodPU7vLd1+rF45gyOYI8DYa/40EN1xFn8R8PLoaK?=
 =?us-ascii?Q?zSC9JjakCk4H0fDxMiNr73VIdn0YHPettA0M6zuyzd05xeZyhgtWRnNVYsNQ?=
 =?us-ascii?Q?X3S5FfU0b5TWKBuufs5Pr5L7rCWJC6f0ZQcIRzOdaakAiuASz9uH358X9cWr?=
 =?us-ascii?Q?GKw8hBLNFcn63RJVhzcD7N2qmrcZuzB+SNFOoCtvwoNyJfucWIUEvqZlSFH5?=
 =?us-ascii?Q?RQjj8lI1by531t1mSzcCiS4m7+FUZz8GwAMD/NQaui1Dx/VIouLPPBwGBBGG?=
 =?us-ascii?Q?2xm5S5LlNoMZibtE5VyqHjDE94C88sEJoScx432sKQ98elGZKWPYLi2DHHrm?=
 =?us-ascii?Q?XkJZzs1w8D+1xLJH1Flt/leqXz9R1mKALqHjSCSABu0KstnrYtjDEI6HTlzV?=
 =?us-ascii?Q?D9HxNjIs0Frk9Ue+E9uGraZ+VZfQyG9bsOSs7q2SzfZUIWCg4yVWufeuOFKc?=
 =?us-ascii?Q?Nl/YjWibX/8ERPGovcMFCrMximOHAg9SVO4t9DjrPdBcKx8Pe3eiOaRfA9Tm?=
 =?us-ascii?Q?vXJZiipqdYW2Q1x3neQdW5Zw3OUyzso1ZnYLugYYYJIlJWgb1tQwjYaYBYF6?=
 =?us-ascii?Q?4LIwO37bloyUtltH1ttIcBVpfYD5uuH0cSVzp4usR/Fs40OFWa5pIGfnvqqs?=
 =?us-ascii?Q?nddvHCt07321R31PHSizj8vJnf0MhD6ivr0UdsfGH+7ol8MpCd0vPhGz/07O?=
 =?us-ascii?Q?Nq8cnbEg5607chJtwqGZpBH8og7adKScOQ1uRBN3KPporFDBq7KW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae5be98-7bb8-4d0f-f83c-08dee8074a79
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 15:38:34.7912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTOXuQ7phIuh3LWuO4NC+TwsDnGTIXBgPnHoIbU6xmgo5xMC+g5sJe0DR/4irnfOuWaBXaPVem3tiHq31eT1IKvqSZUMtBMcRNZJ/C7KQNvo6m3pXE+487Cv3odETzx3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9980

On Wed, Jul 22, 2026 at 07:54:45AM +0200, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
>
> mhi_ep_abort_transfer() notifies the client drivers about the channel
> disconnect using -ENOTCONN and only then flushes the ring workqueue to
> drain the in-flight transfers. But the async DMA transfers issued by the
> ring workers can still complete after the notification. And the completion
> handlers trigger the client xfer_cb() as long as it is set.
>
> So a transfer completing during the flush can deliver a success callback to
> the client even after it has been notified about the disconnect. This can
> lead to UAF (Use-After-Free) issues as the client can free its per-transfer
> resources in response to the -ENOTCONN notification and the trailing
> success callback would then reference the freed resources.
>
> So to fix this issue, disable all the channels first to prevent new
> transfers and then drain both the ring workqueue and the in-flight async
> transfers before notifying the disconnect. The completion and queue paths
> bail out once the channel state is not MHI_CH_STATE_RUNNING, so disabling
> the channels upfront makes sure that no new transfer sneaks in during the
> drain and all the pending completions are delivered while xfer_cb() is
> still valid.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/bus/mhi/ep/main.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index b94c571f01d8..51735f87017f 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1025,26 +1025,37 @@ static void mhi_ep_abort_transfer(struct mhi_ep_cntrl *mhi_cntrl)
>         struct mhi_ep_chan *mhi_chan;
>         int i;
>
> -       /* Stop all the channels */
> +       /* Disable all the channels to prevent new transfers */
> +       for (i = 0; i < mhi_cntrl->max_chan; i++) {
> +               mhi_chan = &mhi_cntrl->mhi_chan[i];
> +               if (!mhi_chan->ring.started)
> +                       continue;
> +
> +               mutex_lock(&mhi_chan->lock);
> +               mhi_chan->state = MHI_CH_STATE_DISABLED;
> +               mutex_unlock(&mhi_chan->lock);
> +       }
> +
> +       /* Drain ring workers and in-flight transfers before notifying disconnect */
> +       flush_workqueue(mhi_cntrl->wq);
> +       if (mhi_cntrl->flush_async)
> +               mhi_cntrl->flush_async(mhi_cntrl);
> +
> +       /* Send channel disconnect status to client drivers */
>         for (i = 0; i < mhi_cntrl->max_chan; i++) {
>                 mhi_chan = &mhi_cntrl->mhi_chan[i];
>                 if (!mhi_chan->ring.started)
>                         continue;
>
>                 mutex_lock(&mhi_chan->lock);
> -               /* Send channel disconnect status to client drivers */
>                 if (mhi_chan->xfer_cb) {
>                         result.transaction_status = -ENOTCONN;
>                         result.bytes_xferd = 0;
>                         mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
>                 }
> -
> -               mhi_chan->state = MHI_CH_STATE_DISABLED;
>                 mutex_unlock(&mhi_chan->lock);
>         }
>
> -       flush_workqueue(mhi_cntrl->wq);
> -
>         /* Destroy devices associated with all channels */
>         device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_ep_destroy_device);
>
>
> --
> 2.43.0
>
>
