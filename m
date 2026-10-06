Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020121.outbound.protection.outlook.com [52.101.228.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031F3EE1EA;
	Tue,  6 Oct 2026 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276429; cv=fail; b=uLysBB/VAxgqZPmX6fCT+VRVWwDcW4R3YInggOVTErS8b3eleWoVyV1nlA1v8HPhEvUWbsMWB45G0Wl/iadtjKmFEgdkuCojfjOtO7PE//P3tnQPdd6Qi2u9nqFuoooylaOxnsnZPyEYwGs7nu3rNE6HdQf0jlb6jWCCxzpnIvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276429; c=relaxed/simple;
	bh=sX2LJa1PpZFPCcEeZcUSayR/zP8/4lj8fswmWILB+aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=efv2c5Pn/tCV1d5drWrTxDIfgxfy8lmLX/R+BqNd1RM0fu0uI4K3cOumf+IX0jWpAj4c/LFT31Il2DeU+uqJ3a9v1355Cm3Ltlklc5DCbEaAi5BGsK9s4MSCelZSm+HQGRJgdFmQp/Z9EMiYxZfLUZFjJhjg6jRcStTbZcGN4cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FKH2nwwi; arc=fail smtp.client-ip=52.101.228.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FKH2nwwi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uk0FgmQ/bX08q/2ACAlbY3uVQ17Kz2Dmsl8EE+CP8zk5rCDpFno4F1sPKDxeAHUs4insdpCjrrJx9dAmRTeF6+cgglbvrXQZ4qolEXc7ZO36yKju2JmD0+ZHnnuaMkySeiyyQKZ/NqGfFsENAQFAUzsv+yLYyx1EqLfmurDPVdFjl4+UPcc+iDVj60P5nhoGfUHPVKtR/GQGomUfIkFIIa9EGTnPET8r/NhDCYPX0MunykHlBVpC5ltvPqpMvyAMDDaFhkR+aBoGxE5Ty0w4x1SX6ZD43Am9jKTzUuSY7U97M94Nkdde1D2zSYUXcCqu4oTeftZwN8BUH6Cw+U6LFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFjYhPqnS+pn/epxjO5TRfAwJvZtwwYnPp3Cty3Iolc=;
 b=J7eXjskh5a7zklbToBpcOlfZXPd2Rc1F/CGvVQ22pLPTjOCQWnd9G7nVO2aGVqcRHKjjPPruyUKKhaHakGb21P/RCH11N/ywY2D6/5x/zNO09AwB52PX/uWnjJLXYxm4TAR1Jp1HjGvt2vh9nRuIjigEkAUMCtmEeQjo+l4DH7D4PtXjl8D7/5uSrok3etHeMDWuROKk+EeC6BgTDkwatIs+1bpOnmmjjcZ92vqeGSHpHJ24G/AdTAlTM2GPHpaZhD8lkTSBHeVGCAvfCR7KziPO6gd7fSw4s6Yzlc8tnVHv5s1QUV+boRcGH3Hpe2gf9oUFIlSSWkskmsJsrVBxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFjYhPqnS+pn/epxjO5TRfAwJvZtwwYnPp3Cty3Iolc=;
 b=FKH2nwwiAYz874t2+j2h7Q/d8XXYq37mAAxR6ShCM9wEdL3XyN8ow/XqTruLngzTwGxDrP5vPuMUwX0dDARgR7vomkpaYxqnQPaK3ZoaTU3WgufGBQIxQ/J56iibzJYgGW0L07qPb1xFGs6cweQVnQdxwt7haltbVLIgAd3vLik=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:46:57 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:46:57 +0000
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
Subject: [PATCH v3 12/18] PCI: rcar-gen4: Recover the Root Port on link down
Date: Tue,  6 Oct 2026 17:46:32 +0900
Message-ID: <20261006084638.3821710-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: b57a18fe-d2b1-4591-e8bb-08df23866104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|6133799003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YFnUvM+KSKsfwVIiJ06dfjQlcFo8GvasmEQxylS+m0TF/laeudwtK258XluT2Ghzn+4BQwrx5qkHSsfgrTVhL4OtaDsuTTfexnEUNxKAFrfoR7llLTLJPGUC+3uluRDHNi/n7crYMhQIANvjrxRWqImybFELlQO7da+/DDJaW/9316OqebvYYkQufUXIOl/1cy409VUE+TRf7hp3at3kz6MBmGpOIWl5vFatOG0ri8T8KQjZ086q4zLTHvHdbdfjkSanXHMNHPXExUNdA3MsXfVn6UY6XPqxuNoZwHvUrh2iYN9xJL+HYCeKIV2tdjiE2NSCAeb2FeJNamxPteslJZVoxmvnRmn2wbsgy6T/np7eRCI+5OQlX8GvqX9iUypmh+h1ShFHkX/9o1PdzTODpvA9ruZOCIdrN/aoK6WewHJnTq91nCmSpyBfyQCiUIs3dcCp+7qY8ROl8KvenvOaObyuwTthPKhNRxF4q/S1q3aR3dgaBEsXvEbrpSfWY+ZSl0asCbrd/bVZbXdn4p2JL0Xdj1T1zRP5TFBIeuIrRNYPDLHFwI+4HALOr3Z2e0xWu9+QQ7LraYHybzn8sW50qnpBwiUUqHR/UYaplY6B8uhBWAg8+NDtJisGNUo6kFMBqTPcHuc52Z0EzCS1xz8ncjpbdyWIPxL4gJam0OMtVdQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kJ9czUQMWLaDuOpar+CAmUP+qWhKppJ8hsTpTHyWM1SxxUrqBezvFyyGK1li?=
 =?us-ascii?Q?UP2Ay+JfX+X19HdNthM6omIU/Yf0dr6Om+w5PycM8dapMh2tBnXkdaeXZ9Gq?=
 =?us-ascii?Q?I5e3QnPIHPwvVwRRq8FhqyfqDnc3cUr6pm5cjk7v52OLuNCy4KPydMaiQXoN?=
 =?us-ascii?Q?CGY3nCLbsOE0KlgZEUAj/GtSwUiaQIt0PS/Ya/cWyFBCTYRAmgtuorEXAHzq?=
 =?us-ascii?Q?YZroqgnpuzx/ARxPzOV+mfGsAvkYm3rh/h6vkFYHZzpz1DZR4lukvuvgYvzV?=
 =?us-ascii?Q?j5w7I6QnzpIsno97HSYM4Jb+JJbHGVGmYrhcS8gt6kXTNB2mp/04fu6Xh+KZ?=
 =?us-ascii?Q?ZSFoxkkq+XRoWNedoWhcZ/EYhmHVh/44fYQA90pl8UQismnPA6QVVrSEUNVX?=
 =?us-ascii?Q?VrVvkM2AYex+Mh++XRBrbowMei16AUXQV8QwkWJ0BMv6mpj3aDmuk354kkDX?=
 =?us-ascii?Q?gRoWF5GGCoqi8/5A6FdvuJUIM/ElDwGingjWfwQ57Jrs4Pfr97HG/nUSuYic?=
 =?us-ascii?Q?H5C2qYZsm8NyNjLMMANFlDSDug18ZP2cS+aRP2sTpp35c6pNeVfTZljFyAzC?=
 =?us-ascii?Q?nAHVnIjtDFxAV0ScctC79fEIXDivMA5sxtjV9rE4eRmGMoiSZKuBjS1qboxp?=
 =?us-ascii?Q?cIF5QNC92C913f1sQ4w7cdjDe62EX5raVVAzaEGVz6C62NdaKOwW3TcsAKla?=
 =?us-ascii?Q?nW2DU4EImYz9DlL39EDT0v0+zZdNtREgNI3vRqq3ddfcKgv3WHjmUzic9yMP?=
 =?us-ascii?Q?bXjLd4qklUlv+Lxs4szpSIkPexUuu+rQS28LIp8QRnre3FrVt7z2eJJLT3W7?=
 =?us-ascii?Q?6Lw3qzcxKlAquiv6eBsnMdDbLG57DFSQhDHghoPwc9XqIURsECkwJdEbsFhe?=
 =?us-ascii?Q?trObw5tYEw2erY2ziJBQDYS0FuST0fXnHZCgop2gcfeg5EsSnQTV3Ss/kUX2?=
 =?us-ascii?Q?BgZlNeXW4OAfOa8omw4/07a7Z49CAXhH+u3IJmfJ8kTUvEeVzSenqWi3wYG0?=
 =?us-ascii?Q?i5wwAnrzWINqKycHJHE7g9IB93MZd5c3WqUYOj9J6xVsK7cRVG+3j03Tpx+6?=
 =?us-ascii?Q?kEuvxsywke8QanRSCM2EQsjhvkq5usvawmeS0eid/5YqOhHkZKgP0XusCDbu?=
 =?us-ascii?Q?vYH6wCke2mOJ0mJ0EO2I+X1UuiYwDLk5Ge1MDdEusmqo7gHNKHi8C+Qf/3/6?=
 =?us-ascii?Q?q7w/tNBQKICauT+3YdSu5CRioYiFbInYq2LYZNLNLtSGaArd7PNhdtJmKJRE?=
 =?us-ascii?Q?7xXfqoji8fr+hTANLD0bH2110NwQRT1WOsm4l78KKK4y3c5h61JXb4SA/N7X?=
 =?us-ascii?Q?aiQz3/YdXsTqeDauSdQ5G/9arAy8yw/zv4GTdNMzfhTq3IhNC9FZrALciTlE?=
 =?us-ascii?Q?NhKk+a/kaPe75tGJgEkQ6IP4jfUqrVm/vl7Yz8UXAX/wOQlqosgr3Qcb8KLa?=
 =?us-ascii?Q?CtLyxQlmg4uHQCI1k57yBcsvpXE8tl1w+jBxiOKylsBmle0xHDOHedzjx4Wd?=
 =?us-ascii?Q?0qb2f4CdFCA8OeJ4vPQBTJCI1Dp/xuKChj2lDnBMzSOjCUK6NT2eRDlf0Lg1?=
 =?us-ascii?Q?quUir8Qn2m6u9rhPZsHxCfz5+DnTaJpNJ7gTX6r5aqvPXOVWxUPw2YqvQqDu?=
 =?us-ascii?Q?uWavGzJPWazzudMnnWVOlC/UhL/x2dElKg+9V/UuHhwBe2ZhzgTvsjMt1hof?=
 =?us-ascii?Q?bg/adkpT309m/Ut864C0t9yZ9xviYa+78KNs6r79E8DTrbAchRAPAU7L9P8r?=
 =?us-ascii?Q?Xdc7krBDS+f8E7UxceriSn96pU6vcVBw1UJmJSZc6C1KNtW8c84v?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b57a18fe-d2b1-4591-e8bb-08df23866104
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:46:57.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AS6l/Uglf10DYm44JWhILp/18Ps9Qs/p2SdBJM1bp0HPm8+bCRcWWuh0VyR06+zjixBJWr/e47uFNlesjBGCWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

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
Changes in v3:
  - Keep recovery outside device suspend/resume with a freezable workqueue,
    and reject suspend while recovery is pending.
  - Disarm Root Port events during suspend until .post_init() re-arms them
    after resume.
  - Reset the controller directly if the Root Port is absent when the
    work runs, so interrupt delivery can resume after a successful reset.
    Serialize the absence check and reset against rescans. (Sashiko)
  - Warn when suspend is refused because the controller needs
    reinitializing.

v2: https://lore.kernel.org/r/20260928165230.3397664-12-den@valinux.co.jp/

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
2.51.0

