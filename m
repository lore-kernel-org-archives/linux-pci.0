Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C13CE490;
	Wed, 15 Apr 2026 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241216; cv=none; b=rzj3GeS30pZZPOc6CEz2v1lt+4eJ3ATep6tJW4Mft/kXDVYhI3kis5kNpgqhnzre7IsC82GObICc+Ok7bcUYltRnP8wo7KIeOOGm7muQrrh6OcjKUGgn63HSopq4e4+HlNWR3o41Mi4bCKOVFOG2xqhc8E0Hhoy8PhesSr1HYU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241216; c=relaxed/simple;
	bh=eLZe6oSogFgFNQGIVtFMPFO0Vms8X8TQuQx8X9tkJlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=Ph173u/4fjrpmObAYlMmmBB9Cw75AArJQg9moMs2EzN4KFs+Sjd/Og7X+wlNbm13S5RVEzBi0yPMDxsfJTQovU1wsYHcz1Fe3lf6LrSGMA4x6JPpehtXdCSnJWFwoI0jyveCOaVgMv080L22Y676SpeMFbWTe/oVNLryNWGVsY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=XRV9fGkl; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="XRV9fGkl"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=657992536b=fe@dev.tdt.de>)
	id 1wCvC8-00BwXd-0R; Wed, 15 Apr 2026 10:01:56 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1wCvC7-00EgtW-GM; Wed, 15 Apr 2026 10:01:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1776240115;
	bh=mY2z2QKdBBeOr5UiVcsrgdhx1nZV87htEaBPB/m6dSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XRV9fGklTeOe5M2r5xA8BLqk/K7awcwnL7akKXe2rEzsFnh+mC/Gx+z7xBWHubPZH
	 6arb2crYu7ALl0dUHNzjiN3Wc4wgWV7y8HJkWUwEMz0H30OFBIqFD52XmmPGX7FPuB
	 1DdXmvnZ+BsB1Nf1P/9HAwtoUu7GEGSAjWPIsSzPtpXjZaXNJExfAhnPjRRiUkGJIu
	 aN9fdI9a8W5iXJYTRVW3f3Fu/BH62m4PG8RbkK/97gW7uD9EKWWB2gGLHhIIzBn8yL
	 CYoDcktTii6BRKxX5k/tytKXOmhJU0Ug/FHtAwJK9IXGbUXatoYoFYUlU79Y7VWlPP
	 yzYRc9MENSaJA==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 0D27D240047;
	Wed, 15 Apr 2026 10:01:55 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 05089240041;
	Wed, 15 Apr 2026 10:01:55 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id CFD2323F30;
	Wed, 15 Apr 2026 10:01:54 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Wed, 15 Apr 2026 10:01:52 +0200 (CEST)
Subject: [PATCH v4 6/7] PCI: intel-gw: Move driver atu base assignment to
 probe function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20260415-pcie-intel-gw-v4-6-ad45d2418c8e@dev.tdt.de>
References: <20260415-pcie-intel-gw-v4-0-ad45d2418c8e@dev.tdt.de>
In-Reply-To: <20260415-pcie-intel-gw-v4-0-ad45d2418c8e@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776240111; l=4090;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=kL2musMQ5PHaQWBVzchER4SxtQ6ESnYIALm57Dd11Ys=;
 b=yGKeqrvY4u8dzv1D8UT8QnnloC0dXDRyM6dnpMCLGN/vJGhFlhzhNZTa+NLSFvpg8AV974zSQ
 IlxSBsS7KlGAobAjh9XoXc6Vg7qe197rxqjg+Km+B831cHauXJDoqzZ
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-ID: 151534::1776240115-3CFFE2EC-B150F9D6/0/0
X-purgate-type: clean

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

