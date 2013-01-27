Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:32287 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313Ab3A0TYQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 14:24:16 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Subject: [PATCH v3 03/22] PCI, libata: remove find_bridge in acpi_bus_type
Date: Sun, 27 Jan 2013 11:23:30 -0800
Message-Id: <1359314629-18651-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
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

