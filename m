Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792657377;
	b=emI1Sx/SmRWygGbwBOp7V4kcT24xvpE21o96z78KDwV7xTJhplv7QSXuhNtCRtXa8h09
	 cnXfl4sxHgTtOA5kMmNPcaYIwpanETIkz3+c5YPRagr7iXWWH6Dv2bzh1jlaRR3qQPMhV
	 rdMkIcmvoXYVD76myK4E83FUay++i5HMXaWu9NsS/sM0QuaK+KIaDYbsXVQUJLGTRwond
	 4lkakAmQj29HlbUnxQvOLhd/fid1zGsLEmyhJufkuNXLpa7fgcOpwLTK4dy87ZzvUmHvz
	 ct5EZNF80vdhovkl9x6hFodp6+VlxjBRC80f/ycbba1vJHw5qfMiJbqblzv3B+U8RHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657377;
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
	b=J8svnsW7071rZCtt5ePbhbslhLiswalssRYpTXpy+qTvQIhU1q1W8gcwhPBGVIvRNLNw
	 BztdG/ufakpHruLlrFCYtBzQIWNJHD1lsKPbwNBcyTIIDapMA3DjFotNxqlWNUuvAjEUa
	 3/EyZyYzmb7EGZwHxx1rrDTD5AxzBdI2IwHx562CBNCtODW7LhoeEKHVcfd9HQBeESv9h
	 T+IyGafEqG+NF2zYN9oLf38aEYnbjpPABNdfX+Foql2C+vN4qqRHFM9KxU3BwIcZqt1nL
	 JtTPpTi6g/XGo/4BOQl7zn25WXITUNm3yu1EEVQSL1JJWaBOlx2Uaol0x44vuvMU6yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=PHb6bXUq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB6606A328;
	Thu, 22 Oct 2026 08:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6BB6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=PHb6bXUq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbAEy5Pccuy4gIaIQYuzIBuWaxHl2337K8vBfzZmnsejnYriYQ9YALVEo3fEmCVuNyMXxJx5gqC8xsKXvY2cHFSr2plbxnuB3iM7OdDuhV8+d62/iUxDfA1GBmkd3vktk1coAODBECVkCERF6JpqgpFjSDATy/+xH0jms2PsNc5vtb7ymlZRSKLBE8amlRa8if2D6AfdKyMBsX+JERoEfG5xtqj7toImXgITzKtcwWsSCQbfp2/ThCAcsL8JQWUhdxvtoK6g010zr2kI5ATPWXo3tZnjlPH/D4W/PP3OV16Blz2I+Th/JkaSGpVi+5aPYE4/UJQ6yXBidXiKlyYEqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBQ/tCX1eKhdtsP58xUYKea0/qCMasmdUejy6LoooqM=;
 b=No5GcpzVugU+Su4/vupWqN6IdDoavfCxjTyhj0zo7I01KGa6fk30x9u+ASf8SEFhq9/rF+y/9EeyQCm51wmuYgazQ865w/oeGx8Hvz5LGIST6XXr721nbfizuta7lC2RoQfEpXtqKH+1XM14nysMU9T3PqQt3qWQS8sF9J/GCDzPb3pjLaJJgHO05dH1bXGrXeBSShFT+GRyJP6pUDsgRY3f2Gb65TbQPfs0J7EWcq5VqWQIyXwBFnRB8qNFEgLxPFfz2rT2rDyygvIl0peZLVNQdpzLLjTTu0TMbjFYxT9NmBjicF1rbjHG8ZS0UWpGOzIBTLCqLNvysQMtG8g8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBQ/tCX1eKhdtsP58xUYKea0/qCMasmdUejy6LoooqM=;
 b=PHb6bXUq2CR+BftAcM8PDzBek/qr7cA/W8/wuOKIA6YS7+cDBRAvllq9FQPi2xIpBZL3LUeSiz+nUH5oNmZvB3mBBpwu6f8m+IrG/wq/Wdg5o+b4/oLrrx4YTza0ye4+4AR7+LHnvj5nJepM0UsORLqY/RIjsf8oiGeBLXnHve0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5275.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:353::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:22:41 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 08:22:41 +0000
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
Subject: [PATCH v8 09/10] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Date: Thu, 22 Oct 2026 17:22:29 +0900
Message-ID: <20261022082230.3164834-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022082230.3164834-1-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e65f014-7fa4-4ee2-8882-08df3015a433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|23010399003|1800799024|6133799003|18002099003|10067099003|261021121427099003|22082099003|261021123027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	NVEAllAx4M4aAPl2fDGbjU6zrUZm+U1bRUx8i6Iejwr5ufiIT1HxUZZLeDWbbZ90eEstPxiiuf2onUt5QrhTKckaQ4XzrjlBh4OHEK5Q6VA6wWP1OUdSIBJ7m+L913q9rq0uqDV8Gwb4V4X9qbdebacQcSSjx8REQuwSGWmJLGCQnI/xnSqNv+TWCXdr6qLWl2GUPkFZmaA/Mcx7O+A3nxcs0Y+zPuHIkrsB5GxEbWBDku/gCrLjfDH3CQRUolRab1rSPPLObdYwjhc+Fgqi7xyoPwP0oeNJ+puH6DEzuE3Y9+MgsXWeXXjLavpPyuiFts8e8GKr+Fxmp8JBU4EveJGEzWKMk5bAhO9Y1OKfxm649WABdkynBuFpQIP6mnPaaRzR7b+/XCEwepHYXyyUR5g4w2RNMhGqOfGgjEPoPAVJhaxdE6qKgWDYV9OPIOmBrD1DW4SBT/nbUXdJwzQqqO3QntEA9VF0Sa+1H9Yv3QLGI/kbw+gmZTLdTbY2Ap1B0Y1w1CC0l41L3FoPWfbz8iavr2jv7Pn53lVkj8UV5lTLkds1fU5nmMZm8zNaS9MnhA36p1XjON5gzNLNk1I7kMyMYvTpGN8PI4j3nWE8VNglfQMpLr+Y9zShRkDNKWAyTXNBd06dbOJwt76ix4CzpeRLdRpaEetSFOc9Vr2Y1Pg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(261021121427099003)(22082099003)(261021123027099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W+aEjCTwRVfn8yG5k3MezqS3h9oYnmDEsPMEZJdiIK3355WTusUVQDLYQvxz?=
 =?us-ascii?Q?IqaJAa2i2QkF8iwb2GUimoOOoQ1i2DJcsVGEVgLk2UCGz43DfkBV1waWnJDM?=
 =?us-ascii?Q?c/sef8qegLGgIp6zXg4GLjpSr5c5j1SeRwIgP/chvJaIw6ZST5itlvhoJXnN?=
 =?us-ascii?Q?3/jMiJmS6UdaRxD7uubLQYL1mv4gnjy/gw4eFqCvt6pavVGldFohPwJyiS0N?=
 =?us-ascii?Q?KxcgapcaAr1BbOoZAiK9pdhnwIbLLqB/D70TJ+Z6r4lFYjnQSFoH9rCooZPU?=
 =?us-ascii?Q?YX8jw1h4btOPgV0ShYR8yNSl8jqEaz/OjClHGPTWcCaLhzdhB69cengvkaHg?=
 =?us-ascii?Q?Dn9av9DG4eWLBUke/M/Omc1mtd1vPW5sQwbyIYOSAfFcn8/ZSNIz1qfS5RWB?=
 =?us-ascii?Q?PGMYkiEXiOW1FH5f6LLdwVnC1XVGoUMcMwtXLHU9ZjWwgbNWVA2OITeZNdLL?=
 =?us-ascii?Q?KSF01HNTtIXO3OBHo1SqY/Yj0IpU23vLneBjxnOGeWOFpU4WqmcGAuDt3bY1?=
 =?us-ascii?Q?OvYxgOy1TngviwOGaDDymk2VcIHoEGS6zL+SG1Diy0j3otgfi2lN+TjfVxCD?=
 =?us-ascii?Q?77/TJQWtifjCWeGiMSjlILlGHLfCD/HbRjHHf+CvFwv487baQEj1K5Mu8aMx?=
 =?us-ascii?Q?opOYTgbjdgubPIui4qtK0FaXcGLlFN1OUXb7KUfsJD0KCHZCKi0NFqlii98k?=
 =?us-ascii?Q?5+cZXR5T+XrYCjq5ZA7o7WnEkWcS0jR7+9Kjv98jvuXe3MpaW3d5Ps01yqxf?=
 =?us-ascii?Q?gMrLWNnr+YlzqmGQQem23F8LIxbys3z4t9K4aR1lbSWHden3dV0UsJquXLvA?=
 =?us-ascii?Q?VB/+Mh89GP7Jl7FURVF7YkK8g/bcka4f4M3LTJ6iqU1h5pO2H++uqcFfpJOL?=
 =?us-ascii?Q?yQ+PBpII6pnofExKdtNhm90aJ604eOKFJuagvaMOKJJYDJVTLsb28MBSR+l9?=
 =?us-ascii?Q?+JrI7m+4CulqnkKW7JZCnLBNh+/oW0YzETGTtTs7wiucjmTLtL4LJrE/1lkE?=
 =?us-ascii?Q?u5/iDjHuS/eriPF1T3I5K/ZUHPcxUKGpLYZF2Me8GC2lwkwMc0h8eygHjAlv?=
 =?us-ascii?Q?DWA4vHp4PYLOG8SaS2LoEbflZg4tHYamgq7ZW6NdL4kw6byt9bkA4eWtPmux?=
 =?us-ascii?Q?7MSL2jih9Q6ke86WlGtecUP0r4gR0eBulZ/1sBBjbSiOQL/Xf+i3RtmiV7f6?=
 =?us-ascii?Q?cXk5VCIAcsZoh4RWRY6TNeqVdeH+mmdaYlUJcxbB1uSkfLF53daqKdHig+N/?=
 =?us-ascii?Q?WOWpq/vS/19E/bS0U7OxkBmTzd5FjFKGpMaGKVzsO4swaBVQcmSXe6iPki8t?=
 =?us-ascii?Q?z8Sn4e9TYGDoyFZwBPkznIpZVR+P409637qjuiGsyIsczsePmtKrSTDZEWlc?=
 =?us-ascii?Q?ipwBe+79R851ZlojSqoWGaFBTOuZCdpXaNbKb+wohciK5S732l+8eVAZIlm/?=
 =?us-ascii?Q?Y9aiWe5XWrKkwqz2dukXzSZ77vnyVgPLMT6mL/gdaKdfAz0PKqqIaCW1UL8H?=
 =?us-ascii?Q?Al0cWHB76yb6AS4rH1k7wiAtg9mfJbg26TB+z534TkJGvzPSkWcJdV3AxwC3?=
 =?us-ascii?Q?a4p2C7PRGUbId9psOwGp1qO41ajdFVmRWORuB8Q9zwMcuB2g8SMowDDP8t11?=
 =?us-ascii?Q?9Ryl0nl5H2fUXalzQBIl+Coo5N31eNr/7OzLIGb7JYhSpRehg9u/cLv++fgv?=
 =?us-ascii?Q?27db2eaKEAnX7AHLq4isZ4duzHeDQnz/zWq93tfjpPqDgZ0oor4h75xRuV1K?=
 =?us-ascii?Q?7Es9nAUHugAx6KWF9FD2JOYJtlXQc8I9y6vk56Dsw3Izyst6c/du?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e65f014-7fa4-4ee2-8882-08df3015a433
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:22:41.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvMmZOklN3h6nyjgcA7+XCXHA7M4DURHOIkgQD6f4yYpLu6TDrLBQqLTQIbo3ViSKcXuTVPHsWXwS9l7aL34FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5275

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

