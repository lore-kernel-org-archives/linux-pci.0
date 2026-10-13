Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F54F4735;
	Tue, 13 Oct 2026 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903207; cv=fail; b=JX+jgzNgE3F0E0KjGhLM4oaImARUc8UrOaT/LJxN4+Sbqtk8jqzGRxBMREv0QLwwRFlJ7GsSWDr2HXTQt9LFhU2YodFHgwBMHbkluLGJ2M7VrOwwrhBJX1GBDBG6U5eZO5/Kh19oisl7g2p/sbvstDqWV1b3gZq2bmKGLPHdZys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903207; c=relaxed/simple;
	bh=/Juu8YH32c9NE0x/GxNax5Nb8YadnhFAsEWTTa+QFjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T4+mJQJRRAr3d3mwzzcgUNkEnP9qo/BKS0bGXHzf8zcaiKLU7rLrbd5A2xf3Oe8iw7UgIPI61UvMsiQMCLW0gfms5Vhfv0fvLr7ZCgYc5ThgVMdpsn0oxTsbA8l7DOt/e09ePLrCSo3SgH3qrW5Yr3EEeHNTfjDf7TcQFNpFJe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=W77LNXIs; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W77LNXIs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=golrGviTXh6AuDzDUln7xnWZUIGxvTBJQsS/wEizRM2pC/QS2KPY2alaxXyVJy9MdPgTgb93nwFm/afh4S0f/26HHxoV7cnC7gn1f1v+iMq+Fvapr/PQ4qekoykoPEsdU2NHYSEX04OVa+eJn4rlxTBiWhbpp5H/EGYvwLjq+txDQrogeGNlwdiYnq5+mCJwMsxr+KyYxiRa7s0VOkLIyvQ5WdCbqkdMf4LIWFLW/Dp2sBBjUAX0aBn/pBdaMrVw/mUbBivtaY23efydou7VLHBXhGBk04h1HjPhvlbEyeX2IgQQLDqYZ9+imDczSWDbLs3ojCJDN3EFRhlvmVTKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYFAMdZp9ZrspksrDhY783hFT4kwotTb0eqiSYMTjTM=;
 b=YUlX3dVDfsPt0M250H3JKKHmLtBHAbd+IOq2P5K9JcboLc6tMSECRt+fLhwveXu/I5H4tG/AKIlP2Ouub1AbQLcFHDAGwIDauWDBKCR4RHZhDT5wz7XMfPKZp/LGGWYpvJZNQJuIHtQXEprXGRWt8FHPJQNX0U4wM8SIn+eHApWNJB2Dju5KkdeJ+Wi8GDeGlEH7MsZZqKZnOG+0S4XqKmZa+wMpu3TONBqI7045xoTQDR3ydKcuhKaXikKeefReyeDrZ2KXfokx8/5/zzjo+XbQeyOPekWeuo1tMT1ssWlST8WzJmFNpn/+2TQHUWVJhd3TJCYFx1Ordd0r6oLTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYFAMdZp9ZrspksrDhY783hFT4kwotTb0eqiSYMTjTM=;
 b=W77LNXIswU1yA1d5PqcFYaSq7J4/uSkcfjj6nBJVQNjAsJKxoxqpaMWy4WnuKkXZ6Q9vPFy7FoKJieCjxXxUORwCUBKXDsHAj+AH7Jh1KIUkie5F6j7RCg8hkW5Z0krEjJXioyPq2EeoUhxffu5vd6cNa0HdAOEUB7l/il8lRf4l6QygHBPl5T4p/qMdMzlWYtq1VFrdZX9JBuAmy88w4g1m3yfHPvdOqIL6CzzsAHa1Gb95/DjkPolIWX5iQdz2+d4HXb6AwOJ8DZwWkIhiy/e5oWw5o5cgNXf0VGT85AWPpn1BNKAlu8tXkhu4j/do/8WaifqhdKPVux97DKJFYw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MIWPR04MB308196.eurprd04.prod.outlook.com (2603:10a6:290:ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 14:53:21 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 14:53:21 +0000
Date: Tue, 13 Oct 2026 09:53:04 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v5 6/7] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Message-ID: <as5F0EQB3owMYmFV@SMW015318>
References: <20261009045949.1109871-1-den@valinux.co.jp>
 <20261009045949.1109871-7-den@valinux.co.jp>
 <as09Xp_EMjPDdk4x@SMW015318>
 <vnae5ngbbkomapwx44zqszdwcx67kv7qpxuzrs6o67uo5qphs4@hxfu6p6ewgt4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vnae5ngbbkomapwx44zqszdwcx67kv7qpxuzrs6o67uo5qphs4@hxfu6p6ewgt4>
X-ClientProxiedBy: CY5P221CA0144.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:6a::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MIWPR04MB308196:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f976df-781b-4d72-8ef9-08df2939b973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|23010399003|6133799003|22082099003|10067099003|18002099003|5023799004|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Q/K/+dwMcAduZOipe9iVihdWK36eYpqF5Q6xBtMQRFjvnmBQtBkTzUDRCtpnh4luW8nkQgq7f1vLHi1ggSOx/1RDWUuDVsAKKfjF/iE2iSdX6FnuZWGHwhQZuZwH+0o1j5xo6n+ieQitn8uFP5KEiU9LwXSPL6cJWIYKc1lxdGbeNx87GqRtahK+Sg8GPOkJulQy0Ar4HRwbT62MLPcAw5qlKlruEmv1yEaxGX9cCl8tzCfREQLioZANfvkUavSE9NPgfUWvq7H6mMVq7qxBf+CNBZKwOez+C0qp8hh6vSLQMMHO7WESv38c3xt1/72n4TCHo/1MriUsqFtWR0eYieaiujzkZ3vQsjq7zcAMNzpTs1yuf/7rkXR/QmtRrXF+vxX6U3tnJKUYb/GPBKhZRryJENdKnkqxH6fDole6h1kl+0zm0OQ6LvvZ+IdU6m/b5XuPlvIw/MA8u8B1Iev9DAnWQi1OpadwIX2cTKvHXRTwBU6izl6YG/o9TU0eU2bk38x3bKXIwAMSkBUfdFJnpsBvifCW2qStsdi5pbDcfkgcjvk7/pSMs56N3NHJnnCl8ZCYHo7qpHTtTxLCLtet6i5+HLigv8oFq2wmjEWiCUMTHMwM1pzFVEidyyHI3QwJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(23010399003)(6133799003)(22082099003)(10067099003)(18002099003)(5023799004)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IYoD5p6xIRm5rA5UqmNDLKHJqMaL1sGwjg2I+P3An+1PAX35+HTpk90pMOiB?=
 =?us-ascii?Q?/cg1UkU7xbT+K48s+8UvOiKP6qyQzqCh2rljwo6wiMGtA0AXgyxK7HF4pFI9?=
 =?us-ascii?Q?3Up45WneumrKrLEWE25UOeBB8Ez/prw6bSuYrjglzSyTmvnb6oNLY+d7rym3?=
 =?us-ascii?Q?O773KYREvwt2Y7jQGkExOBAf1ANG0h4GxVgRlv1O1Oxn1yMSx2hXdISJeWr0?=
 =?us-ascii?Q?WhxJmihRZ0o/V30+xcz31XUWuL1JiotKqxpgGCq79awPwUrJ7VwZ09ChF4SO?=
 =?us-ascii?Q?Va/Ct2G8sPOwnhjRJDusd41EAvdl6N3cegH//KwD/FUpDXseSTcffrR5EqFJ?=
 =?us-ascii?Q?G6QxE6iZhilN+ll0IeaQfnvu5efEN+0ZIp6OnX4UUlzvyAxuVrypJS3bqlAf?=
 =?us-ascii?Q?zYqKhDTlKjIYasouUPBxwSPe/dFA8NyP7twNlxvd9vFNMAdfqR2SGxs1H/sm?=
 =?us-ascii?Q?hLONNFKtM8eq4egv94vYUCVTnq2Nnpgjm8oeEWLUXeXn7JJmcSU35CBcw4KY?=
 =?us-ascii?Q?Rnz8xOxWyvFhoJ1e+NbndB04NQlsvS/xN88dr+0Qqg5dmQP8KYZqYVKExkmB?=
 =?us-ascii?Q?aEfb2qNcS3X51MrlcaG/AW0eGuwGtcE8GYjHenfaiNvolUZIPfsuCxWRu9gB?=
 =?us-ascii?Q?go3vNgbKiamLoqSluhOUU2cf2sC5mpZzF1OKwZuQWgEu+xazVDXmal3W2Khb?=
 =?us-ascii?Q?lUReUVTQzPeHvDTGrFSmYzS+ELzvbCjDo0CWA4NGy/9XBczO28lhAJuR4m+j?=
 =?us-ascii?Q?RAw43gih/4b96sFCLbjRb0ljSNN6dn+9Q1skn3l/41gysA2Ii6t3LNq+Sxms?=
 =?us-ascii?Q?XzHDTZ5hhKHZAWzlbjjG3TtGLXXXsh8mDndzvE7rMs6imcylVZeY0isvRWRG?=
 =?us-ascii?Q?ZUCUf05d29x+G38gPA0V51gSEiYPtDDf5usK/WFuqckalk/CHlsQnX8WzozZ?=
 =?us-ascii?Q?m/IYkyx3cWXvjj8plYK7v9df/NkeqyaoOOWgD54S2nQiwhNc15sdQJ/NU1OB?=
 =?us-ascii?Q?31ux6JpF2I9jKsul0ZzudaONyrrgo6jHDu5hcGr8dsgVLbakImbiPloHtXN7?=
 =?us-ascii?Q?pNEpNULt0vJAd8rQS2o3A2Jh6E0MEcXJ1n6Hd1832YGuIs66932/4wZi7TL8?=
 =?us-ascii?Q?LQovxMu7VCaNMojn7Ld0HpJ33uB2XoANQHjNsAW5VzoCTcYDMVVY7/Gs9VWr?=
 =?us-ascii?Q?jQB2xwckRg495rafLCxYRTMlzhLYWNfd99UUo2fWAB3/kwLmtrAb2dApUThD?=
 =?us-ascii?Q?2ArxZV8CE8p9K+ke8Y1uySpsGr+OyUuZdqLhfD2d/ebhx/FoNfY6yjF+/jsl?=
 =?us-ascii?Q?DRrqrH9AMWtf3N+0NOIwRgNdqwLTjZxV/CnAJubvVnFULwdFU/RQ6dXaOp5d?=
 =?us-ascii?Q?xZm/YBMck1kuu7zSSztMeFVjdNIOS2LffztCmTcWAhjpwMAR0LuN9GdTPkbj?=
 =?us-ascii?Q?6qFF39f6OwJWXzXxtsJPBUTq5tU8dFIDNSFlgei3UX9olHWv2x5kFVmct+Nv?=
 =?us-ascii?Q?ssNn2ZE/8jf09vOXabZME5a+1SrkVn4dUtRmxRuZ5uNtSzh+bf8opSYeKzjA?=
 =?us-ascii?Q?kl46nN3YTH6xdUxALomJImFzGJZ8Tn+lyUFaXloWslYa450+Iuym+rQcoidM?=
 =?us-ascii?Q?JOsVQ0nAD8zk6L2MZgkwS87nqzoTi35xL0elFi5ow6UFMnfQ3hBDUhi1s5hv?=
 =?us-ascii?Q?6TDU5zs2UaM+FBoP+lKmyIiFiTEQrUTOHJT4ezoTxZx3I9JvRavlPEt+HHci?=
 =?us-ascii?Q?MtHSSi6ims/hRNfP25WXZkNxbWbO/dCCHRwFlL9ZFGHefexiQ8aH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f976df-781b-4d72-8ef9-08df2939b973
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:53:21.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78258pL0eq4uVS71LLQZcRERqr7ac1bhdbm/TM7g4dfce62mU0wQxyEKU+nwNT9zHKwl4xd5wPY2Uzs2khGL3uG0w+YTY/AOYfle86Vao3tGlaIaX23WzM2RBoEqfdQj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR04MB308196

On Tue, Oct 13, 2026 at 09:46:36AM +0900, Koichiro Den wrote:
> On Mon, Oct 12, 2026 at 03:04:46PM -0500, Frank Li wrote:
> > On Fri, Oct 09, 2026 at 01:59:48PM +0900, Koichiro Den wrote:
> > > A vNTB PCI function can now expose endpoint-local DMA channels to its
> > > host. Decode the extension and register the advertised channels before
> > > the NTB device, so clients of that NTB device can use the DMA
> > > functionality in the same PCI function. Endpoints without the extension,
> > > or hosts without support for its DMA type or with no DMA IRQ available,
> > > continue without DMA.
> > >
> > > Only DW eDMA is supported for now. Dispatch on the advertised DMA type
> > > and keep type-specific setup in local helpers. Support for another
> > > implementation can add a new case and its own helpers.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > > Changes in v5:
> > >   - Simplify the implementation by using pcim_iomap_range()
> > >   - Drop the unrelated MW size-limit change for pci-epf-ntb bridges.
> > >
> > >  drivers/ntb/hw/epf/ntb_hw_epf.c | 336 ++++++++++++++++++++++++++++++--
> > >  1 file changed, 323 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > > index c47607d4f8a7..7faa40d1ae00 100644
> > > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > > @@ -8,6 +8,7 @@
> > >
> > >  #include <linux/atomic.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/dma/edma.h>
> > >  #include <linux/module.h>
> > >  #include <linux/pci.h>
> > >  #include <linux/slab.h>
> > > @@ -20,6 +21,7 @@
> > >  #define CMD_TEARDOWN_MW		4
> > >  #define CMD_LINK_UP		5
> > >  #define CMD_LINK_DOWN		6
> > > +#define CMD_SETUP_DMA_BAR	7
> > >
> > >  #define NTB_EPF_ARGUMENT	0x4
> > >  #define MSIX_ENABLE		BIT(16)
> > > @@ -44,6 +46,32 @@
> > >  #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
> > >  #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
> > >
> > > +/* Private DMA wire extension produced by pci-epf-vntb. */
> > > +#define NTB_EPF_DMA_BASE	0x134
> > > +#define NTB_EPF_DMA_MAGIC	(NTB_EPF_DMA_BASE + 0x00)
> > > +#define NTB_EPF_DMA_REV_LEN	(NTB_EPF_DMA_BASE + 0x04)
> > > +#define NTB_EPF_DMA_TYPE	(NTB_EPF_DMA_BASE + 0x08)
> > > +#define NTB_EPF_DMA_REGION_BAR(base)	((base) + 0x00)
> > > +#define NTB_EPF_DMA_REGION_OFFSET(base)	((base) + 0x04)
> > > +#define NTB_EPF_DMA_REGION_SIZE(base)	((base) + 0x08)
> > > +#define NTB_EPF_DMA_REGION_SIZEOF	0x0C
> > > +#define NTB_EPF_DMA_SUBMAP_BASE	(NTB_EPF_DMA_BASE + 0x0C)
> > > +#define NTB_EPF_DMA_COMMON_SIZE	0x18
> > > +#define NTB_EPF_DMA_REG_BASE	(NTB_EPF_DMA_BASE + NTB_EPF_DMA_COMMON_SIZE)
> > > +#define NTB_EPF_DMA_CHAN_BASE	(NTB_EPF_DMA_REG_BASE + \
> > > +					 NTB_EPF_DMA_REGION_SIZEOF)
> > > +#define NTB_EPF_DMA_CHAN_SIZE	0x14
> > > +#define NTB_EPF_DMA_CHAN_DESC_BASE(n)	(NTB_EPF_DMA_CHAN_BASE + \
> > > +					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x00)
> > > +#define NTB_EPF_DMA_CHAN_DESC_ADDR_LO(n)	(NTB_EPF_DMA_CHAN_BASE + \
> > > +					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x0C)
> > > +#define NTB_EPF_DMA_CHAN_DESC_ADDR_HI(n)	(NTB_EPF_DMA_CHAN_BASE + \
> > > +					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x10)
> > > +
>
> Hi Frank, thanks for the review.
>
> >
> > legacy use two sets define. Can we use common header files for both epf
> > drivers.
> >
> > In ntb_hw_epf.c, it use readl(), in pci_endpont_vntb.c use direct memory
> > access.
> >
> > Can use offsetof() to avoid these define? we can move more after common
> > head created.
>
> I personally don't think it is a good idea to leak such feature-specific
> definitions into include/linux, now that we agreed upon keeping this feature
> local to vNTB. This contrasts with the previous PCI EPF DMA approach, which
> added include/linux/pci-ep-dma.h:
> https://lore.kernel.org/r/20260813063757.3131865-3-den@valinux.co.jp/

pci-ep-dma.h is used for EP controler and DMA engineer driver only.

>
> I'm aware of the duplication in the current form, but my gut is that it's still
> a tolerable amount, and can be seen as just an extention of the current way of
> defining epf_ntb_ctrl in pci-epf-vntb.c and hard-coding the offsets in
> ntb_hw_epf.c.
>
> So Frank, I'd appreciate it if you could elaborate a bit more, on what concrete
> header location and naming you have in mind. Maybe something like
> include/linux/pci-epf-vntb.h?

I think it is fine. Or include/linux/pci-epf-ntb.h, which can include
ntb part defination in future.

Frank

>
> Mani, I'd appreciate your thoughts on this as well, so we can avoid going back
> and forth any further.
>
> Best regards,
> Koichiro Den
>
> >
> > Frank
> >
> > > +#define NTB_EPF_DMA_MAGIC_VALUE	0x414d444e /* "NDMA": NTB DMA */
> > > +#define NTB_EPF_DMA_REVISION	1
> > > +#define NTB_EPF_DMA_TYPE_DW_EDMA	1
> > > +
> > >  /*
> > >   * Legacy doorbell slot layout when paired with pci-epf-*ntb:
> > >   *
> > > @@ -97,6 +125,24 @@ struct ntb_epf_irq_ctx {
> > >  	unsigned int irq_no;
> > >  };
> > >
> > > +struct ntb_epf_dma_region {
> > > +	unsigned int bar;
> > > +	resource_size_t offset;
> > > +	resource_size_t size;
> > > +};
> > > +
> > > +struct ntb_epf_dw_edma {
> > > +	struct dw_edma_chip chip;
> > > +	struct ntb_epf_dma_region reg;
> > > +	struct ntb_epf_dma_region ll[EDMA_MAX_RD_CH];
> > > +};
> > > +
> > > +struct ntb_epf_dma {
> > > +	struct ntb_epf_dma_region submap;
> > > +	unsigned int nr_irqs;
> > > +	u32 type;
> > > +};
> > > +
> > >  struct ntb_epf_dev {
> > >  	struct ntb_dev ntb;
> > >  	struct device *dev;
> > > @@ -108,6 +154,8 @@ struct ntb_epf_dev {
> > >  	unsigned int mw_count;
> > >  	unsigned int spad_count;
> > >  	unsigned int db_count;
> > > +	struct ntb_epf_dma dma;
> > > +	struct ntb_epf_dw_edma dw_edma;
> > >
> > >  	void __iomem *ctrl_reg;
> > >  	void __iomem *db_reg;
> > > @@ -162,6 +210,212 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
> > >  	return ret;
> > >  }
> > >
> > > +static bool ntb_epf_dma_region_parse(struct ntb_epf_dev *ndev, u32 base,
> > > +				     bool optional,
> > > +				     struct ntb_epf_dma_region *region)
> > > +{
> > > +	resource_size_t bar_len;
> > > +	u32 bar, offset, size;
> > > +
> > > +	bar = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_BAR(base));
> > > +	offset = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_OFFSET(base));
> > > +	size = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_SIZE(base));
> > > +	region->bar = bar;
> > > +	region->offset = offset;
> > > +	region->size = size;
> > > +	if (!size)
> > > +		return optional && bar == U32_MAX && !offset;
> > > +	if (bar > BAR_5)
> > > +		return false;
> > > +
> > > +	bar_len = pci_resource_len(ndev->ntb.pdev, bar);
> > > +	if (offset > bar_len || size > bar_len - offset)
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +/* DW eDMA */
> > > +
> > > +static int ntb_epf_dw_edma_parse(struct ntb_epf_dev *ndev, u32 length)
> > > +{
> > > +	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
> > > +	struct dw_edma_chip *chip = &edma->chip;
> > > +	u32 count, chan_offset;
> > > +	unsigned int i;
> > > +
> > > +	chan_offset = NTB_EPF_DMA_CHAN_BASE - NTB_EPF_DMA_BASE;
> > > +	if (length < chan_offset + NTB_EPF_DMA_CHAN_SIZE ||
> > > +	    (length - chan_offset) % NTB_EPF_DMA_CHAN_SIZE)
> > > +		return -EINVAL;
> > > +
> > > +	count = (length - chan_offset) / NTB_EPF_DMA_CHAN_SIZE;
> > > +	if (count > EDMA_MAX_RD_CH)
> > > +		return -EINVAL;
> > > +
> > > +	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA_REG_BASE, false,
> > > +				      &edma->reg) ||
> > > +	    !IS_ALIGNED(edma->reg.offset, sizeof(u32)))
> > > +		return -EINVAL;
> > > +
> > > +	chip->mf = EDMA_MF_EDMA_UNROLL;
> > > +	chip->ll_rd_cnt = count;
> > > +	chip->func_no = PCI_FUNC(ndev->ntb.pdev->devfn);
> > > +
> > > +	for (i = 0; i < count; i++) {
> > > +		u64 paddr;
> > > +
> > > +		if (!ntb_epf_dma_region_parse(ndev,
> > > +					      NTB_EPF_DMA_CHAN_DESC_BASE(i),
> > > +					      false, &edma->ll[i]) ||
> > > +		    !IS_ALIGNED(edma->ll[i].offset, sizeof(u32)))
> > > +			return -EINVAL;
> > > +
> > > +		paddr = readl(ndev->ctrl_reg +
> > > +			      NTB_EPF_DMA_CHAN_DESC_ADDR_LO(i));
> > > +		paddr |= (u64)readl(ndev->ctrl_reg +
> > Frank> +				    NTB_EPF_DMA_CHAN_DESC_ADDR_HI(i)) << 32;
> > > +		if (paddr == U64_MAX)
> > > +			return -EINVAL;
> > > +
> > > +		chip->ll_region_rd[i].sz = edma->ll[i].size;
> > > +		chip->ll_region_rd[i].paddr = paddr;
> > > +	}
> > > +	ndev->dma.nr_irqs = count;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int ntb_epf_dw_edma_irq_vector(struct device *dev, unsigned int nr)
> > > +{
> > > +	struct ntb_epf_dev *ndev = dev_get_drvdata(dev);
> > > +
> > > +	/* DMA vectors follow the NTB link and doorbell vector block. */
> > > +	return pci_irq_vector(ndev->ntb.pdev, ndev->db_count + 1 + nr);
> > > +}
> > > +
> > > +static const struct dw_edma_plat_ops ntb_epf_dw_edma_ops = {
> > > +	.irq_vector = ntb_epf_dw_edma_irq_vector,
> > > +};
> > > +
> > > +static void __iomem *
> > > +ntb_epf_dw_edma_map_region(struct pci_dev *pdev,
> > > +			   const struct ntb_epf_dma_region *region)
> > > +{
> > > +	return pcim_iomap_range(pdev, region->bar, region->offset, region->size);
> > > +}
> > > +
> > > +static int ntb_epf_dw_edma_init(struct ntb_epf_dev *ndev)
> > > +{
> > > +	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
> > > +	struct dw_edma_chip *chip = &edma->chip;
> > > +	struct pci_dev *pdev = ndev->ntb.pdev;
> > > +	unsigned int i;
> > > +	int ret;
> > > +
> > > +	/* Install BAR submaps before mapping the advertised DMA regions. */
> > > +	ret = ntb_epf_send_command(ndev, CMD_SETUP_DMA_BAR, 0);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	chip->reg_base = ntb_epf_dw_edma_map_region(pdev, &edma->reg);
> > > +	if (IS_ERR(chip->reg_base))
> > > +		return PTR_ERR(chip->reg_base);
> > > +	for (i = 0; i < chip->ll_rd_cnt; i++) {
> > > +		chip->ll_region_rd[i].vaddr.io =
> > > +			ntb_epf_dw_edma_map_region(pdev, &edma->ll[i]);
> > > +		if (IS_ERR(chip->ll_region_rd[i].vaddr.io))
> > > +			return PTR_ERR(chip->ll_region_rd[i].vaddr.io);
> > > +	}
> > > +
> > > +	chip->dev = ndev->dev;
> > > +	chip->nr_irqs = ndev->dma.nr_irqs;
> > > +	chip->ops = &ntb_epf_dw_edma_ops;
> > > +	chip->flags = DW_EDMA_CHIP_PARTIAL;
> > > +
> > > +	return dw_edma_probe(chip);
> > > +}
> > > +
> > > +static void ntb_epf_dw_edma_deinit(struct ntb_epf_dev *ndev)
> > > +{
> > > +	dw_edma_remove(&ndev->dw_edma.chip);
> > > +}
> > > +
> > > +/* Common endpoint DMA */
> > > +
> > > +static int ntb_epf_dma_parse(struct ntb_epf_dev *ndev)
> > > +{
> > > +	u32 magic, rev_len, length, type;
> > > +	u32 spad_off;
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * Legacy endpoints place scratchpads where this extension would begin.
> > > +	 * Once the extension is present, malformed metadata is fatal.
> > > +	 */
> > > +	spad_off = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
> > > +	if (spad_off < NTB_EPF_DMA_BASE + NTB_EPF_DMA_COMMON_SIZE)
> > > +		return 0;
> > > +
> > > +	magic = readl(ndev->ctrl_reg + NTB_EPF_DMA_MAGIC);
> > > +	if (!magic)
> > > +		return 0;
> > > +	if (magic == U32_MAX)
> > > +		return -EIO;
> > > +	if (magic != NTB_EPF_DMA_MAGIC_VALUE)
> > > +		return -EINVAL;
> > > +
> > > +	rev_len = readl(ndev->ctrl_reg + NTB_EPF_DMA_REV_LEN);
> > > +	length = upper_16_bits(rev_len);
> > > +	if (lower_16_bits(rev_len) != NTB_EPF_DMA_REVISION ||
> > > +	    length < NTB_EPF_DMA_COMMON_SIZE ||
> > > +	    spad_off < NTB_EPF_DMA_BASE + length)
> > > +		return -EINVAL;
> > > +	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA_SUBMAP_BASE, true,
> > > +				      &ndev->dma.submap))
> > > +		return -EINVAL;
> > > +
> > > +	type = readl(ndev->ctrl_reg + NTB_EPF_DMA_TYPE);
> > > +	if (type == U32_MAX)
> > > +		return -EIO;
> > > +
> > > +	switch (type) {
> > > +	case NTB_EPF_DMA_TYPE_DW_EDMA:
> > > +		if (!IS_REACHABLE(CONFIG_DW_EDMA))
> > > +			break;
> > > +		ret = ntb_epf_dw_edma_parse(ndev, length);
> > > +		if (!ret)
> > > +			ndev->dma.type = type;
> > > +		return ret;
> > > +	default:
> > > +		break;
> > > +	}
> > > +
> > > +	dev_warn(ndev->dev,
> > > +		 "Endpoint DMA type %u unavailable, continuing without DMA\n",
> > > +		 type);
> > > +	return 0;
> > > +}
> > > +
> > > +static int ntb_epf_dma_init(struct ntb_epf_dev *ndev)
> > > +{
> > > +	switch (ndev->dma.type) {
> > > +	case NTB_EPF_DMA_TYPE_DW_EDMA:
> > > +		return ntb_epf_dw_edma_init(ndev);
> > > +	default:
> > > +		return 0;
> > > +	}
> > > +}
> > > +
> > > +static void ntb_epf_dma_deinit(struct ntb_epf_dev *ndev)
> > > +{
> > > +	switch (ndev->dma.type) {
> > > +	case NTB_EPF_DMA_TYPE_DW_EDMA:
> > > +		ntb_epf_dw_edma_deinit(ndev);
> > > +		break;
> > > +	}
> > > +}
> > > +
> > >  static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
> > >  {
> > >  	struct device *dev = ndev->dev;
> > > @@ -174,6 +428,23 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
> > >  	return ndev->barno_map[BAR_MW1 + idx];
> > >  }
> > >
> > > +static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
> > > +{
> > > +	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET) : 0;
> > > +}
> > > +
> > > +static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int bar)
> > > +{
> > > +	resource_size_t end;
> > > +
> > > +	end = pci_resource_len(ndev->ntb.pdev, bar);
> > > +	/* The DMA submap offset marks the end of an MW sharing this BAR. */
> > > +	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
> > > +		end = min(end, ndev->dma.submap.offset);
> > > +
> > > +	return end;
> > > +}
> > > +
> > >  static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
> > >  {
> > >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > > @@ -212,7 +483,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
> > >  		*size_align = 1;
> > >
> > >  	if (size_max)
> > > -		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
> > > +		*size_max = ntb_epf_mw_size(ndev, bar);
> > >
> > >  	return 0;
> > >  }
> > > @@ -373,16 +644,20 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
> > >  {
> > >  	struct pci_dev *pdev = ndev->ntb.pdev;
> > >  	struct device *dev = ndev->dev;
> > > +	unsigned int dma_max = ndev->dma.nr_irqs;
> > > +	unsigned int dma_min;
> > >  	u32 argument = MSIX_ENABLE;
> > > +	unsigned int ntb_irqs;
> > >  	int irq;
> > >  	int ret;
> > >  	int i;
> > >
> > > -	irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
> > > +	irq = pci_alloc_irq_vectors(pdev, msi_min,
> > > +				    msi_max + dma_max, PCI_IRQ_MSIX);
> > >  	if (irq < 0) {
> > >  		dev_dbg(dev, "Failed to get MSIX interrupts\n");
> > > -		irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max,
> > > -					    PCI_IRQ_MSI);
> > > +		irq = pci_alloc_irq_vectors(pdev, msi_min,
> > > +					    msi_max + dma_max, PCI_IRQ_MSI);
> > >  		if (irq < 0) {
> > >  			dev_err(dev, "Failed to get MSI interrupts\n");
> > >  			return irq;
> > > @@ -390,8 +665,17 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
> > >  		argument &= ~MSIX_ENABLE;
> > >  	}
> > >
> > > -	ndev->db_count = irq - 1;
> > > -	for (i = 0; i < irq; i++) {
> > > +	dma_min = dma_max && irq > msi_min;
> > > +	/* Reserve one shared DMA IRQ when available, then give the rest to NTB. */
> > > +	ntb_irqs = min_t(unsigned int, irq - dma_min, msi_max);
> > > +	ndev->dma.nr_irqs = irq - ntb_irqs;
> > > +	if (dma_max && !ndev->dma.nr_irqs) {
> > > +		dev_warn(dev,
> > > +			 "No IRQ available for endpoint DMA, continuing without DMA\n");
> > > +		ndev->dma.type = 0;
> > > +	}
> > > +	ndev->db_count = ntb_irqs - 1;
> > > +	for (i = 0; i < ntb_irqs; i++) {
> > >  		ndev->irq_ctx[i].ndev = ndev;
> > >  		ndev->irq_ctx[i].irq_no = i;
> > >  		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
> > > @@ -403,7 +687,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
> > >  	}
> > >
> > >  	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
> > > -				   argument | irq);
> > > +				   argument | ntb_irqs);
> > >  	if (ret) {
> > >  		dev_err(dev, "Failed to configure doorbell\n");
> > >  		goto err_free_irq;
> > > @@ -486,7 +770,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
> > >  	if (bar < 0)
> > >  		return bar;
> > >
> > > -	mw_size = pci_resource_len(ntb->pdev, bar);
> > > +	mw_size = ntb_epf_mw_size(ndev, bar);
> > >
> > >  	if (size > mw_size) {
> > >  		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
> > > @@ -520,21 +804,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
> > >  				    phys_addr_t *base, resource_size_t *size)
> > >  {
> > >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > > -	u32 offset = 0;
> > > +	resource_size_t offset;
> > >  	int bar;
> > >
> > > -	if (idx == 0)
> > > -		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
> > > -
> > >  	bar = ntb_epf_mw_to_bar(ndev, idx);
> > >  	if (bar < 0)
> > >  		return bar;
> > >
> > > +	offset = ntb_epf_mw_offset(ndev, idx);
> > > +
> > >  	if (base)
> > >  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
> > >
> > >  	if (size)
> > > -		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
> > > +		*size = ntb_epf_mw_size(ndev, bar) - offset;
> > >
> > >  	return 0;
> > >  }
> > > @@ -630,12 +913,30 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
> > >  {
> > >  	struct device *dev = ndev->dev;
> > >  	int ret;
> > > +	int i;
> > >
> > >  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
> > >  	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
> > >  		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
> > >  		return -EINVAL;
> > >  	}
> > > +	ret = ntb_epf_dma_parse(ndev);
> > > +	if (ret) {
> > > +		dev_err(dev, "Invalid endpoint DMA layout\n");
> > > +		return ret;
> > > +	}
> > > +	if (ndev->dma.submap.size) {
> > > +		for (i = 0; i < ndev->mw_count; i++) {
> > > +			int bar = ntb_epf_mw_to_bar(ndev, i);
> > > +
> > > +			if (bar == ndev->dma.submap.bar &&
> > > +			    ntb_epf_mw_size(ndev, bar) <=
> > > +			    ntb_epf_mw_offset(ndev, i)) {
> > > +				dev_err(dev, "Invalid DMA/MW boundary\n");
> > > +				return -EINVAL;
> > > +			}
> > > +		}
> > > +	}
> > >
> > >  	/* One Link interrupt and rest doorbell interrupt */
> > >  	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
> > > @@ -785,6 +1086,12 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
> > >  		goto err_init_dev;
> > >  	}
> > >
> > > +	ret = ntb_epf_dma_init(ndev);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to initialize endpoint DMA\n");
> > > +		goto err_dma_init;
> > > +	}
> > > +
> > >  	ret = ntb_register_device(&ndev->ntb);
> > >  	if (ret) {
> > >  		dev_err(dev, "Failed to register NTB device\n");
> > > @@ -794,6 +1101,8 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
> > >  	return 0;
> > >
> > >  err_register_dev:
> > > +	ntb_epf_dma_deinit(ndev);
> > > +err_dma_init:
> > >  	ntb_epf_cleanup_isr(ndev);
> > >
> > >  err_init_dev:
> > > @@ -807,6 +1116,7 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
> > >  	struct ntb_epf_dev *ndev = pci_get_drvdata(pdev);
> > >
> > >  	ntb_unregister_device(&ndev->ntb);
> > > +	ntb_epf_dma_deinit(ndev);
> > >  	ntb_epf_cleanup_isr(ndev);
> > >  	ntb_epf_deinit_pci(ndev);
> > >  }
> > > --
> > > 2.51.0
> > >
