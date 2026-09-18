Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F934078F0;
	Fri, 18 Sep 2026 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701657; cv=fail; b=jaCQ4jG/VA3XjTkhZhIM4BbKIb8f4dIFJB25b4Mbx04NsLFqIWDDHVH42e8XgNsr1yAUCxz1X8TWVP4lxmYFYLSvBDTrEGFdsA91gn4iBecR9AAYo2nSDSSsFgq2L+gVYAvvCuORuZK5NY9BWwx1XpASXdSVOGMX9LPJJOpIIK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701657; c=relaxed/simple;
	bh=FZvvP3e0dTS86NyCGPmvhh08Oq+FvsqHRUgo/zFu1YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sx4eXL6VRS1MPPZ8E0hhZjWFh9ztyrb0sUI7wEzvAGmcI5jvnRjQ0kPEuAhYMfRw0XxVl14rUZdfgu+bfqmhCziDyALy53ZdyL97zzOOB+intpp1I4sreEqIbkx10mOHph0iv98lXtrhX9Kv0KNjWsKF60+vibIWk36xGxZOr8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=WYUaIyy9; arc=fail smtp.client-ip=52.101.229.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="WYUaIyy9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgifsvPYlSlSX5oeuYffMpVwzOzUzQ4vkEYzZ1FNaDctIBF1ZPIYdjmhGWyLS2XUaiMJ0Vc5llC5etMlkgu75X/A7NWRlfjWe+0lwQe1NgDjsnM3/0KgY0CXoUHlwfgIz27Ky4SE1nQZJ1EuPz1hdOvnBT90zPvUT0wDO91QWBaKrOMafABgzDHdwYNqrY7rcv7fU6VIHiaYM0t0x7M6B6JL4LCJGTHIfhXEV38+WK20kl9wxT1Bt05EAsqQIViSIWc79z/nDfbfeMvsZuseN3X5VBVyxmmRNYvS77aNMlN8flJyIZi2KLZEv8eANSDVbcPFdun2fbfIi/OWzaidyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtzDgSIaxd2uF+17EPu7uWXA54ASaCytyxzls2aNRB4=;
 b=C+l3/i/5mG7i6A5C9R6cJ5vvYIblBtGCEGxu5y0rHXmqIatIxHQBh8fWgLaMCmA/ZtrjqgSM0MBMB2a95mZKztfi6C5tyfH8zgoSJEt07i5FgoLoxFu/CVU7OEQ12TBw5Tli1m2Bq88Y763FWrWzQa+waw/g6A7jHuFdsJwL6jkFk6msX6eqsfAKVEuS8kpOV9Yib3K9dhCrrUWIuQrHnxaxHudMHwxMVsCVJEzdJhH6QK2tjjGCNtTIDrf7dPTq7tO68QOuEU1R6FvyZE+EZitJclQ21MHFNxt945m1t6vjU4YhBPbdvn4TwfU9fXqHAXx5fuYqQ3PBQy52tvPvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtzDgSIaxd2uF+17EPu7uWXA54ASaCytyxzls2aNRB4=;
 b=WYUaIyy90nDWfTkXpBv6JRlgXOXcaHGiY0h1mrclq9BojsQc6/Ia3EvxWYStsW+YBmVEdmZG37ICVwOsXwfBwwrApmETqXQUivM03D6uGVnIfbqz0ZaLyWo6ibarNFj6mNEI5+djk/GZzVGKqgfRQDvI1TvhKzbpvgBUqtynPOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5141.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:350::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:20:49 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:20:49 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] PCI: rcar-gen4: Recover the Root Port on link down
Date: Fri, 18 Sep 2026 12:20:34 +0900
Message-ID: <20260918032038.2216471-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260918032038.2216471-1-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0301.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db8c246-682e-47f3-c34c-08df1533d67f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|7416014|366016|56012099006|6133799003|5023799004|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	9RHCpXYYd4/orV3T7mhYyltiEkHUQn9hNkOg03rtzmCTEcX7t1wI9LgTjI+1zgKwFWDkkWr/CPRkX1u/3CxAbaE3uFg4XiRyx40NAJzRNN4InrNgRX0wv737shIsAJ8LyGzRO2pVp/TtaHfFPjuPhBVJgv3ZhqthmJczNhTbY2SkGAJfPU23z2WMz0m6RNGOH2AWSluhmzydMXsIoijFPo+QgHc2fuThFaNp7BZEOEI8ypHTumuUNU0qBqB+dczQB8Sl8/nT/G8voGj3J9LXlj4CBHM96kSObqM7m1Qpv9pFXrrUNn8ZWgudg7EjxqjVqe/EA2/zUPwOixDJMGyc8zZyypUnbTSAyrzZZ+DvEOWrctb6b7gJS67KxjSynosrOMw2OiJC8dX8LSm29q0QUr8O2vmf2/R+a4rLXgIIBQPrTUtLbv4qHmbYhF0j22bcP1jkNyVhlftCN0bMz55eX9Wsa/aebsg9NvE/1fqv73kCvMc41A+/vSF2NAIDZs/YlhXxv5z5nyp2//5udR+VaWXFbXR5WfMVVxpL5OQJhaj31D5EKH8sYOpJzR//jQQ0IxQYxHbuJHg4uhIbobuklG9E12O9awEp1IP4lG2X7MIwqh5c4K5jYIZC2EKyRMd2mr8XodpWzNU4HidS02bjOgLis9SGgf3BE+hP9/d4HM2Hi/Xf64CKpbCoccBwMkhCttruDsmmCPXaxEdWihIPug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(7416014)(366016)(56012099006)(6133799003)(5023799004)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9uoceAdYUpNzJkoe7u11GAwvd7qGEXZR0LcEiQLzjTMQbKKumLJwDVye+fol?=
 =?us-ascii?Q?TiOn6MT1ul8bTDuMDRWgRJsKGoYA3sNAwgMj65F0RDU2mvppZEqg3SqpFGC4?=
 =?us-ascii?Q?DbUUe/qCh2AQIb3ad5AXDT9TFp42JIiMSYjHM7qPJmXHM83z7aa+28qKZP8n?=
 =?us-ascii?Q?OiiPIObHcT+3R97rIc/fev4DjLw7GLD4HwJGRSOaTWLcxTcY0OeK25jH0dgL?=
 =?us-ascii?Q?2Ahb1VuH07VnlDJKSdwNV+MxBNnkJZqIyHbz2EyvSS05AemUh207oiVSGIXl?=
 =?us-ascii?Q?IWlHILHsFABIwHuFpuPrNazzhv0mE9VElqBYCm2taM3opNoLtBTNgpRzw4V6?=
 =?us-ascii?Q?fjOTHYy+R6fnzGX4II6SiPgtQuP3fUWz4YqbIkAGsM3KYwFQ+38vAZMXrgqP?=
 =?us-ascii?Q?LEUm7UFL0scFcOLEfBnCgDznJpetgLn/nc6DAbpJ5IGPsypmjCLXsp6Q4Y9b?=
 =?us-ascii?Q?IuTPyQML1rrpQx7afmcya7nQUXh/ddmpBb6LZTAZCY66ifUwVEJPWfaFQb3E?=
 =?us-ascii?Q?XhXyONH9tQhLv6mANaZgd5OQWQTi3RM7Da4LIZvTzTU44z0O4bdmM/1q7urK?=
 =?us-ascii?Q?lGA66YiWE/tCVMFbyqEfwxBOyd0eIPATAaOZrwXbefwEOqZcUoId3rZj19qS?=
 =?us-ascii?Q?Ok7bScDgEp2eUoFe9gutTYxqU8GNNmJmwVxq05oTVMjMg7dWlLTiVHhXnE1L?=
 =?us-ascii?Q?QFS+yvVK8A0ReqI2/rqf0lFP4MUEY1NF0qOtUgpabGGZplkBkH7uTyfeoQFp?=
 =?us-ascii?Q?/QzdtSeC2RkLfmrAoafIlJ3DOpc1/E0DCqveqLDdJzSkjyifAz7SY84aXC3N?=
 =?us-ascii?Q?R5MWjwI6yxeMLlwVJ2Dm5R7p92zFctigLgCA6cNvdUk30jZmv49eFNBkbeQr?=
 =?us-ascii?Q?gg+d0nLn9ByONcV/YlrjVsGqlbYtPj21h8WDet5cVHngoP8J73mv0ar7OYga?=
 =?us-ascii?Q?ZAvGURHSnf7TVeuL5aTeCIGj9Ji8hUMAlojDrGfjor6y1T+PZ60h/0oDoQo3?=
 =?us-ascii?Q?Bizj/ztTeysfoFm51ra2uH5PJMGCJ9/c2ePiEcJ0AnCmQuINlXLWL1m2A5/m?=
 =?us-ascii?Q?+GO12ODQr7kL0aDk7tt5bCKhwj30TCle09Jd7tBfXvDI/qEmH9CPZVOHG56Q?=
 =?us-ascii?Q?2KCQOiKs03c7WYrjzVAJklG8IQ5GJEGHgUFBQWJxeL+Q7OCPIUl2px+t6wb5?=
 =?us-ascii?Q?/sqsYbrqydUs7HXo4vBQzYHNbTOc59aVQiW1lsBOekNb+SHgGpxE+uLiMHme?=
 =?us-ascii?Q?BlM6FViOTfBPH+bt/tt5oj2JkZAlpXNSrSqHdRi8PVGwMGLPNXEi0oGY9uGU?=
 =?us-ascii?Q?fKlynetOQPydR/N0zM8QuvwLZHvtxqed2cdQ05RdHAPoBWkXqC8ODr1Ljz8V?=
 =?us-ascii?Q?1Bnl9hVsjoEBjnCa/hd18bPiBWpW+jacMSsu9UmJ7gm4hnE2EEdURAWaKbSv?=
 =?us-ascii?Q?2LqaZPSJK/AWZi9w5quOUvo/pP3c4QfGgqmPf9BQxIXrA0BczjBrx+Oksvbt?=
 =?us-ascii?Q?sX+zgIkD9/cicenLF1+ztlNiJ7zze89XSfFPHutehhD6a4K9aDw8Rb7VoSN/?=
 =?us-ascii?Q?6sbT5fjU2seFD0PF/MSfbtOZC+bRem8zgXF9scyB69igob/WbtkUVyGYdTnZ?=
 =?us-ascii?Q?PgtS2AsgjeZwT4+fAIIZNRyue0Db+zB9Lpdtd1LIKhnAMDNuc2pRPHOe6yNL?=
 =?us-ascii?Q?lZg1HqiNCjX+7lGlPitFoVqQi+HA1e4oexM8ym/R4qY/vxLONs1B8uOcPSuH?=
 =?us-ascii?Q?Y69Zul8czBvfjCdKAyWSmW5cxxjdkeGtHawDPPjzictqSayGXsnt?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db8c246-682e-47f3-c34c-08df1533d67f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:20:49.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywW99OeQroa6oulXn+KuVBftFVtI+o+D/SCVOrgwGcAH0oPGC7D8Tft81VPwWijdaIi6+GKUJLH3H/UC1JA9lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5141

On R-Car, intreq_pcim_sub carries both the integrated MSI receiver and
the controller's reset requests (smlh_req_rst_not, link_req_rst_not), so
the generic DesignWare chained handler reads the MSI status from DBI as
soon as the link goes down. On R-Car S4 that is a hazard: DBI accesses
issued within a few hundred microseconds of an unexpected link down do
not complete and hang the host. In testing, the first Root Port config
read after powering off the link partner hung unless delayed by ~300 us.

Use the pre-MSI callback to check the APP reset status before DBI is
touched. When a reset request is latched, mask the sources, ack the
request and schedule recovery work. The work calls
pci_host_handle_link_down(), which runs the AER-style recovery and
resets the controller through reset_root_port(). If the reset fails, the
sources stay masked so nothing touches the unrecovered controller.

Only unmasked status bits are handled and pending latches are cleared
when re-arming, so requests recorded during probe or the reset itself do
not trigger another recovery. Teardown only disables link-down
detection: MSI delivery has to keep working while devices are removed.

When iMSI-RX is not used (external MSI controller or pci=nomsi), the
DesignWare core does not request intreq_pcim_sub, so request it in the
driver. The DT routes downstream INTx to the same line, but the driver
has never supported INTx (no INTx domain, INTx enables never set), so
taking the line exclusively takes nothing away. Keep msi_ctrl_int
masked in this mode since nothing would clear it.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/Kconfig          |   1 +
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 201 +++++++++++++++++++-
 2 files changed, 199 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index dcfbe7e229fd..573fcb2e44d7 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -350,6 +350,7 @@ config PCIE_RCAR_GEN4_HOST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCIE_RCAR_GEN4
+	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want PCIe controller (host mode) on R-Car Gen4 SoCs.
 	  To compile this driver as a module, choose M here: the module will be
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 5b983ef6dc47..238755852045 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -25,6 +25,7 @@
 #include <linux/reset.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 /* Renesas-specific */
@@ -39,9 +40,18 @@
 #define MSICAP0			0x0050
 #define MSICAP0_MSIE		BIT(16)
 
+/* PCIe Reset Status */
+#define PCIERSTSTS		0x0020
+#define SMLH_REQ_RST_NOT	BIT(2)
+#define LINK_REQ_RST_NOT	BIT(1)
+#define LINK_DOWN_RESET_MASK	(SMLH_REQ_RST_NOT | LINK_REQ_RST_NOT)
+
 /* PCIe Interrupt Status 0 */
 #define PCIEINTSTS0		0x0084
 
+/* PCIe Reset Status Enable */
+#define PCIERSTSTSEN		0x0300
+
 /* PCIe Interrupt Status 0 Enable */
 #define PCIEINTSTS0EN		0x0310
 #define MSI_CTRL_INT		BIT(26)
@@ -50,6 +60,9 @@
 #define PCIEDMAINTSTSEN		0x0314
 #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
 
+/* PCIe Reset Status Clear */
+#define PCIERSTSTSCLR		0x0330
+
 /* Port Logic Registers 89 */
 #define PRTLGC89		0x0b70
 
@@ -92,6 +105,10 @@ struct rcar_gen4_pcie_drvdata {
 };
 
 enum rcar_gen4_pcie_state {
+	/* A reset request is pending, or its recovery failed */
+	RCAR_PCIE_LINK_DOWN,
+	/* Link-down detection is being torn down */
+	RCAR_PCIE_IRQ_STOPPED,
 	/* The controller is being reset and reinitialized */
 	RCAR_PCIE_RESETTING,
 };
@@ -102,6 +119,10 @@ struct rcar_gen4_pcie {
 	void __iomem *phy_base;
 	struct platform_device *pdev;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
+	/* intreq_pcim_sub ("msi"), shared with the iMSI-RX */
+	int sub_irq;
+	bool sub_irq_owned;
+	struct work_struct link_down_work;
 	unsigned long state;
 	/* Protects APP interrupt enable registers and their software state. */
 	raw_spinlock_t app_lock;
@@ -361,8 +382,19 @@ static bool rcar_gen4_pcie_irqs_blocked(struct rcar_gen4_pcie *rcar)
 	return !!rcar->state;
 }
 
+/*
+ * DBI must not be touched while the link is down or the controller is being
+ * reset.
+ */
+static bool rcar_gen4_pcie_dbi_unsafe(struct rcar_gen4_pcie *rcar)
+{
+	return test_bit(RCAR_PCIE_LINK_DOWN, &rcar->state) ||
+	       test_bit(RCAR_PCIE_RESETTING, &rcar->state);
+}
+
 static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 {
+	struct dw_pcie_rp *pp = &rcar->dw.pp;
 	bool armed = !rcar_gen4_pcie_irqs_blocked(rcar);
 	u32 val;
 
@@ -370,9 +402,28 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 
 	val = readl(rcar->base + PCIEINTSTS0EN);
 	val &= ~MSI_CTRL_INT;
-	if (armed && pci_msi_enabled())
+	/*
+	 * MSI delivery only depends on DBI being usable; teardown must not
+	 * stop it while devices are still being removed.
+	 */
+	if (!rcar_gen4_pcie_dbi_unsafe(rcar) && pp->use_imsi_rx &&
+	    pci_msi_enabled())
 		val |= MSI_CTRL_INT;
 	writel(val, rcar->base + PCIEINTSTS0EN);
+
+	val = readl(rcar->base + PCIERSTSTSEN);
+	if (armed && rcar->sub_irq > 0) {
+		/*
+		 * Clear latches recorded while the sources were masked, so
+		 * stale requests do not fire as soon as they are re-enabled.
+		 */
+		if (!(val & LINK_DOWN_RESET_MASK))
+			writel(LINK_DOWN_RESET_MASK, rcar->base + PCIERSTSTSCLR);
+		val |= LINK_DOWN_RESET_MASK;
+	} else {
+		val &= ~LINK_DOWN_RESET_MASK;
+	}
+	writel(val, rcar->base + PCIERSTSTSEN);
 }
 
 static void rcar_gen4_pcie_app_irq_sync(struct rcar_gen4_pcie *rcar)
@@ -435,6 +486,134 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	return ret;
 }
 
+/* Returns true if a latched reset-request status was consumed. */
+static bool rcar_gen4_pcie_handle_link_down(struct rcar_gen4_pcie *rcar)
+{
+	bool schedule = false;
+	u32 status;
+
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		status = readl(rcar->base + PCIERSTSTS) &
+			 readl(rcar->base + PCIERSTSTSEN) & LINK_DOWN_RESET_MASK;
+		if (!status)
+			return false;
+
+		if (!test_bit(RCAR_PCIE_IRQ_STOPPED, &rcar->state) &&
+		    !test_bit(RCAR_PCIE_RESETTING, &rcar->state))
+			schedule = !test_and_set_bit(RCAR_PCIE_LINK_DOWN,
+						     &rcar->state);
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+		writel(status, rcar->base + PCIERSTSTSCLR);
+	}
+
+	if (schedule)
+		schedule_work(&rcar->link_down_work);
+
+	return true;
+}
+
+static void rcar_gen4_pcie_link_down_work(struct work_struct *work)
+{
+	struct rcar_gen4_pcie *rcar =
+		container_of(work, struct rcar_gen4_pcie, link_down_work);
+	struct dw_pcie_rp *pp = &rcar->dw.pp;
+	struct pci_dev *port;
+
+	for_each_pci_bridge(port, pp->bridge->bus) {
+		if (pci_pcie_type(port) == PCI_EXP_TYPE_ROOT_PORT)
+			pci_host_handle_link_down(port);
+	}
+
+	if (test_bit(RCAR_PCIE_LINK_DOWN, &rcar->state))
+		dev_err(rcar->dw.dev,
+			"Root Port reset failed; keeping the controller's interrupts masked until a reset succeeds\n");
+}
+
+static bool rcar_gen4_pcie_pre_msi_irq(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+
+	rcar_gen4_pcie_handle_link_down(rcar);
+	if (rcar_gen4_pcie_dbi_unsafe(rcar))
+		return true;
+
+	/* Check once more right before the DesignWare DBI access. */
+	rcar_gen4_pcie_handle_link_down(rcar);
+
+	return rcar_gen4_pcie_dbi_unsafe(rcar);
+}
+
+static irqreturn_t rcar_gen4_pcie_sub_irq_handler(int irq, void *data)
+{
+	struct rcar_gen4_pcie *rcar = data;
+
+	return rcar_gen4_pcie_handle_link_down(rcar) ?
+		IRQ_HANDLED : IRQ_NONE;
+}
+
+/*
+ * Arm link-down detection once enumeration is done: the chained iMSI-RX
+ * handler is only installed after ops->init, and the recovery needs the
+ * Root Port to exist.
+ */
+static void rcar_gen4_pcie_link_down_irq_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	struct device *dev = dw->dev;
+	int irq, ret;
+
+	if (pp->use_imsi_rx && pp->msi_irq[0] > 0) {
+		/* The DesignWare core owns the chained handler of this interrupt. */
+		rcar->sub_irq = pp->msi_irq[0];
+	} else {
+		irq = platform_get_irq_byname_optional(rcar->pdev, "msi");
+		if (irq < 0) {
+			dev_warn(dev, "Failed to get \"msi\" IRQ; link-down detection unavailable\n");
+			return;
+		}
+
+		/*
+		 * Run in hard IRQ context even on PREEMPT_RT, like the chained
+		 * handler, so the reset request is masked before anything else
+		 * touches DBI.
+		 */
+		ret = request_irq(irq, rcar_gen4_pcie_sub_irq_handler,
+				  IRQF_NO_THREAD, dev_name(dev), rcar);
+		if (ret) {
+			dev_warn(dev, "Failed to request \"msi\" IRQ; link-down detection unavailable\n");
+			return;
+		}
+
+		rcar->sub_irq = irq;
+		rcar->sub_irq_owned = true;
+	}
+
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
+	clear_bit(RCAR_PCIE_IRQ_STOPPED, &rcar->state);
+	rcar_gen4_pcie_app_irq_sync_locked(rcar);
+}
+
+static void rcar_gen4_pcie_link_down_irq_deinit(struct rcar_gen4_pcie *rcar)
+{
+	if (test_and_set_bit(RCAR_PCIE_IRQ_STOPPED, &rcar->state))
+		return;
+
+	rcar_gen4_pcie_app_irq_sync(rcar);
+
+	if (rcar->sub_irq > 0)
+		synchronize_irq(rcar->sub_irq);
+
+	cancel_work_sync(&rcar->link_down_work);
+
+	if (rcar->sub_irq_owned) {
+		free_irq(rcar->sub_irq, rcar);
+		rcar->sub_irq_owned = false;
+	}
+	rcar->sub_irq = 0;
+}
+
 static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
 					struct pci_dev *dev)
 {
@@ -524,14 +703,23 @@ static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
 		set_bit(RCAR_PCIE_RESETTING, &rcar->state);
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
+
+	if (rcar->sub_irq > 0)
+		disable_irq(rcar->sub_irq);
 }
 
-static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar)
+static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
+				       bool recovered)
 {
 	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		if (recovered)
+			clear_bit(RCAR_PCIE_LINK_DOWN, &rcar->state);
 		clear_bit(RCAR_PCIE_RESETTING, &rcar->state);
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
+
+	if (rcar->sub_irq > 0)
+		enable_irq(rcar->sub_irq);
 }
 
 /*
@@ -574,7 +762,7 @@ static int rcar_gen4_pcie_reset_root_port(struct pci_host_bridge *bridge,
 	dev_dbg(dev, "Root Port reset completed\n");
 
 out:
-	rcar_gen4_pcie_resume_irqs(rcar);
+	rcar_gen4_pcie_resume_irqs(rcar, !ret);
 
 	return ret;
 }
@@ -610,6 +798,8 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
+	rcar_gen4_pcie_link_down_irq_deinit(rcar);
+
 	gpiod_set_value_cansleep(dw->pe_rst, 1);
 	rcar_gen4_pcie_common_deinit(rcar);
 }
@@ -617,6 +807,8 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
 	.init = rcar_gen4_pcie_host_init,
 	.deinit = rcar_gen4_pcie_host_deinit,
+	.post_init = rcar_gen4_pcie_link_down_irq_init,
+	.pre_msi_irq = rcar_gen4_pcie_pre_msi_irq,
 };
 
 static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
@@ -632,6 +824,7 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 		return ret;
 
 	raw_spin_lock_init(&rcar->app_lock);
+	INIT_WORK(&rcar->link_down_work, rcar_gen4_pcie_link_down_work);
 
 	pp->num_vectors = MAX_MSI_IRQS;
 	pp->ops = &rcar_gen4_pcie_host_ops;
@@ -641,6 +834,8 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 
 static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 {
+	/* Cancel recovery work before removing the PCI bus */
+	rcar_gen4_pcie_link_down_irq_deinit(rcar);
 	dw_pcie_host_deinit(&rcar->dw.pp);
 }
 
-- 
2.51.0

