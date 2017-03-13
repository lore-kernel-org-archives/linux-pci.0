Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 04/23] Documentation: PCI: Guide to use pci endpoint
 configfs
Date: Mon, 13 Mar 2017 19:52:40 +0530
Message-ID: <20170313142259.25397-5-kishon@ti.com>
In-Reply-To: <20170313142259.25397-1-kishon@ti.com>
References: <20170313142259.25397-1-kishon@ti.com>
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

Add Documentation to help users use pci endpoint to configure
pci endpoint function and to bind the endpoint function
with endpoint controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/PCI/00-INDEX                      |   2 +
 Documentation/PCI/endpoint/pci-endpoint-cfs.txt | 105 ++++++++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint-cfs.txt

diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
index ba950b296bd8..f84a23c7c74b 100644
--- a/Documentation/PCI/00-INDEX
+++ b/Documentation/PCI/00-INDEX
@@ -14,3 +14,5 @@ pcieaer-howto.txt
 	- the PCI Express Advanced Error Reporting Driver Guide HOWTO
 endpoint/pci-endpoint.txt
 	- guide to add endpoint controller driver and endpoint function driver.
+endpoint/pci-endpoint-cfs.txt
+	- guide to use configfs to configure the pci endpoint function.
diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.txt b/Documentation/PCI/endpoint/pci-endpoint-cfs.txt
new file mode 100644
index 000000000000..8b2a8280b131
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.txt
@@ -0,0 +1,105 @@
+                   CONFIGURING PCI ENDPOINT USING CONFIGFS
+                    Kishon Vijay Abraham I <kishon@ti.com>
+
+The PCI Endpoint Core exposes configfs entry (pci_ep) in order to configure the
+PCI endpoint function and in order to bind the endpoint function
+with the endpoint controller. (For introducing other mechanisms to
+configure the PCI Endpoint Function refer [1]).
+
+*) Mounting configfs
+
+The PCI Endpoint Core layer creates pci_ep directory in the mounted configfs
+directory. configfs can be mounted using the following command.
+
+	mount -t configfs none /sys/kernel/config
+
+*) Directory Structure
+
+The pci_ep configfs has two directories at its root: controllers and
+functions. Every EPC device present in the system will have an entry in
+the *controllers* directory and and every EPF driver present in the system
+will have an entry in the *functions* directory.
+
+/sys/kernel/config/pci_ep/
+	.. controllers/
+	.. functions/
+
+*) Creating EPF Device
+
+Every registered EPF driver will be listed in controllers directory. The
+entries corresponding to EPF driver will be created by the EPF core.
+
+/sys/kernel/config/pci_ep/functions/
+	.. <EPF Driver1>/
+		... <EPF Device 11>/
+		... <EPF Device 21>/
+	.. <EPF Driver2>/
+		... <EPF Device 12>/
+		... <EPF Device 22>/
+
+In order to create a <EPF device> of the type probed by <EPF Driver>, the
+user has to create a directory inside <EPF DriverN>.
+
+Every <EPF device> directory consists of the following entries that can be
+used to configure the standard configuration header of the endpoint function.
+(These entries are created by the framework when any new <EPF Device> is
+created)
+
+	.. <EPF Driver1>/
+		... <EPF Device 11>/
+			... vendorid
+			... deviceid
+			... revid
+			... progif_code
+			... subclass_code
+			... baseclass_code
+			... cache_line_size
+			... subsys_vendor_id
+			... subsys_id
+			... interrupt_pin
+
+*) EPC Device
+
+Every registered EPC device will be listed in controllers directory. The
+entries corresponding to EPC device will be created by the EPC core.
+
+/sys/kernel/config/pci_ep/controllers/
+	.. <EPC Device1>/
+		... <Symlink EPF Device11>/
+		... <Symlink EPF Device12>/
+		... start
+	.. <EPC Device2>/
+		... <Symlink EPF Device21>/
+		... <Symlink EPF Device22>/
+		... start
+
+The <EPC Device> directory will have a list of symbolic links to
+<EPF Device>. These symbolic links should be created by the user to
+represent the functions present in the endpoint device.
+
+The <EPC Device> directory will also have a *start* field. Once
+"1" is written to this field, the endpoint device will be ready to
+establish the link with the host. This is usually done after
+all the EPF devices are created and linked with the EPC device.
+
+
+			 | controllers/
+				| <Directory: EPC name>/
+					| <Symbolic Link: Function>
+					| start
+			 | functions/
+				| <Directory: EPF driver>/
+					| <Directory: EPF device>/
+						| vendorid
+						| deviceid
+						| revid
+						| progif_code
+						| subclass_code
+						| baseclass_code
+						| cache_line_size
+						| subsys_vendor_id
+						| subsys_id
+						| interrupt_pin
+						| function
+
+[1] -> Documentation/PCI/endpoint/pci-endpoint.txt
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
