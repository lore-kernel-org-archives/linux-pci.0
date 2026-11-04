Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792445;
	b=LBWUslG25KX49HpGyr9oXkGofLIhSunGXwePJagUHo/3V8kd6vmtUdaLETvV+NUp4ib3
	 wtBj+6ChCihCc2yHSGLwsmRwdOASt1snHXhFbNxlpwEyucGKkNRTB47uplAr8Te7lUe5U
	 8unle1YHGJ9/OEngz1ZXKWXnvc1vM/IvNjLhkT6jw6xI745yNkdixH+Y/oZNTipt3x4Ub
	 xU2bXvKEWQjVhl/QG6ahFjXVA7eS1Kcd6O6SPTwnKBObVq+f5F5kcEE/giNEcTVOfN8fe
	 9JF3S9bEhQMujP1dwbyA0H3Y9H/2vq9x69mIrfkc+s2h6XLBcbOxE8iuXYCjtqd/FJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792445;
	h=DMARC-Filter:From:DKIM-Signature:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc;
	bh=dx+ZTZohe60n7nAUUGj/dbTq2EwCer1csMhEs/N7uq8=;
	b=g2oZH2mjJEWd67GtftQc4krJ/ZLd6ZBBs9RkrYrqJp+6yiZCPaysjw9chk6hViIbONX2
	 9QgTMD7/eUyY2de1rMm0JKkrE+Dkgmq7KTTd7EV796yKAnB+FeoyklGuaDv5ABKipneid
	 T0Fy9q7P6xUiIpfK71+H6OGnuFrRMbXpI6D8odCWABmHOB8HzkKPz+ijxrPrtxaImrq0w
	 1BR4IveNgdZfteR+t75t2YQ5y7ikYZFPPkG4LDr3aXARuuI2X0xCag0j5s8qCzwv9kj4Q
	 /Tuqy9OqoJbMrmmNQ1gJOU4615DTM/ARB6wSibed2ilxh1rHRzP2EjIkw/l6ncVh+ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=q0YhZEKt;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4CA606A32C;
	Wed,  4 Nov 2026 11:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F4CA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=q0YhZEKt
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793792436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dx+ZTZohe60n7nAUUGj/dbTq2EwCer1csMhEs/N7uq8=;
	b=q0YhZEKt/191YdKM/l+D7NiR0idUSqYPf52teu+ideQmCJ5v6VpbQFXfJE7WbmDhPVz1WZ
	g2j9eUbU11vYZWe7qWNIv4uzkKkK5X6NiJ1gH4Ht2m3FT6fnjTJYhxa5AkykfFVftCnB5J
	PT8j8aHkOdqtKmWhY8qa+yMMfRBf6MA=
Subject: [PATCH v2 0/3] PCI: apple: Integrate pwrctrl API
Date: Wed, 04 Nov 2026 12:40:28 +0100
Message-Id: <20261104-apple-pcie-pwren-v2-0-216a4066965f@cyberchaos.dev>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WOywrCMBBFf6XM2kgStC2u/I/SRR4TOyJpSGq0l
 P67acWVmwsH7py5CySMhAku1QIRMyUafQF5qMAMyt+QkS0MksuaN7xmKoQHsmCoxCuiZ9xagdo
 6YU4GylmI6Oi9K7v+y+mp72imzbM1BkrTGOf9ZxZb76dv/vVZMM7OSrZCi1Y6lFcza4xl3JiOF
 jP067p+ANMssBrHAAAA
X-Change-ID: 20260706-apple-pcie-pwren-0dd1ebdf1c4c
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

Hi all,

This series integrates the PCI pwrctrl framework into the Apple PCIe
host driver to provide standardized power management for PCI ports.

This allows powering on the WiFi, SD card reader, and USB xHCI on
Apple Silicon Macs through the pwrctrl framework before probing the ports.

The first patch in this series exposes the necessary APIs to create,
destroy, and power on/off pwrctrl devices for individual ports.
The second patch integrates these APIs into the Apple PCIe driver on a
per-port basis. The third patch adds device tree changes for t600x as an
example.

Originally, a custom solution for powering on the WiFi and SD card
reader was proposed[1], but we can now use the pci-pwrctrl framework
for this purpose.

Link[1]: https://lore.kernel.org/lkml/20220502093832.32778-4-marcan@marcan.st/
---
Changes in v2:
- Split the pwrctrl API integration to work on a per-port basis for
  consistency with the rest of the driver
- Correctly use ERR_PTR to convert the error value before printing

To: Bartosz Golaszewski <brgl@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Marc Zyngier <maz@kernel.org>
To: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>
To: Neal Gompa <neal@gompa.dev>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org

---
Yureka Lilian (3):
      PCI/pwrctrl: Export per-device APIs
      PCI: apple: Integrate pwrctrl API
      arm64: dts: apple: t600x: Add PCIe pwren gpios

 arch/arm64/boot/dts/apple/t600x-die0.dtsi      |  4 ++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi | 16 ++++++++
 arch/arm64/boot/dts/apple/t600x-j375.dtsi      | 27 ++++++++++++++
 drivers/pci/controller/Kconfig                 |  1 +
 drivers/pci/controller/pcie-apple.c            | 23 ++++++++++++
 drivers/pci/pwrctrl/core.c                     | 51 +++++++++++++++++++++++---
 include/linux/pci-pwrctrl.h                    |  4 ++
 7 files changed, 121 insertions(+), 5 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260706-apple-pcie-pwren-0dd1ebdf1c4c

Best regards,
--  
Yureka Lilian <yureka@cyberchaos.dev>

