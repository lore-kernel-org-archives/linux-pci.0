Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2DBC43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 17:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A649E20675
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 17:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfAORcI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:32:08 -0500
Received: from ale.deltatee.com ([207.54.116.67]:53146 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfAORcH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jan 2019 12:32:07 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gjSZK-0000Ss-Fh; Tue, 15 Jan 2019 10:32:07 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gjSZJ-0003sE-TW; Tue, 15 Jan 2019 10:32:05 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date:   Tue, 15 Jan 2019 10:32:03 -0700
Message-Id: <20190115173203.14850-1-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, sbates@raithlin.com, logang@deltatee.com, jarkko.nikula@linux.intel.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] PCI: fix using __initdata memory after free in disable_acs_redir parameter
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The disable_acs_redir parameter stores a pointer to the string passed to
pci_setup(). However, the string passed to PCI setup is actually a
temporary copy allocated in static __initdata memory. After init, once
the memory is freed, it is no longer valid to reference this pointer.

This bug was noticed in v5.0-rc1 after a change in commit c5eb1190074c
("PCI / PM: Allow runtime PM without callback functions") caused
pci_disable_acs_redir() to be called during shutdown which manifested
as an unable to handle kernel paging request at:

RIP: 0010:pci_enable_acs+0x3f/0x1e0
Call Trace:
   pci_restore_state.part.44+0x159/0x3c0
   pci_restore_standard_config+0x33/0x40
   pci_pm_runtime_resume+0x2b/0xd0
   ? pci_restore_standard_config+0x40/0x40
   __rpm_callback+0xbc/0x1b0
   rpm_callback+0x1f/0x70
   ? pci_restore_standard_config+0x40/0x40
    rpm_resume+0x4f9/0x710
   ? pci_conf1_read+0xb6/0xf0
   ? pci_conf1_write+0xb2/0xe0
   __pm_runtime_resume+0x47/0x70
   pci_device_shutdown+0x1e/0x60
   device_shutdown+0x14a/0x1f0
   kernel_restart+0xe/0x50
   __do_sys_reboot+0x1ee/0x210
   ? __fput+0x144/0x1d0
   do_writev+0x5e/0xf0
   ? do_writev+0x5e/0xf0
   do_syscall_64+0x48/0xf0
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

It was also likely possible to trigger this bug when hotplugging PCI
devices.

To fix this, instead of storing a pointer, we use kstrdup to copy the
disable_acs_redir_param to its own buffer which will never be freed.

Fixes: aaca43fda742 ("PCI: Add "pci=disable_acs_redir=" parameter for peer-to-peer support")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c9d8e3c837de..c25acace7d91 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6195,7 +6195,8 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "pcie_scan_all", 13)) {
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
-				disable_acs_redir_param = str + 18;
+				disable_acs_redir_param =
+					kstrdup(str + 18, GFP_KERNEL);
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
-- 
2.19.0

