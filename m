Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A32FC677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B772085B
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B772085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbeJLAXN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:23:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:17763 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729991AbeJLAXM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 20:23:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 09:55:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="87599217"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Oct 2018 09:55:08 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCH 0/3] aer inject updates
Date:   Thu, 11 Oct 2018 10:52:04 -0600
Message-Id: <20181011165207.12782-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an update to the aer inject that was briefly included in tree,
but backed out due to errors in the implementation across various archs.
This series should fix those issues and remove any arch specific
dependencies so it may continue to be used as before. This series was
compile tested using the CROSS_COMPILE build option for ARM.

The first patches two are unchanged from before, but reordered to the
front of the series since they should be non-controversial and and the
AER interrupt handling is actually necessary now that the AER module
uses threaded IRQs.

I moved the ftrace based error injection to be the last patch. I've
updated it to use the portable 'instruction_pointer_set()' function
instead of trying to modify the arch specific pt_regs directly, and
fallback to the existing error injection method if we can't install the
ftrace hooks at run time due to either arch or kernel config limitations.

Keith Busch (3):
  PCI/AER: Reuse existing pcie_port_find_device() interface
  PCI/AER: Abstract AER interrupt handling
  PCI/AER: Covertly inject errors with ftrace hooks

 drivers/pci/pcie/aer.c          |   3 +-
 drivers/pci/pcie/aer_inject.c   | 248 +++++++++++++++++++++++++++++++---------
 drivers/pci/pcie/portdrv.h      |   4 -
 drivers/pci/pcie/portdrv_core.c |   1 +
 4 files changed, 199 insertions(+), 57 deletions(-)

-- 
2.14.4

