Return-Path: <SRS0=GEr7=TG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526FEC04A6B
	for <linux-pci@archiver.kernel.org>; Mon,  6 May 2019 17:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3013E20830
	for <linux-pci@archiver.kernel.org>; Mon,  6 May 2019 17:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfEFRWS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 6 May 2019 13:22:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:31139 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfEFRWS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 May 2019 13:22:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 10:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="230014470"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2019 10:22:15 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 0/5] Fix PF/VF dependency issues
Date:   Mon,  6 May 2019 10:20:02 -0700
Message-Id: <cover.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Current implementation of ATS, PASID, PRI does not handle VF dependencies
correctly. Following patches addresses this issue.

Changes since v1:
 * Added more details about the patches in commit log.
 * Removed bulk spec check patch.
 * Addressed comments from Bjorn Helgaas.

Kuppuswamy Sathyanarayanan (5):
  PCI/ATS: Add PRI support for PCIe VF devices
  PCI/ATS: Add PASID support for PCIe VF devices
  PCI/ATS: Skip VF ATS initialization if PF does not implement it
  PCI/ATS: Disable PF/VF ATS service independently
  PCI: Skip Enhanced Allocation (EA) initalization for VF device

 drivers/pci/ats.c   | 131 +++++++++++++++++++++++++++++++++++++++-----
 drivers/pci/pci.c   |   7 +++
 include/linux/pci.h |   3 +-
 3 files changed, 126 insertions(+), 15 deletions(-)

-- 
2.20.1

