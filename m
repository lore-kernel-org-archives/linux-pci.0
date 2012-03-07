Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v3 08/34] mips/PCI: removed unused pci_probe configurability
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Date: Wed, 07 Mar 2012 15:32:44 -0700
Message-ID: <20120307223244.25669.85258.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We never assign anything other than PCI_ASSIGN_ALL_BUSSES to pci_probe,
so just remove the indirection.  If configurability is required in the
future, please use the pci_flags/PCI_REASSIGN_ALL_BUS functionality
as is done for powerpc.

CC: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pci/pci.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 2a11045..19f6d19 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -24,10 +24,6 @@
  * assignments.
  */
 
-#define PCI_ASSIGN_ALL_BUSSES	1
-
-unsigned int pci_probe = PCI_ASSIGN_ALL_BUSSES;
-
 /*
  * The PCI controller list.
  */
@@ -238,7 +234,7 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 
 unsigned int pcibios_assign_all_busses(void)
 {
-	return (pci_probe & PCI_ASSIGN_ALL_BUSSES) ? 1 : 0;
+	return 1;
 }
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)

