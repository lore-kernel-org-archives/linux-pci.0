Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [12.32.117.8] ([12.32.117.8]:59743 "EHLO
	stargate3.asicdesigners.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750723AbcFYEEi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 Jun 2016 00:04:38 -0400
From: Hariprasad Shenai <hariprasad@chelsio.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, leedom@chelsio.com,
	swise@opengridcomputing.com,
	Hariprasad Shenai <hariprasad@chelsio.com>
Subject: [PATCH] pci: Use same logic in pci_vpd_read as that of pci_vpd_write
Date: Sat, 25 Jun 2016 09:38:42 +0530
Message-Id: <1466827722-17287-1-git-send-email-hariprasad@chelsio.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The new implementation of pci_read_vpd() silently fails to perform a VPD
read and allows the caller to use random stack garbage in the read buffer
without knowing that it's not really VPD contents. If any portion of the
VPD read isn't going to be performed, we should signal that back to the
caller.  We could either return an error or we could return the number of
bytes actually read. The problem with the latter is that it would require
changing every single caller to check for Requested Read Length == Actual
Read Length. Returning an error is the more conservative fix and allows
for rapid diagnosis of problems.

Signed-off-by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Hariprasad Shenai <hariprasad@chelsio.com>
---
 drivers/pci/access.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index d11cdbb8fba3..113637de79bf 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -405,13 +405,8 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 	if (vpd->len == 0)
 		return -EIO;
 
-	if (pos > vpd->len)
-		return 0;
-
-	if (end > vpd->len) {
-		end = vpd->len;
-		count = end - pos;
-	}
+	if (end > vpd->len)
+		return -EINVAL;
 
 	if (mutex_lock_killable(&vpd->lock))
 		return -EINTR;
-- 
2.3.4

