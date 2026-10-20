Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508630;
	b=5DnzmxBPzXjxlxcirCyRRoadluvZoNzCSts5FElB/OFLcZ7VJbjBrRJGqodg0c+V3EwW
	 FRo7RiUaMFZi+RY+d6g8JGEZre7lEvtDMlKitOFv+oyIhqMa1purfRvLXnLaY6MUUuId2
	 i5LF6tyTWSPf2VbMBAj9RHGoT3jksSr9bzX8Tjr0upND+mzGDEpBwVaUMDSVZizomU5bW
	 21YNzmMFPIuNm8yOJryuPYo65iO285oZYY3Qn+qtY4eAzreURRchA3hAXtb7IHYNY5e3/
	 exfYz284BpA7yvoR8NSk0iG7Duk2uMNWPpkliYXC0yb+QH++UXKpRSrT8dXU+D7KZAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508630;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mcbwaUznvRJWGxydyN5Beg+hTVM53BjHAUaauOO2UaY=;
	b=g2bEYwQO8LuezUQr7Medq6Qh7bP9VhJNWBCMGnLcYuiwg5d1aInHUwCrthft00uJSRa9
	 N20zVAeZ2hScRFnOmF5Ql+TGaU/B2JW8advR1cmYJ+PJutK52koiVx9fEucZVAVz9P+9w
	 u4biNW4wW4p+8va7cVNK8wP17K0Hc1yso4RyVGIZqgf38rQQ++s2fcIqJ8hVGOAq75o64
	 RijIudKPtOkDiSM2HrUjtmGfqSRU1g7DayFU9lioJ3DB4Ce+dHa1kuUZtwwdVsLM5QbLI
	 nO43WDwoxJv800r58mZAAhnizQva737TilAX/bfFDhcAoFFmiCbAqY5Gc2lVw7EGRBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8727606A31A;
	Tue, 20 Oct 2026 15:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31FD1F000C5;
	Tue, 20 Oct 2026 15:03:46 +0000 (UTC)
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
Subject: [PATCH] PCI/pwrctrl/gpio: Correct GPIO_TC9563 / PCI_PWRCTRL_TC9563 dependency
Date: Tue, 20 Oct 2026 17:03:42 +0200
Message-ID: <889ae6695b19ce57ca4b17526c69b48c9414f5ae.1792508601.git.geert+renesas@glider.be>
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
represents the wrong inverse relationship.

Fixes: eea9a072221d97ab ("PCI/pwrctrl: tc9563: Add GPIO auxiliary device support")
Fixes: 81ec9c22d06aea92 ("gpio: tc9563: Add support for the embedded GPIO controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/Kconfig        | 1 +
 drivers/pci/pwrctrl/Kconfig | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

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
index 38aab596aa04b8b1..1952ab4f29b6917a 100644
--- a/drivers/pci/pwrctrl/Kconfig
+++ b/drivers/pci/pwrctrl/Kconfig
@@ -29,7 +29,6 @@ config PCI_PWRCTRL_TC9563
 	select PCI_PWRCTRL
 	default m if ARCH_QCOM
 	depends on I2C
-	depends on GPIO_TC9563
 	select REGMAP_I2C
 	help
 	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe
-- 
2.43.0

