Return-Path: <linux-kernel-owner@vger.kernel.org>
To: linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] pci: add function stub for
 pci_get_domain_bus_and_slot()
Message-ID: <80e3c9bb-fb65-4d87-76f9-db7c1273cef3@infradead.org>
Date: Tue, 28 Nov 2017 14:31:21 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

The coretemp driver build fails when CONFIG_PCI is not enabled
because it uses a function that does not have a stub for that
config case, so add the function stub.

../drivers/hwmon/coretemp.c: In function 'adjust_tjmax':
../drivers/hwmon/coretemp.c:250:9: error: implicit declaration of function 'pci_get_domain_bus_and_slot' [-Werror=implicit-function-declaration]
  struct pci_dev *host_bridge = pci_get_domain_bus_and_slot(0, 0, devfn);
../drivers/hwmon/coretemp.c:250:32: warning: initialization makes pointer from integer without a cast [enabled by default]
  struct pci_dev *host_bridge = pci_get_domain_bus_and_slot(0, 0, devfn);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 include/linux/pci.h |    3 +++
 1 file changed, 3 insertions(+)

--- linux-next-20171128.orig/include/linux/pci.h
+++ linux-next-20171128/include/linux/pci.h
@@ -1660,6 +1660,9 @@ static inline struct pci_dev *pci_get_sl
 static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
 						unsigned int devfn)
 { return NULL; }
+static inline struct pci_dev *pci_get_domain_bus_and_slot(int domain,
+					unsigned int bus, unsigned int devfn)
+{ return NULL; }
 
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
 static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
