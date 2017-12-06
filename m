Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sinan Kaya <okaya@codeaurora.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Minter <matt@masarand.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci: provide pci_get_domain_bus_and_slot dummy helper
Date: Wed,  6 Dec 2017 15:17:30 +0100
Message-Id: <20171206141751.757163-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When CONFIG_PCI is disabled, we still provide a pci_get_bus_and_slot()
function that always returns NULL, but do not provide the same helper
for pci_get_domain_bus_and_slot():

Replacing pci_get_bus_and_slot with pci_get_domain_bus_and_slot now causes
a build error because of that:

drivers/hwmon/coretemp.c: In function 'adjust_tjmax':
drivers/hwmon/coretemp.c:250:32: error: implicit declaration of function 'pci_get_domain_bus_and_slot'; did you mean 'pci_get_bus_and_slot'? [-Werror=implicit-function-declaration]
  struct pci_dev *host_bridge = pci_get_domain_bus_and_slot(0, 0, devfn);

This adds the missing helper function.

Fixes: 1630bd42079c ("hwmon: (coretemp) deprecate pci_get_bus_and_slot()")
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
It would be good to get this into v4.15, in order to increase the
chances of it still working after the conversion patches get merged
during the v4.16 merge window.
---
 include/linux/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index a1589dec7e33..69815397365e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1660,6 +1660,10 @@ static inline struct pci_dev *pci_get_slot(struct pci_bus *bus,
 static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
 						unsigned int devfn)
 { return NULL; }
+static inline struct pci_dev *pci_get_domain_bus_and_slot(int domain,
+						unsigned int bus,
+						unsigned int devfn)
+{ return NULL; }
 
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
 static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
-- 
2.9.0
