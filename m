Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885594;
	b=bDVoY1J/Lrqr364ize6+3ioYFTGXGiybMCTtXVDCdok67bjEsCa8IKp9qWufiY4DD2zv
	 o5z2uczarfbZ+VSeVRFOeHJcIpeP+Tdk/c0ACO7qizv8kZjRYphPmfD0oYUTjpR2nhh1O
	 xRyco6OvDCvjezBGRl4lScfDiGeK/o8I778jNzr12Ig4onjhbobCO4A+fNYqegh0WjpuL
	 MkbnoVyT8voJxFS9DUWPVRpRKk6JDl84b9wfcg4oXDUaVze86ONbmHEP/J1Nt5gsWdo7q
	 Rl3UdF93135EvdHwSfA/okiainzJDTEvJcmHetvuOdGuWr2w3k10gmYpTYz8TUEGVSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885594;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ih8e64eIFh4zy0l5Dkq2nWyyFdIYsw0j6wRXY/x4Y+s=;
	b=yGamiVNauFYb4q3bYAZId5/sv/Wt3pNpE1z/T7ps2kvZh0RECUnq5duoVV3SN7MR27PM
	 U6b1HhL/YLOlrmOw91iT65ZSIdppxGiRYOlfaxGnr8Q/GWCESCmIbsNpolaKI4rXG5QpQ
	 i+ZeVW8X6+3uZzQZvb9lXglPin5LmRPGJwo9mFfSNDUb6M2ki2J+OjjiNp505HiaXJodn
	 wVqSNxwW2G2ATjYIjm+RFnsHoxGmLmeqh16CPwuT05D2DsT95OQJexdOxH6n4FrlW6y8K
	 VfsYZzdis9cy0C3imAaI3wHwTFY97/hE4H6xH3Rs9QKW8JlOV5A+tgdOxkt9FuVL8xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hOKa2D6Y;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C81606A31B;
	Thu,  5 Nov 2026 13:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57C81606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hOKa2D6Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793885591;
	bh=UgCQbv933a+8c/5JcSutP3El6g81sTPPXpwKWLLRMhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hOKa2D6YvO27XnRIv/j2OhsmqBsRwmSa0ja7Gc1eccBUocTe/LKUaooDCRuS6OfeV
	 pSkDuIEtsgWWh6WVlj8RnR5qPZ12jGf9THuK+3xpYRiiedwAkXYKzqiniG1YvVHb7f
	 KAbLn+9aNrt5Opr6PCrRLlo5x2HFZLkl13TuHv+XHSK+xBV0rs7f5jKBavzGdv2car
	 Hz9cjY3qHjP7UumDw8KiVBa+L0E7vvOnOa1475kbfQDv8GFkT0Mt7a8ePeo1CUg8jX
	 GvXE8hsX3BShNJpcJns7tFOC7VrpQAZ5AkluJ6IWDF1FrjfIXMBNpXB5r4ieU7p8yX
	 zlnzfbLkbrfLg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4034D17E07F6;
	Thu, 05 Nov 2026 14:33:11 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E245A480029; Thu, 05 Nov 2026 14:33:10 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 05 Nov 2026 14:33:09 +0100
Subject: [PATCH v9 1/9] PCI: dw-rockchip: Fix LTSSM set functions
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
Message-Id: <20261105-rockchip-pcie-system-suspend-v9-1-a2e55846649e@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=UgCQbv933a+8c/5JcSutP3El6g81sTPPXpwKWLLRMhU=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrshZbD1OCOQCQj4g9smfMOVQHxp2+Xz0N9K
 jMObvDs8UgvoIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq7IWWAAoJENju1/PI
 O/qae70P/3iDfK7o83wMlY2zl+YOy+L/Fpd/3IJYua0Yo0PRxK/cVc5Us3bM/J0Oz8rFiKz8jKN
 VX0K5LYcax2VJHb8zRZ6bwB2orcIK4hZgssTznKetm10t2fxdWkuLJsPy5vm9XT8FDMv0HcnG5a
 m7sEikuZKlYqIRC4VZXdnanXba4jMPOyTECf5xxFVn/WfeXqtIv3wfQfN2Luzd1NxxXy/loCIxS
 OSqadegxjtuYNOX3DlQI27x6j7xHKiRtMB2Fm4Dp40xQz6VDdhB1jDPW9z7+jkSmBlRZ9sIXh9b
 CAXa8bYf+jquOBpp5gfcaTS1oYszAkVRWgh6csk1lqnRYM/lW1gNrrC50l4hvNYkbLFCisog+A5
 kvpUwqppXxx/XjTcLLiemj88mBMhxlxE5dN6mYMurOtJZeM6TKbI/fu5pXsTATw6cCIVtt9IcLq
 7ncFD4K7pL5a2r4FVNCUK9zEO/yf0QGJiuBDh/SHbWg4WqpJHsM9K3OIfgpqYrbnC+HHzV1iOif
 mCJg9sUKFdKXUmQtegSsA/pzw8Sin2yT7cGmC3Ogai3l666a+FMTwg9/jdR2+vn/z+En1HgbF+v
 Qiprsv9w71o1vAXyIWBkVYFOE3CIKXvjowXqorykHr9+MMrTRVNOCZco/vLO+coXbQ0MIroEWo/
 Kq5PmaTsx5HMY+uJUUUQ10g==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Before the Rockchip PCIe driver has been switched over to the
FIELD_PREP_WM16 macro, PCIE_CLIENT_ENABLE_LTSSM and
PCIE_CLIENT_DISABLE_LTSSM were setting bits with a mask of 0xc = 0b1100,
which means BIT 2 and BIT 3. After the conversion it only sets bit 2,
with bit 3 being handled by a separate define named
PCIE_CLIENT_LD_RQ_RST_GRT. Apparently the conversion missed to make use
of this new macros resulting in the third bit not being set.

Fixes: 30e919570581 ("PCI: dw-rockchip: Switch to FIELD_PREP_WM16 macro")
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index bd86e32cc2b1..c35c5583c797 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -322,14 +322,16 @@ static void rockchip_pcie_ltssm_trace(struct rockchip_pcie *rockchip,
 
 static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
 {
-	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
-				 PCIE_CLIENT_GENERAL_CON);
+	u32 val = PCIE_CLIENT_ENABLE_LTSSM | PCIE_CLIENT_LD_RQ_RST_GRT;
+
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_GENERAL_CON);
 }
 
 static void rockchip_pcie_disable_ltssm(struct rockchip_pcie *rockchip)
 {
-	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DISABLE_LTSSM,
-				 PCIE_CLIENT_GENERAL_CON);
+	u32 val = PCIE_CLIENT_DISABLE_LTSSM | PCIE_CLIENT_LD_RQ_RST_GRT;
+
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_GENERAL_CON);
 }
 
 static bool rockchip_pcie_link_up(struct dw_pcie *pci)

-- 
2.53.0

