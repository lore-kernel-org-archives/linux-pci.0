Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B157C43387
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FF420840
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PY+XkWVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389379AbfAPKO1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:14:27 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:45148 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389058AbfAPKO1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jan 2019 05:14:27 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 066F524E01D3;
        Wed, 16 Jan 2019 02:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547633667; bh=mhV+cLD3NGvx9nOyU7Wt24ucdYSjveRtOCBnfu6azG4=;
        h=From:To:Cc:Subject:Date:From;
        b=PY+XkWVP0iQvDkUWb/laEaE2gWHHjDMPHdD/Tn8uXm/yeStjLVKf6Un2NN0kf/gEK
         PWj2qqsgtSVnxR/PSEDWNmAJdDQRt+3RaXywQUaPgrZ0f9KGqiUNQo+8rgsEgGSWfA
         nn3uqauVUfDnB9vfmAHb//zf8WfxYN9tjK9Njh2lTNelb9qrdHRBmJ+EpuJ4BLpXTW
         9fm3j2zW3WPhY87LxCHJ7HH15t4yMpLz+8/k5MlnUMmkwuDfSyu3NFFr+OF6UpGtCu
         JplQKX2Yo8KPzbWLWwE6dv2FSr7gRDMhwNOhg83Y2wdvihLraspQcYa9U1TvRu00vB
         AavXfmouI9Z7Q==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id C71124E46;
        Wed, 16 Jan 2019 02:14:26 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 03B6F3F67C;
        Wed, 16 Jan 2019 11:14:26 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH 0/9] Improve Synopsys DesignWare Root Complex driver code
Date:   Wed, 16 Jan 2019 11:14:13 +0100
Message-Id: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
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
 - adding a pointer null validation on dw_pcie_irq_domain_free()

No functional changes are intended.

All patches are independent so they can be easily analyzed and accepted or
discarded.

This patches organization also allows to easily merge (squash) some patches,
if desired.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>

Gustavo Pimentel (9):
  PCI: dwc: Remove unnecessary header include (of_gpio.h)
  PCI: dwc: Remove unnecessary header include (signal.h)
  PCI: dwc: Replace variable name from data to d on
    dw_pci_bottom_mask/unmask()
  PCI: dwc: Replace variable name from data to d on
    dw_pci_setup_msi_msg()
  PCI: dwc: Replace variable name from data to d on
    dw_pci_msi_set_affinity()
  PCI: dwc: Replace variable name from data to d on
    dw_pcie_irq_domain_free()
  PCI: dwc: Improve code readability and simplifies mask/unmask
    operations
  PCI: dwc: Replace bit rotation operation (1 << bit) by BIT(bit)
  PCI: dwc: Add pcie port pointer validation

 drivers/pci/controller/dwc/pcie-designware-host.c | 57 ++++++++++++-----------
 drivers/pci/controller/dwc/pcie-designware-plat.c |  2 -
 drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
 3 files changed, 32 insertions(+), 29 deletions(-)

-- 
2.7.4

