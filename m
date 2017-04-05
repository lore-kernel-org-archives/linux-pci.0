Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 06/23] Documentation: PCI: Add specification for the *PCI
 test* function device
Date: Wed, 5 Apr 2017 14:22:26 +0530
Message-ID: <20170405085243.18123-7-kishon@ti.com>
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

Add specification for the *PCI test* virtual function device. The endpoint
function driver and the host PCI driver should be created based on this
specification.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/00-INDEX                       |  2 +
 Documentation/PCI/endpoint/pci-test-function.txt | 66 ++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-test-function.txt

diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
index bf8223a1bf08..ab35e4bbdb1c 100644
--- a/Documentation/PCI/00-INDEX
+++ b/Documentation/PCI/00-INDEX
@@ -16,3 +16,5 @@ endpoint/pci-endpoint.txt
 	- guide to add endpoint controller driver and endpoint function driver.
 endpoint/pci-endpoint-cfs.txt
 	- guide to use configfs to configure the PCI endpoint function.
+endpoint/pci-test-function.txt
+	- specification of *PCI test* function device.
diff --git a/Documentation/PCI/endpoint/pci-test-function.txt b/Documentation/PCI/endpoint/pci-test-function.txt
new file mode 100644
index 000000000000..0c519c9bf94a
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-test-function.txt
@@ -0,0 +1,66 @@
+				PCI TEST
+		    Kishon Vijay Abraham I <kishon@ti.com>
+
+Traditionally PCI RC has always been validated by using standard
+PCI cards like ethernet PCI cards or USB PCI cards or SATA PCI cards.
+However with the addition of EP-core in linux kernel, it is possible
+to configure a PCI controller that can operate in EP mode to work as
+a test device.
+
+The PCI endpoint test device is a virtual device (defined in software)
+used to test the endpoint functionality and serve as a sample driver
+for other PCI endpoint devices (to use the EP framework).
+
+The PCI endpoint test device has the following registers:
+
+	1) PCI_ENDPOINT_TEST_MAGIC
+	2) PCI_ENDPOINT_TEST_COMMAND
+	3) PCI_ENDPOINT_TEST_STATUS
+	4) PCI_ENDPOINT_TEST_SRC_ADDR
+	5) PCI_ENDPOINT_TEST_DST_ADDR
+	6) PCI_ENDPOINT_TEST_SIZE
+	7) PCI_ENDPOINT_TEST_CHECKSUM
+
+*) PCI_ENDPOINT_TEST_MAGIC
+
+This register will be used to test BAR0. A known pattern will be written
+and read back from MAGIC register to verify BAR0.
+
+*) PCI_ENDPOINT_TEST_COMMAND:
+
+This register will be used by the host driver to indicate the function
+that the endpoint device must perform.
+
+Bitfield Description:
+  Bit 0		: raise legacy IRQ
+  Bit 1		: raise MSI IRQ
+  Bit 2 - 7	: MSI interrupt number
+  Bit 8		: read command (read data from RC buffer)
+  Bit 9		: write command (write data to RC buffer)
+  Bit 10	: copy command (copy data from one RC buffer to another
+		  RC buffer)
+
+*) PCI_ENDPOINT_TEST_STATUS
+
+This register reflects the status of the PCI endpoint device.
+
+Bitfield Description:
+  Bit 0		: read success
+  Bit 1		: read fail
+  Bit 2		: write success
+  Bit 3		: write fail
+  Bit 4		: copy success
+  Bit 5		: copy fail
+  Bit 6		: IRQ raised
+  Bit 7		: source address is invalid
+  Bit 8		: destination address is invalid
+
+*) PCI_ENDPOINT_TEST_SRC_ADDR
+
+This register contains the source address (RC buffer address) for the
+COPY/READ command.
+
+*) PCI_ENDPOINT_TEST_DST_ADDR
+
+This register contains the destination address (RC buffer address) for
+the COPY/WRITE command.
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
