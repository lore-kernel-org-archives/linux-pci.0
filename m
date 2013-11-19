Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 3/3] PCI: Support PCIe Capability Slot registers only for
 ports with slots
To: stable@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Myron Stowe <myron.stowe@redhat.com>, linux-pci@vger.kernel.org,
	Amos Kong <kongjianjun@gmail.com>,
	Adam Lee <adam.lee@canonical.com>,
	linux-kernel@vger.kernel.org, Yuval Mintz <yuvalmin@broadcom.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Thomas Renninger <trenn@suse.de>
Date: Tue, 19 Nov 2013 14:35:57 -0700
Message-ID: <20131119213557.3839.56953.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20131119212714.3839.52182.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131119212714.3839.52182.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 6d3a1741f1e648cfbd5a0cc94477a0d5004c6f5e upstream.  This is part
of the fix for https://bugzilla.kernel.org/show_bug.cgi?id=65211

Previously we allowed callers to access Slot Capabilities, Status, and
Control for Root Ports even if the Root Port did not implement a slot.
This seems dubious because the spec only requires these registers if a
slot is implemented.

It's true that even Root Ports without slots must have *space* for these
slot registers, because the Root Capabilities, Status, and Control
registers are after the slot registers in the capability.  However,
for a v1 PCIe Capability, the *semantics* of the slot registers are
undefined unless a slot is implemented.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-By: Jiang Liu <jiang.liu@huawei.com>
CC: stable@vger.kernel.org	# v3.7+
---
 drivers/pci/access.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 9a46fa9135d9..061da8c3ab4b 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -497,9 +497,9 @@ static inline bool pcie_cap_has_sltctl(const struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
 
-	return type == PCI_EXP_TYPE_ROOT_PORT ||
-	       (type == PCI_EXP_TYPE_DOWNSTREAM &&
-		pcie_caps_reg(dev) & PCI_EXP_FLAGS_SLOT);
+	return (type == PCI_EXP_TYPE_ROOT_PORT ||
+		type == PCI_EXP_TYPE_DOWNSTREAM) &&
+	       pcie_caps_reg(dev) & PCI_EXP_FLAGS_SLOT;
 }
 
 static inline bool pcie_cap_has_rtctl(const struct pci_dev *dev)

