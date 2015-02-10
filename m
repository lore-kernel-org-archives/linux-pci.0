Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
To: mohit.kumar@st.com, viresh.kumar@linaro.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCHv2 1/2] pci: spear: Use platform_driver_probe instead of platform_driver_register
Date: Tue, 10 Feb 2015 19:31:21 +0300
Message-Id: <1423585882-5464-1-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use platform_driver_probe instead of platform_driver_register
because the former allows us to use probe function placed into __init section
and the driver itself is not support hotplugging (yet?).

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
Changes from v1:
 - Use platform_driver_probe instead of platform_driver_register to make linker happy.

 drivers/pci/host/pcie-spear13xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 866465f..51e1344 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -371,7 +371,6 @@ static const struct of_device_id spear13xx_pcie_of_match[] = {
 MODULE_DEVICE_TABLE(of, spear13xx_pcie_of_match);
 
 static struct platform_driver spear13xx_pcie_driver __initdata = {
-	.probe		= spear13xx_pcie_probe,
 	.driver = {
 		.name	= "spear-pcie",
 		.of_match_table = of_match_ptr(spear13xx_pcie_of_match),
@@ -382,7 +381,7 @@ static struct platform_driver spear13xx_pcie_driver __initdata = {
 
 static int __init spear13xx_pcie_init(void)
 {
-	return platform_driver_register(&spear13xx_pcie_driver);
+	return platform_driver_probe(&spear13xx_pcie_driver, spear13xx_pcie_probe);
 }
 module_init(spear13xx_pcie_init);
 
-- 
2.1.4

