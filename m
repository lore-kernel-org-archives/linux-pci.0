Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f74.google.com ([209.85.216.74]:59345 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114Ab2EHXqR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 May 2012 19:46:17 -0400
Received: by qabg24 with SMTP id g24so187554qab.1
        for <linux-pci@vger.kernel.org>; Tue, 08 May 2012 16:46:16 -0700 (PDT)
Subject: [PATCH 3/3] PCI/AER: use pci_is_pcie() instead of obsolete
	pci_dev.is_pcie
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Huang Ying <ying.huang@intel.com>
Date: Tue, 08 May 2012 17:46:16 -0600
Message-ID: <20120508234616.2085.64127.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120508234605.2085.32267.stgit@bhelgaas.mtv.corp.google.com>
References: <20120508234605.2085.32267.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use pci_is_pcie() instead of looking at obsolete is_pcie field in
struct pci_dev.

CC: Huang Ying <ying.huang@intel.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aerdrv_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_acpi.c b/drivers/pci/pcie/aer/aerdrv_acpi.c
index 275bf15..124f20f 100644
--- a/drivers/pci/pcie/aer/aerdrv_acpi.c
+++ b/drivers/pci/pcie/aer/aerdrv_acpi.c
@@ -59,7 +59,7 @@ static int aer_hest_parse(struct acpi_hest_header *hest_hdr, void *data)
 
 	p = (struct acpi_hest_aer_common *)(hest_hdr + 1);
 	if (p->flags & ACPI_HEST_GLOBAL) {
-		if ((info->pci_dev->is_pcie &&
+		if ((pci_is_pcie(info->pci_dev) &&
 		     info->pci_dev->pcie_type == pcie_type) || bridge)
 			ff = !!(p->flags & ACPI_HEST_FIRMWARE_FIRST);
 	} else

