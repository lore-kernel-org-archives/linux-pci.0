Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E193B27EE;
	Mon, 30 Mar 2026 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861659; cv=none; b=DRGeUoqm62qmxmDQDoqIBkDRUqnPKhRzBeXK1NVLOyER2B6Gvx+scOhw0kjOyDaPVU3I9E7qhSdeZaDYkvlFEQKuZVvtU1XKicxLpqDvCaD3KVy+3l7kpcAYft7gOrbAn0eDdB+KcgAoAOZwxHGdrAo97Ow5vuEL4K1Xi3HDlRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861659; c=relaxed/simple;
	bh=44idu4lYBdKXyDCFc9AO6ve7cpsNsJ7WQmMRL/XaSSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=VT60gQyAqo+REvCLuu4vCOqnCTKMHDSO4DtBjk4wTnQYG2sUXG04OOZc5wFyUslYTNKoyfIO5ULu4VIMMZbNbVji1j4F5Kl2A6vDylpVh7EBMQTRoHekefIy/3audyy775+N33l2epeJk+qgRZZLAJrVViwhY99z6QRh9EUYO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=vAS07I3H; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="vAS07I3H"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65635f912b=fe@dev.tdt.de>)
	id 1w78aq-008YeP-GA; Mon, 30 Mar 2026 11:07:32 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w78ap-009iaO-Uj; Mon, 30 Mar 2026 11:07:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774861651;
	bh=Lo8WEUkHygeOqbMVPhJFGYFHIJXRE1Uzi8HNns3bkEw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vAS07I3HaPpi0MC8vRKNLCCWN2U6M5z/8BPTxwgWzPhoCDkdTQYRtQUdPsQq5EEDq
	 7u4e02n76XY3ajnK1YDON6eMTsHbdFRY+9k4+3IizEEJUxTl7fxvX4rgQeQBQzszkk
	 fOufYlok8C2pZ+HJOI43qhrc+z3qwTznCZKKoNK/odj17ImIcE/FjNERupgid8+yRx
	 H5esvO2tXlpzeVM/INpKx7b6gbDwuXQc2AaVxyyHq29zmxxAt52D1U+VbccNtSolrp
	 QCdX7mXeYLDTTqZegkG3U7LPzyhNDg5/koX/l4ljf9RiT9b3ag8WDDYzPd5g16NP+e
	 ZkyfdZUZ4Gifw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 8AD7C240036;
	Mon, 30 Mar 2026 11:07:31 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 80E7D240045;
	Mon, 30 Mar 2026 11:07:31 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 5D5E02040A;
	Mon, 30 Mar 2026 11:07:31 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Mon, 30 Mar 2026 11:07:16 +0200
Subject: [PATCH v2 6/7] dt-bindings: PCI: intel,lgm-pcie: Make atu resource
 mandatory
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260330-pcie-intel-gw-v2-6-8bd07367a298@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774861650; l=2279;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=44idu4lYBdKXyDCFc9AO6ve7cpsNsJ7WQmMRL/XaSSA=;
 b=6a+kh0mrGISPBeBV/cRAwP8gS1HnnlsT0AWSdGXFxEO18dzeS8qY2onc1qUgtozQ9Uoeo0n+s
 flstiyub/yWCgJKA0My87ZAtUKMOtJqQkxL0lz0Z3fWChoNPmSrCaEh
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate-type: clean
X-purgate-ID: 151534::1774861652-ECECE842-7064A64C/0/0
X-purgate: clean

The ATU information is already set in the dwc core if it is specified in
the DTS. The driver uses its own value here [1]. This information is
hardware specific and should therefore be maintained in the DTS rather
than in the source.

Backwards compatibility is not an issue here [5], as the driver is
exclusively used by Maxlinear.

Old DTS entry for PCIe:

reg = <0xd1000000 0x1000>,
      <0xd3000000 0x20000>,
      <0xd0c41000.0x1000>;
reg-names = "dbi", "config", "app";

New DTS entry for PCIe:

reg = <0xd1000000 0x1000>,
      <0xd10c0000 0x1000>,
      <0xd3000000 0x20000>,
     <0xd0c41000.0x1000>;
reg-names = "dbi", "atu", "config", "app";

[1] https://elixir.bootlin.com/linux/v6.19.10/source/drivers/pci/controller/dwc/pcie-intel-gw.c#L301
[2] https://lore.kernel.org/all/BY3PR19MB507667CE7531D863E1E5F8AEBDD82@BY3PR19MB5076.namprd19.prod.outlook.com/

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
index 54e2890ae6314ac6847fc23f49440d05d66d87d4..e4b781f57e8ae84a3ffc33635a421e1a5761587e 100644
--- a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
@@ -29,12 +29,14 @@ properties:
   reg:
     items:
       - description: Controller control and status registers.
+      - description: Internal Address Translation Unit (iATU) registers.
       - description: PCIe configuration registers.
       - description: Controller application registers.
 
   reg-names:
     items:
       - const: dbi
+      - const: atu
       - const: config
       - const: app
 
@@ -94,9 +96,10 @@ examples:
       #address-cells = <3>;
       #size-cells = <2>;
       reg = <0xd0e00000 0x1000>,
+            <0xd0ec0000 0x1000>,
             <0xd2000000 0x800000>,
             <0xd0a41000 0x1000>;
-      reg-names = "dbi", "config", "app";
+      reg-names = "dbi", "atu", config", "app";
       linux,pci-domain = <0>;
       max-link-speed = <4>;
       bus-range = <0x00 0x08>;

-- 
2.47.3

