Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818612;
	b=d/6R7fBSUVXUb5VwtPxfBolDomB1kjfz60XuXcFCr/bvfhP2kvz88SUxWb26/i7JtjKg
	 EstGmyxMe3zAvq+j7OaXwNKsJZGm/JAaAvDzDLTxs5Zb7hmbXtPM6OmtcT1ooMFWHzwcj
	 4aghyqitLuJv8/zguXeASDXHM97eAwfY59M06lCz0+HxCx1IwEITksgfJUOoDX24Mzsom
	 rmYCuEdPVgc74Qk/rpi+pkw5ce8To1c1ZVw+nfuxQbkOTDOSs7+bEQWZfhEcEXEPjK0C6
	 jjkF7Qqbh2MbmfrOpsxSqlq+hUObE1N6KwzDTbt2jRFRQCorTasTzZi3fZAD0Qc36ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818612;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=kkJreVa8+Xai9L5OxC9rbi5pGUUKIA3s2uVNhelJY0Q=;
	b=aMg9vlLzzWJhcyKf0poMvoIgcMRcNwEBdXzPxK8XdF5fB+SuVdoDWGzGeXdNot4o1Ekn
	 xeBq5sevqBIVJy1e+Znwl1SzSl6uHTR1UwIHAK/rJneyBWxVqZMh66tMSMj2ZC77DdsCq
	 q96hTkzm0medcqVoaZo3D6mnUC+odceScVGrTsa1aRbDPEOBn/pRLlgOsOWvT+/87KPFS
	 IlGLvrqEozB/4ycpQjLLgREdhQgTZ7BIgVm5bBgW2Lzzo3dLP9GRL553uV04KWOGPv1yU
	 i9Q6dUn+3GEFoarke5a7bDCqjedLARVplqEV0C/8+VzP6rPOw9Ame9iXeeC1NyfLaJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Kj23PAKK;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B22606EEAD;
	Wed,  4 Nov 2026 18:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52B22606EEAD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Kj23PAKK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793818601;
	bh=37OzYgJd/FguDZgdiGLTdbD5NRnqgBixtKnp3Gppbnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Kj23PAKKgxk8193z+Ad4Z6yH9BCbfv9UgOszvW5tL3E/0TMazt6llUK8iZqoksY1D
	 3VXSnu4q2VkTqsQA+8L4e/6hqNCG0NNHJ20IExmonW7+D4a7EqazHnWspC6Ah+4hco
	 tY+eq4kf7w9CdDjMrutG+ZC9FM9+LP24T20G71fjEUeGVZFNyfbhjKG7aAo68mrFrl
	 7ZtKZ12/IeXzk3otksJ/+vdHe1jpo8GiUrkaPzP9p/AIJZ5bl4aL2AlNGTgm8wNiCG
	 GnkJz7Disnmnf6F3sPuvmzhdKRo35o+y/iDiIaoo6k78QN5YmOm/tIVajsJ4IX/mfD
	 eBV8QsrrXTK2Q==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 811A917E0D69;
	Wed, 04 Nov 2026 19:56:41 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id DFC5948003D; Wed, 04 Nov 2026 19:56:40 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 04 Nov 2026 19:56:46 +0100
Subject: [PATCH v7 08/10] PCI: dw-rockchip: Set broken L1SS resume flag
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
Message-Id: <20261104-rockchip-pcie-system-suspend-v7-8-6ae6875939a2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=37OzYgJd/FguDZgdiGLTdbD5NRnqgBixtKnp3Gppbnw=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrf+hwNqc6k5R8mkHwP5aYKZKop3SBXtEdB
 dDcYAbGx2JqJ4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq63/oAAoJENju1/PI
 O/qapYQP/0gRB0zlUGjyiF4uEm6a1cPbII10jJOjeenY5wZ21HQXW5aOXeMXQjs9S9yg4JKF9os
 txLBugUNV2EogdYsHMh5EN+Pccrq45SuaFC++B8IlZ88b/2VwZAWDztmRH+9lHEg94mS6V1nMsv
 3kTdLyiqtIZZJij2tflipjrYWo4H+5YMTLJuexrPX/K2YizooBZ0TfM65w1sVkjG2ABaWGscj0R
 09Y9TpDVPRlRuenco5b7ujRysrkLpYkWdvD5Xmxf4qn8Sn1ZPWDbrmbs4NMRXQX4LSMmAacsUUD
 utPAJv0Fct+XHzdy7eseXusS1bAolVCsdMJlh5Z7q64B2hFCZnz9us15kQ357Em0bBOtd+bFway
 g0JFv3C+1VrgWPTBjBrua+XMZzvpzF40Aj/Vznt/lPUn1yQpjk6OL07jofo23wW9r+ujhFhxCPR
 dntpTyhtUBrFhPRXbsWW/b+eXHtG5eyLXFLvBmMcsSGRlhn7DSJwXQO99oP/7/Ci/E7pjkJrW33
 TrvdTPwjmoyqkFjqMOIJZBEF7qb7uOrh8vvm/UL4+VJTtQwKsb3gVD4Pwlt4ACjbFHYV+kzaByA
 oWC4AFB7BONbg/hyGy0PaFiS3I6TUi47w+mHY2Fbdn+yu2Sz4qRX57Kf2LKbJduwhJvsHJgAPtA
 BNOMs248okKMpJURi5TU8jw==
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
index 417e6fbbfe09..2e759f92b5c6 100644
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

