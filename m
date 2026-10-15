Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021109.outbound.protection.outlook.com [40.107.74.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FE43E8328;
	Thu, 15 Oct 2026 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035094; cv=fail; b=Bb4ymU5LH2TvhwKeSND0OTDnqF7w53tFCJeibnV/57GA7N3Zpy1/RPl25n2ynY8a9+JreqMmCbFHvDPY/UKgfK23jkJ1ArMrnWPaM/JX12zBi4ixRjtBzfIAwgFReEgJXLLQniQvI7rLQpfc8dWrL+CrtBYMhX4xJsHXcOzwFQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035094; c=relaxed/simple;
	bh=6IbBNeRYuilqApOIKHDs3h97C6KgKGho0CnTh7DXTwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MfGJIvOXNCAnQcPIy+/rxSr3pImI5WZDQw6QZhpkMCyIC19GKH6YP753Wt3FSGmH9/HaxRiAtPFyUkzNjqHI20oyGBJiu3zSEtN5z2BCxeyIEO1gFY7bZZPSGdrVhX91MyMlSg5HinUHDnCBJG/txedajIj0OgCCdV5/6lNbyds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FQH6S4Ex; arc=fail smtp.client-ip=40.107.74.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FQH6S4Ex"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUz0LYoCIX+TMXRma0nJm294lLoGXJIeQhhSnC/iSLpcSMpgx/hwgP938kGhwbOzX3jPxm9xh0PXk34F92tsxxXvJVOjWWN4vc03vtIaO6e9mNzTUcjElGqdcWvNohBTWTeem74nd2NwFADfMi76aw4AaDSV+tFvctTbZlOKbWugGOSA58FMas8Q6H4OkMgGRFXwZqa35CLdFLa2UrpGNzXmc68h2/9oRf8Nrnc6Xv7AW8xaEGU/qRo6fKdsbgtOLcd2ZF9/7hNNYu/RQ+kiOab8LTg/JNxus9zkZiMRPSQVw014VD7FqZjlP79QEFvJrHZX3+YzjBsfZow9vU0XhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIw6grO0jvsaqcyMwlO7/Woj5o4wUqirdGbJ2eamROA=;
 b=R7Tr/VoHYTYjco7a6IvCnaIeu9tcssRrh9pmxX48nMM0cAQHt3z0E1IMzafzzlXNK3R+Y67MX64aaG4uyH4CBx3RCL0ywb8Bd/y23eb2LH+zwzljrINfCIvmEk3jPwWi2tp0WjMboe8oSlgqYN6OghuNsT5m15vNFdfgxNtsYlif8MKjJNnr794pFcmF+f70CJBWAWaDGicuCei8IuruMSDmQjuuOjYFmVC29ic9OlgKAODOXqXelND5nPhQkuzeC4v56FCIVB358OO7jMnnsRDUBsDUOMjrTWl6hVkcQmwvZwSpFzEsYXDgEC8n6bYdkhnrLGaAbDiRNKQPN2B9Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIw6grO0jvsaqcyMwlO7/Woj5o4wUqirdGbJ2eamROA=;
 b=FQH6S4Ex9QoKIpX9DzuBtj3mdSo0AIFsB/86aHbFGMjBPF2mgI2vM4/F9Q5Yh8AUDHNUuB4tJo5vqUwLaId27gsksJB94Tr6XguCvGsWcWuxaXKwEnGbDy3XG5mz7CQRRHH9v2O/1owXyseEDC6gPboDz3EJiaLL7c2VvTarb84=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:20 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:20 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH v4 12/18] PCI: rcar-gen4: Recover the Root Port on link down
Date: Thu, 15 Oct 2026 12:30:57 +0900
Message-ID: <20261015033103.3076869-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0071.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: 019a5405-a8bb-4166-443b-08df2a6cc78c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|6133799003|10067099003|22082099003|18002099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hMc7XIaaH91gxlzcKvsDaSV23L7C8wPGnYPI5W37S0lt+jSihZsrzzIisSA0KZvnMCAUtXs/3FqqOkB189rVPS5LeJeXWZ7Nh8BKLnFPL+MY8J8B/8MQC/GO8a2lEYp4amystZA/3dSUM0qrYfdZPBB6z+SfbodbpAuL2d5ug3kmz/mz1lxortAnUv9i5RzpuDJzqc8K7Wk2vzbopWnmTx0lOygcazdZ2ZRBLY9YCTk0ygHWE+0cRcF2a7wIDzFNwGnXv4AOorlZNuJnaQM+nZEc2v8M98gR6RBpibkmxQWNIaLME8n/uzQaLgYnguNwHHgz8+5E1jbyi/4yXgPSeMvFNsQc5qzriURdStpGHiYHVQ5XJdSlRdRQuJFS5LpiiRe1lgDfXr1Ayh0n8Lt/Kcxry7vhm0/8RX7ebYeW+dkKGIqXzax5+nXcnTLD+/oRkdu3Ru3vEjQK+9yUnS5LPlwv51xC9R4ozjto/6mxJNt7hHdUDc5JU508kp56fnV5RnpE78rMF5ROMEH2A2LL3VSOe1tbmshTXHuYrDj+LgQ0QrD01MO9etDWIK5M7Hv9sXiIDhdHdKvQc5BxDApw3WZgVUGu4agVezyYrz6/AFIQud2GQreBcWu5M+RKvUQgcoS5SNqhEZ1Te4Tn+oziJbAtyhNToX2WsCJz3AgpXuYQR6g4fEQtGO9Oh3jJ3ansh1SZObx/fZ5AQE1ecWvxbg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wCUR4acCCntJYuMlC5jw6kO8+IlhxpSrI6shkRLURMDOs5P5/A5GsL1AFYxL?=
 =?us-ascii?Q?mo0RvRbyOqoNsf2eUNWFI6/yFUXBY19yg20oYd/3aWrpGSZrHJUnDVmM6Bq4?=
 =?us-ascii?Q?SMLHEIg4Pe+iMGmtLe396AKvVPevDVoDS9Zym+H8WMm+Z7OuTVWEIQ6KIjpY?=
 =?us-ascii?Q?2xkEaOVCHFY8ADzW+W1txEBOPfSuXd8lSxzsN2tgDiRAyswrRB7w5ol/VHlE?=
 =?us-ascii?Q?16l2Zs4IWWug/xO4vKt6LwXtp2p5kVtu4JeByN502DLDr8hFJ4blQLJB9wcY?=
 =?us-ascii?Q?0WCUX59p8zPJWlH8o7LUq1ENIzYTYuEJchwREm6YEkEJxvQtFUoa7z8gKL0K?=
 =?us-ascii?Q?B7Y09g/VHkTNSWBDQG52MkAosC2ZlFFKIo3l2PSfNsViBKFrwhCuZ3VN+gCT?=
 =?us-ascii?Q?YFIqmBxbzVwmE2tI6OlG8PLF0xAP0J39TUFfX8C1XNk+Nj5qwF2ZmYWJjoeZ?=
 =?us-ascii?Q?cwDlwU2xIWcg939nQULoFUF0Va76LvaSB1Kh1zpl9fDlXjMMpEurbGvWykwo?=
 =?us-ascii?Q?NP89UyGNLmzMgl1PBe05TqmKguNFf9fZ+SwFBbdGFbF96bLBU8w7wN0jGiMF?=
 =?us-ascii?Q?1UOeQyh62tAaGTTxgyPbhnAut/2aUkN+M6x5JmqvV0trcHC89aha9etA2RWh?=
 =?us-ascii?Q?n1KEPMQfkSYDscO6nNIvPvPyz+Jl6e+1RQ6yGWkarTGYOn0bSS4L9e3Aqr0/?=
 =?us-ascii?Q?dZ4mswm/RWxhM0ywEWNPu9reyjWMTlGA2ytEc5NhKTauugjZNlkn19ubWXoz?=
 =?us-ascii?Q?Is5g3ob4pJ85/6EnVY7RH9S4Tu5mHYooN3WFtoLWFSTSnLJHKv1G2oZqZgYo?=
 =?us-ascii?Q?p9SPs+1THSBU+U1pCfFVaEqroEvUGX63TdmNileDfBNTVgRqhonoe5EQI9Jb?=
 =?us-ascii?Q?jKG0WwPNgRbDPOhzoSlz1izbcT9p/qd/+wlMOh9od4EjwOiqIYIBz4JHkx7T?=
 =?us-ascii?Q?b3eyh6JnBnK1VNksD//9JdvcJdwCNDCZQi/nX9mHX1vdz1H1hVudD1PZudcp?=
 =?us-ascii?Q?iOCBZHxEibVZ5gd9CT5BXI2KUyin0102Cb/bNgBnyROxFgfRuGHyzB+plGAu?=
 =?us-ascii?Q?+3RkPnahsFOf77HInzQLENg8B3hchUOS4xvGSNbF3+1FVpqt0wnCWq/fhdkp?=
 =?us-ascii?Q?5gK908vhJYn6rCV8POA9MvGnAco9LNPjz+OFrZ4/w35tQhk6sRnMyOgyC/dt?=
 =?us-ascii?Q?0teTtHXUJfE4l0iMnOMuurOLZrDM9WdQHWj17nwHPpcijgBrrKfFxRIyuqTC?=
 =?us-ascii?Q?/XuPQJUTohR8rzw0as8diiKNOanRRsDA65HHcXWkGNSeImYoOkRa+kcOVsOj?=
 =?us-ascii?Q?JYW2+Tfxdb5Htnfgi4Gda5qVmNFHWyMjDwINQEjgzRdlmt1dLbqwlhR6K6tN?=
 =?us-ascii?Q?D4TiMG46nldp/omjDR/jhrPHpxC0Y+XjWNIPhAufCqRbqFX2Ux0C/eQAQiww?=
 =?us-ascii?Q?W7c2nzGTeTAkmqDuTAhU3GXwt+/cslA2ZyD1wULK177hCke9AGcozzE4GrSI?=
 =?us-ascii?Q?G49ggy4tJtQ71k4cz/kfTgjWUe1/S+2N1aPHXcPEsk4Ll1yoOyxFgin6oB1H?=
 =?us-ascii?Q?ZqDvQ4tWHZ++KDw60MgTFAv5uVrF5PWeBuI4AbPto7VrUO9vhVOaj7klnEAL?=
 =?us-ascii?Q?6JzLU7by3L6cV6joJXB05Kg1Y/mpN/AJZb0C9JXDMuP2IY2PaN0SCs3LFhEU?=
 =?us-ascii?Q?YnVgMdNMw353bwOLXMZkscDA97SSwgtw06gjZj/vpfKo4F/CjPixgnkNwy4E?=
 =?us-ascii?Q?9+2S9YPjezBttirV9xBBTl28Ijt58RjwvSRiCTWxtSfyRi4PxJ3C?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 019a5405-a8bb-4166-443b-08df2a6cc78c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:20.3513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqSZH1Q8VaZ1jt2HQ53KbvrXqXKZmmlyNmCxZnqco9bZNofHzI1Ghujc1Sj/DDBSHwFljYPTd3TgSqAejV4/AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

On R-Car, the controller's reset requests (smlh_req_rst_not,
link_req_rst_not) arrive on intreq_pcim_sub, the interrupt the MSIs are
demultiplexed from, so DBI is read as soon as the link goes down. On
R-Car S4 that is a hazard: DBI accesses issued within a few hundred
microseconds of an unexpected link down do not complete and hang the
host. In testing, the first Root Port config read after powering off
the link partner hung unless delayed by ~300 us.

Check the APP reset status in the interrupt handler before DBI is
touched. When a reset request is latched, flag the controller as
needing reinitialization, which masks the sources, ack the request and
schedule recovery work. The work calls pci_host_handle_link_down() on
the Root Port, which runs the AER-style recovery and resets the
controller through reset_root_port(), holding a reference on the port.
If the Root Port is absent when the work runs, reset the controller
directly so that successful reinitialization can restore interrupt
delivery. Hold the rescan lock across the absence check and reset.
The APP reset-status check also reports a recovery already pending,
whether started by another interrupt or left over from a failed reset,
so the handler issues no further DBI accesses until a reset succeeds.

Arm detection after initial PCI enumeration, so recovery does not
interrupt device discovery or resource assignment. Only unmasked status
bits are handled and pending latches are cleared when the sources are
re-enabled, so requests recorded during probe or the reset itself do
not trigger another recovery. Teardown only disarms the detection: MSI
delivery has to keep working while devices are removed.

Run recovery on a freezable workqueue to keep it outside device
suspend/resume. Reject suspend while a reset request is pending,
including one latched after the parent IRQs were suspended.
dw_pcie_suspend_noirq() would otherwise access DBI, and the queued
recovery can run once the system thaws. Disarm Root Port events during
suspend and re-arm them in .post_init() after resume has set up the
link, so taking the link down for suspend does not start recovery.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 127 ++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index d51c0fc5ff36..b8a5bfaf0bbc 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -25,6 +25,7 @@
 #include <linux/reset.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 /* Renesas-specific */
@@ -40,9 +41,18 @@
 #define MSICAP0_MMESCAP_MASK	GENMASK(19, 17)
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
@@ -53,6 +63,9 @@
 #define PCIEDMAINTSTSEN		0x0314
 #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
 
+/* PCIe Reset Status Clear */
+#define PCIERSTSTSCLR		0x0330
+
 /* PCIe Interrupt Status 0 Clear */
 #define PCIEINTSTS0CLR		0x0340
 
@@ -117,6 +130,9 @@ struct rcar_gen4_pcie {
 	const struct rcar_gen4_pcie_drvdata *drvdata;
 	/* intreq_pcim_sub ("msi"): iMSI-RX and other controller notifications */
 	int msi_irq;
+	struct work_struct link_down_work;
+	/* Allow Root Port event handling after enumeration and until teardown. */
+	bool rp_events_armed;
 	/*
 	 * The controller needs reinitializing; the APP interrupt sources
 	 * stay masked until a reset succeeds.
@@ -543,15 +559,35 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie_rp *pp = &rcar->dw.pp;
+	bool rp_events = rcar->rp_events_armed && !rcar->reinit_pending;
 	u32 val;
 
 	lockdep_assert_held(&rcar->app_lock);
 
 	val = readl(rcar->base + PCIEINTSTS0EN);
 	val &= ~MSI_CTRL_INT;
+	/*
+	 * Note that rcar->rp_events_armed is not checked here because device
+	 * removal may still need iMSI-RX interrupts after Root Port events have
+	 * been disarmed.
+	 */
 	if (!rcar->reinit_pending && pp->use_imsi_rx && pci_msi_enabled())
 		val |= MSI_CTRL_INT;
 	writel(val, rcar->base + PCIEINTSTS0EN);
+
+	val = readl(rcar->base + PCIERSTSTSEN);
+	if (rp_events) {
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
@@ -616,6 +652,50 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	return ret;
 }
 
+/*
+ * Consume a latched reset request and start recovery. Returns true if DBI
+ * must be left alone: a request was just consumed or recovery is pending.
+ */
+static bool rcar_gen4_pcie_handle_link_down(struct rcar_gen4_pcie *rcar)
+{
+	u32 status;
+
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
+
+	status = readl(rcar->base + PCIERSTSTS) &
+		 readl(rcar->base + PCIERSTSTSEN) & LINK_DOWN_RESET_MASK;
+	if (status) {
+		/* The sources are only enabled while armed with no reinit pending. */
+		rcar->reinit_pending = true;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+		writel(status, rcar->base + PCIERSTSTSCLR);
+		/* Keep recovery outside device suspend/resume. */
+		queue_work(system_freezable_wq, &rcar->link_down_work);
+	}
+
+	return rcar->reinit_pending;
+}
+
+static void rcar_gen4_pcie_link_down_work(struct work_struct *work)
+{
+	struct rcar_gen4_pcie *rcar =
+		container_of(work, struct rcar_gen4_pcie, link_down_work);
+	struct pci_host_bridge *bridge = rcar->dw.pp.bridge;
+	struct pci_dev *port;
+
+	/* Serialize the absence check and controller reset against rescans. */
+	pci_lock_rescan_remove();
+	port = pci_get_slot(bridge->bus, PCI_DEVFN(0, 0));
+	if (!port)
+		bridge->reset_root_port(bridge, NULL);
+	pci_unlock_rescan_remove();
+
+	if (port) {
+		pci_host_handle_link_down(port);
+		pci_dev_put(port);
+	}
+}
+
 /*
  * intreq_pcim_sub carries the iMSI-RX interrupt along with other controller
  * notifications, so the driver owns it instead of the DesignWare core (see
@@ -626,6 +706,10 @@ static irqreturn_t rcar_gen4_pcie_msi_irq_handler(int irq, void *data)
 	struct rcar_gen4_pcie *rcar = data;
 	u32 status;
 
+	/* Check reset requests before MSI handling, which accesses DBI. */
+	if (rcar_gen4_pcie_handle_link_down(rcar))
+		return IRQ_HANDLED;
+
 	status = readl(rcar->base + PCIEINTSTS0) &
 		 readl(rcar->base + PCIEINTSTS0EN);
 	if (!(status & MSI_CTRL_INT))
@@ -664,6 +748,28 @@ static int rcar_gen4_pcie_msi_irq_init(struct rcar_gen4_pcie *rcar)
 	return 0;
 }
 
+/* Keep link-down recovery out of initial PCI enumeration. */
+static void rcar_gen4_pcie_rp_events_arm(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
+	rcar->rp_events_armed = true;
+	rcar_gen4_pcie_app_irq_sync_locked(rcar);
+}
+
+static void rcar_gen4_pcie_rp_events_disarm(struct rcar_gen4_pcie *rcar)
+{
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		rcar->rp_events_armed = false;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+	}
+
+	/* Handlers queue the work under app_lock, so none can follow this. */
+	cancel_work_sync(&rcar->link_down_work);
+}
+
 static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
 					struct pci_dev *dev)
 {
@@ -871,6 +977,9 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
+	/* Re-arm Root Port events in .post_init, after link setup. */
+	rcar_gen4_pcie_rp_events_disarm(rcar);
+
 	/* Stop the handler before asserting reset and disabling the clocks. */
 	rcar_gen4_pcie_quiesce_irqs(rcar);
 
@@ -881,6 +990,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
 	.init = rcar_gen4_pcie_host_init,
 	.deinit = rcar_gen4_pcie_host_deinit,
+	.post_init = rcar_gen4_pcie_rp_events_arm,
 };
 
 static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
@@ -892,6 +1002,7 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 		return -ENODEV;
 
 	raw_spin_lock_init(&rcar->app_lock);
+	INIT_WORK(&rcar->link_down_work, rcar_gen4_pcie_link_down_work);
 
 	ret = rcar_gen4_pcie_msi_irq_init(rcar);
 	if (ret)
@@ -913,6 +1024,8 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 
 static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 {
+	/* Cancel recovery work before removing the PCI bus */
+	rcar_gen4_pcie_rp_events_disarm(rcar);
 	dw_pcie_host_deinit(&rcar->dw.pp);
 }
 
@@ -1310,6 +1423,20 @@ static int rcar_gen4_pcie_suspend_noirq(struct device *dev)
 	if (rcar->drvdata->mode != DW_PCIE_RC_TYPE)
 		return 0;
 
+	if (rcar->dw.suspended)
+		return 0;
+
+	/*
+	 * Recovery work queued after the workqueues were frozen cannot run
+	 * until thaw. Abort suspend so it runs then, instead of touching DBI
+	 * here. This also catches requests latched after the parent IRQs were
+	 * suspended.
+	 */
+	if (rcar_gen4_pcie_handle_link_down(rcar)) {
+		dev_warn(dev, "Controller needs reinitializing, aborting suspend\n");
+		return -EBUSY;
+	}
+
 	return dw_pcie_suspend_noirq(&rcar->dw);
 }
 
-- 
2.54.0

