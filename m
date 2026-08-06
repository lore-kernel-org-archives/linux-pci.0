Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E154125AA;
	Thu,  6 Aug 2026 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029641; cv=fail; b=KdyIgeDNhGqdG1K9K+O8cQqMRiMadl88y8ox9Z9M4r3DY7sKsTAWMyHZ5XKZQTJ8TjqbqDVubcl2n+Q/A+9XACx5I6tVrrC80Ud/GJsrXgg85fcO4uMseqguxGHHfy+6J4idv9+Bog2MBsw+8C1CdK9TUXwBKRNElVBOm/+JsuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029641; c=relaxed/simple;
	bh=KWQWu9UE1qKtnWtY5vUXW3151dpksZwyDSu/zsa2b9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dfgdwe0Fd+XYRf1fxudJYoQAhUYYTrIfxdCwolpDglD8DagYnjNCPjIbxkUihCj3ojwCmmTcoZVGqm55G7puLeuYS3CR2TJ+WGSvmlh5j3rqP39149KVn7Yj1mwoN2kFglUPh4xcKLhCuLT7sgeYPW+jwtFY0CwnCo7CJtRJiD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=n5H6d1y4; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="n5H6d1y4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiOK0XxiH2pQWvNJ9EIfainy5bAicnGpSeCw2kAnf+EgrYB6UiEJXOFERvWBOcJVTjU13Oj/vzKUf2YJNZnNz15VJ41N9MCL5DAy2ElxFNa6QVvzDff38XieYzFGThi29JjHPaoXnLMjwzANfBCVf+jwO3DG2IaIoSzFcBigbOANHp3SUiGmji+M+f/NemNRKFJ9WSTjERGM6pMO8VZHFMhCKXh3HHeSlazGKcnSZYdPuAWo24DxNhoOY/8OzEYUsoYbGKSLZBn3L81O6JK7jEBGudXkAD7irDpf9QmxYr6ditOABdM3H/ibKatO22DwEIhkKHS0TtnJaeo+spNaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYNAoaR7zPmzxhieRDcln4o8XSHrcLkn3zrKRLWZ7cc=;
 b=ILXcXa+koiNciBVt2KPpgwlCbNyiDQMSrT6IS4j/T3GLkSixJBzo+SNquPFUhhhMMo07C2d5fBfaSeFvdR/tjriX8hFy+0uJXy3xL7Y4uhBUo/is6LSVtccVIY2P4ljAhL1Q7wEW6CSh0dBo/kSsAdy/wq4SuXGaX1PFAyJ6EFQheLfMfigaJAb9McK3whN2MU4vHmVdIsAHfSkK4UiuWDrsXkKhFg9N1ZJysGVU40ChbIMF18zOyiHqjCIIc2rzVhx0npjzsBg25gjw1HhwroXGEJwrjuYkv5of7GJzrT6Zb9AiNtVZyJZV4aPA2dXvqf5ABeVrBnvYxiH66Vr0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYNAoaR7zPmzxhieRDcln4o8XSHrcLkn3zrKRLWZ7cc=;
 b=n5H6d1y4blmauuOqOu3qQ+U8aTdLs6fwn9m7za/5SLtcmktja82t4Q9oDvOO1Qt7TQmcJH7ASmjgC0Tf7Z2GqxO3Iwi3eSf4zJezyiHR7yysPd2Jcgoz22zs8Xqv57KdRP7O0J+LM0XDgHzepLCTf2OnYNooc2lBUQD28J5PbuNFWqbj1RcorTxTBhvL8kfbcL9Uxu/VV53Tcph+18p5Wvmgfey/ArKo8hxp0Wj0RCQQrsUbhBgbzQq3edoVL9S86SxVBNcBK6aj7afCBPLzct2bLfSba3McyQd96JsHmCzqb8t2fVWEqB+Be3uj1s7csLzbVpFbqSfRQ62J/EZzkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMCPR04MB12621.eurprd04.prod.outlook.com (2603:10a6:20b:76d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 15:20:36 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 15:20:36 +0000
Date: Thu, 6 Aug 2026 10:20:28 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v2 2/3] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
Message-ID: <anSmPKdneDINIoa-@SMW015318>
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-3-devverma@amd.com>
 <amjLxoj9Ut84PDGJ@SMW015318>
 <e3fa8833-ce85-41dd-8b07-97f85d20b97e@amd.com>
 <amzAhe-YbGECDCZT@SMW015318>
 <d9ab60af-a46c-45e1-829f-72d6815f1946@amd.com>
 <amzyDsPP-H2M4FkQ@SMW015318>
 <e3e87269-dd5c-4ef6-8361-6a9e010356d4@amd.com>
 <anJo017Z1_Ah4ek6@SMW015318>
 <8ba90d9f-be10-4312-a2db-1c547350c563@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ba90d9f-be10-4312-a2db-1c547350c563@amd.com>
X-ClientProxiedBy: SA1PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMCPR04MB12621:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f7a9de-87ce-4685-f03c-08def3ce43b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pi12lfFv5GJj0MVgMJwU4P195TBVAC19tHqV2OID1QXQGuF22+X4GU6P4DDKzfRhrMATfMxXaPxMgjmYyJ8Wb8ywiWOgi/RJito8DikwvTwqEQm4lJfMW/BzMMh5xBCRzs6G7821qcGI2D5oFzPAU/fAUXymKo604+2pxpOmRnyr/qXp2FV+urRrJUQ7Gd0UsN9ub2nBE3oIYxmFTt9uYlzozBfhb03ryo58sx8Q+o3Dmef0jJFgDxV+YcPy8SyRyxQeE2YETr+afswYAnxxEEx+MG3qn/+u2lXIFh40FgQ/WNCLNR+92aRFFs/e8on7NEQfL0UtDlfIWBIIiijxIFzffitYmomenaON47ysSKgg+G/faX34/fz1eblEmw64F4I5dxIj7nEc9eRI6v2vqBCO5Rpib+liWnmnAFMzVWxb2mJ7QhWiDU6ALZnxF8JyODonL0jk4hVXEMszhzQMCsjMugUL+STbrG2wQrGH/uH+AIumFUuEqeu+/1xAqnOqva5H+UHRP0v2AA1gl2BfKrbYzSAXVhjEMpTjDLatCqxaxb57AmX7eEzQPsWapmUxhvbEgrWUetPDS/LOBGeRSwC7q1iTi0SHyfo1mzarkG2pGo/p1s+9dxYl6Wx5bTir4dt93Mbm7H92kxPFwB6/iZBizvTd/T26+fQ2ROw3WJs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xH4vv9Fza1/BwykclhWCUi1xL+oOSyfqzo/UpXcJ55IQWTn7f/w+61AYTggs?=
 =?us-ascii?Q?dlK+yBAq3LiF2q/c2McM1/sT1fpvhiNQAI0h24Ax6CVVl4g6kNjvYIUH3Vx+?=
 =?us-ascii?Q?6CsS9j3vcFctgl6i6AL6KpkxGRyP+10g32QRjW4/yNXKrsWiMD2uadlRP01+?=
 =?us-ascii?Q?DhsaEuU3k18WH3RoOu+A4vqYmdyzSpdfSQSQlEjL7EHMtNGLT0PwjJTMFvlW?=
 =?us-ascii?Q?GZ3CUzCjspWijQXMzXTu4osSxqfthg3siF8hmJqHN9Bx2vwx6qi58h0t4uZ+?=
 =?us-ascii?Q?nwH8KuJzHcQiV15Dwhpd5VFEoLzKvmU6JhnBVVW9YxsPBc+86R+0CdrgfiAZ?=
 =?us-ascii?Q?FLP9Vl+6l/Z/qWOoWHxD2+EY2RLKXa93JSK9HCx4FjTQiwYbi9zeM4CjyuKl?=
 =?us-ascii?Q?SCbHKNqLgUhAOikLSruZvn0RntHyOBGxzFt8Cnj50f0BKM8cvB/l+HMo+8rd?=
 =?us-ascii?Q?MavTyeKt53xhSuls2QY4vDq/uvdxv7vMejPjH6teNZD9VIJ1pk/zJ63x5b7u?=
 =?us-ascii?Q?bJqVIN5nhScELFl1hsW+BT/Ei15na8qd1OJNdRBUID+iuOmVXdamGC7DM2EU?=
 =?us-ascii?Q?uxUc6N4ZR3Yy08FcK30PE/3X/H4IxvIkwyXEUhQ7K8vdyvCLUDzkF6x9jMXb?=
 =?us-ascii?Q?K0TjwiTicb9K58K00M4j/lBITzWs5SfLGmzFc0lZ3AW5TWY2DNzeuqCn36Zy?=
 =?us-ascii?Q?+bAv3c+yhPZUhyozYZeiXX2DeS6jMiOX6jalGPVt3IhuDVMHiq05bfLNmHSo?=
 =?us-ascii?Q?26uyZO5xetTY+koRgfLrKu42aBxbrLXwY3o5unamUYZQGpHov2nwftHpiF8/?=
 =?us-ascii?Q?AcLbeEd5p5EdnBOZc9PpgDoF+CEw9jCnlWEWZLbZmg2wdwRhlJYnOrkQOZXY?=
 =?us-ascii?Q?GEOOF9yAVYgFteUkrxQKgRzrvCXhfKQTW7WYnncsAZHLIRWpe+OXkQcMM4vm?=
 =?us-ascii?Q?DzWbYVGjJS0BFsxJ/np4Qblx3gIn11Vp4/RxpzfjbO2TD59b/NP8XGvxK69l?=
 =?us-ascii?Q?FfHnBzj/PSVBek8e9h/5BbMrUL7bTaJf/JWaQcG4fOFUIIGGKs0Gny1Cv/+9?=
 =?us-ascii?Q?cofecHg7N52ISb3Oeu17zfuArzKvL7/RHgIthBAD0uNKy3F0q2st9HcPXCUy?=
 =?us-ascii?Q?8vK5m0rFPsFMEouapS089nOaB3QCRywSxeMMNY/JAcBhu9GqCMhvQbV0y8qN?=
 =?us-ascii?Q?WuoXo47uXuPOJj8O6HHYgri/AUE/byzRqhxE5JT5volmw66hwMZBwer0NG1Q?=
 =?us-ascii?Q?Lruevrb5xC3yWqJswTuLU/fhgW8UeAL1NzEd1D0LnTddeaGnn5sQQGeuUwsc?=
 =?us-ascii?Q?rOjRycWzAZqB0aCilL2ZfVDA7co8c4qFLHpUpF1JfoHhJg8vraztLYCZh8UM?=
 =?us-ascii?Q?eoj5b8H2bfVkb0jm2UGCmDX6U6tH1ROY0oUNrrr5VAyzpjBCW09qL6UK6wSF?=
 =?us-ascii?Q?yuVHCdduRJ+Jp1e0coq3ImaDD8chl5vp4cJRshULI4eYAbqE8sZJfTlUGybW?=
 =?us-ascii?Q?o6uoKx83/Z5J7ENvRZ9oWd6Y1LJ0zdBW8/BR1jXiWNjcodkxN9gPAzUYS3CC?=
 =?us-ascii?Q?Y1wxkJEdXb8Txr0wCiYmlbIlvsIzTxexbM9fuxJWM4enWvvWxj7Pplwz9bU0?=
 =?us-ascii?Q?6ITEn5d+Mrh71EYaE84pnEWt9JEr6eaBDhnePbs8oytWv163fX0U9pKLIN+8?=
 =?us-ascii?Q?y0u1F9qyKWcgcD9YcTWywMAETbrWyPBErpRc3VDmi2A+xlRNHiGzmcwtr+JF?=
 =?us-ascii?Q?21JLEIosH5ar2QTEJSrSyJhaT9vjdSO/VYDM0hQVBxtir3gW+LG0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f7a9de-87ce-4685-f03c-08def3ce43b3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:20:36.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9nrOlLumrvFPNSset8cO/kbMXIs0Fn4qFhTIGQmJ6Z/or86Jqz/ERn7GCSmS4QNkq7IkaxF4rb0PJXHaYiK8la1ZiwobdARQEvzgFvekxl43Z3lbhgzel5WhBAVcVqb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR04MB12621

On Thu, Aug 06, 2026 at 06:36:26PM +0530, Verma, Devendra wrote:
> On 05-Aug-26 04:03, Frank Li wrote:
> > On Mon, Aug 03, 2026 at 06:01:39PM +0530, Verma, Devendra wrote:
> > > On 01-Aug-26 00:35, Frank Li wrote:
> > > > On Fri, Jul 31, 2026 at 10:03:10PM +0530, Verma, Devendra wrote:
> > > > > On 31-Jul-26 21:04, Frank Li wrote:
> > > > > > On Fri, Jul 31, 2026 at 04:22:22PM +0530, Verma, Devendra wrote:
> > > > > > >
> > > > > > >
> > > > > > > On 28-Jul-26 21:03, Frank Li wrote:
> > > > > > > > On Tue, Jul 28, 2026 at 02:47:43PM +0530, Devendra K Verma wrote:
> > > > > > > > > As per, 'Designware Cores PCI Express DM Controller - Reference
> > > > > > > > > Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
> > > > > > > > > the channel separation mechanisms. Basically, the HDMA IP allows
> > > > > > > > > the user to configure the separation between DMA channel
> > > > > > > > > registers and retrieve it via the VSEC capability mentioned
> > > > > > > > > above.
> > > > > > > > >
> > > > > > > > > HDMA IP supports the channel register space separation from
> > > > > > > > > 256B to 32KB. Default supported size is 256B.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > > > > > > > > ---
> > > > > > > > > Changes in v1:
> > > > > > > > >        o Modified dw_edma_get_ch_sep_sz() as per review comment.
> > > > > > > > >          The function now supports ch_sep_sz up to 32KB.
> > > > > > > > >        o Updated to description to reflect the supported channel
> > > > > > > > >          separation sizes.
> > > > > > > > >        o Introduced the CPM6 specific macro for VSEC cap.
> > > > > > > > > ---
> > > > > > > > >      drivers/dma/dw-edma/dw-edma-pcie.c | 21 ++++++++++++++++++---
> > > > > > > > >      1 file changed, 18 insertions(+), 3 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > > > > index ec5e057a0f11..d0f209082878 100644
> > > > > > > > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > > > > @@ -31,8 +31,11 @@
> > > > > > > > >
> > > > > > > > >      #define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
> > > > > > > > >      #define DW_PCIE_XILINX_VSEC_ID			0x20
> > > > > > > > > -#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
> > > > > > > > >      #define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
> > > > > > > > > +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
> > > > > > > > > +/* AMD CPM6 (Xilinx) supported cap */
> > > > > > > > > +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
> > > > > > > > > +
> > > > > > > > >      #define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
> > > > > > > > >      #define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
> > > > > > > > >
> > > > > > > > > @@ -73,6 +76,7 @@ struct dw_edma_pcie_data {
> > > > > > > > >      	u16				wr_ch_cnt;
> > > > > > > > >      	u16				rd_ch_cnt;
> > > > > > > > >      	u64				devmem_phys_off;
> > > > > > > > > +	u32				ch_sep_sz;
> > > > > > > >
> > > > > > > > ch_space_sz?
> > > > > > >
> > > > > > > In the document, Designware Cores PCI Express controller Reference
> > > > > > > Manual, it widely referred as channel separation and ch_sep
> > > > > >
> > > > > > which version? I only find "Register Wire Channel seperation" at 6.21a
> > > > > > Feb 2025.
> > > > > >
> > > > > > Frank
> > > > >
> > > > > We have the reference from RM - 6.00a June 2022, following sections:
> > > > > - Table 1-4
> > > > > - Sec 3.2.34.3, Table 3-276 (VSECDMA_DEVICE_INFORMATION)
> > > > > refer to channel separation and describe for HDMA
> > > >
> > > > But this is not register value, the register MACRO defination should follow
> > > > spec.
> > > >
> > > > "Channel Separation: Address distance between read and write channels."
> > > >
> > > > helper function dw_edma_get_ch_sep_sz() convert register value to this
> > > > field.
> > > >
> > > > The field should use software easy understand/generic term, so reader
> > > > can know what's that easily without check spec. Driver need do some
> > > > abstract, instead direct copy from hardware.
> > > >
> > > > Frank
> > > >
> > >
> > > The other macros defined also follow the similar format as mentioned in the
> > > RM. I did not deviate from the rule and used the variable which is both
> > > understood in software and hardware context alike.
> > > Please follow the discussion below.
> > >
> > > >
> > > > >
> > > > > -Devendra
> > > > >
> > > > > >
> > > > > > > has been used so in order to keep the relevance with the document,
> > > > > > > I chose it to be ch_sep_sz. The other name used is chaddr_space but
> > > > > > > it is not used widely as the ch_sep.
> > > > > > > With your suggestion, it can be infered to be same but relevance with
> > > > > > > the document may not be established.
> > > > > > >
> > > > > > > In the past, a similar discussion we had for choosing the non_ll
> > > > > > > naming and chose this as it mentioned and has relevance with the
> > > > > > > document.
> > > > > > >
> > > > > > > Reference
> > > > > > > https://lore.kernel.org/all/20251223162842.GA4022246@bhelgaas/
> > > > > > >
> > >
> > > Also, as pointed out in this thread, it was a learning how naming
> > > shall be convenient and relevant to the concept being implemented
> > > and that's where the idea of naming the variable close to software
> > > and hardware was taken up. It kind of helps in relating with the
> > > RM data.
> >
> > The term "channel space size" (ch_space_sz) is more commonly used in kernel
> > drivers. It is widely seen across various DMA engine drivers and is
> > generally easier for software developers to understand. In contrast,
> > ch_sep_sz appears to be more specific to your hardware implementation.
> >
>
> Hi Frank, could we have a little libral approach about the
> naming conventions?
> I checked the linux/drivers and there is no such name exists
> ch_space_sz or ch_space_size. The term 'channel space size' may have

git grep -E 'space_sz|space_size'

> been commonly used but that is not getting translated into any variable
> in the linux/drivers code.
> I checked it here: https://elixir.bootlin.com/linux/v7.2-rc5/source
> and manually within the source code.
>
> I get the intent that widely used names help in easy understanding but
> if a variable fits a requirement and has a valid reasoning then it should be
> allowed instead of having of single point of view. Some
> variables may have variations, if it does not change the meaning
> drastically then I guess it should have been allowed if not
> causing much harm.

Not exactly, field in drvdata will used by other vendor also. Not only
for AMD. I checked origin DW design book, ch_sep is hardware signal/config
name.

AMD just reuse it. This driver is NOT dedicated for AMD.

>
> The selection of name is based on two such references so it is backed
> by the evidence as well:
> - RM widely mentions it as chsep_256, etc, it can be directly related
>   with the code and vice-versa.
> - There was one such previous discussion over the exact similar topic,
>   how the name 'non_ll' was concluded, even though it sounded as
>   negation but fit the requirement, eventually.

Because "ll" is enough popular as link list. Many dma driver use it.
git grep "lli" drivers/dma

non is just prefix, everyone know thats.  "sep" is easy to miss understand
as seperate token/chars.

naming itself for both non_ll and (has)_ll are accetable.

>
> Also, it makes developers totally dependent on the reviewers as only the
> selected name will go, not even the variations are allowed to
> passthrough.
> Please consider the name once, it was well thought about in advance.

One of reviewer/maintainer's reponsible is make API or key name consistent
and maintainable in long term.

drvdata is high frequency change data when new hardware appear. We need
make it easy understand and self documented.

Frank

>
> -Devendra
>
> > The other existing fields are self-documenting, clean, and easy to
> > understand.
> >
> > Additionally, this change introduces a conversion from the register value
> > through an algorithm, even though the calculation itself is relatively
> > simple.
> >
> > dw_edma_pcie_data is not only used for your hardware.
> >
> > You register name already align RM data, which is already enough.
> >
> > Frank
> > >
> > > -Devendra
> > >
> > > > > > > >
> > > > > > > > >      };
> > > > > > > > >
> > > > > > > > >      static const struct dw_edma_pcie_data snps_edda_data = {
> > > > > > > > > @@ -127,7 +131,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
> > > > > > > > >      };
> > > > > > > > >
> > > > > > > > >      static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> > > > > > > > > -	/* MDB registers location */
> > > > > > > > > +	/* CPM6 registers location */
> > > > > > > > >      	.rg.bar				= BAR_0,
> > > > > > > > >      	.rg.off				= SZ_4K,	/*  4 Kbytes */
> > > > > > > > >      	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> > > > > > > > > @@ -189,6 +193,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
> > > > > > > > >      	return pci_irq_vector(to_pci_dev(dev), nr);
> > > > > > > > >      }
> > > > > > > > >
> > > > > > > > > +static u32 dw_edma_get_ch_sep_sz(u32 ch_sep_val)
> > > > > > > > > +{
> > > > > > > > > +	if (ch_sep_val > 0 && ch_sep_val <= 7)
> > > > > > > > > +		return 256 << ch_sep_val;
> > > > > > > > > +	return 256;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >      static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
> > > > > > > > >      {
> > > > > > > > >      	struct pci_dev *pdev = to_pci_dev(dev);
> > > > > > > > > @@ -279,6 +290,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > > > > > > >      	pdata->mf = map;
> > > > > > > > >      	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
> > > > > > > > >
> > > > > > > > > +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
> > > > > > > > > +		pdata->ch_sep_sz = dw_edma_get_ch_sep_sz(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP,
> > > > > > > > > +								   val));
> > > > > > > > > +
> > > > > > > > >      	pci_read_config_dword(pdev, vsec + 0xc, &val);
> > > > > > > > >      	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
> > > > > > > > >      			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
> > > > > > > > > @@ -324,9 +339,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > > > > > > > >      	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
> > > > > > > > >      	struct device *dev = &pdev->dev;
> > > > > > > > >      	struct dw_edma_chip *chip;
> > > > > > > > > +	bool non_ll = false;
> > > > > > > > >      	int err, nr_irqs;
> > > > > > > > >      	int i, mask;
> > > > > > > > > -	bool non_ll = false;
> > > > > > > >
> > > > > > > > unnecesary change
> > > > > > > >
> > > > > > > > Frank
> > > > > > >
> > > > > > > Yes, it is an unncessary change. It was introduced by me in some patch
> > > > > > > series and wanted to maintain the revers x-mas order that's why posted
> > > > > > > it. The declration order looks in the patch after this change.
> > > > > > > Please suggest is it OK to include changes like this or it is kind of
> > > > > > > extra scrutiny for the reviewers? I will make the change accordingly
> > > > > > > in next patch.
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > >      	if (!pdata)
> > > > > > > > >      		return -ENODEV;
> > > > > > > > > --
> > > > > > > > > 2.43.0
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>
