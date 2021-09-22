Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D70BC433F5
	for <linux-pci@archiver.kernel.org>; Wed, 22 Sep 2021 21:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0032A61168
	for <linux-pci@archiver.kernel.org>; Wed, 22 Sep 2021 21:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbhIVVbk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:31:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:45002 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237770AbhIVVbi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Sep 2021 17:31:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="203202706"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="203202706"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 14:30:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="557639903"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 22 Sep 2021 14:30:07 -0700
Received: from debox1-server.jf.intel.com (debox1-server.jf.intel.com [10.54.39.121])
        by linux.intel.com (Postfix) with ESMTP id A4C94580ABF;
        Wed, 22 Sep 2021 14:30:07 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, bhelgaas@google.com,
        andy.shevchenko@gmail.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        mgross@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 0/5] Add general DVSEC/VSEC support
Date:   Wed, 22 Sep 2021 14:30:02 -0700
Message-Id: <20210922213007.2738388-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch enables general support for Intel defined PCIe VSEC and DVSEC
capabilities in the Intel Platform Monitoring Technology (PMT) driver.
Though the driver was written exclusively for PMT capabilities, newer DVSEC
and VSEC IDs for other capabilities can exist on the same device requiring
that the driver handle them.

V3 is mostly a resend of V2. It drops a platform/x86 patch that was picked
up separately by Hans in the last cycle. It also adds a new patch to
support an upcoming capability.

David E. Box (5):
  PCI: Add #defines for accessing PCIE DVSEC fields
  MFD: intel_pmt: Support non-PMT capabilities
  MFD: intel_pmt: Add support for PCIe VSEC structures
  MFD: intel_pmt: Add DG2 support
  MFD: intel_extended_cap: Add support for Intel SDSi

 drivers/mfd/intel_pmt.c                    | 258 +++++++++++++++------
 drivers/platform/x86/intel/pmt/class.c     |   2 +
 drivers/platform/x86/intel/pmt/crashlog.c  |   2 +-
 drivers/platform/x86/intel/pmt/telemetry.c |   2 +-
 include/uapi/linux/pci_regs.h              |   4 +
 5 files changed, 191 insertions(+), 77 deletions(-)

-- 
2.25.1

