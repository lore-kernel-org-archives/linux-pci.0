Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95930C169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 17:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCD020855
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 17:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfBHRAa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:00:30 -0500
Received: from ale.deltatee.com ([207.54.116.67]:33674 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfBHRAa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 12:00:30 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gs9Vt-0005Ua-8G; Fri, 08 Feb 2019 10:00:30 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gs9Vt-0005QN-3p; Fri, 08 Feb 2019 10:00:29 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Date:   Fri,  8 Feb 2019 09:54:39 -0700
Message-Id: <20190208165439.19503-2-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190208165439.19503-1-logang@deltatee.com>
References: <20190208165439.19503-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, logang@deltatee.com, helgaas@kernel.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 2/2] PCI: Clean up usage of __u32 type
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The double underscore types are meant for compatibility in userspace
headers which does not apply here. Therefore, change to use the
standard no-underscore types.

The origin of the double underscore types dates back to before the
git era so I was not able to find a commit to see the original
justification.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
---
 drivers/pci/pci-driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 79b1610a8beb..71853befd435 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -100,7 +100,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 {
 	struct pci_driver *pdrv = to_pci_driver(driver);
 	const struct pci_device_id *ids = pdrv->id_table;
-	__u32 vendor, device, subvendor = PCI_ANY_ID,
+	u32 vendor, device, subvendor = PCI_ANY_ID,
 		subdevice = PCI_ANY_ID, class = 0, class_mask = 0;
 	unsigned long driver_data = 0;
 	int fields = 0;
@@ -168,7 +168,7 @@ static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
 {
 	struct pci_dynid *dynid, *n;
 	struct pci_driver *pdrv = to_pci_driver(driver);
-	__u32 vendor, device, subvendor = PCI_ANY_ID,
+	u32 vendor, device, subvendor = PCI_ANY_ID,
 		subdevice = PCI_ANY_ID, class = 0, class_mask = 0;
 	int fields = 0;
 	size_t retval = -ENODEV;
-- 
2.19.0

