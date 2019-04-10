Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4237C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD2220818
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDJVFo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:05:44 -0400
Received: from ale.deltatee.com ([207.54.116.67]:49426 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfDJVFf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 17:05:35 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hEKPV-0000k1-TT; Wed, 10 Apr 2019 15:05:34 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hEKPV-0001C1-GW; Wed, 10 Apr 2019 15:05:33 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 10 Apr 2019 15:05:32 -0600
Message-Id: <20190410210532.4538-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410210532.4538-1-logang@deltatee.com>
References: <20190410210532.4538-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 2/2] PCI: Clean up resource_alignment parameter to not require static buffer
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Clean up the 'resource_alignment' parameter code to use kstrdup
in the initcall routine instead of a static buffer that wastes memory
regardless of whether the feature is used. This allows us to drop
'COMMAND_LINE_SIZE' bytes (typically 256-4096 depending on architecture)
of static data.

This is similar to what has been done for the 'disable_acs_redir'
parameter.

This conversion also allows us to use RCU instead of the spinlock to
deal with the concurrency issue which further reduces memory usage.

As part of the clean up we also squash pci_get_resource_alignment_param()
into resource_alignment_show() and pci_set_resource_alignment_param()
into resource_alignment_store() seeing these functions only had one
caller and the show/store wrappers were needlessly thin.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 89 ++++++++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 766f5779db92..13767c2409ae 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5896,9 +5896,7 @@ resource_size_t __weak pcibios_default_alignment(void)
 	return 0;
 }
 
-#define RESOURCE_ALIGNMENT_PARAM_SIZE COMMAND_LINE_SIZE
-static char resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
-static DEFINE_SPINLOCK(resource_alignment_lock);
+static const char __rcu *resource_alignment_param;
 
 /**
  * pci_specified_resource_alignment - get resource alignment specified by user.
@@ -5916,9 +5914,9 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 	const char *p;
 	int ret;
 
-	spin_lock(&resource_alignment_lock);
-	p = resource_alignment_param;
-	if (!*p && !align)
+	rcu_read_lock();
+	p = rcu_dereference(resource_alignment_param);
+	if (!p)
 		goto out;
 	if (pci_has_flag(PCI_PROBE_ONLY)) {
 		align = 0;
@@ -5956,7 +5954,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 		p++;
 	}
 out:
-	spin_unlock(&resource_alignment_lock);
+	rcu_read_unlock();
 	return align;
 }
 
@@ -6082,35 +6080,48 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	}
 }
 
-static ssize_t pci_set_resource_alignment_param(const char *buf, size_t count)
+static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
 {
-	if (count > RESOURCE_ALIGNMENT_PARAM_SIZE - 1)
-		count = RESOURCE_ALIGNMENT_PARAM_SIZE - 1;
-	spin_lock(&resource_alignment_lock);
-	strncpy(resource_alignment_param, buf, count);
-	resource_alignment_param[count] = '\0';
-	spin_unlock(&resource_alignment_lock);
-	return count;
-}
+	const char *p;
+	size_t count = 0;
 
-static ssize_t pci_get_resource_alignment_param(char *buf, size_t size)
-{
-	size_t count;
-	spin_lock(&resource_alignment_lock);
-	count = snprintf(buf, size, "%s", resource_alignment_param);
-	spin_unlock(&resource_alignment_lock);
-	return count;
-}
+	rcu_read_lock();
+	p = rcu_dereference(resource_alignment_param);
+	if (!p)
+		goto out;
 
-static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
-{
-	return pci_get_resource_alignment_param(buf, PAGE_SIZE);
+	count = snprintf(buf, PAGE_SIZE, "%s", p);
+
+	/*
+	 * When set by the command line there will not be a
+	 * line feed, which is ugly. So conditionally add it here.
+	 */
+	if (buf[count - 2] != '\n' && count < PAGE_SIZE - 1) {
+		buf[count - 1] = '\n';
+		buf[count++] = 0;
+	}
+
+out:
+	rcu_read_unlock();
+
+	return count;
 }
 
 static ssize_t resource_alignment_store(struct bus_type *bus,
 					const char *buf, size_t count)
 {
-	return pci_set_resource_alignment_param(buf, count);
+	const char *p, *old;
+
+	p = kstrndup(buf, count, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	old = rcu_dereference_protected(resource_alignment_param, 1);
+	rcu_assign_pointer(resource_alignment_param, p);
+	synchronize_rcu();
+	kfree(old);
+
+	return count;
 }
 
 static BUS_ATTR_RW(resource_alignment);
@@ -6238,8 +6249,8 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "cbmemsize=", 10)) {
 				pci_cardbus_mem_size = memparse(str + 10, &str);
 			} else if (!strncmp(str, "resource_alignment=", 19)) {
-				pci_set_resource_alignment_param(str + 19,
-							strlen(str + 19));
+				RCU_INIT_POINTER(resource_alignment_param,
+						 str + 19);
 			} else if (!strncmp(str, "ecrc=", 5)) {
 				pcie_ecrc_get_policy(str + 5);
 			} else if (!strncmp(str, "hpiosize=", 9)) {
@@ -6275,15 +6286,21 @@ static int __init pci_setup(char *str)
 early_param("pci", pci_setup);
 
 /*
- * 'disable_acs_redir_param' is initialized in pci_setup(), above, to point
- * to data in the __initdata section which will be freed after the init
- * sequence is complete. We can't allocate memory in pci_setup() because some
- * architectures do not have any memory allocation service available during
- * an early_param() call. So we allocate memory and copy the variable here
- * before the init section is freed.
+ * 'resource_alignment_param' and 'disable_acs_redir_param' are initialized
+ * in pci_setup(), above, to point to data in the __initdata section which
+ * will be freed after the init sequence is complete. We can't allocate memory
+ * in pci_setup() because some architectures do not have any memory allocation
+ * service available during an early_param() call. So we allocate memory and
+ * copy the variable here before the init section is freed.
  */
 static int __init pci_realloc_setup_params(void)
 {
+	const char *p;
+
+	p = rcu_dereference_protected(resource_alignment_param, 1);
+	p = kstrdup(p, GFP_KERNEL);
+	rcu_assign_pointer(resource_alignment_param, p);
+
 	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
 
 	return 0;
-- 
2.20.1

