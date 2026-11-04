Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836141;
	b=wpYsJty6iNJSoNtYKlTrZXcIUh01dLNDyM6jLxGn686f0XKx3u/N/cLoslHnb8qOdaME
	 8Jv7/m5TjDuC+VWohzf5OL60VFSmmTiNm1bYkyubTst8JNh668t6mwKbeGJr27UgGbYQ+
	 FkA+fY4KjNGvgPq8nqVuzZDfX5ggJsyJ8D7HNASRyne/FMp5Ta6EVi6dqlVvz27/Z84ns
	 83tBgJkDQODWbmhXK1y3jygfuySmFYxB1vdxJD/M03XDlSRX9e43QMRZSHLZRgs0m1tnu
	 ZvHhDDHaex7vsLIHenRXsqRqELADy/AWFEwSsbCP37EciCxH8FipAXFORPvpvu/Ayow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836141;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ih8e64eIFh4zy0l5Dkq2nWyyFdIYsw0j6wRXY/x4Y+s=;
	b=IXwOveMcShnyhe8693VzkBw0TVzyx5Vs1p9n384Hym/qllUasfzuC921B1yTmdhcjutS
	 yDkqNtT9Arnjj2tpyouwM3dSOljZXOW2hWXplvqAKOcTi10MLO2zthSS74ESqn0vCCz+2
	 n1jPcFr9Y7JRV2KR5KRwt3b4kWNu7zpZ5DT2+ZbackE38mJytOgxxeiTJTEmWXl5R+WdV
	 nNr/rT+24lSq5K00jfT7awQtjYEpBmEVp8u9Mo0/6mWa9fBA8Ed3atDv6jUrJfn+2fBuF
	 EslUiSoJlnsR0oiSyLxz0ic1m9q4XR5YKVmWC3Aja0zezRXYCM0NIS85OgtLbR5oRaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Qm8n+J44;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012ED606A328;
	Wed,  4 Nov 2026 23:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 012ED606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Qm8n+J44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793836139;
	bh=UgCQbv933a+8c/5JcSutP3El6g81sTPPXpwKWLLRMhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qm8n+J44JfZX65sYoK3d/RyOskjZXcxUYqPw06XQGdAFFT6frZ0VeJgAgKOumLRVw
	 fkGmiKiIerzK03IRK5Q+oZ1KsLN3so2eRJ+2vjLYzhk65cuNiolSoKzZKfnCF35GOU
	 i/VAjNRd8y1822vzbb5erDl/FSr8TsQYJbHxCFwZB4asH0vuQickH07Owtf261wnDv
	 iri6bUCDKUDrSFwhUhXLGXw3NgpTi9n4I1CfIwirfxGzFRSLYA9F9CmxCrMts+YiD6
	 lLbPxK1n/woVqT+AMoeFFQhRkFqbNEShmT5xOVs/QPnwZ1tS2eelu06vqhkfMsiiDV
	 KFr4/xrnPgFYQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2912D17E07EC;
	Thu, 05 Nov 2026 00:48:59 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id DE194480029; Thu, 05 Nov 2026 00:48:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 05 Nov 2026 00:47:02 +0100
Subject: [PATCH v8 1/9] PCI: dw-rockchip: Fix LTSSM set functions
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
Message-Id: <20261105-rockchip-pcie-system-suspend-v8-1-0434b4f373bc@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=UgCQbv933a+8c/5JcSutP3El6g81sTPPXpwKWLLRMhU=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrxGpFQVbXyHb7+I8+tDu3owlAbTMkrJDIK
 lISlnuEfH0aLYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq68RqAAoJENju1/PI
 O/qaejQP/0Sk6dJKuxoSnM1A3fzLEz3uvILAVCH96QHTRNDv+nhzghnRStut1rg73Q27kHemgTN
 mx8aRXOtQEIVDrfvUOWT6jggQ425yJcmnYh9HIBHLKENYLk4mB+otYhlOONAie/zFTUHX07WY7w
 u7y1t/SN1XmNncfmCjIy1GbQ6yr4bhRRI5qy7gxtrCeDopXIC1vDo/OC/eFh74asYAcN3WOrFRz
 bxwAZnzntbfP5sP+1qqjHG46i761pMoGvOpLyjn7VCXdOX930Lywo2djTL0q+cP4KwqTNKlbCez
 r6rwx3VGrD2zva4PSeddfeR9qXWE3m+FWookxWL/wY7jXun8qf7mxQbNlmbEBo/a7eccJ+fy8gH
 Grxnr86eeRul4NKzdVp0BaMd6qh0uK9OHxtFBcyTHN1neO0JzC8H2yS21pXgwaoXO1pS/mlYBIB
 ob421laggOLTQojRNvvh0OqLczsI5QPTvbrfwEYoINoEVnt9XgFGrZa5jbGtHRd3mLI1PJdWPt/
 HgbEWJB5CYC/S/0gcnKayAew31ynxkOp+KkjRhQqkCigknLCLPpDHHKd3x2t7Bl3IPMTU+gvUJL
 N17g0RqoUAXbQmMHPN//mn5LD+lfCSI8zHAWrLMUf7eCQ1u/q+gAKSRZvAPKwWF0NfamoHlBVtz
 /XlLTh2/h3UBLAFv+7Us0eg==
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

