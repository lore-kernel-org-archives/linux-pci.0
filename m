Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
To: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <hanjun.guo@linaro.org>, <thomas.lendacky@amd.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V5 7/9] of/pci: Fix pci_get_host_bridge_device leak
Date: Wed, 28 Oct 2015 15:50:52 -0700
Message-ID: <1446072654-5608-8-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In case of error, the current code return w/o calling
pci_put_host_bridge_device. This patch fixes this.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/of/of_pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 5751dc5..a2f510c 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -129,10 +129,9 @@ void of_pci_dma_configure(struct pci_dev *pci_dev)
 	struct device *dev = &pci_dev->dev;
 	struct device *bridge = pci_get_host_bridge_device(pci_dev);
 
-	if (!bridge->parent)
-		return;
+	if (bridge->parent)
+		of_dma_configure(dev, bridge->parent->of_node);
 
-	of_dma_configure(dev, bridge->parent->of_node);
 	pci_put_host_bridge_device(bridge);
 }
 EXPORT_SYMBOL_GPL(of_pci_dma_configure);
-- 
2.1.0

