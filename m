Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Ravi Shankar Jonnalagadda <venkata.ravi.jonnalagadda@xilinx.com>
To: <bhelgaas@google.com>, <michal.simek@xilinx.com>,
 <soren.brinkmann@xilinx.com>, <lorenzo.pieralisi@arm.com>,
 <bharat.kumar.gogada@xilinx.com>, <vjonnal@xilinx.com>,
 <paul.gortmaker@windriver.com>, <linux-pci@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <dan.j.williams@intel.com>, <vinod.koul@intel.com>,
 <dmaengine@vger.kernel.org>
Subject: [PATCH 4/4] PCI: ZYNQMP PS PCIe DMA driver: Devicetree binding for
 Root DMA
Date: Tue, 8 Aug 2017 16:42:19 +0530
Message-ID: <1502190739-13474-5-git-send-email-vjonnal@xilinx.com>
In-Reply-To: <1502190739-13474-1-git-send-email-vjonnal@xilinx.com>
References: <1502190739-13474-1-git-send-email-vjonnal@xilinx.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Binding explaining devicetree usage for using Root DMA capability of ZynqMPSoC

Signed-off-by: Ravi Shankar Jonnalagadda <vjonnal@xilinx.com>
---
 .../devicetree/bindings/dma/xilinx/ps-pcie-dma.txt | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/ps-pcie-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/xilinx/ps-pcie-dma.txt b/Documentation/devicetree/bindings/dma/xilinx/ps-pcie-dma.txt
new file mode 100644
index 0000000..acdcc44
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/xilinx/ps-pcie-dma.txt
@@ -0,0 +1,67 @@
+* Xilinx PS PCIe Root DMA
+
+Required properties:
+- compatible: Should be "xlnx,ps_pcie_dma-1.00.a"
+- reg: Register offset for Root DMA channels
+- reg-names: Name for the register. Should be "ps_pcie_regbase"
+- interrupts: Interrupt pin for Root DMA
+- interrupt-names: Name for the interrupt. Should be "ps_pcie_rootdma_intr"
+- interrupt-parent: Should be gic in case of zynqmp
+- rootdma: Indicates this platform device is root dma.
+	This is required as the same platform driver will be invoked by pcie end points too
+- dma_vendorid: 16 bit PCIe device vendor id.
+	This can be later used by dma client for matching while using dma_request_channel
+- dma_deviceid: 16 bit PCIe device id
+	This can be later used by dma client for matching while using dma_request_channel
+- numchannels: Indicates number of channels to be enabled for the device.
+	Valid values are from 1 to 4 for zynqmp
+- ps_pcie_channel : One for each channel to be enabled.
+	This array contains channel specific properties.
+	Index 0: Direction of channel
+		Direction of channel can be either PCIe Memory to AXI memory i.e., Host to Card or
+		AXI Memory to PCIe memory i.e., Card to Host
+		PCIe to AXI Channel Direction is represented as 0x1
+		AXI to PCIe Channel Direction is represented as 0x0
+	Index 1: Number of Buffer Descriptors
+		This number describes number of buffer descriptors to be allocated for a channel
+	Index 2: Number of Queues
+		Each Channel has four DMA Buffer Descriptor Queues.
+		By default All four Queues will be managed by Root DMA driver.
+		User may choose to have only two queues either Source and it's Status Queue or
+			Destination and it's Status Queue to be handled by Driver.
+		The other two queues need to be handled by user logic which will not be part of this driver.
+		All Queues on Host is represented by 0x4
+		Two Queues on Host is represented by 0x2
+	Index 3: Coalesce Count
+		This number indicates the number of transfers after which interrupt needs to
+		be raised for the particular channel. The allowed range is from 0 to 255
+	Index 4: Coalesce Count Timer frequency
+		This property is used to control the frequency of poll timer. Poll timer is
+		created for a channel whenever coalesce count value (>= 1) is programmed for the particular
+		channel. This timer is helpful in draining out completed transactions even though interrupt is
+		not generated.
+
+Client Usage:
+	DMA clients can request for these channels using dma_request_channel API
+
+
+Xilinx PS PCIe Root DMA node Example
+++++++++++++++++++++++++++++++++++++
+
+	pci_rootdma: rootdma@fd0f0000 {
+		compatible = "xlnx,ps_pcie_dma-1.00.a";
+		reg = <0x0 0xfd0f0000 0x0 0x1000>;
+		reg-names = "ps_pcie_regbase";
+		interrupts = <0 117 4>;
+		interrupt-names = "ps_pcie_rootdma_intr";
+		interrupt-parent = <&gic>;
+		rootdma;
+		dma_vendorid = /bits/ 16 <0x10EE>;
+		dma_deviceid = /bits/ 16 <0xD021>;
+		numchannels = <0x4>;
+		#size-cells = <0x5>;
+		ps_pcie_channel0 = <0x1 0x7CF 0x4 0x0 0x3E8>;
+		ps_pcie_channel1 = <0x0 0x7CF 0x4 0x0 0x3E8>;
+		ps_pcie_channel2 = <0x1 0x7CF 0x4 0x0 0x3E8>;
+		ps_pcie_channel3 = <0x0 0x7CF 0x4 0x0 0x3E8>;
+    };
-- 
2.1.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
