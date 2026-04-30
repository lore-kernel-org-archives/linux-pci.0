Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD2E28030E;
	Thu, 30 Apr 2026 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574757; cv=pass; b=S1KKC85KmC5SrK+9KHXTsEmgMUuxFz2IJzte0dAaSivDyvHR85+G1hMkpHkYpiVC06bLgtqX15P9PzkNyzD5P7q8ymh7S4AoX33tEqMJmAM9THvIOkwo2vocTPKJPjOcNGvhZ/hVADd+D3q2AJN+11KYXZn9Yqr2JICyOIcFKB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574757; c=relaxed/simple;
	bh=FPpVVe+m+q36Kjv0eDC5VirL8YxY+kryP06SAzR123Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fatNsnQFCkgGVOB1FqIkUOc0kYr9L/ku/E/1sP3Paf/fRtD8vUtmKEBubITRkZvAiNALFgvLW5g81g4fTN+j+Qj5u7FjFJntmtfj1EZAZo84wY741d5+JjIwtTIELFPvJ+LMY5Tu5B0eYgKQXuDxjD3BsBZ5VKK8qfLcHEaWU4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=Tg69EmOI; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="Tg69EmOI"
ARC-Seal: i=1; a=rsa-sha256; t=1777574736; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bARqjw6y9ZzRH+weM4zD+od67bHG5EjI1lLjk1ZPrj9RJ+o00U4F1dMXFBm73Rmr7rH+tQBpfp4miFwTLThFrSUqmtH6vtVRzm2mpq5tVdBHcA7HxTVr6nDsmixUtM1ZIsyx3i9aOd5F9xE/AMv6LIbC+HHKgkdpXyxAK83psqo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777574736; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qhcUzWz+e0eHqHXsaKs+FfS0uIQ3j8wCK538/jEKh44=; 
	b=QQmh7wdMGZFXPYJSuL2vsqhDwJX3558b0zbJ3ii663DAA6VoxMyRnbX7GJDoB17Qe88E9TBZaSF1aKx63tQg2qbbnR8U2Us+06d0qwvgcaa2Kb0W6MvgzY1dU+VqD4HBXXXJUMqZQtqcUahUD0f24ClBZs5SnuIJAa1AUvoauYI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777574736;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=qhcUzWz+e0eHqHXsaKs+FfS0uIQ3j8wCK538/jEKh44=;
	b=Tg69EmOIcZR+jtONoO8C1q7jrxMY+8LLXBC//b6w/D0jipOxqkOlUUXYFvSzk1nK
	1Z0hRyVV8ZHVpwL9hNGg8I3fcK54EPX/08OMxsGB/XS23OiE0wbucZV6/0dH01h43jy
	2t16kM+2RdqE9sxJ2Z5FSX9fDsTnc+8ba42NurplT7VjhtQNKgcC2/h4LwAFpS4gjgv
	4uPseNJjWawzFJPPvZcf4eEcPrV/3Sa9JYMxfee6cb6c+4H0lYBWLt7HRM6+7bnUU9K
	PBYBVEN/5jYZF4zvGvGNTnUwIwbjy4yI8J3RcON9R0OC5Q8llwe9OC0ZBy+ELvCISyY
	voKJP+lbHg==
Received: by mx.zohomail.com with SMTPS id 1777574734960836.5917068452161;
	Thu, 30 Apr 2026 11:45:34 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Fri, 01 May 2026 02:45:23 +0800
Subject: [PATCH v2] PCI: loongson: Do not ignore downstream devices on
 external bridges
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ls7a-bridge-fixes-v2-1-69fa93683805@rong.moe>
X-B4-Tracking: v=1; b=H4sIAEOj82kC/22NwQ6CMBBEf4Xs2ZpSoYIn/8NwaMsW1ig1XSQaw
 r9bMN48vszMmxkYIyHDKZsh4kRMYUigdhm43gwdCmoTg5JKy0JW4sZHI2ykNkWeXsiiMrUtC6O
 tVg7S7hFxC9Ls0nyZn/aKblxFa6MnHkN8b6dTvvZ+/vqPf8qFFAddSo+tz4135xiGbn8PCM2yL
 B8EFxLDwwAAAA==
X-Change-ID: 20260408-ls7a-bridge-fixes-8a9b54a6b62c
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Huacai Chen <chenhuacai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 "Lain \"Fearyncess\" Yang" <i@lain.vg>, Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-7777e
X-ZohoMailClient: External

Loongson PCI host controllers have a hardware quirk that requires
software to ignore downstream devices with device number > 0 on the
internal bridges. The current implementation applies the workaround to
all non-root buses, which breaks external bridges (e.g., PCIe switches)
with multiple downstream devices.

Fix it by only applying the workaround to internal bridges.

Tested on Loongson-LS3A4000-7A1000-NUC-SE, using AMD Promontory 21
chipset add-in card [1].

  $ lspci -tnnnvvv
  -[0000:00]-+-00.0  Loongson Technology LLC 7A1000 Chipset Hyper Transport Bridge Controller [0014:7a00]
             +-00.1  Loongson Technology LLC 7A2000 Chipset Hyper Transport Bridge Controller [0014:7a10]
             +-03.0  Loongson Technology LLC 2K1000/2000 / 7A1000 Chipset Gigabit Ethernet Controller [0014:7a03]
             +-04.0  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset USB OHCI Controller [0014:7a24]
             +-04.1  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset USB EHCI Controller [0014:7a14]
             +-05.0  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset USB OHCI Controller [0014:7a24]
             +-05.1  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset USB EHCI Controller [0014:7a14]
             +-06.0  Loongson Technology LLC 7A1000 Chipset Vivante GC1000 GPU [0014:7a15]
             +-06.1  Loongson Technology LLC 2K1000 / 7A1000 Chipset Display Controller [0014:7a06]
             +-07.0  Loongson Technology LLC 2K1000/2000/3000 / 3B6000M / 7A1000/2000 Chipset HD Audio Controller [0014:7a07]
             +-08.0  Loongson Technology LLC 2K1000 / 7A1000 Chipset 3Gb/s SATA AHCI Controller [0014:7a08]
             +-08.1  Loongson Technology LLC 2K1000 / 7A1000 Chipset 3Gb/s SATA AHCI Controller [0014:7a08]
             +-08.2  Loongson Technology LLC 2K1000 / 7A1000 Chipset 3Gb/s SATA AHCI Controller [0014:7a08]
             +-09.0-[01]----00.0  Qualcomm Technologies, Inc QCNFA765 Wireless Network Adapter [17cb:1103]
             +-0a.0-[02]----00.0  Etron Technology, Inc. EJ188/EJ198 USB 3.0 Host Controller [1b6f:7052]
             +-0f.0-[03-08]----00.0-[04-08]--+-00.0-[05]----00.0  Shenzhen Longsys Electronics Co., Ltd. FORESEE XP1000 / Lexar Professional CFexpress Type B Gold series, NM620 PCIe NVME SSD (DRAM-less) [1d97:5216]
             |                               +-08.0-[06]----00.0  MAXIO Technology (Hangzhou) Ltd. NVMe SSD Controller MAP1202 (DRAM-less) [1e4b:1202]
             |                               +-0c.0-[07]----00.0  Advanced Micro Devices, Inc. [AMD] 600 Series Chipset USB 3.2 Controller [1022:43f7]
             |                               \-0d.0-[08]----00.0  Advanced Micro Devices, Inc. [AMD] 600 Series Chipset SATA Controller [1022:43f6]
             \-16.0  Loongson Technology LLC 7A1000 Chipset SPI Controller [0014:7a0b]

Fixes: 2410e3301fcc ("PCI: loongson: Don't access non-existent devices")
Link: https://oshwhub.com/wesd/b650 [1]
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Co-developed-by: Lain "Fearyncess" Yang <i@lain.vg>
Signed-off-by: Lain "Fearyncess" Yang <i@lain.vg>
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v2:
- Squash into a single patch to prevent temporary build regressions,
  i.e., unused variable on non-MIPS builds (found by Sashiko)
  - https://sashiko.dev/#/patchset/20260409-ls7a-bridge-fixes-v1-0-3650fedf1afc%40rong.moe
- Link to v1: https://patch.msgid.link/20260409-ls7a-bridge-fixes-v1-0-3650fedf1afc@rong.moe
---
 drivers/pci/controller/pci-loongson.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index bc630ab8a283..de5e809a537d 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -80,6 +80,18 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_LPC, system_bus_quirk);
 
+static const struct pci_device_id loongson_internal_bridge_devids[] = {
+	{ PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
+	{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
+	{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
+	{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
+	{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
+	{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
+	{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
+	{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
+	{ 0, },
+};
+
 /*
  * Some Loongson PCIe ports have hardware limitations on their Maximum Read
  * Request Size. They can't handle anything larger than this.  Sane
@@ -92,24 +104,13 @@ static void loongson_set_min_mrrs_quirk(struct pci_dev *pdev)
 {
 	struct pci_bus *bus = pdev->bus;
 	struct pci_dev *bridge;
-	static const struct pci_device_id bridge_devids[] = {
-		{ PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
-		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
-		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
-		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
-		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
-		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
-		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
-		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
-		{ 0, },
-	};
 
 	/* look for the matching bridge */
 	while (!pci_is_root_bus(bus)) {
 		bridge = bus->self;
 		bus = bus->parent;
 
-		if (pci_match_id(bridge_devids, bridge)) {
+		if (pci_match_id(loongson_internal_bridge_devids, bridge)) {
 			if (pcie_get_readrq(pdev) > 256) {
 				pci_info(pdev, "limiting MRRS to 256\n");
 				pcie_set_readrq(pdev, 256);
@@ -230,11 +231,11 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
 	struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
 
 	/*
-	 * Do not read more than one device on the bus other than
-	 * the host bus.
+	 * Do not read more than one device on the internal bridges.
 	 */
 	if ((priv->data->flags & FLAG_DEV_FIX) && bus->self) {
-		if (!pci_is_root_bus(bus) && (device > 0))
+		if (!pci_is_root_bus(bus) && (device > 0) &&
+		    pci_match_id(loongson_internal_bridge_devids, bus->self))
 			return NULL;
 	}
 

---
base-commit: 08d0d3466664000ba0670e0ef0d447f23459e0d4
change-id: 20260408-ls7a-bridge-fixes-8a9b54a6b62c

Thanks,
Rong

