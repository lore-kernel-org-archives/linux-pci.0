Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64079 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138AbcALUSO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jan 2016 15:18:14 -0500
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCHv8 4/5] PCI/AER: Use 32 bit int type domains
Date: Tue, 12 Jan 2016 13:18:09 -0700
Message-Id: <1452629890-17542-5-git-send-email-keith.busch@intel.com>
In-Reply-To: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

New pci device provides additional pci domains that start above what 16
bits can address.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer/aer_inject.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index 182224a..20db790 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -41,12 +41,12 @@ struct aer_error_inj {
 	u32 header_log1;
 	u32 header_log2;
 	u32 header_log3;
-	u16 domain;
+	u32 domain;
 };
 
 struct aer_error {
 	struct list_head list;
-	u16 domain;
+	u32 domain;
 	unsigned int bus;
 	unsigned int devfn;
 	int pos_cap_err;
@@ -74,7 +74,7 @@ static LIST_HEAD(pci_bus_ops_list);
 /* Protect einjected and pci_bus_ops_list */
 static DEFINE_SPINLOCK(inject_lock);
 
-static void aer_error_init(struct aer_error *err, u16 domain,
+static void aer_error_init(struct aer_error *err, u32 domain,
 			   unsigned int bus, unsigned int devfn,
 			   int pos_cap_err)
 {
@@ -86,7 +86,7 @@ static void aer_error_init(struct aer_error *err, u16 domain,
 }
 
 /* inject_lock must be held before calling */
-static struct aer_error *__find_aer_error(u16 domain, unsigned int bus,
+static struct aer_error *__find_aer_error(u32 domain, unsigned int bus,
 					  unsigned int devfn)
 {
 	struct aer_error *err;
@@ -106,7 +106,7 @@ static struct aer_error *__find_aer_error_by_dev(struct pci_dev *dev)
 	int domain = pci_domain_nr(dev->bus);
 	if (domain < 0)
 		return NULL;
-	return __find_aer_error((u16)domain, dev->bus->number, dev->devfn);
+	return __find_aer_error(domain, dev->bus->number, dev->devfn);
 }
 
 /* inject_lock must be held before calling */
@@ -196,7 +196,7 @@ static int pci_read_aer(struct pci_bus *bus, unsigned int devfn, int where,
 	domain = pci_domain_nr(bus);
 	if (domain < 0)
 		goto out;
-	err = __find_aer_error((u16)domain, bus->number, devfn);
+	err = __find_aer_error(domain, bus->number, devfn);
 	if (!err)
 		goto out;
 
@@ -228,7 +228,7 @@ static int pci_write_aer(struct pci_bus *bus, unsigned int devfn, int where,
 	domain = pci_domain_nr(bus);
 	if (domain < 0)
 		goto out;
-	err = __find_aer_error((u16)domain, bus->number, devfn);
+	err = __find_aer_error(domain, bus->number, devfn);
 	if (!err)
 		goto out;
 
@@ -329,7 +329,7 @@ static int aer_inject(struct aer_error_inj *einj)
 	u32 sever, cor_mask, uncor_mask, cor_mask_orig = 0, uncor_mask_orig = 0;
 	int ret = 0;
 
-	dev = pci_get_domain_bus_and_slot((int)einj->domain, einj->bus, devfn);
+	dev = pci_get_domain_bus_and_slot(einj->domain, einj->bus, devfn);
 	if (!dev)
 		return -ENODEV;
 	rpdev = pcie_find_root_port(dev);
-- 
2.6.2.307.g37023ba

