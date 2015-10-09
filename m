Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:57701 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752443AbbJIQ6F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 12:58:05 -0400
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	device-tree <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] PCI: Add quirk for PLDA's XpressRICH3 host bridge class.
Date: Fri,  9 Oct 2015 17:57:26 +0100
Message-Id: <1444409849-5685-3-git-send-email-Liviu.Dudau@arm.com>
In-Reply-To: <1444409849-5685-1-git-send-email-Liviu.Dudau@arm.com>
References: <1444409849-5685-1-git-send-email-Liviu.Dudau@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The XpressRICH3 host bridge at power up has an unassigned class on
some of ARM Ltd boards, add a quirk to correct that.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/pci/quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b03373f..ae24bb4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4149,3 +4149,13 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 	}
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
+
+/*
+ * The PLDA's XpressRICH3 doesn't describe itself as a bridge. This is required
+ * for correct/normal enumeration.
+ */
+static void xr3pci_quirk_class(struct pci_dev *pdev)
+{
+	pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PLDA, PCI_DEVICE_ID_XR3PCI, xr3pci_quirk_class);
-- 
2.6.0

