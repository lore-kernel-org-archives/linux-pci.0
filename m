Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A27C4360F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2794120830
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9BwWhhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfCYWK0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:26 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:56953 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730889AbfCYWKZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 18:10:25 -0400
Received: by mail-ua1-f73.google.com with SMTP id z31so477514uac.23
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2019 15:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5YTphNCZAMpEXxUv7rOxGetCpK0M7qq91rW7GzRAqO4=;
        b=W9BwWhhEk3R9kt9oYI4KanwoednXfPb3X+Yi6Dt+Nylfbq+ckM0NYWhPN6lcqRHtsy
         9q7/RIgxD9eUug1W9CSmnVU3ZqOeo8hO7yARqNknkUxa12HmTFKKHfv3L9813irQS/l1
         8GDnk8wMkQk4BFb3K2iIxXEbzphn1Uc9ullAkkMqIv2vP4KiH/ij5Ycgu0kkcfPsdowj
         Ca3PcotEOk1XWjCcZWRdKc6GRA9wVXrQlpkI9MUpz/sAYxBEJomW2EYBxc2smbvEkxtd
         CFHMc18928CoBKgH9zFhL5iznVkC7KOVPVm3dFRwVvZo/y8nCvHyQGefvJRQCUDmmDbY
         0itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5YTphNCZAMpEXxUv7rOxGetCpK0M7qq91rW7GzRAqO4=;
        b=YWOa9xxKq42bk1zPm9ecPINRiHPXiMzCwR75BkVRU2NNNW395P4Ec7JHQFQUws/otg
         F9iF08IS0z26IRGhRYanVSV6T/7NsHV7IT3jW1ijIsoIa7OP4e5HY5vSucS9NLv1hvb0
         oDdYPamg0NcuPahao+TM0Hmrbo767l8QhrhqQ+rQWslIp5ONelO3qz1wwdC23W8Lqzr5
         6wfAm1VSevTxpgQNaTbf4cUoNC7VtfKz1uTBDP1/++ZycbsDE1F6FNcP/qziUy3ORtHh
         rPa076icXAcBfQtkLXaYen094jt9fNqy9kbgUwz2Dfo+Xnj/GjCKWjTN3LHtujvltmxB
         nSfQ==
X-Gm-Message-State: APjAAAXsKFMWTdyD/Anoz0s8uKdHIsSQq0bvAW5uh963DWgrhvagQnMZ
        5/8PeDJCtBcWaegR8SS2ONpx8Bypwav51Lye0C679w==
X-Google-Smtp-Source: APXvYqyzu5YW23qFSwxQFEBET1+I50UyXTTqBzSetMilQACx2b/chaObguWIQJwc91+CoxdOnaCeEQxy/5kxawWHpIRqTA==
X-Received: by 2002:a1f:b587:: with SMTP id e129mr15961378vkf.23.1553551823984;
 Mon, 25 Mar 2019 15:10:23 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:37 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 10/27] PCI: Lock down BAR access when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Any hardware that can potentially generate DMA has to be locked down in
order to avoid it being possible for an attacker to modify kernel code,
allowing them to circumvent disabled module loading or module signing.
Default to paranoid - in future we can potentially relax this for
sufficiently IOMMU-isolated devices.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/pci/pci-sysfs.c | 9 +++++++++
 drivers/pci/proc.c      | 9 ++++++++-
 drivers/pci/syscall.c   | 3 ++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ecfe13157c0..40c14574fcf8 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -905,6 +905,9 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 	loff_t init_off = off;
 	u8 *data = (u8 *) buf;
 
+	if (kernel_is_locked_down("Direct PCI access"))
+		return -EPERM;
+
 	if (off > dev->cfg_size)
 		return 0;
 	if (off + count > dev->cfg_size) {
@@ -1167,6 +1170,9 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	enum pci_mmap_state mmap_type;
 	struct resource *res = &pdev->resource[bar];
 
+	if (kernel_is_locked_down("Direct PCI access"))
+		return -EPERM;
+
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
@@ -1242,6 +1248,9 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 				     struct bin_attribute *attr, char *buf,
 				     loff_t off, size_t count)
 {
+	if (kernel_is_locked_down("Direct PCI access"))
+		return -EPERM;
+
 	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
 }
 
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 6fa1627ce08d..1549cdd0710e 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -117,6 +117,9 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	int size = dev->cfg_size;
 	int cnt;
 
+	if (kernel_is_locked_down("Direct PCI access"))
+		return -EPERM;
+
 	if (pos >= size)
 		return 0;
 	if (nbytes >= size)
@@ -196,6 +199,9 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 #endif /* HAVE_PCI_MMAP */
 	int ret = 0;
 
+	if (kernel_is_locked_down("Direct PCI access"))
+		return -EPERM;
+
 	switch (cmd) {
 	case PCIIOC_CONTROLLER:
 		ret = pci_domain_nr(dev->bus);
@@ -237,7 +243,8 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 	struct pci_filp_private *fpriv = file->private_data;
 	int i, ret, write_combine = 0, res_bit = IORESOURCE_MEM;
 
-	if (!capable(CAP_SYS_RAWIO))
+	if (!capable(CAP_SYS_RAWIO) ||
+	    kernel_is_locked_down("Direct PCI access"))
 		return -EPERM;
 
 	if (fpriv->mmap_state == pci_mmap_io) {
diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index d96626c614f5..b8a08d3166a1 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -90,7 +90,8 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 	u32 dword;
 	int err = 0;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_ADMIN) ||
+	    kernel_is_locked_down("Direct PCI access"))
 		return -EPERM;
 
 	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
-- 
2.21.0.392.gf8f6787159e-goog

