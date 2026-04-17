Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3B3A9615;
	Fri, 17 Apr 2026 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414981; cv=none; b=Xx/VgoFOySAA4FJ1Y0vlbTWYKaRlFiin384VJXJTiMqzooJ6yB3hiee3J2If8U/RF8MXVutRCRCud3w0mmvTPZOjXcRnWepZ6CHE995ZMwDf1yBoFkmtzNmXJCITPYC9Eb6Vw8UW302hnwVfpFcKWY8mJrxOSEJ3vQyzL5baYuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414981; c=relaxed/simple;
	bh=t+G3zYgTsMTowJn0yo3fLFh5TKKiqyTLaVwL59V0M1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=LwnJOQ4Fqs9J2ffRRtsZVAhmgxmw44N9wjo0s6mJpAJO3m9auaflOvIeqOJTXdHuq1EbnkAd8w9LNJ/AUAuUpyFh17WiutPG92a6+82CuWf10M1p2LviPqAmGO5ZRfYvif6yAYxPMhWT1YicaPGIN+vOib9ryydFYA0dpwWhIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=GELn7gSc; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="GELn7gSc"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=75813159fe=fe@dev.tdt.de>)
	id 1wDegP-00BgAj-0i; Fri, 17 Apr 2026 10:36:13 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1wDegO-00DTvO-HA; Fri, 17 Apr 2026 10:36:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1776414971;
	bh=VpO7tSDeSrvpivl94BB4ux2keIxCCjATqhuGI/Eo9ho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GELn7gScTbj+/R8BGijesND5vsQxr5R/Fo2BdrI81/yG6zZWurrxuinz6HKIvA8Y5
	 7oMF+kdK/gGsrBYH7uzL6AQl1w71hQP+9FThkkUf2unkmxSnD8jsKhUvlf+rp84w16
	 SiIGeSRmO1IE3sR42lqVdvnqSu1zRfGLfmxsYgJAfZmYVg9kJCH7kfexmVJqW3NMF2
	 z3UNukl/SByL6Dsmh98YFCPWHBw6uLYgoHMEqllerKALJYjLPLP3J6hMtLvubEmEh3
	 omvsrs7g67uP8AcpaVU5iZweZ3YSSHmkcw/m7uh7WvDt5Bjp4IyI4jfapjoy5JFZC+
	 Gl+EOltPvn26A==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 1AD40240041;
	Fri, 17 Apr 2026 10:36:11 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 11E13240040;
	Fri, 17 Apr 2026 10:36:11 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id E6E31242E4;
	Fri, 17 Apr 2026 10:36:10 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Fri, 17 Apr 2026 10:35:51 +0200 (CEST)
Subject: [PATCH v5 7/7] dt-bindings: PCI: intel,lgm-pcie: Add atu resource
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20260417-pcie-intel-gw-v5-7-0a2b933fe04f@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776414969; l=1926;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=rlwTMCXH/aMqUifxKhjkwyS27qKPELxXtIKb/5h280o=;
 b=2Rfky6YKUgQWBMqIyb/z6lyGcEay4A9f4YYYOv7T+W27+BbjpN2beAgIl3MYvVzRy6i/1x6Md
 JDJd8unUAuGB2+z0QwR2y1qXqqsjaxOnTZMyae9ZGFBT2B+gHIXf6ou
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-ID: 151534::1776414972-1B6C0049-C5E597B6/0/0
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
 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml b/D=
ocumentation/devicetree/bindings/pci/intel-gw-pcie.yaml
index 54e2890ae6314ac6847fc23f49440d05d66d87d4..394bb46b38e601345429de828=
f491980f8058d25 100644
--- a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
@@ -27,16 +27,20 @@ properties:
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
+    minItems: 3
     items:
       - const: dbi
       - const: config
       - const: app
+      - const: atu
=20
   ranges:
     maxItems: 1
@@ -95,8 +99,9 @@ examples:
       #size-cells =3D <2>;
       reg =3D <0xd0e00000 0x1000>,
             <0xd2000000 0x800000>,
-            <0xd0a41000 0x1000>;
-      reg-names =3D "dbi", "config", "app";
+            <0xd0a41000 0x1000>,
+            <0xd0ec0000 0x1000>;
+      reg-names =3D "dbi", "config", "app", "atu";
       linux,pci-domain =3D <0>;
       max-link-speed =3D <4>;
       bus-range =3D <0x00 0x08>;

--=20
2.47.3

