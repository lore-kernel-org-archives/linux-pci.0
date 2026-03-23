Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCE38B7D2;
	Mon, 23 Mar 2026 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263327; cv=none; b=IpJNLc36J2IORigfDX8r8K3M+9CEYLZmF7FZVzL5qNiEUzTbn7fW0G8DrY8AGUlg6o8oiFG+Wj7krwJfWpDXhCw11XTRKwGcOWqIZFsiIs0JLmxL39+0lwG7Y2by5O9/7AmDgEhnIdVksuDRQk5oT/K0Nfl8RqO5LIcDmrg9Gqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263327; c=relaxed/simple;
	bh=9W56aQ9O2mCnQ68QZ3yP7ENAZ8roACbMFM6v0WstbDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ghu+dAqy9ev+O3nNMmm+gOpquEFSk0kQr9DvjcukttIDuvoUhkbcEIGAO3Mc843XfC9BhpTqx6/2Esl9b5xSbsoMi9OcHhDnqorL69hL8plB7BVHKvSCUlRylPSRIMM6atyXP6gZsvcmGFU34u1NYuv5Ip9X19dEK62+Nu6v2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlmGxLEH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlmGxLEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6015C2BC87;
	Mon, 23 Mar 2026 10:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774263327;
	bh=9W56aQ9O2mCnQ68QZ3yP7ENAZ8roACbMFM6v0WstbDc=;
	h=From:To:Cc:Subject:Date:From;
	b=nlmGxLEHSUrmO6dGX9NfuiTACxpIM89yJRQ5e9uDl9gh/61aw5ZTMKtKe5tLdpk1r
	 i//eTpYRvrJ7TvtTPkYeHT/1C53DUgO/gGmSrMCu4dbtkGNQLRAQViRV0ZkdlxGKM1
	 RezVSBNrU1EaBspJcwxzMGphD+0TptcTQTPtF4oT9weKtiafWU4VfSyqSVF9Bla4Od
	 iMqnv729/J/fXv328InJzqfMdxwXnZSHwoMFmTMpoAtKAQJdqfwsfCCOIsahBA9uIe
	 is4SMMMn/hNGgn7nGu6vRXcXHOHamRb3+lfB4SVTaCj9AAE/N/EjxDprw3tepG/NJi
	 Oz5RVDtd9vcSg==
From: Arnd Bergmann <arnd@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] PCI: mediatek-gen3: select PCI_PWRCTRL_GENERIC correctly
Date: Mon, 23 Mar 2026 11:55:06 +0100
Message-Id: <20260323105520.461640-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The PCI_PWRCTRL_SLOT option was renamed to PCI_PWRCTRL_GENERIC, but a new
user showed up using the old name, which caused a build failure when
both conflicting patches are merged:

aarch64-linux-ld: drivers/pci/controller/pcie-mediatek-gen3.o: in function `mtk_pcie_remove':
pcie-mediatek-gen3.c:(.text+0x137c): undefined reference to `pci_pwrctrl_power_off_devices'

Use the correct symbol as intended originally.

Fixes: ff124bbbca1d ("PCI/pwrctrl: generic: Rename pci-pwrctrl-slot as generic")
Fixes: 073a7e1b7bcc ("PCI: mediatek-gen3: Integrate new pwrctrl API")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/controller/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index e72ac6934379..686349e09cd3 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -222,7 +222,7 @@ config PCIE_MEDIATEK_GEN3
 	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
 	depends on PCI_MSI
 	select IRQ_MSI_LIB
-	select PCI_PWRCTRL_SLOT
+	select PCI_PWRCTRL_GENERIC
 	help
 	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
 	  This PCIe controller is compatible with Gen3, Gen2 and Gen1 speed,
-- 
2.39.5

