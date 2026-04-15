Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45C1307AE3;
	Wed, 15 Apr 2026 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241179; cv=none; b=M84/8y2/Gib7rTVV9QUn200oiqdKzdt8zUMMFrUbOz/mzFckq8gDctDmL6pIAQGuN1sU15SkF+lCBa71U6BSsVOis6p9Bu2sqRtvxdQnuBUT02rwE7S9QOWLIOsOE8ePoxEs9ahI/bWlqmApbGNVWy1p4WZcXhCHFYBZdPCWvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241179; c=relaxed/simple;
	bh=EadTy1WXVKJsJIQNU5C/sb/DblrxVNjmV+l1CCkIcNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=F3rqXb/f90o/A963TTOPCcPy2gDND6LS91SiVjeQihBmxW+MG1rSiUOpbnYoBaOMl+8oau3NRVIuz/mn7hGmHtmUbQmGdu9LTuYpKDsVst9xvwWMh5MA3ijn+lIjwkNsYbilmya3chtdhuby21b223+uOiByMlBY26vJ7E6B1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=oEHi4N45; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="oEHi4N45"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=657992536b=fe@dev.tdt.de>)
	id 1wCvC8-00BwY1-5X; Wed, 15 Apr 2026 10:01:56 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1wCvC7-009xZa-JP; Wed, 15 Apr 2026 10:01:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1776240115;
	bh=qmOjkGY4isnqDRbe+0Ic2XKe3mIF3cZx+X8XlwRN5Jk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oEHi4N45NaNJt2UAQWK4yWf8fSRloszekii9nxVQr7Nc0HH3Jy014HNmmQzJpoO8M
	 9Lm/rKfW41wxaPy/H5qhg1bJyVfLlHyUc7i6WSsgb5RpdbMctjbL6H7okrb3x9UtXF
	 cjqRX0TCSe4Q4UcJheF9queVjl1hK3SwbskfJDSgCr89Xyqymd0iohiJJkh7ppOytc
	 hHI5+Ueh41ALeBWSyn9yre8rUMDRlvhyGUatLKj1o1H2sNXnj/iU22NX17F9NA/UD3
	 r5D7gn+47PmcRaU60B4SEvw9GJi+rpK8BOQIEx00iqL0n/S+fm12HuRdpl/TjN6cgQ
	 IENQKxOKhkaPg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 309C3240051;
	Wed, 15 Apr 2026 10:01:55 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 201A3240050;
	Wed, 15 Apr 2026 10:01:55 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 0513A24043;
	Wed, 15 Apr 2026 10:01:55 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Wed, 15 Apr 2026 10:01:53 +0200 (CEST)
Subject: [PATCH v4 7/7] dt-bindings: PCI: intel,lgm-pcie: Add atu resource
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20260415-pcie-intel-gw-v4-7-ad45d2418c8e@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776240111; l=1906;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=AXbWkqnfnXkg5GGOJ+SWn5GjqEnEK81zcfXBynbMX+Y=;
 b=qFOx4AXlU6qSrD3pRQNg40Jd30cjP0KfB+h/7s4PlP5d82gz0VP/G6ioWegoM4YyaqwVC00Xn
 /qqaFH1/FWFDGZIvbV+4GNNWjwhOkBlo2ezoDPCSkMYzMaWAdVhxBzo
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-ID: 151534::1776240116-3D7F12EC-F235BB83/0/0
X-purgate-type: clean

The 'atu' information is already set in the dwc core, if it is specified
in the devicetree. The driver uses its own default, if not set in the
devicetree. This information is hardware specific and should therefore be
maintained in the devicetree rather than in the source.

To be backward compatible, this field is not mandatory. If 'atu'
resource is not specified in the devicetree, the driver=E2=80=99s default=
 value
is used.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml b/D=
ocumentation/devicetree/bindings/pci/intel-gw-pcie.yaml
index 54e2890ae6314ac6847fc23f49440d05d66d87d4..9b7a8ef77585677841c7064c5=
001110bc2b65db1 100644
--- a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
@@ -27,16 +27,19 @@ properties:
       - const: snps,dw-pcie
=20
   reg:
+    minItems: 3
     items:
       - description: Controller control and status registers.
       - description: PCIe configuration registers.
       - description: Controller application registers.
+      - description: Internal Address Translation Unit (iATU) registers.
=20
   reg-names:
     items:
       - const: dbi
       - const: config
       - const: app
+      - const: atu
=20
   ranges:
     maxItems: 1
@@ -95,8 +98,9 @@ examples:
       #size-cells =3D <2>;
       reg =3D <0xd0e00000 0x1000>,
             <0xd2000000 0x800000>,
-            <0xd0a41000 0x1000>;
-      reg-names =3D "dbi", "config", "app";
+            <0xd0a41000 0x1000>,
+            <0xd0ec0000 0x1000>;
+      reg-names =3D "dbi", config", "app", "atu";
       linux,pci-domain =3D <0>;
       max-link-speed =3D <4>;
       bus-range =3D <0x00 0x08>;

--=20
2.47.3

