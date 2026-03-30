Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A843B27C9;
	Mon, 30 Mar 2026 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861658; cv=none; b=hbxmzuKoj6oHFJw93zF+ERgdwJ0X9NQshRVyd1FUd5MXg3CzlNEsbKp1dfaa9Rnn9rP1pIXXhulMW/yFBft+vVuTRAR+oEfTN2+g7bNFVXdGmfE/HXbmlSDMXe4XdxhD2c9aRw+MKz26aKNBi48Ck/Xns2TI6KgaEkJYs2BNVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861658; c=relaxed/simple;
	bh=agN87K+CDzqSq8A3CtdiM5qsSgnm7chk8ZFt0OrwmeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=kbjzRHyrZxIzXWHzLzEvwbfbpgN/AVk+b+FebPIkqc7GwISmIzPSc9jEHS1l/+eV9Ylkcm0DhNymY0Vv6oA6kkBOk93hsDYHKAFB8xc02hXzH88oz1BAUEPOjFxljkuPoq8ShHUOkmf8MiYCdP9EY//SFzhe62n1x81mZYd7h1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=edQ2oG6K; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="edQ2oG6K"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65635f912b=fe@dev.tdt.de>)
	id 1w78ap-008Ycu-Ul; Mon, 30 Mar 2026 11:07:32 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w78ap-008YbP-Cp; Mon, 30 Mar 2026 11:07:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774861650;
	bh=lMn3lFGeOL2LbKYJ5BgVNUmk+cjNqBsZKKuwLQ+o6aA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=edQ2oG6K66GfAqJd0kgsfIGvAxxbeJ6DEyt+5Bgy+bgnQFenimYRilAADUh5RbGMQ
	 Q0RicTNqpHcpobDeh+HbIUWsy18osA6NtvKdKkL8iPHf7ByRfUYo2SHv784G+8jOIA
	 ICArCQDj/oo6GFpUe78VW0qnnq9piU/Ee72S+qjhvaWmjzk2rZkrsLLXLc+b4m4TWM
	 3K+Q9EFjoVSa/m2AFL3BZ0gjOBVlA2iGPn3BK+k0dLC7R4wNuz3CN0yXYUc0oUJ5+9
	 uI+mcof7fuQsnIvNI5DmaUQl07ED1A5lbtF8chk8QXyFCGgUelVa9lsEdepQ24+iVS
	 NHdH1OgRbk3ZA==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id E5F25240047;
	Mon, 30 Mar 2026 11:07:30 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id D6BDC240046;
	Mon, 30 Mar 2026 11:07:30 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id B50B62040A;
	Mon, 30 Mar 2026 11:07:30 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Mon, 30 Mar 2026 11:07:12 +0200
Subject: [PATCH v2 2/7] PCI: intel-gw: Move interrupt enable to own
 function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20260330-pcie-intel-gw-v2-2-8bd07367a298@dev.tdt.de>
References: <20260330-pcie-intel-gw-v2-0-8bd07367a298@dev.tdt.de>
In-Reply-To: <20260330-pcie-intel-gw-v2-0-8bd07367a298@dev.tdt.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rahul Tanwar <rtanwar@maxlinear.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>,
	Eckert.Florian@googlemail.com, ms@dev.tdt.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774861650; l=2285;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=lb6QCw9gymNGaU3gwgLeUyGUNWDhF66pmRRGTrBntko=;
 b=sNI2x29ee8uZAAOa7uvLnjH0hd/tlcDXapNwhd+w/Lxe6TI2ELK+oSHLImAoSEYbbPr2pI5UM
 h6JCo6beY/zAk1YwVMLUenjAct7orP8Fysn3R/7pAmn9P4yV/lhKKmZ
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1774861651-EEC25842-DDEDDA82/0/0
X-purgate: clean
X-purgate-type: clean

To improve the readability of the code, move the interrupt enable
instructions to a separate function. That is already done for the disable
interrupt instruction.

In addtion, all pending interrupts are cleared and disabled, just as this
is done in the disable function 'intel_pcie_core_irq_disable()'. After
that, all relevant interrupts are enabled again. The 'PCIE_APP_IRNEN'
definition contains all the relevant interrupts that are of interest.

This change is also done in the Maxlinear SDK [1]. As I unfortunately
don=E2=80=99t have any documentation for this IP core, I suspect that the
intention is to set the IP core for interrupt handling to a specific
state. Perhaps the problem was that the IP core did not reinitialize the
interrupt register properly after a power cycle.

In my view, it can=E2=80=99t do any harm to switch the interrupt off and =
then on
again to set them to a specific state.

[1] https://github.com/maxlinear/linux/blob/updk_9.1.90/drivers/pci/contr=
oller/dwc/pcie-intel-gw.c#L431

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/con=
troller/dwc/pcie-intel-gw.c
index 80d1607c46cbbb1e274b37a0bb9377a877678f5d..e88b8243cc41c607c39e4d58c=
4dcd8c8c082e8b0 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -195,6 +195,13 @@ static void intel_pcie_device_rst_deassert(struct in=
tel_pcie *pcie)
 	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
 }
=20
+static void intel_pcie_core_irq_enable(struct intel_pcie *pcie)
+{
+	pcie_app_wr(pcie, PCIE_APP_IRNEN, 0);
+	pcie_app_wr(pcie, PCIE_APP_IRNCR, PCIE_APP_IRN_INT);
+	pcie_app_wr(pcie, PCIE_APP_IRNEN, PCIE_APP_IRN_INT);
+}
+
 static void intel_pcie_core_irq_disable(struct intel_pcie *pcie)
 {
 	pcie_app_wr(pcie, PCIE_APP_IRNEN, 0);
@@ -316,9 +323,7 @@ static int intel_pcie_host_setup(struct intel_pcie *p=
cie)
 	if (ret)
 		goto app_init_err;
=20
-	/* Enable integrated interrupts */
-	pcie_app_wr_mask(pcie, PCIE_APP_IRNEN, PCIE_APP_IRN_INT,
-			 PCIE_APP_IRN_INT);
+	intel_pcie_core_irq_enable(pcie);
=20
 	return 0;
=20

--=20
2.47.3

