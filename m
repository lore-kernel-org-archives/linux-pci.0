Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630A435AB2;
	Mon,  6 Jul 2026 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377528; cv=none; b=i6slvDhy+94eokeNYi1cQFGFJ3Bs/fc6p2noeB+fH7702bJC80p5Gd7+ps6kzF4v+XU83dilyNmddAf7Uuf89VyCTenMPj+kWrrkysgj4VTPmYkrIKfwpwZeH5m/etOZQr0ipGzW8/k3/WLrV7c+DplKA6O3Gn3p+5pbmv3E1oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377528; c=relaxed/simple;
	bh=Pq7FM/7dT0sdoENBJTeDdi2ZZrR4z30evW5se4bYris=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlOMYTSMt/CLueU9/obu5tCPVt3Y4TrOT7YPQMefvvklQ6cYWdjcUpCE/ovkMpTEk5BGn3ElG50jIKaE9HglcAzSVGoYYD6vyxFIvxvQbAKG82O3pXyW8oGWCma9SdpFc2Mc8hVKbhvIaXDzc7ChDbGy3OPN1PlPb+XwkDmtmBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=v8aRUQ1s; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="v8aRUQ1s"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1783377519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3rFa0sUM2ZNZURgg7xmwQHAayX2Vx/lL2j0bys8ap8A=;
	b=v8aRUQ1siz7ifJ0JC1a+8OAQOU0AOT6dLhlF6kFKzp6NsIO709o9CYYkOy0X/T4INHI6y5
	Q7XqWjadaAIiyafY+MlsfKRoYe7qVEE57z9ItINet26/a/C+EZROUwunXQrNqh41AyGsnH
	81jl9t/JqVUsU2qXKTeHms+Ff818WiU=
Date: Tue, 07 Jul 2026 00:38:27 +0200
Subject: [PATCH 1/2] PCI: apple: Integrate pwrctrl API
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-apple-pcie-pwren-v1-1-5a281b182fe2@cyberchaos.dev>
References: <20260707-apple-pcie-pwren-v1-0-5a281b182fe2@cyberchaos.dev>
In-Reply-To: <20260707-apple-pcie-pwren-v1-0-5a281b182fe2@cyberchaos.dev>
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

Integrate the PCI pwrctrl framework into the Apple PCIe host driver to
provide standardized power management for PCI devices.

Notably, this allows enabling powering on the WiFi, SD card reader on
various Macs by means of the pwrctrl framework before probing the ports.

Previously, a custom solution for powering on the WiFi and SD card
reader was proposed[1], but we can now use the new pci-pwrctrl-generic
driver for this purpose.

Link[1]: https://lore.kernel.org/lkml/20220502093832.32778-4-marcan@marcan.st/

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 drivers/pci/controller/Kconfig      |  1 +
 drivers/pci/controller/pcie-apple.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 2247709ef6d6..af64630d28fa 100644
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
index c2cffc0659f4..db038a9d4831 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -30,6 +30,7 @@
 #include <linux/msi.h>
 #include <linux/of_irq.h>
 #include <linux/pci-ecam.h>
+#include <linux/pci-pwrctrl.h>
 
 #include "pci-host-common.h"
 
@@ -825,6 +826,21 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	if (WARN_ON(!pcie))
 		return -ENOENT;
 
+	ret = pci_pwrctrl_create_devices(pcie->dev);
+	if (ret) {
+		dev_err(pcie->dev, "Failed to create pwrctrl devices: %pe\n", ret);
+		return ret;
+	}
+
+	ret = pci_pwrctrl_power_on_devices(pcie->dev);
+	if (ret) {
+		if (ret != -EPROBE_DEFER) {
+			dev_err(pcie->dev, "Failed to power on devices: %pe\n", ret);
+			pci_pwrctrl_destroy_devices(pcie->dev);
+		}
+		return ret;
+	}
+
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {

-- 
2.54.0

