Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37584 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab3A0Fhe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 00:37:34 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Subject: [PATCH v2 03/22] PCI, libata: remove find_bridge in acpi_bus_type
Date: Sat, 26 Jan 2013 21:36:24 -0800
Message-Id: <1359265003-16166-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359265003-16166-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQUhrVPNKcdWbiqHLa5PzH7Dg-uduVc9BP-OjM-eCqSXdw@mail.gmail.com>
 <1359265003-16166-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The struct member is not used anymore, remove it.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org
Acked-by: Jeff Garzik <jgarzik@redhat.com>
---
 drivers/ata/libata-acpi.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index ef01ac0..7038225 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -1177,13 +1177,7 @@ static int ata_acpi_find_device(struct device *dev, acpi_handle *handle)
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
1.7.10.4

