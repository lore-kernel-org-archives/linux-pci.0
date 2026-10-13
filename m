Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021126.outbound.protection.outlook.com [52.101.125.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58D129B8E1;
	Tue, 13 Oct 2026 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906632; cv=fail; b=NjeEBKlI1aB71FlqJ0CIC9QIItVpJLkZGiv8uMZt8XZMCI7zySyDPk6J6lZ1U6dJUctmwZzoyY2c8f6Gw6CT13LzwmVu4T4wudPvC+zDMeYognVNmfh2S5ffOpDStCAuQHcfFGOrGZTePML5vT1LdAnB/ho9xvG57jrnqwn1wKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906632; c=relaxed/simple;
	bh=f7qbGmQHLGjaOvb1Eig8a2NDGeigh6Lpig7A3Qss54E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PwjOnWFyIojMVUfPb9UIYPfqOp30jn8kOw7KuSry7RQ6U8CIP4AdfIPi0n8R7JENloTDdLzZUwzG4W5y8PFQYvPilKGnNDBolMNBR4dgp9AFC5hMEEuKZoTsDao7FzoxvU1WPUN/Q/EF+kZAPGU9aM1EFVpY1RxpoXj8oSmuxHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=P895VXQ3; arc=fail smtp.client-ip=52.101.125.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="P895VXQ3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UD2etN27pq1wEvAiY8Y6M/gSGirb1HW55lZT43gJ7K8v25ccpDoVIy4eolqJoAv/fAjUv/G/9I/2hLeLqNjlvwA4oXw9WNJSW1gEemy9DaaleGVcXFDl7b85Htj6OAbP+C++8vd6fEGdaINvSmuslshzOegYRjijE6Xy4ACW+jONDNo6JsySj1WE3RvK5VbNcMYp7euVeD67Z7oJ/FEyXULdkLjaiZeje+ZycmRR7g6Y9yTs6vwqhTx7SXPOjYxB73qp3C/NBwLa0wEldwROBmZvBridBvBWXynhtJQd1hFe0AAw8cCzQ0U6iHu8o4d7LPNiEt8wDmhB6EXJ+a6GMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKfusgFTuajwrRaASJfbvoXEukixCgVhh12xMIxaCrQ=;
 b=MziVukPiwNGDuvDTis4M6EoZ3S9vDmkgd4BNiWilk1AGMrEdnl12rthIG8ByP8PPRFIZxFZ68J+vRZADHdDLh15fHj4j5V9xFRLYBDbT7vhJuXEmd4ijmGme9+Gy2m1ONPFUycjuoSoxkRh2ewmH1mU7Q4lJ37335Ojw9aneQkNB4jIEblS5IFinWX1ZZae91izm5b3beoquRfzaV/4hptSZMRj9FEqcwVu8UGP2EaHIoznUvqcFfbY9DTzMx3eO8XQDlxuKMii25YeTQazbwDspx+fr1dW8j9HXgfP33mNtj2Nn9R31QC4gfUdJZh2p7JWV4tSE6DAleKr9F9qydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKfusgFTuajwrRaASJfbvoXEukixCgVhh12xMIxaCrQ=;
 b=P895VXQ3NKPPp+WCeGCxTL8X62e2WShaKPUOMiJTvwwlcpMDdzdtlr7e2d0E9mu+bWKmMa9BogCmxlYiqVeCe1tqtTe9i6lbbzfIMpB2/yGwK6sJAzrcRiSllphhXJqpiMsX2DVnRoH3BXBp6FWupIC9rgRzJm9duSkjqCw+OtI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYRP286MB5825.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 15:50:26 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 15:50:26 +0000
Date: Wed, 14 Oct 2026 00:50:24 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>, 
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v5 6/7] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Message-ID: <alflcktvzkvnoy2kbwtpfsf44vfadqoafmy7jr2ugqssxabitf@oclzw5moz2xm>
References: <20261009045949.1109871-1-den@valinux.co.jp>
 <20261009045949.1109871-7-den@valinux.co.jp>
 <as09Xp_EMjPDdk4x@SMW015318>
 <vnae5ngbbkomapwx44zqszdwcx67kv7qpxuzrs6o67uo5qphs4@hxfu6p6ewgt4>
 <as5F0EQB3owMYmFV@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as5F0EQB3owMYmFV@SMW015318>
X-ClientProxiedBy: TYCP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYRP286MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 451bd14f-a160-4f76-a0d2-08df2941b2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|7416014|366016|6133799003|22082099003|10067099003|18002099003|4143699003|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	JQyldOX37Zm5I0afBwnuwT0wh1p3b+zOAl5dDIL02R9OkTcBkk8JB0tsFc8FuSe01jzy6SSMjstnAkuQ6JMUXi0X8NUqzKMowuyQ4oHP3LVfL/241KrTO0fMJGP99yL7cYj66eR4XFxmBmDkrWlSZNNRsXwleSQz6DwF/eua1anjFmdOqgEzwi3brPNPxRPdJKC/rPRyhjycEHokqNlpp3Cvg17CGUxobwg8X29T2yRl8O64WodfT2oZXQ2ursTCgeZ7ERq7TgbE/mrQoShzhOjmtQ1nOYt1VerLOu9LXCPfBdm7ESrp/Q+z56VsR+RLRZRP3N4nAcgn2BA7UpzuwNosIxbAGs30HFCbQ8os0vJgqRQoh7FRG+4YIqmqsjX3HVZUtXeql0NiayAYPYxl4lU8POcL2KgZhe3TjSL4PDIECExdFGTH6h9zO69lbddMl6PWrV8HVaUmTEHw0Sfh/gZTjnCW/04E4lfw3AGNfyaYUZMORK9a7HJugoIXm+yyva8ymXxcaX/Ks+CL6HLGuqPh3YQBCN8/LAw1oCWKCMq4YKP/ik/VL5fIFlPd4um33B4/xue7+rHU0ZOC4FpMD8xQPfu9zkUmPjHSj4Cn5eYILWwszk99S5VXtecWEuT3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(7416014)(366016)(6133799003)(22082099003)(10067099003)(18002099003)(4143699003)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?46ZQa/AGvDmTagLLcTgrRuMcb2IQ5gRqjvohuDjRVvfDkf0ZLDCs2xbZ0z+l?=
 =?us-ascii?Q?Ucjv/B790rdQBa7/ejlRrqS6mgBCPnTNVUuRKZyeS2aHFQhg3BhyP4P+1mMP?=
 =?us-ascii?Q?34iJKPUMjZRXW6jFLrfK19Jcmp9bQV5wxhdo/3u2yN+pciXHpyHqRuDN5eDn?=
 =?us-ascii?Q?pMCd9kizjO2wN0OGOCY6Hz6fm+Up8cOwVqSpOcaEg3LIM+r1BnkdiCKFnggX?=
 =?us-ascii?Q?9eATp71tirq3YZumxNLFeeYNP9BD6AeonpqNdzg+ttkU3qyCXlH7h7X2fDsI?=
 =?us-ascii?Q?3g9B3mhYeOonE/Pu5ygttvGXu0BpBrdijYom4Iu0Z+3fhxZE0F4USARVUOXs?=
 =?us-ascii?Q?+9LU1PSCl6NLpRa3YuYkei5xBoO6vEA/q5XxnnGvaaYQlkVSrh75j/k3QkPW?=
 =?us-ascii?Q?wMsZKKR0itjU/rQ5SD85XBxYYi+/Tp+aVgs8gf2liTenIfvPXXZ8cudUKSHQ?=
 =?us-ascii?Q?1wn/jKNxDReHp4UMh9RezOoPuTzfKkhw6btGbPNk4NcDrGj2l97jrUpFTyEY?=
 =?us-ascii?Q?XMNL9f+UeAbd5XezmEmXYaHMRPRUJkI0gpjFkVLCj2jnFd8bB3VxD0B+NrN+?=
 =?us-ascii?Q?wrlVidIAh4U7jJ15txC3Ig5i1OVE2bHp83hEdOaV4i6wd/PayTEuN93c0F0h?=
 =?us-ascii?Q?k04IE7nqbnLX0XvZyruxaxEZHPuGUC6B8cyLSN3vFYnKYBtxR2nZWJC4/IYq?=
 =?us-ascii?Q?11lgrJEl+E2rbF3yS0dLFzKGyFDgej5jlQtIp8/wh6MnnaN7BCFDuo6Gm1Ne?=
 =?us-ascii?Q?8URpEaWDHmrfePim/eGNZkNldWIIF6QcVwxCnJ+hlxixKwPkXsFVQ6O+p4rL?=
 =?us-ascii?Q?w0cyFxbE4PrJQhEU+TYlISd4aJrRnL7nWLKZe0QTpSAX/shrg40G5//BfKpg?=
 =?us-ascii?Q?HFXD85vKwHd37BlXz+iCeQ8Q8J47web8lu0qwW0K5R+u/9NHFCG7OnFPSfV6?=
 =?us-ascii?Q?xUuhChbkPjNDbDzTZurvyBz0dkDvlKxsOcPfCNLUPLrq9hajMil5lMhW62vJ?=
 =?us-ascii?Q?ZoF5F1bvb2BAplzhJqNs6q3XK7MlW4e7dBmGMdR3D24SaC4qTIYL1Z4Dy2F+?=
 =?us-ascii?Q?UbMPSKZm0F+hBEu9t4Yi1a5ddddOMKovgSCwJ/ca0hcJUANDCqf0bg3Y9KNs?=
 =?us-ascii?Q?+C6ZNXdf9WMBW33RjVtmvf0F6H8f69pzseSAzInks8cDnDYWxiZNT5XOhf9v?=
 =?us-ascii?Q?8eh/Qp9wlzlJfF3A6oZtYEXDR6O8A9bnX6U9MowdmFOYWq2JQPEQRGlY1MQw?=
 =?us-ascii?Q?/aqCZHDtEAdb1rgSLVVsu2F2ZZnAZGLbYKJD74fBzCLGM6AETOaWk9BpeJ0+?=
 =?us-ascii?Q?C4ko5ib2UrnHjukvg1zfCe2TkJoMax6AYG709i52EEUwIz6lPQjhgrOdDby3?=
 =?us-ascii?Q?oBdbubc3AibGdHaGsqI4V3pmGjX1qPjAkNb602Jt425LailerI4slXrUSM7z?=
 =?us-ascii?Q?fTUBJJXBk1ysJKBzWjsB8P0pYSuIusL9SDnom6YKdspx613s8gl0ffzhwC5J?=
 =?us-ascii?Q?Gu4yWrz+l2miBhDMuJhtlXZlthJCzWNQBb4MPxWsWiM0Ay7gmChEsmDF/ojh?=
 =?us-ascii?Q?sOjzNj7+bwjJfEkfXv60PJ839POOfOua4BWezsCS1JOVV4pGB+lXH0MdOpj5?=
 =?us-ascii?Q?EDDejoaG3vVX/Hq/jvTsWnUMyNvorhg6b2DIo76J2CISHycM34v9kAS6/fMn?=
 =?us-ascii?Q?wfxr7RvSOb2M7d8G/zJIVJRcuzypmM2wHpIZh1acl6Ar+O3+lc50YHah3TCD?=
 =?us-ascii?Q?1g7rFCiQHpKoXAc+2VqzK1Iodr7rdq7tp3Deoh3wpwWKz8bpvBAe?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 451bd14f-a160-4f76-a0d2-08df2941b2ab
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:50:25.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExhoBMV20jZH0UeTiPlDZ8aHVJfOs+RwOHXjNZQC61dBgJhs996f2weG6ceL9LrOUF7hgeHz5V5yHqbrwHpqBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5825

On Tue, Oct 13, 2026 at 09:53:04AM -0500, Frank Li wrote:
> On Tue, Oct 13, 2026 at 09:46:36AM +0900, Koichiro Den wrote:
> > On Mon, Oct 12, 2026 at 03:04:46PM -0500, Frank Li wrote:
> > > On Fri, Oct 09, 2026 at 01:59:48PM +0900, Koichiro Den wrote:
> > > > A vNTB PCI function can now expose endpoint-local DMA channels to its
> > > > host. Decode the extension and register the advertised channels before
> > > > the NTB device, so clients of that NTB device can use the DMA
> > > > functionality in the same PCI function. Endpoints without the extension,
> > > > or hosts without support for its DMA type or with no DMA IRQ available,
> > > > continue without DMA.
> > > >
> > > > Only DW eDMA is supported for now. Dispatch on the advertised DMA type
> > > > and keep type-specific setup in local helpers. Support for another
> > > > implementation can add a new case and its own helpers.
> > > >
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > > Changes in v5:
> > > >   - Simplify the implementation by using pcim_iomap_range()
> > > >   - Drop the unrelated MW size-limit change for pci-epf-ntb bridges.
> > > >
> > > >  drivers/ntb/hw/epf/ntb_hw_epf.c | 336 ++++++++++++++++++++++++++++++--
> > > >  1 file changed, 323 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > > > index c47607d4f8a7..7faa40d1ae00 100644
> > > > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > > > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > > > @@ -8,6 +8,7 @@
> > > >
> > > >  #include <linux/atomic.h>
> > > >  #include <linux/delay.h>
> > > > +#include <linux/dma/edma.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/pci.h>
> > > >  #include <linux/slab.h>
> > > > @@ -20,6 +21,7 @@
> > > >  #define CMD_TEARDOWN_MW		4
> > > >  #define CMD_LINK_UP		5
> > > >  #define CMD_LINK_DOWN		6
> > > > +#define CMD_SETUP_DMA_BAR	7
> > > >
> > > >  #define NTB_EPF_ARGUMENT	0x4
> > > >  #define MSIX_ENABLE		BIT(16)
> > > > @@ -44,6 +46,32 @@
> > > >  #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
> > > >  #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
> > > >
> > > > +/* Private DMA wire extension produced by pci-epf-vntb. */
> > > > +#define NTB_EPF_DMA_BASE	0x134
> > > > +#define NTB_EPF_DMA_MAGIC	(NTB_EPF_DMA_BASE + 0x00)
> > > > +#define NTB_EPF_DMA_REV_LEN	(NTB_EPF_DMA_BASE + 0x04)
> > > > +#define NTB_EPF_DMA_TYPE	(NTB_EPF_DMA_BASE + 0x08)
> > > > +#define NTB_EPF_DMA_REGION_BAR(base)	((base) + 0x00)
> > > > +#define NTB_EPF_DMA_REGION_OFFSET(base)	((base) + 0x04)
> > > > +#define NTB_EPF_DMA_REGION_SIZE(base)	((base) + 0x08)
> > > > +#define NTB_EPF_DMA_REGION_SIZEOF	0x0C
> > > > +#define NTB_EPF_DMA_SUBMAP_BASE	(NTB_EPF_DMA_BASE + 0x0C)
> > > > +#define NTB_EPF_DMA_COMMON_SIZE	0x18
> > > > +#define NTB_EPF_DMA_REG_BASE	(NTB_EPF_DMA_BASE + NTB_EPF_DMA_COMMON_SIZE)
> > > > +#define NTB_EPF_DMA_CHAN_BASE	(NTB_EPF_DMA_REG_BASE + \
> > > > +					 NTB_EPF_DMA_REGION_SIZEOF)
> > > > +#define NTB_EPF_DMA_CHAN_SIZE	0x14
> > > > +#define NTB_EPF_DMA_CHAN_DESC_BASE(n)	(NTB_EPF_DMA_CHAN_BASE + \
> > > > +					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x00)
> > > > +#define NTB_EPF_DMA_CHAN_DESC_ADDR_LO(n)	(NTB_EPF_DMA_CHAN_BASE + \
> > > > +					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x0C)
> > > > +#define NTB_EPF_DMA_CHAN_DESC_ADDR_HI(n)	(NTB_EPF_DMA_CHAN_BASE + \
> > > > +					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x10)
> > > > +
> >
> > Hi Frank, thanks for the review.
> >
> > >
> > > legacy use two sets define. Can we use common header files for both epf
> > > drivers.
> > >
> > > In ntb_hw_epf.c, it use readl(), in pci_endpont_vntb.c use direct memory
> > > access.
> > >
> > > Can use offsetof() to avoid these define? we can move more after common
> > > head created.
> >
> > I personally don't think it is a good idea to leak such feature-specific
> > definitions into include/linux, now that we agreed upon keeping this feature
> > local to vNTB. This contrasts with the previous PCI EPF DMA approach, which
> > added include/linux/pci-ep-dma.h:
> > https://lore.kernel.org/r/20260813063757.3131865-3-den@valinux.co.jp/
> 
> pci-ep-dma.h is used for EP controler and DMA engineer driver only.

Yeah, my point was that with the vNTB-embedded design, it just seems reasonable
to me to do without such a header.

> 
> >
> > I'm aware of the duplication in the current form, but my gut is that it's still
> > a tolerable amount, and can be seen as just an extention of the current way of
> > defining epf_ntb_ctrl in pci-epf-vntb.c and hard-coding the offsets in
> > ntb_hw_epf.c.
> >
> > So Frank, I'd appreciate it if you could elaborate a bit more, on what concrete
> > header location and naming you have in mind. Maybe something like
> > include/linux/pci-epf-vntb.h?
> 
> I think it is fine. Or include/linux/pci-epf-ntb.h, which can include
> ntb part defination in future.

Okay, got it. To me include/linux/pci-epf-vntb.h (or pci-epf-ntb.h) still looks
somewhat odd, but I might feel differently tomorrow morning... I'll go with your
suggestion.
I will respin and add a prep patch that first moves the existing epf_ntb_ctrl to
the header and replaces the hard-coded macros in ntb_hw_epf.c with more
readable/maintainable offset calculations, and then use the header for the
vNTB-DMA stuff.

Mani, please let me know if you have any objections.

Thanks for the review!

Best regards,
Koichiro Den

> 
> Frank
> 
> >
> > Mani, I'd appreciate your thoughts on this as well, so we can avoid going back
> > and forth any further.
> >
> > Best regards,
> > Koichiro Den
> >
> > >
> > > Frank
> > >
> > > > +#define NTB_EPF_DMA_MAGIC_VALUE	0x414d444e /* "NDMA": NTB DMA */
> > > > +#define NTB_EPF_DMA_REVISION	1
> > > > +#define NTB_EPF_DMA_TYPE_DW_EDMA	1
> > > > +
> > > >  /*
> > > >   * Legacy doorbell slot layout when paired with pci-epf-*ntb:
> > > >   *
> > > > @@ -97,6 +125,24 @@ struct ntb_epf_irq_ctx {
> > > >  	unsigned int irq_no;
> > > >  };
> > > >
> > > > +struct ntb_epf_dma_region {
> > > > +	unsigned int bar;
> > > > +	resource_size_t offset;
> > > > +	resource_size_t size;
> > > > +};
> > > > +
> > > > +struct ntb_epf_dw_edma {
> > > > +	struct dw_edma_chip chip;
> > > > +	struct ntb_epf_dma_region reg;
> > > > +	struct ntb_epf_dma_region ll[EDMA_MAX_RD_CH];
> > > > +};
> > > > +
> > > > +struct ntb_epf_dma {
> > > > +	struct ntb_epf_dma_region submap;
> > > > +	unsigned int nr_irqs;
> > > > +	u32 type;
> > > > +};
> > > > +
> > > >  struct ntb_epf_dev {
> > > >  	struct ntb_dev ntb;
> > > >  	struct device *dev;
> > > > @@ -108,6 +154,8 @@ struct ntb_epf_dev {
> > > >  	unsigned int mw_count;
> > > >  	unsigned int spad_count;
> > > >  	unsigned int db_count;
> > > > +	struct ntb_epf_dma dma;
> > > > +	struct ntb_epf_dw_edma dw_edma;
> > > >
> > > >  	void __iomem *ctrl_reg;
> > > >  	void __iomem *db_reg;
> > > > @@ -162,6 +210,212 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
> > > >  	return ret;
> > > >  }
> > > >
> > > > +static bool ntb_epf_dma_region_parse(struct ntb_epf_dev *ndev, u32 base,
> > > > +				     bool optional,
> > > > +				     struct ntb_epf_dma_region *region)
> > > > +{
> > > > +	resource_size_t bar_len;
> > > > +	u32 bar, offset, size;
> > > > +
> > > > +	bar = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_BAR(base));
> > > > +	offset = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_OFFSET(base));
> > > > +	size = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_SIZE(base));
> > > > +	region->bar = bar;
> > > > +	region->offset = offset;
> > > > +	region->size = size;
> > > > +	if (!size)
> > > > +		return optional && bar == U32_MAX && !offset;
> > > > +	if (bar > BAR_5)
> > > > +		return false;
> > > > +
> > > > +	bar_len = pci_resource_len(ndev->ntb.pdev, bar);
> > > > +	if (offset > bar_len || size > bar_len - offset)
> > > > +		return false;
> > > > +
> > > > +	return true;
> > > > +}
> > > > +
> > > > +/* DW eDMA */
> > > > +
> > > > +static int ntb_epf_dw_edma_parse(struct ntb_epf_dev *ndev, u32 length)
> > > > +{
> > > > +	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
> > > > +	struct dw_edma_chip *chip = &edma->chip;
> > > > +	u32 count, chan_offset;
> > > > +	unsigned int i;
> > > > +
> > > > +	chan_offset = NTB_EPF_DMA_CHAN_BASE - NTB_EPF_DMA_BASE;
> > > > +	if (length < chan_offset + NTB_EPF_DMA_CHAN_SIZE ||
> > > > +	    (length - chan_offset) % NTB_EPF_DMA_CHAN_SIZE)
> > > > +		return -EINVAL;
> > > > +
> > > > +	count = (length - chan_offset) / NTB_EPF_DMA_CHAN_SIZE;
> > > > +	if (count > EDMA_MAX_RD_CH)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA_REG_BASE, false,
> > > > +				      &edma->reg) ||
> > > > +	    !IS_ALIGNED(edma->reg.offset, sizeof(u32)))
> > > > +		return -EINVAL;
> > > > +
> > > > +	chip->mf = EDMA_MF_EDMA_UNROLL;
> > > > +	chip->ll_rd_cnt = count;
> > > > +	chip->func_no = PCI_FUNC(ndev->ntb.pdev->devfn);
> > > > +
> > > > +	for (i = 0; i < count; i++) {
> > > > +		u64 paddr;
> > > > +
> > > > +		if (!ntb_epf_dma_region_parse(ndev,
> > > > +					      NTB_EPF_DMA_CHAN_DESC_BASE(i),
> > > > +					      false, &edma->ll[i]) ||
> > > > +		    !IS_ALIGNED(edma->ll[i].offset, sizeof(u32)))
> > > > +			return -EINVAL;
> > > > +
> > > > +		paddr = readl(ndev->ctrl_reg +
> > > > +			      NTB_EPF_DMA_CHAN_DESC_ADDR_LO(i));
> > > > +		paddr |= (u64)readl(ndev->ctrl_reg +
> > > Frank> +				    NTB_EPF_DMA_CHAN_DESC_ADDR_HI(i)) << 32;
> > > > +		if (paddr == U64_MAX)
> > > > +			return -EINVAL;
> > > > +
> > > > +		chip->ll_region_rd[i].sz = edma->ll[i].size;
> > > > +		chip->ll_region_rd[i].paddr = paddr;
> > > > +	}
> > > > +	ndev->dma.nr_irqs = count;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int ntb_epf_dw_edma_irq_vector(struct device *dev, unsigned int nr)
> > > > +{
> > > > +	struct ntb_epf_dev *ndev = dev_get_drvdata(dev);
> > > > +
> > > > +	/* DMA vectors follow the NTB link and doorbell vector block. */
> > > > +	return pci_irq_vector(ndev->ntb.pdev, ndev->db_count + 1 + nr);
> > > > +}
> > > > +
> > > > +static const struct dw_edma_plat_ops ntb_epf_dw_edma_ops = {
> > > > +	.irq_vector = ntb_epf_dw_edma_irq_vector,
> > > > +};
> > > > +
> > > > +static void __iomem *
> > > > +ntb_epf_dw_edma_map_region(struct pci_dev *pdev,
> > > > +			   const struct ntb_epf_dma_region *region)
> > > > +{
> > > > +	return pcim_iomap_range(pdev, region->bar, region->offset, region->size);
> > > > +}
> > > > +
> > > > +static int ntb_epf_dw_edma_init(struct ntb_epf_dev *ndev)
> > > > +{
> > > > +	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
> > > > +	struct dw_edma_chip *chip = &edma->chip;
> > > > +	struct pci_dev *pdev = ndev->ntb.pdev;
> > > > +	unsigned int i;
> > > > +	int ret;
> > > > +
> > > > +	/* Install BAR submaps before mapping the advertised DMA regions. */
> > > > +	ret = ntb_epf_send_command(ndev, CMD_SETUP_DMA_BAR, 0);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	chip->reg_base = ntb_epf_dw_edma_map_region(pdev, &edma->reg);
> > > > +	if (IS_ERR(chip->reg_base))
> > > > +		return PTR_ERR(chip->reg_base);
> > > > +	for (i = 0; i < chip->ll_rd_cnt; i++) {
> > > > +		chip->ll_region_rd[i].vaddr.io =
> > > > +			ntb_epf_dw_edma_map_region(pdev, &edma->ll[i]);
> > > > +		if (IS_ERR(chip->ll_region_rd[i].vaddr.io))
> > > > +			return PTR_ERR(chip->ll_region_rd[i].vaddr.io);
> > > > +	}
> > > > +
> > > > +	chip->dev = ndev->dev;
> > > > +	chip->nr_irqs = ndev->dma.nr_irqs;
> > > > +	chip->ops = &ntb_epf_dw_edma_ops;
> > > > +	chip->flags = DW_EDMA_CHIP_PARTIAL;
> > > > +
> > > > +	return dw_edma_probe(chip);
> > > > +}
> > > > +
> > > > +static void ntb_epf_dw_edma_deinit(struct ntb_epf_dev *ndev)
> > > > +{
> > > > +	dw_edma_remove(&ndev->dw_edma.chip);
> > > > +}
> > > > +
> > > > +/* Common endpoint DMA */
> > > > +
> > > > +static int ntb_epf_dma_parse(struct ntb_epf_dev *ndev)
> > > > +{
> > > > +	u32 magic, rev_len, length, type;
> > > > +	u32 spad_off;
> > > > +	int ret;
> > > > +
> > > > +	/*
> > > > +	 * Legacy endpoints place scratchpads where this extension would begin.
> > > > +	 * Once the extension is present, malformed metadata is fatal.
> > > > +	 */
> > > > +	spad_off = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
> > > > +	if (spad_off < NTB_EPF_DMA_BASE + NTB_EPF_DMA_COMMON_SIZE)
> > > > +		return 0;
> > > > +
> > > > +	magic = readl(ndev->ctrl_reg + NTB_EPF_DMA_MAGIC);
> > > > +	if (!magic)
> > > > +		return 0;
> > > > +	if (magic == U32_MAX)
> > > > +		return -EIO;
> > > > +	if (magic != NTB_EPF_DMA_MAGIC_VALUE)
> > > > +		return -EINVAL;
> > > > +
> > > > +	rev_len = readl(ndev->ctrl_reg + NTB_EPF_DMA_REV_LEN);
> > > > +	length = upper_16_bits(rev_len);
> > > > +	if (lower_16_bits(rev_len) != NTB_EPF_DMA_REVISION ||
> > > > +	    length < NTB_EPF_DMA_COMMON_SIZE ||
> > > > +	    spad_off < NTB_EPF_DMA_BASE + length)
> > > > +		return -EINVAL;
> > > > +	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA_SUBMAP_BASE, true,
> > > > +				      &ndev->dma.submap))
> > > > +		return -EINVAL;
> > > > +
> > > > +	type = readl(ndev->ctrl_reg + NTB_EPF_DMA_TYPE);
> > > > +	if (type == U32_MAX)
> > > > +		return -EIO;
> > > > +
> > > > +	switch (type) {
> > > > +	case NTB_EPF_DMA_TYPE_DW_EDMA:
> > > > +		if (!IS_REACHABLE(CONFIG_DW_EDMA))
> > > > +			break;
> > > > +		ret = ntb_epf_dw_edma_parse(ndev, length);
> > > > +		if (!ret)
> > > > +			ndev->dma.type = type;
> > > > +		return ret;
> > > > +	default:
> > > > +		break;
> > > > +	}
> > > > +
> > > > +	dev_warn(ndev->dev,
> > > > +		 "Endpoint DMA type %u unavailable, continuing without DMA\n",
> > > > +		 type);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int ntb_epf_dma_init(struct ntb_epf_dev *ndev)
> > > > +{
> > > > +	switch (ndev->dma.type) {
> > > > +	case NTB_EPF_DMA_TYPE_DW_EDMA:
> > > > +		return ntb_epf_dw_edma_init(ndev);
> > > > +	default:
> > > > +		return 0;
> > > > +	}
> > > > +}
> > > > +
> > > > +static void ntb_epf_dma_deinit(struct ntb_epf_dev *ndev)
> > > > +{
> > > > +	switch (ndev->dma.type) {
> > > > +	case NTB_EPF_DMA_TYPE_DW_EDMA:
> > > > +		ntb_epf_dw_edma_deinit(ndev);
> > > > +		break;
> > > > +	}
> > > > +}
> > > > +
> > > >  static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
> > > >  {
> > > >  	struct device *dev = ndev->dev;
> > > > @@ -174,6 +428,23 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
> > > >  	return ndev->barno_map[BAR_MW1 + idx];
> > > >  }
> > > >
> > > > +static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
> > > > +{
> > > > +	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET) : 0;
> > > > +}
> > > > +
> > > > +static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int bar)
> > > > +{
> > > > +	resource_size_t end;
> > > > +
> > > > +	end = pci_resource_len(ndev->ntb.pdev, bar);
> > > > +	/* The DMA submap offset marks the end of an MW sharing this BAR. */
> > > > +	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
> > > > +		end = min(end, ndev->dma.submap.offset);
> > > > +
> > > > +	return end;
> > > > +}
> > > > +
> > > >  static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
> > > >  {
> > > >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > > > @@ -212,7 +483,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
> > > >  		*size_align = 1;
> > > >
> > > >  	if (size_max)
> > > > -		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
> > > > +		*size_max = ntb_epf_mw_size(ndev, bar);
> > > >
> > > >  	return 0;
> > > >  }
> > > > @@ -373,16 +644,20 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
> > > >  {
> > > >  	struct pci_dev *pdev = ndev->ntb.pdev;
> > > >  	struct device *dev = ndev->dev;
> > > > +	unsigned int dma_max = ndev->dma.nr_irqs;
> > > > +	unsigned int dma_min;
> > > >  	u32 argument = MSIX_ENABLE;
> > > > +	unsigned int ntb_irqs;
> > > >  	int irq;
> > > >  	int ret;
> > > >  	int i;
> > > >
> > > > -	irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
> > > > +	irq = pci_alloc_irq_vectors(pdev, msi_min,
> > > > +				    msi_max + dma_max, PCI_IRQ_MSIX);
> > > >  	if (irq < 0) {
> > > >  		dev_dbg(dev, "Failed to get MSIX interrupts\n");
> > > > -		irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max,
> > > > -					    PCI_IRQ_MSI);
> > > > +		irq = pci_alloc_irq_vectors(pdev, msi_min,
> > > > +					    msi_max + dma_max, PCI_IRQ_MSI);
> > > >  		if (irq < 0) {
> > > >  			dev_err(dev, "Failed to get MSI interrupts\n");
> > > >  			return irq;
> > > > @@ -390,8 +665,17 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
> > > >  		argument &= ~MSIX_ENABLE;
> > > >  	}
> > > >
> > > > -	ndev->db_count = irq - 1;
> > > > -	for (i = 0; i < irq; i++) {
> > > > +	dma_min = dma_max && irq > msi_min;
> > > > +	/* Reserve one shared DMA IRQ when available, then give the rest to NTB. */
> > > > +	ntb_irqs = min_t(unsigned int, irq - dma_min, msi_max);
> > > > +	ndev->dma.nr_irqs = irq - ntb_irqs;
> > > > +	if (dma_max && !ndev->dma.nr_irqs) {
> > > > +		dev_warn(dev,
> > > > +			 "No IRQ available for endpoint DMA, continuing without DMA\n");
> > > > +		ndev->dma.type = 0;
> > > > +	}
> > > > +	ndev->db_count = ntb_irqs - 1;
> > > > +	for (i = 0; i < ntb_irqs; i++) {
> > > >  		ndev->irq_ctx[i].ndev = ndev;
> > > >  		ndev->irq_ctx[i].irq_no = i;
> > > >  		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
> > > > @@ -403,7 +687,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
> > > >  	}
> > > >
> > > >  	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
> > > > -				   argument | irq);
> > > > +				   argument | ntb_irqs);
> > > >  	if (ret) {
> > > >  		dev_err(dev, "Failed to configure doorbell\n");
> > > >  		goto err_free_irq;
> > > > @@ -486,7 +770,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
> > > >  	if (bar < 0)
> > > >  		return bar;
> > > >
> > > > -	mw_size = pci_resource_len(ntb->pdev, bar);
> > > > +	mw_size = ntb_epf_mw_size(ndev, bar);
> > > >
> > > >  	if (size > mw_size) {
> > > >  		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
> > > > @@ -520,21 +804,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
> > > >  				    phys_addr_t *base, resource_size_t *size)
> > > >  {
> > > >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > > > -	u32 offset = 0;
> > > > +	resource_size_t offset;
> > > >  	int bar;
> > > >
> > > > -	if (idx == 0)
> > > > -		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
> > > > -
> > > >  	bar = ntb_epf_mw_to_bar(ndev, idx);
> > > >  	if (bar < 0)
> > > >  		return bar;
> > > >
> > > > +	offset = ntb_epf_mw_offset(ndev, idx);
> > > > +
> > > >  	if (base)
> > > >  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
> > > >
> > > >  	if (size)
> > > > -		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
> > > > +		*size = ntb_epf_mw_size(ndev, bar) - offset;
> > > >
> > > >  	return 0;
> > > >  }
> > > > @@ -630,12 +913,30 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
> > > >  {
> > > >  	struct device *dev = ndev->dev;
> > > >  	int ret;
> > > > +	int i;
> > > >
> > > >  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
> > > >  	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
> > > >  		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
> > > >  		return -EINVAL;
> > > >  	}
> > > > +	ret = ntb_epf_dma_parse(ndev);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Invalid endpoint DMA layout\n");
> > > > +		return ret;
> > > > +	}
> > > > +	if (ndev->dma.submap.size) {
> > > > +		for (i = 0; i < ndev->mw_count; i++) {
> > > > +			int bar = ntb_epf_mw_to_bar(ndev, i);
> > > > +
> > > > +			if (bar == ndev->dma.submap.bar &&
> > > > +			    ntb_epf_mw_size(ndev, bar) <=
> > > > +			    ntb_epf_mw_offset(ndev, i)) {
> > > > +				dev_err(dev, "Invalid DMA/MW boundary\n");
> > > > +				return -EINVAL;
> > > > +			}
> > > > +		}
> > > > +	}
> > > >
> > > >  	/* One Link interrupt and rest doorbell interrupt */
> > > >  	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
> > > > @@ -785,6 +1086,12 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
> > > >  		goto err_init_dev;
> > > >  	}
> > > >
> > > > +	ret = ntb_epf_dma_init(ndev);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Failed to initialize endpoint DMA\n");
> > > > +		goto err_dma_init;
> > > > +	}
> > > > +
> > > >  	ret = ntb_register_device(&ndev->ntb);
> > > >  	if (ret) {
> > > >  		dev_err(dev, "Failed to register NTB device\n");
> > > > @@ -794,6 +1101,8 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
> > > >  	return 0;
> > > >
> > > >  err_register_dev:
> > > > +	ntb_epf_dma_deinit(ndev);
> > > > +err_dma_init:
> > > >  	ntb_epf_cleanup_isr(ndev);
> > > >
> > > >  err_init_dev:
> > > > @@ -807,6 +1116,7 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
> > > >  	struct ntb_epf_dev *ndev = pci_get_drvdata(pdev);
> > > >
> > > >  	ntb_unregister_device(&ndev->ntb);
> > > > +	ntb_epf_dma_deinit(ndev);
> > > >  	ntb_epf_cleanup_isr(ndev);
> > > >  	ntb_epf_deinit_pci(ndev);
> > > >  }
> > > > --
> > > > 2.51.0
> > > >
