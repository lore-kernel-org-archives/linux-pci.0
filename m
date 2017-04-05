Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 20/23] tools: PCI: Add sample test script to invoke pcitest
Date: Wed, 5 Apr 2017 14:22:40 +0530
Message-ID: <20170405085243.18123-21-kishon@ti.com>
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

Add a simple test script that invokes the pcitest userspace tool to perform
all the PCI endpoint tests (BAR tests, interrupt tests, read tests, write
tests and copy tests).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 tools/pci/pcitest.sh | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 tools/pci/pcitest.sh

diff --git a/tools/pci/pcitest.sh b/tools/pci/pcitest.sh
new file mode 100644
index 000000000000..5442bbea4c22
--- /dev/null
+++ b/tools/pci/pcitest.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+
+echo "BAR tests"
+echo
+
+bar=0
+
+while [ $bar -lt 6 ]
+do
+	pcitest -b $bar
+	bar=`expr $bar + 1`
+done
+echo
+
+echo "Interrupt tests"
+echo
+
+pcitest -l
+msi=1
+
+while [ $msi -lt 33 ]
+do
+        pcitest -m $msi
+        msi=`expr $msi + 1`
+done
+echo
+
+echo "Read Tests"
+echo
+
+pcitest -r -s 1
+pcitest -r -s 1024
+pcitest -r -s 1025
+pcitest -r -s 1024000
+pcitest -r -s 1024001
+echo
+
+echo "Write Tests"
+echo
+
+pcitest -w -s 1
+pcitest -w -s 1024
+pcitest -w -s 1025
+pcitest -w -s 1024000
+pcitest -w -s 1024001
+echo
+
+echo "Copy Tests"
+echo
+
+pcitest -c -s 1
+pcitest -c -s 1024
+pcitest -c -s 1025
+pcitest -c -s 1024000
+pcitest -c -s 1024001
+echo
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
