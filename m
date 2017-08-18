Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH 17/18] misc: pci_endpoint_test: Enable/Disable MSI using module param
Date: Fri, 18 Aug 2017 20:28:09 +0530
Message-ID: <20170818145810.17649-18-kishon@ti.com>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In certain platforms like TI's DRA7 SoCs, use of legacy PCI
interrupt is exclusive with use of MSI (Section 24.9.4.6.2.1
Legacy PCI Interrupts in
http://www.ti.com/lit/ug/spruhz6i/spruhz6i.pdf).

However pci_endpoint_test driver enables MSI by default in probe.
In order for pci_endpoint_test to be able to test legacy interrupt,
MSI should be disabled. Add a module param 'no_msi' to disable MSI
(only when legacy interrupt has to be tested).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 1f37ad39b169..1f64d943794d 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -72,6 +72,11 @@ static DEFINE_IDA(pci_endpoint_test_ida);
 
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
 					    miscdev)
+
+bool no_msi;
+module_param(no_msi, bool, 0444);
+MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
+
 enum pci_barno {
 	BAR_0,
 	BAR_1,
@@ -451,7 +456,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	int err;
 	int irq = 0;
 	int id;
-	bool no_msi = false;
 	char name[20];
 	enum pci_barno bar;
 	void __iomem *base;
-- 
2.11.0
