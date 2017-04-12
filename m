Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:19027 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751992AbdDLIfv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2017 04:35:51 -0400
Date: Wed, 12 Apr 2017 11:35:25 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc: Stephen Bates <stephen.bates@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] switchtec: checking for NULL instead of IS_ERR()
Message-ID: <20170412083525.GF3250@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

stuser_create() uses error pointers, it never returns NULL.

Fixes: 74004262f329 ("MicroSemi Switchtec management interface driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

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
