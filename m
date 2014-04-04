Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ryan Desfosses <ryan@desfo.org>
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Ryan Desfosses <ryan@desfo.org>
Subject: [PATCH 2/2] pci: added space before the open parenthesis
Date: Fri,  4 Apr 2014 14:18:10 -0400
Message-Id: <1396635490-3630-1-git-send-email-ryan@desfo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

change made to resolve checkpatch.pl error

Signed-off-by: Ryan Desfosses <ryan@desfo.org>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fdbc294..56acb63 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -114,7 +114,7 @@ unsigned char pci_bus_max_busnr(struct pci_bus* bus)
 	max = bus->busn_res.end;
 	list_for_each(tmp, &bus->children) {
 		n = pci_bus_max_busnr(pci_bus_b(tmp));
-		if(n > max)
+		if (n > max)
 			max = n;
 	}
 	return max;
-- 
1.9.1

