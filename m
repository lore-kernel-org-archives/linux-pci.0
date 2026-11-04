Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818612;
	b=EkSOM+YGClIKRQN3yHvRGYiLLMQWnzCPeYgxFBRisFFdEo2J9y3eomJzHRvUCZ7qMn8w
	 HXBfzOtzrHaalT+I1iT5wNhIdSmlLEg7EwAWHwV7O8Kg0eZK+BnM9U7NBXddnhgMqJh3W
	 AIb+XL6qDuGklX+JCPuKGV0JficufKB6m87aVNToowcown2QRMJlY6stYC5e8DKRNxdQ8
	 8eN09P6bML1TDHOibUX5u0lu+tbb9vm+py6K1IixZoZlTQJWwZc0kZHSDzZmpyeInHpBX
	 AmWxeIH/OMOtpAyWxlyU/bbfHDuj6ZSfRFZdRbiCOd2KihBanFMlZ8GOAxNBt09Qncw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818612;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=c0EdPddL2cajf7nxjgNfBhfCJVRh8eHhjm8AGny3o5U=;
	b=jrYyQCsZvMO6t+KpvrgjYDGOwhP9mFtBMG7OuKHb8RRRXBi8dZ2lXCifXNpXkW907+aF
	 /lGJ0xGtzEhxm70WckSFlbO+01OGE6+n3LpGsROB0m6e2YHm6LxvSGXYKxOWLgaSvJ4qc
	 G3HHSmnEi5n1TbjUAJuqWz7opqzsCu7+wc0TwWPjaOKyiwH7gX/KJTbnzGLnk9w2uE59F
	 XXdz5GHIvufYHGVY8rpWdM8k5DGKwKZ2nAq8YScCjYcAx/H+7+N9zOgquCc7b32hLHYry
	 q4JLGw4GK3JyRIwrpaweV4Zeg5fn4Wll7vqdkatI48gV/glYEJehTZookG52Td1XK6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="QxgZ/e7u";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F402606EEB0;
	Wed,  4 Nov 2026 18:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F402606EEB0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=QxgZ/e7u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793818601;
	bh=KjpUu3iPvkexjJAxJ7hes6bbWKuc2UMI+yAtuOLVY6A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QxgZ/e7uQnq2VEpSBrUdj+Jb7c5LUBvi2GNKIxnU+PIQ0b5l1gSzpdgBtaCQONyvU
	 8/DVaZ5EISj8srxYUp8rYKeSMtmzYf5mUvmTHtXaB/nVwpaNwND+cY5AWymMy4qIrA
	 VUYf/+rPx2tKz5eaQhpSf5yfyU1trN7EYbSc6zfyhDNYnga80ZecDSVPyrI8T6YHUx
	 YgnjSLJHQemiAuGWIYldMo1WvB4AFpuo1g/vsfdFrq3E8i9PLYrCiUg8LPhReDQCZR
	 x8aRFU3UFJJUcJW7JZPBCmLHG7gu9vH+mPaoCw8f98u5V8DoGH8JCwwVNHnTaIKcqZ
	 O/LEsbsYWhYHg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8CE7717E0D81;
	Wed, 04 Nov 2026 19:56:41 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E2F9D480048; Wed, 04 Nov 2026 19:56:40 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 04 Nov 2026 19:56:48 +0100
Subject: [PATCH v7 10/10] PCI: dw-rockchip: Clear debug buffer before
 entering L2
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-rockchip-pcie-system-suspend-v7-10-6ae6875939a2@collabora.com>
References: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
In-Reply-To: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=KjpUu3iPvkexjJAxJ7hes6bbWKuc2UMI+yAtuOLVY6A=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrf+iWIVtOPSNaDr4Qrj9LikUNVb5SUN5ii
 j+9AxrmGmTkaYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq63/oAAoJENju1/PI
 O/qavLIP/3HDeg3ANNn6m8zn/o/oqrAiUDpVZdn++Z5BSS74ov1eTXfpa9xvnQJSS0RDDbJ/6ad
 gPFmRHjDUrOIM0GvoV4mYTW6Qsmir1nEE5u1BLXpfXKuZ8yhz/3F6JORPe9+pRlKUKJhBH8LA01
 OexHTDJ0vQwqj4eYlJ+XRb7YajQPnXawfJ0Rh2mRc/g7WhRrpiBXDOxUxM0iKho6o2t0KPNW+Dd
 LvxvrTy/K4otznfq0M8JGQiH9gV/L0W2aAVclNdcLJg0lHALLf0FeLYzpgjApvLjPrbh2TOQ0E0
 LzR1vcDtl3yKWrdAIsv+sJS9rnfogbm4SDtFBbQnBVfFedw4eW/fUqjJFkdC3oXSDzkYAdrrhEO
 v9gcD51oQrwrP9fA9UtO29vi4bf0PSc09wwROynbY/OsPtsVB2+mzmed0JhVOWzmVvrW/NQgdHd
 ZaXWuf90jnL8/+cB6+zsnrDOe6iwEVDNg8OY3IqJTxv1C8vC/r/VvCW1wvy0Xk9wFZQwAnE4vL5
 sIkbnWYNuWfOB3G9v679fjYSaxuZPdL3lcXWMs9vb2ZssUMY8CRS3gsXKlO8/1xAKjdUti8yHWe
 J8UzGxcOLPqlH0afQxtSZVYhJFP80XbwsOT7Ut/F13Tbjgy9sVAelO+HIO1QKpaV+qIOXXLuy6N
 KOpuGuhU/eIUMnjx+sWQ5cQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Clear the debug buffer before entering the L2 state to ease debugging
link training issues on resume. The register latches link/LTSSM status.
Clearing it at suspend means post-resume diagnostics reflect the new
link bring-up, and not pre-suspend residue.

Cc: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 75b40091bb95..66b3d31d7bc9 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -81,6 +81,9 @@
 #define PCIE_CLIENT_MSG_GEN		0x34
 #define  PME_TURN_OFF			FIELD_PREP_WM16(BIT(4), 1)
 
+/* General Debug Register */
+#define PCIE_CLIENT_GENERAL_DEBUG	0x104
+
 /* RASDES TBA information */
 #define PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN	0x154
 #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_1	BIT(4)
@@ -1039,6 +1042,11 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
 	return ret;
 }
 
+static void rockchip_pcie_link_status_clear(struct rockchip_pcie *rockchip)
+{
+	rockchip_pcie_writel_apb(rockchip, 0x0, PCIE_CLIENT_GENERAL_DEBUG);
+}
+
 static int rockchip_pcie_suspend(struct device *dev)
 {
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
@@ -1050,6 +1058,8 @@ static int rockchip_pcie_suspend(struct device *dev)
 
 	rockchip->intx = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_MASK_LEGACY);
 
+	rockchip_pcie_link_status_clear(rockchip);
+
 	ret = dw_pcie_suspend_noirq(pci);
 	if (ret)
 		return ret;

-- 
2.53.0

