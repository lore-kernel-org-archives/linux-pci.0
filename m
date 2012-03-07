Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ey0-f202.google.com ([209.85.215.202]:43040 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031691Ab2CGBAe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2012 20:00:34 -0500
Received: by mail-ey0-f202.google.com with SMTP id q10so213220eaa.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Mar 2012 17:00:33 -0800 (PST)
Subject: [PATCH v1 5/9] arm/PCI: don't export pci_flags
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <rob.herring@calxeda.com>
Date: Tue, 06 Mar 2012 18:00:32 -0700
Message-ID: <20120307010032.27465.35675.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307005905.27465.71131.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307005905.27465.71131.stgit@bhelgaas.mtv.corp.google.com>
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

