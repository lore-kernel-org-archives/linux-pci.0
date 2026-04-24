Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1912E7F2C;
	Fri, 24 Apr 2026 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024192; cv=fail; b=j90KP0z5wtfnFPr8Bs75OQSaUJbTGm6gJYzNLaFCalp6kNOQM33HGqJ1TOmD1SdYYZdhMsgcs+N2ycahxfovluszXLjqUwneEVI+IeGDNZt6dv1YB/vx8Rndd3R/OHNFTPs2UjzQ7zJ21B8ZEW+/yByWIPaueyQSQeuShFKuP6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024192; c=relaxed/simple;
	bh=Ng/s2NlM42ldA0DZEhSS1Of6ltzQ5H1taeBTpi17PSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=udh58wSPyW7UkiyIhbF5ilD2R15sidsnGW9OknTKAdfmS4wO71b+XH0WSsyNZ45D633PztF5r+vUsyd6+p23iCYHdEEFFro9XbaO+gA1Nvk2NkXHOT0X6FYxyFQl/llebRZeOmgDyqTT4kKcs+vvlXy3phSJfRoJPys/AQbYipU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=OmDvUrYW; arc=fail smtp.client-ip=52.101.61.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="OmDvUrYW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylWc+U7DWbcmvooQEyWrOjWkbfx7kx86rh9RwnpqyzvG/V41Awgb7n7n6mczQ5YAcZUjfwFcWK7FP4aXqQpOlqpxEflgGo6M3mQHibs7zRpNFh0Z8OCV21kwM9dJYpDfJeE53CbellnugS28pkCHTaK49Sr2mGoNdR5o0CGVLH+vg60DXoBx92nazZKKwDoniIwpNe9g0w5qr8Ame19FSHWenjZkEZbVdxehzqUGzeqxfu7cuHa6fGGu6kSDFxSGGRQIaznOEl+UViPjZSVUpEFQqk+6Km+Of4xXZEJIxd3pXvYWbghbMGhcEsQGFZG+DTJ+iItU6A/g+RQTG7DrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYcZPuJUiUMn8O5FaaFRMfVOYqdut+Lo4+vloT2MdK4=;
 b=FpPsjmFOIabSne4jjcvh8ow+xAEEZymHkUDjuyeG41QPm9SlBQ8kiYYN/mAFRIn+GPjvdsgNu44JaQesW1Vbplj7EN8ph1GfjthXTipiDtRaUTzcppmb17ixkpDlBHW0fUWXiqq0pFiQ8WRAhYjcpsWhTa6NPfvYAQwf0Tscn1iFeRxPXmkKd+BhpeUvdhySY/rupLkW12K3wGxs+m804c4o8vou8ODsfwbPhdqmrg2SVRM+aaEY3HmKx8xIP5ScI6DexavT7ybu/9jJsedkjM6YR0uaRjsHd2INAjAyXARCZ9qFVQhQNfazlhKdMoIYB76n89WkQAqSt4V42RakqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYcZPuJUiUMn8O5FaaFRMfVOYqdut+Lo4+vloT2MdK4=;
 b=OmDvUrYWf7REB1f0sea2/Pgui4eYd5YfDGZMsa2WFLI0DN9+jPiZUItDjfKMpeLRVo3RHBg9IHMxjloB0PYebxt/jPtDO5pVBxxV5ZMdOMqX/4WzLh4JNQsZ2uGsVQhDY3SAYA/WmbsemlPkfH3kdc9gWuJOSjvaUobNzT38qDgW94JzNtQKFl3hDlLBZBn+8zHtV7UYtAGhFXf90zA7XMUYv0D25LPrSBQtAuxTS0o222KkwwfIfl3CJVUYBHFtZfy59qlcno9GhW4Zu8XKPVAFGzOo/PrUXSMgOriPkkJKLVjdheOVA9TkJ9h7/cmAHzIPTrk4XZnjwxUfAe6xdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6498.namprd03.prod.outlook.com (2603:10b6:806:1c5::7)
 by DM4PR03MB5982.namprd03.prod.outlook.com (2603:10b6:5:389::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 09:49:49 +0000
Received: from SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc]) by SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 09:49:49 +0000
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
To: joyce.ooi@intel.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	subhransu.sekhar.prusty@altera.com,
	dinguyen@kernel.org,
	Mahesh Vaidya <mahesh.vaidya@altera.com>
Subject: [PATCH 3/3] PCI: altera: add Agilex 5 support
Date: Fri, 24 Apr 2026 02:49:13 -0700
Message-Id: <20260424094913.522123-4-mahesh.vaidya@altera.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424094913.522123-1-mahesh.vaidya@altera.com>
References: <20260424094913.522123-1-mahesh.vaidya@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To SA1PR03MB6498.namprd03.prod.outlook.com
 (2603:10b6:806:1c5::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6498:EE_|DM4PR03MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 495f5240-2992-4b9a-66ee-08dea1e6d319
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zKt4Cn7eSxBSVmAH3MHxbIAh2kplcSZEo1cVY/IPeW1O5khTiCaxI6Oq5FLplALqBs+T3IHW5poIcTGAfGbR4/ZFGmy5gkK76PNtGPDxCgBiclc4uOZwC4v3wH6LlD9NaZhwT2Ap1j2FgmQlYNahaHJ2Alinzc2dLFMTpiSv48WT+2Io1qbruJOW3TknhyN6OmY87Qsmlucu6X/utZf0i5MTnWkAZKIMKdbOdBTuDcJA6Drlf/CykNdwugtiLPFvzhnfNO4bZYriGoeoSyeL2sRys8U4+U6HBO9TRe4FEucruvmwC/vtUe9KJXudRfuNUk0s5JrZiD/9L1zY825oVEHNAsVAJDIwiZN/RpLFcjEgEc74Vy2lCV8QuCUID3Ob6gfhkyrybs6YbvEkKBIW1iM4Rh6byA3D7Zl/56BsHRr0xGdynySjXTZmCMtDhO974vdVgHjtl8kNzXp6/Mlm9ZFno5QT3XEya8GEF+2BYS13sozhiCrqp+fK5+7nUy5xirUoW/td0WGgDZ67TiLPSh+SXfkC3l2eGlzaedR03K7BxEE7OourCHofU5LIOkKyBNvkgBtSKOMMJercOgeF7grF8HzpDuY4xmfSQESDAz10RvJmFcQ/kUeNVzvVjoIyuoBwRr88/+jWajOW3yrxotGTEfhNXRvDb0ljq+ACMWCBpIMyVAGnspHWy2h/0HvEHORIGf5eFj+ZpDVMExNNPNujdvvsA69t4ONqil+I9xE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6498.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xPqBxTHhyB2gn5HEdQkikKR7cVos82ul/CTAZvajxKg/KwMKEM8t53Bcvx8+?=
 =?us-ascii?Q?bzQBazUokWuJQTdpjIsfav4jeiK+cXQFIOqETv4wWvoWbX91I1Ie7RBrNzmt?=
 =?us-ascii?Q?Y7rA9CdjCAXYZSHNvcl4I1HCmuWyqrJxEKKK6vdUh3gvhBR4MGKvPfrst9B1?=
 =?us-ascii?Q?Fp/PNNkEZ82g7Gr6yyqcUjDG2KvRXj7s+iWfdVWK8sRMa2H5icFEkvrv8fmO?=
 =?us-ascii?Q?WCeUPhMX9U8gjpBDDhnEoOQmyh/J6BWWoAN9LW8LwzK76jxPpLaH/KpOJyIr?=
 =?us-ascii?Q?HbCgJm7YA9wdXcqDlna6cLfPj4g5hvXse0kvSnKgvdrQZH3JMOdz/v1VDoBb?=
 =?us-ascii?Q?kGAuad049xOWaGcKL0q6tg3E7SA/a4yVnN8gizpY45r/WebcvTwt8HyVz8YS?=
 =?us-ascii?Q?rfXuDrLCEYqaEvnBg0146oSJH/U2N+n8b3qfwNkce9uhwF4XB2WfK6+C3cCd?=
 =?us-ascii?Q?YWk6uJ4Ksnz8mymE7Zc9Lj2pWUAh2EoX2RlHz/lRxJ08wXeeeWp86crqNfOX?=
 =?us-ascii?Q?nXqSx934wTPxfUjL1z2LKN2kaW+8GnfO1UReT/IxP/S9IH3X1FLWI6o071JV?=
 =?us-ascii?Q?XR4bRlLVKbSe5VM8HvnnEb5IdmKl8dnXhUPYTfHzffWClhTBJj3x7EoTehTm?=
 =?us-ascii?Q?20238K15nYE5On0p785Ima/XAyZ3vA7dkHejpFUTBnWugPhdA22vL1cJqNpO?=
 =?us-ascii?Q?5gYtvYnQCBanZSjALIs5h8uo5IvucpQXGy7PihyFIPdCismwAhlxV2YuLXCs?=
 =?us-ascii?Q?biYhrdDdKKqTKXnl544eWWmjYnKBV2lDJ8A3coVrrYAgbX5bgq2bDqo0xn66?=
 =?us-ascii?Q?XwmOVLGQufYlMVphaRnPuOcPEDZsZQ8arhcpHQgz/lVB/DOXL5w2eeGraltA?=
 =?us-ascii?Q?EVoemQ4VVcup1HYCr2XOgvvFZ4t7G4DQgQ/+B8P6Z+yEgHynyFkxXTr03stU?=
 =?us-ascii?Q?ELotPQj6hpagFe0l+tojkh8MwHrVHQLidyws5kXwe3rUp7gao9EwgRZejJ65?=
 =?us-ascii?Q?oSxJTsjYZMVbf+ZIv8e5K76j5hCqc8WatVVACrIREBGlBwKGWfnuamHdSf6D?=
 =?us-ascii?Q?rivSxTs9yzD326fqy3afCOgjeMiBhXnp0eYuyh6ngv5dXbcnKSvoTS+WViNK?=
 =?us-ascii?Q?D/z5MQmyJ/XijyeVDn+FlFq3YcXINfjbNnh7l3FT+DvFFKas9ipDAzZRDke7?=
 =?us-ascii?Q?kqNylIUfUIm84O98RgfLBqTTsW8S67p53AUeTns2Ho0uacb0H3QF8R+bzKxg?=
 =?us-ascii?Q?Rxu4kEcJj9BIWxINPH1zPQ0eNv0KMo/qpUgzjCIkSMWZ3s9wj5v9AdoQ+bX3?=
 =?us-ascii?Q?feaTUxjZQASU625TOKaHJhUMTkcLforxGUwKO8nCflpSpvOnYbDcDWX8BaH4?=
 =?us-ascii?Q?vFL2bOGQIQB0GNgILkaoN49SbECmDJng+Nq5oxIHOyIqyLsEyZR9GMdiiYIr?=
 =?us-ascii?Q?AQz/GIaRUqc5i7bZf0ZWfnBvR8HUnRxFgmnBola5jCHYcxn8693V20U9FAuE?=
 =?us-ascii?Q?E2Mhx2el8euwYIx5Wrsj7h2DVp6pkzDOlankuANfQeKSKhdme67QoILDa0Np?=
 =?us-ascii?Q?CbGQWw2bOTKruwt28djZ8gC1D8GY8NwuGgrDKKdlq2gjWe5kBDHPVb9A/z82?=
 =?us-ascii?Q?550kc8AdkWHn4W2R9A1dKaD4dnYgsq4ZFGGMDBkXBfx4N9FTlNmPCptPnB25?=
 =?us-ascii?Q?IcFXXIGzI0UCGtwr6mOuIMST2/Z/Vxn8S+y1fUmntLwF49eFWvO1kUu+Dm7q?=
 =?us-ascii?Q?72nZZA6uXg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495f5240-2992-4b9a-66ee-08dea1e6d319
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6498.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:49:49.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyjYr1LpDPtWXAO/Jn0tYur7U+uTCLPjSgbBQR7s7N1FwXZvoZ+nV72sk/Ks3YhDlJu7mGI1UBzWc7DlS8MoLOxCpLF70KSdJ9cm+3pXYSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB5982

Add PCIe root port controller support for the Agilex 5 (V4) family
of SoC FPGAs.

The Agilex 5 PCIe Hard IP reuses the same config-space access path
as Agilex 7 (V3). Root port and endpoint configuration reads/writes
use direct MMIO to the HIP and CRA regions.

The difference is in the HIP port-level registers (IRQ status and IRQ
enable). On V3 these are directly mapped through the HIP MMIO window.
On V4 these registers are only reachable through an indirect access
mailbox (CFG REG IA CTRL) in the PCIe Subsystem AXI-Lite interface,
documented in the GTS AXI Streaming IP for PCIe User Guide.

This adds:
- ALTERA_PCIE_V4 version and platform data
- Indirect register read/write helpers using readl_poll_timeout_atomic
- Chained IRQ handler (aglx5_isr) for the V4 interrupt path
- OF match for "altr,pcie-root-port-4.0"

Co-developed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Co-developed-by: Peter Colberg <peter.colberg@intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
---
 drivers/pci/controller/pcie-altera.c | 156 ++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 025ba74d1ee2..db8149d84c96 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -12,6 +12,8 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/init.h>
+#include <linux/bitfield.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
@@ -93,16 +95,36 @@
 #define AGLX_CFG_TARGET_LOCAL_2000	2
 #define AGLX_CFG_TARGET_LOCAL_3000	3
 
+/* PCIe subsystem indirect register access */
+#define PCIE_SS_IA_CTL			0xc8 /* control register */
+#define PCIE_SS_IA_FN_NUM		0xcc /* function number */
+#define PCIE_SS_IA_FN_WRDATA		0xd0 /* write data */
+#define PCIE_SS_IA_FN_RDDATA		0xd4 /* read data */
+
+/* PCIE_SS_IA_CTL bitfields */
+#define PCIE_SS_IA_CTL_INITIATE		BIT(0)
+#define PCIE_SS_IA_CTL_WRITE		BIT(1)
+#define PCIE_SS_IA_CTL_BYTE_EN		GENMASK(5, 2)
+#define PCIE_SS_IA_CTL_ADDR		GENMASK(31, 6)
+
+/* PCIE_SS_IA_FN_NUM function types */
+#define PCIE_SS_IA_FN_TYPE_HIP		2
+
+#define AGLX5_INDIRECT_SLEEP_US		1
+#define AGLX5_INDIRECT_TIMEOUT_US	1000
+
 enum altera_pcie_version {
 	ALTERA_PCIE_V1 = 0,
 	ALTERA_PCIE_V2,
 	ALTERA_PCIE_V3,
+	ALTERA_PCIE_V4,
 };
 
 struct altera_pcie {
 	struct platform_device	*pdev;
 	void __iomem		*cra_base;
 	void __iomem		*hip_base;
+	void __iomem		*controller_base;
 	int			irq;
 	u8			root_bus_nr;
 	struct irq_domain	*irq_domain;
@@ -849,6 +871,98 @@ static void aglx_isr(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+/*
+ * Indirect register access to HIP registers via the PCIe Subsystem
+ * AXI-Lite mailbox, documented in the GTS AXI Streaming IP for PCIe
+ * User Guide. Called from chained IRQ handler (hardirq) and probe
+ * (before handler is installed), so no locking is required.
+ */
+static int aglx5_indirect_readl(const struct altera_pcie *pcie,
+				unsigned int addr, unsigned int *val)
+{
+	unsigned int ctl;
+	int ret;
+
+	writel(PCIE_SS_IA_FN_TYPE_HIP,
+	       pcie->controller_base + PCIE_SS_IA_FN_NUM);
+
+	ctl = FIELD_PREP(PCIE_SS_IA_CTL_ADDR, addr >> 2) |
+	      PCIE_SS_IA_CTL_BYTE_EN | PCIE_SS_IA_CTL_INITIATE;
+	writel(ctl, (pcie->controller_base + PCIE_SS_IA_CTL));
+
+	ret = readl_poll_timeout_atomic(pcie->controller_base + PCIE_SS_IA_CTL,
+					ctl, !(ctl & PCIE_SS_IA_CTL_INITIATE),
+					AGLX5_INDIRECT_SLEEP_US,
+					AGLX5_INDIRECT_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	*val = readl(pcie->controller_base + PCIE_SS_IA_FN_RDDATA);
+
+	return 0;
+}
+
+static int aglx5_indirect_writel(const struct altera_pcie *pcie,
+				 unsigned int addr, unsigned int val)
+{
+	unsigned int ctl;
+	int ret;
+
+	writel(PCIE_SS_IA_FN_TYPE_HIP,
+	       pcie->controller_base + PCIE_SS_IA_FN_NUM);
+	writel(val, pcie->controller_base + PCIE_SS_IA_FN_WRDATA);
+
+	ctl = FIELD_PREP(PCIE_SS_IA_CTL_ADDR, addr >> 2) |
+	      PCIE_SS_IA_CTL_BYTE_EN | PCIE_SS_IA_CTL_WRITE |
+	      PCIE_SS_IA_CTL_INITIATE;
+	writel(ctl, pcie->controller_base + PCIE_SS_IA_CTL);
+
+	ret = readl_poll_timeout_atomic(pcie->controller_base + PCIE_SS_IA_CTL,
+					ctl, !(ctl & PCIE_SS_IA_CTL_INITIATE),
+					AGLX5_INDIRECT_SLEEP_US,
+					AGLX5_INDIRECT_TIMEOUT_US);
+
+	return ret;
+}
+
+static void aglx5_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct altera_pcie *pcie;
+	struct device *dev;
+	u32 status = 0;
+	int ret;
+
+	chained_irq_enter(chip, desc);
+	pcie = irq_desc_get_handler_data(desc);
+	dev = &pcie->pdev->dev;
+
+	ret = aglx5_indirect_readl(pcie, pcie->pcie_data->port_irq_status_offset, &status);
+	if (ret) {
+		dev_err(dev, "timeout reading IRQ status, masking IRQ\n");
+		disable_irq_nosync(pcie->irq);
+		goto out;
+	}
+
+	if (status & CFG_AER) {
+		ret = generic_handle_domain_irq(pcie->irq_domain, 0);
+		if (ret)
+			dev_err_ratelimited(dev, "unexpected IRQ\n");
+
+		/* W1C: clear the handled bit */
+		ret = aglx5_indirect_writel(pcie,
+					    pcie->pcie_data->port_irq_status_offset,
+					    CFG_AER);
+		if (ret) {
+			dev_err(dev, "timeout clearing IRQ status, masking IRQ\n");
+			disable_irq_nosync(pcie->irq);
+		}
+	}
+
+out:
+	chained_irq_exit(chip, desc);
+}
+
 static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
@@ -880,12 +994,19 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 		return PTR_ERR(pcie->cra_base);
 
 	if (pcie->pcie_data->version == ALTERA_PCIE_V2 ||
-	    pcie->pcie_data->version == ALTERA_PCIE_V3) {
+	    pcie->pcie_data->version == ALTERA_PCIE_V3 ||
+	    pcie->pcie_data->version == ALTERA_PCIE_V4) {
 		pcie->hip_base = devm_platform_ioremap_resource_byname(pdev, "Hip");
 		if (IS_ERR(pcie->hip_base))
 			return PTR_ERR(pcie->hip_base);
 	}
 
+	if (pcie->pcie_data->version == ALTERA_PCIE_V4) {
+		pcie->controller_base = devm_platform_ioremap_resource_byname(pdev, "Txs");
+		if (IS_ERR(pcie->controller_base))
+			return PTR_ERR(pcie->controller_base);
+	}
+
 	/* setup IRQ */
 	pcie->irq = platform_get_irq(pdev, 0);
 	if (pcie->irq < 0)
@@ -924,6 +1045,15 @@ static const struct altera_pcie_ops altera_pcie_ops_3_0 = {
 	.rp_isr = aglx_isr,
 };
 
+static const struct altera_pcie_ops altera_pcie_ops_4_0 = {
+	.rp_read_cfg = aglx_rp_read_cfg,
+	.rp_write_cfg = aglx_rp_write_cfg,
+	.get_link_status = aglx_altera_pcie_link_up,
+	.ep_read_cfg = aglx_ep_read_cfg,
+	.ep_write_cfg = aglx_ep_write_cfg,
+	.rp_isr = aglx5_isr,
+};
+
 static const struct altera_pcie_data altera_pcie_1_0_data = {
 	.ops = &altera_pcie_ops_1_0,
 	.cap_offset = 0x80,
@@ -971,6 +1101,20 @@ static const struct altera_pcie_data altera_pcie_3_0_r_tile_data = {
 	.port_irq_enable_offset = 0x4,
 };
 
+static const struct altera_pcie_data altera_pcie_4_0_data = {
+	.ops = &altera_pcie_ops_4_0,
+	.version = ALTERA_PCIE_V4,
+	.cap_offset = 0x70,
+	.port_conf_offset = 0x14000,
+	/*
+	 * Unlike V3 where IRQ offsets are relative to port_conf_offset,
+	 * V4 IRQ offsets are absolute addresses in the HIP indirect access
+	 * space documented in the GTS AXI Streaming IP for PCIe User Guide.
+	 */
+	.port_irq_status_offset = 0x1414c,
+	.port_irq_enable_offset = 0x14150,
+};
+
 static const struct of_device_id altera_pcie_of_match[] = {
 	{.compatible = "altr,pcie-root-port-1.0",
 	 .data = &altera_pcie_1_0_data },
@@ -982,6 +1126,8 @@ static const struct of_device_id altera_pcie_of_match[] = {
 	 .data = &altera_pcie_3_0_p_tile_data },
 	{.compatible = "altr,pcie-root-port-3.0-r-tile",
 	 .data = &altera_pcie_3_0_r_tile_data },
+	{.compatible = "altr,pcie-root-port-4.0",
+	 .data = &altera_pcie_4_0_data },
 	{},
 };
 
@@ -1035,6 +1181,14 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		writel(CFG_AER,
 		       pcie->hip_base + pcie->pcie_data->port_conf_offset +
 		       pcie->pcie_data->port_irq_enable_offset);
+	} else if (pcie->pcie_data->version == ALTERA_PCIE_V4) {
+		ret = aglx5_indirect_writel(pcie,
+					    pcie->pcie_data->port_irq_enable_offset,
+					    CFG_AER);
+		if (ret) {
+			dev_err(dev, "Failed to enable AER IRQ\n");
+			goto err_teardown_irq;
+		}
 	}
 
 	bridge->sysdata = pcie;
-- 
2.34.1

