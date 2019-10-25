Return-Path: <SRS0=uEhh=YS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFF5CA9EA0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Oct 2019 13:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A16222D0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Oct 2019 13:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572011886;
	bh=47t+Nnmbk++aVQPPcj57svH35Wds3MJ6qI0wsT4LmTE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bD9gt62JR1j7PciGzY4hrT+c/QkmFtaAraQNnKYhYUtMMdztmtwgMsab6+2fx19CV
	 3xNOYuUS61WQrj/xQKUJY2mR/ye3ZUsumKKyeK7NGmqxzR6Miw6+9UreGyIt9hCvoT
	 vZLQ9lLdaFKHtTo/oEVuqqUZRcu46M4Do/ks/S64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394837AbfJYN6E (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389701AbfJYN6E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Oct 2019 09:58:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE23222C2;
        Fri, 25 Oct 2019 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572011883;
        bh=47t+Nnmbk++aVQPPcj57svH35Wds3MJ6qI0wsT4LmTE=;
        h=From:To:Cc:Subject:Date:From;
        b=1d27D0O609ZMBBRZPWFnlaMK7yVfvPh27IEOnkiVgBPpRN4yW/HQmdAO6S/tGBcmN
         +W0t6pPjDFtKM0BuJ6iRDuWIla8/5hAiIeB9beg7g9cpvy74Fb7LaKQ5WSpSNLwP1Y
         b8GygqRg/pFh6SbUaZWT6TvPHojTnpoBdCsDeH0U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Patrick Talbert <ptalbert@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 01/20] PCI/ASPM: Do not initialize link state when aspm_disabled is set
Date:   Fri, 25 Oct 2019 09:57:41 -0400
Message-Id: <20191025135801.25739-1-sashal@kernel.org>
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
index b12fe65d07f82..f69a9180c5ffd 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -581,7 +581,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	struct pcie_link_state *link;
 	int blacklist = !!pcie_aspm_sanity_check(pdev);
 
-	if (!aspm_support_enabled)
+	if (!aspm_support_enabled || aspm_disabled)
 		return;
 
 	if (pdev->link_state)
-- 
2.20.1

