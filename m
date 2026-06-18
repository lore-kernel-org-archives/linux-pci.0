Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A875D2652A2;
	Thu, 18 Jun 2026 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781793395; cv=none; b=GXlcCgP3e0q3caPpekoOSAK7UDwop6phNLiT5YC7YN0HkQYZbeFHUuSfFy92rNFVg9IkgI4WY8nJmpHK5CWEj98yztgNdX4fetJfO9xW1kusYainy6zOnTF3E6TjpFPKlvKkcGGrOdE9mJJyRsSV8NZOof3TKvCLhXTGJT3ddGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781793395; c=relaxed/simple;
	bh=+O9+fOuqCFTjFPdpS7z34J3X50T8IRqsa3UVaNqbAMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gu1XBcDC/5HMQvImm6PU1RKapVoYVOndl0/JAGbBcDI1/BTa7GxkcCBca1NwYKCK+FfsxRPbd4r+uAEuyTSUDRP9X1vCgdsYFPlxcV8mjkWP5nfjzRUA5/a3VP/w0xrBiFI2/2n2VHoWn/2CwGXzL40Y4r5wfIt4GMoGAGix5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf+Fl2vb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf+Fl2vb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754A31F000E9;
	Thu, 18 Jun 2026 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781793394;
	bh=eAZfrMvcD4U9ojf4nItgldaBGbFTOlmo9rwT5jUC+M0=;
	h=From:To:Cc:Subject:Date;
	b=mf+Fl2vbv3vuTdLltvcom6WjakA7ei4X8xfZpkwR/KVNBeTG4itB3M5E/MEEm/ASH
	 SbsndSLbOg7OlIJSDapr/MUWmWCYsfcJnuA+vszOyuRcw1557aM+4icBQkPBfR9Wpg
	 XDRvqoldVLGU9MeV6dhRobHAe3G7LVJSeRunn0A8tTxSPxdoc4XLs/PnexAd6usNl5
	 SSokb780DDU5/R1NHWx303SQ67JJRjSsejDRnmEbqrUjrlnmrJulCxU20vTDKWA3zp
	 Fjl0hWKwJlbuOME5TKUed11mhPk7qTBz6hUmMnNziCRhzLLdWKeV1+6t3OkR2P6zcz
	 yZLO0bVWY829A==
From: Arnd Bergmann <arnd@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: imx6: fix building against pwrctrl
Date: Thu, 18 Jun 2026 16:36:08 +0200
Message-Id: <20260618143629.2035247-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When endpoint mode is built-in, but pwrctrl support is in a loadable
module, the imx driver fails to build because the unused host
support still tries to link against pwrctrl:

ld.lld: error: undefined symbol: pci_pwrctrl_power_off_devices
>>> referenced by pci-imx6.c:1988 (drivers/pci/controller/dwc/pci-imx6.c:1988)
>>>               drivers/pci/controller/dwc/pci-imx6.o:(imx_pcie_shutdown) in archive vmlinux.a

Add one more select for this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
There is already another fix pending that I sent earlier, see
https://lore.kernel.org/all/ajF_LyjOnINAHvA3@lizhi-Precision-Tower-5810/

If you prefer a combined patch, I can send an updated version,
or you can just fold the two into one commit when applying.
---
 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 7d49027c6736..49a7a2c50ca1 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -128,6 +128,7 @@ config PCI_IMX6_EP
 	select PCIE_DW_EP
 	select PCI_HOST_COMMON
 	select PCI_IMX6
+	select PCI_PWRCTRL_GENERIC
 	help
 	  Enables support for the PCIe controller in the i.MX SoCs to
 	  work in endpoint mode. The PCI controller on i.MX is based
-- 
2.39.5

