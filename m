Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BD3C282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 18:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3042173B
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 18:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfBGSmm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:42:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:17894 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfBGSmm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 13:42:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 10:42:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="318494886"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga005.fm.intel.com with ESMTP; 07 Feb 2019 10:42:41 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Add page alignment check in Intel IOMMU.
Date:   Thu,  7 Feb 2019 10:41:12 -0800
Message-Id: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
only uses bits[63:12] of the page address. Hence its required to
enforce that the device will only send page request with
page-aligned address. So, this patch set adds support to verify
whether the device uses page aligned address before enabling the
ATS service in Intel IOMMU driver.

Kuppuswamy Sathyanarayanan (2):
  PCI: ATS: Add function to check ATS page aligned request status.
  iommu/vt-d: Enable ATS only if the device uses page aligned address.

 drivers/iommu/intel-iommu.c   |  1 +
 drivers/pci/ats.c             | 22 ++++++++++++++++++++++
 include/linux/pci.h           |  2 ++
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 26 insertions(+)

-- 
2.20.1

