Return-Path: <SRS0=uEhh=YS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81893CA9EA0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Oct 2019 14:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D13E222BE
	for <linux-pci@archiver.kernel.org>; Fri, 25 Oct 2019 14:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572012333;
	bh=c0TQ9TU8D9mzimPcnMDQ6JW2zlHSnWl8KaABvWCTNr0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lito8UXhxRoQg8Cna2KteK2LcAWcnyIQkMef8MJlv1EVgIAkqsgKZe6qvG6sB96jR
	 lFK6pz8ibVLsu69sOho80UXu7PmuietmE9BOpC0IgUa2o4J2IAkM9tE9cYmGfgKq2x
	 Y4lMCgXmzr6giDukDX1aoYorgwWEmTv6DkZbNEh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505236AbfJYN4H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2632773AbfJYN4F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Oct 2019 09:56:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 747FB2084C;
        Fri, 25 Oct 2019 13:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572011765;
        bh=c0TQ9TU8D9mzimPcnMDQ6JW2zlHSnWl8KaABvWCTNr0=;
        h=From:To:Cc:Subject:Date:From;
        b=GMcrN1P4H7MIZdZC/VJOwpK7qwW2IyFb8BUyraLaqo7e47gQgjNDg/Bm/BYpt6isW
         MXneFBSL3bzvpajNKazOsG4U6Vwd+CVuVicrYwJEmPB+FMO7iJiZyFg07LUaCQBaRx
         S9r1A2Nlww1+ZBeWPuqYdiar4EeuLKX3mjljirCI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Patrick Talbert <ptalbert@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/37] PCI/ASPM: Do not initialize link state when aspm_disabled is set
Date:   Fri, 25 Oct 2019 09:55:25 -0400
Message-Id: <20191025135603.25093-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Patrick Talbert <ptalbert@redhat.com>

[ Upstream commit 17c91487364fb33797ed84022564ee7544ac4945 ]

Now that ASPM is configured for *all* PCIe devices at boot, a problem is
seen with systems that set the FADT NO_ASPM bit.  This bit indicates that
the OS should not alter the ASPM state, but when
pcie_aspm_init_link_state() runs it only checks for !aspm_support_enabled.
This misses the ACPI_FADT_NO_ASPM case because that is setting
aspm_disabled.

The result is systems may hang at boot after 1302fcf; avoidable if they
boot with pcie_aspm=off (sets !aspm_support_enabled).

Fix this by having aspm_init_link_state() check for either
!aspm_support_enabled or acpm_disabled.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=201001
Fixes: 1302fcf0d03e ("PCI: Configure *all* devices, not just hot-added ones")
Signed-off-by: Patrick Talbert <ptalbert@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1117b25fbe0bb..ce218b32724db 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -912,7 +912,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	struct pcie_link_state *link;
 	int blacklist = !!pcie_aspm_sanity_check(pdev);
 
-	if (!aspm_support_enabled)
+	if (!aspm_support_enabled || aspm_disabled)
 		return;
 
 	if (pdev->link_state)
-- 
2.20.1

