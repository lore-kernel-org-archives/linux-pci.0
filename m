Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 17/22] Documentation: misc-devices: Add Documentation for
 pci-endpoint-test driver
Date: Fri, 17 Feb 2017 15:20:37 +0530
Message-ID: <1487325042-28227-18-git-send-email-kishon@ti.com>
In-Reply-To: <1487325042-28227-1-git-send-email-kishon@ti.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Add Documentation for pci-endpoint-test driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/misc-devices/pci-endpoint-test.txt |   35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/misc-devices/pci-endpoint-test.txt

diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
new file mode 100644
index 0000000..4385718
--- /dev/null
+++ b/Documentation/misc-devices/pci-endpoint-test.txt
@@ -0,0 +1,35 @@
+Driver for PCI Endpoint Test Function
+
+This driver should be used as a host side driver if the root complex is
+connected to a configurable pci endpoint running *pci_epf_test* function
+driver configured according to [1].
+
+The "pci_endpoint_test" driver can be used to perform the following tests.
+
+The PCI driver for the test device performs the following tests
+	*) verifying addresses programmed in BAR
+	*) raise legacy IRQ
+	*) raise MSI IRQ
+	*) read data
+	*) write data
+	*) copy data
+
+This misc driver creates /dev/pci-endpoint-test.<num> for every
+*pci_epf_test* function connected to the root complex and "ioctls"
+should be used to perform the above tests.
+
+ioctl
+-----
+ PCITEST_BAR: Tests the BAR. The number of the BAR that has to be tested
+	      should be passed as argument.
+ PCITEST_LEGACY_IRQ: Tests legacy IRQ
+ PCITEST_MSI: Tests message signalled interrupts. The MSI number that has
+	      to be tested should be passed as argument.
+ PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
+		as argument.
+ PCITEST_READ: Perform read tests. The size of the buffer should be passed
+	       as argument.
+ PCITEST_COPY: Perform read tests. The size of the buffer should be passed
+	       as argument.
+
+[1] -> Documentation/PCI/endpoint/function/binding/pci-test.txt
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
