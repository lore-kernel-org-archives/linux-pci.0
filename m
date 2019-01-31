Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2864CC169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC42218EA
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fjkfqGEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbfAaSRP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:17:15 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:57860 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfAaSRP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 13:17:15 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 7AD1410C13C7;
        Thu, 31 Jan 2019 10:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548958634; bh=UqvLG9OQZ79DixK5JOz7MF9SE5+rfluURdrFg1g9olU=;
        h=From:To:Cc:Subject:Date:From;
        b=fjkfqGEec0n3SoactilpvvRxlSXtkxxTndmXc1HC9fdjwW4eVVVGQ//C44c9LWE7q
         Rx8v8NiuwmwOFi/x33iGXfs2SkEb44KVFo3m9q1B7CjAHntbyYTSkEDJgll3i8Q8uE
         RXDRySHbnalhQ1LnvA77W740pjy9UwgHqCOBb4Cj2uirBpCLYSf41zqoKh7VcAWCjX
         CK1vPTBStlFvnc+3SAAFQoRQ5nc/SDoyi6j54Kz7aZLYJ8aJ7jjBzxbHZNgDF+LMNP
         jXCPT4NL58cQoRybDs+4gEuW9JGy683VBkO0ZVSB3LFVS3/ij0cfdN6hlthaDXzEdS
         2H1kwLXhuMaiw==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 43C8FA0098;
        Thu, 31 Jan 2019 18:17:14 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 77BA33CED0;
        Thu, 31 Jan 2019 19:17:13 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH v2 0/8] Improve Synopsys DesignWare Root Complex driver code
Date:   Thu, 31 Jan 2019 19:16:59 +0100
Message-Id: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series aims to improve Synopsys DesignWare Root Complex driver
code by:
 - removing unnecessary header files
 - enforcing variable naming coherency among similar functions
 - simplifing code readability of mask/unmask function operations
 - replacing bit rotation operation (1 << bit) by BIT(bit)

No functional changes are intended.

All patches are independent so they can be easily analyzed and accepted or
discarded.

This patches organization also allows to easily merge (squash) some patches,
if desired.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>

Gustavo Pimentel (8):
  PCI: dwc: Remove unnecessary header include (of_gpio.h)
  PCI: dwc: Remove unnecessary header include (signal.h)
  PCI: dwc: Rename variable name from data to d on
    dw_pci_bottom_mask/unmask()
  PCI: dwc: Rename variable name from data to d on
    dw_pci_setup_msi_msg()
  PCI: dwc: Rename variable name from data to d on
    dw_pci_msi_set_affinity()
  PCI: dwc: Rename variable name from data to d on
    dw_pcie_irq_domain_free()
  PCI: dwc: Improve code readability and simplifies mask/unmask
    operations
  PCI: dwc: Replace bit rotation operation (1 << bit) by BIT(bit)

 drivers/pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++------------
 drivers/pci/controller/dwc/pcie-designware-plat.c |  2 -
 drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
 3 files changed, 27 insertions(+), 29 deletions(-)

-- 
2.7.4

