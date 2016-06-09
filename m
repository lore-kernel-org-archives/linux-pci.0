Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246]:57782 "EHLO
	rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751153AbcFIKmR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2016 06:42:17 -0400
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pci: make bus_attr_resource_alignemnt static
Date: Thu,  9 Jun 2016 11:42:13 +0100
Message-Id: <1465468933-6922-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The symbol bus_attr_resource_alignment is not exported or declared
elsewhere, so make it static to fix the following warning:

drivers/pci/pci.c:4900:1: warning: symbol 'bus_attr_resource_alignment' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c8b4dbd..9add285 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4897,7 +4897,7 @@ static ssize_t pci_resource_alignment_store(struct bus_type *bus,
 	return pci_set_resource_alignment_param(buf, count);
 }
 
-BUS_ATTR(resource_alignment, 0644, pci_resource_alignment_show,
+static BUS_ATTR(resource_alignment, 0644, pci_resource_alignment_show,
 					pci_resource_alignment_store);
 
 static int __init pci_resource_alignment_sysfs_init(void)
-- 
2.8.1

