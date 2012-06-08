Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Xudong Hao <xudong.hao@intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, avi@redhat.com, alex.williamson@redhat.com,
	ddutile@redhat.com, myron.stowe@redhat.com,
	xiantao.zhang@intel.com, xudong.hao@intel.com
Subject: [PATCH 3/4] Enable OBFF before device is used by driver
Date: Fri,  8 Jun 2012 16:01:31 +0800
Message-Id: <1339142492-13625-4-git-send-email-xudong.hao@intel.com>
In-Reply-To: <1339142492-13625-1-git-send-email-xudong.hao@intel.com>
References: <1339142492-13625-1-git-send-email-xudong.hao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enable OBFF(optimized buffer flush/fill) in pci_enable_device() function, make
sure this feature is enabled before device is used by driver.

Signed-off-by: Xudong Hao <xudong.hao@intel.com>
---
 drivers/pci/pci.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5e5e3ad..35127c1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1144,11 +1144,20 @@ static void pci_enable_dev_caps(struct pci_dev *dev)
 	 * tolerance for snooped & unsnooped memory transactions.
 	 */
 	pci_enable_ltr(dev);
+
+	/* 
+	 * OBFF (optimized buffer flush/fill), where supported,
+	 * can help improve energy efficiency by giving devices
+	 * information about when interrupts and other activity
+	 * will have a reduced power impact.
+	 */
+	pci_enable_obff(dev, PCI_EXP_OBFF_SIGNAL_L0);
 }
 
 static void pci_disable_dev_caps(struct pci_dev *dev)
 {
 	pci_disable_ltr(dev);
+	pci_disable_obff(dev);
 }
 
 static int do_pci_enable_device(struct pci_dev *dev, int bars)
-- 
1.5.5

