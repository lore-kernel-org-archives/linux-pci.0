Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:49432 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081Ab3BUPxc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2013 10:53:32 -0500
Date: Thu, 21 Feb 2013 15:53:29 +0000
From: Andrew Murray <Andrew.Murray@arm.com>
To: linux-pci@vger.kernel.org
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	"jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>
Subject: [PATCH] pci: Remove unnecessary dependency between PME and ACPI.
Message-ID: <20130221155329.GA26729@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/pci/pcie/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 6c8bc58..4cccd8c 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -82,4 +82,4 @@ endchoice
 
 config PCIE_PME
 	def_bool y
-	depends on PCIEPORTBUS && PM_RUNTIME && EXPERIMENTAL && ACPI
+	depends on PCIEPORTBUS && PM_RUNTIME && EXPERIMENTAL
-- 
1.7.0.4


