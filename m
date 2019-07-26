Return-Path: <SRS0=nurA=VX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A27C7618F
	for <linux-pci@archiver.kernel.org>; Fri, 26 Jul 2019 21:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3318222BF5
	for <linux-pci@archiver.kernel.org>; Fri, 26 Jul 2019 21:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfGZVpu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:45:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:28904 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbfGZVpu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jul 2019 17:45:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 14:45:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,312,1559545200"; 
   d="scan'208";a="369671127"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jul 2019 14:45:49 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 0/9] Add Error Disconnect Recover (EDR) support
Date:   Fri, 26 Jul 2019 14:43:10 -0700
Message-Id: <cover.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
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

Changes since v5:
 * Addressed Keith's comments.
 * Added additional check for FF mode in pci_aer_init().
 * Updated commit history of "PCI/DPC: Add support for DPC recovery on NON_FATAL errors" patch.

Changes since v4:
 * Rebased on top of v5.3-rc1
 * Fixed lock/unlock issue in edr_handle_event().
 * Merged "Update error status after reset_link()" patch into this patchset.

Changes since v3:
 * Moved EDR related ACPI functions/definitions to pci-acpi.c
 * Modified commit history in few patches to include spec reference.
 * Added support to handle DPC triggered by NON_FATAL errors.
 * Added edr_lock to protect PCI device receiving duplicate EDR notifications.
 * Addressed Bjorn comments.

Changes since v2:
 * Split EDR support patch into multiple patches.
 * Addressed Bjorn comments.

Changes since v1:
 * Rebased on top of v5.1-rc1

Kuppuswamy Sathyanarayanan (9):
  PCI/ERR: Update error status after reset_link()
  PCI/ACPI: Add _OSC based negotiation support for DPC
  PCI/ACPI: Expose EDR support via _OSC to BIOS
  PCI/DPC: Allow dpc_probe() even if firmware first mode is enabled
  PCI/DPC: Add dpc_process_error() wrapper function
  PCI/DPC: Add Error Disconnect Recover (EDR) support
  PCI/AER: Allow clearing Error Status Register in FF mode
  PCI/DPC: Update comments related to DPC recovery on NON_FATAL errors
  PCI/DPC: Clear AER registers in EDR mode

 drivers/acpi/pci_root.c         |   9 ++
 drivers/pci/pci-acpi.c          |  91 +++++++++++++++
 drivers/pci/pcie/Kconfig        |  10 ++
 drivers/pci/pcie/aer.c          |  12 +-
 drivers/pci/pcie/dpc.c          | 196 +++++++++++++++++++++++++++++---
 drivers/pci/pcie/err.c          |  11 +-
 drivers/pci/pcie/portdrv_core.c |   8 +-
 drivers/pci/probe.c             |   1 +
 include/linux/acpi.h            |   4 +-
 include/linux/pci-acpi.h        |  11 ++
 include/linux/pci.h             |   2 +-
 11 files changed, 322 insertions(+), 33 deletions(-)

-- 
2.21.0

