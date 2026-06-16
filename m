Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D328644E045;
	Tue, 16 Jun 2026 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628057; cv=none; b=Eov08f7e7ojGpUNyJJ9yC7X9xq47Z6HjoOgwNoDy8ifK6egNL2Y6bDcwqJcKrn8AVFwZ6wa/y+0M8HI/y8jCRGU7HDjIYxd1O19dbvjDGOS6noxZMvzjUUZ3nd42SA9DgJuC2j3RHkuCQ0Y0/TdNMH3gUlzK19zFsajLUwxfMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628057; c=relaxed/simple;
	bh=RcK3Px5qUbh8XXlAI6w2igXvbWfy+QWc9ZVLhgeJ98g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qsMGXT4MTJ8ukbJAOvciiIeWRGJp30x4Vqlc0Q26sXctNsJVRKIDVxHh5ns/PE5riL2djjvkwPMgQm9JrnJZymfYLT7lURmxEQ1ZGyIDRGQDtwLR2+DhxiJ6hFjJ+lehSaR96zyIuH+biT2W94aEcpWDvzAEH/dgT2pzIDY6Vrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieeWCPEL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieeWCPEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D521F000E9;
	Tue, 16 Jun 2026 16:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781628056;
	bh=divQ5Yjk3XS3QVueUIZJigdnss2iRrOOpBuotDvoNEM=;
	h=From:To:Cc:Subject:Date;
	b=ieeWCPELtZ5QiwUazDhBrQUiYIomgu1kZFDAkQfaaUMUhElb98WHSpXh5QF+vA2+4
	 0ZIYesWfczx3b97JPCCrDy7JHvOJTi0Qh7AsXIfo2pjSRQy10L4DwtJb5nQ44YICxk
	 mjJ8CuB8MoGUwJa/SWwTkUwwze4Cd1n2uyU/G0JeP5EAwVheVSoTT82GAZzoiEc1zL
	 dQ9o0wbQdBQr6DMDbbyA7n7+oUjO68HW14anrDWbaL26H4TPuDVCXhR9O7P54dXpOf
	 etnJt2yp51m39UIsrhMRuAwd+HBlPeiYvo6DCTObN6NL6xNHofnzTambmmdCc1PP9B
	 9+eWsUdrm3YHg==
From: Arnd Bergmann <arnd@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sherry Sun <sherry.sun@nxp.com>,
	Richard Zhu <hongxing.zhu@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: imx6: fix building against host-common
Date: Tue, 16 Jun 2026 18:39:59 +0200
Message-Id: <20260616164049.3656435-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_PCI_HOST_COMMON is set to =m, the i.MX6 PCIe driver
fails to link. This can happen when only i.MX endpoint mode is
enabled but not host mode, which would indirectly enable the
host-common driver itself.

ld.lld: error: undefined symbol: pci_host_common_parse_ports
>>> referenced by pci-imx6.c
>>>               drivers/pci/controller/dwc/pci-imx6.o:(imx_pcie_host_init) in archive vmlinux.a

ld.lld: error: undefined symbol: pci_host_common_delete_ports
>>> referenced by pci-imx6.c
>>>               drivers/pci/controller/dwc/pci-imx6.o:(imx_pcie_host_init) in archive vmlinux.a
>>> referenced by pci-imx6.c
>>>               drivers/pci/controller/dwc/pci-imx6.o:(imx_pcie_host_init) in archive vmlinux.a

Select the common module from the endpoint support directly.

Fixes: 250eea5c06f5 ("PCI: imx6: Parse 'reset-gpios' in Root Port nodes")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index aa0b784c85b4..7d49027c6736 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -126,6 +126,7 @@ config PCI_IMX6_EP
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
+	select PCI_HOST_COMMON
 	select PCI_IMX6
 	help
 	  Enables support for the PCIe controller in the i.MX SoCs to
-- 
2.39.5

