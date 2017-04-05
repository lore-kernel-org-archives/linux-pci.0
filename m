Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 08/23] Documentation: PCI: Add binding documentation for
 pci-test endpoint function
Date: Wed, 5 Apr 2017 14:22:28 +0530
Message-ID: <20170405085243.18123-9-kishon@ti.com>
In-Reply-To: <20170405085243.18123-1-kishon@ti.com>
References: <20170405085243.18123-1-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: hch@infradead.org, nsekhar@ti.com, kishon@ti.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Add binding documentation for pci-test endpoint function that helps in
adding and configuring pci-test endpoint function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/00-INDEX                              |  2 ++
 .../PCI/endpoint/function/binding/pci-test.txt          | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/function/binding/pci-test.txt

diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
index ab35e4bbdb1c..2fc901a1c32e 100644
--- a/Documentation/PCI/00-INDEX
+++ b/Documentation/PCI/00-INDEX
@@ -18,3 +18,5 @@ endpoint/pci-endpoint-cfs.txt
 	- guide to use configfs to configure the PCI endpoint function.
 endpoint/pci-test-function.txt
 	- specification of *PCI test* function device.
+endpoint/function/binding/
+	- binding documentation for PCI endpoint function
diff --git a/Documentation/PCI/endpoint/function/binding/pci-test.txt b/Documentation/PCI/endpoint/function/binding/pci-test.txt
new file mode 100644
index 000000000000..3b68b955fb50
--- /dev/null
+++ b/Documentation/PCI/endpoint/function/binding/pci-test.txt
@@ -0,0 +1,17 @@
+PCI TEST ENDPOINT FUNCTION
+
+name: Should be "pci_epf_test" to bind to the pci_epf_test driver.
+
+Configurable Fields:
+vendorid	 : should be 0x104c
+deviceid	 : should be 0xb500 for DRA74x and 0xb501 for DRA72x
+revid		 : don't care
+progif_code	 : don't care
+subclass_code	 : don't care
+baseclass_code	 : should be 0xff
+cache_line_size	 : don't care
+subsys_vendor_id : don't care
+subsys_id	 : don't care
+interrupt_pin	 : Should be 1 - INTA, 2 - INTB, 3 - INTC, 4 -INTD
+msi_interrupts	 : Should be 1 to 32 depending on the number of MSI interrupts
+		   to test
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
