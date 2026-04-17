Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4F2E8897;
	Fri, 17 Apr 2026 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414981; cv=none; b=lczi7WTqjKgqK96kkNYQFL+4GM4easwDaEh7FlsX6Cg48iofF4iPDHxnHgrqPHCgR1SM6zuPXY2ucknGSb34EJW8bCOzThbxXW69R+0g7PuC1lkwD8yAN78OLzZOY+LWCsgi5LCb+tlk4gV5Z2zPPJ4fTD3uVkmwOaeewTbMZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414981; c=relaxed/simple;
	bh=eLZe6oSogFgFNQGIVtFMPFO0Vms8X8TQuQx8X9tkJlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=PDlYIRl0GNmqOs6HFMNC1N7Xz6QZnUiBAM2t/Y4QbUrEvyFIw/B95zIBu7SOwF3Oygonn57vTn8U35BD0fKqrfpZo36dyEBf4Y8+a/nyqrHKCmSDkAdy/G3Po8Dn22GXPsa5jKUXHGDVTuiNZypcf1CSJIynXJBzYdJgjF0HZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=PfcNhIHL; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="PfcNhIHL"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=75813159fe=fe@dev.tdt.de>)
	id 1wDegP-00BgAo-2h; Fri, 17 Apr 2026 10:36:13 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1wDegO-008N6Z-I4; Fri, 17 Apr 2026 10:36:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1776414971;
	bh=mY2z2QKdBBeOr5UiVcsrgdhx1nZV87htEaBPB/m6dSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PfcNhIHLKCOuh6hsTq7jQ/30pQ0mboL/UKYqM83NXwmKnHwGq0HX1vNQhrvBRG0Nc
	 OmDVbuzz0avZyMeIuLTcKyj4pXBtC8dDFdDvE23404Ao0JYXTLE1T2ApkmqJXa9CfX
	 UQm/5wPSpj/AsqVzC9YxAVcSdQYN5JMxwq9gWsG601TcC0mTRdJBzQja38bGLqeOQF
	 KNP/xw1Ml6paLgzA6BMyT48V3xybcU6/vpvppXlQ3e81BI01fHh2tBKtRplaQHSldc
	 TKW7SGNOn2hVzaZafo8WHUeHa5w7zL3T7hhkkZ6bFXwlGVqBX0oRpqxWEQiFPDJSnI
	 VSgaTCZbul+Dw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id EE3D8240042;
	Fri, 17 Apr 2026 10:36:10 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id E7B43240041;
	Fri, 17 Apr 2026 10:36:10 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id BF16E23BD7;
	Fri, 17 Apr 2026 10:36:10 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Fri, 17 Apr 2026 10:35:50 +0200 (CEST)
Subject: [PATCH v5 6/7] PCI: intel-gw: Move driver atu base assignment to
 probe function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20260417-pcie-intel-gw-v5-6-0a2b933fe04f@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776414969; l=4090;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=kL2musMQ5PHaQWBVzchER4SxtQ6ESnYIALm57Dd11Ys=;
 b=MGUFGW1DqMVDQZmJQwac5r4KNEdwWjoroWsuXPX2wAuVFxy0K1HyDsbZ7nl98QuBioNXXHwmi
 Y3n4rB8f5MIBAxpWc8EXv4zZU5akHqoGc1/ZaraF2KCIVtOYlv10d4q
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate-ID: 151534::1776414973-1A6C6049-5D25D6A0/0/0
X-purgate: clean

If no ATU resource is defined in the devicetree, then driver=C2=B4s defau=
lt
value '0x300000' [1] is set. This is done during probing in the function
'dw_pcie_get_resources()' [2] by dwc core.

The driver overwrites this again when its own init callback
'pp->ops->init()' [3] function 'intel_pcie_host_setup()' [4] is called.
This is done, because the 'atu_base' offset for this IP is '0xC0000'rathe=
r
than '0x300000'.

callstack:
intel_pcie_probe()
  dw_pcie_host_init()
    dw_pcie_host_get_resources()
      dw_pcie_get_resources() [2]
    pp->ops->init =3D intel_pcie_rc_init() [3]
                      intel_pcie_host_setup() [4]

However, this is a problem because, the callback 'pp->ops->init' is calle=
d
after 'dw_pcie_get_resources()' in dwc core (see callstack). The 'atu_bas=
e'
must be set before, so that this value is not set by dwc core. Therefore
the assignment of 'atu_base' is moved to driver=C2=B4s probe function.

While we=E2=80=99re at it, the change also adds the option to load ATU in=
formation
from the device tree. For reasons of backwards compatibility, this is not
mandatory. If =E2=80=98atu=E2=80=99 is not specified in the devicetree, t=
hen driver=E2=80=99s
default value is still used and set in driver=C2=B4s probe function. If t=
he 'atu'
resource is present in the devicetree, then dwc core loads it via the
function 'dw_pcie_get_resources()' and not in the driver=C2=B4s probe fun=
ction.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/pci/controller/dwc/pcie-designware.h?h=3Dv7.0#n292
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/pci/controller/dwc/pcie-designware.c?h=3Dv7.0#n150
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/pci/controller/dwc/pcie-designware-host.c?h=3Dv7.0#n588
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/pci/controller/dwc/pcie-intel-gw.c?h=3Dv7.0#n301

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 28 ++++++++++++++++++++++++=
++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/con=
troller/dwc/pcie-intel-gw.c
index afd933050c92ee31c477e0b1738ab1136bdcfbf6..59b11e45944e199aac0f599f9=
6d6cc90e2104708 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -310,8 +310,6 @@ static int intel_pcie_host_setup(struct intel_pcie *p=
cie)
 		goto clk_err;
 	}
=20
-	pci->atu_base =3D pci->dbi_base + 0xC0000;
-
 	ret =3D phy_init(pcie->phy);
 	if (ret)
 		goto phy_err;
@@ -395,6 +393,7 @@ static int intel_pcie_probe(struct platform_device *p=
dev)
 	struct device *dev =3D &pdev->dev;
 	struct intel_pcie *pcie;
 	struct dw_pcie_rp *pp;
+	struct resource *res;
 	struct dw_pcie *pci;
 	int ret;
=20
@@ -419,6 +418,31 @@ static int intel_pcie_probe(struct platform_device *=
pdev)
 	pci->ops =3D &intel_pcie_ops;
 	pp->ops =3D &intel_pcie_dw_ops;
=20
+	/*
+	 * If the 'atu' resource is not available in the devicetree,
+	 * then use the driver default value for backward compatibility.
+	 * The 'atu' should always be set in the devicetree, as this is
+	 * hardware specific setting that should not be defined in the
+	 * source.
+	 */
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
+	if (!res) {
+		res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+		pci->dbi_base =3D devm_pci_remap_cfg_resource(pci->dev, res);
+		if (IS_ERR(pci->dbi_base))
+			return PTR_ERR(pci->dbi_base);
+		pci->dbi_phys_addr =3D res->start;
+		pci->atu_base =3D devm_ioremap(dev, res->start + 0xC0000, SZ_4K);
+		if (!pci->atu_base) {
+			dev_err(dev, "failed to remap ATU space\n");
+			return -ENOMEM;
+
+		}
+		pci->atu_size =3D SZ_4K;
+		pci->atu_phys_addr =3D res->start + 0xC0000;
+		dev_warn(dev, "devicetree ATU resource is missing; driver`s default va=
lue is being used\n");
+	}
+
 	ret =3D dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "Cannot initialize host\n");

--=20
2.47.3

