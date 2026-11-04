Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792448;
	b=y7P6DgpNUTP6vL2hKQ9QMBfkvs+yYDjmJl8fu+hvRzbtrhCRWDSD6IliKyoSL16fXLap
	 VPVuN8pXOy6iwwhSlwKyD2ypd7TgOb0sISXpeaHWzsYyfWVy0QaEls7vxWtbTR4+2eip4
	 4xQVDQ+px01/9zhh8oMGJXqxOzIL2GNPN4TdRh5301DXxCDwGaJiBI9U6Bf0jCqUq7iUq
	 dvBC2gpCC2CmyCyZg+Nvr5qzmErfvN/g+J3LlIQb1qe4iv6dg9iImIZYyqhEmwjnzLtWE
	 e+mmCOZE18TKRRiFjhvSfQJb7pcviNgJZMtdSJPM3FTiLgo0qKdGqJX/vAF9I7Ed95Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792448;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=8FaVhxguwgKI7Sj57jrxeuXDOLyYakEWO+TPFrvtixk=;
	b=k+hDsEmqUy8MfvOm07hbRtJuvc6oxMeR6U4Lg1jQF/5Vkoq33UYnEd6takqZe4ueaa0P
	 CShYSaH7kfXbhVBp0hulmF+jDb7cmMtXp9u2T1X2rB7Fm0nuMix2lYdASmvR5JAKA43A6
	 JOH5QQLy/RWl4seoZMxf3wDADfYE+rce8HOWlHVHksBmx39msyPTHUe7cxH2JWPTELfR9
	 ZJogd0S0D+/fc3DPk4lEl2azf9SWJk4DSZGXyyqO+WOBESTecFW3xtrjgtiVDzaA8E2SH
	 KYsTpGjtLgpFaae/9pWR/VrIe7aXmflNDaYEw9/MRjqgBdljrJ2q0BUpC0rnWUlyg1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b="at5rsQ/j";
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657FA606A339;
	Wed,  4 Nov 2026 11:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 657FA606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=at5rsQ/j
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793792440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FaVhxguwgKI7Sj57jrxeuXDOLyYakEWO+TPFrvtixk=;
	b=at5rsQ/jOkdtSPI+2QXw+EHXVB0TuvT/f3XdBQ1Di6LlgYRik4GL+5r+04gFo7VDr5l9Rl
	ggQpu/7Oh0QBbq+LQr2TqWomFiArzV9yOefxmasCliQWvFROLC1C85e4ct8RRClPiviwQg
	Hq/jJ3KP5RU7Yv6vjptFycvChAMiA8s=
Date: Wed, 04 Nov 2026 12:40:30 +0100
Subject: [PATCH v2 2/3] PCI: apple: Integrate pwrctrl API
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-apple-pcie-pwren-v2-2-216a4066965f@cyberchaos.dev>
References: <20261104-apple-pcie-pwren-v2-0-216a4066965f@cyberchaos.dev>
In-Reply-To: <20261104-apple-pcie-pwren-v2-0-216a4066965f@cyberchaos.dev>
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

Integrate the PCI pwrctrl framework into the Apple PCIe host driver to
provide standardized power management for PCI devices.

Notably, this allows enabling powering on the WiFi, SD card reader on
various Macs by means of the pwrctrl framework before probing the ports.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 drivers/pci/controller/Kconfig      |  1 +
 drivers/pci/controller/pcie-apple.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index d246bbe37948..791892a6c0c6 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -46,6 +46,7 @@ config PCIE_APPLE
 	depends on OF
 	depends on PCI_MSI
 	select PCI_HOST_COMMON
+	select PCI_PWRCTRL_GENERIC
 	select IRQ_MSI_LIB
 	help
 	  Say Y here if you want to enable PCIe controller support on Apple
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index c2cffc0659f4..2d32092e2122 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -30,6 +30,7 @@
 #include <linux/msi.h>
 #include <linux/of_irq.h>
 #include <linux/pci-ecam.h>
+#include <linux/pci-pwrctrl.h>
 
 #include "pci-host-common.h"
 
@@ -825,6 +826,28 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	if (WARN_ON(!pcie))
 		return -ENOENT;
 
+	// Ensure all ports can be powered on before attempting initialization
+	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
+		ret = pci_pwrctrl_create_device(of_port, pcie->dev);
+		if (ret) {
+			dev_err(pcie->dev, "Failed to create pwrctrl device: %pe\n", ERR_PTR(ret));
+			return ret;
+		}
+
+		ret = pci_pwrctrl_power_on_device(of_port);
+		if (ret) {
+			if (ret != -EPROBE_DEFER) {
+				dev_err(pcie->dev,
+					"Failed to power on device: %pe\n",
+					ERR_PTR(ret));
+				for_each_available_child_of_node_scoped(dev->of_node, of_port) {
+					pci_pwrctrl_destroy_device(of_port);
+				}
+			}
+			return ret;
+		}
+	}
+
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {

-- 
2.56.0

