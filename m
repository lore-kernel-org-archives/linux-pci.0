Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7D0C43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 19:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BFB2147C
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 19:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfBSTHp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:07:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:6001 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbfBSTHp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Feb 2019 14:07:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 11:07:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="125645919"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga008.fm.intel.com with ESMTP; 19 Feb 2019 11:07:44 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, keith.busch@intel.com
Subject: [PATCH v3 0/2] Add page alignment check in Intel IOMMU.
Date:   Tue, 19 Feb 2019 11:06:08 -0800
Message-Id: <cover.1550602392.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per Intel vt-d specification, Rev 3.0 (section 7.5.1.1, title
"Page Request Descriptor"), Intel IOMMU page request descriptor
only uses bits[63:12] of the Page Address. Hence its required to
enforce that the device will only send page request with
page-aligned address. So, this patch set adds support to verify
whether the device uses page aligned address before enabling the
ATS service in Intel IOMMU driver.

Changes since v1:
 * Fixed issue with PCI_ATS_CAP_PAGE_ALIGNED macro.
 * Fixed comments.

Changes since v2:
 * Fixed Bjorn Helgaas comments.

Kuppuswamy Sathyanarayanan (2):
  PCI/ATS: Add pci_ats_page_aligned() interface
  iommu/vt-d: Enable ATS only if the device uses page aligned address.

 drivers/iommu/intel-iommu.c   |  1 +
 drivers/pci/ats.c             | 27 +++++++++++++++++++++++++++
 include/linux/pci.h           |  2 ++
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 31 insertions(+)

-- 
2.20.1

