Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AF4C6780B
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 18:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD2A204FD
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 18:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD2A204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeJLCFl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:05:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:50095 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbeJLCFl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 22:05:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 11:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="80468705"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 11 Oct 2018 11:37:16 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 3/4] PCI/AER: Refactor error injection fallbacks
Date:   Thu, 11 Oct 2018 12:34:12 -0600
Message-Id: <20181011183413.13183-4-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181011183413.13183-1-keith.busch@intel.com>
References: <20181011183413.13183-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch just moves the bus ops fallback into separate functions. No
functional change here.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer_inject.c | 66 +++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 726987f8d53c..95d4759664b3 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -176,14 +176,48 @@ static u32 *find_pci_config_dword(struct aer_error *err, int where,
 	return target;
 }
 
+static int aer_inj_read(struct pci_bus *bus, unsigned int devfn, int where,
+			int size, u32 *val)
+{
+	struct pci_ops *ops, *my_ops;
+	int rv;
+
+	ops = __find_pci_bus_ops(bus);
+	if (!ops)
+		return -1;
+
+	my_ops = bus->ops;
+	bus->ops = ops;
+	rv = ops->read(bus, devfn, where, size, val);
+	bus->ops = my_ops;
+
+	return rv;
+}
+
+static int aer_inj_write(struct pci_bus *bus, unsigned int devfn, int where,
+			 int size, u32 val)
+{
+	struct pci_ops *ops, *my_ops;
+	int rv;
+
+	ops = __find_pci_bus_ops(bus);
+	if (!ops)
+		return -1;
+
+	my_ops = bus->ops;
+	bus->ops = ops;
+	rv = ops->write(bus, devfn, where, size, val);
+	bus->ops = my_ops;
+
+	return rv;
+}
+
 static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
 			       int where, int size, u32 *val)
 {
 	u32 *sim;
 	struct aer_error *err;
 	unsigned long flags;
-	struct pci_ops *ops;
-	struct pci_ops *my_ops;
 	int domain;
 	int rv;
 
@@ -204,18 +238,7 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
 		return 0;
 	}
 out:
-	ops = __find_pci_bus_ops(bus);
-	/*
-	 * pci_lock must already be held, so we can directly
-	 * manipulate bus->ops.  Many config access functions,
-	 * including pci_generic_config_read() require the original
-	 * bus->ops be installed to function, so temporarily put them
-	 * back.
-	 */
-	my_ops = bus->ops;
-	bus->ops = ops;
-	rv = ops->read(bus, devfn, where, size, val);
-	bus->ops = my_ops;
+	rv = aer_inj_read(bus, devfn, where, size, val);
 	spin_unlock_irqrestore(&inject_lock, flags);
 	return rv;
 }
@@ -227,8 +250,6 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 	struct aer_error *err;
 	unsigned long flags;
 	int rw1cs;
-	struct pci_ops *ops;
-	struct pci_ops *my_ops;
 	int domain;
 	int rv;
 
@@ -252,18 +273,7 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 		return 0;
 	}
 out:
-	ops = __find_pci_bus_ops(bus);
-	/*
-	 * pci_lock must already be held, so we can directly
-	 * manipulate bus->ops.  Many config access functions,
-	 * including pci_generic_config_write() require the original
-	 * bus->ops be installed to function, so temporarily put them
-	 * back.
-	 */
-	my_ops = bus->ops;
-	bus->ops = ops;
-	rv = ops->write(bus, devfn, where, size, val);
-	bus->ops = my_ops;
+	rv = aer_inj_write(bus, devfn, where, size, val);
 	spin_unlock_irqrestore(&inject_lock, flags);
 	return rv;
 }
-- 
2.14.4

