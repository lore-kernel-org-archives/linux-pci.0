Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF0BC10F12
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 08:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C4D2073F
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 08:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfDQIYF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:24:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:37934 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726895AbfDQIYF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 04:24:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD87BAFED;
        Wed, 17 Apr 2019 08:24:03 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] PCI: Remove pci_request_region_exclusive()
Date:   Wed, 17 Apr 2019 10:23:56 +0200
Message-Id: <20190417082356.7054-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_request_region_exclusive() was introduced with commit e8de1481fd71
("resource: allow MMIO exclusivity for device drivers") in 2.6.29 which
was released 2008.

It never had an in tree user since then, so after 11 years later let's
remove it.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/pci/pci.c   | 25 -------------------------
 include/linux/pci.h |  1 -
 2 files changed, 26 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c1b362f599a..d185b49e105a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3706,31 +3706,6 @@ int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
 }
 EXPORT_SYMBOL(pci_request_region);
 
-/**
- *	pci_request_region_exclusive - Reserved PCI I/O and memory resource
- *	@pdev: PCI device whose resources are to be reserved
- *	@bar: BAR to be reserved
- *	@res_name: Name to be associated with resource.
- *
- *	Mark the PCI region associated with PCI device @pdev BR @bar as
- *	being reserved by owner @res_name.  Do not access any
- *	address inside the PCI regions unless this call returns
- *	successfully.
- *
- *	Returns 0 on success, or %EBUSY on error.  A warning
- *	message is also printed on failure.
- *
- *	The key difference that _exclusive makes it that userspace is
- *	explicitly not allowed to map the resource via /dev/mem or
- *	sysfs.
- */
-int pci_request_region_exclusive(struct pci_dev *pdev, int bar,
-				 const char *res_name)
-{
-	return __pci_request_region(pdev, bar, res_name, IORESOURCE_EXCLUSIVE);
-}
-EXPORT_SYMBOL(pci_request_region_exclusive);
-
 /**
  * pci_release_selected_regions - Release selected PCI I/O and memory resources
  * @pdev: PCI device whose resources were previously reserved
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 77448215ef5b..5f32275358cf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1233,7 +1233,6 @@ int __must_check pci_request_regions(struct pci_dev *, const char *);
 int __must_check pci_request_regions_exclusive(struct pci_dev *, const char *);
 void pci_release_regions(struct pci_dev *);
 int __must_check pci_request_region(struct pci_dev *, int, const char *);
-int __must_check pci_request_region_exclusive(struct pci_dev *, int, const char *);
 void pci_release_region(struct pci_dev *, int);
 int pci_request_selected_regions(struct pci_dev *, int, const char *);
 int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
-- 
2.16.4

