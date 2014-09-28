Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0123.outbound.protection.outlook.com ([207.46.100.123]:56592
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753525AbaI1Uyp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 28 Sep 2014 16:54:45 -0400
From: <suravee.suthikulpanit@amd.com>
To: <will.deacon@arm.com>, <liviu.dudau@arm.com>,
	<marc.zyngier@arm.com>, <mark.rutland@arm.com>,
	<catalin.marinas@arm.com>, <jason@lakedaemon.net>,
	<tglx@linutronix.de>, <robh+dt@kernel.org>, <bhelgaas@google.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Subject: [RFC 3/4] arm64: Do not call enable PCI resources when specify PCI_PROBE_ONLY
Date: Sun, 28 Sep 2014 15:53:29 -0500
Message-ID: <1411937610-22125-4-git-send-email-suravee.suthikulpanit@amd.com>
In-Reply-To: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

When specify PCI_PROBE_ONLY, the resource parent does not get assigned.
Therefore, pci_enable_resources() return error saying that
"BAR x not claimed".

Note: This same logic is also used in the arch/arm/kernel/bios32.c

Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 arch/arm64/kernel/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index ce5836c..7fd4d2b 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -68,3 +68,11 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 	bus->domain_nr = domain;
 }
 #endif
+
+int pcibios_enable_device(struct pci_dev *dev, int mask)
+{
+	if (pci_has_flag(PCI_PROBE_ONLY))
+		return 0;
+
+	return pci_enable_resources(dev, mask);
+}
-- 
1.9.3

