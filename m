Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3981C3CF032;
	Wed,  1 Apr 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035917; cv=none; b=TWj2U8hNV3xCWqTxWpCPgr1Tviy+KsBCQxLcf9SNbjck6nc1z7FOQVpk9RkaKpC8OBgZqTJZvk8tifLuzElpZy9KTT0axoOhABvLSQhilJiNeOgcAoKNUMGN8j6jGb/G+nY09Z639E0Kc+duy8zEyILwN2tHiFl6nxrkMy4KCRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035917; c=relaxed/simple;
	bh=nvgQstFC/8C3uAxwX6l6w10NoGOWBnOys1OW4EEIVmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=X2cAFN6wZQbUhUED8k0C6Vq0yuyT5/F5EAfyR5qXuiflMaVqh7YBdcW3m/63OFgL7sqBOAaxSMxb2tGZBg1JOE6Ae2Qb/0SvSK6fZnZnVtUu+0rf+9EuYDa+sTNN0g5GCON8Fm0Ujyn66gqnIUSEN2es6CL9FOApIxV13PcIIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=kaQ4vWmu; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="kaQ4vWmu"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65659f006e=fe@dev.tdt.de>)
	id 1w7rvM-001T0Q-Uz; Wed, 01 Apr 2026 11:31:45 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w7rvM-00CBFL-DM; Wed, 01 Apr 2026 11:31:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1775035904;
	bh=zKqMM7YfjGBHZcHoyCc72DeTKbYkA+Ky6K4OQtPbCik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kaQ4vWmuLNDUAQXOXmk89JgWVVYNM9R7aEtRqjkG4+R88x83er4656CELakt1xK0q
	 fNfDbrFGdOxkTTAkfUvLCCoM4vYCDQ5KnQAzGKqnapaMlRuXflrio6WdhKZIXbsVid
	 Sam4mpUWr22SrF3cE4R5c0gjT1timx6WCDXQLgB9WUQCrNySWIfkgvQoPgORkqtqZk
	 wyrmqI8F2497vTNsGT+px97MV042LOtUBfWpKG9EBRVbqid/M97mXQ4cxssSrmw+T/
	 r+dHXcop16JmGCGpOP33aqsqHaIkWcZdGmH46x26M+wMyW67YoTCOO9R751A2ivwhi
	 hpyQX19RaxB6g==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 0CC90240036;
	Wed,  1 Apr 2026 11:31:44 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 02315240040;
	Wed,  1 Apr 2026 11:31:44 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id B921B23C6F;
	Wed,  1 Apr 2026 11:31:43 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Wed, 01 Apr 2026 11:31:42 +0200
Subject: [PATCH v3 6/7] PCI: intel-gw: Move driver atu base assignment to
 probe function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20260401-pcie-intel-gw-v3-6-63b008c5b7b2@dev.tdt.de>
References: <20260401-pcie-intel-gw-v3-0-63b008c5b7b2@dev.tdt.de>
In-Reply-To: <20260401-pcie-intel-gw-v3-0-63b008c5b7b2@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775035902; l=3975;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=Uirz/FKs+IwSVaGspwLzgInnY3C/WWrZXZmhIyMs3ww=;
 b=Jd98K2cRrkn4RSEm8cX9bkhkxxtSviuDs0QJhUoGiv2tzARq8fkFSRyRdICAdWJn4AD6usr7B
 Wy6UjdjsZ5xBu+GurJoRvAzsv/iS3AJR0qedRX04b8HeC7hymNs0rEQ
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1775035904-4A7C8233-E0A53BA3/0/0

If no ATU resource is defined in the devicetree, then driver=C2=B4s defau=
lt
value '0x300000' [1] is set. This is done during probing in the function
'dw_pcie_get_resources()' [2] by dwc core.

The driver overwrites this again when its own init callback
'pp->ops->init()' [3] function 'intel_pcie_host_setup()' [4] is called.
This is done, because the 'atu_base' value for this IP is '0xC0000'
rather than '0x300000'.

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
must be set before, so that this value is not set by dwc core. Therefor
the assignment of 'atu_base' is moved to driver=C2=B4s probe function.

While we=E2=80=99re at it, the change also adds the option to load ATU in=
formation
from the device tree. For reasons of backwards compatibility, this is not
mandatory. If =E2=80=98atu=E2=80=99 is still not specified in the devicet=
ree, then driver=E2=80=99s
default value is still used and set in driver=C2=B4s probe function. If t=
he 'atu'
resource is present in the devicetree, then dwc core loads it via the
function 'dw_pcie_get_resources()' and not in the driver=C2=B4s probe fun=
ction.

[1] https://elixir.bootlin.com/linux/v6.19.10/source/drivers/pci/controll=
er/dwc/pcie-designware.h#L292
[2] https://elixir.bootlin.com/linux/v6.19.10/source/drivers/pci/controll=
er/dwc/pcie-designware.c#L150
[3] https://elixir.bootlin.com/linux/v6.19.10/source/drivers/pci/controll=
er/dwc/pcie-designware-host.c#L589
[4] https://elixir.bootlin.com/linux/v6.19.10/source/drivers/pci/controll=
er/dwc/pcie-intel-gw.c#L301

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

