Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6C637CD39;
	Fri,  7 Aug 2026 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122307; cv=fail; b=smGLT2hBwqNwIohp7R7X/iemTx27Wfn6kHe5rfL2FCaPqZg7s6FPOul/nRRUoYZ94q54nHq2ihooonWgCLs9w7YetosjsamL2FMafIJtl7AW672LFvAJ1MPf/yizJu+os+uWZPhBtUNYvZvFimInqaNYQIXgb1skpR4hArCFVBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122307; c=relaxed/simple;
	bh=bvNU/MuzMPVf95bir5CzNctVWXGh3N2+vaIMZ6IP3LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t9XDJSgNG3BQ/AfH0lJ8Ft1VZGo8Lf+7qiitmSCk1lTEqtmfpBqabOkMRYuvcYfkjIluSkYUKA4Fi0Wjurww0iif3RImofiL3mSzZgObMj7HovUf/QXLZFDZPPHK0MICFU07927jaJ3KGutsBIb6y+0Cx2Wr/laYjlLJ3i58dUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HO7CosIL; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HO7CosIL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eInEkiJelJu9Ne+yK4Zx/sc7vLqOgz8tRIw4gVJWa8ldPtObsoy2dka7/T1xFSNcVgC4+ET+lOw/IpRdvTLn7Koqaxje09Ji/MrNw6AoysS6X4nJb2nhvU8S0DgiBU2sgljnKyT9L7l1ozIAcwkw/wGnwbmXIoa5+AxCa3wXGiVlxu3qSezMntX6hyNlhdqQiTD3fILYnG8hANrz8gCUWwcgc4RPrH5oGYg0JLdNUm5qd4piBcqfMawTACX/Xjv7ma2VDb07vwiXvPFjmNF5jaM5G31hWfvJCbVih9j0eepCtUBBGsR8PD69/AkEf+Je58xbgTueYIzX7u/6andICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRsOF9zL95rJm8MMN7N3BKrentF/UahyXUjHbG9YBnA=;
 b=RNL5SzdPEay35Ca03CE1yKdzn+qXzceNjF4s1ACjF5V7PQOkBKi+GqvFVPdENN3VqbW0I2NtxMV+PjE8vfRKRSeNkqUJJTStOaOCQ4OAxaEk79gD0YjAeuB6RdFiClflFppn/8v32ZGG8lLNKPHgNVQp1DsImw2s6LLExkvMvLCZ5CnkV7NXNrh4eT93gkaJQl3XAOfY3w8uDshzULhDoa+V8rdy6E/iIfZi9HwRGCP3wnrCA9dzi9HuQok740NZlxIcxrpnR5EQ/UnaxvseY7WDIWjA8fCL/32Cs8pEDuRMDT5Q8hm1eR6Q0WeQ1p2YN/Othdxk3qmV6vMk/nzfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRsOF9zL95rJm8MMN7N3BKrentF/UahyXUjHbG9YBnA=;
 b=HO7CosILEqHX0jglrH5+5487ZZFeEjmAgu6jMhJnq5Yl2QWRnzQR3a1iUp9o2ZxemMcbmcbVlEvkTnz9ikNIy40WnHm3BK8aLgeUM76RvCRXDCmq3IwUuJaPZ6cay3PN69GXCYaVdnC/SCyrwNz/l/RpNFJH8Fxpma1Xh9L4y42OopkB+5JZULcQUMUE0evGtmsmuEq0oFFW1zpEohYVJqEr/gG58wscX44lW/EDLh0nKWU0D86Atl8O060VFBNrCSzu72UX8oOJWS8VpYBB4Ca454oIjN3iG/208/bGKaZAYJPdJBBQDtxAg7uvABuUZU2DJ5WZUt15KOrqEZfRYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA2PR04MB10260.eurprd04.prod.outlook.com (2603:10a6:102:410::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 17:05:02 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 17:05:02 +0000
Date: Fri, 7 Aug 2026 12:04:52 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v2 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name
 Agnostic
Message-ID: <anYQNBCK4AmdTuzp@SMW015318>
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-2-devverma@amd.com>
 <amjLTTa-OYtjiP1W@SMW015318>
 <a80a43ce-a291-49f6-baf3-aa1340a3aca2@amd.com>
 <amz1amHpAjxrlwiq@SMW015318>
 <c771a891-8924-410c-8495-eb91304531c2@amd.com>
 <anJrAuO4Kh2Q2L9B@SMW015318>
 <c9fcb0cf-7deb-4038-8041-99242e5499bc@amd.com>
 <anSn4nqVZmxapD3R@SMW015318>
 <64dc49f2-69ee-4752-8555-35a1a5478ed3@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64dc49f2-69ee-4752-8555-35a1a5478ed3@amd.com>
X-ClientProxiedBy: PH7PR17CA0034.namprd17.prod.outlook.com
 (2603:10b6:510:323::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA2PR04MB10260:EE_
X-MS-Office365-Filtering-Correlation-Id: f91d39ad-22b0-4f20-ac43-08def4a604bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	KvCQwxsz035GNNdpkDv7CgirL11UdIhqpIBkiqhOhZNyvDfpFGHvo8FhCCNNlm4796GFnZcTwm+aRo8ufTMn9XrPsuSCzxX4XkYJEcmnzHDG7IQOSJzbmpiTrdP/DZ/T5dpul2WSm3i8CIltjw3ZF2lY+KFrDQNDO8wWVWNiEcUXr/7pSRlT2suPZK75/l25unbNGY+XNfP0VFgZn4Nk1HXjVFWYSeCKWliqAjhmBpoCPNz1vxrFHZSF6gQEuAyuqDMOtyXksXPZUIZybP6OPNJaS/MhpehLT3toSGhNXtJBKQyp0nW4KeUjuuAoNeMdZcSx5OMFFDbdzZxvuO3PW7QRbGHLRm5OIDw8CDVUvYd0/dpE1RztSxoAFgMmCvcefgjrfdTXPaZkg5l5P0iI5outnQ/l61ycfx6tNjSIFiDMXLxhJ13iPdcnZeETcaHxvswYM8+f3B9gXR000MGF7P08vIC3P0K1bx8iSV4p4w0cv4K7SqQ3tUkJzL+cxqnYliG+GXOoJW/gh9AGvS8QSGjVVAkEO9aphwFIyTWfnMoTo3K0AgxPjIPnV1MYcQHaCBUVVnb/LSHX0V4pjx4RKx9rkkwq0c/PIqc/RYPLkD9Gl2ouJMbrsi/FHYPcERzKiz7bs2Qd2qHrC9z+017tLbkx6W5NeIXHYscnreiuSMc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z+NGkk00lflLDA8qc6MsTTdI6KcPxA+q36BvkZRVilo3c5t0zTmhTNE718Sx?=
 =?us-ascii?Q?i3DUgX0y58WHDB+vmoF5rdJYfweA8+duDzp/jeacnEsUZPXLxjH1P0yc5AHc?=
 =?us-ascii?Q?p8Sb6IzG8CxhTG9InAYumt4RDXEo1/yn44fbVRk+IKMcPCN8YiJOtfx9kaG/?=
 =?us-ascii?Q?oHSfOyTQE4ilY4XLBfEPJ9uxu0x9x5zVHRcQTXYrOcclT1cEGEBMipEE0XKW?=
 =?us-ascii?Q?Df+2wtNej09kq/crqjVcl8RWd4NJ3acRYKOLxYI6oNO9qZymH0HUom84+rV5?=
 =?us-ascii?Q?WZY0z3Jn9n2Sd+5IOprqSuob+tECSn46ycrhBcetta3Pf6O8bMN5HM3oKRK1?=
 =?us-ascii?Q?scAkgOUmKccaSEMju7POuiCqz8nYDHsFJyuQaNFUcJZw/eQQTzmV7VU/Nz0b?=
 =?us-ascii?Q?lTIfI0IawiMXf8/QtqJh5WmpFN8HqEZ815ZgofwzrM58TwyeHMav/umsYdnt?=
 =?us-ascii?Q?Lp7oJBXtwa811q5+ZST6qsITbeTK2snqP8UY3QM3lq+iigsVvqmRnLFLSTeb?=
 =?us-ascii?Q?OW1lO2rD5eAxvsJHV7MOdBLA1ZBdv9Y/9A7eVQwJXiviPoCvDsTfA1mDTok/?=
 =?us-ascii?Q?wynyG6N9/PhX9bLkAuHLZlUJCQGY5jxFnJbq8q6SeBvLB/0KQLmMT3wJ4XII?=
 =?us-ascii?Q?PD2ioviAcMw7eAVFzXg0cyESZzmtQCsPvw46iiRQ/w+TOjgotc7sfAJZBsGW?=
 =?us-ascii?Q?C653isn5Pezb4bOv2afvK5T7l9xLca4vyCHH6P15q7WhTT/cruFz4AP7j1g5?=
 =?us-ascii?Q?B4eN7t0kP9GDrODs3sgmiJJQ/g2Yq/BhqnLkL0qbWhpM765aQBn7f7SNsBbg?=
 =?us-ascii?Q?7ErUHDhcFqhnU4HF2nTpk8MkSW4hNmp/1iGFhN27HOyAWsHF5nYbLjugOYmL?=
 =?us-ascii?Q?yiimMPwI2QAV3TPFW/Gx+IxOxzI2esh1oOzj2/kKI1ieYp1G4t9duw843IUD?=
 =?us-ascii?Q?vN7WTixsNL4MJbLFbYN2nzJgwKKIG5IzyXkzMz3LY5PDOJgqHbmWMwC1v7XB?=
 =?us-ascii?Q?C40+b7Pm2tLuLTqlIgB05bBlcD7B+o2K+JRpq87K9rB+PPVAAwYwYIZQef/2?=
 =?us-ascii?Q?h9SctZr0c4Jg5PSEKpS2LAgEt7nz954o8ljGhUjwQLnGCgGm4upqXasXyBbg?=
 =?us-ascii?Q?DS8BqaIQc0JiZgIjwH2zjaJ+JyEy5NtTSfpAGRn22NjQSijQtEpH7PdDbfSK?=
 =?us-ascii?Q?+BjHq3JAf7L8pgYpCvFxiXEzBUEKd/EkJMPz7HBq2U2yOBbazGTdddJ2GNHo?=
 =?us-ascii?Q?FhCt+A2Jz6S6/WspHJxsgNzpEAfkO4gm/dJmgEGVXphu7CFFmDlOAyoTlX3l?=
 =?us-ascii?Q?jXpmtjaj689+z5btW+JzOVs1GEE6R9GyVzSOJH/+IE7332+CpawP1UdIEabb?=
 =?us-ascii?Q?Y6aq/eAsK0igt1g0FPDwUkTZ+IhN0t7UwJLxPANimUuvWka1nEADl3I7w14p?=
 =?us-ascii?Q?hBqzVNbOe7pVt2qY4uNc2Im1GlwTkGyh2zktCeuo9MuwjwIxEKLwYixIrqe0?=
 =?us-ascii?Q?26S13L7toziNuaExB1lFcz1o177R/RlPwrIIm8oKl9TEej1GGUgf0odpW6qI?=
 =?us-ascii?Q?YlxjB4YAuKkNuhdQxCDWIlPNdNNEKQiPb0mbXMog44syjKZwJew2VjTfRSSc?=
 =?us-ascii?Q?mHwStzQiMOCBsNcZyBigVYSDta6vYS9voh/RlKC84Om3+KgZt11RREi1ApcP?=
 =?us-ascii?Q?p42pLk96mTj/5mzc0lTPNw6WhqyWR7m+FYxX4MEe6R14r6RoRZs6uRURp4dP?=
 =?us-ascii?Q?fJUh2NYEp/HO18NA/by8kX8kIrRsxaSgCeEfi8fcfn3MqXivdzKi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91d39ad-22b0-4f20-ac43-08def4a604bc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 17:05:01.9051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46QypE3B3axVtzUB1PevRLo00kkqPGNHVzof4ewRQFx09CHlItnMRwQVdjeB8w8mf8pSeOesnv89C+5sj/MBcu9TIqC6qy0hkAXYKe1NG28+lFuzWKvjRx+COzQOyOw9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10260

On Fri, Aug 07, 2026 at 08:04:28PM +0530, Verma, Devendra wrote:
> On 06-Aug-26 20:57, Frank Li wrote:
> > On Thu, Aug 06, 2026 at 06:27:17PM +0530, Verma, Devendra wrote:
> > > On 05-Aug-26 04:13, Frank Li wrote:
> > > > On Mon, Aug 03, 2026 at 05:45:14PM +0530, Verma, Devendra wrote:
> > > > >
> > > > > On 01-Aug-26 00:50, Frank Li wrote:
> > > > > > On Fri, Jul 31, 2026 at 09:54:01PM +0530, Verma, Devendra wrote:
> > > > > > >
> > > > > > >
> > > > > > > On 28-Jul-26 21:01, Frank Li wrote:
> > > > > > > > On Tue, Jul 28, 2026 at 02:47:42PM +0530, Devendra K Verma wrote:
> > > > > > > > > Xilinx specific macros for MDB device can be reused for the
> > > > > > > > > Xilinx supported other similar IP such as CPM6.
> > > > > > > > > Renamed the Xilinx specific macros in a way that can be
> > > > > > > > > reused for Xilinx supported upcoming IP, CPM6.
> > > > > > > > > Naming is in accordance with the naming done for Synopsys macros.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > > > > > > > > ---
> > > > > > > > > Changes in v1:
> > > > > > > > >        o No change
> > > > > > > > > ---
> > > > > > > > >      drivers/dma/dw-edma/dw-edma-pcie.c | 58 +++++++++++++++---------------
> > > > > > > > >      1 file changed, 29 insertions(+), 29 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > > > > index 791c46e8ae4c..ec5e057a0f11 100644
> > > > > > > > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > > > > @@ -29,21 +29,21 @@
> > > > > > > > >      #define PCI_DEVICE_ID_XILINX_B054		0xb054
> > > > > > > > >      #define PCI_DEVICE_ID_XILINX_B00F		0xb00f
> > > > > > > > >
> > > > > > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
> > > > > > > > > -#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> > > > > > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
> > > > > > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
> > > > > > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
> > > > > > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
> > > > > > > > > -
> > > > > > > > > -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
> > > > > > > > > -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
> > > > > > > > > -#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
> > > > > > > > > -
> > > > > > > > > -#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
> > > > > > > > > -#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
> > > > > > > > > -#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
> > > > > > > > > -#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
> > > > > > > > > +#define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
> > > > > > > > > +#define DW_PCIE_XILINX_VSEC_ID			0x20
> > > > > > > > > +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
> > > > > > > > > +#define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
> > > > > > > > > +#define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
> > > > > > > > > +#define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
> > > > > > > >
> > > > > > > > v1, you agree keep use old MDB ?
> > > > > > > >
> > > > > > > > Frank
> > > > > > > >
> > > > > > >
> > > > > > > I followed the suggestion you provided at the given link at the end.
> > > > > > > Talking of Xilinx based devices, the channel separation is fixed for MDB
> > > > > > > but not for CPM6. So, I have have renamed the specific functionality
> > > > > > > specific to CPM6 in 2/3 of the same patch series.
> > > > > > >
> > > > > > > This one cleans up the MDB references and makes the functionality generic
> > > > > > > for all the Xilinx devices.
> > > > > > >
> > > > > > > Suggestion: https://lore.kernel.org/all/amI09ZcfhX4SEPIH@SMW015318/
> > > > > >
> > > > > > Maybe I have not said cleanly
> > > > > >
> > > > > > Actually you only need add one macro to for CPM6, other use MDB macro can
> > > > > > work well.
> > > > > >
> > > > > > #define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP                GENMASK(18, 16)
> > > > > >
> > > > > > These rename are totally unnecessary.  It is quite popular that new chip
> > > > > > reuse old chip's register name.
> > > > > >
> > > > > > We rename it utils we really can't handle these without rename.
> > > > >
> > > > > You have pointed out the issue in the last line. For the upcoming
> > > > > support we anticipated that it would be messy to use the MDB related
> > > > > stuff for CPM6 and that's why wanted to clean it before introducing
> > > > > functionality for CPM6.
> > > >
> > > > Do it only when have to do that. Now only add one macro
> > > > DW_PCIE_XILINX_CPM6_VSEC_CH_SEP to support CPM6.
> > > >
> > >
> > > Here also we realized that using MDB would create the confusion later on
> > > when more features related to CPM6 will come out.
> >
> > Do it when you post new features. We will make decistion at that time.
> >
> > Now only one DW_PCIE_XILINX_CPM6_VSEC_CH_SEP is NOT enough to support
> > rename now.
> >
>
> Could you please tell how many changes are required to have the renaming
> related patch to be pushed?

It is hard to talk exactly number. I provide an example to help understand

drivers/gpio/gpio-pca953x.c, which cover nxp, maxium, ti many chips, which
have indivial hardware spec.

register defination is most part use PCA, some specific use TCA.

Frank

> > Unnecessary rename will cause meanless conflict when back port some fix
> > patches to stable tree in future.
> >
>
> This issue will occure irrespective of when patches are pushed.
>
> Anyways, I will be changing the code as per recommendation.
> Here we were trying to reduce the misunderstanding but it is not
> recommended, for 2/3 of the same patch series, the variable causes
> misunderstanding despite reasons/context.
>
> I will push the changes, please review them. Thanks!
>
> > Frank
> >
> > > We are trying to contain the issue early, that is why putting up the
> > > effort of segregating the macro names.
> > >
> > > As you have already suggested that the names can be changed but when the
> > > need arises. We see the need and handling it early.
> > > Request to consider the approach:
> > > - All the Xilinx specific macros, providing common functionality,
> > >    applicable to MDB and CPM6 are made name agnostic. The macros will
> > >    go by the Xilinx name similar to Synopsys declarations.
> > >
> > > - Macros used specifically for MDB will have MDB to specify the
> > >    association with the IP and similar approach for CPM6.
> > >
> > > Also, as of now, as we are aware of both MDB and CPM6, they look
> > > related but there would be end users of these IPs who would not be knowing
> > > the MDB if working on CPM6 and vice-versa. This distinction
> > > helps in easy understanding rather than creating confusion due to
> > > naming dependance on MDB.
> > >
> > > -Devendra
> > > > The prefix "DW_PCIE_XILINX_MDB" and "DW_PCIE_XILINX_VSEC" have not bring
> > > > much information,
> > > >
> > > > The most important part following part after it.
> > > >
> > > > Frank
> > > >
> > > > >
> > > > > The MDB works, no denying, but mixing the two creates confusion and
> > > > > requires the understanding of MDB first and CPM6. For that reason
> > > > > the clean approach taken is:
> > > > > - Add the generic functionality supported by MDB and CPM6 under the
> > > > >     name Xilinx
> > > > > - Add the MDB and CPM6 specific functionality with their own
> > > > >     associated names, keeping it clean.
> > > > >
> > > > > - Devendra>
> > > > > > Frank
> > > > > >
> > > > > > >
> > > > > > > CPM6 specific declaration:
> > > > > > > https://lore.kernel.org/all/20260728091744.1086942-3-devverma@amd.com/
> > > > > > >
> > > > > > > - Devendra
> > > > > > >
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH	0xc
> > > > > > > > > +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW	0x8
> > > > > > > > > +#define DW_PCIE_XILINX_INVALID_ADDR		(~0ULL)
> > > > > > > > > +
> > > > > > > > > +#define DW_PCIE_XILINX_LL_OFF_GAP		0x200000
> > > > > > > > > +#define DW_PCIE_XILINX_LL_SIZE			0x800
> > > > > > > > > +#define DW_PCIE_XILINX_DT_OFF_GAP		0x100000
> > > > > > > > > +#define DW_PCIE_XILINX_DT_SIZE			0x800
> > > > > > > > >
> > > > > > > > >      #define DW_BLOCK(a, b, c) \
> > > > > > > > >      	{ \
> > > > > > > > > @@ -258,10 +258,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > > > > > > >      	u16 vsec;
> > > > > > > > >      	u64 off;
> > > > > > > > >
> > > > > > > > > -	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
> > > > > > > > > +	pdata->devmem_phys_off = DW_PCIE_XILINX_INVALID_ADDR;
> > > > > > > > >
> > > > > > > > >      	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > > > > > > > > -					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
> > > > > > > > > +					DW_PCIE_XILINX_VSEC_DMA_ID);
> > > > > > > > >      	if (!vsec)
> > > > > > > > >      		return;
> > > > > > > > >
> > > > > > > > > @@ -272,18 +272,18 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > > > > > > >
> > > > > > > > >      	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
> > > > > > > > >      	pci_read_config_dword(pdev, vsec + 0x8, &val);
> > > > > > > > > -	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
> > > > > > > > > +	map = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_MAP, val);
> > > > > > > > >      	if (map != EDMA_MF_HDMA_NATIVE)
> > > > > > > > >      		return;
> > > > > > > > >
> > > > > > > > >      	pdata->mf = map;
> > > > > > > > > -	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
> > > > > > > > > +	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
> > > > > > > > >
> > > > > > > > >      	pci_read_config_dword(pdev, vsec + 0xc, &val);
> > > > > > > > >      	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
> > > > > > > > > -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
> > > > > > > > > +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
> > > > > > > > >      	pdata->rd_ch_cnt = min(pdata->rd_ch_cnt,
> > > > > > > > > -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
> > > > > > > > > +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_RD_CH, val));
> > > > > > > > >
> > > > > > > > >      	pci_read_config_dword(pdev, vsec + 0x14, &val);
> > > > > > > > >      	off = val;
> > > > > > > > > @@ -293,16 +293,16 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > > > > > > >      	pdata->rg.off = off;
> > > > > > > > >
> > > > > > > > >      	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > > > > > > > > -					DW_PCIE_XILINX_MDB_VSEC_ID);
> > > > > > > > > +					DW_PCIE_XILINX_VSEC_ID);
> > > > > > > > >      	if (!vsec)
> > > > > > > > >      		return;
> > > > > > > > >
> > > > > > > > >      	pci_read_config_dword(pdev,
> > > > > > > > > -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> > > > > > > > > +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH,
> > > > > > > > >      			      &val);
> > > > > > > > >      	off = val;
> > > > > > > > >      	pci_read_config_dword(pdev,
> > > > > > > > > -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> > > > > > > > > +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW,
> > > > > > > > >      			      &val);
> > > > > > > > >      	off <<= 32;
> > > > > > > > >      	off |= val;
> > > > > > > > > @@ -360,7 +360,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > > > > > > > >      		 * address use the non-LL mode or simple mode supported by
> > > > > > > > >      		 * the HDMA IP.
> > > > > > > > >      		 */
> > > > > > > > > -		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
> > > > > > > > > +		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_INVALID_ADDR)
> > > > > > > > >      			non_ll = true;
> > > > > > > > >
> > > > > > > > >      		/*
> > > > > > > > > @@ -370,10 +370,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > > > > > > > >      		 */
> > > > > > > > >      		if (!non_ll)
> > > > > > > > >      			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > > > > > > > > -						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> > > > > > > > > -						       DW_PCIE_XILINX_MDB_LL_SIZE,
> > > > > > > > > -						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> > > > > > > > > -						       DW_PCIE_XILINX_MDB_DT_SIZE);
> > > > > > > > > +						       DW_PCIE_XILINX_LL_OFF_GAP,
> > > > > > > > > +						       DW_PCIE_XILINX_LL_SIZE,
> > > > > > > > > +						       DW_PCIE_XILINX_DT_OFF_GAP,
> > > > > > > > > +						       DW_PCIE_XILINX_DT_SIZE);
> > > > > > > > >      	}
> > > > > > > > >
> > > > > > > > >      	/* Mapping PCI BAR regions */
> > > > > > > > > --
> > > > > > > > > 2.43.0
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>
