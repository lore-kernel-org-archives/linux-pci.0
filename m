Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013044.outbound.protection.outlook.com [40.107.159.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05054E4C30;
	Thu, 17 Sep 2026 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660550; cv=fail; b=DqrB2yf3BJBcJjPNvVyNx4mt/ywmISsSM/6rw0b1jkpgHRK9A2nqQeTDl6aHoG8V1jYQn/zP69Ea1mDq30kaUU6U0KUIuNwcSnHqHF0BGrHxwY+oVmXsW8coKtWP7k3UdoKFK9wOY2CgcsiSIQVE2OGp0N8DlD0uBKmv/3Hqxso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660550; c=relaxed/simple;
	bh=ypXUvrH3533+X0yR5L4q6H7Hd9ruG6UMOEWtCuGrgok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KspCoOE75JKC1bc2vpUFshZWohNnhN76QVMPvZaQUoa3IRwPtGn+GRMFjPEa66CAb1dhEItUJPbJIW/n2TSodvqUKmI3xDBzvmrA2eQo9mvHFor5u2BlcOzt+vPNqSzp0+IcGJaDK0qgNtMawTpb9y3y4/X6NhtUYADcaH7Lx1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R9Pnwofp; arc=fail smtp.client-ip=40.107.159.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R9Pnwofp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQ3BHXQ16CZHl1pnr/kExAzP1+P8w6DnaCux5NtnC8iI1leLJQ4404vO8JLHOSBbmn0PLwPMb6KzqFx/jCuBbQeJUxVTEjjr04uMs+xY94PiFHVAhOE8I609CLYfkn8VaYNT9kOu/aKsDXaywiSaK1NlMeeh8QRq1s6fQrTcDiiLelMLbldLDD24VX9DS1a2qJB30OSe5DO7Iux+C6/H7eSFrWwAT1OpOiqpd+wSrkXp9H2b4BIJITtRCtVmBtrMaqAOu5l0f1EE74h9R9uwX+5H5l179zEiC7dF4UnTfVH3rlZkhkF9tFytc0/hho/JGSNh15i+IDK4QYfauy2HEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLFcdEe4qcvZeQbFBV3cG0/cwcR7tiyxN8pT9j62e1c=;
 b=O3TX1t1s1aSKLZiQbT97aPkmj8MLEDN6msHW3yVuk0l0UBMe9scHWmu2UE6pgh/MbxYnA49EJ2DQe1glY++J/zOg7Ssit+zRde+1ZmgY6iAw/H5sjXo2qHhnrJ6Ex6OEFJeKdLocNTjB6TBwK4m/VHg53Fil9dRngQcwk2sAuYjWzF2oob5M1H9E8qLdWt0+t5qsvQh8bUFEbailuxebS59Z/P6Kghg70qCw/oU20H5iYo8rnrt9gTq3re7xGXA4sew//MU8bx2N3qFxIjUuoj47k536jPrAz9un98hJ6x/uHn+Vb5rZGRTzU47K8/vPyuCMGuNUtCquM1gD2Y1Lsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLFcdEe4qcvZeQbFBV3cG0/cwcR7tiyxN8pT9j62e1c=;
 b=R9PnwofpHIsClGoBNSfLMlZ0ZkaIsdtBYZAJDIM2x9I0hRDRxFjOqj49a5nHnwnLhg7Q5MBpBLinUxYJlmkgchKiVaEgpvwc2QbnJ1yOMrE0duwd86XTVCi6kNcfG7ZxqwvNC5vDtp8Sg/ENZcUO0hrZFYwZUCksc6ra+uSO+lWY4gxHsIaymsx2iJyZFbyE14AhD8qyZNxcnprKMhqubOp4IiAEFBRkfWO4R/8sj8EhI9r9MEwhemHCtd2jmD5yFcRst6U1kE4Va9BWPZ8NQM4dYVrGx6YT2XggAnceJE/51/wIDhd5z+msTpJrRMB15Q61cltAUKQ7k+wB+oW1NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8331.eurprd04.prod.outlook.com (2603:10a6:10:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Thu, 17 Sep
 2026 15:55:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Thu, 17 Sep 2026
 15:55:44 +0000
Date: Thu, 17 Sep 2026 10:55:36 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v2 1/2] dmaengine: dw-edma: Sort Register Field Macros by
 Bit Position
Message-ID: <aqwNeCmo51qm2_-6@SMW015318>
References: <20260917103050.1020982-1-devverma@amd.com>
 <20260917103050.1020982-2-devverma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917103050.1020982-2-devverma@amd.com>
X-ClientProxiedBy: PH7PR17CA0066.namprd17.prod.outlook.com
 (2603:10b6:510:325::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eef7f9f-b97a-4eac-7a78-08df14d421c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|23010399003|18002099003|22082099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	a9drOSItd4UAd4CzJcrSQDKSh5IXqOpvvLFkSnN+4dE3knjBqPeMv9nvKVTD3nzolEvR7kMiH9ALynyIwJ9yufW22bhVhnGbJOjU2u+ze3y6JG8RPgPKGFhn7PzFDYtWIDaifZfdV2cYZVYanX4iXCoONcJE0hVucKS/DfYVh5+dyLlXhJUs6aFQMh8iPPI2xM8Ur+SpB6Dk3h/WyrDEsjLE3EUEjt+uV/HFu3k0Y0BNvJ2ieCLngPDH+HDjSzIJzRB40IkmgFfaUTg3a3DrqJE2tPNl48LaWajGht+KCkhoBdKgN3jdK9oOrJpnaXciCL3lWUwNmYlJSkq065ZcxccF2KhawsuSu0qV1LQUrj+gFe2mPzbXJ/kjOGgF4Zly20BdKOZf3s3tYOjynLRcmy+ivulm4giGNuTCpVyJj94Gj7DHmbWfSKOb6fGJEErqHkCXJfk2tDtqlLXphO4OWB21oItineWSgN68ZjeroXrsyTjMcXHrul2PsjCPneSSn1II2WZp5ZuA0sl7pVsEYABrmLxT7RFUJAIl+ygWrtFKShDQTlhIkjiEN2WmsApbHVTxFgWlu58CfMCvRh++ZKGaOsaN+5deWBkx9ZM8A29mt48DaIXUB7FGHuEsSI4WodXxkyth7eBY1WIFol1nkg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vkxqbTe/KUVEj3P7Ansy8J9xkzi5O3Qo6u12l3dpQAl4XLy32KjeEjeuXYEY?=
 =?us-ascii?Q?NsO7LFbWt6S1IX11YwMTvL4VIUh6IghEyAbDF/e+HkXlybyfroiZMev9HrS3?=
 =?us-ascii?Q?kSXvIpzYDaVR6kOxgpaRI8f7KPw4dtgmzZ+aWJlfOlcbj3T5cYSRcAKWVaS8?=
 =?us-ascii?Q?A7Sx7rEXeXYIa7kaUQIY5kpz+U0+ROF3rodnojEB0FqTSoOH5cUf7APZm/W1?=
 =?us-ascii?Q?OiYqd9IellwsuvRqtN/pIh3on29xjyV4KzEzmZwWYP6NS74Vb43uFiAxI2YT?=
 =?us-ascii?Q?wS+KNCZF+LeV115kkO70YdNbIJ7TL5vJ6BtKSBCfoJ7XwxDGiA/IZJOg/HIy?=
 =?us-ascii?Q?XvcS/IstmafV1Y2raWpEoINiWZVGvwU42eo9K3xLaWJ70YNlbdHRTE578FWa?=
 =?us-ascii?Q?FvUShXQlvuOVvfI3MMm/8jmHxED3BR2X8GJ2GLK3gq7eAMTPcAr8+wTWHmJY?=
 =?us-ascii?Q?yYjeKYBsVKJcP9zxs442KPmin9spR3T6oawsy+b+urQUmJnHlyLKSVZzvtg1?=
 =?us-ascii?Q?RdaAoyGkZAsHzLzj+dk5tOq4KJuJubPPnbPiqlLi40IPFsXDFQwzxghRbZza?=
 =?us-ascii?Q?y9Wm+WiB1rgECxOI/T6T02rVWd/XLzUFyGUNtzEiE7Tw6tGHWV2Zuj3c7jkz?=
 =?us-ascii?Q?dURkqyuKVjlmIM1+JPVxeyyuaBb4apr07KmU2/4e0Tc2/8lxdxwFBPm9A2mF?=
 =?us-ascii?Q?IuBUO6VS5DppmLqon0JSpntYmr410I27HjleP4iln2iUI/ZqoAXqHEOwnuEK?=
 =?us-ascii?Q?avKD64ccQsyQZbIj+aT5fdw7YClNfqIPSI1U4AkGqBxCpaMJcsOek5VstjFz?=
 =?us-ascii?Q?kPwuROCXgk1PjCWTWTLRudVwED/yjiY87K0fnq8u3P64OuV7BxXtMHREmIbV?=
 =?us-ascii?Q?1vYxJix9Hk/jhhXpaH7DkogIm/JjlhJ2aSVGfQxSe+dXgphlh9z0oaZRM6BC?=
 =?us-ascii?Q?lhWILDzzvoJpismBgBIX9iB5TWbxzMr/TRn2XQMXlTW5Ytz04NAnifqNowOY?=
 =?us-ascii?Q?2Q2GjT+Neop+TrcfWx3LWqHYJywFJdPHi8mgOPk7g8p/aoK5y7dWWMlO/81U?=
 =?us-ascii?Q?/N80NshW2w3+wmkBotFH19XEE8+gVXrcH9ck4sWLrTzvom35OxClwDGnexVb?=
 =?us-ascii?Q?PJT6oa98fwBEE8LP20z2ufVJSIsXsqgtD6JmuPSGqCFtXdB0mPw2vArqEg3h?=
 =?us-ascii?Q?xjlmW4Gkm66kfQTXK4G/FoWchE6WzqOyT4wGEEzMM+l5k3OcT0VSjvnOPeKE?=
 =?us-ascii?Q?zbfqzj9awEDCcVG2+JoqfZFN7cijrfkoD8PX6mz0dhQBPvWWK4Wno9JwkwsN?=
 =?us-ascii?Q?F3IX4drCj3TWXQdd/PwXdkiUpPX3YqMsYGh57HqbsueYDLfuQSlUoTCrIsfw?=
 =?us-ascii?Q?JplWEQdYROki0mzi2MkmqfULbs/zky36g5W7WTxLrqqZOg8+2H9d31wwltHB?=
 =?us-ascii?Q?i67nVpWTyz0fPVPFizKW+WfjNsTuDc5lLZmbfvYkKFHoNA0k+j5Agw5sIgsM?=
 =?us-ascii?Q?t6WfUl7hHBuYQ6vnvYCD5pLJ1MWoEGA7ZT0UEU1mFMqhf8FufT8bl9GhUKL8?=
 =?us-ascii?Q?DM69TrK04bREqlB56cD5d4/CGx5I3xmXS5zEAg5EPQK6vjZrn+jlYGsGbsib?=
 =?us-ascii?Q?1B5d6ADE4W7TXjQXL2dmiKDF6FlWo1I0Wn+gJj74EH8YUh5Uic3V2+TOC9uj?=
 =?us-ascii?Q?1m/kupR4vXoMURuurMyk647w4CFc5RpmWxmr1In3fcm58DlcA/wgwUnuBFTb?=
 =?us-ascii?Q?OGBpmkCUzFj+Hd1nUKdXsbGiqFh16N3IqcSpyPI/bv3X35TmAXGS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eef7f9f-b97a-4eac-7a78-08df14d421c7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:55:44.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRgOUuEKFqYHZXYBjKaqNy3/hZ4g8AmglNaiZLohDMSiYjKaIPPRVZFkSHK2turWg8lCcrVsFg7SP7pMT9/gZRWJEqGgQylGY2kzo2+b8OPgL3T4xFt6dXKKy0BW9qJR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8331

On Thu, Sep 17, 2026 at 04:00:49PM +0530, Devendra K Verma wrote:
> Sort register field macros by bit position to improve readability.
> No functional change.
>
> Signed-off-by: Devendra K Verma <devverma@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v1:
>    o Corrected heading and body as per reviewer's suggestion
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 9f237ba916de..006dea7d6322 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -31,8 +31,8 @@
>
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
>  #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
>
> --
> 2.43.0
>
