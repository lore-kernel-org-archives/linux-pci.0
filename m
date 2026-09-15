Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013003.outbound.protection.outlook.com [52.101.83.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8251366055;
	Tue, 15 Sep 2026 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490647; cv=fail; b=J0ISuXpZA9UT9HqhSHR7LFiyY0Yv2TGWNXgICGYJLP1b7pXeYQjM3o3UE9Id7Hl5n7hkWSoi5Coq9GV5Q3768KoF0/hEIbCCnGbgDih3hjSD8iJSM/+EqsAeDnkUwUInn8MBJ31IvRETEzphtYl+1s5KCSj0HF3Kcg5m8dJWR1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490647; c=relaxed/simple;
	bh=KgC+oa1XBa4rw2hb7AA9YEF2pl6DQIgkUa92MpS5kPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B7zTvNye1xRBSm2pNntS9qugm7MboIq3kj8kPvyJWZyO02foJ1nLxc9qC+ivZ2uVf0EWVc6/aoGgUw339WPB0YHaJ+azAi+fxFBS9I991ddu6qLg+ytMiMVw3fUACJHgszJTCc/Neq6iTRe5cWgewtNq8FoFa7epCR0gNxcMTKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ukI4X1qE; arc=fail smtp.client-ip=52.101.83.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ukI4X1qE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9TGnH71VErUAdHLXNkrEjIHVxLxF1IiO89xbDi8bxjYYIoS+lYKlsJDAB/41AOYcaXzOkR/r0zuUljH+aNdDYbJQBMcxC7XBSgHoQJIziJYwYdgkhwpaVVsRML9/SO1CtYhHIVVy1D2+ibkjXSlvpjCRx9QKab29Pn2IOCRuXK2WrgMRhdCEbt1SPEuaGKr1XQdeiJme7bIyrrJW+m0SInlV1XHraEzFQfUyxS04UIHbGN/SjzFi4lo9/9Gx1QbETlX1tqdiAlb6sb8aGdyZBFk8Hgep3Na+ML/koLopRlJRb5ONgHN95rdHvb8KCaFJHqMndMcPkXW23VVdsxYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0QE7Xsmq8ToKB5W5ZCmCdCb2dqxGJPdyqyQKJxf7UU=;
 b=gqDExgL3FEZsZJtjoQLSaIKM4ogVWl98/0NaWbcuuvLl/Gxfe9JRwcfE2CIVGVjR7MIvYKTnWcOskoEexni66fF9pvj1pWbkQkTjLztfduM7IyBeXXjZQifuf9odHIeZS1MgHcGKBJlPmQmPAx1tHC+wRsvhT/CBCLfuBDUt7jFOdmwdkvxOo1G7ZMVwMt/CFLwhpzbvUcjuBsg3qrhBb7KVgrjSpRxRA0GC1lHYObmrxSqTCLX5PEIup3LR5WEeUtEjcRiw2SOD9If4kYMO51DrKUY/kQYaZG7vLmkhUBMjd8tH+/xLP6GrIM8zp4LCP9ccWWRhUFUmVuB9uTF9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0QE7Xsmq8ToKB5W5ZCmCdCb2dqxGJPdyqyQKJxf7UU=;
 b=ukI4X1qETQp2LFoBGKC5qIzFMq5CroJvC4qlOgNzXomi0y9UCe23TTobFfrV7eupFWY2dcSF0G9W/6YNfab1vuiSdwY6upxW6Z64XSAkAtxBVGWBsKMRUDXRHwzrYYreiyUyQAhGhGr8f+QbQyEr5NnmsIF+HDb5lGTIVvHza9bANbBvpefEMC2IoyAn5Dk3Uwpz5t1oiBvfZ6DXkFAMVdJRsRHZ4Y6CEvlqn/Kj1wQ0tzztE7ofX/dWB/E+Z6sPFVwbwg+I25tKUNvmp4ekgqgRjBp8SpZwrqSCEft6hoO0+3X8G7d4UelLBt13aAntEgs4qUof7ShmGfm0XJXwlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9670.eurprd04.prod.outlook.com (2603:10a6:10:31e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 16:44:02 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 16:44:02 +0000
Date: Tue, 15 Sep 2026 12:43:54 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v1 1/2] dmaengine: dw-edma: Macro order as per reg bit
 position
Message-ID: <aql1yiDI8bGQh6Gj@lizhi-Precision-Tower-5810>
References: <20260907105453.1940646-1-devverma@amd.com>
 <20260907105453.1940646-2-devverma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907105453.1940646-2-devverma@amd.com>
X-ClientProxiedBy: PH7PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:510:339::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9670:EE_
X-MS-Office365-Filtering-Correlation-Id: e1668a65-70f0-419d-cee8-08df13488c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|23010399003|1800799024|10067099003|4143699003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	AyH154SIyhVPFfQ8Kc7wxm+M6+XQANbuSC2SwEaD2oknxRB30EVZ5pSVt6yQiILRCyq4iXQrdvv0rx+7Ny8+V1TR8CiLRXAtcIstUa4UH1796s+q7qgW33WRKXS9LCe9wJzX4x04O21lorjhSdJt5Jv9W26nSZUH9pQJfM6q9uTy4YDl5+HGNg0fVjBg/ztjiHvlYSG7A0uerCjJc/TuQHsgt0exbVgHmmjW1OuV1aeXaXv+b87+POg95Rbsa0MJi+yoj3bOWaDH04fV4w/FxxBZMVcDykSdkqzKOb2H1j3AYjgVBQWxNifStF1hT/qnSQjVjOY5+ocaka8nEEl4XzLJPByV1QB7gJLjS2LtL+wGK+ZJyBrqpxAwCyMSWDkIZjvhr8P9EY7ZsJh6CEjPn3IvFetnGQz92XSDMUJChIFdylCCBV3HbwVso1/X+TYwF6UsL/iGve5jqmXcAY7RZKOdXtnPRS0d8kb17QjAYhQm7l+RFD/731P9OaXmq35CpZ7a+nbW8LPxdZeaba8ypIGBG6qnBv2sU0Jce4r7gu8kVObhwFVYXCU/EMCuvZ7tIzxqLyVZs8gHgVl0A5qE2CLSKG2sC1LrY0xU1uSdkOSqDP2+2r3kEIbayJokNoYeGFGldN2XxJjYliemSmNnmgqYHmZtDA502UWiPTiSZjE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(1800799024)(10067099003)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JvSscdAWME1py3tmzQ0gqo29lcwwH9RjfzXP4hr+vx1RsQWTKTr5HMVuk931?=
 =?us-ascii?Q?1Dc2IR4EvKRIjB+VG/Bizg3g0rqSAEMjIl4QIbRkYwNN7tC6mVGW240hxnxg?=
 =?us-ascii?Q?EDoSBYa5ioqrxPyDNgst5PtI6dkNbo8qUUnX4PrO8x2s5c5PmFdHNtJj0rgm?=
 =?us-ascii?Q?I+udG0r/c5hmj+oZ1fBAffLPzs0C/fjUHnBikhvLanO5RoxOELnRnJbOp5Rb?=
 =?us-ascii?Q?Agp2NhN75JaxQbsqTXtZSeMn9umTdmAkRADM/rvOTSjel2ub++gkQj0jjw+u?=
 =?us-ascii?Q?0/wyw6MV9pW9gE3Bu9ZmFHPfsf91kAAsS9n6Ii/HaZJQfEyfQGMNONlSrKG6?=
 =?us-ascii?Q?7L9lmnXCMj3/uWaFCKrRRjZz1wG5p1OYNw8SrAFwVCXTOD+tVEA8uWqGj1JM?=
 =?us-ascii?Q?W4KjmeWtR1lKW47z7CU0+q0jlUwBl8D6T3tKIsBRV/sF9FFpBsPwFG5czEMt?=
 =?us-ascii?Q?H5SBeKte5nWdhw0eQa5bznAajqu0tWY1M0HT2jts7e2w2gcWfskis/RgLuul?=
 =?us-ascii?Q?4KH5jEMIb00QfRruyvtkBnIHyQGhM/LzN2U1u7vR/MDmSYduvD/M7bDgGj+p?=
 =?us-ascii?Q?y18IMSLQAyvtZeS9f2W4OPOJqXlDi8swN+Rlh8U7qSUtwpGxiPc0hDbU6Gbu?=
 =?us-ascii?Q?WfjNXySB3cbZ8P2RVI6kt9RS0AzY+2tr4Js/OsP399qsDOtO7qNa69s0509H?=
 =?us-ascii?Q?Md+1/4wjEerIltUyCAu4zd5vNyXDy5ZLa/KsP34Je2xikEEL/DgN6JJQHznv?=
 =?us-ascii?Q?JAmz0IpHvoLVLKFD8cqWb+GFLr/TJQ4FmK13Z/CnAGDiikixCnJ0WL8yCUpT?=
 =?us-ascii?Q?WDNsndeJ7D+R/KDjIfiteAo7wv71yhEqFVZV1FhhQjDsWpT0k7+yp375DJrH?=
 =?us-ascii?Q?2Nn3966zbTGRzWoZMRgDJ9PHi7glzIW06vG/gPhG6mas4+jQLh7d5H+GrxyL?=
 =?us-ascii?Q?0/1E/34thsynlq97WeltQsx+hfE1IiJC05AWsbnLEhjYnGxTJ6v/akyhywoY?=
 =?us-ascii?Q?LiI1OEeSH5JEvuiXccTUFIPiNSeMGj7HgKKkrdulRNd8hfPqIsckmvffpRtz?=
 =?us-ascii?Q?g0zaVaM1QbRn94nwd98qT8vDepR4Md0ZltLd3kZ0XXzvbuHxWLzqWh6Lgm50?=
 =?us-ascii?Q?i/SfddLejQCLVND5oZPB3qTICDawCihXDnj7qndh1NYdT8GDF/rZDXH7Xa/v?=
 =?us-ascii?Q?i8eSTy6x8VdIGsTtTMksA/50rwCxJDEiMU5rMP2io03RqIJpfWdYLbKRZ+oh?=
 =?us-ascii?Q?fe3X7YWMAX/Xeqb0KShybkixYFlov7JuRQ2n1eTI6+4cPSYB36A5clN7h1lA?=
 =?us-ascii?Q?r3K+2mTyPrdJFk2LJmKFKnwFY2v1ZlgPQ836OX2VSXv7XZsJoMHhU2e8iHUR?=
 =?us-ascii?Q?SUOtpnaEuPgZ0dS2iFZOEygLLVDT3M1i0mtkMaq1eyn8h1iw4jNq8EiIJFwT?=
 =?us-ascii?Q?05uoDTqtqBUUfVahz2ptDVmGXOlrAq30eyTWB8fqbJX2OdN/IscFcDuQE9rt?=
 =?us-ascii?Q?ptFjP6arGlSKbQbyhLFFvZWbTdNTno+vzURgjipIU6fqjdwNfZ6yzqWAlAMK?=
 =?us-ascii?Q?qlJdvUG9sDddRiYGuJPEA5CJq+PSl4XfVO46qK0i1dTk0DNk7HQsUmEknxH+?=
 =?us-ascii?Q?yp+24QCiZ5rF+C7Ndl6DNSCBo36Gz0nKLZ2jbGEcJFkW41UmnHi7+nAMGgny?=
 =?us-ascii?Q?3V0hv9OPyyGbHdZTPQDTqGy2NFkMUNOJ8KTDY0u3HqgS8ut2WXIWTJAKzFlP?=
 =?us-ascii?Q?aVjW5VjH2h7zXyYPACMqFLcruEDUCPsPWKOHG922+DCVdXND5quN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1668a65-70f0-419d-cee8-08df13488c07
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:44:01.9925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ocl/Z/3TvOpqdtcVK1CR33VqskgtlW+aCV30Bs9262gGCKfYscFRwqoph+6smc3XjuNQNU3dPnQS1NKoZGc0VoCKnZiGXWm41X8mL6Ocv2E9UOL9Hl/BR6dMo5WwPvpe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9670

On Mon, Sep 07, 2026 at 04:24:52PM +0530, Devendra K Verma wrote:

> For a register the macros providing masks for bit ranges.
> These macros if placed in order provide good view of the bits.
> Placed macros in ascending order.

dmaengine: dw-edma: sort register field macros by bit position

Sort register field macros by bit position to improve readability.

No functional change intended.

Frank
>
> Signed-off-by: Devendra K Verma <devverma@amd.com>
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
