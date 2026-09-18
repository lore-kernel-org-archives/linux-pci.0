Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020136.outbound.protection.outlook.com [52.101.229.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393836B929;
	Fri, 18 Sep 2026 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701656; cv=fail; b=TcONCejIOOkjbPBxReSMqYI+yDs1fqxGKDuQiTWNlplZsM9E39viFtUkqz6wzqr+arKK6NxS9zlCa82MgI+/TrwwJq6ksTZqQmPAtS3nzl+4N38EPZoTALreTpLrl7OCiQgHg6qTryEWUqUt/JiwwbFnwPy/Ih/8E5MiKk81q2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701656; c=relaxed/simple;
	bh=3CXxNlfKl3jTyinf3fzh3QEr/nXimXBzFkqL/fImCUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NHFBqxHsgTf9YHs8l4d7N4HB83rRkiwkpqJEA/is0XkP6ZoRJCQ1Cz5t0Ljxs0i+//Q50TpLHlbNDfrgYHnS/G16OdwMWc1KVRT0WvvYdjUqg/1238ZBwLa6FRWOHIF4rx90pzW+OYNxOs5uaLxt/988M9Sku0GeBSHYNaJhngY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=iiaEDPP4; arc=fail smtp.client-ip=52.101.229.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="iiaEDPP4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BM4ObPgFP+hsZOLyh5jxwVKKxN2sFOqB+xJJQhpNqnfqYeaTmf/IjiiWYXE9BhyBuWW4p8w3Rd5rmL2T0bt+p9/hC8JQM1Bj8zxfg6q40dHspCe6SSKVl/VIVPKWLUrX4YrTaqfVHE6ETCjUT9UbYo3YwH4W59Lt1fzgNPDLfL55D+WFhExb/b5PQPvvDcyvWNqpOuPAOGwO8pezPZAyIxx7O79pFncOW6rgeagAe8RytqjzYsR7ar0lSwBFiHcDFmltM1YIA4gN1lcBFV8XD4EDoLIUqKIjzKU14hLMsJaIv+w4FbFiKiFyeHb+m2TsnfYot6KqnEC2n4FxdpSxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbNGi902Kx+sfR3aIOAbg7iyUwZcvYkJ5WdjIvDvyFo=;
 b=IrvVMYbdb2S0vyCeFPrdHXyhhn1BtWQcmKdltnQusFj0z/b4eLrHUsdkhmGuJSaEzfskvkaHkKj5uZzgcXjYjVYaKTsl8gGVldvfNNvy508H4ayH/OTBFZXmkYzw02ZDCLSHNptaENimhqIEzEuRmu2Xya9RC/4w2KBwEpzO6lPi/Hc+n1lrpaAhcQy2OwpW8Cb/t/q6aC1nj5/jPh3L1VN6L0vDi+oU9008SUgh+L1IQWQ0LtInvwsSaqQsP1/F5SxYcmhSVM3afvHheLJBAll9fgoVuQn0kIjGej0ialfUOvNJMOD4ccbRp46Q8zWKJYHKg0f3cLx+B+5pCT3R4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbNGi902Kx+sfR3aIOAbg7iyUwZcvYkJ5WdjIvDvyFo=;
 b=iiaEDPP4hhVN8ulERPmDsdux15UqpIbe2K/2YoQT45izaG27adLPrKb8mTDKLioDkawxFkdO4VPMzK78CXVgKyaUHaDld682DWm2r2cH93q19yFfIza6YILikE7CjpnrIiaqnSdzjcg0RIVD9AXXT3l55mOa/l3HjSlt4brbHxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5141.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:350::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:20:48 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:20:48 +0000
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
Subject: [PATCH 06/11] PCI: rcar-gen4: Add Root Port reset support
Date: Fri, 18 Sep 2026 12:20:33 +0900
Message-ID: <20260918032038.2216471-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260918032038.2216471-1-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0180.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: bb022f3b-380a-4e11-89ab-08df1533d5fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|7416014|366016|56012099006|6133799003|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	blI7zTewziGa4+D+XZujim/nzUS/25W+abgZGaRRmfNSf5tDb7plZ3WPZd1yNIMjb9E6QAvPwqMWhDezVMCGzOmv+0gYsrFWFb1hXU9Q0D1cqVEFaCnMYCoyUUynSsAq0ZAqmnstqXH5ZiIphJK3srHMjmqXF4ibQ6dV/SCoAF5qFIlitZZ6YsqfDEpqAU76bZpZIFXZVTUKuR6w3qM2yERMqpcnp33yd4DxVpLKb2c73Xb+85Li/lP5/QhNlYKsE/529G6RF8idKJOZV5dwo3HGYK/DLttsxR3rmL8VglyhdujX9+lhxWGzHMMRqXEy0Vy7+x9byHx8xDwS+EDIFMmjcJsmqfAo25qu8xCgay27ywcC2lyJLNiqLkRsuYD7h8ZJrWdwM9kYD8UDtTms7Gpu+c1zFauJL1JX5YDwAY+HpM8pjSVEKrM5p+6YLpYInQJ0g4rwkYMpUN0y6awNY3JObnnTM58FXaqbEP7PkhCuV/iDqSLMC4LTZ+OliiUc8+5dDzZW7nmL5pMBCreATJsAgoQUw0wW83+aHcXB5SDxP0a4qe4j6vEdk4zQ/2mjAo3iZvGdVgOAxRz/mVms7hVRe1ahUW9PrnljZZB6B+7F9op+o64E7a1N+lDxo5g4T0laRL8aXOvLRxIYJNk003Mk8hPs+wW3o8Kxx34SgCkww8EOj1oqVWmCWqZA+95qBZ1ZnSHTfd2S3tc2RhGVsw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(7416014)(366016)(56012099006)(6133799003)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?npalGFeLxxOGVxxhEfYztBxSKlPsCfLKFn2eRkE6kQ9T/ERCeUCv2oH0gylc?=
 =?us-ascii?Q?dMbkJ5x24XEsnPm51nJDu5anmO1MlpI5tJZeuQwDBtfA6CLHIasG6b4zPkwC?=
 =?us-ascii?Q?utLQKQFRI13P2sQLhtKYVGyYjQTaJSRjLxzQfGfhyHYWfHDtTZ0aeZBm4OhC?=
 =?us-ascii?Q?xjHCTlGZZjBgZ3QSX1h0TbD/XrurdQ2i4P/2z+bJcQhzjPzViaGz46cQ+IF2?=
 =?us-ascii?Q?wVhSu+X0K11f7bS+jc7If6I4he/BKEohPVJCyluP8deIJzHVuyZNEVzbq9jP?=
 =?us-ascii?Q?K9zEBF/JbHWq5VkDoG+o3MR6ghpkDb7v+7FNjVex9HbG/KUm1JTt3kwVPSFs?=
 =?us-ascii?Q?K5cNWaMiqzb9sBp1aCIDI3nWJn1zX0hx6xshKQ4ZZ8Bz0mI6FTe8z2Pd71Db?=
 =?us-ascii?Q?AQzMKpIQH4FofrEGdx/T98/XmBRDXZCKkC3H+VrdE3d63bcj7KYgd/ZzzQhJ?=
 =?us-ascii?Q?jtDC41pSiO49t357n2DHWu9F0vSJige6jEfJFCfWWuTfA8c6+1+h/SWbp7Q/?=
 =?us-ascii?Q?wEOFNszy+vnEkUlHPmC0OBfFc05J7H0CAk2KftmYFaSN+dgAMvTsb6IQguvy?=
 =?us-ascii?Q?cm5AqnJulpqjfp1LUoiLvpmuOq4p+Pwyo8wQgBa57Tl/uVkcj+5fbRkXP1WC?=
 =?us-ascii?Q?73p3SM50lZWyrfQX1sVm1OVbjXGq0jbU+DYjxZ6xWZXC+ub1aBSUoTfK8sJu?=
 =?us-ascii?Q?YHu2St377T+OSXX+OB+mWVwbmc9d/vwXl7fWj/TZ3EIdozvTKL15N1VpwNLL?=
 =?us-ascii?Q?9HJO2ttL5bWYZZbobqyPC2hrivoLrmLmRBDsoV9i/naYlxUxsiQZvG7r7B9N?=
 =?us-ascii?Q?HFSYYLon6AaMoDzmRM3NrGHtno9DJytT9m6JKzFPJg9XHdQMltkAA6ZDyTls?=
 =?us-ascii?Q?y6LQCzmayCJmSSTvG8wMk1J9rzZXNfbZsSlU1ogpHG64eYZ63qU5XyEkTzHW?=
 =?us-ascii?Q?lwGwwRwzHmLNQtUg0GvpkLRKejOhsktzl/4AEv+Jbo36wIHmBYsewQDgOG+L?=
 =?us-ascii?Q?7nheOqTPAyyuZjNxvlCN7hTjR+uZzMvAo729ZY+Dc6MsSFhTkqUgOsXELRaA?=
 =?us-ascii?Q?lXmU+LKQS86oG0YFbIuwJHRlqY5Ixx1kBJp8UsLJ7+5bkFxQdssxlfkzWnFN?=
 =?us-ascii?Q?83pRRTPnjUrSQUqegXXxQFyJSvOoTW1HNVj0qEkvbd5Azitz5fdu4iJsf+Kt?=
 =?us-ascii?Q?lm/f58dg9U1ESLFBPM1+MSx5f2Gcg26bopaKJUkxXikrXb5X9H+rSJm3cySQ?=
 =?us-ascii?Q?UYCJBUc6IEurBeh15vV112QRidF+N+DVfnuBCeHi7xv3MRImUDSmojlbtMl3?=
 =?us-ascii?Q?U73j/55ByFNMG76LxFhbkLj7SWhtsig4oUW6fBKU0sQXqZxLlKSyMc/lSBco?=
 =?us-ascii?Q?L6a5vRJzc9EssjKBdAtcru82vbrqNaAkvo2uS0ity04wswpdTCrQjuiWsxCh?=
 =?us-ascii?Q?XARAztRvdTXw30uzagMwA7n+dzxLAOXchkVK3XfbEUuekq4+VZR7vQdFhBdb?=
 =?us-ascii?Q?XnerQfB5W3sv74Cv1vqiLt+vV/f8ccy2TNmF0p1lykGTw9IDkc0CZjczsVHG?=
 =?us-ascii?Q?oNwNZExNbgV3/U8lFxp0mTrGGjCwwz/3STtivLoddLO88pQbYLL5qrsxr7oM?=
 =?us-ascii?Q?BnET0+H2udLSKUC0vOe5L6VwkbKi/V+3ddE5bYqJfqZ7vlZrZHXz2iU4NX7A?=
 =?us-ascii?Q?rhgZzsS3epJBQ1hGoVtV2qhDIqE39NJvDFygFWXi9IEJjyJaZZMcefSi/50Y?=
 =?us-ascii?Q?IiBitAmTWMBAyYvryYln3ycw/i9iYQmyyfGtTXoFkiC89Z51tpik?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bb022f3b-380a-4e11-89ab-08df1533d5fa
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:20:48.8674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgEe54+Rda98dwQUHfrs0eX7jCtUKJvwYJpQ4RPS+gsewZQ0n608GBo/ae2wZsv0gcfFNaRRctZHnuSRrbaH9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5141

Secondary Bus Reset is a hot reset signalled over the link, so it is of
no use for recovering from a link down, and it does not reset the
controller either. Implement the host bridge reset_root_port() callback
instead: it re-runs the hardware initialization probe uses, redoes the
DesignWare Root Port setup and restarts link training. The PCI core
routes every Secondary Bus Reset of the Root Port through it, including
AER recovery and the link-down handling added later.

Rather than tracking which APP interrupt enables survive the power
reset, derive them from software state through a single helper. A state
bit keeps the sources masked while the controller is being
reinitialized.

Serialize the reset with a mutex, as not all callers hold the Root
Port's device lock: pci_try_reset_function() on a downstream device only
locks that device before falling back to a parent bus reset.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
For reviewers:
  - scoped_guard() is used deliberately in rcar_gen4_pcie_quiesce_irqs()
    and rcar_gen4_pcie_resume_irqs(): the next patch adds code after the
    locked section, and keeping that shape here makes the diff easier to
    read.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 118 ++++++++++++++++++--
 1 file changed, 111 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 8a85f5f45cda..5b983ef6dc47 100644
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
@@ -90,12 +91,22 @@ struct rcar_gen4_pcie_drvdata {
 	enum dw_pcie_device_mode mode;
 };
 
+enum rcar_gen4_pcie_state {
+	/* The controller is being reset and reinitialized */
+	RCAR_PCIE_RESETTING,
+};
+
 struct rcar_gen4_pcie {
 	struct dw_pcie dw;
 	void __iomem *base;
 	void __iomem *phy_base;
 	struct platform_device *pdev;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
+	unsigned long state;
+	/* Protects APP interrupt enable registers and their software state. */
+	raw_spinlock_t app_lock;
+	/* Serializes Root Port hardware reinitialization. */
+	struct mutex reset_lock;
 };
 #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
 
@@ -344,6 +355,33 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 	return 0;
 }
 
+/* Whether the APP interrupt sources may currently be enabled. */
+static bool rcar_gen4_pcie_irqs_blocked(struct rcar_gen4_pcie *rcar)
+{
+	return !!rcar->state;
+}
+
+static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
+{
+	bool armed = !rcar_gen4_pcie_irqs_blocked(rcar);
+	u32 val;
+
+	lockdep_assert_held(&rcar->app_lock);
+
+	val = readl(rcar->base + PCIEINTSTS0EN);
+	val &= ~MSI_CTRL_INT;
+	if (armed && pci_msi_enabled())
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
@@ -374,12 +412,7 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
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
 
@@ -394,6 +427,7 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	writel(0, rcar->base + AXIINTCCONT);
 
 	/* Deconfigure MSI interrupt signal */
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
 	val = readl(rcar->base + PCIEINTSTS0EN);
 	val &= ~MSI_CTRL_INT;
 	writel(val, rcar->base + PCIEINTSTS0EN);
@@ -484,14 +518,77 @@ static int rcar_gen4_pcie_host_hw_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
+{
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		set_bit(RCAR_PCIE_RESETTING, &rcar->state);
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+	}
+}
+
+static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar)
+{
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		clear_bit(RCAR_PCIE_RESETTING, &rcar->state);
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
+	ret = rcar_gen4_pcie_host_hw_init(pp);
+	if (ret) {
+		dev_err(dev, "Host init failed: %d\n", ret);
+		goto out;
+	}
+
+	ret = dw_pcie_setup_rc(pp);
+	if (ret) {
+		dev_err(dev, "Failed to setup RC: %d\n", ret);
+		goto out;
+	}
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
+	rcar_gen4_pcie_resume_irqs(rcar);
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
 
 	ret = rcar_gen4_pcie_clk_enable(rcar);
 	if (ret)
@@ -525,10 +622,17 @@ static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
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
 
-- 
2.51.0

