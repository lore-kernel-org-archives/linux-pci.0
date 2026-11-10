Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299121;
	b=Vk/GB2H3XQ4ifBy3cO2UqLMN6zmD26mX4ACNDwbnhQUF4+4bidb7NfHOMkJYkd//jGg9
	 W5jkrQcxZnlY58uExPVe0t6h6gOk7XPKR4x74T+mvQKPPo4qZKm46cdaqb8BOU3Ngt19V
	 G37A1cdWQ+hqa8FjGafUgW5kyyz4Ru4A6PN72YnvTyUzGpLUpMb4/w7IIM0Yi5eHoFrNt
	 r2+qUqe8IXht+Kw+jBGXhSDrBnrndyqwL1Zt83LZX8Qk1G9rwXN94PibAFkJK9o3SkU71
	 T+U5i7837tGvGff7Rec6CqTicMOhSgWk1sHRt9eOuZszox97Wso3QZAWrK1RlbkMMFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299121;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xBQ/tCX1eKhdtsP58xUYKea0/qCMasmdUejy6LoooqM=;
	b=1ZhLVBFfxjw5lRXq757MH1La7Oww2Q75Avn8nury/nUFgVg03bcS+k6rVjM70M2MQUXk
	 NdzmHbHBcawGJJHFFYQ1zIXfTJWkshfHlsXGKgyzzgoK80H+OkXnyQex0Drv9+hG7soxz
	 gobQmBy1ajsmJNLocGE4gMX8Fg/GCCZSYEXA37Ehv6ochC+QaO0bBd8duoDO8VbMt24Ra
	 TQ3YWAuSw5fG/wgIu3qgQF7Mw1FGaVIKKAgXiwPrpFFgNGlCvq/nQDnu+VmQW5+3s/CWD
	 +KFpfOArxgyMA5NhQvhd/LrkcOBSDygAnlHhh9YzBkKK4yvfYWFBpME53TFOlcIMPIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=edwzvwP9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0273660A382D;
	Tue, 10 Nov 2026 08:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0273660A382D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=edwzvwP9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueq+zPNeNPcGlqXPu0bX63lg7sfS3cdLem18pWbkzz9u8jNpYGyxvLuMHsG/Nx6yAVV7AeEdZM0+APFxMrAfVyhgmND9Y4JJdTf5wbcNbmt6puODGvSoCPmhx8Ns6akn9Fhmeg57mQQx+hwaOtOCxaXnucQg9oslVPXqVnsCJElIDVoZQY02j+HBUzeyRKTbsECH30/gUtpNXArF6Zu4eBxFjfWE/iVGUXMUXpMME1799KrKzcM+PpOOnt0fJGn3Lw6OI/aYyJSZi0cFNoanMYC7/eeUD1NOn2jVXOTtuzUgX3iW3we0oVxw4JA5/h/5wygS25zUUvs3uB0/hiWt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBQ/tCX1eKhdtsP58xUYKea0/qCMasmdUejy6LoooqM=;
 b=K2sSMzPc9P62e3ABhLJQGPWoyl2GeizmZ1xZDudOGf0e2MADnbzqw/ieBge70FOZZtEyNJnyGSxXlsb6DvTjQuUN2TpG7IEcp/ffOv10hVzz/jvjix8CrOh6oQm/4i/zd8Z57fJ4FsGVJVzJeD4xkuU3j0Z89KLfA0G4ZXYkkGGvuQHMVUgA/0H7ZDNFFIeOjGkXBxb3FMwNFINni1SWreqjD8X2GPOWs36Pl+sC2CbMHAIzslfurxkszMzlHQV6ArjHaSsnkKb/V9/D12SXkMU87qKBqNQf+f1zP6bKCPabQXfw5wKGd78BLJ6s9YqXQnss3AH8N38N0Re804Bpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBQ/tCX1eKhdtsP58xUYKea0/qCMasmdUejy6LoooqM=;
 b=edwzvwP9SvGyMEkVAj5Xg9b+HHlG+s0fzDGzAEylM3X2kBxfsYboulgeJkijJLkMXsXphxhbm1M/LDUqwPPNpwVPAvFKHb6xPnVB6BhqP5bxgCxYfAUKSLbWhHZ1EbbeV+iT+6y/9UOhmdCozAXaPCu7rzKsmDAtHdSGWyg8/J4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB3015.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:318::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:25:14 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:25:14 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
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
Subject: [PATCH v9 09/10] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Date: Tue, 10 Nov 2026 17:24:58 +0900
Message-ID: <20261110082459.1798763-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110082459.1798763-1-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0216.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY3P286MB3015:EE_
X-MS-Office365-Filtering-Correlation-Id: b29f1914-f329-4f87-39e2-08df3f0424cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|366016|1800799024|56012099006|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261026121527099003|261026140227099003|261022115727099003|261028144727099003|261102123227099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	s9c7u3UCqXRavaEUd0HUlE0N6o+3v1l3aXgjEV2OzB0oCtG/GPvna0QVRuCkmNfEqL6p4BcYYQzeSgyMXV2Fn6Dwz8cSzaukfyZvwkfkP7fTnvcUtxV0dfts2npblY5O8t5OuC8NSB/WPxOJP7YtkSJAmK33abWsk3IBgZrI0x2UkMIfnE9WcpFUFmhrJDJBYTVEGML9xE412sJsbSoM1qOXU3jVKfXsYU1F6LNhQ7YMyoGAs1LOBRtELHYbikMUHvbw3vf2X4l54qptPh8kUi0WizR8GeIaWsH0onG1K+RwLS/z/poVh/ur+JcyVZxwqCfieI7xjZLIaH/XBnoQ9GuO0enM76llukCvdkV7oD5TytTObLBHROY5kUv4nx7v4sig825a3wiQzdCW3H1W1gHMiKz9QB3YjcnnLGa01TcMuE9QgdAPKcCvOrBJKReFnNuLqUxSebg4M5GYm05EnFzjHj3zQpQW1vS7NvhN+sSnbzIEORRewBCfHbosrEk3JQM48rgEZJvFyi5cB+6c03Q66Q3yFzPPDm32+t+enwlPYLSXS0Y9lOhaP+60CnhSbtEe8HvYk1an10Su4JArt7r9DiWSysqEVF5nu+FzikOecGX9IpkWBisf+ZjtrITZxrJyFO/L44LkaOYc0Wky7V2QuYqyJJ7N4B6aIVvC+p4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261022115727099003)(261028144727099003)(261102123227099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0bPKifaeq5GGccCbruIl4bZHtfGQOPAMHsv1P3zaqRvsSoVCURN7qaCyzpty?=
 =?us-ascii?Q?SYJPVdG/fbEOhgY4rL5Gn/7wkJgQweO772vNAN9Eng7Ly3qYI2P38MmvUR7L?=
 =?us-ascii?Q?dzArquf66B3mlYjYvT1CXuYjG/uVl64F4L+TqgbeX1LhiWHEUG9PJy/SM+BS?=
 =?us-ascii?Q?YhEtB89AYZcGwrxJMPd8dFMSopSFf27jYS93MrsX9RiYGhsOfVg1mli1S83W?=
 =?us-ascii?Q?YbDyxCPo/mI4SILVOu5e5ZH9lnC6n4sA+pLKjHJkvJ6oOxJfBWIbS6dOssmS?=
 =?us-ascii?Q?w1UaFBe+zLWQaL7by6eMfBM28ZMJ6U97Jyctg5Slg9f+qRdc6sSbLzI1HYNy?=
 =?us-ascii?Q?2N7Ib7VgOFdoNUhUDwBSXkQ6JPwugv6aBX9Rsa86ujPiZ7gAteD6w5TTxPM2?=
 =?us-ascii?Q?rq8cSABRT/YKBYXkIxZaWBSH/T3OnD1UhhCzYtPdhdLfY7bX/ahEJ+WbmNmb?=
 =?us-ascii?Q?3nYG/uAmQpGqmmKiRo0ZPp+F4szm9KqHf7bvBqKN4KZ0gtlKUSrc48oPcrCR?=
 =?us-ascii?Q?nWMOZ2ZTqn140cTmTZkpx+Ueu9nPoRCM1GxBVpVQqUkZtcGPOgY9NHFxEb2Q?=
 =?us-ascii?Q?g/V5MyFSL6a1v59Wt2RbXT+zS86WgFvFeYZA3GikD6TqSjX0E5zHxOl9o2QB?=
 =?us-ascii?Q?s1wW8ZRMfIVf9ubNzu0RSp1YBTzJRaTdrpW/3cSEudjN/a+fxjwiNazuSF3O?=
 =?us-ascii?Q?yDR2tg82WSx7DpwrPmwo1mJ002BYyVaGvgpizJkMvMakcT1t4m6R877A8Glo?=
 =?us-ascii?Q?EVK5dwJGzn8JFxqwZbX6VMMW5P35YNtYNnIsOo69KVZUtDr8XEvn+WldxKpg?=
 =?us-ascii?Q?1ge3jlIfTIG9fx5TK0FZemuc7yVfBQS6y7ZmPiwTtHd8imt9AmHgb9xDyvWn?=
 =?us-ascii?Q?FYazAd6ACw5Gt3CyE57KvxM2dCnA6v72UxLdHdxL9eA6TzcqFo3gaGTjXS0C?=
 =?us-ascii?Q?mUwb4CmWFTFKAFZD6Ho34mx8Ryqy/PwHHeBrZHsGiCUWJDwMcrx/08DP9FKx?=
 =?us-ascii?Q?TdxAgbgjr0wnNz0PqsZbXDlOUX3se2NWHtqniWWylRUJQGfmvO7eha14W1JD?=
 =?us-ascii?Q?sgyJKSVF2blgTcI3igJbHAE2iNFVqbPjPS8VB5ponGqPz3f+mS4tMYC5Bq72?=
 =?us-ascii?Q?6FrXnA6K77pYRAk6nAlrbb92LP/1TdepdLyv8gALpxJGZSBCAkUMO9O/jTlz?=
 =?us-ascii?Q?q9g9LPWX5AR4ulj0iiocfMYAUMpu6eoAZMxo672sy8C7jfucwyFxxpob4Mzc?=
 =?us-ascii?Q?OJpunVQq7LyBP3DwIVPqEJvaVaB5Jpep1+4izRTsKIA7GxPrx4lwMJ7C9v41?=
 =?us-ascii?Q?gvpkZCPloQgtFGBxFMOg3ycpaBa0wJHmXG0S3HbPA3ZCUTsiM8R9ttjexNrU?=
 =?us-ascii?Q?s1JZWKgAPttVe9Y3fStKCbraBkdgPi4YDd3cvSSQRHdB3BV2uBoyR4YBcTYw?=
 =?us-ascii?Q?P7sNC8ULDKbI5XqhplsPIVpIajDsN9TGzGF6vGgpnqobaZwUrasQDxDrclV8?=
 =?us-ascii?Q?l7LLeoNy2geqqZkt+OQwBLlb2/85Dt1SJNPlaFb8lk6aT/r29jQna1uWEXjB?=
 =?us-ascii?Q?QRT7zjZSBEdIhqC6dVIACsPGx7vN1Oy9kQLsYdgrJuYcCDeRWVk8GPO42WGG?=
 =?us-ascii?Q?gcTyumhN8iWW9wf4wwzDpxYJicCmM65rf2EXQAy5/uK9DTRdgNXLRgLgeFqc?=
 =?us-ascii?Q?1ILRx9qQ66w35iegyl7mYHomL0Xc5rcEzSvWZAU0I8KYvv0vxUCjW4r3r6xp?=
 =?us-ascii?Q?kYjhzEVDWeIvMMB4YKYKUh6EVFWtgKGp8aKanfE/C2GYutxDgki1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b29f1914-f329-4f87-39e2-08df3f0424cb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:25:14.0510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQJnKrK1rBVVmBKXm3scDEg/WcJxyu2vvrzSE/vwCl2iMtV/ZLuM2zyo5qLTuUzhxx96TySNPoR7vlqAOx416w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3015

A vNTB PCI function can now expose endpoint-local DMA channels to its
host. Decode the extension and register the advertised channels before
the NTB device, so clients of that NTB device can use the DMA
functionality in the same PCI function. Endpoints without the extension,
or hosts without support for its DMA type or with no DMA IRQ available,
continue without DMA.

Only DW eDMA is supported for now. Dispatch on the advertised DMA type
and keep type-specific setup in local helpers. Support for another
implementation can add a new case and its own helpers.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v7:
  - No changes.

 drivers/ntb/hw/epf/ntb_hw_epf.c | 273 +++++++++++++++++++++++++++++++-
 1 file changed, 267 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index ff92c2a61ce7..e0016128b95c 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -8,6 +8,7 @@
 
 #include <linux/atomic.h>
 #include <linux/delay.h>
+#include <linux/dma/edma.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -18,6 +19,12 @@
 /* Offsets into the control region, see include/linux/pci-epf-ntb.h. */
 #define NTB_EPF_CTRL(field)	offsetof(struct epf_ntb_ctrl, field)
 
+/* Private DMA wire extension produced by pci-epf-vntb. */
+#define NTB_EPF_DMA(field)	(EPF_NTB_DMA_CTRL_OFFSET + \
+				 offsetof(struct epf_ntb_dma_ctrl, field))
+#define NTB_EPF_DMA_REGION(field)	\
+	offsetof(struct epf_ntb_dma_region_ctrl, field)
+
 /*
  * Legacy doorbell slot layout when paired with pci-epf-*ntb:
  *
@@ -71,6 +78,24 @@ struct ntb_epf_irq_ctx {
 	unsigned int irq_no;
 };
 
+struct ntb_epf_dma_region {
+	unsigned int bar;
+	resource_size_t offset;
+	resource_size_t size;
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
@@ -82,6 +107,8 @@ struct ntb_epf_dev {
 	unsigned int mw_count;
 	unsigned int spad_count;
 	unsigned int db_count;
+	struct ntb_epf_dma dma;
+	struct ntb_epf_dw_edma dw_edma;
 
 	void __iomem *ctrl_reg;
 	void __iomem *db_reg;
@@ -136,6 +163,213 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
 	return ret;
 }
 
+static bool ntb_epf_dma_region_parse(struct ntb_epf_dev *ndev, u32 base,
+				     bool optional,
+				     struct ntb_epf_dma_region *region)
+{
+	void __iomem *reg = ndev->ctrl_reg + base;
+	resource_size_t bar_len;
+	u32 bar, offset, size;
+
+	bar = readl(reg + NTB_EPF_DMA_REGION(bar));
+	offset = readl(reg + NTB_EPF_DMA_REGION(offset));
+	size = readl(reg + NTB_EPF_DMA_REGION(size));
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
+	u32 count, chan_offset, chan_size;
+	unsigned int i;
+
+	chan_offset = offsetof(struct epf_ntb_dma_ctrl, chan);
+	chan_size = sizeof(struct epf_ntb_dma_chan_ctrl);
+	if (length < chan_offset + chan_size ||
+	    (length - chan_offset) % chan_size)
+		return -EINVAL;
+
+	count = (length - chan_offset) / chan_size;
+	if (count > EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA(reg), false,
+				      &edma->reg) ||
+	    !IS_ALIGNED(edma->reg.offset, sizeof(u32)))
+		return -EINVAL;
+
+	chip->mf = EDMA_MF_EDMA_UNROLL;
+	chip->ll_rd_cnt = count;
+	chip->func_no = PCI_FUNC(ndev->ntb.pdev->devfn);
+
+	for (i = 0; i < count; i++) {
+		u64 paddr;
+
+		if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA(chan[i].desc),
+					      false, &edma->ll[i]) ||
+		    !IS_ALIGNED(edma->ll[i].offset, sizeof(u32)))
+			return -EINVAL;
+
+		paddr = readl(ndev->ctrl_reg +
+			      NTB_EPF_DMA(chan[i].desc_addr_lo));
+		paddr |= (u64)readl(ndev->ctrl_reg +
+				    NTB_EPF_DMA(chan[i].desc_addr_hi)) << 32;
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
+	/* DMA vectors follow the NTB link and doorbell vector block. */
+	return pci_irq_vector(ndev->ntb.pdev, ndev->db_count + 1 + nr);
+}
+
+static const struct dw_edma_plat_ops ntb_epf_dw_edma_ops = {
+	.irq_vector = ntb_epf_dw_edma_irq_vector,
+};
+
+static void __iomem *
+ntb_epf_dw_edma_map_region(struct pci_dev *pdev,
+			   const struct ntb_epf_dma_region *region)
+{
+	return pcim_iomap_range(pdev, region->bar, region->offset, region->size);
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
+	/* Install BAR submaps before mapping the advertised DMA regions. */
+	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_SETUP_DMA_BAR, 0);
+	if (ret)
+		return ret;
+
+	chip->reg_base = ntb_epf_dw_edma_map_region(pdev, &edma->reg);
+	if (IS_ERR(chip->reg_base))
+		return PTR_ERR(chip->reg_base);
+	for (i = 0; i < chip->ll_rd_cnt; i++) {
+		chip->ll_region_rd[i].vaddr.io =
+			ntb_epf_dw_edma_map_region(pdev, &edma->ll[i]);
+		if (IS_ERR(chip->ll_region_rd[i].vaddr.io))
+			return PTR_ERR(chip->ll_region_rd[i].vaddr.io);
+	}
+
+	chip->dev = ndev->dev;
+	chip->nr_irqs = ndev->dma.nr_irqs;
+	chip->ops = &ntb_epf_dw_edma_ops;
+	chip->flags = DW_EDMA_CHIP_PARTIAL;
+
+	return dw_edma_probe(chip);
+}
+
+static void ntb_epf_dw_edma_deinit(struct ntb_epf_dev *ndev)
+{
+	dw_edma_remove(&ndev->dw_edma.chip);
+}
+
+/* Common endpoint DMA */
+
+static int ntb_epf_dma_parse(struct ntb_epf_dev *ndev)
+{
+	u32 magic, type, spad_off;
+	u16 revision, length;
+	int ret;
+
+	/*
+	 * Legacy endpoints place scratchpads where this extension would begin.
+	 * Once the extension is present, malformed metadata is fatal.
+	 */
+	spad_off = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_offset));
+	if (spad_off < EPF_NTB_DMA_CTRL_OFFSET + EPF_NTB_DMA_CTRL_COMMON_SIZE)
+		return 0;
+
+	magic = readl(ndev->ctrl_reg + NTB_EPF_DMA(magic));
+	if (!magic)
+		return 0;
+	if (magic == U32_MAX)
+		return -EIO;
+	if (magic != EPF_NTB_DMA_MAGIC)
+		return -EINVAL;
+
+	revision = readw(ndev->ctrl_reg + NTB_EPF_DMA(revision));
+	length = readw(ndev->ctrl_reg + NTB_EPF_DMA(length));
+	if (revision != EPF_NTB_DMA_REVISION ||
+	    length < EPF_NTB_DMA_CTRL_COMMON_SIZE ||
+	    spad_off < EPF_NTB_DMA_CTRL_OFFSET + length)
+		return -EINVAL;
+	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA(submap), true,
+				      &ndev->dma.submap))
+		return -EINVAL;
+
+	type = readl(ndev->ctrl_reg + NTB_EPF_DMA(type));
+	if (type == U32_MAX)
+		return -EIO;
+
+	switch (type) {
+	case EPF_NTB_DMA_TYPE_DW_EDMA:
+		if (!IS_REACHABLE(CONFIG_DW_EDMA))
+			break;
+		ret = ntb_epf_dw_edma_parse(ndev, length);
+		if (!ret)
+			ndev->dma.type = type;
+		return ret;
+	default:
+		break;
+	}
+
+	dev_warn(ndev->dev,
+		 "Endpoint DMA type %u unavailable, continuing without DMA\n",
+		 type);
+	return 0;
+}
+
+static int ntb_epf_dma_init(struct ntb_epf_dev *ndev)
+{
+	switch (ndev->dma.type) {
+	case EPF_NTB_DMA_TYPE_DW_EDMA:
+		return ntb_epf_dw_edma_init(ndev);
+	default:
+		return 0;
+	}
+}
+
+static void ntb_epf_dma_deinit(struct ntb_epf_dev *ndev)
+{
+	switch (ndev->dma.type) {
+	case EPF_NTB_DMA_TYPE_DW_EDMA:
+		ntb_epf_dw_edma_deinit(ndev);
+		break;
+	}
+}
+
 static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
 {
 	struct device *dev = ndev->dev;
@@ -347,16 +581,20 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 {
 	struct pci_dev *pdev = ndev->ntb.pdev;
 	struct device *dev = ndev->dev;
+	unsigned int dma_max = ndev->dma.nr_irqs;
+	unsigned int dma_min;
 	u32 argument = EPF_NTB_MSIX_ENABLE;
+	unsigned int ntb_irqs;
 	int irq;
 	int ret;
 	int i;
 
-	irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
+	irq = pci_alloc_irq_vectors(pdev, msi_min,
+				    msi_max + dma_max, PCI_IRQ_MSIX);
 	if (irq < 0) {
 		dev_dbg(dev, "Failed to get MSIX interrupts\n");
-		irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max,
-					    PCI_IRQ_MSI);
+		irq = pci_alloc_irq_vectors(pdev, msi_min,
+					    msi_max + dma_max, PCI_IRQ_MSI);
 		if (irq < 0) {
 			dev_err(dev, "Failed to get MSI interrupts\n");
 			return irq;
@@ -364,8 +602,17 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		argument &= ~EPF_NTB_MSIX_ENABLE;
 	}
 
-	ndev->db_count = irq - 1;
-	for (i = 0; i < irq; i++) {
+	dma_min = dma_max && irq > msi_min;
+	/* Reserve one shared DMA IRQ when available, then give the rest to NTB. */
+	ntb_irqs = min_t(unsigned int, irq - dma_min, msi_max);
+	ndev->dma.nr_irqs = irq - ntb_irqs;
+	if (dma_max && !ndev->dma.nr_irqs) {
+		dev_warn(dev,
+			 "No IRQ available for endpoint DMA, continuing without DMA\n");
+		ndev->dma.type = 0;
+	}
+	ndev->db_count = ntb_irqs - 1;
+	for (i = 0; i < ntb_irqs; i++) {
 		ndev->irq_ctx[i].ndev = ndev;
 		ndev->irq_ctx[i].irq_no = i;
 		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
@@ -377,7 +624,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 	}
 
 	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_CONFIGURE_DOORBELL,
-				   argument | irq);
+				   argument | ntb_irqs);
 	if (ret) {
 		dev_err(dev, "Failed to configure doorbell\n");
 		goto err_free_irq;
@@ -610,6 +857,11 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
 		return -EINVAL;
 	}
+	ret = ntb_epf_dma_parse(ndev);
+	if (ret) {
+		dev_err(dev, "Invalid endpoint DMA layout\n");
+		return ret;
+	}
 
 	/* One Link interrupt and rest doorbell interrupt */
 	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
@@ -760,6 +1012,12 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
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
@@ -769,6 +1027,8 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_register_dev:
+	ntb_epf_dma_deinit(ndev);
+err_dma_init:
 	ntb_epf_cleanup_isr(ndev);
 
 err_init_dev:
@@ -782,6 +1042,7 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
 	struct ntb_epf_dev *ndev = pci_get_drvdata(pdev);
 
 	ntb_unregister_device(&ndev->ntb);
+	ntb_epf_dma_deinit(ndev);
 	ntb_epf_cleanup_isr(ndev);
 	ntb_epf_deinit_pci(ndev);
 }
-- 
2.54.0

