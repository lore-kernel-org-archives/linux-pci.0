Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 27 Feb 2018 17:19:52 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] PCI/ASPM: Change type of threshold_ns variable to u32
Message-ID: <20180227231952.GA9001@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It seems that the expression threshold_us * 1000 will never exceed the
32-bit limits [1]. So changing the type of threshold_ns from u64 to u32
seems sensible [2].

[1] https://marc.info/?l=linux-kernel&m=151855021100725&w=2
[2] https://marc.info/?l=linux-kernel&m=151976318924615&w=2

Addresses-Coverity-ID: 1462501
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/pci/pcie/aspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 57feef2..8633fc4 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -322,7 +322,7 @@ static u32 calc_l1ss_pwron(struct pci_dev *pdev, u32 scale, u32 val)
 
 static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 {
-	u64 threshold_ns = threshold_us * 1000;
+	u32 threshold_ns = threshold_us * 1000;
 
 	/* See PCIe r3.1, sec 7.33.3 and sec 6.18 */
 	if (threshold_ns < 32) {
-- 
2.7.4
