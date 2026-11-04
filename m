Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836144;
	b=MMjvkCIHVQeoz3Lb4dQzkp8C+iK7BQU9wSgH9y1bwSgZONCYa3Ki0PEHwRVSSkAe5Ywt
	 3fTIIHZuieeCA7eAlOcDdnC9+EHyu5UpxK6IfB1q2eafRKsptFTNrOY7jgatUJZnNTp9T
	 9RPiRJcgzv+2OoQO3UPq6HvwLqwke7VW7vdaRNvX9dhj5T1ET+H6QflQU5MD0j5yqK2QE
	 ZjBPph66VQY7fzf6iVHWbc5MJFWbVoHy+VqJPtdQUT0Df92lqqqBt6FFWHPD0PV5AEXdV
	 q/wzvujN9o7wwOSVsyTpXLl77MCCx7ft2sZaIww7I8w4rgz6gXlWSyYlkqSIpTFbOWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836144;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=OmKsfl9uJsUWso+fMpxk/dFFuSVB9wUShIb6I86M6Xw=;
	b=qEThTyd9WDqXqSm1xL3V7ditzwYdLZipLBsx8rGeRp12EL04nbREEWOpLL/6XCE7N5iW
	 4ZIxJVMZbDBTTnLK4p/mRM+KYLrW3C4LZAK26op7Sic9vcFNhm//r4n+hcn8cTS8qRf7l
	 xtpxvm8EleWgoNiNFLZLOaI5jKqG1vqTfItFCaa54DlY7X82fuWYMoWLp3Tt5FrkkoDQn
	 LGlZ8O8xnapStk+AhGRllSD3QsUhwTqUldNpUBAKvpUEVUGAA4V5vBv+sPyuaIqa0b/0u
	 1uE/iV5VR7HRBT8QIYGAhwrWi7wGTawh/urhRtthsBVJ99jOupy+AgH7kGvcJiuQH5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=HVASworK;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4EF606A32E;
	Wed,  4 Nov 2026 23:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E4EF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=HVASworK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793836139;
	bh=NjKQZleP3GcYsDwf94ycTmT6FiH5od/S2dfJRexNKCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HVASworKWrHbgBeyxEUggCXTadYlAuf2oaPMT1BJT0sltNz34MQ6vse9e4MzedMpr
	 A2tQIt9Z+5SDsUE/3Q8nPgpJQOYuGQpynR6hlBagEL8vjw4hMo79yPSH1omToEhtoc
	 LczQ4SYQFIAfbWx3sgNtTCEPa9MMM2qc5wc5QzGJqzJXvw+z1HEbMWhOo+bTNbUxGj
	 WyLUbfmOXwYlGcak9awaqG/smJIBRinc8CDqeptI7tWSLSL7RGVp6UDC9kSP3YKclC
	 dwIOvX5d/ZwaNEDt0ERbxnGknpBKq7ce2Kpy4hGlR4iN170PMrP460lmwAXWn2ozrC
	 5YbCaCE8UxpfQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 82CDA17E0D7E;
	Thu, 05 Nov 2026 00:48:59 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id EA7D948003D; Thu, 05 Nov 2026 00:48:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 05 Nov 2026 00:47:09 +0100
Subject: [PATCH v8 8/9] PCI: dw-rockchip: Set broken L1SS resume flag
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
Message-Id: <20261105-rockchip-pcie-system-suspend-v8-8-0434b4f373bc@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=NjKQZleP3GcYsDwf94ycTmT6FiH5od/S2dfJRexNKCE=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrxGoHvZr0cSFoeS+VJ9o5szng4QW621TUw
 Vk2qvOPnzLXQokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq68RqAAoJENju1/PI
 O/qa1usQAJOHCDfrJAH8J4H9h+WAwhi2xbEj/F1EHyCsHgL4ByhT/aXZC9nDwTpZpo1u6lMktVX
 049i8pQfSLvXKqmg969Ob9Senj26yp46SJ3gTlK3z5nKivHbj02ArhdMJYcZgH6IH+Aw2Ww9U4X
 QiE7pPCO0NTLsaM4sFLQz9sig2gO3c6e1eV/aSpSwnkUSrVBzxOjx85JWwelp3tOFdaUSfqYkM2
 4tgCfEuqCZWYpQq0diwdQV9KtVHYhLOiJjCV5ZWbX4/s1VfTNJCRBq6hfv1xVOssYxPpTjVTPDM
 gED87hoJjhpVoSWnsYToMcff9rbrxShg9Ole2P4wmqJRJJtaWWFXcPMMPvy5AD97Yzhf28PggDt
 ai+3zgMOiLbXHVSqQQ6FpWygWLKNBBCnkzyBJ1i1CbQNsyRmiD1RcApV2WKHnSU/3ACb2HjI9rE
 54M06z0JYtL/vtRjj1brVRKqnc5uPAAFsltG8UFZ6P9fcCuuPbUpO5PoIhXrhEJnaqvzZYCb5mi
 CrXQvfWJ8ao/ON10e/Dv6dkCJQKPpIDtzFdyv56LLhgl6XGM13++TbyXihPbVZOgjFK6OBG2PBH
 4ypCFQqp6NqmOZASYZA9BDQWrYL5hKXVIarvG4NbJRZylWT6mrCCTDWZUDqt+1fAyIwQIZ7u89p
 JzHHuxkbRjDOv4G8p1RUwtg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

During system suspend, the Rockchip RC driver effectively powers off the
controller. If the link is in L1SS and the endpoint asserts CLKREQ# to
exit L1SS, the time required to wake the system and restore the
PHY/REFCLK may exceed the L1SS exit timing (L10_REFCLK_ON +
T_COMMONMODE), resulting in Link Down (LDn) and a reset of the endpoint.
Set broken_l1ss_resume flag to indicate this limitation to the PCIe
framework. This results in pci_suspend_retains_context() returning false
and PCIe client can avoid relying on device state being preserved
during system suspend.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 7933c50df340..9a2606748281 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -448,6 +448,11 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void rockchip_pcie_host_post_init(struct dw_pcie_rp *pp)
+{
+	pp->bridge->broken_l1ss_resume = true;
+}
+
 static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -487,6 +492,7 @@ static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 
 static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
 	.init = rockchip_pcie_host_init,
+	.post_init = rockchip_pcie_host_post_init,
 	.pme_turn_off = rockchip_pcie_pme_turn_off,
 };
 

-- 
2.53.0

