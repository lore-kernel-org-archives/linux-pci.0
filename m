Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB212D2394;
	Thu, 23 Jul 2026 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820529; cv=fail; b=ZHvdB2I2KzOlrsW0FCpyPqupPY3MkfJ4i1tJ6ihFHWpX+YdHJtE6FenBMwuxUSGy1rMBKQ54wo3kTaRDj435n1d0Wfxe8i6KIMBeGkHIEwD6Y5tRAHzyQXQR+yVyw1jlUJwXvY2BLkaqpBxs7P/WrSDlhlVpuWLbEiiWiaKCSCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820529; c=relaxed/simple;
	bh=DRhYYUg2d32Y2R3BEuw1604L2zZPz8lHdegyaCHGXLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i6xDkzH7ylgWvMxxGKXs3aMbS4l9QtN+K+KrbHlzqVODILOR9e+A8qe+yRCfIX6zB9WDJMVqNun8KIEhQuA+XbCEdss9o4+nPjrMMMvFWYKaI5QCdNqtENipOedai8EQnnK+S7tEhryVa8kgWalGzU/V97L1U/7dRSf3omZMf58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xE1c9B+Z; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xE1c9B+Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhLBleG36H0O4bs7+XcrgLIjPig8vS5dJ12pKHP1GrgWO7pHRXambRroLsFPdkqSndnys4IvVD1m0WioCwKdO6I4jtIm9+yhoMtxWEQ6ntM+scuM7X/tVtTZDJnsdynQBvC0z+EosppeTYfGdcwe7OCmAv99FDsJBXgpW1IthAub3MlmA+AQJmn0KMni0BiI54egeuo0cx3bfrrPehgrvfNFMXg+pWDKcHaMsrfFrC9ousBQzDsQBTOob/fvICbOJiLgdZjqcV+Ba3he5w3ovYLkTV4uROMkHwqTgV8/zCSjYelvlTGxT/QgNdcJl8e/9yFVgYXo+YHGXFh+mhOw7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATunOrL8EPVSeCSgZxj5j6+CIYloS0r4CUosNLCl6ts=;
 b=tjTO0b/vG7pldJKc7L0bsxXvfineBAIlXqKFW12oFSLkSCsIMkzrrKJxv5kKjK0f8SEqea8aDAb+y5C0+nkHHhhv4klxYWMg7v2BbvtaHYcL60YcXNTJBFjol+BnfHjDAKiF2DpYjh7nQEBHLN1JZroKTKewwLDcvswi8BYjgv8pmzIzSRGSHB82o/m/6oOea/DNp+cf6+0PmDfw8GZcy3Asm4fCV2BTQCRb2cIUkaPqtTFWbAKBKfRTISXS/vdjGphPQKmBpIhndZk2ljD55efmGuKtgEWZSpN9dpkTh55qLSrxC8iXtEn1H19yYNbTd35od3MOYElIkIXRVEW3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATunOrL8EPVSeCSgZxj5j6+CIYloS0r4CUosNLCl6ts=;
 b=xE1c9B+ZD+47G6ujLZPgTOtkfx72sCGzXbCF1aZ1gEsiAp5YwH9myh41q/h3MPd+ORMYOkeHQ5YdCyqH6awM+03yjcUNQaZWTe3IEKG4eq2UUPYm2sHy1FWzMbWTwPanSB4WSDIa02QU7bwjKxdniHPw+fibXi1ucTDer/B8VyAycIyJS8H22+qa93QLWtP6QhsusrRGiF6GvQ1gCiH9YJGkYoyt8k0DDB6uC8k7E3D7mcsNh95pEn9srj/VgukdrlW5G7fMkzPa98Ro8mPAt7lUa9ZBsm5+vVnDE88qd2tKmSV3e3h3uMO3/WZnB88GscG2xKIuDTRJ7FgEMapWkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB12053.eurprd04.prod.outlook.com (2603:10a6:800:324::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:28:43 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:28:43 +0000
Date: Thu, 23 Jul 2026 10:28:33 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	Koichiro Den <den@valinux.co.jp>
Subject: Re: [PATCH v1 3/3] dmaengine: dw-edma: Add changes to support
 Channel Separation
Message-ID: <amIzIV5-p8_IgE2k@SMW015318>
References: <20260722111640.1146212-1-devverma@amd.com>
 <20260722111640.1146212-4-devverma@amd.com>
 <amDgIC0ZNGnGibzK@SMW015318>
 <c4d9ef2e-3bfa-4dfc-b943-1b42e04e9cf1@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d9ef2e-3bfa-4dfc-b943-1b42e04e9cf1@amd.com>
X-ClientProxiedBy: SA1P222CA0155.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB12053:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f0f11e-4558-4af5-1299-08dee8cf145d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|19092799006|6133799003|56012099006|5023799004|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+dCYvTUBbEWvIEu6qGbex47TsjUshZiwYquBq6cZen5OFKuWKd1DM+IJPDLFXyBHZyFDuC4BD+s6RXyHKo/ZOycT6fKcN/rXjkvoKIlFOKN/9VeIAX+K1izZqW8fN727xpPLjyDXa2Z9OnKh9zt0KP/O7ej+lUkTHaFDrNkpaP/mjeiCai1vxy5S4uwfbVKt/JhiDtIkMbZSt6eTsMjkYfBKqeNKX8BG5HpBCBcrvyt7agvHmb1IXWnm4cfLPhl72N7PiABeTLKi1egfS41T6goyrcDoYKALe75zlhpMr+utQuzr6NTS6Ps9kP4GD7eYCN3WTCKJTnQMn2N98OAgUSqxnwAUwCejCTqfjYItWl14lRCZEcyW9zcByHLu2FDkrAKpQRWYD0fu1sCNzcZaODFKbvJUFZZtCdoydvcec64xgu+e98zqpsW+NT4hgbeRhhjstUwK6hrDMhyHWBfcUSJ/JcpK+b4Lwl6RTcxgyB772ot+SQyNqKWKLRWBgoXelWdqzbMosji3XH+kCvfwTb0gkAmttDBIWibHNtSDlrvrcq+AnCOjiJmNzlJqCyuVoQwbm3yFjYbvdiAuEdVcJ2XrXyAoQ3bePUDF35uJnPZo4tTy6HXqAvkclT0vFI5ITbE+XNzRntIFcW+Lmnyw0765V5aXPgrUi46uUmb/VBQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(6133799003)(56012099006)(5023799004)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CJhfA+jvF75li4adcyAbTfxMblOeA9RrMBAGMO5cipyhgiWGHkW7BCg9TKmu?=
 =?us-ascii?Q?M5Hr58ZOw+wEIqnSHtBLgFrkQB4lhJG4KzzlkXH5aF8p4bGb0L2PMHszKJaL?=
 =?us-ascii?Q?6dwPIMGtokgRkKCPdPHOoub70aUh+GSLmsKyHoAY3V9F4CP6J6/st1linNpB?=
 =?us-ascii?Q?WWMI4sqYFyUO1EaFId+e9VwIkgJiLOlgz3P5hJu2b7OCLIg8oHP19aXz9n9E?=
 =?us-ascii?Q?0aOLSItpJ9mntVBzGCnhn0UOMRp3Gr+LsCsAEzCKtAQI1b8AAMBUuCeIGlc/?=
 =?us-ascii?Q?PSQHt1hul376AUWWNpoBGna8X5q9/AykCZlZ49HTSlrWmGDhZMxBfPNxNfFK?=
 =?us-ascii?Q?tg6Rjm/Dlo8PKswP4k5mHQ41yMcv+T3HKFSosrE2IFvU1vpzpqL/wF/+RNHQ?=
 =?us-ascii?Q?ZR3z/xa0y/azUSX9Ebql1bDUuwfXIe1svN3MO6182QMLht9zplE+hcS+txU3?=
 =?us-ascii?Q?bi4zMRw/Pg6Np3Kdk6tke+lZyxpJlostz45Ybb8h45CXyaiIa8amKX+M3cPo?=
 =?us-ascii?Q?eBDsXjnQN6xMmRuBw3Ks5Gn64szOM5Ugc7KYuYc/Ovf4trtHWgJYRpCup4kn?=
 =?us-ascii?Q?8uz58XEptsH6TKD8fXMi1bKTiib1O5Gw/OHbnb9VHGdn3H1jX/lXCMi3fS57?=
 =?us-ascii?Q?anT877KC74tcvRKU5N9vR0qBAXzHF1um/booAr//mr7FcfZEjH4E6G72LlWg?=
 =?us-ascii?Q?3+nRiCqoCSiKhaw+tChjMXadKNYCL45PO657y1W/bAZcolCNV04CYd5X7v73?=
 =?us-ascii?Q?f1EPBlsQW2gqsU6/MOEU5VK+6R24MZTrmJCPyC+UHhQkKADc5f4oeyyAg5IJ?=
 =?us-ascii?Q?TbXE/0KCdzJEHrmvf3ixRi8akaCc7lJBY6uvUDo9x8Q4cGltFwRzrcOkLF70?=
 =?us-ascii?Q?KnpYPZtpeVTsBd+jPhLilKwQF/37CiTo1RJpCEROlqWFZJhGLjg0rYMxv6FN?=
 =?us-ascii?Q?8+bCC9kFW3mBjIOJJPsgjr0aLoKjvN+LkLSpOilSTz1F0yZY8gCEw+fUyqfR?=
 =?us-ascii?Q?JffB0Dx3N7WWfzHe7u+gTnxAT9a4Gc73xzx+xGNglXjKmtBsUQyHspXh9MTu?=
 =?us-ascii?Q?rD7+cLBejP/7pejSVWTTeG98iRIew8JnBkdL+VpixBgmM1rP6md+fCLqmVbX?=
 =?us-ascii?Q?guTlbtXZV820+xg3XvW0dGH1ntTrNEmh1QQoYKF3H5wQAbautmGYQuHfep6k?=
 =?us-ascii?Q?Y9NOry6/boL8M23u/BGG5ORdjW5YahDlMwqfh1GjRDYew34g6Cy8KQ0OTA8h?=
 =?us-ascii?Q?F0IbfSH3too1J0D/1t54nNm3sbi9C/Fv//872G5XDbHf0FhFUwy0UXVlw6qC?=
 =?us-ascii?Q?HEkLohTVOrsuzbfbi67EOB1uzqO/XPWhD+tiZUCfzsV+7bqyMpPj2vDV/zQN?=
 =?us-ascii?Q?2lLyaNB3sEWBUUfO6PeBzfH7egGAozUIDJOfCxLrNi9CwEb9bd8Uuv2B6lkZ?=
 =?us-ascii?Q?6Pssuyc8C4kbyApxMqrzqG7rI6YzAuqLJgsX7/WAF30fvGb1zQnZ9VKh7ZzY?=
 =?us-ascii?Q?+lZY+rs4WNAl0Y+NAHRlV5jRWeyY9WPulcCy5yLnfRo7/9Z/M0YjQYoAomhC?=
 =?us-ascii?Q?3Irw02SvNm7wStOO7cd9IB1uSkULbHfFJjwq/GLC5oo4s0MsAusln/Pykmc8?=
 =?us-ascii?Q?LYsA8R+wS1MBSS1u842m+IHWsc6fa23mW95Xl0zsviM659kNVEPwIFQuBMQ4?=
 =?us-ascii?Q?bOae453cYMuSu8rPi8DA/fEieT7taV0sJvpkARggzKbBGWYXy153G8dYUk0v?=
 =?us-ascii?Q?7Vt3nVZ7/trmDf/k5dWurf8FItlEmHkyz60aPbfSFWl7hADSGlOs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f0f11e-4558-4af5-1299-08dee8cf145d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:28:43.6069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ipxeo5howhWowCwg+DVtjDHXzaW13SKMc6rEMhthzBp8s2eQsXm2p08dy0FGC5OSv4gKiEzcFvUl9DLnChTAgVSTaFwm3hlGPNrt/CVTTKL95vDl++khrhASC1+sku8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12053

On Thu, Jul 23, 2026 at 03:56:33PM +0530, Verma, Devendra wrote:
>
>
> On 22-Jul-26 20:52, Frank Li wrote:
> > On Wed, Jul 22, 2026 at 04:46:40PM +0530, Devendra K Verma wrote:
> >
> > Add Koichiro Den, who did many work with this edma driver recently
> >
>
> Sure, thanks!
>
> > > Following changes are made:
> > > o In 'struct dw_hdma_v0_ch_regs', it is assumed the channel
> > >    separation as 256-bytes which is default, but if an IP is
> >
> > channel register space size?
> >
> > >    configured for a different size of channel separation then
> > >    user can retrieve it using the supported VSEC (0x6).
> > >    Modified the struct to work with the channel separation
> > >    supported by IP.
> > >    CPM6 supports channel separation, default is 512.
> >
> >
> > > o Changes in macros / functions where address of the channel
> > >    is accessed based on channel index and direction. It enables
> > >    the calculation of the channel reg base address based on
> > >    the selected channel separation.
> > > o Struct removed - dw_hdma_v0_ch, dw_hdma_v0_regs
> > > o Functions removed - __dw_regs()
> >
> > Can you summary change and purpose? such as
> >
> > Support difference channel register space size for difference IP. Previous
> > use fix default value 256, CMP6 support difference register space size,
> > which default value is 512.
> >
> > Update channel register base address caluator method by use ch_space_sze
> > and remove unused dw_hdma_v0_ch, dw_hdma_v0_regs.
> >
> > You can rephrase.
> >
>
> Sure, I will rephrase this. Thank you for the suggestion!
>
> > >
> > > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > > ---
> > >   drivers/dma/dw-edma/dw-edma-pcie.c       |  4 ++++
> > >   drivers/dma/dw-edma/dw-hdma-v0-core.c    | 23 ++++++++++++++---------
> > >   drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 17 ++++++-----------
> > >   drivers/dma/dw-edma/dw-hdma-v0-regs.h    | 10 ----------
> > >   include/linux/dma/edma.h                 |  1 +
> > >   5 files changed, 25 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > index 6295d01ba2f7..ca2a4be2f3a5 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > @@ -113,6 +113,7 @@ static const struct dw_edma_pcie_data snps_edda_data = {
> > >   	.irqs				= 1,
> > >   	.wr_ch_cnt			= 2,
> > >   	.rd_ch_cnt			= 2,
> > > +	.ch_sep_sz			= 256,
> > >   };
> > >
> > >   static const struct dw_edma_pcie_data xilinx_mdb_data = {
> > > @@ -126,6 +127,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
> > >   	.irqs				= 1,
> > >   	.wr_ch_cnt			= 8,
> > >   	.rd_ch_cnt			= 8,
> > > +	.ch_sep_sz			= 256,
> > >   };
> > >
> > >   static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> > > @@ -139,6 +141,7 @@ static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> > >   	.irqs				= 1,
> > >   	.wr_ch_cnt			= 8,
> > >   	.rd_ch_cnt			= 8,
> > > +	.ch_sep_sz			= 512,
> > >   };
> > >
> > >   static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
> > > @@ -443,6 +446,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >   	chip->nr_irqs = nr_irqs;
> > >   	chip->ops = &dw_edma_pcie_plat_ops;
> > >   	chip->cfg_non_ll = non_ll;
> > > +	chip->ch_sep_sz = vsec_data->ch_sep_sz;
> >
> >
> > This blocks PCI endpoint DMA, this driver is not only used by this.
> > EPC controller will not set this value, so ch_sep_sz will be 0 for EPC
> > controller.
> >
> > Frank
> >
>
> The EPC driver is using the chip->reg_base + reg_offset for computing
> the final addresse and not using the register mappings. If the
> reg_offset are correct then this ch_sep_sz change will not affect the
> EPC driver.

show me, how work, both use below method to get channel register address

__dw_ch_regs () {
return dw->chip->reg_base + (ch_base * dw->chip->ch_sep_sz)
}

Frank

>
> > >
> > >   	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
> > >   	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > index 632abb8b481c..3f27a93c4d8c 100644
> > > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > @@ -23,18 +23,23 @@ enum dw_hdma_control {
> > >   	DW_HDMA_V0_LLE					= BIT(9),
> > >   };
> > >
> > > -static inline struct dw_hdma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
> > > -{
> > > -	return dw->chip->reg_base;
> > > -}
> > > -
> > >   static inline struct dw_hdma_v0_ch_regs __iomem *
> > >   __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
> > >   {
> > > -	if (dir == EDMA_DIR_WRITE)
> > > -		return &(__dw_regs(dw)->ch[ch].wr);
> > > -	else
> > > -		return &(__dw_regs(dw)->ch[ch].rd);
> > > +	u32 ch_base;
> > > +
> > > +	/*
> > > +	 * For Write, the channel register index starts at
> > > +	 * wr_base(ch_idx) = (2 * ch_idx) * ch_sep_sz
> > > +	 *
> > > +	 * For Read channel,
> > > +	 * rd_base(ch_idx) = (2 * ch_idx + 1) * ch_sep_sz
> > > +	 */
> > > +	ch_base = 2 * ch;
> > > +	if (dir == EDMA_DIR_READ)
> > > +		ch_base += 1;
> > > +
> > > +	return dw->chip->reg_base + (ch_base * dw->chip->ch_sep_sz);
> > >   }
> > >
> > >   #define SET_CH_32(dw, dir, ch, name, value) \
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> > > index dcdc57fe976c..33128685bbd9 100644
> > > --- a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> > > @@ -13,22 +13,17 @@
> > >   #include "dw-hdma-v0-regs.h"
> > >   #include "dw-edma-core.h"
> > >
> > > -#define REGS_ADDR(dw, name)						       \
> > > -	({								       \
> > > -		struct dw_hdma_v0_regs __iomem *__regs = (dw)->chip->reg_base; \
> > > -									       \
> > > -		(void __iomem *)&__regs->name;				       \
> > > -	})
> > > -
> > >   #define REGS_CH_ADDR(dw, name, _dir, _ch)				       \
> > >   	({								       \
> > > -		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;		       \
> > > +		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;                  \
> > > +		off_t __off = (dw)->chip->ch_sep_sz;			       \
> > >   									       \
> > > -		if (_dir == EDMA_DIR_READ)				       \
> > > -			__ch_regs = REGS_ADDR(dw, ch[_ch].rd);		       \
> > > +		if ((_dir) == EDMA_DIR_READ)				       \
> > > +			__off *= (2 * (_ch) + 1);			       \
> > >   		else							       \
> > > -			__ch_regs = REGS_ADDR(dw, ch[_ch].wr);		       \
> > > +			__off *= (2 * (_ch));				       \
> > >   									       \
> > > +		__ch_regs = ((dw)->chip->reg_base + __off);		       \
> > >   		(void __iomem *)&__ch_regs->name;			       \
> > >   	})
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > index 7759ba9b4850..2475b8d96133 100644
> > > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > @@ -84,16 +84,6 @@ struct dw_hdma_v0_ch_regs {
> > >   		};
> > >   	} msi_abort;
> > >   	u32 msi_msgdata;			/* 0x00a8 */
> > > -	u32 padding_2[21];			/* 0x00ac..0x00fc */
> > > -} __packed;
> > > -
> > > -struct dw_hdma_v0_ch {
> > > -	struct dw_hdma_v0_ch_regs wr;		/* 0x0000 */
> > > -	struct dw_hdma_v0_ch_regs rd;		/* 0x0100 */
> > > -} __packed;
> > > -
> > > -struct dw_hdma_v0_regs {
> > > -	struct dw_hdma_v0_ch ch[HDMA_V0_MAX_NR_CH];	/* 0x0000..0x0fa8 */
> > >   } __packed;
> > >
> > >   struct dw_hdma_v0_lli {
> > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > index 1fafd5b0e315..a6c5728f03d3 100644
> > > --- a/include/linux/dma/edma.h
> > > +++ b/include/linux/dma/edma.h
> > > @@ -104,6 +104,7 @@ struct dw_edma_chip {
> > >
> > >   	struct dw_edma		*dw;
> > >   	bool			cfg_non_ll;
> > > +	u32			ch_sep_sz;
> > >   };
> > >
> > >   /* Export to the platform drivers */
> > > --
> > > 2.43.0
> > >
>
