Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D93914F5;
	Tue,  9 Jun 2026 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018763; cv=none; b=F16IX4YYK2cod5FnKjrwCbcfBut1K1xKcIiGxUl82lIk62UaTjq5stP6OMVqWZRy6BO4tuvuXUB9uUaqcrn91ub8Wps3cxTVYFF1v7nk0EIi7jtREXeG5Tbjw3vMGTbpG2oz/x2+WuuM0pbpyTGGu068j9npMgkIaBQ2Rl/yR0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018763; c=relaxed/simple;
	bh=APebVWXlW3OuDhk3ME8Ah4Gh4nyN2caUygVMsoneur0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WuJZURMAO2mKhYokthFzQpU5OwBlgI3/TGO9LrXXrLsRdem//ouQLOQz4luoULpNh2BzghEy4d4Hu1E1iftI8a4J7oBhem3Pp/S2/NR5rW/dpx6N01s9Zj1VEP7ImQE9dJLumLvYEEkbCHSjAth9MhEXNTtiH4y+Ncirztn3rhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=DtxmOonY; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="DtxmOonY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1781018755;
	bh=tmJmQOyKn/aHDN6rauzjqMEKyvMKYytGnFOek9M4pm0=;
	h=From:To:Cc:Subject:Date:From;
	b=DtxmOonYxz3HfHnC9dynPXcw2feUs1znUhiadLCDnFLzfcrm+lySwDoBcEV/lusur
	 4SLPoK+BOSXAVO9awg4nob3n8L0pZmCAaMQWq4gkfxVxE7xaNfC4rsCO8vKc6dQlls
	 X/ax14dYkGGD4AUJOsHXjHywXXnLPRYxupZ2v4gc=
Received: from stargazer (unknown [IPv6:2409:8a4c:e12:98c1::376])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 13E6D65982;
	Tue,  9 Jun 2026 11:25:48 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>,
	Mingcong Bai <jeffbai@aosc.io>,
	Henry Chen <chenx97@aosc.io>,
	Han Gao <gaohan@iscas.ac.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] pci: loongson: Avoid L0s on LS7A1000 PCIe x8 [0014:7a29] Root Ports rev2
Date: Tue,  9 Jun 2026 23:25:11 +0800
Message-ID: <20260609152511.753760-1-xry111@xry111.site>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
devicetree platforms") has broke booting of a Loongson 3B4000 + 7A1000
server with an Intel 750 Series SSD.  We also found a Loongson 3A5000
board using the same 7A1000 bridge chip exhibiting the same issue with
pcie_aspm=force and pcie_aspm.policy=powersave (ASPM is not enabled by
default on the 3A5000 board because it's based on ACPI and the _OSC
method has not been implemented in its DSDT/SSDT yet).

This seems only affecting the 7A1000 chips shipping the revision 2 of
the PCIe x8 Root Port: on other two boards with a (persumably older)
LS7A1000 bridge chip utilizing the revision 1 of the root port, the
issue does not reproduce.

Cc: Mingcong Bai <jeffbai@aosc.io>
Cc: Henry Chen <chenx97@aosc.io>
Cc: Han Gao <gaohan@iscas.ac.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/pci/controller/pci-loongson.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index a4250d7af1bf..dc7cee10643e 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -212,6 +212,19 @@ static void loongson_pci_bridge_speed_quirk(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, loongson_pci_bridge_speed_quirk);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, loongson_pci_bridge_speed_quirk);
 
+/*
+ * Some devices, for example Intel 750 Series SSD, experiences data loss
+ * (read timeout) on LS7A1000 PCIe x8 Root Port when ASPM L0s is enabled.
+ * This seems only affecting the revision 2.
+ */
+static void ls7a_pcie_port2_aspm_quirk(struct pci_dev *pdev)
+{
+	if (pdev->revision == 2)
+		pcie_aspm_remove_cap(pdev, PCI_EXP_LNKCAP_ASPM_L0S);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT2,
+			 ls7a_pcie_port2_aspm_quirk);
+
 static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
 {
 	struct pci_config_window *cfg;
-- 
2.54.0

