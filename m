Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F22C43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 19:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095E02147A
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 19:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfBSTGg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:06:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:4541 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfBSTGg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Feb 2019 14:06:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 11:06:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="276264317"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga004.jf.intel.com with ESMTP; 19 Feb 2019 11:06:35 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, keith.busch@intel.com
Subject: [PATCH v3 0/2] Add PGR response PASID requirement check in Intel IOMMU.
Date:   Tue, 19 Feb 2019 11:04:50 -0800
Message-Id: <cover.1550602470.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Intel IOMMU responds automatically when receiving page-requests from
a PCIe endpoint and the page-request queue is full and it cannot accept
any more page-requests. When it auto-responds to page-requests with a
success to the endpoint, it automatically responds with the PASID if
the page-request had a PASID in the incoming request. IOMMU doesn't
actually have any place to check device capabilities (like whether
the device expects PASID in PGR response or not) before sending the
response message. Due to this restriction, If PASID is enabled then Intel
IOMMU driver will enable PRI only, if the endpoint is compliant to Intel
IOMMU's.

Changes since v1:
 * Changed interface name to pci_prg_resp_pasid_required().
 * Update comment header format.

Changes since v2:
 * Fixed typos.
 * Moved pci_prg_resp_pasid_required() check to PRI enable logic.

Kuppuswamy Sathyanarayanan (2):
  PCI/ATS: Add pci_prg_resp_pasid_required() interface.
  iommu/vt-d: Fix PRI/PASID dependency issue.

 drivers/iommu/intel-iommu.c   |  4 +++-
 drivers/pci/ats.c             | 30 ++++++++++++++++++++++++++++++
 include/linux/pci-ats.h       |  5 +++++
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.20.1

