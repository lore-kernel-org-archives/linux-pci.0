Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-fa0-f74.google.com ([209.85.161.74]:51086 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946304Ab2CPXsF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Mar 2012 19:48:05 -0400
Received: by mail-fa0-f74.google.com with SMTP id a19so214757faa.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Mar 2012 16:48:05 -0700 (PDT)
Subject: [PATCH v2 2/7] arm/PCI: don't export pci_flags
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <rob.herring@calxeda.com>
Date: Fri, 16 Mar 2012 17:48:04 -0600
Message-ID: <20120316234804.6649.3554.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
References: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There's no need to export pci_flags; it's not exported by any other
architecture, and no modules reference it.

CC: Rob Herring <rob.herring@calxeda.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm/kernel/bios32.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index be5d3b2..632df9a 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -498,7 +498,6 @@ void __init pci_common_init(struct hw_pci *hw)
 		pci_bus_add_devices(bus);
 	}
 }
-EXPORT_SYMBOL(pci_flags);
 
 #ifndef CONFIG_PCI_HOST_ITE8152
 void pcibios_set_master(struct pci_dev *dev)

