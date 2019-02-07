Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6D7C282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 18:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655772175B
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 18:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBGSlz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:41:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:3517 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfBGSlq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 13:41:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 10:41:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="122781668"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga008.fm.intel.com with ESMTP; 07 Feb 2019 10:41:44 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, keith.busch@intel.com
Subject: [PATCH v1 0/2]  Add PGR response PASID requirement check in Intel IOMMU.
Date:   Thu,  7 Feb 2019 10:37:57 -0800
Message-Id: <cover.1549479043.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
response message. Due to this restriction Intel IOMMU driver only
enables PASID, if the endpoint is compliant to Intel IOMMU's. 

Kuppuswamy Sathyanarayanan (2):
  PCI: ATS: Add function to check PRG response PASID bit status.
  iommu/vt-d: Enable PASID only if device expects PASID in PRG response.

 drivers/iommu/intel-iommu.c   |  3 ++-
 drivers/pci/ats.c             | 27 +++++++++++++++++++++++++++
 include/linux/pci-ats.h       |  5 +++++
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.20.1

