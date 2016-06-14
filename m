Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:36165 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbcFNTUo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Jun 2016 15:20:44 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <jespern@axis.com>,
	Niklas Cassel <niklass@axis.com>
Subject: [PATCH] PCI: artpec: correct section mismatch for function artpec6_pcie_probe
Date: Tue, 14 Jun 2016 21:20:23 +0200
Message-ID: <1465932023-10606-1-git-send-email-niklass@axis.com>
In-Reply-To: <201606141525.f3Gs5A4F%fengguang.wu@intel.com>
References: <201606141525.f3Gs5A4F%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Niklas Cassel <niklas.cassel@axis.com>

WARNING: drivers/pci/host/built-in.o(.data+0xb00): Section mismatch in reference from the variable artpec6_pcie_driver to the function .init.text:artpec6_pcie_probe()

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
Reported by kbuild test robot.
I converted to using module_platform_driver macro in
v2 of this series, unfortunately I missed the
section mismatch warning.
Feel free to fold this into the original patch.

 drivers/pci/host/pcie-artpec6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index 19adc77..be54fad 100644
--- a/drivers/pci/host/pcie-artpec6.c
+++ b/drivers/pci/host/pcie-artpec6.c
@@ -223,7 +223,7 @@ static int __init artpec6_add_pcie_port(struct pcie_port *pp,
 	return 0;
 }
 
-static int __init artpec6_pcie_probe(struct platform_device *pdev)
+static int artpec6_pcie_probe(struct platform_device *pdev)
 {
 	struct artpec6_pcie *artpec6_pcie;
 	struct pcie_port *pp;
-- 
2.1.4

