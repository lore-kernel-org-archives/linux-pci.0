Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397853CF02D;
	Wed,  1 Apr 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035917; cv=none; b=Flae8pASdlMsaQVPt8TFR1izkEKdG5ROywY03fZDKxn5ldatZoR/14HD/iCLS3+JW5zKnTm8cvjs6qqFQPryg+ElVKvHSxoMOZsTe0C3NEufAAvHumnjmwzawjYT9anhXxcm2qnLMx0qMFKopgkW9ubwBrhjG1TQ7KSNdrSHHVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035917; c=relaxed/simple;
	bh=R2vCsdbJHHcFr8iqaU4GCFC2E1xF3bRK76EuHCM2p6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=aMO7UdnEXPspzw0HofthQbGR50sbog32KBx7xSGxba8r0YhQxpZiZaGjWesg4qsRdGnHFEWe23oxNoT0+kDM/Cuy7dm+a7p3494OBkG+l8b/gMcGhoCLf3nIgFJJ8s7HWMdoSPK7pwQ2qE05FU3XI3WoexjQZPFXW95zMtA+zwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=JlYDnwCQ; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="JlYDnwCQ"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65659f006e=fe@dev.tdt.de>)
	id 1w7rvN-001T0m-2s; Wed, 01 Apr 2026 11:31:45 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w7rvM-003a8y-Hi; Wed, 01 Apr 2026 11:31:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1775035904;
	bh=80wSRuaaz4Z5I6/Igjb6weeWQYoJM4kb2xLfVStZAQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JlYDnwCQPmIVeJ0VOpCeyJt/i3x0VjPd9NCAum70+bXWlKIIms+EayTkUkUU71UeC
	 Y2LKTPZIFjF60Wwv995cX6mCPrdF2MmlqsLEGVAH8M32aO7p7Qv8ApLLJG84jIcBie
	 4PlGTRbtMxdzJ13khIu6ZkI1RY5GhyvvRrkDmPkQr75tP7MNe1Ydk4t8bS7bhqqwlI
	 o45lsPyVIkVpnjNJHRjDO2gy3DulOqguwpUpannAYKguSb7ERlWLa1CwmJls8mtfxs
	 Y2DHcEeAjH0cTU0Cf3trOpCk55DygGjkLVjTGIuOqBqcHXeCVuWBO5hZhpf7suYuH7
	 5LgGPH+RzlfKQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 27C86240047;
	Wed,  1 Apr 2026 11:31:44 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 1EA28240045;
	Wed,  1 Apr 2026 11:31:44 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 0059923C7E;
	Wed,  1 Apr 2026 11:31:44 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Wed, 01 Apr 2026 11:31:43 +0200
Subject: [PATCH v3 7/7] dt-bindings: PCI: intel,lgm-pcie: Add atu resource
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20260401-pcie-intel-gw-v3-7-63b008c5b7b2@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775035902; l=2237;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=HJlP/B9l/9XIBtHUr6FUXPARzVZw8W2vrdkskTwd5Tw=;
 b=FLahYPjlIdeF7+mWTBgC9P9Ri0wSzLTVgpjH7VcmM1VkQS1r9ehocBcI+yYgbRDkcApt6ocxl
 6aj5lslBovIBwy/y0NI+YJvacqDqm+NNkjtkS2Ot7+1L4hV7ZrMXtY+
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1775035905-3CFC5233-26DC20E1/0/0
X-purgate: clean
X-purgate-type: clean

The 'atu' information is already set in the dwc core, if it is specified
in the devicetree. The driver uses its own default, if not set in the
devicetree. This information is hardware specific and should therefore be
maintained in the devicetree rather than in the source.

To be backward compatibile, this field is not mandatory. If 'atu'
resource is not specified in the devicetree, the driver=E2=80=99s default=
 value
is used.

Old DTS entry for PCIe:

reg =3D <0xd1000000 0x1000>,
      <0xd3000000 0x20000>,
      <0xd0c41000.0x1000>;
reg-names =3D "dbi", "config", "app";

New DTS entry for PCIe:

reg =3D <0xd1000000 0x1000>,
      <0xd10c0000 0x1000>,
      <0xd3000000 0x20000>,
     <0xd0c41000.0x1000>;
reg-names =3D "dbi", "atu", "config", "app";

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml b/D=
ocumentation/devicetree/bindings/pci/intel-gw-pcie.yaml
index 54e2890ae6314ac6847fc23f49440d05d66d87d4..a7cb2b66b382a55d88211890a=
ee068f25f05f61b 100644
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
@@ -94,9 +97,10 @@ examples:
       #address-cells =3D <3>;
       #size-cells =3D <2>;
       reg =3D <0xd0e00000 0x1000>,
+            <0xd0ec0000 0x1000>,
             <0xd2000000 0x800000>,
             <0xd0a41000 0x1000>;
-      reg-names =3D "dbi", "config", "app";
+      reg-names =3D "dbi", "atu", "config", "app";
       linux,pci-domain =3D <0>;
       max-link-speed =3D <4>;
       bus-range =3D <0x00 0x08>;

--=20
2.47.3

