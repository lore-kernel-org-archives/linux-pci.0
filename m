Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36914 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934007AbbLPPSA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2015 10:18:00 -0500
Received: by mail-wm0-f44.google.com with SMTP id p187so5611613wmp.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Dec 2015 07:18:00 -0800 (PST)
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V2 11/23] arm64, pci: Remove useless boot time IRQ assignment when booting with DT.
Date: Wed, 16 Dec 2015 16:16:21 +0100
Message-Id: <1450278993-12664-12-git-send-email-tn@semihalf.com>
In-Reply-To: <1450278993-12664-1-git-send-email-tn@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In order to probe PCIe host controller when booting with DT,
ARM64 is using drivers which defer IRQ assignment to device
enable time. It means that boot time DT specific irq map initialization
is always overridden, so lets remove that code.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/arm64/kernel/pci.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 023b983..f7948f5 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -51,16 +51,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
-/*
- * Try to assign the IRQ number from DT when adding a new device
- */
-int pcibios_add_device(struct pci_dev *dev)
-{
-	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
-
-	return 0;
-}
-
 #ifdef CONFIG_ACPI
 /* Root bridge scanning */
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-- 
1.9.1

