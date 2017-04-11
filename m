Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:53342 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbdDKEds (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2017 00:33:48 -0400
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: kurt.schwemmer@microsemi.com, stephen.bates@microsemi.com,
        logang@deltatee.com, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] switchtec: Fix an error handling
Date: Tue, 11 Apr 2017 06:32:04 +0200
Message-Id: <20170411043204.19343-1-christophe.jaillet@wanadoo.fr>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

'stuser_create' returns an error pointer in case of error, not NULL.
So test its return value with IS_ERR.

Fixes: 74004262f329 ("MicroSemi Switchtec management interface driver")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/switch/switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index fcde98161d9a..cc6e085008fb 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -608,7 +608,7 @@ static int switchtec_dev_open(struct inode *inode, struct file *filp)
 	stdev = container_of(inode->i_cdev, struct switchtec_dev, cdev);
 
 	stuser = stuser_create(stdev);
-	if (!stuser)
+	if (IS_ERR(stuser))
 		return PTR_ERR(stuser);
 
 	filp->private_data = stuser;
-- 
2.11.0
