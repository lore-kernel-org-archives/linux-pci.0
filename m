Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B89C4361A
	for <linux-pci@archiver.kernel.org>; Thu,  3 Dec 2020 18:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E32207B8
	for <linux-pci@archiver.kernel.org>; Thu,  3 Dec 2020 18:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgLCSwA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Dec 2020 13:52:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgLCSwA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 13:52:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Kishore <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 0/3] PCI/MSI: Cleanup init and improve 32-bit MSI checking
Date:   Thu,  3 Dec 2020 12:51:07 -0600
Message-Id: <20201203185110.1583077-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

MSI/MSI-X init was a little unconventional.  We had pci_msi_setup_pci_dev()
to disable MSI and MSI-X, in probe.c instead of msi.c so we could do it
even without CONFIG_PCI_MSI.  Move that to msi.c and fix the config issue
with an #ifdef.

Then add Vidya's patch on top.  Previous postings at

https://lore.kernel.org/linux-pci/20201117145728.4516-1-vidyas@nvidia.com/
https://lore.kernel.org/linux-pci/20201124105035.24573-1-vidyas@nvidia.com/

Bjorn Helgaas (2):
  PCI/MSI: Move MSI/MSI-X init to msi.c
  PCI/MSI: Move MSI/MSI-X flags updaters to msi.c

Vidya Sagar (1):
  PCI/MSI: Set device flag indicating only 32-bit MSI support

 drivers/pci/Makefile |  3 +-
 drivers/pci/msi.c    | 70 ++++++++++++++++++++++++++++++++++++++++----
 drivers/pci/pci.h    | 23 ++-------------
 drivers/pci/probe.c  | 21 ++-----------
 4 files changed, 70 insertions(+), 47 deletions(-)

-- 
2.25.1

