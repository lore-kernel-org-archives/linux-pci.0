Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:59443 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752081Ab2JRCX6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Oct 2012 22:23:58 -0400
From: Tang Chen <tangchen@cn.fujitsu.com>
To: bhelgaas@google.com, lenb@kernel.org, yinghai@kernel.org,
	jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Add PNP0A08 into acpi_pci_roots array.
Date: Thu, 18 Oct 2012 10:22:51 +0800
Message-Id: <1350526971-9427-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

acpi_pci_roots array doesn't include PNP0A08, which is PCI Express
Root Bridge.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 drivers/acpi/pci_root.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 037b59c..dedc4d6 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -56,6 +56,7 @@ static int acpi_pci_root_start(struct acpi_device *device);
 
 static const struct acpi_device_id root_device_ids[] = {
 	{"PNP0A03", 0},
+	{"PNP0A08", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, root_device_ids);
-- 
1.7.1

