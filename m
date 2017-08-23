Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:46557 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdHWJrz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2017 05:47:55 -0400
From: Colin King <colin.king@canonical.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: pci_endpoint_test: make boolean no_msi static
Date: Wed, 23 Aug 2017 10:47:52 +0100
Message-Id: <20170823094752.26962-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The boolean no_msi is local to the source and does not need to be in
global scope, so make it static.

Cleans up sparse warning:
symbol 'no_msi' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/pci_endpoint_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 1f64d943794d..deb203026496 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -73,7 +73,7 @@ static DEFINE_IDA(pci_endpoint_test_ida);
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
 					    miscdev)
 
-bool no_msi;
+static bool no_msi;
 module_param(no_msi, bool, 0444);
 MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
 
-- 
2.14.1
