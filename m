Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B338D3E6;
	Tue, 23 Jun 2026 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236238; cv=none; b=RG0VMbTuMRsE+1B6ewZTrRIpUAer+jkeykXr5dA9Ih12MVhk8TwsBFGrNOHZWQHKTLmJag0GH6O+Dqe6P9qWsMiUukVxCNe2YgexA6e4orsIe0DWuFeoSDSVyanLqtaEkdAJ6etDt6OS768z/Ugjw9sgSTs9RTzGqVaJ6bpsFc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236238; c=relaxed/simple;
	bh=ss1Q8sXYQoUYSrXeYW2PCowfMhu2CARpqrdNcUnmnyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1j3D9Yz2fX8i9UFi9fAwHMHSFKYmEaQ5nj/9ESK09HdpAwq6HmnpTy/kTT7KMy9hEbdF4/PnO74wwGqFaY19H4GMhwhh9Gw+j3YwY3eKY0gx20wCVxCxuSVYT9/JQZH4GTJttkxGcODLLZq8k51z1/uJ47RJJ4GEzQyj4NZiME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=OUkXGCpS; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="OUkXGCpS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1782236233;
	bh=AMUl968WpFSwixHb/PalWiEndr8v+yvVKIjWyIAfyj8=;
	h=From:To:Cc:Subject:Date:From;
	b=OUkXGCpSxSNFUSHl7EsVigdJpSgDcA/f8CkbxDiXq9wmWuOSpMSWbDM5RaJ4wfPfq
	 L3xFS2nZ9O7ixcBlM7NJuaSoJvcVnvsXf89I8QSO6UTzr78nb1u/3x1HlHEKSFARAu
	 +QmCsfle9j0QX86zYIpnt5lX/F9zAtQ0jpkDakTE=
Received: from stargazer (unknown [IPv6:2408:824e:303:c231:c427:8c70:2426:a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D885265B57;
	Tue, 23 Jun 2026 13:37:07 -0400 (EDT)
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
Subject: [PATCH v2] pci: loongson: Avoid L0s on LS7A1000 PCIe x8 [0014:7a29] Root Ports rev2
Date: Wed, 24 Jun 2026 01:36:48 +0800
Message-ID: <20260623173648.222922-1-xry111@xry111.site>
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

Changes from v1: rename the quirk function into a style similar to other
quirk functions in the same file.

 drivers/pci/controller/pci-loongson.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index a4250d7af1bf..235b44859b53 100644
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
+static void loongson_port2_aspm_quirk(struct pci_dev *pdev)
+{
+	if (pdev->revision == 2)
+		pcie_aspm_remove_cap(pdev, PCI_EXP_LNKCAP_ASPM_L0S);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT2,
+			 loongson_port2_aspm_quirk);
+
 static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
 {
 	struct pci_config_window *cfg;
-- 
2.54.0

