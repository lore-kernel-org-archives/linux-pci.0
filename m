Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0049.outbound.protection.outlook.com ([104.47.33.49]:6512
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751011AbdCQHQm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Mar 2017 03:16:42 -0400
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From: Manish Jaggi <mjaggi@caviumnetworks.com>
Subject: [PATCH] pci: quirk cavium: Add device ID range check
Cc: Alex Williamson <alex.williamson@redhat.com>,
        "Daney, David" <David.Daney@cavium.com>, bhelgaas@google.com
Message-ID: <43ff1f3f-b098-f25d-b9dc-9e8ef2278110@caviumnetworks.com>
Date: Fri, 17 Mar 2017 12:46:29 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  ACS quirk applies to devices with ID in the range a000-a0XX.
  The patch adds a check.This matches on-chip pci devices for
  CN81xx/CN83xx/CN88xx

  This patch adds check to
  b404bcfbf0 : PCI: Add ACS quirk for all Cavium devices

Signed-off-by: Manish Jaggi <mjaggi@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
  drivers/pci/quirks.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f754453..178242d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4094,6 +4094,9 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
  	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
  		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
  
+	if (!((dev->device >= 0xa000) && (dev->device <= 0xa0ff)))
+		return -ENOTTY;
+
  	return acs_flags ? 0 : 1;
  }
  
-- 
2.7.4
