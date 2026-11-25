Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795601878;
	b=tUn9fyh9Z0pQ/l8zIsKUa34xeKTuxkUjH/GpdXizsN6blBDYj1LLwFky9RIJFMa87wpq
	 bjbr5jnOctdozf0PsFU0Z70WkKqGUg0rYi6brWlnmXP3WDqIGsKf98D3MVAvBQN6i86u2
	 UnkKNdgrXlnzsa0/dSirNsKyar1Nefa7NLrfX4Ct86CCs0RFEMGi6e3a7VhGlvkfFRrpa
	 S+9LdV4Xb6K1xrCyoXfENNLqoVtY+Du5fj3/v3GmIK2lY+4ycQV6Y95RmrRhqfStOegDd
	 E3vUVmATXelirLruu648i4xroAbPaWyKiNRGB8qA35/6SQRlwKirAV95oTMPW3TPhKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601878;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=kqZb1W9yH3UuOXEKSV7hpbEFxa5ssZs3YaAfNDExtEw=;
	b=qfr4FnhbfDB0rCoEhaecoG7UI0nTHlMkb8w8oOmMBMnNQLnaXxhV54YXYpS9O7EE53WP
	 mOYbrzQ9qRTowdID0NT5Aht+oFWldMUd/Dbe9eJJ80k0QwhuW8N7k8sAZAl0G6MSCS0W5
	 VO8soMGr3f/C6NatSBN85AG1hA9TJ0x7h0Szsg57gto2AYcc1DivLAIoTBfkQhUGc2sR3
	 O2TfszyBXE0SpyMkNAtUqEJXU+XJiA4pwd6EDMp23ATUPQX/eWbrNrpQDwiM60mDuLF0/
	 eetg42tCkO+w0WY9JMBEbtMQmuqOJ2drf8KCkz+Rno85SnZ2jYgwYUUDZo1muj6ZZ9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9roNah4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A257D606A333;
	Wed, 25 Nov 2026 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9roNah4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795601877;
	b=AKWF0faLnQkr2gwzjXXh/bkfROE5j62qxuzSdfCK1bDdobxU9ObyNXc1dufFMXXJrPu4
	 uEpBW21O1wko+kkML9XUyxa9xZHjrdoOlGd+Y5HfwlqsPXzdwuiz9CbTR1ywIpX2jVPZ3
	 ziDZNCGLSsOL+R6I8cr/+7iBYOu3N9JQnBuZywnw+gWfPQ20bnzY9IZ/t9aw2LOFsM0+R
	 huIDKQx6oKupQv5k2LmtDb4BK6n1MXv+F3WFOOVFjxdMzzOdZ9A1545PYxwhA76JeLnMI
	 3iQa3BvL1XBMCOJfU4lwyYIwhjAL9W2/trSTsJyyAT9gDJYzEJqf5FdC9jbad8BJNeQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795601877;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=kqZb1W9yH3UuOXEKSV7hpbEFxa5ssZs3YaAfNDExtEw=;
	b=0qLw71uWfEQyg6uT4Sud94ZbdUjZpoJokw8gne6fNHwdWsBsffzakHVBWw292VcXOSHI
	 HCmPhizlG54a7SA2B2Ooja5WFA4LcpbHbvlqCjU2itMwz42diae1ML/XdPOHaBBwQuOb+
	 pzyCdsrewxnGVOi4gFJBDenwyrzUYSdMm9JXYRENy0jb7hoxiuDssU1fNRfA7mg3+F54w
	 47mLdlCaLpte+CFOsIAHIBKEFU8sD6nm+0Wd1u9HeTS7cF1ex1X3sRLEtEGRMAFigAvDm
	 aa4oiFGtvWY7sBjEx5UzqO9PJ1mg5CogXyudT8pLuR957votNqOtiu0+M3A9/HnhyxQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EFDAD1F000D1;
	Wed, 25 Nov 2026 10:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795601877;
	bh=kqZb1W9yH3UuOXEKSV7hpbEFxa5ssZs3YaAfNDExtEw=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=e9roNah4zQJWX9l8WaJHV+sEcg+dvY2PErIL/isDlt1tJEJS0V2OvAj0zKjbz/lOJ
	 C1DhgcAaN1uhlXkYfbHFbVYGXJc17Vnb9g+KDS9wJ0kMEq0UNrY8ykz0PfjhfTVq+M
	 Q0Pnds8KUie2vQohbTsNL1l4aDJmrTCxocfDia3OOUx7c81etjvotwwa1+uSigweRX
	 6bKzDL6tMGavK5taugqF9kAoVE0tbkRMl5DJqGcDP/M1Xu8abGMb6IKRw1N8SWpftU
	 Nf/1+J5nseZ8oc0xdVdbAOV+rhNrHLbqLxNRdMEn1ZAIrJeI8PahR2rGNUEFg7LbC9
	 w4WRmZZGqIuPw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 54A024CE37;
	Wed, 25 Nov 2026 10:17:52 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH 0/4] PCI: qcom: Recalibrate the PHY on temperature drift
Date: Wed, 25 Nov 2026 11:17:40 +0100
Message-Id: <20261125-glymur-thermal-fix-v1-0-b93a9feae156@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMS1BmsC/yXM3QpAQBCG4VvRHJvaXUW5FTlYazDy1ywiuXeLw
 +er773AkzB5yKMLhHb2PE8BOo7AdXZqCbkOBqNMqpVOsB3OcRNcO5LRDtjwgTprapdYZbPUQDg
 uQmH+okX5229VT259S3DfDzAArdl2AAAA
X-Change-ID: 20261013-glymur-thermal-fix-17fdc3a0a762
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2723;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=HgrmnZrPJ03VUOGr7acN3x0L+JRf71NfChjXIGvBIFI=;
 b=owEBbAGT/pANAwAKAVWfEeb+kc71AcsmYgBrBrXJN0nx0VuywW13Z9P5yu8BfPQgfO99OfSiF
 NpXFGodvkaJATIEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawa1yQAKCRBVnxHm/pHO
 9Y3KB/i2GophMZJQXPNfRUIqmFp7Af4cCz0vRGPONdERPpK8uIZobxvZyQ55b86iy2gt4z7Wrlh
 PpQQCgB3OnFqVkd3uC3IVbsMUC73LjQMWrcBWuoh8L6Fs8+CTWJxyadQR8JJhQEPBg8FuN62FRm
 KWeoWjWA2DkDymTW5d0MqpnmYofjpHBRzk1BwnIL3jizZfApARfb7sgZNBwK/zv8FJ2eWSciaMh
 rt4FTGVf57sYWGLdhWLQ/fOUAh9RBYyHQszHolrm0R+2iNcXn9RcFSZ3T/uA1waJvkpzqEAxwuL
 EcYzRdUIAal2GHmHSaaqCrvYcCXgtMiJOhq0brfJWnWX9wU=
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Problem Statement
=================

Some PCIe PHY instances on SoCs like Glymur benefit from periodic
recalibration to compensate for temperature-related drift and maintain
stable link operation. Otherwise there is a potential for a link drop.

The PHY gets calibrated when the link trains and it cannot recalibrate
itself while the link is up, so the recalibration has to be driven by
software.

Proposal
========

The PCIe controller driver triggers the recalibration with a PCIe link
speed switch once the temperature change on a polled sensor exceeds the
defined threshold. For this purpose, the driver needs to know which
sensors track the PHY temperature and the drift temperature. Both of them
vary per platform, so they come from DT.

Once a zone has drifted far enough, the driver performs the link speed
switching by scaling down the Target Link Speed to 2.5 GT/s and then
restoring the original Target Link Speed. This forces the link to run
Equalization again, which recalibrates the PHY against the current
temperature, thereby maintaining stable link operation. Equalization only
runs on a speed change to 8.0 GT/s or above.

Patch 1 adds a lookup from a DT node to its thermal zone, which the driver
needs for resolving the phandles it is handed. Patch 2 adds the new DT
binding property to specify the tuples of thermal zones and their drift
temperature. Patch 3 adds support for reading those zones on an interval
and recalibrating the PHY once one of them has drifted far enough.

Finally, patch 4 wires up the two Glymur PCIe controllers that use this,
pointing each one at the sensor that tracks the temperature of the PHY it
feeds.

Testing
=======

Tested on the Glymur CRD, on the two controllers patch 4 describes.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (4):
      thermal/of: Add thermal_zone_get_zone_by_node() API
      dt-bindings: PCI: qcom,pcie-x1e80100: Add qcom,pcie-recalibration-thermal-zones
      PCI: qcom: Recalibrate the PHY on temperature drift
      arm64: dts: qcom: glymur: Describe the PCIe thermal inputs

 .../bindings/pci/qcom,pcie-x1e80100.yaml           |  31 +++
 arch/arm64/boot/dts/qcom/glymur.dtsi               |   4 +
 drivers/pci/controller/dwc/pcie-qcom.c             | 224 +++++++++++++++++++++
 drivers/thermal/thermal_of.c                       |  21 ++
 include/linux/thermal.h                            |   8 +
 5 files changed, 288 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261013-glymur-thermal-fix-17fdc3a0a762

Best regards,
--  
மணிவண்ணன் சதாசிவம்


