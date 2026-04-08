Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9B13D47AC;
	Wed,  8 Apr 2026 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671064; cv=pass; b=cRn5uxZgoals8A6am08ACnhtbeAjzyGkuZYHr+QB68EK/QeN+7IEteLcZzrDNJSvAU1HZoUipH2bFCHrGD14rgz2cVZOwWqVIw+IANpb1214lx+Xbtcih8Jitu8q2jVpg7Xs2A1Fm+KJqNBLBQk0kPAjRuZIkIxk+7M/MvqCRGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671064; c=relaxed/simple;
	bh=EmPpMYylqfg+DgyC52WoNLJTF7BDDgSSmGdithsFnpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4O8TzYjgPnwAeuZoDNBxMTGl1LKchd6Zo4ZKJml4d6KT/ZiijUPZWvfngCpu9hJV/1yXoxgbysF0pIdZ1yTwhZgTiAo17gUQl7SLiPixfmTMOL0eVf9V4S3KA7As2O9+ftPEVvYaJqDUiBZZ4AxkAgTssZzPf2x3uvRxfSvp7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=FBe2kZ9R; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="FBe2kZ9R"
ARC-Seal: i=1; a=rsa-sha256; t=1775671043; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I9LOUI6BZwMDLVKH9X/e4I7WTN94gmXQTrKzEMhqQC6dhXZZbWaSuQsRCt+sFMIIV/pWSb2G5wMWRMuwVqKB4k2FvUhu/zv7t4PQ0MLqNT6BEFSXa1yEJ7jPqv/6oOtBLWGbZrzg10rNBTgFE7JyXJpwhUoTk4gMvKDgItYpz28=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775671043; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6MyuPLfEw4cUfhZONOuruooW8MLfZecPIIFNtqPD4Lk=; 
	b=m7/fnqP9ze3AFZbuHGw3CnKCr+yvu7xh7K2gQyjloiYrSkI+uh9sYDthoBBgcEZPgRy1NQ8E7/om5+k8N0Gas6vtG4YHgRD6JAOarnu6iyMtnRtCO7I1Bnineey6NzgL8jAoJY1I0Z+rXzxaTDCqwgR/nQrGRVB2RqlQuO1UVpE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775671043;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=6MyuPLfEw4cUfhZONOuruooW8MLfZecPIIFNtqPD4Lk=;
	b=FBe2kZ9RO9Cvput/F01YvvQAr/yQmpxuyyKmcxIohTkUDCvxJJAjDFYQYpQcvry4
	ojHqQYXQsUJP5E1FxWiEaupjFtlqRIyXUXYfdqjdfHP0GzAifEQMIQpXiwBD6V9RY1a
	JhiT9yFEbfP2g/oh9C/al97ctuSLOQB6t2xDfuORMYOPlrGx3uh183L9VxFz1ngw3Kg
	KF8qF5TorapMWKzHk5/D8ER9DxJ6WSpafoPUtgBU5LIL3MjfVaFiJV/bcBylufsW4lf
	9gbVXAxGORlqVKwJN72kY638S5mdZFwWIQx7OmUJ6dmoE+uOkKENXLgNvq8Z/IVjQ35
	LA+raWiHWw==
Received: by mx.zohomail.com with SMTPS id 1775671041919155.67752107933018;
	Wed, 8 Apr 2026 10:57:21 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Thu, 09 Apr 2026 01:56:57 +0800
Subject: [PATCH 1/2] PCI: loongson: Move bridge device ids to file scope
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-ls7a-bridge-fixes-v1-1-3650fedf1afc@rong.moe>
References: <20260409-ls7a-bridge-fixes-v1-0-3650fedf1afc@rong.moe>
In-Reply-To: <20260409-ls7a-bridge-fixes-v1-0-3650fedf1afc@rong.moe>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Huacai Chen <chenhuacai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 "Lain \"Fearyncess\" Yang" <i@lain.vg>, Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-7777e
X-ZohoMailClient: External

There is a pci_device_id array for the internal bridges of Loongson PCI
host controllers declared inside loongson_set_min_mrrs_quirk().

Move it to the file scope so that it can be used by other functions.

Fixes: 2410e3301fcc ("PCI: loongson: Don't access non-existent devices")
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Co-developed-by: Lain "Fearyncess" Yang <i@lain.vg>
Signed-off-by: Lain "Fearyncess" Yang <i@lain.vg>
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/pci/controller/pci-loongson.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index bc630ab8a283..8b1a3a03dc51 100644
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

-- 
2.53.0

