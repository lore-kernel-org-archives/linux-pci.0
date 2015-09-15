Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH] PCI: Fix devfn for VPD access through function 0
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: mark.d.rustad@intel.com, myron.stowe@redhat.com,
	linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2015 11:17:21 -0600
Message-ID: <20150915171216.7049.58119.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 932c435caba8 ("PCI: Add dev_flags bit to access VPD through
function 0") passes PCI_SLOT(devfn) for the devfn parameter of
pci_get_slot().  Generally this works because we're fairly well
guaranteed that a PCIe device is at slot address 0, but for the
general case, including conventional PCI, it's incorrect.  We need
to get the slot and then convert it back into a devfn.

Fixes: 932c435caba8 ("PCI: Add dev_flags bit to access VPD through function 0")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Cc: stable@vger.kernel.org
---

Since the original patch and quirk was marked for stable and applies
to all Intel NICs, regardless of the bus type, I assume this needs to
chase it or VPD might disappear on e1000/e100 if it currently exists.

 drivers/pci/access.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 769f7e3..5a5f0a7 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -442,7 +442,8 @@ static const struct pci_vpd_ops pci_vpd_pci22_ops = {
 static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
 			       void *arg)
 {
-	struct pci_dev *tdev = pci_get_slot(dev->bus, PCI_SLOT(dev->devfn));
+	struct pci_dev *tdev = pci_get_slot(dev->bus,
+					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 	ssize_t ret;
 
 	if (!tdev)
@@ -456,7 +457,8 @@ static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
 static ssize_t pci_vpd_f0_write(struct pci_dev *dev, loff_t pos, size_t count,
 				const void *arg)
 {
-	struct pci_dev *tdev = pci_get_slot(dev->bus, PCI_SLOT(dev->devfn));
+	struct pci_dev *tdev = pci_get_slot(dev->bus,
+					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 	ssize_t ret;
 
 	if (!tdev)
@@ -475,7 +477,8 @@ static const struct pci_vpd_ops pci_vpd_f0_ops = {
 
 static int pci_vpd_f0_dev_check(struct pci_dev *dev)
 {
-	struct pci_dev *tdev = pci_get_slot(dev->bus, PCI_SLOT(dev->devfn));
+	struct pci_dev *tdev = pci_get_slot(dev->bus,
+					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 	int ret = 0;
 
 	if (!tdev)

