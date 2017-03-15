Return-Path: <SRS0=p8WW=2Y=semihalf.com=tn@kernel.org>
Return-Path: <SRS0=p8WW=2Y=semihalf.com=tn@kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	Lorenzo.Pieralisi@arm.com,
	robert.richter@caviumnetworks.com,
	ddaney@caviumnetworks.com,
	Vadim.Lomovtsev@caviumnetworks.com,
	rafael@kernel.org
Cc: Sunil.Goutham@cavium.com,
	geethasowjanya.akula@gmail.com,
	linu.cherian@cavium.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH 1/2] PCI: Use Cavium assigned hardware ID for ThunderX host controller
Date: Wed, 15 Mar 2017 08:49:14 +0100
Message-Id: <1489564155-3881-2-git-send-email-tn@semihalf.com>
In-Reply-To: <1489564155-3881-1-git-send-email-tn@semihalf.com>
References: <1489564155-3881-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

"CAV" is the only PNP/ACPI hardware ID vendor prefix assigned to Cavium
so fix this as it should be from day one.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/pci/host/pci-thunder-pem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index af722eb..e354010 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -331,7 +331,7 @@ static int thunder_pem_acpi_init(struct pci_config_window *cfg)
 	if (!res_pem)
 		return -ENOMEM;
 
-	ret = acpi_get_rc_resources(dev, "THRX0002", root->segment, res_pem);
+	ret = acpi_get_rc_resources(dev, "CAVA02B", root->segment, res_pem);
 	if (ret) {
 		dev_err(dev, "can't get rc base address\n");
 		return ret;
-- 
2.7.4
