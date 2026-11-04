Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792446;
	b=47CozS2hwxRWGHVb8VBausBzZjbZrguVPQ+HZG3Nl21LXNCawz93WDrjn0FpM3ZpQo0S
	 M6lo7yvpwViJEe2qSle5s1Uwt1ALuBfleMyVKzW6MFhbrTHhbjsiJoLXfcp6GhAgBUWcw
	 0Y2vH8eR4D6dTuph1lAPJunRXHs7o9mq/wl+C+cghnh6g9ALumX4S6hsnAkQ1OcD9j1Fr
	 Gr4v6KyyGmB5w09vmw02cmnvDurupUGK0uG704+iMSoulw/HOeOzJ18gU5/U7bh3HEE3I
	 CffuoRsJ0S/K+PWdgRAodNoOLX6CL2VfN/8Er0mCrT/on2o5m2rXWRq6K+DVcrCUjlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792446;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=GNEkLS7x3xup7k/Ojt7ZkvN366zwwDCNFWsahX9UKfI=;
	b=WwPJt0jT4k6FuThN/FfNSRG1RGxKn5RkHKTa5F6McItyc6ZBeK37BDbn++ZnNkcUnG4l
	 dhm8RNEgNe23tUmbG4OJaUioTMkjBC8XRalxMvPgCF2JCai77Kotl27Lt4+7wbdZMOJot
	 AfKqQ4Wq0XShBO7Z8Y1Q/x0vIgLoRR2THBc0yEcZ9sPJe5HFyZSGQCkUzsL/dqgI4XlQH
	 zStYsJPTYOC2B07KeDoFGJVSQSyBA6ZRRkjjLKuFxKDYVV9irxj+c0Uad+/vChcqqig8j
	 PQ+PfJBsy6mhtS/2GtwPcEMnuRXB3HePrx0ENfLHYfI250VoD67hQo+dHz5W/0iCoHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=yWfisoRE;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59420606A32E;
	Wed,  4 Nov 2026 11:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59420606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=yWfisoRE
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793792439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNEkLS7x3xup7k/Ojt7ZkvN366zwwDCNFWsahX9UKfI=;
	b=yWfisoRENsW64pUOMDbkEuV3yPacTgGGhFKf/9z38WVNVD16MXsFRiolhs5oFqdE/x0vAL
	8GlEAtT85sRsNg2FbSLm02JsYYBSAgv3qzmpey/131p6h20seyO/y/kEiOjwCGUE1n1HRH
	HIN8KtO9OTfcYh0xBgTHl7DpjWqY7Uk=
Date: Wed, 04 Nov 2026 12:40:29 +0100
Subject: [PATCH v2 1/3] PCI/pwrctrl: Export per-device APIs
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
Message-Id: <20261104-apple-pcie-pwren-v2-1-216a4066965f@cyberchaos.dev>
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

Export the `pci_pwrctrl_power_on_device()` and
`pci_pwrctrl_power_off_device()` functions to allow PCIe host drivers
to call manage power control on a per-port basis.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 drivers/pci/pwrctrl/core.c  | 51 ++++++++++++++++++++++++++++++++++++++++-----
 include/linux/pci-pwrctrl.h |  4 ++++
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 0e2387cf4657..b59dbedf251b 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -191,7 +191,16 @@ static int __pci_pwrctrl_power_off_device(struct device *dev)
 	return pwrctrl->power_off(pwrctrl);
 }
 
-static void pci_pwrctrl_power_off_device(struct device_node *np)
+/**
+ * pci_pwrctrl_power_off_device - Power off pwrctrl devices
+ *
+ * @device_node: PCI port or device to operate on
+ *
+ * Recursively traverse all pwrctrl devices for the devicetree hierarchy
+ * below the specified PCI port or device and power them off in a depth
+ * first manner.
+ */
+void pci_pwrctrl_power_off_device(struct device_node *np)
 {
 	struct platform_device *pdev;
 	int ret;
@@ -216,6 +225,7 @@ static void pci_pwrctrl_power_off_device(struct device_node *np)
 
 	platform_device_put(pdev);
 }
+EXPORT_SYMBOL_GPL(pci_pwrctrl_power_off_device);
 
 /**
  * pci_pwrctrl_power_off_devices - Power off pwrctrl devices
@@ -245,11 +255,21 @@ static int __pci_pwrctrl_power_on_device(struct device *dev)
 	return pwrctrl->power_on(pwrctrl);
 }
 
-/*
+/**
+ * pci_pwrctrl_power_on_device - Power on pwrctrl devices
+ *
+ * @device_node: PCI port or device to operate on
+ *
  * Power on the devices in a depth first manner. Before powering on the device,
  * make sure its driver is bound.
+ * Recursively traverse all pwrctrl devices for the devicetree hierarchy
+ * below the specified PCI port or device and power them on in a depth
+ * first manner.  Before powering on the device, make sure its driver is bound.
+ *
+ * Return: 0 on success, -EPROBE_DEFER if any pwrctrl driver is not bound, an
+ * appropriate error code otherwise.
  */
-static int pci_pwrctrl_power_on_device(struct device_node *np)
+int pci_pwrctrl_power_on_device(struct device_node *np)
 {
 	struct platform_device *pdev;
 	struct device_node *child;
@@ -296,6 +316,7 @@ static int pci_pwrctrl_power_on_device(struct device_node *np)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_device);
 
 /**
  * pci_pwrctrl_power_on_devices - Power on pwrctrl devices
@@ -335,7 +356,17 @@ int pci_pwrctrl_power_on_devices(struct device *parent)
 }
 EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
 
-static int pci_pwrctrl_create_device(struct device_node *np,
+/**
+ * pci_pwrctrl_create_device - Create pwrctrl devices
+ *
+ * @device_node: PCI port or device to operate on
+ *
+ * Recursively create pwrctrl devices for the devicetree hierarchy below
+ * the specified PCI port or device in a depth first manner.
+ *
+ * Return: 0 on success, negative error number on error.
+ */
+int pci_pwrctrl_create_device(struct device_node *np,
 				     struct device *parent)
 {
 	struct platform_device *pdev;
@@ -368,6 +399,7 @@ static int pci_pwrctrl_create_device(struct device_node *np,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_pwrctrl_create_device);
 
 /**
  * pci_pwrctrl_create_devices - Create pwrctrl devices
@@ -396,7 +428,15 @@ int pci_pwrctrl_create_devices(struct device *parent)
 }
 EXPORT_SYMBOL_GPL(pci_pwrctrl_create_devices);
 
-static void pci_pwrctrl_destroy_device(struct device_node *np)
+/**
+ * pci_pwrctrl_destroy_device - Destroy pwrctrl devices
+ *
+ * @device_node: PCI port or device to operate on
+ *
+ * Recursively destroy pwrctrl devices for the devicetree hierarchy below
+ * the specified PCI port or device in a depth first manner.
+ */
+void pci_pwrctrl_destroy_device(struct device_node *np)
 {
 	struct platform_device *pdev;
 
@@ -415,6 +455,7 @@ static void pci_pwrctrl_destroy_device(struct device_node *np)
 
 	of_node_clear_flag(np, OF_POPULATED);
 }
+EXPORT_SYMBOL_GPL(pci_pwrctrl_destroy_device);
 
 /**
  * pci_pwrctrl_destroy_devices - Destroy pwrctrl devices
diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
index 1192a2527521..f27be6489b50 100644
--- a/include/linux/pci-pwrctrl.h
+++ b/include/linux/pci-pwrctrl.h
@@ -59,6 +59,10 @@ int pci_pwrctrl_create_devices(struct device *parent);
 void pci_pwrctrl_destroy_devices(struct device *parent);
 int pci_pwrctrl_power_on_devices(struct device *parent);
 void pci_pwrctrl_power_off_devices(struct device *parent);
+int pci_pwrctrl_create_device(struct device_node *np, struct device *parent);
+void pci_pwrctrl_destroy_device(struct device_node *np);
+int pci_pwrctrl_power_on_device(struct device_node *np);
+void pci_pwrctrl_power_off_device(struct device_node *np);
 #else
 static inline int pci_pwrctrl_create_devices(struct device *parent) { return 0; }
 static void pci_pwrctrl_destroy_devices(struct device *parent) { }

-- 
2.56.0

