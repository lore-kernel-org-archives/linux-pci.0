Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <hch@infradead.org>, <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH v5 21/24] tools: PCI: Add sample test script to invoke pcitest
Date: Mon, 27 Mar 2017 15:15:17 +0530
Message-ID: <20170327094520.3129-22-kishon@ti.com>
In-Reply-To: <20170327094520.3129-1-kishon@ti.com>
References: <20170327094520.3129-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a simple test script that invokes the pcitest userspace tool
to perform all the PCI endpoint tests (BAR tests, interrupt tests,
read tests, write tests and copy tests).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
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
