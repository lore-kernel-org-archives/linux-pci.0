Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2907DC169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 21:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F3721855
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 21:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfBKVpB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:45:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:58441 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfBKVpB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 16:45:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 13:44:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,360,1544515200"; 
   d="scan'208";a="117096153"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga008.jf.intel.com with ESMTP; 11 Feb 2019 13:44:59 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, keith.busch@intel.com
Subject: [PATCH v2 0/2] Add page alignment check in Intel IOMMU.
Date:   Mon, 11 Feb 2019 13:43:13 -0800
Message-Id: <cover.1548726944.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per Intel vt-d specification, Rev 3.0 (section 7.5.1.1, title "Page Request Descriptor"), Intel IOMMU Page Request Descriptor only provides bits[63:12] of the page address. Hence its required to enforce that the device will only send page request with page-aligned address. So, this patch set adds support to verify whether the device uses page aligned address before enabling the ATS service in Intel IOMMU driver.

Kuppuswamy Sathyanarayanan (2):
  PCI: ATS: Add function to check ATS page alignment status.
  iommu/vt-d: Enable ATS only if the device uses page aligned address.

 drivers/iommu/intel-iommu.c   |  1 +
 drivers/pci/ats.c             | 24 ++++++++++++++++++++++++
 include/linux/pci.h           |  2 ++
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 28 insertions(+)

-- 
2.20.1

