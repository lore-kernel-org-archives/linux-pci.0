Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:34000 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbaERQCM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 18 May 2014 12:02:12 -0400
Received: by mail-ee0-f41.google.com with SMTP id t10so2931251eei.28
        for <linux-pci@vger.kernel.org>; Sun, 18 May 2014 09:02:11 -0700 (PDT)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Marta Rybczynska <rybczynska@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: hotplug: cpqphp_ctrl.c:  Fix for possible null pointer dereference
Date: Sun, 18 May 2014 18:02:57 +0200
Message-Id: <1400428977-10464-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is otherwise a risk of a possible null pointer dereference.

Was largely found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/pci/hotplug/cpqphp_ctrl.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
index 11845b7..a319d07 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -709,7 +709,8 @@ static struct pci_resource *get_max_resource(struct pci_resource **head, u32 siz
 				temp = temp->next;
 			}
 
-			temp->next = max->next;
+			if(temp)
+				temp->next = max->next;
 		}
 
 		max->next = NULL;
-- 
1.7.10.4

