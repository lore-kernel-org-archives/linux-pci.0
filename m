Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:55531 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752864AbdJKWfJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2017 18:35:09 -0400
From: Jim Quinlan <jim2101024@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH 9/9] MIPS: BMIPS: enable PCI
Date: Wed, 11 Oct 2017 18:34:29 -0400
Message-Id: <1507761269-7017-10-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds the Kconfig hooks to enable the Broadcom STB PCIe root complex
driver for Broadcom MIPS systems.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cb7fcc4..83ba54d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -209,6 +209,9 @@ config BMIPS_GENERIC
 	select BOOT_RAW
 	select NO_EXCEPT_FILL
 	select USE_OF
+	select HW_HAS_PCI
+	select PCI_DRIVERS_GENERIC
+	select PCI
 	select CEVT_R4K
 	select CSRC_R4K
 	select SYNC_R4K
-- 
1.9.0.138.g2de3478
