Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70B282F13;
	Tue, 28 Jul 2026 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266345; cv=fail; b=jBVbfdH39wiEuHkG3hkewxzA5jhdtDUDsTY9FFRvSnSZ3xAOQ367U2HxBKWmwtQWdTiUB2HYzAObREt8JgO2OGQ9MIk3mmcWDAtBMW6R1NFpv2+5OQxJEDFaHRWMB3b0s/754XOXygDL6DR6nFwmjbv4prdneVBZKjE85IB/0Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266345; c=relaxed/simple;
	bh=ngRLp/wyFlxgQJH884V75rsMrK2/VRqcdSmCDw5e9vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GAADf1asHzuX/Uko7cwu59n2tFyCufwLY82uvi2utm13XSDJS82Xt/lFEJvYS8wqVPEMZ9C1V2gBsb8n9hIpDtQDdDDCpn8bQ/EHxMCB0asBi+LQxBifAZS380GAICDsk9ykqZhaTlE8n2t+oaQpi7WpmFMmOnfcp/9GzGHLptk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nPMsgheL; arc=fail smtp.client-ip=52.101.83.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nPMsgheL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGdlRsoiLQkIx+zCbcrZ6AzI+resnKe10zPcvN7/rVEkpHOHxYXE8FMMtxuXlR9rDdpsG6VY6bTDHFcZG5NwepuXT76vJmoBi92xKWOhQU0u5eHA+YBiJhEbWQyFPk/VfFbZLiXxGJW0OZNUM9ze8bINxTsolVXCQt0H1kvf8iFNsV5/PjMegOrVfEnzgdO9iq8juyZOoR2GHsJijYKY8fGsWcwwImzINAbApAVtVEFzF3GC1C8xcM7GKyhbbWdzK9Tfb2Koe3d+N5/yYSMXUkBWxd3xOdz5hCS25UCVkhINEnFEQCW8rKz5IV5EW+GBFqC6TbNYb8205w6ccjhYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkvU7P8Ma9P8w/RZW4M8xDSgO2ESaOusV/7PKqNcUi4=;
 b=OF3+s9Y1PFzJT7WxcF3MSB/PINNQ6+1HfDF5RU+heuOHeIEPU37fVlDtGGaDhHkRPAPZfbDhrRqyR1Ztj0ZIJw+wy/XVeWJqoINBSdinKM0NZ/wm120SR9SFjeLD/06FlloF41UV7fA6jBvx7WTsfqvywdNLUfmQYe2Na2KwGQ0VQrLipuSWxB1YgXkdnTTUb3k2gsqaZ5SQoUZo6NIts406nWd1J3/MuNsGUKb+ReJlhKWzZcHQclZ4fV3Mnsagg2PRYDm7IAHIUEcF/bEqDvdLooVpyL0djPHSz9OYzOUi4WCXZgAB7xnCXiAKH/uq/BLfQbAIUDG0wNAKmEKh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkvU7P8Ma9P8w/RZW4M8xDSgO2ESaOusV/7PKqNcUi4=;
 b=nPMsgheLP9oF2K2ZaJ9crAUByUS1sM8oGaruzdBWQHfYftfPP8xpziy2qUnuAzw8El+x6XnldGU4CFkMaFbPHW9kcf2weSnDpaRPOZS67MHlmKvTlEl8QCrBoLxrwQmSXHx1EuX8trPRMoBeRiz187CuW9pWdPwHObjF6evLpc+OQq4Mgm8kiPI51ZvUB/bxOSIYIomvaT3Iu63Kx6EvjS3A3ilgUaBjZZC+PnyaRmypyYLYh0le0V0NUURZe+dtfxtxh9T0oUKjyRBgk0cdDMBhueu6xS2SPzX2p38n7ZDX7C7V/EGj3T56yiyO4wrPHBWHt+qelkBVfHHGNU6Mmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMBPR04MB529741.eurprd04.prod.outlook.com (2603:10a6:20b:789::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 19:18:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 19:18:58 +0000
Date: Tue, 28 Jul 2026 15:18:50 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: pci-epf-vntb: Pass PF/VF number when
 BAR programming
Message-ID: <amkAmotCC7K1bORZ@lizhi-Precision-Tower-5810>
References: <20260728172306.2751813-1-den@valinux.co.jp>
 <20260728172306.2751813-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728172306.2751813-2-den@valinux.co.jp>
X-ClientProxiedBy: SN7PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:806:f2::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMBPR04MB529741:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6d1782-315c-4bf6-4117-08deecdd1297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|23010399003|11063799006|4143699003|10067099003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mDTobEsPHVXdm/mTUb4Di4hueeFL5b0dVu+ssRfSd7UoRPqf7beq/jwZ2VL26ASDEAnuUXUOas5MJlVU7D1eYp3xFdg/WSAPdPPKs5ZnPq5cHQyjrDRMCYOHlt3EWErsw0zAwbFtNL3dDghiMd/YZmh1ztI206UWBOj1Ndo3LVQS8Jziy/W8r0A5krlckMQXdw5o0apxfvqycwMBbBBq3sAhYvEYEibU3WV8fDsIRdlF1yKXMcLwocyLS0+mu7JHOFMGDIR3si2QPpHR9RxjMpg+oH4QEy0Ujewe1bs6aUYrq0WBmxkNXyYPBF4UtzK86okYbwm4y1Xz3Cc8NyzPmroAQdVF2VVN7dvVLtkGx4X3VMCQpr9eQWU/eHgXnxaqGw7WKhtQVu7ShlhiPAutMfI0fllE8JHu+U9T1aw6dXiFUrk2/GbNGZfkENaJYGz6ZBSzI51dQuCCxrWk6EEd7heq1xBJfbyhyAi0ucpL/8B6g+93owuneOv3WRl0hdf44QQRXFlZzJeru+mpmWSclvkYEny0JDeT3GM0sP5nM2GnR93ENQ7PgTa6Sj4MMSrCBJQ+npx/ljNcPXQNZVI842fwUinXNVX7w21wQ/l+u+Z2pSIkVfjletPaM3KEJ/9C3NWC7rTeLlG5BoqeSJboFrckW/K1eOus/8PZbb5GiAg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(23010399003)(11063799006)(4143699003)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?epyCixEi4TwsrGqxbrh7jkp4gx9caeZ+qlDpksTjTkBwKwJsx82GdXMaF5W0?=
 =?us-ascii?Q?feFsEkPdovX59icGkn89UyW0ZKwz8aHQBHuIANftl7jpF+izaHefxFaUPqpY?=
 =?us-ascii?Q?tMoCBKu7e7uPNb4vILaRdZUCfqcMijc0eChNY8XZKg9u0XaXIVADKpQEeJho?=
 =?us-ascii?Q?nlfGGzOJKtKp9LkYqHgmQqmvNscvO15MpItFXCjwFVVGD5yB2S77aENs4kbh?=
 =?us-ascii?Q?GGt/7Fps3XHMfWuDJnprWT8gt/mOfcwPZ071PKzP1fsdMoWR+A3oqm38cMQB?=
 =?us-ascii?Q?lx4r8GyfbDI8Vdyr8sGhV686U8Qu7e9L0eS48CKBWQvCXkmkY6WgRCYoP23Y?=
 =?us-ascii?Q?c9caEtSEYjyaSOyxJ/kMRSRCCB3puKvfTwHFiFtA6Z4ZWCFfP8vLLz/nR6v/?=
 =?us-ascii?Q?Avol4VbD0GYGgb2AZK28nzvbPWxaZ1B+e0nRgGa+Yn8cev8b8o/JVeJszalB?=
 =?us-ascii?Q?rWNhjGI0g/zg6R9DlJMi/0IyVh3yGuIwj1Q/EnhWb+It7tTbBmikmcJExmh0?=
 =?us-ascii?Q?1pTIFZXwC/OBt07phFsPlwBIgFc23n2L7+ZyV778QZ0HrHy91RTxgBZCKXss?=
 =?us-ascii?Q?5p4IcAmwaTfuZ0WXRi3wtnjBCQdaLzOWTJkn2KH1nqDvNq3JYmbEfyBRdcBC?=
 =?us-ascii?Q?RYtVdfPmMmIVeF07cyIopti4uXeIfP2DnWHCtQQsEF8KgNU3sZb2B/d9hzOj?=
 =?us-ascii?Q?m7+V/Uf3JXNBA3EzxaBU/3NXY0MyA4RnD5AKN2yWuqG1TySJvPggjTVIyOjr?=
 =?us-ascii?Q?uaXBrInr3Z5ip5AnGOshRlQj9w4smlNop02U8Ja9b9JnMvtcXsy3i0mU+DrE?=
 =?us-ascii?Q?/xVog0GpZTY03DOMyxoGBfFvNMGJhrljrrscYeZYW8pedXBkaY5NHm2KnDGV?=
 =?us-ascii?Q?TioSGuTQ8QMELD2WlBTN7tCElsqEt9JB9xhyV3KNZTMZAk37TVYgv8BtQ6iZ?=
 =?us-ascii?Q?iJB/eeNUY7j5r72Jev9fXcFpEuT3GTC8b1dsCpOtGdbPw2Y1ejbpu8P3LB6G?=
 =?us-ascii?Q?qBs7hyZT0ZzOPCMb6GyMktDHjnKIAqHJyTBYS0COO2eZT+c/ICXZkXcUcfZO?=
 =?us-ascii?Q?rcG0JDAMVFB2vUJcUjzav65ARCGAyCdGXFHLwhOJrhx1zypJLTcSO2nF0vPX?=
 =?us-ascii?Q?/Q3Q2NHCpJMERrPYIzlMkzs1jwU4rpgCOiVgOa/gURctj4bGG13KBzgrSr0K?=
 =?us-ascii?Q?sMJDa6WFAw+WWa+sr798y8gv/HYH6fohwO8hWYMgud/jRVX+AX6d91kVUz5N?=
 =?us-ascii?Q?X8AEWb5PKbdIjP9RulFKcmrXl8zoYnWEtEaje07MJC8LxBBtLJzAATTdLAZk?=
 =?us-ascii?Q?mwvBeFO/lv5YLj1ql6uEVXcAG6aCpdeaC3T4z76OBhXJy82SOEB48xR/RGE6?=
 =?us-ascii?Q?qQ/IhlZHreZbUKiial+1bKuCUSCbHboQzmx6r6nZ/L0CQknvG2374xa7XFdE?=
 =?us-ascii?Q?6wGm5oefxw4xFCNTcwKA4XSjD21dWpacs9hRICVkjLm/kgTu2Oaxy6NxQIts?=
 =?us-ascii?Q?u0aywMENOam14kpG0GjOlpYEhebJvigbw81HoZy4Aj/EYP2Aa1H8sZNUaktG?=
 =?us-ascii?Q?vxi0X1ibecV/TEdijBgwCthQ3TqRqBWgZNCrZK/gCxpp8pojkT7zZyy+EGst?=
 =?us-ascii?Q?gWG7JrbP06yVhD1ihnnz5cwBhG16WdZBL4q9VH4F2g2XZ6rqiMPn4eepm12c?=
 =?us-ascii?Q?BoqUeY/rpYBxwpvOf+PPhmAM756XFdxxnmha7csFL+ITiKT6lKhcntA/pBff?=
 =?us-ascii?Q?ARlfUBuGAelSeFounYDsp6fW82EaMDtoJCoC5XY3uRZX2ajLhEwm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6d1782-315c-4bf6-4117-08deecdd1297
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 19:18:58.0440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhPHmfurzK4RNSjecGno5XoDPwXqJA4cl0vYjD+MAiEbshquRgDJW4cFWa7fxQUChKo0YnUPH4HcdeggEnBv9QAEV7MzGEGGuyGFago2HnR3VWPGNjnU78T6PAxlhrXc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB529741

On Wed, Jul 29, 2026 at 02:23:04AM +0900, Koichiro Den wrote:
> vntb_epf_mw_set_trans() programs the memory-window BAR through
> pci_epc_set_bar() with hardcoded function numbers (0, 0), so the BAR
> lands on the wrong function whenever the vNTB EPF is bound to anything
> but PF0. The other BAR programming sites in the vNTB driver already pass
> the EPF's own numbers.
>
> Pass the EPF's own func_no/vfunc_no here as well.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index c3caec927d74..fba65abfb6b2 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1427,7 +1427,8 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	epf_bar->barno = barno;
>  	epf_bar->size = size;
>
> -	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
> +	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> +			      ntb->epf->vfunc_no, epf_bar);
>  	if (ret) {
>  		dev_err(dev, "failure set mw trans\n");
>  		return ret;
> --
> 2.51.0
>
