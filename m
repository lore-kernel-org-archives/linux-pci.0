Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97D435A8C;
	Mon,  6 Jul 2026 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377528; cv=none; b=MtWkBJ04PRqFQIgzeMeLzCktj+iPYgzl/Xqzd8Jg5eJUnNm6oyuPVU3Ja42exDojH+nBgcmKt9EkUGiu4YApJgp2uBCuslJJifE81tU4P5AYwC2V4+YOe3LWLWi1ejPKcB5w7lCe5PureS46aEGOJHXq5HaycaMPfCBsCL5LDPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377528; c=relaxed/simple;
	bh=Cu1jgg3NbLdbM7hEx3Ub79IibbWZ8rXwwdDEvO85wLM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PBvLDs8FrgQOVpc4aufwqIqIC88hyKlKxP+zOIFndsv+MYJw/AuSGhFCCBNcdAkVfVG+9IIvjclj5QF3uhuNF7+buQrFMII2nnAK2GTF2m7m72m6tOGtNGEIaALuye4LYpN3Y8/R2tSBIcB40fIFCjZYsUFcLGOntVTUkGrVbZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=EFwSFZCz; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="EFwSFZCz"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1783377517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=35CpdFffP/62zFF5JjwRjV4NgkfUPe4DE5l0yRpJh9w=;
	b=EFwSFZCzFdnTBKxiciPLYWB8xFR/ASGaIUHatC0RJr/dZ1rOgbrDi3YZJliwaYZxr0k8tM
	EiJetuC90ZV8OKDOHRczEbJZPILydlCdz1H+LvjAaQHa3SBtRIZi12rQklMUL+AIAVA5Y0
	pzHEXKpEGbzS4lnXgTuwoBHyAuHIjiU=
Subject: [PATCH 0/2] PCI: apple: Integrate pwrctrl API
Date: Tue, 07 Jul 2026 00:38:26 +0200
Message-Id: <20260707-apple-pcie-pwren-v1-0-5a281b182fe2@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGIuTGoC/yXMwQrDIBCE4VeRPUfQECzkVUoPcZ20W4IVbdpA8
 N1rk8vAd5h/p4IsKDSqnTI+UuQVG2yniB9TvENLaKbe9M5cjNNTSgt0YmnzzYjahGDhw2x5YGq
 3lDHLdiSvt9Nl9U/w+9+hWn/+ljMSdAAAAA==
X-Change-ID: 20260706-apple-pcie-pwren-0dd1ebdf1c4c
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, 
 Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

Hi all,

this is my attempt at using the pci-pwrctrl framework to power on the
PCIe-connected WiFi and SD card reader on Apple Silicon Macs.
Back in 2022, Hector Martin proposed a custom solution for this[1].
Since then, the pci-pwrctrl framework has evolved and
pci-pwrctrl-generic seems to be the way to do this nowadays.
Device tree changes for t600x are included as an example for how this
could be used.

Link[1]: https://lore.kernel.org/lkml/20220502093832.32778-4-marcan@marcan.st/
Link[2]: https://lwn.net/Articles/1052333/

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
Yureka Lilian (2):
      PCI: apple: Integrate pwrctrl API
      arm64: dts: apple: t600x: Add PCIe pwren gpios

 arch/arm64/boot/dts/apple/t600x-die0.dtsi      |  4 ++++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi | 16 +++++++++++++++
 arch/arm64/boot/dts/apple/t600x-j375.dtsi      | 27 ++++++++++++++++++++++++++
 drivers/pci/controller/Kconfig                 |  1 +
 drivers/pci/controller/pcie-apple.c            | 16 +++++++++++++++
 5 files changed, 64 insertions(+)
---
base-commit: 8e9685d3c41c35dd1b37df70d854137abcb2fbac
change-id: 20260706-apple-pcie-pwren-0dd1ebdf1c4c

Best regards,
--  
Yureka Lilian <yureka@cyberchaos.dev>

