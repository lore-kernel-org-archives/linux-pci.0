Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:17463 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbIPDMr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 23:12:47 -0400
From: Ethan Zhao <ethan.zhao@oracle.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ethan Zhao <ethan.zhao@oracle.com>
Subject: [PATCH v2] iov: restore NumVFs register to 0 before return from virtfn_max_buses()
Date: Wed, 16 Sep 2015 12:19:53 +0900
Message-Id: <1442373593-8342-1-git-send-email-ethan.zhao@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After commit 4449f079722c ("PCI: Calculate maximum number of buses
required for VFs"),the initial value of NumVFs register was left to
non-zero after sriov_init() and no VFs was enabled in device driver.
this changed the behaviour of kernel exported by lspci and sysfs etc.
so this patch restore the NumVFs register to zero after the
calculation of max_VF_buses was done and before return from
virtfn_max_buses().

Tested on stable 4.1 and passed building on stable 4.3-rc1

Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
Tested-by: Sriharsha Yadagudde <sriharsha.devdas@oracle.com>
---
v1..v2:
 -Suggestions from Bjorn Helgaas (move the restoration of NumVFs register
  to virtfn_max_buses())
---
 drivers/pci/iov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ee0ebff..92cee06 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -71,6 +71,8 @@ static inline u8 virtfn_max_buses(struct pci_dev *dev)
 			max = busnr;
 	}
 
+	/* restore NumVFs register to 0 */
+	pci_iov_set_numvfs(dev, 0);
 	return max;
 }
 
-- 
1.8.3.1

