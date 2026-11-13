Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794598508;
	b=Nyf140qlqhMqIMQg6KX8W+uSfsVfwdAXAc5Z/90Go9Kmd32V2rmlRepm0RMv5mGSfNzU
	 Tem/g00dflyuWB/0Q7D3oSqIulFijqhNDp0uSSeNASgjeQTyR+1hngImo7Kl75NqeG59D
	 lcOzW1pi2vLg5ZGXyoX0gjrqbTuKiLo4waGP8MjMnC7oMziIpAFr/TzuoPpB+/jU9Tqmi
	 o6o2eWtdfkOmWCeQbWx/CtCLDcwXZlt7HYB0ru4pJ3vZcAln1mpnjEjvQzIYeByfl6HK8
	 BHHncLwdHo9EYBdbLV7IihgQclUvzoBacHZIsg5sZJCkEHIg0UX6WjX5PhZrGK2N1AQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598508;
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
	bh=Zc+pN2pP/kPSq0Zoc1phsdcblWD0OFgX1sQAfuHiQAA=;
	b=5NCxz7rwHzRkQs50bkgeySzur6F4OU5jPUZto74n1Gq1MHU48i5T8RR4z6zcNj/uP1hC
	 ZcCNsyj8VyI0wdh9BksrqbxTtwjxxh0PxE/jlV93EDjE9unbXDoZqVvEVOPj6RhblEGd/
	 FrpCCgKlZ1x9ACRVUK0CWujEFDRpVKS1O/7HukyM0OWwAAsHkfJ9OKtun8WbxuAdA6M0P
	 oBUCVeVv3xHNBddo9mz3Pi3ceYZ3BijS33WQi6wS5eh9rfYhKgDRVPGlfebYuoSzxfbiX
	 E/SyehlifwcWDNSuQc9fUNNUIQxhJ7irY9zB66ZbApegbwyds2TQwWJQr6QSr5bFk7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rSkC4EWd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.67
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0EB606A338;
	Fri, 13 Nov 2026 19:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C0EB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rSkC4EWd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EN41dnLejyahlcbFgmcwmdpTimvhgCHn22Um2La0nCIj22wE4ixzN/kZL0XpTS4aLqnoh+yANbxbAZKqhi8Ewxkw0ZhMCpVN8UjcIBHTCvwQEqZGmXl51A+1/NtLYRVvMSlLgAFvF6rAlSbpPhWeUsQKExNBJtqogR5NjZImiLvzH6t3JIvEHq/vUfiZsA58MNBoGh5Stq60uwxKUJHtQKqP0LOrUFUqttTLCP26rIvxWnZQ5Iwnq6vHzHCzyQCwyVVjXofaxnu74iY+JRb436ogQLlGmUTpthY9d4PsW6nzbnvAw6tRzQKcIkk/+9TH4XEUHlmWNnrreN2HeJY4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zc+pN2pP/kPSq0Zoc1phsdcblWD0OFgX1sQAfuHiQAA=;
 b=Cjqa4manoUFvJGGXOKfN+Bzlgfun60xI2LqScXQULYG8ZMvnsvzn4ZPJg9x0xghmeAxQ2ptJaqQ6XfEXMnWTUiqT1+78kD9w59iLXfn4RVBQD72V0c3k6yLVIDaOMUZTpuxjqDpU113fMPv3wCBSk+6izqkinW3YnQ3EWfS7PsqXKd+Sz3HLwBjUZ85htbjyAUcCYaIdjruBCHr7TdcR/el+G9ViZEZSps2ZvTBLi7c9Kb9rC6eSkby0/D2mWm3ZEyK9S3nZrVtfZetamM5AVEmPEt54pj2CsEsU6QbORlrr6BOpGwr9d9v/9TPKz6lw0v08/V5VyI0f7Bo/YpxQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zc+pN2pP/kPSq0Zoc1phsdcblWD0OFgX1sQAfuHiQAA=;
 b=rSkC4EWdAL0BFau/7U03+UEnZB4vCSf4Eunjz8Zz7g5TlHeByT9IEFfH9NWuARxELDiKQf9sKNLEAJ5+H0yZelwZcoZGKJSns/R5/LB1DdNcmdHJ7KW8FxBbbmpTvWHlKthmHjM/IV8BWtv2NBhRwwplLXd2gvrWqBrBTJb/FYNVv636cA1tQEIEY7j9dObHyU8BE4U8kIDFT4VfezSxPAuZCGVsEOP6hLFMrY97/qeWk9MDxcNkcp6ia1mVRwXFOET9x+FMaRWRrLkc1upGS2Fp876PmmbQXc/LcSXkCqxXeIi0HmYl2yiSKIeMil+JeK00+uYgorhdJwuQBW4+oQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU7PR04MB11089.eurprd04.prod.outlook.com (2603:10a6:10:5b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Fri, 13 Nov
 2026 19:35:04 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 19:35:04 +0000
Date: Fri, 13 Nov 2026 14:34:58 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.li@nxp.com>,
	Kelvin Cao <kelvin.cao@microchip.com>
Subject: Re: [PATCH 1/2] dmaengine: switchtec-dma: Add Gen6 secure device IDs
Message-ID: <avdmYiUwX2ihWQao@lizhi-Precision-Tower-5810>
References: <20261103175208.481170-1-logang@deltatee.com>
 <20261103175208.481170-2-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103175208.481170-2-logang@deltatee.com>
X-ClientProxiedBy: DS7PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::27) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU7PR04MB11089:EE_
X-MS-Office365-Filtering-Correlation-Id: 273cae19-68ef-400b-ce2a-08df41bd373b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|376014|22082099003|18002099003|6133799003|10067099003|11063799006|261026121527099003|261021121427099003|56012099006|261021123027099003|261009223027099003|261102123227099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	fA3HeLtrtxbR3b3lKsTCn5aaATKh9yXncOEU9FOBY6BSJUX3oCwFpCqutAvG1QfsXQEkeFJ1RT9m3YVu5QEBkxj77ksy7g8MjGXU7mEhOKqsO35HJ5EGhKYYReY6KCVfbpEPzWF+AFp4gGK0NSaalkksrRDXxPHUc69CCMym63lrtYgLZ4SJjKyD870pgfaNUUm4s9U0/OeQAlZ1f7FSHXue5+1g1LY+aIEManrkuf2tUZ8tEm3ofOx5a+UDcrbYxD6XXnji+No6+jokq6aoJk1rSTQg6OH363khpbMB4DW3ULNtbD0vSRSE8c+tmm8d4tcm49KCas1rKF7oR9I+8I6naubP7xhGcTsSSSe6xGWLOovcWMGa8+ZRytZZgb5VNBpU6FzITBZoSltcdJlIZSDr73sF+WjcMvhiMelFRuqgTWjnC46eJzCUPXKOiryl4WQIuqH8+IzyHEE8PqnLFdD321mKY7ft1buB5ad7qBq3O6fgoOIYTmlKnmEn2mA9LBuySE36WwtXo1MxXna8DIAQroBZr97XnbNEHGHowAMXUoc3zxvZFI32m5ERZbxoAIKPyfs8Gy4TS04VYQeVWBy8qroOZH6FMYHWnZFlQxmlUya2p4nj86I0R8vDPt/MvJVUCdolhivc29r38hXRRkRZ4/WSX+TEbKW9LD3SAis=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(261026121527099003)(261021121427099003)(56012099006)(261021123027099003)(261009223027099003)(261102123227099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5vOxmCjinpWivtp9CfPIF4K8F0BsL9W8glg81qqSJwo5oCtKkOUrbGqji9gl?=
 =?us-ascii?Q?9gI6orF7ByQpOKug7jMExjB3znrgh4sSav4A1JZsbuZHlZUcp6nePMbuwFMO?=
 =?us-ascii?Q?X9IoDMXC5LK5Lm/KRj12/G14cS3jbY+l7iqeJ65XajoK+J1uDDQcEME5ubTl?=
 =?us-ascii?Q?bnt0+Yv8DFFuOUfY/PJ9iipcc5ziR5XDw/6ZD9Jfz4CqvfyO4IFzsXu/cHuS?=
 =?us-ascii?Q?tYVajuv5Rk2cjTAJQT3pL414Yk15ZQs5fAGn6I6k/JQ0nGzJXNpmFuCdYabZ?=
 =?us-ascii?Q?QlAxr2f8eiIW+hS27qXLt5mkQUsVH2+OBoSaXrLcfvR4xpwNbLC/Nth6D7x9?=
 =?us-ascii?Q?RskqezCdHM720W2oCnxlJSvS2ve3Empn9IWcP++4yw+nHgXW975XwCZ7ZbXQ?=
 =?us-ascii?Q?I+iL0YBkelmYH2f0znlS/CgG1X8wWpzBCRbEnhXRvmBWv4M3sCBv302bunR6?=
 =?us-ascii?Q?w9M74EDMACXySXtOmxqPwr/82H5SHV/xNdu70xoj7noy6jiYp2PTdNi88Yuy?=
 =?us-ascii?Q?tlBOluga7sr1eJ06VI2E2OHlMFI1fg8fbalk9tl4niyUXKg1emtxF0VcKYke?=
 =?us-ascii?Q?J7uuJkIbPntoJflf2ryqYrGbyso066FF0M33JmJZ3NF9nJ5Ks6fjxruy7R+/?=
 =?us-ascii?Q?LbjSBEaWRnKoGvYNLc8sGidM/WXfJBqCuTwYiLc3/ChJUoX8U2ulToH98R6y?=
 =?us-ascii?Q?pUNAX01dyfo3/BHLjKLVvxfIMsrey4uZYNIH0KjqGbqTzc3XL531MreriTfw?=
 =?us-ascii?Q?UmccHB0mANoHHIDIg5sNCMakIncRR09I9yv7aSIh0Xjdu4bzXRvKj9Cl5vPN?=
 =?us-ascii?Q?4Q/VCngCgoVVxuUix5ysQmNP1nlOhWOhLKM5/fm9NbVSSKuUVoL4TuKkefnj?=
 =?us-ascii?Q?E44CWWMLYE6Z9g9Ma+0hJvltSldR0Rp5rh+Eg6epHw3nvdiDQGN5KQdT0IKz?=
 =?us-ascii?Q?U8Hv3Phzj1Uf3nAQO4Vi265NdIputa29OGPyIj9A/piwXDYIAwCa7/JIB1q8?=
 =?us-ascii?Q?Fsf0EzNXuKKbNlvfz0OR2bj/VFoOt52AMqHBrZKhksDU0ZlqnpsGTBnk8Fgh?=
 =?us-ascii?Q?I4nSUV1uP8D9IKhdj1E9oc+6BbWOWyvEGE6OC5SJI2UZzlH4C8WQ6zvmmIGC?=
 =?us-ascii?Q?sUlqL/UyDLfJSVS7HjlrPFyGzn47UFgJXbrVaFggjnHgL52dnO6hHLHsh8YT?=
 =?us-ascii?Q?tOG93fwuXHSp8gfcchZl0+hR+J2RfCYnuo/NSq55opPyR3CMCJ19FEpxJX6r?=
 =?us-ascii?Q?azNYxeijwTDycSZRkkuavYJ0PNItIVMxZ2xVxMTPr23ugc/p8kw9jfs/AOld?=
 =?us-ascii?Q?k+aS33mdksW6/PkVasmrvlRTDSv2oPPysOmca09EiaYwbRjCibxgLRjEm2XQ?=
 =?us-ascii?Q?V5kOupfIByAgo0+as8cHJPjoxl9V8a8kfOZ0xwB45fVNrhJ5eclQOWUcnwuF?=
 =?us-ascii?Q?G+Q/KkJC6zHnwCzPwTdFOFyE3z/ZwibKmZWkKDgWT/n0EjWeJRT+QzJb0MPO?=
 =?us-ascii?Q?m6qHR9wou+Rg6/8841UXiEg6MOk9QV3Ykyc8WgZ9xg0DjAi3YLpP+AzPS3Zx?=
 =?us-ascii?Q?clqnPA9TspQcPqS18Gxlogh930S5XeYazHsmZeA9hz+rT1LtKiiGzb0D9f5y?=
 =?us-ascii?Q?bJKV/OiJPzmKmtmZVvlQKaiwDCOQEALUNvCGmDDRRTe+x/9Jsu4pZLZaixGk?=
 =?us-ascii?Q?Ie5rw+oirGtiPV55rKMt0V6Hm0yfpMX2gFs0HtE93GlkP1sjPkpKlhhz12es?=
 =?us-ascii?Q?5ZXOQOzJ/eh0EDfaDw1/urKTewQESOE8/Q5TDXIw1HspeiTNS1MK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273cae19-68ef-400b-ce2a-08df41bd373b
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 19:35:04.2030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dY+9l9ZYbHkX6ROOR5EzNVP55/AUQ2KQUoB9Z5bzxP+nOOYrzYu9Jw318y6ivEijTfDmdmZCVw0lLyQbgw4wk2X470bjNrVDwEB3n5w/K/MGrihjWYk2ok6vuZkJYsm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11089

On Tue, Nov 03, 2026 at 11:52:07AM -0600, Logan Gunthorpe wrote:
> Add the device IDs for the Gen6 PFXs and PSXs secure switches
> (48XG6 and 64XG6) so switchtec-dma binds to their DMA functions.
>
> Based-on-a-patch-by: Kelvin Cao <kelvin.cao@microchip.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/switchtec_dma.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index a386c3a284e6..1af938bb40b3 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1455,6 +1455,10 @@ static const struct pci_device_id switchtec_dma_pci_tbl[] = {
>  	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5452), /* PSXA 52XG5 */
>  	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5436), /* PSXA 36XG5 */
>  	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5428), /* PSXA 28XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x6064), /* PFXs 64XG6 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x6048), /* PFXs 48XG6 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x6164), /* PSXs 64XG6 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x6148), /* PSXs 48XG6 */
>  	SW_ID(PCI_VENDOR_ID_EFAR,      0x1001), /* PCI1001 16XG4 */
>  	SW_ID(PCI_VENDOR_ID_EFAR,      0x1002), /* PCI1002 16XG4 */
>  	SW_ID(PCI_VENDOR_ID_EFAR,      0x1003), /* PCI1003 16XG4 */
> --
> 2.47.3
>
