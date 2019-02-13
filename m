Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ED8C282C4
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 02:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876FB21934
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 02:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026300;
	bh=maKmdX1RRYrfiRTEpEPGl+XrlyWmoxc5oidzyeFqGGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Re+BDgrI8IJcgxAh8EsvKGnXrMmgyDbaoX2OgBMiBR1AdpO/SUGurMP9eBdjUL2R0
	 7l52ehoKFDh324cd4jynQgIqyVgmWdKq747L7CyfVBNBTKHEdKKvqL7UzPMhBFtUUm
	 Mx4ks8HB/cc8D0URiqSOA2NwI8+pvvHUfyVlODIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfBMCjW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:39:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388661AbfBMCjV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Feb 2019 21:39:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3BA6222C9;
        Wed, 13 Feb 2019 02:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025560;
        bh=maKmdX1RRYrfiRTEpEPGl+XrlyWmoxc5oidzyeFqGGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O+SPzG52FMpzeoM42MSRuDp/tbi7gekiCRi6n6k83prLmwaAaMSuSSqOV4I3Rpt+0
         0HkcTtKeJwmPE7twC3Oxq06t+cAvhkH1tukJ7WRk7dQW4bN83H3Ra5mRRnL9PZcWca
         c9bQKUfGYkqYQqvX5LyzvSB/X4Biv50hF+VSL3rA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 67/83] PCI: Fix __initdata issue with "pci=disable_acs_redir" parameter
Date:   Tue, 12 Feb 2019 21:36:45 -0500
Message-Id: <20190213023701.20286-67-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit d2fd6e81912a665993b24dcdc1c1384a42a54f7e ]

The disable_acs_redir parameter stores a pointer to the string passed to
pci_setup().  However, the string passed to PCI setup is actually a
temporary copy allocated in static __initdata memory.  After init, once the
memory is freed, it is no longer valid to reference this pointer.

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

To fix this, instead of storing a pointer, we use kstrdup() to copy the
disable_acs_redir_param to its own buffer which will never be freed.

Fixes: aaca43fda742 ("PCI: Add "pci=disable_acs_redir=" parameter for peer-to-peer support")
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index afc4680c584f..7eb1549cea81 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6113,7 +6113,8 @@ static int __init pci_setup(char *str)
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
2.19.1

