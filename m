Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794821748;
	b=dKm4tam5iABqNKQgX+77LCoar3sRcuuCIhSOSjd5h0n+R/lO0gQA+gxL0H/bpF1L1K/b
	 KZYG6+9D5/9XgMpCbspf+QZvS36imSfx7MuP4m6Xox2r3ENmruHVoDekmM0224/GRjS9P
	 hyh32/SY/n2c1Qdi+lqxny4118mqRVzW1GIFbS/64ZA8rdxaFpyC8OyaRWcPvmRQBT7UR
	 y6sD9QgoKKV666Aw2V6y9tPdTlDqHRlWY+1ozs5NIGOnEpbeHRuxVcXpQVnOSUiGsEBFF
	 TUXsH6L+Gv1ocYtKWmE9gmLm2xyIfTVmy5byCOhBTh28nnvDrXmY1ZYHAVhr3K8VGsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821748;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LkOtS9QLJh/Ed55JHkela6po+qyGdBl1lvnUWZZTMEA=;
	b=T/h9CyB6n05q5HZT81JdcCnbepAlHfkODMRZE65XjKg1wFHxdIN2C9c8vSmrrwAWZrfQ
	 rr6yyHSZzzQmkwRZmDeyqqNaNjuUka01DdKGne4putGaQu5j9OlKRcVZ2cnoTUyIyD8kx
	 JA/bmn71H69GW7jv3q3E1L8XpppKcqZ1uJWQTLR7pGLlTvScUskMteeh9FNUb7YhngF1S
	 RydBnf0PmwuMtHg5ITf/TV3daNnLQh+k6g5zuT/72TQplvuLeUUEVwM/rxW0jKCEtlqLj
	 24nEAZjebhE8XS0zCWUsFgWqUjWG6vvtEGY5/ah9vgdf0zFehtNvKW2xQxEvUH2syaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpNDt5fb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF261606A333;
	Mon, 16 Nov 2026 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpNDt5fb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794821747;
	b=rRVn42L6CcLhMp7Wx27bxbnAPn4xFmycbCYSlwjdM+RqKqfka7a50s/xj+TIOzEE78tN
	 AenwU6UvugnaT6hQHgY84YjEtIGR3Seh+FGmgpAfr0BeJUJa3V7aK5+/7RMehnckF2ID1
	 J/BdtzKRDLiS2CAz90WASuj+ekv5OSLsTx5Fe63c39qLtbkAWLi3pK10BUQXHpBtSFOGz
	 Z1qSGKAL57VeBTxn3sBdHC5ZypaHJakPoHLC1zySXFc942VqCt0c8xyU/8lTYp5sXmMni
	 Lqhs4omDJHSFKjcuaCUuP8GJ2PRJrAwdO1BIy729mARPdwMQm61jU5XTMjsDePpWH4w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794821747;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LkOtS9QLJh/Ed55JHkela6po+qyGdBl1lvnUWZZTMEA=;
	b=uwysEjOFVE6RIkentkt38dD9lGRU6FvpZGLN/SXheq3MJZjB9AqK6szb51zugF4URC8G
	 +6BRzA54ENQA7EOedP23v99gCBcEWkq9C+U87IK8h9YZ6yMA2pGicVXyx8PuO2Mgd/29x
	 uXH4nh4EE8zwpMIgKoH1NvgCHL4VlWGCwgPD4K3yRqVQhexvXJeXb4EpzwO+9dHhdZrEn
	 GxQ/3NEK6n48bro9J+pTaDmbpE3XvZJ7355555VtloVTNnHzftI5UMic2QoFVKZcFuxSE
	 Kz3fqssV/JCe/YIixa9gufMRvxfBKmLjh3pssrvdY4tlzTtIwNgpVyfpPEGHKC6W57Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F28141F000CA;
	Mon, 16 Nov 2026 09:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794821747;
	bh=LkOtS9QLJh/Ed55JHkela6po+qyGdBl1lvnUWZZTMEA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IpNDt5fbgmfJ7LrIpaFQ+MlMePRI9YSSFeV9b9oAVwiDvLaA3zC7IbvvSd4hk7mU5
	 fM79N4gvBZhbxjJ6z5pC5Rzox62SxzenNneOiv5qoMY8xNodk5duNJDtGqgtB5hz/Q
	 xT/oIdhy/6mA45XL5UeMVbb2rCNAW7VVyCjKLMVAJcAPbV0UbD1L4wS3HXWpFnCJ3l
	 q6bgntJ2wLnO5YWiuoIw76i1crj+yzVOLGmjAr99VPqONt6SfJgci9kcjsLOioE5fR
	 NVzZwy2XPxKRXjoO6FOAYl7OUaOEaRKmD2trBafUex2XDaUvbQV+cA4WyqX5YlNKvc
	 Knsc0LibYzq9A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9BB6F4A40E;
	Mon, 16 Nov 2026 09:35:45 +0000 (UTC)
From: Matt Thompson via B4 Relay <devnull+matt.boondocker.io@kernel.org>
Date: Mon, 16 Nov 2026 02:35:47 -0700
Subject: [PATCH RFC v3 5/6] PCI: rockchip-host: Defer retraining during
 initial link training
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-rfc-b4-v3-5-0bf052b68f2a@boondocker.io>
References: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
In-Reply-To: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794821744; l=4671;
 i=matt@boondocker.io; s=rk3399-rfc-20261113; h=from:subject:message-id;
 bh=KUXpKSAKyk225bpT79IH2hk0YJswSkRu8Uhog5/Ier8=;
 b=sNVtW5seraedhdRLtk/01tgNfKXot3Oe0ZrNnzO7kxnYpnZRc9MJhR0eFYN8XN15mSkDH8B5P
 iKpB8swdS4NCD8ogtJv+gkpNAEPatfYGTf7msQ1lNr7PkDL9KlitTKG
X-Developer-Key: i=matt@boondocker.io; a=ed25519;
 pk=WMnh3kwFFRkrqamL/FbDcdl1/9rBF2uT03VdvGGP40k=
X-Endpoint-Received: by B4 Relay for matt@boondocker.io/rk3399-rfc-20261113
 with auth_id=1517
X-Original-From: Matt Thompson <matt@boondocker.io>
Reply-To: matt@boondocker.io
Content-Transfer-Encoding: 7bit

From: Matt Thompson <matt@boondocker.io>

Clearing Link Disable starts initial training. A retrain request can
arrive while the PHY is still in Detect, when it cannot recover a data
link that later stalls in initialization. On RockPro64 the link could
reach L0 while the data link remained unable to pass configuration
traffic.

Remember an early request and give initialization 50 ms to finish.
If a later downstream access finds the PHY ready with data link
initialization still pending, issue the saved request once and leave
configuration access blocked until the data link becomes ready.

Signed-off-by: Matt Thompson <matt@boondocker.io>
---
 drivers/pci/controller/pcie-rockchip-host.c | 45 +++++++++++++++++++++++++++--
 drivers/pci/controller/pcie-rockchip.h      |  3 ++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 64ac6f4..d6c494f 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -19,6 +19,7 @@
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
@@ -123,11 +124,28 @@ static int rockchip_pcie_wr_own_conf(struct rockchip_pcie *rockchip,
 				     int where, int size, u32 val)
 {
 	u32 mask, tmp, offset;
+	bool link_control = where == 0xc0 + PCI_EXP_LNKCTL;
 	void __iomem *addr;
 
 	offset = where & ~0x3;
 	addr = rockchip->apb_base + PCIE_RC_CONFIG_NORMAL_BASE + offset;
 
+	/*
+	 * Let the PHY finish initial training after Link Disable is cleared.
+	 * Retain a request made during this phase in case the data link does
+	 * not finish initializing on its own.
+	 */
+	if (link_control && (val & PCI_EXP_LNKCTL_LD)) {
+		rockchip->retrain_pending = false;
+	} else if (link_control && (val & PCI_EXP_LNKCTL_RL)) {
+		rockchip->retrain_pending = false;
+		if (!PCIE_LINK_TRAINING_DONE(rockchip_pcie_read(rockchip, PCIE_CORE_CTRL))) {
+			rockchip->retrain_pending = true;
+			rockchip->retrain_after = jiffies + msecs_to_jiffies(50);
+			val &= ~PCI_EXP_LNKCTL_RL;
+		}
+	}
+
 	if (size == 4) {
 		writel(val, addr);
 		return PCIBIOS_SUCCESSFUL;
@@ -149,8 +167,29 @@ static int rockchip_pcie_wr_own_conf(struct rockchip_pcie *rockchip,
 
 static bool rockchip_pcie_downstream_ready(struct rockchip_pcie *rockchip)
 {
-	return PCIE_LINK_UP(rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS1)) &&
-	       PCIE_LINK_TRAINING_DONE(rockchip_pcie_read(rockchip, PCIE_CORE_CTRL));
+	u32 status = rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS1);
+	u32 core = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
+	u32 control;
+
+	if (!PCIE_LINK_TRAINING_DONE(core))
+		return false;
+	if (PCIE_LINK_UP(status)) {
+		rockchip->retrain_pending = false;
+		return true;
+	}
+
+	if (rockchip->retrain_pending &&
+	    time_after_eq(jiffies, rockchip->retrain_after) &&
+	    (status & PCIE_CLIENT_LINK_STATUS_MASK) == PCIE_CLIENT_LINK_STATUS_DL_INIT) {
+		rockchip->retrain_pending = false;
+		rockchip_pcie_rd_own_conf(rockchip, 0xc0 + PCI_EXP_LNKCTL, 2, &control);
+		if (!(control & PCI_EXP_LNKCTL_LD)) {
+			rockchip_pcie_wr_own_conf(rockchip, 0xc0 + PCI_EXP_LNKCTL, 2,
+						  control | PCI_EXP_LNKCTL_RL);
+		}
+	}
+
+	return false;
 }
 
 #ifdef CONFIG_ARM64
@@ -914,6 +953,8 @@ static int rockchip_pcie_suspend_noirq(struct device *dev)
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
 	int ret;
 
+	rockchip->retrain_pending = false;
+
 	/* disable core and cli int since we don't need to ack PME_ACK */
 	rockchip_pcie_write(rockchip, (PCIE_CLIENT_INT_CLI << 16) |
 			    PCIE_CLIENT_INT_CLI, PCIE_CLIENT_INT_MASK);
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 1cc3621..5fdd06b 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -58,6 +58,7 @@
 #define   PCIE_CLIENT_NEG_LINK_WIDTH_SHIFT	6
 #define   PCIE_CLIENT_NEG_LINK_SPEED		BIT(5)
 #define PCIE_CLIENT_BASIC_STATUS1	(PCIE_CLIENT_BASE + 0x48)
+#define   PCIE_CLIENT_LINK_STATUS_DL_INIT	0x00200000
 #define   PCIE_CLIENT_LINK_STATUS_UP		0x00300000
 #define   PCIE_CLIENT_LINK_STATUS_MASK		0x00300000
 #define PCIE_CLIENT_INT_MASK		(PCIE_CLIENT_BASE + 0x4c)
@@ -325,6 +326,8 @@ struct rockchip_pcie {
 	void    __iomem *msg_region;
 	phys_addr_t msg_bus_addr;
 	bool is_rc;
+	bool retrain_pending;
+	unsigned long retrain_after;
 	struct resource *mem_res;
 };
 

-- 
Git-155)


