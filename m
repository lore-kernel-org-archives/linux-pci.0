Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021136.outbound.protection.outlook.com [40.107.74.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722BE4F4041;
	Mon, 28 Sep 2026 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614398; cv=fail; b=ZimlqGjSzTBXgc3UiPvhOvij1p7LlJ29TOpLNDI5RUqDVh/r7U7albtY0Fp9ssRp4K+VyHCHipuT5hb9l1uMRM+SX60f6AzJEJJjHQe5+2OsouDVypwVRnaD9qr0dr6B4/5fZvWNzESLqFrdMaOuHaJEXsClK+mJu6HyYWnhA58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614398; c=relaxed/simple;
	bh=9WCwKrpzTo8lkEtb9dVY1FSkhSS7cx7sJ1t+xa53UJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MXpDlJBy0jvJy/Umklq2uZUzyyIXWeQSgHgQfDoUv0kwAcN9MGAGQq+82ENTNwbgAzcLUH5IPds4q8hzLGjypg6YUZFl871ewVtjg3PL4vmgwMPOtN/cftsjpeVWFZSFAZOQwJKDM5VYaYZN4kNOAsih+XT6O/gE2mtls18GObE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZiJc9eZn; arc=fail smtp.client-ip=40.107.74.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZiJc9eZn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/QDrUJ9cCxuR0DTB8Zn4y76MG4jntJTplmh5rLUfLQC7c7uCMMc4y0IdhGxG73VXgJMDbl8/lwUNfKGppAS7jygmSu0LLgKhoE9S6sMfB6WdOP7zYSWuBHK6LolauTXY2Im6YxEBeiXFkpW66feDNDCrlkdqDEPoijE4lLgDDQBzKyFpmXa9nW0Ys7UtxfT8G24V4n9NsJiXfw9w6P42oMyp1amyAR4SX0sUUOw7mWaBOImkcoIH2nu3gWkzHJZ24ue1FoRa9qkhSA4YKw4qRkEEL0ZQZUB/qJRtjjhCjFMF7v3ihShPfBe7LZnly69WrYGINfQ3vXSAdXddXz9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5IXvGU6zIPkU4VlXecS1vANBqzQND4JK8aU3Ox1Ai0=;
 b=tW2Q9aT9ciD3H2uAZ0yTpbbTvac2ihi8QAA3brB66IKz1BTvKQ2xM3MYpHe8yPtssNiifyxA2iPZoy7d9766a3qCf7BRNd4J8EcXJz70xtXWvu/BBuIEbLJjsifRlDewocNLk+0Gid8FBtgOR3ReVB0jPA/lqdW9Yo1xbfADWu8231EmJnqsrikMzRkncNI4qyTbJm8zmj9X9N/MpKOa9ZYiDXiiBg/pZpQ7/wgIRokqdJCxDg+XRK5niXBefqyOMsNhQAC2tyWvAmKf+Lo2QiKd2ThhBBTtqB061KOCvd+NbB5/QcnApx5+aTqerg9i1QlfyGdRyM3nMFkNF00eQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5IXvGU6zIPkU4VlXecS1vANBqzQND4JK8aU3Ox1Ai0=;
 b=ZiJc9eZnETRvtZ0W5eqb5EgVi+peTUd3YldN7p77Sy4A+XVRyeGH6B0dN+nZAbSvQ39q+u8dVu30P7olEh0sA0TfcEngEtdJP9+N02Doxgt4D5Md6OY1iDHhB4zEkwV1HDnRy8D37PpurXAT13+mXpuEbfDJgyXhQTLpnUGLLEY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:07 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:53:07 +0000
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
Subject: [PATCH v2 09/15] PCI: rcar-gen4: Add Root Port reset support
Date: Tue, 29 Sep 2026 01:52:24 +0900
Message-ID: <20260928165230.3397664-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::20) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba70f02-7bbe-4068-3a72-08df1d80f8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|6133799003|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GQkArqG1A/LHqXqtZEwS0ecuGBWNfj3x62mSL1yDg2CsbbdBqW3ZLvBkgxb+TNoZPeW58ch81N82lE952IBQASK3TanEIvNnd+7NhHOXC/BCUNMcPiYufyvRo2efopuy3X3E9uZ7Rd0MIECSA0LTYuV9IWj/QyUaXMe1Ku1OdmgaXmXyNzsCOTYkxcXFmxkB40Qofx6qeNPXO1haWw6iYXXbv7RjXSaM1SsLgO+iNWGEDAN234eV5NEK1Cp8plYc+v/1Q3c9ufvSTSV1tBC+qbtr4HefPWR561L+txpq60/HVCGxPrlRqTreQSGFm8qYeWeFHHVbBuFkWQi/vGQ0Al9dElr1pG/C2eYVX2KOlJCR5sCPFgor63bWEjNCyAs673ThnWFRRgLv9oqbRDSKau6b9Zk9APXS0mQkwU90LlnDILe4Aazu9pzAGenkj+IqsJIU75Alw41Ws/c99KJwKQd8sJY4YC81ebthPUpVneToSx9aLuHh7pjjVAOmBc188fWIO5KH50wYTeaKx0Q3Q7nt/gWt5XycIS8ATyWQ6mqkzWB1BmKotVjt8bXO+Oqf926S8r2dHsNCgX3sI4jcs1RCv96gnpuqlwlos5xQjcQ8G42oMNbeBYd4wTnD/kccZhM105VT5CIF3YMfdzXv0cqOrXw9aQIszfVBNMVG16nGAOgh7oEAHL+QVetnr4MscF8+RB2gL61AEcY0snt8VA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(6133799003)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n9ZN/aTEhcwjfPLX66/r8pdPEvWisgIg9nanxGDlFo7QGqc1I3yEzV7Um27v?=
 =?us-ascii?Q?uJ8oPQr8EkUh1VqOg1lstetVPHQ7gHxnPCeBSRve57uWDnYR4U/yGnkIDfwk?=
 =?us-ascii?Q?aJ6KH6SPmnaOtGzHOU6dQgs0YhA6H4YW/2APV9GZ9PY5XYyhgWFiB7uZEFoz?=
 =?us-ascii?Q?M//Yo701zc7434ZK0+mAG2zbLHOYJZqd8mG2yv6kEeWJzn5B9+6ZNIaynJHr?=
 =?us-ascii?Q?91WiEhlpyNIo8p71L98Zm3cZqKe7T+45u3tX5MdKUx+hpSZegA6KCVXd9CYR?=
 =?us-ascii?Q?wwkN+9UdMiCkkwA2s4Q42FOJQdR14XzJCSfVMs5+LVwhnBcgSWJdR2JLlq3b?=
 =?us-ascii?Q?3xtKFfS3A6g6P6L1r3SdsEHmWIrzz8CGIlRbQnV3bFUzXqvaMmy+GQ7c8ld/?=
 =?us-ascii?Q?PsdF4Voqxl4FhTht7ydgDa/g/nESxe9WsKDP036MVBwYd1ZO1c8Fm8KVph18?=
 =?us-ascii?Q?FCzhHWmP/5X2bY4xRxx+ScGY3BNqYqT9mZHAr8ii21fKHs2/ox/0+0Z+E1K+?=
 =?us-ascii?Q?DN5/ktDmPIuoaL0P1eZXNlxhM0NbQxru4W0ZwrSt2zcRfYarRkV2XsAY5Wzs?=
 =?us-ascii?Q?yTMRQ2BTok1RnG03MGoyQwYBBlV3IIHoxT5QjRbFjAN099815EdI3A4ctVF7?=
 =?us-ascii?Q?EYBdIbMQaP4TOTAmBqpkeaKsWwUS8ld0aoBRokXY0E6JcSRxMAqDzjZvZYhQ?=
 =?us-ascii?Q?g1fIvu6faFZlSkMPjuR4l4S4K5CViOSSTUe/cfMViGH0vI5iitkulyX3mP3A?=
 =?us-ascii?Q?1Nk7W2v06DB8R6VkdDUc87LOcXbaJWaGZiLt5uOIvXQWFnkVDEOQ0E1Sy+EL?=
 =?us-ascii?Q?n6DjwTQ09lDaZ7Sma9G4leV07+Csiwk8JIcwusdH4zuQvImN362NNJ17FxnA?=
 =?us-ascii?Q?th0iu7npWv5tvdFQwkZ1lbzu93regIzMpHqX3ORDWtzVRzGRCwrNzeRLsTyc?=
 =?us-ascii?Q?ilV+rGrbEDn2ZSXL1fr17Cl6tKSBSbseVd6m/6K9pqOCULAy5CZxXhrBpUi6?=
 =?us-ascii?Q?np3sg37mRl/Ogs5cDiKs3M569e46S/d34zH3ep5AA3IyCvfUXOWqV+utxz9Q?=
 =?us-ascii?Q?+rrrMGxE5aaP0stKcx0Opm9+34cvRmna/VdblPfJDiM8ZXvN0M+j6PUy9hDj?=
 =?us-ascii?Q?Fi3VGABvL3f8+koXpvDW4ofMc5l160GNCFnmJdbdp8QlKU+3hiY6vPv50z1Z?=
 =?us-ascii?Q?oyEJafZSWTZGaVjN0MWL5NmPTna9qWduUSq7t9Z0oqrYsEkk24IlrvmsZgrj?=
 =?us-ascii?Q?/In6eId2VF8cRfyiMjdTNd5Mom6yccnm+3UBGIWsqHDH1lZOkZ0idg3qbktO?=
 =?us-ascii?Q?m9LFSHZxoI02sjIJmJjRNPu33CVqZA5EjedIQfDm6eVfVgpYoF0nPY/oICO+?=
 =?us-ascii?Q?V5KZf8sgvzNbzYoUuS1wNtqNESmzgItDyqdq7ODPlmzAWQ9SrHRNbfYhzRwd?=
 =?us-ascii?Q?seqVDKMP4y/aU38fdu/+lCuVMTdL4gTeQtCb0UTMVbxNiwrYn/WWdaug/P3M?=
 =?us-ascii?Q?WtnXza9KKfhVwmaWzWlrpyveLXM35C4VbAvNMZy/5tFR92S1RS9RnSmp6xCK?=
 =?us-ascii?Q?EuSAFDnYaRwSjv1/FHV6hmZ3CcN/QbZUQKLt8ykKOCnVmjDNP+P1BLRNU6IT?=
 =?us-ascii?Q?NFc5n9y+jwK0gCLZW2jUjuEAIoSCN2yNHsp1IZlhGhlvOmoqJevsfyD1w2JF?=
 =?us-ascii?Q?aZoPvgU1W95VfxUDwunHoOZFrN9mnJohAtpo/uv7CG85+9QP79DJiaFNim/Z?=
 =?us-ascii?Q?FY004K+O6if7BDz4inlYE6Ki2/E0M8YGEEjGsEDrhIdVzQqnJZ0X?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba70f02-7bbe-4068-3a72-08df1d80f8b7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:53:07.6597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uB3LD9bqcp0NhjIRTsHwEV0iLpT+eTVI7iP4VAtd4hNDTVw3rOjOIM9f4EToFfF9XxLo9QXcnDJwE9tIXye4/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

Implement the host bridge reset_root_port() callback so PCI error
recovery can reset and reinitialize the R-Car controller. This also
provides the reset operation for the link-down handling added later.

Call .reinit() with clocks and PHY initialization retained, restore
the Root Port registers and restart link training.

Rather than tracking which APP interrupt enables survive the power
reset, derive them from software state through a single helper. A flag
keeps the sources masked from the start of a reset until one succeeds,
so a failed reinitialization does not re-enable them against an
uninitialized controller.

Serialize the reset with a mutex, as not all callers hold the Root
Port's device lock: pci_try_reset_function() on a downstream device only
locks that device before falling back to a parent bus reset.

Track whether Gen5 PHY power-on has been requested so a reset retry, or
teardown after a failed reset, does not call phy_power_off() twice.
Continue to ignore the PHY power operation return values.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Use a bool flag instead of a state bitmask. (Marek)
  - Keep the sources masked after a failed reset.
  - Use .reinit() to retain clocks and PHY initialization across resets.
  - Keep Gen5 PHY power calls balanced across failed reset retries.
  - Refine the commit message.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 123 ++++++++++++++++++--
 1 file changed, 116 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index d1ea94272711..d3f04358bbe3 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -15,6 +15,7 @@
 #include <linux/iopoll.h>
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -111,9 +112,19 @@ struct rcar_gen4_pcie {
 	void __iomem *base;
 	void __iomem *phy_base;
 	struct phy *phy;
+	bool phy_powered;
 	struct platform_device *pdev;
 	struct reset_control *perst;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
+	/*
+	 * The controller needs reinitializing; the APP interrupt sources
+	 * stay masked until a reset succeeds.
+	 */
+	bool reinit_pending;
+	/* Protects APP interrupt enable registers and their software state. */
+	raw_spinlock_t app_lock;
+	/* Serializes Root Port hardware reinitialization. */
+	struct mutex reset_lock;
 };
 #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
 
@@ -543,6 +554,26 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 	return 0;
 }
 
+static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
+{
+	u32 val;
+
+	lockdep_assert_held(&rcar->app_lock);
+
+	val = readl(rcar->base + PCIEINTSTS0EN);
+	val &= ~MSI_CTRL_INT;
+	if (!rcar->reinit_pending && pci_msi_enabled())
+		val |= MSI_CTRL_INT;
+	writel(val, rcar->base + PCIEINTSTS0EN);
+}
+
+static void rcar_gen4_pcie_app_irq_sync(struct rcar_gen4_pcie *rcar)
+{
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
+
+	rcar_gen4_pcie_app_irq_sync_locked(rcar);
+}
+
 static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
@@ -573,12 +604,7 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	}
 
 	/* Configure MSI interrupt signal */
-	val = readl(rcar->base + PCIEINTSTS0EN);
-	if (pci_msi_enabled())
-		val |= MSI_CTRL_INT;
-	else
-		val &= ~MSI_CTRL_INT;
-	writel(val, rcar->base + PCIEINTSTS0EN);
+	rcar_gen4_pcie_app_irq_sync(rcar);
 
 	return 0;
 
@@ -593,6 +619,7 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	writel(0, rcar->base + AXIINTCCONT);
 
 	/* Deconfigure MSI interrupt signal */
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
 	val = readl(rcar->base + PCIEINTSTS0EN);
 	val &= ~MSI_CTRL_INT;
 	writel(val, rcar->base + PCIEINTSTS0EN);
@@ -691,14 +718,83 @@ static int rcar_gen4_pcie_host_setup(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
+{
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		rcar->reinit_pending = true;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+	}
+}
+
+static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
+				       bool recovered)
+{
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		rcar->reinit_pending = !recovered;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+	}
+}
+
+/*
+ * R-Car Gen4 controllers have a single Root Port per instance, so the
+ * 'pci_dev' is ignored and the whole controller is reset.
+ */
+static int rcar_gen4_pcie_reset_root_port(struct pci_host_bridge *bridge,
+					  struct pci_dev *pdev)
+{
+	struct rcar_gen4_pcie *rcar = dev_get_drvdata(bridge->dev.parent);
+	struct dw_pcie *dw = &rcar->dw;
+	struct dw_pcie_rp *pp = &dw->pp;
+	struct device *dev = dw->dev;
+	int ret;
+
+	guard(mutex)(&rcar->reset_lock);
+
+	rcar_gen4_pcie_quiesce_irqs(rcar);
+
+	dw_pcie_stop_link(dw);
+
+	rcar_gen4_pcie_host_perst_assert(pp, true);
+
+	ret = rcar->drvdata->reinit(rcar);
+	if (ret)
+		goto out;
+
+	ret = rcar_gen4_pcie_host_setup(pp);
+	if (ret)
+		goto out;
+
+	ret = dw_pcie_setup_rc(pp);
+	if (ret)
+		goto out;
+
+	ret = dw_pcie_start_link(dw);
+	if (ret)
+		goto out;
+
+	/* Ignore errors, the link may come up later */
+	dw_pcie_wait_for_link(dw);
+	dev_dbg(dev, "Root Port reset completed\n");
+
+out:
+	rcar_gen4_pcie_resume_irqs(rcar, !ret);
+	if (ret)
+		dev_err(dev, "Root Port reset failed (%d); interrupts stay masked until a reset succeeds\n",
+			ret);
+
+	return ret;
+}
+
 static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
-	if (pp->bridge)
+	if (pp->bridge) {
 		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
+		pp->bridge->reset_root_port = rcar_gen4_pcie_reset_root_port;
+	}
 
 	rcar_gen4_pcie_host_perst_assert(pp, true);
 
@@ -734,10 +830,17 @@ static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
 static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie_rp *pp = &rcar->dw.pp;
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_PCIE_RCAR_GEN4_HOST))
 		return -ENODEV;
 
+	ret = devm_mutex_init(rcar->dw.dev, &rcar->reset_lock);
+	if (ret)
+		return ret;
+
+	raw_spin_lock_init(&rcar->app_lock);
+
 	pp->num_vectors = MAX_MSI_IRQS;
 	pp->ops = &rcar_gen4_pcie_host_ops;
 
@@ -972,11 +1075,17 @@ static int rcar_gen5_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 	}
 	writel(val, rcar->base + PCIERSTCTRL1);
 
+	/* A reset retry may find the PHY already powered off. */
+	if (enable == rcar->phy_powered)
+		return 0;
+
 	if (enable)
 		phy_power_on(rcar->phy);
 	else
 		phy_power_off(rcar->phy);
 
+	rcar->phy_powered = enable;
+
 	return 0;
 }
 
-- 
2.51.0

