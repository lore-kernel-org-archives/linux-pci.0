Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E5530DEC;
	Tue,  8 Sep 2026 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879140; cv=none; b=R3mwN2gymvj/0YTunyjUzVC60bWR9+dkT7DJTp83LwRcHfxktoyKXQsxN7/Ka9xACJDXyJsYm9wjTUzcJYJm8KJFYpeDcJAKVfx8Hc/e92Bz7s+7jb8u5av6kr1D+mhnme5qJFwrox9eYtKRpq5+//jhUkk+CXCq2cf5afZkHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879140; c=relaxed/simple;
	bh=T2E33x//zZv34p7VqHG8S4S8Gcb0wfJ11dQV0Vms09o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mqLEMVMQWKgR8BElL0I/T5bxp/V8kqylIpSkDjuXw7rXkUqN0UfnSCCyJE2ci06YxTpKprIJyAKcIpa0csFOCryXnpv1Yc2Yk/at9PvJxeUKEIYv9Jn9qJxy6dFvJzK79AeEjfW1w/bA8j3AsyrWwfppfpazL5EPwYAUYZmDIss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gx4zacVm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gx4zacVm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788879101;
	bh=T2E33x//zZv34p7VqHG8S4S8Gcb0wfJ11dQV0Vms09o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gx4zacVme7Cb/WJWMF51IiBYVhNXoQuO/Xg/biEFIQ7ZxnpOk+pDC8fkq54ejfm4P
	 1O36Gxw31Hk18mEtWBVUfHHKrEe7dQiW38KdKJi3WzjBIGA8F0AABqIuP6RP05tHHV
	 0Xrbui6o7JQenjtc8LeGM8MBWzckBp3HdZBrhNkPZOI9wScUHzv/iF4SrNHfBf4BQ3
	 Z7qIsDWx7S1CPUnXL3kcSyYXbRxfPikx3WTkqwKlbYq1H1YCKH67Pvdh8aPXnbLTcp
	 PxQYrukrhkz3gfyJQ4hT1Pb4mUfapCTSunF8xZ6x0zXH+2ghJqNmp6RdzNHrUVgftM
	 vM0Rj6pE/ydZw==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4A8C817E0FE2;
	Tue, 08 Sep 2026 16:51:41 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9CC47480048; Tue, 08 Sep 2026 16:51:40 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 08 Sep 2026 16:51:28 +0200
Subject: [PATCH v6 10/10] PCI: dw-rockchip: Clear debug buffer before
 entering L2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-rockchip-pcie-system-suspend-v6-10-fbabcca9921b@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1731;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=T2E33x//zZv34p7VqHG8S4S8Gcb0wfJ11dQV0Vms09o=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqgIPxM5BtG5TqRDBVCuGbS8z6iuqCgAxY17
 ahfCBQp2DV9c4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqoCD8AAoJENju1/PI
 O/qaty8QAJ8td11B3+qPI+KtA21Q0cYszi6xEntVmNV9V2BWUiJt03mDyIPet2ld7lAwolemgzq
 TVRfdWvL+N2KcWgZMYSR9dltxPr/dKma7J5cKLmzgVhJ7Y3VktbMMkjKcwdgOYF24vlLkIBnniA
 WsAQBy3/m2to0+B/Ls+vRKcqYfeqyAkVoeJ6xgHb5wGhomZxgYsbYwgEswXMYsNwMdmEi1BCrz2
 NYWu/g9F7XNSnLTBhml3knIvqvJBHzbyQElF9CSa7cx8Llolln6oDIGxxGTUAFmBh+T88izWQN5
 8w2+CxxbXkgeaSkQKjJRsqr6trosRMWDUwh+93+AqvAtYjQ96Ag0b4/NIkvmX9lSlyr1kiZ5fNF
 bYnKgReb6bV4QLSSGzlriXluJAe8iA/9+CLob0Pu8BYvmAcmFREPsuK0OyjuGHAAXzHP/xWpsoa
 4OXHcmML5E/jUery+AuXb6cBAyLX6kC6mveQ7NGkLJB+JFlV3ACzQRlZZG4np/vXM2U12E6j/wY
 LqOp3uInUWUoJ/zw9CEWip9bW9qEi+90c5nJ/N9ATtNJJlkgy6Vkb2qarOxYwwG5PuvrgIQdTqH
 yk1d3MUu+ChPPOdZjW3o7O2jsitRGjNXW6YrzMemUAmXjE+MCrvg/X26K5SCs2YKqa83A/N+rSv
 PIdn1Jmtwcez+fHGZzWAePA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Clear the debug buffer before entering the L2 state to ease debugging
link training issues on resume.

Cc: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index e675918ba184..a508f4fffd2a 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -77,6 +77,9 @@
 #define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
 #define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
 
+/* General Debug Register */
+#define PCIE_CLIENT_GENERAL_DEBUG	0x104
+
 /* RASDES TBA information */
 #define PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN	0x154
 #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_1	BIT(4)
@@ -1043,6 +1046,11 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
 	return ret;
 }
 
+static inline void rockchip_pcie_link_status_clear(struct rockchip_pcie *rockchip)
+{
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_GENERAL_DEBUG, 0x0);
+}
+
 static int rockchip_pcie_suspend(struct device *dev)
 {
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
@@ -1056,6 +1064,11 @@ static int rockchip_pcie_suspend(struct device *dev)
 
 	rockchip->intx = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_MASK_LEGACY);
 
+	/* All sub-devices are in D3hot by PCIe stack */
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	rockchip_pcie_link_status_clear(rockchip);
+
 	ret = dw_pcie_suspend_noirq(pci);
 	if (ret)
 		return ret;

-- 
2.53.0

