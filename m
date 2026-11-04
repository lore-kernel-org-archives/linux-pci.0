Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818611;
	b=0wnq3byMSOWzryyXpkfN8kJn05O1Og2EpZ0UcPZdpkU21A561B+wzZXkwwIEZ+BAUuzI
	 yi9nd8JB1XVJs8E8izmFkpp4O3Oflq5SZ3mKOp2c4kjXHI2QVEaxEFL7ueB/TSe0HjqJC
	 rVE6o0dMjuDonv0lK4zDiN582r05Qu5q8U1u8UNqqVEPclPXaUr4NcNyq3m91Z/I3t1Ti
	 Qz5pmqWHwkFJ0XSsdHNYxtyREmlA0S7kdJHPyyRKmgDoOeTtjQVYg2aIXkNbVhE13GzTd
	 cMdglGn8pvYnH4kBeHLTd1BBwBvrDH4onmTFyDwkmNBn9RokHZ6HCDAp9tntfJR0WPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818611;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=rxgX/NZJyDSaUF0l+bWb1KVC9zUm/fwoXq8hASaNyw8=;
	b=QBbdmw0/ZqA6rm6nOIaOOx8f6RLlQtlvCTvxc1GNXEaXhkAuyM5QkpT6aUcAi7UKQmWT
	 0bBx2j8wI9o3XvEjSTnz4eh53ZC87sepwfOjqDLXFhWGlC8xB72muyaFGWbg14Q5tKzjS
	 224dJYNVQ6xro7B52Zw0l9Ivq9Hxm64W3HI/tTkFuJ/y/pE6BEcpQq+J7xkkCDlYH2fd+
	 iykKJabLkQfXy127sWqksLyZGgylSRLscyOh7iVgHJYdwgR1xaeBmh21ELOFHQlBK1irl
	 Oo+yFjf2AZqsuUfFu6Y1WtEi8SJAGNTVki12rJfXFezjcwn3LlTL/sbyVQhyI9EXBHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="JCZ/efHi";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE89606A329;
	Wed,  4 Nov 2026 18:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DE89606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=JCZ/efHi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793818601;
	bh=QQAYFAnTkv/pKIj0b3J4mqLvwbwXUkjQ5XKgIr1HDrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JCZ/efHiiifVEuMohhJVYz8qE0A67S6Cvc1gYvH9zJyZzirjvhqZu4DjmTFkvKaSF
	 BoOnst6VXb7un24YYLMglkKkbGEWy7rzbm01vcwOu3AK11oyrrI4cFHW9Eg8+EpD4q
	 AWO+u4H0onJrj6dkQx8adl0TrcXJATk/m/mxezDWLSeASoJrtIaSNuhd4v+XuxGoXU
	 qqXbqXUFUsp2i0C9rjQ98IzFmqsuneRbNJrR3B5X5U2mKTLRGUzP+H0Fnrq6Y9+MbP
	 VFnvDMsIAHGZWGS/0Vs8BU87DnBiCWSKIPTil1OoWi8IQkCr5W2Bl7/04miNE20JQ/
	 EwwEZwucbyWtA==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7836917E0D58;
	Wed, 04 Nov 2026 19:56:41 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id DC52B480038; Wed, 04 Nov 2026 19:56:40 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 04 Nov 2026 19:56:44 +0100
Subject: [PATCH v7 06/10] PCI: dw-rockchip: Add helper function for DDL
 indicator
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
Message-Id: <20261104-rockchip-pcie-system-suspend-v7-6-6ae6875939a2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=QQAYFAnTkv/pKIj0b3J4mqLvwbwXUkjQ5XKgIr1HDrc=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrf+hlASs/JMY/QpkQeL7gOYJZ7+g0jX7bk
 npIxXbuj3ztWokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq63/oAAoJENju1/PI
 O/qaAIAP/ifXji7ytsHrKBQb3pwhTwW0oBcsIMi98OWsF8SPdY6krk1bK98l0E3KE2GIww8Gh0H
 DsDB+lLTMThbjV02FyPxgd9Tsvkfpc/Esjbsd7GUxDMqaFSjOBLmifv7CEaI7FH3w9dFeK5h9M5
 K40oog1eUlR25wG823Mm1TJ6zcvZShgfxVOv58sxfOMNLDKZTAc/YWxPMN3DgXvzk/2uIVJG5Ku
 60S1ht+aRzRdSew3dBMqShlKOXBQuQTVeb9W/nrCZ1d6fM0B2e80ObkhNU3yhMeROHS+cu/jO0Z
 IBaZcgLZCr1mZbrxOGU2HzGXXTECIlb+CC2I0B3FcAoKmtv6n7cxd4l1ltX32ZjUclqZYF9ykpP
 tuY2KwpMFKDo+MVQ6K84t9wIB3Ysf/BmFiP4MKMMYU0oyJZsod63/UCOg9LDYFVS4U96NREefJH
 oiwLY57ecUauIfVaxLWtvUdQH5S/oRnX6srWpbZc+PLsKBzWDB+X0zAxIuzZGdCQ5vKGU+ejoKp
 addaHidF8AuRAzZeUx7aO5flgKu94CDqFOrT528Iud2h5SInVJAgC6MdMXMS6wOd0cy04g8tjzZ
 FjzgU6cP8ibY66XU5GUy07RwDZk6vRd3zGVKXDNcbWvhGexrS7zUnkPTpeub4Ujp50TMD6SlLtF
 yawPK4hKnl+I9FXiRWyIuTA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Remove code duplication and improve readability by introducing a new
function to setup the DLL indicator.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 18dce2f52a27..f089dab4acf0 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -700,6 +700,16 @@ static void rockchip_pcie_set_controller_mode(struct rockchip_pcie *rockchip, u3
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

