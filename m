Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C35C2BB48
	for <linux-pci@archiver.kernel.org>; Tue, 15 Dec 2020 17:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C756E2222B
	for <linux-pci@archiver.kernel.org>; Tue, 15 Dec 2020 17:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbgLORbi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Dec 2020 12:31:38 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:54406 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729683AbgLORbe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Dec 2020 12:31:34 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B126F4013F;
        Tue, 15 Dec 2020 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1608053433; bh=Rp8f7F2uSWSg/KTfT5SE2X1d3fnriVqX5tGhIffKmcQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GjhXQoyIF/y9+gGU/sZNtHmlndMcQ/lGXwh3VcL7bOhRlqhO9moIUNvXDLDSHS/I8
         mUNCEyeeLyA/L2hmJLqBKFhygi8RoQ7nN2FFLD9yEaRHCJZmBqMfhfcVAp6I27kbFF
         TXN4nI57f5a1vPzNMSXPC/bWrcGjS4XAC5E7kH2v35Ja8o/RotFMMOfCDH5OEOHWAB
         DgfLhua+k9DE2Sbft+1GMYvbwmKtHdRcEFsOT6jAMy/ptiSHMsCRu3WP/UWFdz3DUD
         x8M6GDLgFX5aLpa5uCiRLRcT4/frTVD/efG042YH44UrBSstbmF71ofMcY6KS6FjXi
         A4FoNoTbfCMNA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6C272A024A;
        Tue, 15 Dec 2020 17:30:30 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 00/15] dmaengine: dw-edma: HDMA support
Date:   Tue, 15 Dec 2020 18:30:09 +0100
Message-Id: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series adds the HDMA support, as long the IP design has set
the compatible register map parameter, which allows compatibility at
some degree for the existing Synopsys DesignWare eDMA driver that is
already available on the Kernel.

The HDMA "Hyper-DMA" IP is an enhancement of the eDMA "embedded-DMA" IP.

This new improvement comes with a PCI DVSEC that allows to the driver
recognize and switch behavior if it's an eDMA or an HDMA, becoming
retrocompatible, in the absence of this DVSEC, the driver will assume
that is an eDMA IP.

It also adds the interleaved support, since it will be similar to the
current scatter-gather implementation.

As well fixes/improves some abnormal behaviors not detected before, such as:
 - crash on loading/unloading driver
 - memory space definition for the data area and for the linked list space
 - scatter-gather address calculation on 32 bits platforms
 - minor comment and variable reordering

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org

Gustavo Pimentel (15):
  dmaengine: dw-edma: Add writeq() and readq() for 64 bits architectures
  dmaengine: dw-edma: Fix comments offset characters' alignment
  dmaengine: dw-edma: Add support for the HDMA feature
  PCI: Add pci_find_vsec_capability() to find a specific VSEC
  dmaengine: dw-edma: Add PCIe VSEC data retrieval support
  dmaengine: dw-edma: Add device_prep_interleave_dma() support
  dmaengine: dw-edma: Improve number of channels check
  dmaengine: dw-edma: Reorder variables to keep consistency
  dmaengine: dw-edma: Improve the linked list and data blocks definition
  dmaengine: dw-edma: Change linked list and data blocks offset and
    sizes
  dmaengine: dw-edma: Move struct dentry variable from static definition
    into dw_edma struct
  dmaengine: dw-edma: Fix crash on loading/unloading driver
  dmaengine: dw-edma: Change DMA abreviation from lower into upper case
  dmaengine: dw-edma: Revert fix scatter-gather address calculation
  dmaengine: dw-edma: Add pcim_iomap_table return checker

 drivers/dma/dw-edma/dw-edma-core.c       | 178 +++++++++++-------
 drivers/dma/dw-edma/dw-edma-core.h       |  37 ++--
 drivers/dma/dw-edma/dw-edma-pcie.c       | 275 +++++++++++++++++++++-------
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 300 ++++++++++++++++++++++++-------
 drivers/dma/dw-edma/dw-edma-v0-core.h    |   2 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c |  77 ++++----
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-regs.h    | 291 +++++++++++++++++++-----------
 drivers/pci/pci.c                        |  29 +++
 include/linux/pci.h                      |   1 +
 include/uapi/linux/pci_regs.h            |   5 +
 11 files changed, 844 insertions(+), 355 deletions(-)

-- 
2.7.4

