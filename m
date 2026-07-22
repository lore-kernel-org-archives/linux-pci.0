Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8743BDB4;
	Wed, 22 Jul 2026 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734769; cv=fail; b=eAWEtg7pUVKzudNIPFCvTG/hPNeO3U1A10DAhcMGFlV91vqNWB62kfaWBF2uWsynV+q45ISlgoemxBtZrvtnNxeg62JRegtFRChJwDAdfV0AJqvF+3Qref3gllomFZBdvZYnJO/qwtcAEUpnicZ79w7V96W2xTMtkk06fLSHDcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734769; c=relaxed/simple;
	bh=+DaieJ/KRyW8S9fFkdXtx+Lp60ZL80kdsVkUxU+h1OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oCrpiptxAZWLIc7JohCPoCN56mT/R43ad6/T61wie3QQfhaSX1rcKxm8MFd814R9hJj+gP/S7/qf6PYQwA9q6Vs+el4YhDj2pAZzYdFQV7YXlbe3jbaFw+sUXSt8Ehmep02+h6VixQa95/oK/WnFe7nJzK+SJwTRNj6pW0e7+Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OYn+sgy8; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OYn+sgy8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PF/E+WfWRvrfgDngIDCzZpsgFoB1AB4YZ1EcdzYQKPKWpWdC7OihFNFQjO/n+qHYdSzPUO04cJN165DEIHNL0RCjGntTn2N76yfMIdC43ko68mlQBsn8HUndLTsgU8eDOMafRBfWhbbMTBMmqJ5QAXjpAvmFBmW2XU7q9p9I9aHWibFwv16/y4l0JjO1/e0A57FtgJRhYSJhDGPEQgj+1pO+QFc5FRZvYkoNHgvExpB10TbogwC/7PI+vjWXkaBspVZjjA21pexFZUT3z2krRfLN8JaD8qRAG79+YjxkrP4M7Zwd2MG3dZM+TWwPRpb9Mipu+FIXLBqrHVcvbMe/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snaVo8FIyW4oVp0nTvc4K7eFtkKPuQKMU9LCUWi33HA=;
 b=OVIBjjguLi1eZeQASnna+YDCGAGISJHNuKD0XjM03wUJAl7TZU5NKGLyOME6C6lDKpi30lCnJwfO9L2MmeBB1M4lUGRtv3sZ36XprLsopGcKn2nM5GwVpirUICay2uKGfepBQwOb1qxvRlJM2PrutFXnU4qlMZTdRBGWZ5NgQzbNSbv3KCSTTJUJQQLZn5SJaqCnrNbT5VcGEqtE18luiXopDH7p3sViVZMuFE3FCTahIPM7ntbZSVSzPobKB7Y20+n16jM7Qz2Il/IiBVxQlvEcjYlZEZxB6e0w9NmeC2+Ay0yp+A3c5qF686FaAkDeIf12w8VJ+DQgULcCvtmPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snaVo8FIyW4oVp0nTvc4K7eFtkKPuQKMU9LCUWi33HA=;
 b=OYn+sgy85HT/OnyYPylOPyoAQD4iTrpr3VSzHxDiho6/M9aNrXJoLopimAlX9i7FLDUIJ54ni1TxQF1OFGRo9y13VPMsArNr3i2LRduhBCUj4h/d5+JwdBSW7ycMPTqh2zk486YyhGBOWr9x2dmlE8ZR1C/eR5TFAYY3wQWxdgHmRQly+QGQgDVbVfNx1yGlwA7bXZhlP+MC71/IDzsj3ffRBkiXnoQnFFWr8VQKSH8s2wQOnvbhEOkiUvKinOJdjtvTgUKdNTYAvcyD2Mob0ABB9pGo9KLev7/KjyPMVAtaem63C+GsEcQrdkLg5DC/VaG/I6JpoFBQZbwkSBE8bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9980.eurprd04.prod.outlook.com (2603:10a6:800:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:39:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 15:39:24 +0000
Date: Wed, 22 Jul 2026 10:39:15 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: epf-mhi: Implement mhi_cntrl->flush_async()
 to flush DMA read/write
Message-ID: <amDkIyFGifjM15tY@SMW015318>
References: <20260722-mhi-ep-flush-v3-0-d855e715264e@oss.qualcomm.com>
 <20260722-mhi-ep-flush-v3-3-d855e715264e@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-mhi-ep-flush-v3-3-d855e715264e@oss.qualcomm.com>
X-ClientProxiedBy: SA1PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9980:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c62f77-05e9-480f-5e9f-08dee8076820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|23010399003|6133799003|11063799006|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uWyKk5dCtFEtKgg5DGq0KKSr+3WkG9WDGc/dnPkpaRKA121Yu+DgAwO9bZxJQdHe3u55u9zcjEAo1IyukQkAO16MCgzD56Oqnj5Bc+6XYejvKp+/RHfApjtObyx0BvqOfuCHC/Q/dkO03+E4dm9bINWuaPURcdMCdjXsiMAD1QKsry/tIHzXdITwzulLsvWpXxOdGzvEyWyfz2wPVFxOiSi+Pm3hDTvvHIsb7v92b1Lqd9xAYcwA35hecJbA1klfo+IFsVPtGJsvgUhzQmBPKZQyLUIew9muhc9v7du7JnlFG13bjUIYtZ5I/mJz9pGoK2lgtapMa+fT7IDlpr2u+3yfdalqvacVgyPuGiecG8CMWE8jVYu95IghjE58SSnNCK+ifCtb+h8H2yKzmMKVoZPM7JnQrgLKpcatFWHfGbjDlBrM+zFj2Vp956olI0GXeERHT4dHB2Qd6g7i5qKzhH5nCHjgT/hAt1DNCFariTxjO0BVkSaQmY1j+nkQD8C/MhZOGWJpXZIZ0senjIewy8pWf6IdM8iLvOnn5+DIQWPJ6j994lpWm+1pp43psoEnG4zvuasK0H6gOR/ZmjoSdKuj175Jiq62OSJtz9sTO7kv8bYGzb6dXfZfxP9EjA/UpDK08Xx3JRhZlQqzo4MpHEAQ+Bvc8vye5zY0Ppn7P4Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(23010399003)(6133799003)(11063799006)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rs/GqA8O6171oI7gsX7OyHEW3ucRXj2sezA5beQ2RRWnIpN5Z9lpk4eddXN7?=
 =?us-ascii?Q?gf3wAb4yHZVTYAzd8FiNXsNUbdbl7AfMWpZt2NM2dgyMZ+sKMMj0qxPulqdv?=
 =?us-ascii?Q?t1WD4Xo9r3drhGJwkTF+/KcdGXLBGmf7jneJWKDYRPpjEIctOPZJNjazU08j?=
 =?us-ascii?Q?9mN/rIIl+VGMbg8JJd0jiTHfOqibMk/KzicPbJMYQWzmVcsxEz9zhh/mr71y?=
 =?us-ascii?Q?djgWeF8vSuP5cR7VBVEVgCuEfMmChjnTzSvUAcEl9/eF6D/aWmq3MayUnm+F?=
 =?us-ascii?Q?Lzp0mGEqcTuaFkSJyXfjBdZjcgeaMVkXQYkq77ZBCtTBnfa0seZ8eHms4utb?=
 =?us-ascii?Q?zQSUGMYCYouPhMlZ7lTHlJpqjVTlCy4V1yTQEJPLnarb35PuxpZ6uVtfEMYt?=
 =?us-ascii?Q?wxu0V3f4BChStIz8hUqWx0iRlywj5J/sLDqwqTQZel0maB/HgNRnhnYoNm/+?=
 =?us-ascii?Q?TgJAH7kvEnggvjPRzT8iVYEzBNijL4LFQdyfIGo6H6b7EuG9J+4IcEcuDUYK?=
 =?us-ascii?Q?W4jDhFQOqBf7h+y8PeRNT44jtmYbjifjU61PCK5p5+t8vfD/1RGYPnXlxJ5b?=
 =?us-ascii?Q?n1cUskF5bs1hExBEq3Jkn1HNkP6c25Tz7UM4MIXI73cosIlOeukg+yJJMoWn?=
 =?us-ascii?Q?04jHc14fTn697lQg+OAT2kvdTeGSxo4scuBT4uNhklLELx/KZihncLn+yxb8?=
 =?us-ascii?Q?Bz2UxWdw38+mZe5ephUoRi1xKiDrSVmFMwVK/Lyaj1afWredNmyODSlsSfqB?=
 =?us-ascii?Q?s9rCnJvRe7ohcrHgZILWu/27Hy5gCnWsyWynFGDSoIN/V3WRn8LKBKqALEJl?=
 =?us-ascii?Q?ujhdUGiI12SLuq80/HnkfpzIX8CeGPmzLGUhvCb0BSbFmyVr5OsSp+PF2IE6?=
 =?us-ascii?Q?OAwbNKrYrN8N5VNbeId4QoVRweJcufWaQABsEL8mt88MoGQ+ARRI8lM/4ywS?=
 =?us-ascii?Q?mP4ijtMVbqvLZrDUSuKXaqzeIYIj/4GUTNMKL/me71Ujevc3HSTeBDlv8iY7?=
 =?us-ascii?Q?yvK9SSUNeml8J5g5jyfx8uaSXj2t0oHuR2RmF5IbabWS1rGHVvZ4/CcdhY2n?=
 =?us-ascii?Q?z3FrmiX9E4nbcW+OGhgsXnQGxu1Xh6IPhF/GJggmyaWPaQgNVzFpt0u2mpep?=
 =?us-ascii?Q?NoJRgc3MaWxnXZyG2sP2deIiVU3pgwGkBWQfI2bExqTv6mHoqq7kFTDMOmvW?=
 =?us-ascii?Q?Nh8/BVbgmp8C+wNID5yoTxxxKY9l205ZswKNVTeYpCSHvLpGIq7Ivw6gt+gQ?=
 =?us-ascii?Q?RNRoqhiUowm08S/B5+8H/grE0bjorEioroGOFWucPjZidHtkur+WOTDTLDyl?=
 =?us-ascii?Q?da4yQ04prFLxTMS77LR2ICw42TbNDIZUQJT9syOeuFIED6xx9TDUMIr68K9T?=
 =?us-ascii?Q?zCp2v2Fb6NKGfM9Dcosb1YW6qt+p/lYSV2kFIV5ntz6+kqR32yVkSQCzDfGT?=
 =?us-ascii?Q?TKU1OwxQV1T0eArN1B/pjBvw2PtgBtsmGMejwwGhrfu7VdbD7uj/42RFElJA?=
 =?us-ascii?Q?Gf/0CMxwLy5Nf7FLwS3g09VotuR38YGw7HC+P+CQnB2YkarFWBgN5/2VBs+3?=
 =?us-ascii?Q?ZSWh/biZKO1axD2UM2crjz9u5ND76NTw3a3yFAXnQ+oqJG/tEeV6vDQN2A7q?=
 =?us-ascii?Q?DywqXInsFU52Bz0AGqkcy6eRiStki+J0sXnGyg7DnfbNzXthCR4FXQdxb+eF?=
 =?us-ascii?Q?dsWOltRSo6ST1DlWVrtjvXJslK/eSydtibXnqE2csVtj9hwSkOW9DZoO0U0g?=
 =?us-ascii?Q?Iy+PZB/igHUNx9FuLuskn/GVLvPjZvZNDcKDRobmNUcESgpylndT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c62f77-05e9-480f-5e9f-08dee8076820
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 15:39:24.5341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZXmti3Sp2yzM11EGPHMjwcUVhq4whU+2Y0cS981RLmZeCPvqjbF3EdWGV1q6IFSfZt4+MC88QI72dfJSJ64tElaXdpwgHVrESgj4WWb5slIoNUvK2VCCrXzmtDj6/np
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9980

On Wed, Jul 22, 2026 at 07:54:46AM +0200, Manivannan Sadhasivam via B4 Relay wrote:
>
> From: Manivannan Sadhasivam <mani@kernel.org>
>
> The MHI core needs to make sure that all the current DMA transactions are
> completed before removing the channels. So implement the
> mhi_cntrl->flush_async() callback by first making sure all the in-flight
> DMA operations are completed and then flushing the DMA workqueue.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 7f5326925ed5..8d2d9d01cfd2 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -644,6 +644,15 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
>         return ret;
>  }
>
> +static void pci_epf_mhi_edma_flush_async(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +       struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
> +
> +       dmaengine_synchronize(epf_mhi->dma_chan_rx);
> +       dmaengine_synchronize(epf_mhi->dma_chan_tx);
> +       flush_workqueue(epf_mhi->dma_wq);
> +}
> +
>  struct epf_dma_filter {
>         struct device *dev;
>         u32 dma_mask;
> @@ -812,6 +821,7 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
>                 mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
>                 mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
>                 mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
> +               mhi_cntrl->flush_async = pci_epf_mhi_edma_flush_async;
>         }
>
>         /* Register the MHI EP controller */
>
> --
> 2.43.0
>
>
