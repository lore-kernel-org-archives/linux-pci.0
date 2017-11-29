Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:41736 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932138AbdK2R25 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Nov 2017 12:28:57 -0500
From: Logan Gunthorpe <logang@deltatee.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kelvin Cao <kelvin.cao@microsemi.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 29 Nov 2017 10:28:44 -0700
Message-Id: <20171129172844.21468-3-logang@deltatee.com>
In-Reply-To: <20171129172844.21468-1-logang@deltatee.com>
References: <20171129172844.21468-1-logang@deltatee.com>
Subject: [PATCH 2/2] switchtec: Add device IDs for PSX 24xG3 and PSX 48xG3
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Kelvin Cao <kelvin.cao@microsemi.com>

These are valid devices that were missing from the existing device
ID table for the Switchtec driver.

Signed-off-by: Kelvin Cao <kelvin.cao@microsemi.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Author:    Kelvin Cao <kelvin.cao@microsemi.com>
# Date:      Sat Oct 14 01:31:58 2017 +0800
#
# interactive rebase in progress; onto 4fbd8d194f06
# Last commands done (2 commands done):
#    r b63e909353b8 switchtec: Added Global Fabric Manager Server (GFMS) event.
#    r a9d2d2460138 switchtec: Add device IDs for PSX 24xG3 and PSX 48xG3
# No commands remaining.
# You are currently editing a commit while rebasing branch 'switchtec-pci-next' on '4fbd8d194f06'.
#
# Changes to be committed:
#	modified:   drivers/pci/switch/switchtec.c
#

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Author:    Kelvin Cao <kelvin.cao@microsemi.com>
# Date:      Sat Oct 14 01:31:58 2017 +0800
#
# On branch switchtec-pci-next
# Changes to be committed:
#	modified:   drivers/pci/switch/switchtec.c
#
---
 drivers/pci/switch/switchtec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 7668d270725d..a0f8373f3b5f 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1353,6 +1353,8 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
 	SWITCHTEC_PCI_DEVICE(0x8534),  //PFX 64xG3
 	SWITCHTEC_PCI_DEVICE(0x8535),  //PFX 80xG3
 	SWITCHTEC_PCI_DEVICE(0x8536),  //PFX 96xG3
+	SWITCHTEC_PCI_DEVICE(0x8541),  //PSX 24xG3
+	SWITCHTEC_PCI_DEVICE(0x8542),  //PSX 32xG3
 	SWITCHTEC_PCI_DEVICE(0x8543),  //PSX 48xG3
 	SWITCHTEC_PCI_DEVICE(0x8544),  //PSX 64xG3
 	SWITCHTEC_PCI_DEVICE(0x8545),  //PSX 80xG3
-- 
2.11.0
