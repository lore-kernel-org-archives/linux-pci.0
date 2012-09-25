Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:42795 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab2IYI0n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:43 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Subject: [PATCH 09/29] PCI, libata: remove find_bridge in acpi_bus_type
Date: Tue, 25 Sep 2012 01:26:10 -0700
Message-Id: <1348561590-28067-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The struct member is not used anymore, remove it.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/libata-acpi.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index fd9ecf7..48976fe 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -1168,13 +1168,7 @@ static int ata_acpi_find_device(struct device *dev, acpi_handle *handle)
 		return -ENODEV;
 }
 
-static int ata_acpi_find_dummy(struct device *dev, acpi_handle *handle)
-{
-	return -ENODEV;
-}
-
 static struct acpi_bus_type ata_acpi_bus = {
-	.find_bridge = ata_acpi_find_dummy,
 	.find_device = ata_acpi_find_device,
 };
 
-- 
1.7.7

