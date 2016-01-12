Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33808 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbcALOW3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2016 09:22:29 -0500
From: Bogicevic Sasa <brutallesale@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bogicevic Sasa <brutallesale@gmail.com>
Subject: [PATCH] drivers:pci Add pcie/Kconfig to pci/Kconfig
Date: Tue, 12 Jan 2016 06:22:25 -0800
Message-Id: <1452608545-32242-1-git-send-email-brutallesale@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Architectures currently have to include both
drivers/pci/Kconfig and drivers/pci/pcie/Kconfig.
They should include only drivers/pci/Kconfig, and
that should handle PCIe as well.

Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
---
 drivers/pci/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 73de4ef..005dd7d 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -119,3 +119,5 @@ config PCI_LABEL
 	select NLS
 
 source "drivers/pci/host/Kconfig"
+
+source "drivers/pci/pcie/Kconfig"
-- 
2.5.0

