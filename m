Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 2/3] pci: Add pci_dev_flag for ACS enable quirks
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Mon, 03 Feb 2014 14:27:39 -0700
Message-ID: <20140203212739.8607.65523.stgit@bling.home>
In-Reply-To: <20140203212216.8607.68273.stgit@bling.home>
References: <20140203212216.8607.68273.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Quirks that enable ACS compatible functionality on a device need some
way to track whether a given device has been enabled.  Rather than
create new data structures for this, allocate one of the pci_dev_flags
to indicate this setup.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 include/linux/pci.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index f9a47dd..cb9a109 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -170,6 +170,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_D3 = (__force pci_dev_flags_t) 2,
 	/* Provide indication device is assigned by a Virtual Machine Manager */
 	PCI_DEV_FLAGS_ASSIGNED = (__force pci_dev_flags_t) 4,
+	/* Flag for quirk use to store if quirk specific ACS is enabled */
+	PCI_DEV_FLAGS_ACS_ENABLED_QUIRK = (__force pci_dev_flags_t) 8,
 };
 
 enum pci_irq_reroute_variant {

