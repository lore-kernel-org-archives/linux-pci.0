Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Anders Roxell <anders.roxell@linaro.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] drivers/pci/probe: Move variable bridge inside ifdef
Date: Sat, 21 Jul 2018 23:45:56 +0200
Message-Id: <20180721214556.25651-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When CONFIG_PCI_QUIRKS isn't enabled we get the warning below:
drivers/pci/probe.c: In function ‘pci_bus_read_dev_vendor_id’:
drivers/pci/probe.c:2221:18: warning: unused variable ‘bridge’ [-Wunused-variable]
  struct pci_dev *bridge = bus->self;
                  ^~~~~~

Move the declaration of variable bridge to inside the ifdef
CONFIG_PCI_QUIRKS.

Fixes: ac5ea104a279 ("PCI: Workaround IDT switch ACS Source Validation erratum")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1c581346c5b9..7a5323798312 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2218,9 +2218,9 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 				int timeout)
 {
+#ifdef CONFIG_PCI_QUIRKS
 	struct pci_dev *bridge = bus->self;
 
-#ifdef CONFIG_PCI_QUIRKS
 	/*
 	 * Certain IDT switches have an issue where they improperly trigger
 	 * ACS Source Validation errors on completions for config reads.
-- 
2.18.0
