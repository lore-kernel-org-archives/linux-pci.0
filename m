Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B33A556BB6;
	Tue,  8 Sep 2026 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879121; cv=none; b=RL8HfCNExwdygxtfhmUEiJwmP8ENqvBfek04fpPsw74GJqfKzxZ63ILAo/OEl17ADoDrmGg4Z3NU8ib0uzAWZ85QjtEhwB0pqlM2rNJtQX7PubDosqWzB1x08Z9hMm6FRlgKP9or1858W6EvzQB2d0FPc2p07R4HUItlKQJSpUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879121; c=relaxed/simple;
	bh=Fg34IEunqJ87tallgVaqmL3g1l7Lk3fv7w8kAzfIgiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W2Rf53MmWQx9wKVsssbgTfWcRRaU0HZ86PouqBEG1eSODSToJdIuqBFRWPgX793G4LOV69cvVHFOUkjs6rZWQBcX1YT3A6QAy4SAGWrdjnoqcqIeCa5PtAP1Jw92ItkPG//cHDf6fWC8JlGxvt1/ovr74KRl15fZwfUd3UzqELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TbNDZZCk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TbNDZZCk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788879101;
	bh=Fg34IEunqJ87tallgVaqmL3g1l7Lk3fv7w8kAzfIgiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TbNDZZCkh3+30wTwoHAFATA8ACNPU5c21RyKLa28Dmqn83mRr7ahXKFBIkHIzoV9Y
	 XX+GJtDg28T26H66tGuYlK4VWBSYKHIfzPIitwGlFVlkfjwDR4VAq9KSQ5EhYGV4fz
	 AP1GgYxwLMUBUkDMLIP8AMAWft6KPATxQHNzPSiDJAqz/ro+L3XZoBZFtSlVrHAvfQ
	 CkvONTw4W+fvwE0ii/iHhMXGIcUX1gNIPU8AyG/YMye0Liige0huoQT0ooLrLQNTGK
	 NBS6OBqAhI0PpukKElgCZCCfdaE8Qo1Tvzn8m8WnP3MQNFNsxE+1lk4YZc61m4JV0p
	 2o3fSxnOQbCUg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D83D817E0CA6;
	Tue, 08 Sep 2026 16:51:40 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 8E17C480029; Tue, 08 Sep 2026 16:51:40 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 08 Sep 2026 16:51:19 +0200
Subject: [PATCH v6 01/10] PCI: dw-rockchip: Fix LTSSM set functions
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-rockchip-pcie-system-suspend-v6-1-fbabcca9921b@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1781;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=Fg34IEunqJ87tallgVaqmL3g1l7Lk3fv7w8kAzfIgiQ=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqgIPwEwohiJhIRtREX/UPidd6YqPL8FjV5B
 /2sETgGRQv07IkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqoCD8AAoJENju1/PI
 O/qadEkQAJq+v1y4/jvh+oo3YY3fY5I+eWTBo+SLQvRumeyeqQEPeRMCgyu/I8i42rprrdh3ciZ
 zNFR3QwfFJfxrqdhS65Mz2/u+xF+JzFUJjSiKsAmUvQ65yy2npvrnXbwkA3fPdFyRSS+OwsL5F8
 NSG75CrMRJAvXprI3B8jNwSDgxAR31LpauxDUMwru9tQhwpKAOQlyz3/rCoIgKcaJY1OOlqY5Ej
 Pfkw/vVeZLZgl9iJzPusU+xRO0zD11RX2N/XAv2qfKz9aOtC3UbRDdn1PwroMRIKE4mJaSTamWK
 LPblA2NVdE3WA65rxFPZ+WgkOamc5KWgyz0HT5Njz4WpwmkUuKQw1ii4a7J7jMlbYE4c8Nl08Gd
 qE/epbdwETAb5o0O7+8+e5HPe6EVIsDiC7MCTyZ9h9GtxnSVSKxieTIEByI8TlDcTm+9H8g79qb
 cCo7iGYj0vt/VAJBaxP1CG67ZrQoQGS230mG27YKLWNG7QD7A5DyrPnPDS9/GoKkI7uqFvn9qrt
 utZqRGGoPTncdQF0lltIqyGe57JlzDZng4ZWcRCEB+T6YW8n0wKEUrrWq8gliMsgNVilTHOBwMU
 UMTV+FVW/qQmKrZxEiX6xj6SL8cz0cWrRGp6OUFxAMrbhwUvSUbEdforXcOnEa5Ub0ZxDEmg0JL
 JpYJr+o/gVyhmUzW+P3owcg==
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
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index af26a07c0c9e..dc85564e5001 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -321,14 +321,16 @@ static void rockchip_pcie_ltssm_trace(struct rockchip_pcie *rockchip,
 
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

