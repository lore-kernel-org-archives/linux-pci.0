Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 09/18] PCI: endpoint: functions/pci-epf-test: Remove the ->remove() callback
Date: Fri, 18 Aug 2017 20:28:01 +0530
Message-ID: <20170818145810.17649-10-kishon@ti.com>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Shawn Lin <shawn.lin@rock-chips.com>

epf_test is allocated using devm_kzalloc. Hence it's not required to
explicitly free it in remove() callback. Since ->remove() callback
doesn't do anything other than freeing epf_test, remove the
->remove() callback.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index a0aea2500690..4ddc6e8f9fe7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -496,14 +496,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 	return 0;
 }
 
-static int pci_epf_test_remove(struct pci_epf *epf)
-{
-	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
-
-	kfree(epf_test);
-	return 0;
-}
-
 static struct pci_epf_ops ops = {
 	.unbind	= pci_epf_test_unbind,
 	.bind	= pci_epf_test_bind,
@@ -513,7 +505,6 @@ static struct pci_epf_ops ops = {
 static struct pci_epf_driver test_driver = {
 	.driver.name	= "pci_epf_test",
 	.probe		= pci_epf_test_probe,
-	.remove		= pci_epf_test_remove,
 	.id_table	= pci_epf_test_ids,
 	.ops		= &ops,
 	.owner		= THIS_MODULE,
-- 
2.11.0
