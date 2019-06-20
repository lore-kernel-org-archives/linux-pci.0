Return-Path: <SRS0=HNSb=UT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24730C43613
	for <linux-pci@archiver.kernel.org>; Thu, 20 Jun 2019 20:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032582082C
	for <linux-pci@archiver.kernel.org>; Thu, 20 Jun 2019 20:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfFTUk5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:40:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:28566 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfFTUk5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 16:40:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 13:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,398,1557212400"; 
   d="scan'208";a="311788158"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2019 13:40:56 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 0/7] Fix PF/VF dependency issue
Date:   Thu, 20 Jun 2019 13:38:41 -0700
Message-Id: <cover.1561061640.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
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

Changes since v2:
 * Added locking mechanism to synchronize accessing PF registers in VF.
 * Removed spec compliance checks in patches.
 * Addressed comments from Bjorn Helgaas. 

Kuppuswamy Sathyanarayanan (7):
  PCI/ATS: Fix pci_prg_resp_pasid_required() dependency issues
  PCI/ATS: Initialize PRI in pci_ats_init()
  PCI/ATS: Initialize PASID in pci_ats_init()
  PCI/ATS: Add PRI support for PCIe VF devices
  PCI/ATS: Add PASID support for PCIe VF devices
  PCI/ATS: Disable PF/VF ATS service independently
  PCI: Skip Enhanced Allocation (EA) initialization for VF device

 drivers/pci/ats.c       | 385 ++++++++++++++++++++++++++++++----------
 drivers/pci/pci.c       |   7 +
 include/linux/pci-ats.h |  12 +-
 include/linux/pci.h     |   7 +-
 4 files changed, 312 insertions(+), 99 deletions(-)

-- 
2.21.0

