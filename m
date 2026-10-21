Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574639;
	b=2xg8R1GWbFqbr4NPndV52LWPKffnGckByjtVj7+mKamM8uRV/js3CabRkspZrViWT3UR
	 4Tc7T3D3X9GCPpe0zBx7Q6Tujt3CkNrawidXzNh90PSL+j1n67+JbVr6MErQaF4TsCQ9Y
	 6/MQJnukvKh8L+V969lSmp0fJNuajV1bN/PeAEygPWlt7qi28DElhsjZtrwfARvI+f6W5
	 ZaSSaiazxN9DY9/1fVTZU1E5JQTgNSb8dnvIOuKJYuFNUy5EyBm5nE8bh9jLEZA8bJXzf
	 F9za235tzc3v2xsrVPBIi4ACVkUBfpLIVkznpilKwof4g4D4IOfkP3escVpoqC4x+Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574639;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0gs9XpaSjbr64Ge17Hfl/wQs+RcWCk7dCuZGLLhBeLk=;
	b=wawUcc6jxmHeBV13zH3ACTZ+x7ZWxyK5jol6cJAED66lOIgqEB93VLFifAPjKC91iWkV
	 r0XG/QaDGJclzZTYGtM94z96AG8ep1x9++rIOEeWIQhZTxqeX0ZEOXwj+DdtJ+whfJQDB
	 DcLHSgI3Fwf/keNAD3gi4QtMNDs/BAaeO/PvVWYVG2Q/vuv1y4TO3qPlYzGW5kv/HaoHa
	 BvcKX/MNMfFbQqi7RD/5K8Z2Rnkv0P6VZrzTo5Qdt13ftxgptHdIgYKj8zsaDJvqO2RXG
	 Q+BCcU/44zvVD7xAARWw1mnVzRbakvVJCf6DwQRySEReIdMDTtxdY9cJUr3QMgXpxLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CCA606A319;
	Wed, 21 Oct 2026 09:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D0C1F000C9;
	Wed, 21 Oct 2026 09:23:56 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Elder <elder@riscstar.com>,
	Daniel Thompson <daniel@riscstar.com>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] PCI/pwrctrl/gpio: Correct GPIO_TC9563 / PCI_PWRCTRL_TC9563 dependency
Date: Wed, 21 Oct 2026 11:23:52 +0200
Message-ID: <45484c37512a3102495d8b75b6e9f72a141ba42e.1792574560.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Toshiba TC9563 GPIO controller is embedded in the Toshiba TC9563
PCIe switch, and its auxiliary device is instantiated by the TC9563 PCI
Power Control driver.  Hence make GPIO_TC9563 depend on
PCI_PWRCTRL_TC9563, to prevent asking the user about the GPIO driver
when configuring a kernel without TC9563 PCI Power Control support.

Drop the dependency of PCI_PWRCTRL_TC9563 on GPIO_TC9563, which
represents the inverse and wrong relationship.
Let PCI_PWRCTRL_TC9563 select AUXILIARY_BUS, as this is no longer
guaranteed through GPIO_TC9563.

Fixes: eea9a072221d97ab ("PCI/pwrctrl: tc9563: Add GPIO auxiliary device support")
Fixes: 81ec9c22d06aea92 ("gpio: tc9563: Add support for the embedded GPIO controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Let PCI_PWRCTRL_TC9563 select AUXILIARY_BUS.
---
 drivers/gpio/Kconfig        | 1 +
 drivers/pci/pwrctrl/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 5d3f076c539b3a64..c5556b1638b8c113 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1893,6 +1893,7 @@ endmenu
 
 config GPIO_TC9563
 	tristate "Toshiba TC9563 GPIO support"
+	depends on PCI_PWRCTRL_TC9563 || COMPILE_TEST
 	default m if ARCH_QCOM
 	select AUXILIARY_BUS
 	select GPIO_REGMAP
diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index 38aab596aa04b8b1..a2fc2a359702e861 100644
--- a/drivers/pci/pwrctrl/Kconfig
+++ b/drivers/pci/pwrctrl/Kconfig
@@ -29,7 +29,7 @@ config PCI_PWRCTRL_TC9563
 	select PCI_PWRCTRL
 	default m if ARCH_QCOM
 	depends on I2C
-	depends on GPIO_TC9563
+	select AUXILIARY_BUS
 	select REGMAP_I2C
 	help
 	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe
-- 
2.43.0

