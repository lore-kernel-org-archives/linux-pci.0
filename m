Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753066AbcK2SBE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2016 13:01:04 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uATHwuGx103773
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2016 13:01:03 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0b-001b2d01.pphosted.com with ESMTP id 271a7vsj31-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2016 13:01:02 -0500
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <mrochs@linux.vnet.ibm.com>;
        Tue, 29 Nov 2016 13:01:02 -0500
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Subject: [PATCH] PCI: Increase VPD access timeout
Date: Tue, 29 Nov 2016 12:00:40 -0600
Message-Id: <1480442440-11540-1-git-send-email-mrochs@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI core uses a fixed 50ms timeout when waiting for VPD accesses to
complete. When an access does not complete within this period, a warning
is logged and an error returned to the caller.

While this default timeout is valid for most hardware, some devices can
experience longer access delays under certain circumstances. For example,
one of the IBM CXL Flash devices can take up to ~120ms in a worst-case
scenario. These types of devices can benefit from an extended timeout.

To support devices with a longer access delay, increase the timeout in
pci_vpd_wait() to 125ms. The PCI specification is silent with respect to
VPD delays, therefore there is no concern for violating a threshold.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/pci/access.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index d11cdbb..61b5a6b 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -355,7 +355,7 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 static int pci_vpd_wait(struct pci_dev *dev)
 {
 	struct pci_vpd *vpd = dev->vpd;
-	unsigned long timeout = jiffies + msecs_to_jiffies(50);
+	unsigned long timeout = jiffies + msecs_to_jiffies(125);
 	unsigned long max_sleep = 16;
 	u16 status;
 	int ret;
-- 
2.1.0

