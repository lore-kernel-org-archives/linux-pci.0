Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEF5C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 20:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9DD2084F
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 20:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbfB1UwU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:52:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:16411 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388176AbfB1UwU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Feb 2019 15:52:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 12:52:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,424,1544515200"; 
   d="scan'208";a="130192185"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga003.jf.intel.com with ESMTP; 28 Feb 2019 12:52:19 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
        robert.moore@intel.com, erik.schmauss@intel.com, ruscur@russell.cc
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        keith.busch@intel.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v1 0/3] Add Error Disconnect Recover (EDR) support.
Date:   Thu, 28 Feb 2019 12:49:46 -0800
Message-Id: <cover.1551382061.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

Kuppuswamy Sathyanarayanan (3):
  PCI/ACPI: Add _OSC based negotiation support for DPC
  ACPI: Add Error Disconnect Recover (EDR) ACPI notifier support
  PCI/DPC: Add Error Disconnect Recover (EDR) support

 drivers/acpi/acpica/utdecode.c  |   3 +-
 drivers/acpi/bus.c              |   5 +-
 drivers/acpi/pci_root.c         |   6 +
 drivers/pci/pcie/Kconfig        |  10 +
 drivers/pci/pcie/dpc.c          | 326 ++++++++++++++++++++++++++++++--
 drivers/pci/pcie/portdrv_core.c |   8 +-
 drivers/pci/probe.c             |   1 +
 include/acpi/actypes.h          |   3 +-
 include/linux/acpi.h            |   3 +-
 include/linux/pci.h             |   1 +
 10 files changed, 347 insertions(+), 19 deletions(-)

-- 
2.20.1

