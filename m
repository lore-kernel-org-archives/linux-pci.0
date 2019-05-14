Return-Path: <SRS0=pnCm=TO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09611C04AB4
	for <linux-pci@archiver.kernel.org>; Tue, 14 May 2019 22:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D507F20578
	for <linux-pci@archiver.kernel.org>; Tue, 14 May 2019 22:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfENWVD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 May 2019 18:21:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:20401 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfENWVD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 May 2019 18:21:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 15:21:02 -0700
X-ExtLoop1: 1
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga007.fm.intel.com with ESMTP; 14 May 2019 15:21:02 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 0/5] Add Error Disconnect Recover (EDR) support
Date:   Tue, 14 May 2019 15:18:12 -0700
Message-Id: <cover.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

This patchset adds support for following features:

1. Error Disconnect Recover (EDR) support.
2. _OSC based negotiation support for DPC.

You can find EDR spec in the following link.

https://members.pcisig.com/wg/PCI-SIG/document/12614

Changes since v1:
 * Rebased on top of v5.1-rc1

Changes since v2:
 * Split EDR support patch into multiple patches.
 * Addressed Bjorn comments.

Kuppuswamy Sathyanarayanan (5):
  PCI/ACPI: Add _OSC based negotiation support for DPC
  PCI/DPC: Allow dpc_probe() even if DPC is handled in firmware
  PCI/DPC: Add dpc_process_error() wrapper function
  PCI/DPC: Add Error Disconnect Recover (EDR) support
  PCI/ACPI: Expose EDR support via _OSC to BIOS

 drivers/acpi/pci_root.c         |   9 ++
 drivers/pci/pcie/Kconfig        |  10 ++
 drivers/pci/pcie/dpc.c          | 265 ++++++++++++++++++++++++++++++--
 drivers/pci/pcie/portdrv_core.c |   8 +-
 drivers/pci/probe.c             |   1 +
 include/linux/acpi.h            |   6 +-
 include/linux/pci.h             |   1 +
 7 files changed, 282 insertions(+), 18 deletions(-)

-- 
2.20.1

