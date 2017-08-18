Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH 16/18] misc: pci_endpoint_test: Avoid using hard coded BAR sizes
Date: Fri, 18 Aug 2017 20:28:08 +0530
Message-ID: <20170818145810.17649-17-kishon@ti.com>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

BAR sizes are hard coded in pci_endpoint_test driver corresponding to
the sizes used in pci-epf-test function driver. This might break if
the sizes in pci-epf-test function driver is modified (and the
corresponding change is not done in pci_endpoint_test pci driver).
To avoid hard coding BAR sizes, use pci_resource_len API.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 5cbb25cf276c..1f37ad39b169 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -100,8 +100,6 @@ struct pci_endpoint_test_data {
 	bool no_msi;
 };
 
-static int bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
-
 static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
 					  u32 offset)
 {
@@ -149,11 +147,12 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	int j;
 	u32 val;
 	int size;
+	struct pci_dev *pdev = test->pdev;
 
 	if (!test->bar[barno])
 		return false;
 
-	size = bar_size[barno];
+	size = pci_resource_len(pdev, barno);
 
 	if (barno == test->test_reg_bar)
 		size = 0x4;
-- 
2.11.0
