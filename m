Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B925F389116;
	Fri, 28 Aug 2026 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937000; cv=fail; b=Ag+T/bPFoa5W3JSryxwQnk9lx9ROrTnxGEalqtr68xg56joxir3RQN2x4CttC/fc/CQtrM9+o7+HTMrrQ57uYVQp5UMwSjAHV5daeJ7IcgQ2q+D4kgCLPw3+alRDFrcdLn/AgkNf/CygzHK6k3v8rVKRBKrcMZX0MicdR19/krA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937000; c=relaxed/simple;
	bh=Q+PSXsylTPkaefra1HoKioozUc8zM40pdMeTj4lZGcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NVIysJy6G7Lv6NDdFqaaghMU4MwZLkVWyuMhJF+SUi/FAt65EokArLX3Q4cfZRFirnokcddyJ8YhoxGl3IbjoGm4cHaKU2EGNZvB2RmWUSAIODb9qUjDmPbDHsyMTWcidSAjQvWUxe6+LlQn3EIsb92LRe0Wu7666PBsJ20dGeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Bz2nweWK; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Bz2nweWK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEVXWTC76nWzva4k/Mb4hx+B3ohI42ul3UulfDUd9dluldVVC1hS13iwjFSUeboHdKN0Ba57ReUJOaKRNibHMBTdWCuofu0t9uCT/jtSvrlQNrxlLIuK6x0ZqyB/b7Zhl4FKXLN+iIJ6K5apNt8D01ozSdFHlkwa50z5RNKi8TYhK+zT79/VL3Q7I/EvZrgIp5xi15VVJpfb8DY/Ygu40TWFoJB798SkLCSQiqaJIMQum3lnTao7yxymF2EOIeu+KiD7aCzqY5Ue1s32ibKswgktM9euXz6t3xIaV3iiqjtgl/t77+KH5nR48MM4r1eI8MoJT6hhCWYaHua8mwAOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC/s/DZevu9aeGGPJBisc2RQyhX5u28YKL6jm2pQvoo=;
 b=rKljgzZ2AXloS9B2Wv+fErNX3srhlsK38AlBSBpiF+RBv8LAYok3VatIgGp+LlSw/gIdAgeUPPfdKbln5Q2hHL/nXngQsv50zx1cF7ZNDularC0mDLZkT+j2o0HOT6rGJ55ViaUqm5EnTTaeG8Ovu4NO579bS295nCYAX6C4n0ese6P6tRH0qnDxaq1D3agdW/Gervewvwye4+Q4WyZusDC3MgBq+Hd7WVoiDOGKilqvo8xGtpY2pZsSIp9h2zZ/X5ipl/hW3zP6Up05dZq5lpS3j920QCJ6K5BC7aEi2GdSwq36oDET9GRZoXIoRNayDST/g0LkDYrPSpt8Pidruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC/s/DZevu9aeGGPJBisc2RQyhX5u28YKL6jm2pQvoo=;
 b=Bz2nweWKOx9PZuxR1RjuFJxwM7dbtuf50ME6+PXLoHLW8eSHerW599Jc+h29WCbW+iJbmS//RxJtSdhK2bKzcSorCj6es3VA21dWTjQWW613GChM7wedzpZfLuc27tiz/i/t+bVlKcpiOVGzGNdYI8RXudBnOfiQ6ZuQyRt2JnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7951.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:09:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:09:43 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v2 5/5] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Date: Sat, 29 Aug 2026 02:09:32 +0900
Message-ID: <20260828170932.2735807-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260828170932.2735807-1-den@valinux.co.jp>
References: <20260828170932.2735807-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::23) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ce73a3-b961-4c53-4afe-08df05272747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|376014|7416014|1800799024|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/twOi4GBqqp39LUaVhKPAeXs+5YQkAYLzgV+ZSqoGMa/IBnWfw+yAJB5HyOkrCHg8TZUa4DWrtduF7V67NmCHxt75GQC2caoT5o249k67qXStANHLk7GEtO5LAEtoVKSAi/McucKbXcyZaz7+fNjzDtqUxYZAFzPRu8eaOe1EL1sTxNIoiPy4iTs+fRFxiv7oQU2mYlgD/aW6IJncHuHqgorv6zH/OLHQA7Z2iHQFwNYcfrpP53EzluJMjdXiHxltAYdO8wQMD1RRB/qY3Qh2t1nhZzWT75KNttE4SGSFpmk3k9Kp5D0B6yPLMTjiB3+MpycxKiPZt35U/zENDMq5gdzWLMUoVWlt5gdftg5F8nGJh13oP19+wUVn9AVQMOLQN0d99b5IykNknQRe8RA4WAllleQeAOTVHcZm6NFuFPmh9PnDzw+IKEYQnI0eGntKJNj8xg88ktlqxcPMpS/qPYG93AkXTJ9Bm+nU0ZJ9s+ChTaJ0Ew/2LhTjCjLpzoGiK6HNlkiamOvKEzt1SQfT1CUhd04ulCUBllGH3D701vy1IW2z6lQA7nQQ713r5gw9ybP2wdsVgtxkyjUQDIBkCDGn17zTMSZuuEDu9dN4m3WYqYLLiaKHQcLSh8YiDVe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(376014)(7416014)(1800799024)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r++60l+XR2o3MomMHjnVZOutYmZ4YEWGzGIjvdlV8qDkdngrCUQkTnxOKFbo?=
 =?us-ascii?Q?13VuA7f5oEWyYwe/8oOyhV0ACU0XwKUVXSkAqAtXy/BQbPGgF5i2P0vO/BqL?=
 =?us-ascii?Q?kgbPKTLR+drwk1tFdfbOI9SJhdMdeYcRiXKtVgeyYbDBQOR/+XAibyqt0t1+?=
 =?us-ascii?Q?cOA9HRWK5rhekP6knbL4EAtzaL2+5L7w+ndXUts98JGws61VgUxVgygu0i8n?=
 =?us-ascii?Q?O7lBCHbQZO+qiwHPAjkfcpMBU4uXoA3N4nhCynUBa+FymFn4W+4n+HjET91u?=
 =?us-ascii?Q?Hxvl9WjHL3KB2M/JD3xfp9qWHakuPaom5onTSXiZEj/w4fqxkRFny/3DnD11?=
 =?us-ascii?Q?ePn47mGszopJvHe1BOq0RahzC8ioAjcOg4Hu6LamsKpViVJYyUDuKZUZFcLq?=
 =?us-ascii?Q?LCzByXYWGaeyfTPlnAPsb4UAyvRfvIQmphb5yL2yO75wd1PTEOWI5/H3c2Y8?=
 =?us-ascii?Q?fM+3SO9oNvSyeZXnjTxwY+Hprsws+pd29eOktNLLJXtnQkDENSQWNhIAspwk?=
 =?us-ascii?Q?hkq7ZZs3U6htZlfIVnkl2cpCIdZHr2xIFMSw7ZXo6PkWnelSn+RXJo5YxofJ?=
 =?us-ascii?Q?02YdWKL4EO4+LaRrue4V66msGLLiiyfjtbgR3+jrvFehOhmySwvfu8NrQEbm?=
 =?us-ascii?Q?LC3gkJoKVIXjDXlzhLNvFdw4QoLv859VX1nDdarI1j1tMkjqz81x9NCFxhOA?=
 =?us-ascii?Q?BH88bOIRwRjrgNSfUINmVS0/Yh89iqUuCTyWQNazSMjNjX1WGet6f5e6bJKC?=
 =?us-ascii?Q?KEJx+JlAmMwfhnQMGjWPYN/3+uEirtKCxhDbb8eiN2FS3vE2YT3793JhZt+y?=
 =?us-ascii?Q?PFStx2BQ+cgP2XKtqpbxFuzGQouNjY06L1I8ydIr2gFJeuntLQPPG1+PfX0m?=
 =?us-ascii?Q?ZUig9EtRTeW+ZX1E8SRRk+cO3m8YtfHmfF6QLkwoY9vEQba35ieHgQMLlYAn?=
 =?us-ascii?Q?i0Xq77o/AMhDEiAaWjT9+XbgiWbfaBGQW9oDnq4SaVVkKhiteToqrMfUCSvY?=
 =?us-ascii?Q?lzIlTgLLxMOtG4dSkEEsYRITgorKn9cVqbHUn+2nRtUQp2jqCTvZ3tz+0diY?=
 =?us-ascii?Q?/4M8dB/dn2tygRq2t4YoxiLRm0GQsXEXseBYK0LjgcROZgl4S3Ua6T8B38Xz?=
 =?us-ascii?Q?EfMV0418Z14m/Dwnh//j+Op5J9t/cwsu3y90EGySIHDn596u0dS8FHaDhMhu?=
 =?us-ascii?Q?FubD0EMR822bRFY8GJndYHEZPHFaPWmBfIaRIK4VYb+jamo2AhFXIKFQD4YB?=
 =?us-ascii?Q?8U30ij5q4OSzhkhdSm+HqjxrS2qbdwninUabUgcdnUNn561q2BpAY0qcI21v?=
 =?us-ascii?Q?veJqqHdtXN16vA3cy18UldDw8hTMsxuPvJVKrnn3Y3blPDU/5dIqd7OGz3d9?=
 =?us-ascii?Q?UxDomtY+nFOweuSMENR7kPUHg08w1ul4cU/56E5Qu5x/UrE7i+iTvvObgnGJ?=
 =?us-ascii?Q?bBQefiYq5V/h7YCxKYfD4GPj5PuLGXb5YvEo7rEiVHqrrlIm2NEcHXXxuVcq?=
 =?us-ascii?Q?bLc8Xv0fcVDO6ih9yqjmUXy1doZQMeIUha0VgLcmXsxU9J47KiEbkDYDxshE?=
 =?us-ascii?Q?UYn5YmZ6ek91WRkktz8b/MB1lP2j864xqF7DvzDb4Jpb5pV6NJjNQp7OIAMr?=
 =?us-ascii?Q?EBbEhW6kALiT+zZZRv49CjcaL5xHxUCdMPrJNJp3SQqOS/GcZ6E5pPDQtegk?=
 =?us-ascii?Q?F6zU/UZbugcRSf72JMoZeujsW3GD0UZ94mLKPIq63ezQP7gOZiaosbx7GTPw?=
 =?us-ascii?Q?RebUq4x73DhqcjDB+a9RG9Sb4XVa4cDk+WRLMmJCltISzXlrR9+r?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ce73a3-b961-4c53-4afe-08df05272747
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 17:09:43.1448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBfqPwpvCd9GFyfZO9VaG8LZNt1ghh5qVYpKwNLJpPNP0y0oNh0x+t6yyTjHC1oer3vXL/7nydGrN7UigOOnMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7951

A vNTB PCI function can now expose endpoint-local DMA channels to its
host. Decode the extension and register the advertised channels before
the NTB device, so clients of that NTB device can use the DMA
functionality in the same PCI function.

Add the host-side discovery and setup to ntb_hw_epf. Endpoints without
the extension keep the existing path.

Only DW eDMA is supported for now. Dispatch on the advertised DMA type
and keep type-specific setup in local helpers. Support for another
implementation can add a new case and its own helpers.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Completely rework v1 patches 11-13: drop the generic DMA locator and
    auxiliary child, and keep discovery and registration in ntb_hw_epf.
    https://lore.kernel.org/r/20260312165005.1148676-1-den@valinux.co.jp/
  - Rework host-side discovery from PCI DMA EPF v7 patch 8 into
    ntb_hw_epf.
    https://lore.kernel.org/r/20260813063757.3131865-9-den@valinux.co.jp/
  - Place DMA interrupt vectors after the NTB doorbell vectors.

 drivers/ntb/hw/epf/ntb_hw_epf.c | 360 ++++++++++++++++++++++++++++++--
 1 file changed, 348 insertions(+), 12 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index c47607d4f8a7..cae1ad4834c7 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -8,6 +8,7 @@
 
 #include <linux/atomic.h>
 #include <linux/delay.h>
+#include <linux/dma/edma.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -20,6 +21,8 @@
 #define CMD_TEARDOWN_MW		4
 #define CMD_LINK_UP		5
 #define CMD_LINK_DOWN		6
+#define CMD_CONFIGURE_DMA	7
+#define CMD_TEARDOWN_DMA	8
 
 #define NTB_EPF_ARGUMENT	0x4
 #define MSIX_ENABLE		BIT(16)
@@ -44,6 +47,32 @@
 #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
 #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
 
+/* Private DMA wire extension produced by pci-epf-vntb. */
+#define NTB_EPF_DMA_BASE	0x134
+#define NTB_EPF_DMA_MAGIC	(NTB_EPF_DMA_BASE + 0x00)
+#define NTB_EPF_DMA_REV_LEN	(NTB_EPF_DMA_BASE + 0x04)
+#define NTB_EPF_DMA_TYPE	(NTB_EPF_DMA_BASE + 0x08)
+#define NTB_EPF_DMA_REGION_BAR(base)	((base) + 0x00)
+#define NTB_EPF_DMA_REGION_OFFSET(base)	((base) + 0x04)
+#define NTB_EPF_DMA_REGION_SIZE(base)	((base) + 0x08)
+#define NTB_EPF_DMA_REGION_SIZEOF	0x0C
+#define NTB_EPF_DMA_SUBMAP_BASE	(NTB_EPF_DMA_BASE + 0x0C)
+#define NTB_EPF_DMA_COMMON_SIZE	0x18
+#define NTB_EPF_DMA_REG_BASE	(NTB_EPF_DMA_BASE + NTB_EPF_DMA_COMMON_SIZE)
+#define NTB_EPF_DMA_CHAN_BASE	(NTB_EPF_DMA_REG_BASE + \
+					 NTB_EPF_DMA_REGION_SIZEOF)
+#define NTB_EPF_DMA_CHAN_SIZE	0x14
+#define NTB_EPF_DMA_CHAN_DESC_BASE(n)	(NTB_EPF_DMA_CHAN_BASE + \
+					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x00)
+#define NTB_EPF_DMA_CHAN_DESC_ADDR_LO(n)	(NTB_EPF_DMA_CHAN_BASE + \
+					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x0C)
+#define NTB_EPF_DMA_CHAN_DESC_ADDR_HI(n)	(NTB_EPF_DMA_CHAN_BASE + \
+					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x10)
+
+#define NTB_EPF_DMA_MAGIC_VALUE	0x414d444e /* "NDMA": NTB DMA */
+#define NTB_EPF_DMA_REVISION	1
+#define NTB_EPF_DMA_TYPE_DW_EDMA	1
+
 /*
  * Legacy doorbell slot layout when paired with pci-epf-*ntb:
  *
@@ -97,6 +126,25 @@ struct ntb_epf_irq_ctx {
 	unsigned int irq_no;
 };
 
+struct ntb_epf_dma_region {
+	unsigned int bar;
+	resource_size_t offset;
+	resource_size_t size;
+	void __iomem *vaddr;
+};
+
+struct ntb_epf_dw_edma {
+	struct dw_edma_chip chip;
+	struct ntb_epf_dma_region reg;
+	struct ntb_epf_dma_region ll[EDMA_MAX_RD_CH];
+};
+
+struct ntb_epf_dma {
+	struct ntb_epf_dma_region submap;
+	unsigned int nr_irqs;
+	u32 type;
+};
+
 struct ntb_epf_dev {
 	struct ntb_dev ntb;
 	struct device *dev;
@@ -108,6 +156,8 @@ struct ntb_epf_dev {
 	unsigned int mw_count;
 	unsigned int spad_count;
 	unsigned int db_count;
+	struct ntb_epf_dma dma;
+	struct ntb_epf_dw_edma dw_edma;
 
 	void __iomem *ctrl_reg;
 	void __iomem *db_reg;
@@ -162,6 +212,244 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
 	return ret;
 }
 
+static bool ntb_epf_dma_region_parse(struct ntb_epf_dev *ndev, u32 base,
+				     bool optional,
+				     struct ntb_epf_dma_region *region)
+{
+	resource_size_t bar_len;
+	u32 bar, offset, size;
+
+	bar = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_BAR(base));
+	offset = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_OFFSET(base));
+	size = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_SIZE(base));
+	region->bar = bar;
+	region->offset = offset;
+	region->size = size;
+	if (!size)
+		return optional && bar == U32_MAX && !offset;
+	if (bar > BAR_5)
+		return false;
+
+	bar_len = pci_resource_len(ndev->ntb.pdev, bar);
+	if (offset > bar_len || size > bar_len - offset)
+		return false;
+
+	return true;
+}
+
+/* DW eDMA */
+
+static int ntb_epf_dw_edma_parse(struct ntb_epf_dev *ndev, u32 length)
+{
+	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
+	struct dw_edma_chip *chip = &edma->chip;
+	u32 count, chan_offset;
+	unsigned int i;
+
+	chan_offset = NTB_EPF_DMA_CHAN_BASE - NTB_EPF_DMA_BASE;
+	if (length < chan_offset + NTB_EPF_DMA_CHAN_SIZE ||
+	    (length - chan_offset) % NTB_EPF_DMA_CHAN_SIZE)
+		return -EINVAL;
+
+	count = (length - chan_offset) / NTB_EPF_DMA_CHAN_SIZE;
+	if (count > EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA_REG_BASE, false,
+				      &edma->reg))
+		return -EINVAL;
+
+	chip->mf = EDMA_MF_EDMA_UNROLL;
+	chip->nr_irqs = count;
+	chip->ll_rd_cnt = count;
+	chip->func_no = PCI_FUNC(ndev->ntb.pdev->devfn);
+
+	for (i = 0; i < count; i++) {
+		u64 paddr;
+
+		if (!ntb_epf_dma_region_parse(ndev,
+					      NTB_EPF_DMA_CHAN_DESC_BASE(i),
+					      false, &edma->ll[i]))
+			return -EINVAL;
+
+		paddr = readl(ndev->ctrl_reg +
+			      NTB_EPF_DMA_CHAN_DESC_ADDR_LO(i));
+		paddr |= (u64)readl(ndev->ctrl_reg +
+				    NTB_EPF_DMA_CHAN_DESC_ADDR_HI(i)) << 32;
+		if (paddr == U64_MAX)
+			return -EINVAL;
+
+		chip->ll_region_rd[i].sz = edma->ll[i].size;
+		chip->ll_region_rd[i].paddr = paddr;
+	}
+	ndev->dma.nr_irqs = count;
+
+	return 0;
+}
+
+static int ntb_epf_dw_edma_irq_vector(struct device *dev, unsigned int nr)
+{
+	struct ntb_epf_dev *ndev = dev_get_drvdata(dev);
+
+	if (nr >= ndev->dma.nr_irqs)
+		return -EINVAL;
+
+	return pci_irq_vector(ndev->ntb.pdev, ndev->db_count + 1 + nr);
+}
+
+static const struct dw_edma_plat_ops ntb_epf_dw_edma_ops = {
+	.irq_vector = ntb_epf_dw_edma_irq_vector,
+};
+
+static int ntb_epf_dw_edma_map_region(struct pci_dev *pdev,
+				      struct ntb_epf_dma_region *region)
+{
+	region->vaddr = pci_iomap_range(pdev, region->bar, region->offset,
+					region->size);
+	return region->vaddr ? 0 : -ENOMEM;
+}
+
+static void ntb_epf_dw_edma_unmap_regions(struct ntb_epf_dev *ndev)
+{
+	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
+	struct pci_dev *pdev = ndev->ntb.pdev;
+	unsigned int i;
+
+	for (i = 0; i < edma->chip.ll_rd_cnt; i++) {
+		if (!edma->ll[i].vaddr)
+			continue;
+		pci_iounmap(pdev, edma->ll[i].vaddr);
+	}
+	if (edma->reg.vaddr)
+		pci_iounmap(pdev, edma->reg.vaddr);
+}
+
+static int ntb_epf_dw_edma_init(struct ntb_epf_dev *ndev)
+{
+	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
+	struct dw_edma_chip *chip = &edma->chip;
+	struct pci_dev *pdev = ndev->ntb.pdev;
+	unsigned int i;
+	int ret;
+
+	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DMA, 0);
+	if (ret)
+		return ret;
+
+	ret = ntb_epf_dw_edma_map_region(pdev, &edma->reg);
+	if (ret)
+		goto err_teardown;
+	for (i = 0; i < chip->ll_rd_cnt; i++) {
+		ret = ntb_epf_dw_edma_map_region(pdev, &edma->ll[i]);
+		if (ret)
+			goto err_iounmap;
+	}
+
+	chip->dev = ndev->dev;
+	chip->ops = &ntb_epf_dw_edma_ops;
+	chip->flags = DW_EDMA_CHIP_PARTIAL;
+	chip->reg_base = edma->reg.vaddr;
+	for (i = 0; i < chip->ll_rd_cnt; i++)
+		chip->ll_region_rd[i].vaddr.io = edma->ll[i].vaddr;
+
+	ret = dw_edma_probe(chip);
+	if (ret)
+		goto err_iounmap;
+
+	return 0;
+
+err_iounmap:
+	ntb_epf_dw_edma_unmap_regions(ndev);
+err_teardown:
+	ntb_epf_send_command(ndev, CMD_TEARDOWN_DMA, 0);
+	return ret;
+}
+
+static void ntb_epf_dw_edma_deinit(struct ntb_epf_dev *ndev)
+{
+	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
+	int ret;
+
+	dw_edma_remove(&edma->chip);
+	ntb_epf_dw_edma_unmap_regions(ndev);
+
+	ret = ntb_epf_send_command(ndev, CMD_TEARDOWN_DMA, 0);
+	if (ret)
+		dev_warn(ndev->dev, "Failed to teardown endpoint DMA\n");
+}
+
+/* Common endpoint DMA */
+
+static int ntb_epf_dma_parse(struct ntb_epf_dev *ndev)
+{
+	u32 magic, rev_len, length, type;
+	u32 spad_off;
+	int ret;
+
+	spad_off = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
+	if (spad_off < NTB_EPF_DMA_BASE + NTB_EPF_DMA_COMMON_SIZE)
+		return 0;
+
+	magic = readl(ndev->ctrl_reg + NTB_EPF_DMA_MAGIC);
+	if (!magic)
+		return 0;
+	if (magic == U32_MAX)
+		return -EIO;
+	if (magic != NTB_EPF_DMA_MAGIC_VALUE)
+		return -EINVAL;
+
+	rev_len = readl(ndev->ctrl_reg + NTB_EPF_DMA_REV_LEN);
+	length = upper_16_bits(rev_len);
+	if (lower_16_bits(rev_len) != NTB_EPF_DMA_REVISION ||
+	    length < NTB_EPF_DMA_COMMON_SIZE ||
+	    spad_off < NTB_EPF_DMA_BASE + length)
+		return -EINVAL;
+	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA_SUBMAP_BASE, true,
+				      &ndev->dma.submap))
+		return -EINVAL;
+
+	type = readl(ndev->ctrl_reg + NTB_EPF_DMA_TYPE);
+	if (type == U32_MAX)
+		return -EIO;
+
+	switch (type) {
+	case NTB_EPF_DMA_TYPE_DW_EDMA:
+		ret = ntb_epf_dw_edma_parse(ndev, length);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (!ret)
+		ndev->dma.type = type;
+
+	return ret;
+}
+
+static int ntb_epf_dma_init(struct ntb_epf_dev *ndev)
+{
+	switch (ndev->dma.type) {
+	case 0:
+		return 0;
+	case NTB_EPF_DMA_TYPE_DW_EDMA:
+		return ntb_epf_dw_edma_init(ndev);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void ntb_epf_dma_deinit(struct ntb_epf_dev *ndev)
+{
+	if (!ndev->dma.type)
+		return;
+
+	switch (ndev->dma.type) {
+	case NTB_EPF_DMA_TYPE_DW_EDMA:
+		ntb_epf_dw_edma_deinit(ndev);
+		break;
+	}
+}
+
 static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
 {
 	struct device *dev = ndev->dev;
@@ -174,6 +462,24 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
 	return ndev->barno_map[BAR_MW1 + idx];
 }
 
+static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
+{
+	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET) : 0;
+}
+
+static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int idx,
+				       int bar)
+{
+	resource_size_t offset, end;
+
+	offset = ntb_epf_mw_offset(ndev, idx);
+	end = pci_resource_len(ndev->ntb.pdev, bar);
+	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
+		end = min(end, ndev->dma.submap.offset);
+
+	return offset < end ? end - offset : 0;
+}
+
 static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
@@ -212,7 +518,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 		*size_align = 1;
 
 	if (size_max)
-		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
+		*size_max = ntb_epf_mw_size(ndev, idx, bar);
 
 	return 0;
 }
@@ -373,15 +679,19 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 {
 	struct pci_dev *pdev = ndev->ntb.pdev;
 	struct device *dev = ndev->dev;
+	unsigned int dma_irqs = ndev->dma.nr_irqs;
+	unsigned int ntb_irqs;
 	u32 argument = MSIX_ENABLE;
 	int irq;
 	int ret;
 	int i;
 
-	irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
+	irq = pci_alloc_irq_vectors(pdev, msi_min + dma_irqs,
+				    msi_max + dma_irqs, PCI_IRQ_MSIX);
 	if (irq < 0) {
 		dev_dbg(dev, "Failed to get MSIX interrupts\n");
-		irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max,
+		irq = pci_alloc_irq_vectors(pdev, msi_min + dma_irqs,
+					    msi_max + dma_irqs,
 					    PCI_IRQ_MSI);
 		if (irq < 0) {
 			dev_err(dev, "Failed to get MSI interrupts\n");
@@ -390,8 +700,9 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		argument &= ~MSIX_ENABLE;
 	}
 
-	ndev->db_count = irq - 1;
-	for (i = 0; i < irq; i++) {
+	ntb_irqs = irq - dma_irqs;
+	ndev->db_count = ntb_irqs - 1;
+	for (i = 0; i < ntb_irqs; i++) {
 		ndev->irq_ctx[i].ndev = ndev;
 		ndev->irq_ctx[i].irq_no = i;
 		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
@@ -403,7 +714,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 	}
 
 	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
-				   argument | irq);
+				   argument | ntb_irqs);
 	if (ret) {
 		dev_err(dev, "Failed to configure doorbell\n");
 		goto err_free_irq;
@@ -486,7 +797,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	if (bar < 0)
 		return bar;
 
-	mw_size = pci_resource_len(ntb->pdev, bar);
+	mw_size = ntb_epf_mw_size(ndev, idx, bar);
 
 	if (size > mw_size) {
 		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
@@ -520,21 +831,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 				    phys_addr_t *base, resource_size_t *size)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
-	u32 offset = 0;
+	resource_size_t offset;
 	int bar;
 
-	if (idx == 0)
-		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
-
 	bar = ntb_epf_mw_to_bar(ndev, idx);
 	if (bar < 0)
 		return bar;
 
+	offset = ntb_epf_mw_offset(ndev, idx);
+
 	if (base)
 		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
 
 	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
+		*size = ntb_epf_mw_size(ndev, idx, bar);
 
 	return 0;
 }
@@ -630,12 +940,29 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 {
 	struct device *dev = ndev->dev;
 	int ret;
+	int i;
 
 	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
 	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
 		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
 		return -EINVAL;
 	}
+	ret = ntb_epf_dma_parse(ndev);
+	if (ret) {
+		dev_err(dev, "Invalid endpoint DMA layout\n");
+		return ret;
+	}
+	if (ndev->dma.submap.size) {
+		for (i = 0; i < ndev->mw_count; i++) {
+			int bar = ntb_epf_mw_to_bar(ndev, i);
+
+			if (bar == ndev->dma.submap.bar &&
+			    !ntb_epf_mw_size(ndev, i, bar)) {
+				dev_err(dev, "Invalid DMA/MW boundary\n");
+				return -EINVAL;
+			}
+		}
+	}
 
 	/* One Link interrupt and rest doorbell interrupt */
 	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
@@ -785,6 +1112,12 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 		goto err_init_dev;
 	}
 
+	ret = ntb_epf_dma_init(ndev);
+	if (ret) {
+		dev_err(dev, "Failed to initialize endpoint DMA\n");
+		goto err_dma_init;
+	}
+
 	ret = ntb_register_device(&ndev->ntb);
 	if (ret) {
 		dev_err(dev, "Failed to register NTB device\n");
@@ -794,6 +1127,8 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_register_dev:
+	ntb_epf_dma_deinit(ndev);
+err_dma_init:
 	ntb_epf_cleanup_isr(ndev);
 
 err_init_dev:
@@ -807,6 +1142,7 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
 	struct ntb_epf_dev *ndev = pci_get_drvdata(pdev);
 
 	ntb_unregister_device(&ndev->ntb);
+	ntb_epf_dma_deinit(ndev);
 	ntb_epf_cleanup_isr(ndev);
 	ntb_epf_deinit_pci(ndev);
 }
-- 
2.51.0

