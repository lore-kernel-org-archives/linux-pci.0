Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A7369D6A;
	Wed, 22 Jul 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731900; cv=fail; b=MhabSWbKbfyQ2BEPxhRIMcrZTBxZvD+gh952zcEmCfkIj9H4VFsHVWa2O52SbxrwnENKX16BSZqB0KkHBnlUEzKJwwul70cb817+ktQ9B09AzDQGdKRTt0hNcjLlvVALzj8HM1PRt7ZqhoxMvrlxmsGIXNd9n7wEOJ9F+T5mw4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731900; c=relaxed/simple;
	bh=dUI6N1mz2Pwmp4gzQCWFBZAhMTZmuiLCPV1i3NBx+3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WqYP/2tbhInEdzcprv9WhK27yto3K8/wd9Rx6l8mjKgll/DBWqPwnCmZGybFVTZDxMZIY/LwppSSFF8pSLY4C4N+WqdxnL5fID73RxhP2604Iu7L4g+cii/1/55fdsNpcEJUMVIb42SVmrJGSLVT8nXsdNLGsG9IRy3AI4JnEno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OgorLHhp; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OgorLHhp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prSE57xKEBQqLhqzYsm7PNi7dv1sF/lRv3Zus6NL28TMfSHT87L78Nm6vOfc6EPMeMubGvZ2vw2AstxAfSXi0HJX8pg6nk1G+y+mm9INll96hTtKZ/h83V5Ajzq/dOYP3QL/73d21zbUWyLknSCXGXxMvsKktE4ZJ+KhcgOp/1+ScVzl92TTTj7cH3GQ8X0wu1BvNz8qwEl/XFOlhgZV14ldqY/GFDq3sQYIuZJmJcPsx3JohhKDrckGCTqoiL278ncnNdDqtaR02BeFJNroaudpT2zqR8JV360RuU3of2fMY++7h3dxVcJk/ada8jgiBYkz8tcV0rmCx6I8ZoCKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2YCRQznHmgGT0XNHxGepaocevArP1D15vdqLc3mxRk=;
 b=ukD7Q99aALzeYeeigJU+5HFI9/F1NSk5l4YbM3Uzhrji5FAriobO4gBcXB+gFvFFL9TWNMYOESQzlg7j79BBGvKqCE8dkwebG4pYj5lzphDi/c2eYIPxQYDQWMMpN1rMqlr348Jfiqq95KRxJNnjMij0WZmcVC6vnb0IDvMOB8gzkMZe3ikusx77DpwXEua1OnQBWXAsyN5Ee6kLAzWSFI8kkgwKJznPIVFlsNTlTHGJInKY+QauhC/+ObxrRwatt5h5SDbA3q867YVChcc45DzhelvjAGRvMQvpsgNUHxiujhb/34A/RUTc/gtEyzjiezJHxuDBkctOhkwe9QG6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2YCRQznHmgGT0XNHxGepaocevArP1D15vdqLc3mxRk=;
 b=OgorLHhpW8xjZb9qeUjpKsGJcijfVVL+NyHsWhfX6A11dS3hP3SYH+vTFFB7GTeO5nyBUX54spw9AbwJvn8BroEA+RKpFee40fqmGskuERAlykPuHKBzS5MjVhryHNp64BPksIUJzrzrvLyesZLyPpbASmD3N28vwxv1jfxLM39yIN5LDZn36oV+j+2SUXpCXqIj+EdukfhFZ4FLEYV/BHnIEMYqJWtOvHWZ99QOoIjzjiwuv5LxAf7LZIkedmVgfZ5TkgMo57K+oRyjxGXOoGGtprh1QHkaHo/68n/9PgPWG9GQyTYbHfuJbjw5KfX8aQQmw49AdwWIauS1bUtG9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB7926.eurprd04.prod.outlook.com (2603:10a6:20b:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 14:51:35 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 14:51:35 +0000
Date: Wed, 22 Jul 2026 09:51:26 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v1 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name
 Agnostic
Message-ID: <amDY7rTS06xEfFxu@SMW015318>
References: <20260722111640.1146212-1-devverma@amd.com>
 <20260722111640.1146212-2-devverma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722111640.1146212-2-devverma@amd.com>
X-ClientProxiedBy: SA0PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:806:6f::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8fb299-e986-4223-00ce-08dee800b9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|19092799006|1800799024|366016|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2zM6cl891i/odlhT7Nrtx74EvrVNii1OmDqqp7zphwdwtPABOj+s+9fr5yAm3nlCG7LZn8VXlUlGa6hY1/7NDo0AohDqHnryXr57GkcyJQTlOaBDFgF9eze9B31V+W5M5pi0f2q6mcHesho0aH7n49Whm2m5g3kzjE760YwuZSvPSMzq20xd7mSIbcfQoajjCptMtsSkoFbmjwGwu6HGCYhKnfGkH0vWgabWym2mAZoTzsZa1sPXHHe42YmGuj0NGRCxud2Wb0I5GF2vL0gWYFEmq8FPmEdZUJxBcvXy82N590iFZTvrD1QjQDY7erOF7+CHijgvcK3Os9PMgO0pLLKQNnkUQNdLW+s0QrPh6ko4LfMc/Lug1ruAb/C0BJHRyjpI0KhZ7VyjYDkiHKD8uL8wqok8euqCmmMnBHmAs9QNW1Xzh7Cr7aqjUPO0s1z09+ZcLIqQrot2dfZGu2HtPkDEdY4RNN43qxshHlGnjr6UqJWHcXmjaUo84x4TNJfUBgN4Ylcm45KZocCGv8PBKibQLdMPLSA32wLrnVRW9xv5El51xHJtAyN+aScJ211jUaCIwkTcDJ3GgtsL29tWD3UiAlGt5FHg9CsM161xq2z1icul8WBxh02F7gavK00uSxPlV85aEA0JQ0nZ4Rpc3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t7uAnh3bIFjw/xjyRadzSXDfzP1Jgkxj2NOMUuO6hCpNInakpBD/iFVbizNV?=
 =?us-ascii?Q?ab/grY90s92ibIn+tj+1Tue7Midx6q/eVRBcSFusnM2tXZ9t+B808+Ss4zKs?=
 =?us-ascii?Q?wllItc5KbT7tpDQkF8jie/Vj/hvZUMkuyTlY3Jm02pwE7eDVKLkXchBb4PxM?=
 =?us-ascii?Q?YxwXkhf8iQarn6v7LHm5em+12vEwSnlaATjzkLrOFfMtGZPYzv9S8rIlh89D?=
 =?us-ascii?Q?muy83vJ0SPu39nyunLAUtKeek6dO89cK4QPyFFriNUlXkFj5uDVVruYnuZqP?=
 =?us-ascii?Q?gQwLCJ7+JszI1REX4yQCK5UoyXn9d0zsbioxC3j9Gl/+iQeWJBfKOwCBk+1W?=
 =?us-ascii?Q?oBdpr/dOM4BREGPCWetT71+JVaPA1i/FOHQXYY2yW+e9Z67Ovx2BmWq2QTed?=
 =?us-ascii?Q?LcYWMhGb5KrV8urCeaaGHyk4+mkb35EiCPvSO/JOFfweNgSDBq5U3m3Dn6TF?=
 =?us-ascii?Q?4oReKgEL6SE+jrWEJHX13MWyG9MIBuPHkiqJ0WezHOTraITHvQZ75m6xYXss?=
 =?us-ascii?Q?w4nAAApG6q0nXNwbdeyjt30YDxA0wDI9OJfPdi3UqaHZkO1zh9jZnXZVjQAS?=
 =?us-ascii?Q?kZm9Jb04HLSTipcq4Wrl2EAekr2LugToBEEDsQqjtbvxET7g0AfkfR6kaSRD?=
 =?us-ascii?Q?Q81xZ6Dx8hmUz46PUCvDsTavHh0+uA0B77/hg8o1UjHmb8uiwp5mmzPtIdFi?=
 =?us-ascii?Q?SSMX3xV+SL5DAPe+BtnSVjv12wkpxB+CVrVUU94pnial8DgDgl+EIzhVtzKF?=
 =?us-ascii?Q?wC/4zgJvxEHkJMp9x7godbRxc9UGdgjxAIzafte4Yeh96+fC6j3UgR8z/pa+?=
 =?us-ascii?Q?GSAN7CXOcTiwsS3vKVEJkbqWgDh68LcHDQyqsILQcjpPhO2qksGBymQ0NFuI?=
 =?us-ascii?Q?4SoVZOGkxIewqmp2XWY4VoELfIdlk6H5SiIjxgjlgdY/6TvgHp1Dw2BTQk34?=
 =?us-ascii?Q?n7zjOS16CXKHYafxkMxdIMSMvqB4FKWzp4e1HTJVSjg2dN4ZGPTBxO4tazFD?=
 =?us-ascii?Q?Nqs/X3/9cRMAyHJz4hudv8zy0TGHiJ9UPMTyfyxFeAnrXF3VlsFwZDPjMKA7?=
 =?us-ascii?Q?W+/q//U2uEgQjzBfmILuzWwYpCVnL3p/3uUGp5R/3dt/DNfm23N5yQv08vEJ?=
 =?us-ascii?Q?ZBsbA67p/bRC3sbd+LrIT1BYBDfDoLI4miwg/I+qSjYev1z5wzYWANCr9w+e?=
 =?us-ascii?Q?sXHHIrr1efiOTLnmvv56fwhDFzw5dQJMR16Pvq6P2Ft91EP68Dxpi8WnJT4o?=
 =?us-ascii?Q?2oGHhZ6rIhIQ/lFL6EMKtGAmwR88UbT51QyFwyNr0UP3xWYWQuOxqSX1vWqN?=
 =?us-ascii?Q?J7/NSOb18hviijtZqHk/KHL+j2i2HM1axO1lxF4JH8KMw8AMSvyl1s6Hy7XV?=
 =?us-ascii?Q?M0UyVXzS8GD4fFh9o+iEIwltsZ9hlT81+7RnC0IGSCLQ0oGsnR0CZASMDqpu?=
 =?us-ascii?Q?5u8l5fvxbw6IAhnMUyglEtNKzm/U75m78U4un0ju0B+Tx7GUwTYDgGcvjZ8D?=
 =?us-ascii?Q?tTGK+8ilTFltQVQl+W0ajaxZiIOI0LVCDBkraCJNdIkjIIQrreiDofPDkDA+?=
 =?us-ascii?Q?b79FdEyYrrSXEwyAFLBOqAwu2IEQV0fzDBi6c0IFxOKsvKl7wBmKrZH+B5X7?=
 =?us-ascii?Q?w6xguxclnOiG4jPG1GqbLclZMU44W+3KV0mGvvAfpZczXts6mavP6OtnyC6s?=
 =?us-ascii?Q?IE7oisnHYqsOxFEfIadrNS6tRqghqmDvUDmmouToKK01ZaRtj4ioQqZRo8If?=
 =?us-ascii?Q?G2GA2xpCozdE3QlIFs69cFjaS6RFtn4hN3dANK1IKXhUK0yalKas?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8fb299-e986-4223-00ce-08dee800b9f9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 14:51:35.3812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhSb4qYzl0TJQpq4JX/acoBR8qxnnKjSQUfh6tncTv59Tky3hdn+9ZztXB7pHLkoAvX6ESsx9QRLpSzb5rX2GUzZNCcO6UybK13rNFGk8lIMs4+eNDvj0GTOg5LAq3w3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7926

On Wed, Jul 22, 2026 at 04:46:38PM +0530, Devendra K Verma wrote:
> Xilinx specific macros for MDB device can be reused for the
> Xilinx supported other similar IP such as CPM6.
> Renamed the Xilinx specific macros in a way that can be
> reused for Xilinx supported upcoming IP, CPM6.
> Naming is in accordance with the naming done for Synopsys macros.
>
> Signed-off-by: Devendra K Verma <devverma@amd.com>
> ---

I don't think it is necessary to remove MDB. You may mention somewhere
CMP6 compatible with MDB. It is quite common in driver.

The major concerns is that if a incompatible devices appear, such as CMP7,
which have special registers, need add _MDB_ back.

Frank

>  drivers/dma/dw-edma/dw-edma-pcie.c | 58 +++++++++++++++---------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 791c46e8ae4c..ec5e057a0f11 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -29,21 +29,21 @@
>  #define PCI_DEVICE_ID_XILINX_B054		0xb054
>  #define PCI_DEVICE_ID_XILINX_B00F		0xb00f
>
> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
> -#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
> -
> -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
> -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
> -#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
> -
> -#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
> -#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
> -#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
> -#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
> +#define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
> +#define DW_PCIE_XILINX_VSEC_ID			0x20
> +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
> +#define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
> +#define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
> +#define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
> +
> +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH	0xc
> +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW	0x8
> +#define DW_PCIE_XILINX_INVALID_ADDR		(~0ULL)
> +
> +#define DW_PCIE_XILINX_LL_OFF_GAP		0x200000
> +#define DW_PCIE_XILINX_LL_SIZE			0x800
> +#define DW_PCIE_XILINX_DT_OFF_GAP		0x100000
> +#define DW_PCIE_XILINX_DT_SIZE			0x800
>
>  #define DW_BLOCK(a, b, c) \
>  	{ \
> @@ -258,10 +258,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>  	u16 vsec;
>  	u64 off;
>
> -	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
> +	pdata->devmem_phys_off = DW_PCIE_XILINX_INVALID_ADDR;
>
>  	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> -					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
> +					DW_PCIE_XILINX_VSEC_DMA_ID);
>  	if (!vsec)
>  		return;
>
> @@ -272,18 +272,18 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>
>  	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
>  	pci_read_config_dword(pdev, vsec + 0x8, &val);
> -	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
> +	map = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_MAP, val);
>  	if (map != EDMA_MF_HDMA_NATIVE)
>  		return;
>
>  	pdata->mf = map;
> -	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
> +	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
>
>  	pci_read_config_dword(pdev, vsec + 0xc, &val);
>  	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
> -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
> +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
>  	pdata->rd_ch_cnt = min(pdata->rd_ch_cnt,
> -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
> +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_RD_CH, val));
>
>  	pci_read_config_dword(pdev, vsec + 0x14, &val);
>  	off = val;
> @@ -293,16 +293,16 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>  	pdata->rg.off = off;
>
>  	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> -					DW_PCIE_XILINX_MDB_VSEC_ID);
> +					DW_PCIE_XILINX_VSEC_ID);
>  	if (!vsec)
>  		return;
>
>  	pci_read_config_dword(pdev,
> -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH,
>  			      &val);
>  	off = val;
>  	pci_read_config_dword(pdev,
> -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW,
>  			      &val);
>  	off <<= 32;
>  	off |= val;
> @@ -360,7 +360,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		 * address use the non-LL mode or simple mode supported by
>  		 * the HDMA IP.
>  		 */
> -		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
> +		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_INVALID_ADDR)
>  			non_ll = true;
>
>  		/*
> @@ -370,10 +370,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		 */
>  		if (!non_ll)
>  			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> -						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> -						       DW_PCIE_XILINX_MDB_LL_SIZE,
> -						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> -						       DW_PCIE_XILINX_MDB_DT_SIZE);
> +						       DW_PCIE_XILINX_LL_OFF_GAP,
> +						       DW_PCIE_XILINX_LL_SIZE,
> +						       DW_PCIE_XILINX_DT_OFF_GAP,
> +						       DW_PCIE_XILINX_DT_SIZE);
>  	}
>
>  	/* Mapping PCI BAR regions */
> --
> 2.43.0
>
