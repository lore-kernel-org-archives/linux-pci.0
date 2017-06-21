Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/4] PCI: versatile: fix typo
Date: Wed, 21 Jun 2017 23:53:01 +0200
Message-Id: <20170621215323.3921382-3-arnd@arndb.de>
In-Reply-To: <20170621215323.3921382-1-arnd@arndb.de>
References: <20170621215323.3921382-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

There is no 'dev' variable in this function:

drivers/pci/host/pci-versatile.c: In function 'versatile_pci_probe':
drivers/pci/host/pci-versatile.c:131:38: error: 'dev' undeclared (first use in this function); did you mean 'pdev'?

This passes the device embedded in the platform_device instead.

Fixes: 433d2671da1b ("PCI: versatile: Convert PCI scan API to pci_scan_root_bus_bridge()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pci-versatile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index 3be25a9dd29a..f572c921cdd4 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -128,7 +128,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	LIST_HEAD(pci_res);
 
-	bridge = devm_pci_alloc_host_bridge(dev, 0);
+	bridge = devm_pci_alloc_host_bridge(&pdev->dev, 0);
 	if (!bridge)
 		return -ENOMEM;
 
-- 
2.9.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
