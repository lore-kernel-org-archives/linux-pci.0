Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB9554083;
	Tue,  8 Sep 2026 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879134; cv=none; b=pTmi9KrHkE56D8PjOMIGLDZtkity89y0IZSh95D1zbY5Gr63nrm2d5ZNQaVxNkIcZQ74biIxEDwp78ge/45A3eHYBS00QZJFQuOrGcU7IevbIqJ3JiKU2XbQe7fjJ1JbJYuomWkOR7RTokksZYfQGuXE7YfOWG9OFjo7ECjdZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879134; c=relaxed/simple;
	bh=pQ075WLFf2brXAVxwHCIqRV7MiZ2UQ9bz57J6cuXjls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fo3MhqUyd0zPsDK7poM6ZQuYmrpFxesdZ3pi+Ih+jENAWcIX6v+K1372FmqUJGCz/bMWsZAStsJTcwaM+g/cTxWwOBWLqVSzv2VY8hy/MRUXx2ghPt2AinczPPDBDGoGl7X1ze7KqPn8tAn/xJyS6p9me4okz1t4qQmQ0/V2/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Tlr2ZA8x; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Tlr2ZA8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788879101;
	bh=pQ075WLFf2brXAVxwHCIqRV7MiZ2UQ9bz57J6cuXjls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tlr2ZA8xG8wupPbHFg9adiM37IzUpaw5DIVzYbhDijv9DA17+mrqZFRk65xYfRwiR
	 8a0CRf1mx3QWt1+636B/HbF0n9eXQUQBE4jNvB3EBL3AVrOvTz+uCxM2mWjcdefVvL
	 u0zGkbOPIlU6dRNLpONP4FMOD0QHhxq4RmOYobKVV1Nz4Tv4it8soBwKhwd0t6Y10m
	 8Ty+TkI+AIkKsfsdLD37uucyxpSiN7hwLYfWpTZ9OzXEKtF64l3Ltzp6dFk1LW+Nms
	 5yLvLBOtESuEsTRQFdrkamDPibFzYFDvceuUYurdPAkcarG9jhxI4YIkdEQESEH+nq
	 33sfrsABq5cLA==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 35DD017E0D7F;
	Tue, 08 Sep 2026 16:51:41 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 95DE1480038; Tue, 08 Sep 2026 16:51:40 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 08 Sep 2026 16:51:24 +0200
Subject: [PATCH v6 06/10] PCI: dw-rockchip: Add helper function for DDL
 indicator
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-rockchip-pcie-system-suspend-v6-6-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=pQ075WLFf2brXAVxwHCIqRV7MiZ2UQ9bz57J6cuXjls=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqgIPxanYSFeNaTKI80U9Qk5pMvLkD/tATIm
 bJl2oJDZLST14kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqoCD8AAoJENju1/PI
 O/qaIeQP/2bqoeDyDW7+kPK44HOhBltY6S7QNU3cZa+i6Q8PIxcsQXUjVfb8OoBsWSKB8YvIrqJ
 x2GzmmRTwNlvzcdaq3wZ6a9za/lmATJoLnM4gv+yC5Wfnq6+qcu2kDMrtLx/D3+Wih7WGF5cTyS
 jOAg4gzcf3HYU03/cpcp/xJsmdW+h3DPCrkp7Imf+6aOC6R1j+0PU3zC8IoJi0CdNC7SsIxncuZ
 seMM/55ddl9jWkM7TYyZGqjwYiKxP2QnAfLPhSXjAUHChHgGcOfZlSH4M/Odd81zwpTEiXNLhyt
 GsxLUxsgrV/SUSSqruNMuDhGdbOP6OTY2LIVHn4YSY24I7HKWZCFNofs5t9X7E6T8ntbMQkjfWx
 KO6sMZUfzbGdqKvlutq2Yv6Z78iTRLGvNZKdC9F0AVsRtadNIfOiV1N2WMqYHHXpYM96/icyLtj
 Shj0rNBUBWF9K+1SSFvGvzhcBEuFPghLKLE9VzxbZrURkfizsPdyLR9kqQDEbpZertOyAev1M85
 9maIGOXdasRs/KO18Lr2C6uP3q8fJSO3NRqjOFoMihM2+BTq6gKOnBejTEUx4dooDlTrghWq9GB
 FH2ZrblBWvvtF5HMubmv0DEvRxDAfs9ROGVY2RxT8FvVgt4xH20w9M6tA1vy70BRjhIKxPnkpxN
 TQYkvtHyh9gunyGptVQo3mw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Remove code duplication and improve readability by introducing a new
function to setup the DLL indicator.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 211776bbcb99..1e48099e36e4 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -713,6 +713,16 @@ static void rockchip_pcie_set_controller_mode(struct rockchip_pcie *rockchip, u3
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_SET_MODE(mode), PCIE_CLIENT_GENERAL_CON);
 }
 
+static void rockchip_pcie_unmask_dll_indicator(struct rockchip_pcie *rockchip)
+{
+	u32 val;
+
+	/* unmask DLL up/down indicator and hot reset/link-down reset */
+	val = FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0) |
+	      FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
+}
+
 static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 				      struct rockchip_pcie *rockchip)
 {
@@ -760,7 +770,6 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	int irq, ret;
-	u32 val;
 
 	if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_EP))
 		return -ENODEV;
@@ -800,10 +809,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 
 	pci_epc_init_notify(rockchip->pci.ep.epc);
 
-	/* unmask DLL up/down indicator and hot reset/link-down reset */
-	val = FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0) |
-	      FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
+	rockchip_pcie_unmask_dll_indicator(rockchip);
 
 	return ret;
 }

-- 
2.53.0

