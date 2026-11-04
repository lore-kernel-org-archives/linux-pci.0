Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818610;
	b=NIf0Q9b+txVSsxB51I9pfGRewM3eoQkaHVYb9Mw03ZZXZk0iIplo38+eJ7a7PeHgzkRt
	 IurCPmtva4MWa4qdvklOQY25NASfkXorOqIwKAPGbQSvqOtUQUY35RjWkEFYEoToi1vHg
	 itgQMhsJCbgagstTb8YzEOue31GM1Efpyl3xEMQJ+xiNPX7gNIkyiFu8kHTCK6UkxhshJ
	 MbT0OI8nArGEZm3DbjG+MW5CetDhPSUdEELBgQYfZ9gsshNKaEBGSUqp/9swIK5yd34zO
	 RVB3VEXf04aoEKdpwSFrQMtIFp5rLzn9mLRMuX24QCCrJMGfTap2PIjCV7+WOwK2eEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818610;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ih8e64eIFh4zy0l5Dkq2nWyyFdIYsw0j6wRXY/x4Y+s=;
	b=BYfpBO0q2ugsC3i2cG988ROWPnMRs0OW9UUgKGb/IxLagH/TF+vJh5F7cp+DXXIiO2nU
	 SrtHZC0W/+pFTsPiSI3sysl2dWvL2hCz/57yESmSGOLye8nj9etJgPDIe9bpyzYg8W6jF
	 Q+xr0m9KPCGLxKkyMksftz13qNv88fL127cs/Wl38m3UjxLISzKGrfHd//C7kRRDCfGqv
	 cH/Ea9sIkAC4Y48JuCA2RMRYeFyclfNLKJQljzXiyfnPp6gVe3LS5z+ulYBME1SjPlq4A
	 zerOjlx2kaDV3RorlEMFJgaskN6xbbR2lf5Ma4me8qD6lQYGJbVxYkSZxoTAO/X9Txw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="RYWhJ/eZ";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F88606D80E;
	Wed,  4 Nov 2026 18:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01F88606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=RYWhJ/eZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793818601;
	bh=UgCQbv933a+8c/5JcSutP3El6g81sTPPXpwKWLLRMhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RYWhJ/eZm2n2bymxtcD7fBjz8FREigz8MXZeFIdGhpDC0dHgMFO/gfYXicA09TIgv
	 PZdi4jDGARr5KI20VOE+OzKmBH21vbXAkAE9mayuaQY0XgE+rAya1rtSRR7RdGhQlp
	 wb6Uy2ZYdItY/Rs41AOEkTcMEzYgfTsCP2KIgL5aSkjhVTQDG/lXetxYV76bQnMF9x
	 a2VisSTmplOVYE5MkNc6woaNTuQhpNAtNgAJ4vaR3/GW0rvi2yj6z1tp00NrCGCgkr
	 E77MiW2RoUtNGgP26WY97G2cAwHHsob0bbW9nIC9bqlP0dTzZz9t7yys9Cklf+pi0F
	 R989LaW5mGyFg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 25E7717E0CE8;
	Wed, 04 Nov 2026 19:56:41 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id D4042480029; Wed, 04 Nov 2026 19:56:40 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 04 Nov 2026 19:56:39 +0100
Subject: [PATCH v7 01/10] PCI: dw-rockchip: Fix LTSSM set functions
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
Message-Id: <20261104-rockchip-pcie-system-suspend-v7-1-6ae6875939a2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=UgCQbv933a+8c/5JcSutP3El6g81sTPPXpwKWLLRMhU=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrf+hsXO6JR78y3RjTyxN0XGzP4b54bm3Ib
 KXd7tKTvCW4ZIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq63/oAAoJENju1/PI
 O/qa9cMP/RUj/WrmWHxRhrK1r2tkhjRosB5MrFS7Loah6usEXbZuF+Eg1mxKJTRoTCJ6d/4Xc7J
 G7Qy4KyQe+rIFjbwvqblTo2P9Q4T8ofBPCRuEPuwinzPQHfjfTzMcN+wfqM+SzMrxMnTMAXKsG7
 vkwTLKwZwGtzvY3h4uiNwNHxNg5rL2eHfMw4TnqhFTsZ01INMLGu4k4TCYXQaz+IlRr1B5Y7R2H
 3IVhAMVkf2q3xRyE83Mh2/9OSq2aNTed9mMyY0ZzkrK3XVjtK9DcoLO/OfrRwDXD5UZK398omUU
 voTPhb8RAf9L6IW6Flizt6JWdySZs48DZqa22S8LUmd5aw3vD0jTto16Q1Q8sXSDoY8VtOO9Rme
 yDZIKha/j2YW+eI2j9E0hs+tp95Xf+wFRNg2xcgIu2giTw3xgc/q/4BmFp4wdgIRkdM9Q+yD2Jj
 kBG14xxJjEFLKFGsVSZJmzGf6IEP66i9V/zDlPTGqWaxO0JNeHz8h5ZO07COp/YhftIdtof+rue
 mxmYUbTxtsqXfkA6SRFdshs1gHGyQvTfXC8ONriZOag/LR8eoNFiJVTv7r3AKxNiEtx1NndR0hN
 zUsuIdcjqszO+NVVtySF6WDVOMMUhZ93iddxt5Lw4U6gdSKywXCFRBlMRIXe00k3sj6Hh/R9jeM
 OlfeQjVNTnPbwiheRmxs4Yw==
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

