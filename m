Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59527339870;
	Fri, 17 Apr 2026 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414981; cv=none; b=rtBgcgXHQi2Nh0DThuChHCesNqvj0FTWIiZqI8UQPQcdFwz/qqYDWWOwjgLH6OPtU9pX+zVHy8zV9rQVgGgJPIvZNlBtjndjn1sxGxRiKm6sLKQCywCn4YqDMX9beZOuogI1ovaXGFL7MPRqyM7SY7rdNs0Ggg8sufmwA3mRLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414981; c=relaxed/simple;
	bh=6lCPDhwMPmbCAjK6/f8NJEjZkHW31sOZG+Q5dj06sak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=ZlBKN4NhEMt3SWPHRpX8cz6p7E6241rpjCFSvvVsEfxan5WEv5ME61/u6vCXynYsd870NeG7gspEUadIp9ioy6MImdwp+n0p/fHNKVg5v+pqiBbY81/aN2Is3uU9EZUll6VjLOJXa0S42XjCRqhEJv1n0MmCjT9J/UlWg/Pn6lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=SERGk5wU; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="SERGk5wU"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=75813159fe=fe@dev.tdt.de>)
	id 1wDegN-00Bg7y-Gf; Fri, 17 Apr 2026 10:36:11 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1wDegN-00A0O0-0u; Fri, 17 Apr 2026 10:36:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1776414970;
	bh=6QtU1DwrqZAmortOvILGh/LMarM4rShFvVlM6/CpYDY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SERGk5wUcv5PQxOgPQAERvR7bZNusW2aBWA1Vz0Va+VHdJjpl1COcBBREB+WXGvAb
	 YrDQM+1zaer4ojj3oKetxyTgHNy78cUnNFcTrsqKblm9k3ocFNDBOGkxr5K7EbVPPt
	 sm++bJj1vzq3zyO9r5DnlENT5rpxefRV2v3DbmQ2tTI73CN2EXCz7vwcUEYQckLEoi
	 SRjM3Wum7/gp9UNTJrFySWnOui+uYOJ16CCKm89xLPGyUyXm6L7I0Q9ydwDJy4WrHh
	 qaMOom09lMSgJZt9YOVH77RjeH0XaBP4+lqwrdKUuYJvgqP0J6a/KmVzeVwUA8dXIn
	 PvKHZEMi8aMZQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 9FE39240045;
	Fri, 17 Apr 2026 10:36:10 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 98C01240041;
	Fri, 17 Apr 2026 10:36:10 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 6F7D723BD7;
	Fri, 17 Apr 2026 10:36:10 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Fri, 17 Apr 2026 10:35:48 +0200 (CEST)
Subject: [PATCH v5 4/7] PCI: intel-gw: Enable clock before phy init
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20260417-pcie-intel-gw-v5-4-0a2b933fe04f@dev.tdt.de>
References: <20260417-pcie-intel-gw-v5-0-0a2b933fe04f@dev.tdt.de>
In-Reply-To: <20260417-pcie-intel-gw-v5-0-0a2b933fe04f@dev.tdt.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>,
	Eckert.Florian@googlemail.com, ms@dev.tdt.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776414969; l=2721;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=e2R433hJ5rO3HTn7PeimYHVCAsltELW5gkTR8+BYSdw=;
 b=TK0TlUJCQAyTf891AJmuo9RGGLoRE52nS5Ugq+boqK34bcdFONigbhL+u3v2qHOX+2qA3vXt1
 MdUkCt4L1uDBxSkXN0BEN11UiDVqg36PxNJwBCBz6pSBy8waQCH/Pbe
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1776414971-1B6C0049-4CD1D541/0/0

To ensure that the boot sequence is correct, the dwc pcie core clock must
be switched on before phy init call [1]. This changes are based on patche=
d
kernel sources of the MaxLinear SDK.

The reason why the MaxLinear SDK is used as a reference here is, that thi=
s
pcie dwc IP is used in the URX851 and URX850 SoC. This SoC was originally
developed by Intel when they acquired Lantiq=E2=80=99s home networking di=
vision in
2015 [2]. In 2020 the home network division was sold to MaxLinear [3].
Since then, this SoC belongs to MaxLinear. They use their own SDK,
which runs on kernel version '5.15.x'.

[1] https://github.com/maxlinear/linux/blob/updk_9.1.90/drivers/pci/contr=
oller/dwc/pcie-intel-gw.c#L544
[2] https://www.intc.com/news-events/press-releases/detail/364/intel-to-a=
cquire-lantiq-advancing-the-connected-home
[3] https://investors.maxlinear.com/press-releases/detail/395/maxlinear-t=
o-acquire-intels-home-gateway-platform

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/con=
troller/dwc/pcie-intel-gw.c
index e88b8243cc41c607c39e4d58c4dcd8c8c082e8b0..6d9499d954674a26a74bff56b=
7fb5759767424c0 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -291,13 +291,9 @@ static int intel_pcie_host_setup(struct intel_pcie *=
pcie)
=20
 	intel_pcie_core_rst_assert(pcie);
 	intel_pcie_device_rst_assert(pcie);
-
-	ret =3D phy_init(pcie->phy);
-	if (ret)
-		return ret;
-
 	intel_pcie_core_rst_deassert(pcie);
=20
+	/* Controller clock must be provided earlier than PHY */
 	ret =3D clk_prepare_enable(pcie->core_clk);
 	if (ret) {
 		dev_err(pcie->pci.dev, "Core clock enable failed: %d\n", ret);
@@ -306,13 +302,17 @@ static int intel_pcie_host_setup(struct intel_pcie =
*pcie)
=20
 	pci->atu_base =3D pci->dbi_base + 0xC0000;
=20
+	ret =3D phy_init(pcie->phy);
+	if (ret)
+		goto phy_err;
+
 	intel_pcie_ltssm_disable(pcie);
 	intel_pcie_link_setup(pcie);
 	intel_pcie_init_n_fts(pci);
=20
 	ret =3D dw_pcie_setup_rc(&pci->pp);
 	if (ret)
-		goto app_init_err;
+		goto err;
=20
 	dw_pcie_upconfig_setup(pci);
=20
@@ -321,17 +321,18 @@ static int intel_pcie_host_setup(struct intel_pcie =
*pcie)
=20
 	ret =3D dw_pcie_wait_for_link(pci);
 	if (ret)
-		goto app_init_err;
+		goto err;
=20
 	intel_pcie_core_irq_enable(pcie);
=20
 	return 0;
=20
-app_init_err:
+err:
+	phy_exit(pcie->phy);
+phy_err:
 	clk_disable_unprepare(pcie->core_clk);
 clk_err:
 	intel_pcie_core_rst_assert(pcie);
-	phy_exit(pcie->phy);
=20
 	return ret;
 }

--=20
2.47.3

