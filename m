Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9CB2E06E6;
	Tue, 28 Jul 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252698; cv=fail; b=jkcAFvWadCNuTMiR6a/bCBnWKHLi236uuoC0W3bxDY0mZPPwxORW7dTsAhGZXJDRBEXiZbiOm8RtSRCw1Ot9DnfOdOD2MhDbWZ/xZaiRO4jVLhDYnptpL0RLo2EeRdX108XC5aq/PpKMqftniFQZgGDVAN0LY0HZ20xSkKnoSBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252698; c=relaxed/simple;
	bh=U4Rl+v8gSBJgapLYzRjsla/RKBHHTJ2A6UnQzL4QeZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lPiFa6WZo3wTUh5XChpljPk/Bd8hUvrV8Ro15MvsphP5wjyUbAujIi0LLSWaVW9DtpPyietGYPlaqQ4prJFGq984/+RcI1hKZu1yHem1U+0LW8NqWblx5XB6BCpfnFX4Js6cRZp8/GMQdWSLMeQlGX4vKiHIW3TkCmyrcHaeTOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iWj64Ft1; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iWj64Ft1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZ0OUoBbheEynu9zbpwcAx1u+H0kqoneM33rMUJsajQwDiS5xal9lFrbPZ8hkKYP+dBsTjcm+w1SdZqtLi5pP28c3lbY6/y7HhEchlfs9UeKlamyBUPVYBL0ExGwte8PB0kzlg5XXP6QLtLboFFGmIa+THdNmnqCU6yJrm7UF2aaLco6B+1uHWd8Eg1/PIF4vQJSm7Ql1+79S6rjak8Nacfo4wkc8wsvOnHSFzqKMKK29jM5TzCsiggtNEPhPGR8RpYVdbe6FmPLipDCZj2SE2ux24wGaBbG4AZx/5Xp2BpzTMsys/ngpKZmI1mQFrw0WYVD0FJFjmn5aR2zfKb40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQxa4BItQw/KOAIkszoLtV/SwalKOV6+8rjYlr0cTP8=;
 b=NMVhlBSJEwuytc+S7fYHKawxwjdUfAZVZK3HFLHQXLMUMljZmlxYyt5xRkHQJ3P7Pk+e5IAzgcKbPvon9/Qkn5dNzGZ8LHWOapflUMEPm7JiyIWhKCSkjLlsGfemZG2jKXgjQEvoSGG2Mxz+MjWkq4lOJpfE4oIY/LTb8VVC5g4TlBx6cec0Df6SwzmdoZPzoPzxeNlux/TAh65ChTQG29Jk9Sv9dKSujMMRyRitqFXqTREbkXbO8HdB1ezUqj8o94U7R4X4OdmFQX256HwqFRY2ID5RSVfPsJ5xbpoEU1By9ciQwJ4rifZChBGF1Tcz2o8IFNuR7WbUSGAyqPNQEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQxa4BItQw/KOAIkszoLtV/SwalKOV6+8rjYlr0cTP8=;
 b=iWj64Ft1ABNvPNMPAvw3vRkoXovadV15IFYt4v/usTc/rc/KXZZznO6Cae0z4gvDnvuDbOQ2JPsgU4dGBs2W0DGJNgUFOu8h8xUQ0oX4RBPnyi+yNU/gauZnPHGhxOZPY1TiYbUl83e7yQEpS18+3UVjRZpymvOPk45FSJrlIP+okQ//z1VSSq8FPM7PYwv3hsQQ8PTeIZtYXKOZ60w1L+ruCCj4xbShLq4+ZrEEtKAAMZHyAj9LT1+lYvcZMNGReRinfmBvURPLzQwu7iOSQuLNas0hkQ9fOenS6zD/vgFUyo5tdCqosilxjY9fGZSnJ3Jet07sloP8AAHlE8hBxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB7174.eurprd04.prod.outlook.com (2603:10a6:20b:11a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:31:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 15:31:33 +0000
Date: Tue, 28 Jul 2026 10:31:25 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v2 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name
 Agnostic
Message-ID: <amjLTTa-OYtjiP1W@SMW015318>
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-2-devverma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728091744.1086942-2-devverma@amd.com>
X-ClientProxiedBy: SA1P222CA0146.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 081f190a-7e1a-46d5-0ef1-08deecbd4dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|366016|376014|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	IlUFE7VgHkjntsRcWRvS3DVhXOtPDelehNidl38fM1GlPpcJ32vPGrLrR+Bi/a2mBdbJE2L6/d/Mn6RVitz5jsIzLPRj6EYarW0LuhETDwCMPY4yErX+jf/XwKJDsP/1rfBPGuWhodp8fCMw82ie65mBhPFTS0LAkOqQI9tSPcwkTyonRclMq/osYbZWq67Y/6Ht1ODSta+GbG9lYPs/cwiN5dtxbyfhQXyHQ8Wf48YkSrVcxi1xjRcA6+XM7FajdQZj3buq2h2d7bFtxeCLX7fL0TAhfLZ0gyedG5KIx2M69snROvyKLxn7XL+I0BnYOODBrKtdd4NrYDFWZCVYUhBxQ432kcTuYO9RMfRjeaIR2Vy9H/N4TbndojJtAa4j3xfQHx8aXVgGxVsQL4R1EeMzIHJ61yMCGMGbZRK/ycpJ/iiiaQLIA+h970s7BIuGCPh9nXih787aQCxExS3suu9J28X1tBJW+tOAuBwHqGdPCt0iOwKSdped29DmhDqqHuPD7a6J/31og6Ce/CsoJXYZzcr3ggcQhvCaoR9xhO8aEb6glMaWTipgSQk4ndYkiGvJl1kR5V25ctDZrNQhS6mhuXBMHJDuQfX0d36IGUl8rek6KaCnWivb/DecrSra5LPA6Oe8lSEPUAlJvDYZU4i+FYxe1fP9mukXFRDdvrI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C08mNUm0efUBWyN+uUMBO7F37KepwIfDFP5GYs5rHBWajB2bu1Qqe1i0i4qD?=
 =?us-ascii?Q?G9ci7PjVOzot9RXgGzBjHT9WDgaHuZU5vVkfUpfKKSiZad+pVSI/zr/IxOsT?=
 =?us-ascii?Q?c5ZZzHYeb1K1LA6ZVx5SnPeSydLSUiFaQHescw2ToSqD9qK5FpkrB9BXqHNR?=
 =?us-ascii?Q?3WtvgZgfYIUMoPVDB5ISs0O2283NtOFqQZ14X7a2eTvAlds8y6dwbuoU2Bfi?=
 =?us-ascii?Q?ymeMpElYbfA3iKQX0tp+NY/HMyNU/zPeLzdhEii6d5atlfpGn0jP3cm20LOb?=
 =?us-ascii?Q?8x6DwBc8+bwdxYzROjBlcySi8viIg0b8bN8kI2uY06MxUh1W6VH0zGnw6ERk?=
 =?us-ascii?Q?kofvGx2hl2+WqwbDknR9EDQ9IAxh37PjiM7ACe0HRT5+IZyDne2PYXxY+xLF?=
 =?us-ascii?Q?T83V0frDSMO+VF6Nzr5ybc0J4+JnGumREYfpjyMtPdbDGCKXA1eAhxVuozv7?=
 =?us-ascii?Q?1o1W11dqnrVyaoPgNGXozpCnyxNuy5+zzkaz+XgjQU4P4jawCCvcEmpDGG8H?=
 =?us-ascii?Q?/wD0VmGL4PVh2R9SItFmB/x1WEAmotr011nT6cdLuQQ4rVZGWfJUxnEwr6dJ?=
 =?us-ascii?Q?9YkdAuOeZ9fcyJmRbw7vN5KWvmInX4cRHB+O+N0bVgyRnZVdpD1Go9oloIt0?=
 =?us-ascii?Q?DCbzjarZA0a6+89ZkWcjURr1L0ibtSlgd2y+iOakVagCHjR6AAb7hBHi4lWQ?=
 =?us-ascii?Q?mpCDXEQVSNYjqI7UoRF7MRcyb4qOlIHFWm+ViFot78SjUuCAhQOmJUdIVufW?=
 =?us-ascii?Q?zBxVc18uEXTvzIt+RhN4z4XFzRXC39PzTzCTtuiUcGOjHde+s0uPHSTiysEc?=
 =?us-ascii?Q?I/BqRO+P5p6irRxjJ7QdKWZ5X2ecPNMNEww30dJi0FRgwylI04/YDf1F+ihP?=
 =?us-ascii?Q?Iw3KfcLlmWKsabrMuhw7f2dy9Eaz4y8wnkPsL+JKA91E+U7pgAoENktZnln7?=
 =?us-ascii?Q?7DB1FV4B2o2eKTtY/uUv0iq4VLJqkprve5r5XHBB5ka+hypNqW5342w1R6KN?=
 =?us-ascii?Q?oQRiHFccb6jafZylR2nUtCh6EL4Arh5xGN/yHbVTEvrS2Fdcww64FvO28j6b?=
 =?us-ascii?Q?t7zJztTQZc8qcMcGbK4539rv2EbJIpyRCG118/HYRky/hTgJcQKLnvoyjjBy?=
 =?us-ascii?Q?/DH2riWCD2+lwMQq1+JGLt6++Yq4Q//HpLBVbCM9TGc3L71yxXNpGQ9BRDKK?=
 =?us-ascii?Q?gN1vevuB3r0ZQY3Jf9XxiBazcixoPoEAzjiz2S8sIh2RuiVAkvRdqLn6NtO7?=
 =?us-ascii?Q?KVjmnmSZ/pfmyk9O4iOTvH8tsoe+q5TFdFd0ztU2AgexOl+IgE3YJTjrWJlj?=
 =?us-ascii?Q?86xHdwtTsWkm4dPkPwjlBKJk/Tmj7tlB1QY87Jo4GrO1XVQEkR1DHW51dQyU?=
 =?us-ascii?Q?Iy6SV2MtAjG4wdgL5RkJhpAbAW5m7FbQvt+qVI2i0DCfeklpIHkRYbiE011h?=
 =?us-ascii?Q?2GTHVeiLiH1rwTVyV+JGqmTsHLwZc+ZBsTfipcxsTM5DI8g7ymchhK5DW2q3?=
 =?us-ascii?Q?GATVwZn2Uimvk3BdpJ6lUdQB9pYEnobr6VmzMVItc9t2xeodr4ODZ4bQlLV2?=
 =?us-ascii?Q?q79kuJpf/l3BFYT0wB9F3AMDTuZf1XRFjRiMjGHfoBUNnBEWm8BeVK0W8cZN?=
 =?us-ascii?Q?0sR+UmWdBjlfiKGokQpJC9Vedrt/VJm8WpklWMD8xrcY3oLlPTRVFmGuDLyq?=
 =?us-ascii?Q?8bFmFX4a68FMFpWe4Uo4xkqzAxxbtat949Xo1Esk0fXzneJVPIrr18W0z0qm?=
 =?us-ascii?Q?Se6cX2FH2RN2VG2dDoflixK+hVGnfFbRtW9KLVMkMKoflgKJMMRk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081f190a-7e1a-46d5-0ef1-08deecbd4dbc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:31:33.2849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SYbXalU43eERGy92MUL6pOrZjGxJNJQ2V3TbG1HSopr+dt1qOJmR6J8fRp2D2ZNAd+4L4alJVwWxFFXoS2ZqO9UpqZnXAmMZ7cZ8JD45yPljJk+6yecoteyFF5QooEA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7174

On Tue, Jul 28, 2026 at 02:47:42PM +0530, Devendra K Verma wrote:
> Xilinx specific macros for MDB device can be reused for the
> Xilinx supported other similar IP such as CPM6.
> Renamed the Xilinx specific macros in a way that can be
> reused for Xilinx supported upcoming IP, CPM6.
> Naming is in accordance with the naming done for Synopsys macros.
>
> Signed-off-by: Devendra K Verma <devverma@amd.com>
> ---
> Changes in v1:
>    o No change
> ---
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

v1, you agree keep use old MDB ?

Frank


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
