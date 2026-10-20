Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792475405;
	b=ie92v2ggX66H8d8Mf4PxKzxLMGnQX3JBmukhfIBnDk+Rz0ej1yC6N5LABy1Os9qCNNNo
	 uK74iN/cLaP5bP3rySUOvV2iGOeRaZSqf+h9Sv2dF1+XXLJLI95ZugX79sX+NilMMsrPX
	 CwjSSsAw+7aqKEoQemG/Pkq8cF4N6aVOalVRl7E1mCzH4iHWw0dyy+pndHG6l66v43nOc
	 oN8NY8GCBhuZb1xP4gy33BEfM0zZwAXMmAn+IwC7OkBi7SUSBR5QEJvjzlakMXItT5+6d
	 Q+udSxIl0DZfHjrQyTVkqxnfkNxHbJ/Y0PU+IMx+xpNGvEJufR/um+/O5qYzVsx5/YA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792475405;
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
	bh=9SU9znR0uu14J+3zOFsOEuWT1zR0MSAWeQdPbTcoGJ0=;
	b=etFppK26qisoU/nfSzA8pa2JvOLKdMdTGyJ/JwndE+dlFlmvwWXVtJQk1SNV2Xcz8flt
	 JXN84iSQSGgTwwPQjX/e07QYkCJuZTyKqhErD3efY7REIzIQAkPl+ZqK6+r5pyarozJMG
	 LzbFUwL7G/4H44NIBFXo/Ytwv415G/ZS6wRf2Cn8DmQ8IONa5zpuEt2zi9d7vHwVRz2D2
	 xm9FeaFWdJ0crsZnyMiwcw/D8puEF0IGfRupX0GX+5S6j/AMLu0cozytxa8/v2SLqBnVv
	 IPAXrEhkZRpCBSr/5MM1sXz3tS4+QOigDB5JvmcW9L9gUEhxKfp04sWtC+ZUMHZTf+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="H8h/467o";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.140
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021140.outbound.protection.outlook.com [40.107.74.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393960A260B;
	Tue, 20 Oct 2026 05:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E393960A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=H8h/467o
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6tNzpspzGUaJPtho9sJSqKFjkB4pJHRG5n0YiGfbaieJGeRVp14uzw6P8yWZqOBnsM+ox0stunRsWQArcFyODcz5u6JlX6K0T3zLXKE7QisLRUm7037qezukeFWq7bRKWQfDfpfoBuk9ugccwpfutFaBdhywBEs4V/4x7SWSu/zP+rVy9uKUQiiRRX6t9xVuyG75VmEEJ1BOZ1akqfrW6OrIIVN+ly4GNX15l8TWR80f99WnDlg07SUdp5iW64s0/mWL51c16uljnB0XxV8DHFUOp1i1+s1ZeimjFAp9hbyAmucperEFT4Un2AXDjjSBITcuyZUSK+XHIyPyClPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SU9znR0uu14J+3zOFsOEuWT1zR0MSAWeQdPbTcoGJ0=;
 b=aDni8DrcTlBN0jljyvYrZB0x7wVvNx8NKGHVeBJg5pdrE8uodtFUNXEawWJfaSRwG/fGw+ZF7ipgKGqenrp0X1lrEdkxZSjkJWGboI+QLE6A25cZfyH38y0kSE4hwoS5ZohZmQfWYAE2Xh9/AIf/gRYnsHbJpAlrbfpLOe5hVIZbN1sd9sWdKJgAYhVMpNwwtVrzdTWdLoC8TRSM6Zm9xvxKPKpLW8rvFv8x0waMggtSM9Siy0bKfgK+84a6n8g3/u+5xFMLziMrOrv7EyP4eDrULM1d5XBnLkfuiaCo44xOF3hCl9GzUtXuNSaJ5nkLFPCbDzOaZqeFSsEKzJsReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SU9znR0uu14J+3zOFsOEuWT1zR0MSAWeQdPbTcoGJ0=;
 b=H8h/467owLXAVyaBAEYkdDIp6Gzst2QCYvAM7JUK9x2vA5OiugOx8AMXLAfeoNe4N5UEVc96NKFN8x3oySIATvt6tSDp0GQIUvdWEoF8ip84Jt3qG7GfC/l0nw86D/T+B1zjpFuLgveRE+175R7yCGcrjVdMMR/9axAN+c1jIWY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY6P286MB7913.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:49:57 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 05:49:57 +0000
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
Subject: [PATCH v6 6/8] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Date: Tue, 20 Oct 2026 14:49:46 +0900
Message-ID: <20261020054948.1218370-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020054948.1218370-1-den@valinux.co.jp>
References: <20261020054948.1218370-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY6P286MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 028f0443-2713-4a7f-050a-08df2e6df8de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	X6QbdCUgH9DniI7LBe0dILtP3aih/iP7je8gaK38LeMt7K+oY679m75lSNuVpq/3rkjhvOfW64TLGcK3M2BXCRfEM8tD8eNiHRzC9+QWcOTX1EqFy59z7GdlR5J3XYv1wux5EB2zFwD6RxOH0AE+kPdnGQxobsOVlk4aXrFWVd4XAVeLVXPhcSw8fqm0bKx/tRwjo8lmtE1wSzDNoLFMM5PHsVxTw1XbyoPf8/6NJs++oaUlMlYYjFXmGXpa5mQNzMuy1/MdfGwKk6OmxibmDhTwlBl6kOaG9GN7U9Ugw/LAThsCPjmbZAO2kGFEa3Hv+S/gX/BDRK0wpPPaQ4Tlwsaji/YY0Mu2etWvP+uLH0WOKhZPyo8smjtRkrYJrttH2jFaUW1otaGRFeGR8E+OkIqY+MSfL5QGv8L/2W2ATvaJKVwmU9ZYPIaBA7UqIXqO3PCJ8tXXdl2xqe62V2A+NeZLTaGHqKRBYPRlfzIMmhCIJ4b0chzcqk1MqOl9UNJAMoUt+kxoBMOFWvjMjhfhEdxUfJNVloLeADLktLeYQGwmhVfoFCjUCsYUAHPxgt6NVbXOLEhAmTH32/txMEtib9Xh99JtJDOvV65dvFCaToD7zv8NoDEQ6374GtSI5Ct7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SotsFyhtCQg7/kULm49648GWInczQvkyyfXJ2RJhZaqbjU3SHZo4M2nJWR4q?=
 =?us-ascii?Q?VS7PigVx290rh0/AMESpw9MxAiCqOfBkT4Avi0WHyQ5tm30ZUk0QKvjLT50E?=
 =?us-ascii?Q?HyltGOmkAyhwgfm/g9A25SwlSbKlYzIBSw0uAMPMCEjuP8M1pQ4XH/B9pWvq?=
 =?us-ascii?Q?IvJu1uuV+2i/9yh/SctIEemt9y3PDuHecPL7TowUWkkckAW8i+QtnqRxLc1e?=
 =?us-ascii?Q?RQL4E2L4jQj/Wk8fh/6Gz3uEzgnJeFhlcyGGDg6FAvL/wh3WW+Ase6Q/SxLa?=
 =?us-ascii?Q?3JbuE/SafWb4xRC5c04rnV2zjyYmsm56Ixrqa12PXA1/hL1TwjOpnr0TvGdD?=
 =?us-ascii?Q?P0Uu8Xctsf8iaMmVE52+UofuMnNbTrxNd2lwQ3BYrs6IeMB+dHmimxgRcdl8?=
 =?us-ascii?Q?TWZy9FHgIXacvdISiyb1ivs9Y6YNoaEV8/bjG2EXB1uccY0H2wb7JL+LsDxn?=
 =?us-ascii?Q?qTY2ooJctPaQU/a3WQoZjBVYIJuuUaOEFshaPpbiTycB4nezd/cgJucaSAZB?=
 =?us-ascii?Q?7lD5B3VpDfm30ekL4TDagXnSG90C93G06GbNtS83m3lKqVGwIc0l+eatWX6p?=
 =?us-ascii?Q?rjv7dLVynQt28MO77kv3L7gPxL85F7FJsg5lN48P9c5zHwYfKVCbu8WOudIf?=
 =?us-ascii?Q?JEIhI7ORKIUklHk9mukqgqVEHCtGejUZVOw+TvH6pvaGNkBnYbTQWGU5oi+e?=
 =?us-ascii?Q?y4uS88SVa6rpy84PFRn3EU4J1F//sIozUmsI9KzO2oJZuD4HOj19hAg5TcFI?=
 =?us-ascii?Q?g10PlyASN30h3t2cR0mQB4IYcP99VVdEIctsTonK+eTmern9LAGIGGlDT4nU?=
 =?us-ascii?Q?ad8Ys+tqXKMT8gnok9MQuwY0TID/PB42vrAZpWUa4l1M7WPfF5p67Ii8Xbyu?=
 =?us-ascii?Q?RNOZRiKIWcwdxaycNw1TBcMReu5piTd8KH5J/+PxMWUm6Rk6J3IU8sPT4Jh9?=
 =?us-ascii?Q?3JCKBARS9kJGmTMo05Pm5dGLcBvbuhwAky825u7gWGvPohUvw8VtzA5coGFd?=
 =?us-ascii?Q?SGw9l2GoNDbvx5tzwnGn8rIQFAc8a+YiItcdYxQbkcf3TCVKWJjTRgbKiQRj?=
 =?us-ascii?Q?8ntyWL9EyLYhjo+ivqtdI8YID1w6jHibizPRxxcl2oRjS7QRJjLanCtFvqFS?=
 =?us-ascii?Q?uq5tdAWlY6BtPCbSxJMnaPTUWjmZ3/sUNuvkPNW7I8BPDmUBIw2TM8qtnzwY?=
 =?us-ascii?Q?uKyWPUStTdUX6p4N9m07A7WNZtwF2PaApM5aGAWQKzWLuGhuASJsrYrNZiWW?=
 =?us-ascii?Q?i1qYXMqeG6BDhxw4GPkx0Wv9T0sJydoboMjWXKd7cRs3LfxPde6b5sLsB2bF?=
 =?us-ascii?Q?SijJOLx18rCLXfsvCXsxmBdPjEekM6LHr2b71OqH/ToDtscZ4P7d4MzPKviX?=
 =?us-ascii?Q?k5oNB7INGIJSPzy7YeugM4vMbOuJqRpa/AcfBJSyaVIcCnsJGDp1Ay41ENqC?=
 =?us-ascii?Q?e9uAzWSAVF/BRlbKlaZu+I5+AlB35G5gwt+/gZUNP8EHBJphsdRZGPU9N74J?=
 =?us-ascii?Q?LQlkO1wQCRoEkav7s6GAnkd2o9r/v69V18arm2Q4sZIEo5rNocvZC+ZnFG2u?=
 =?us-ascii?Q?biXp/lti1fxi4WmwUWQWMfwzqNQo+Pjz9NtMP7A3U91ZH/ot+Z366FnAnxyX?=
 =?us-ascii?Q?EsGqZiuAZ7AOAKTgv0mKQI4GYxvgyIHbtO6PaAYC4cM+Yq/no3qD3m4RhyzE?=
 =?us-ascii?Q?GxEO0kOrK4lFIHcdRtHLZwW/TgaYPn8jFuzjh4BFs1bAMpBRwcpMnIyJLcKy?=
 =?us-ascii?Q?GCnnCGunbNiOg+QngFgRvWuprjyyudLUNjqBqbSxdl++sKEbP4hF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 028f0443-2713-4a7f-050a-08df2e6df8de
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:49:57.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +495uyTykI69AKwQJLuDvEBIMyPUDlI4aAX30nxONyPF7PbgulVgKdv/h/MyFpJA5+hzW5ogWyXx5+1P1BsMqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7913

A vNTB PCI function can now expose endpoint-local DMA channels to its
host. Decode the extension and register the advertised channels before
the NTB device, so clients of that NTB device can use the DMA
functionality in the same PCI function. Endpoints without the extension,
or hosts without support for its DMA type or with no DMA IRQ available,
continue without DMA.

Only DW eDMA is supported for now. Dispatch on the advertised DMA type
and keep type-specific setup in local helpers. Support for another
implementation can add a new case and its own helpers.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v5:
  - Derive the control region and DMA extension offsets from
    include/linux/pci-epf-ntb.h instead of hard-coding them. (Frank)
  - Move shared-MW boundary handling to the BAR-sharing patch.
  - Link to v5: https://lore.kernel.org/r/20261009045949.1109871-7-den@valinux.co.jp/

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

