Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8DFC43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 11:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CEC20672
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 11:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CEC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbeKZWJW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:09:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:13922 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbeKZWJU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Nov 2018 17:09:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 03:15:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,281,1539673200"; 
   d="scan'208";a="94071696"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 26 Nov 2018 03:15:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id F0B13546; Mon, 26 Nov 2018 13:15:26 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] iommu/vt-d: Do not enable ATS for untrusted devices
Date:   Mon, 26 Nov 2018 14:15:25 +0300
Message-Id: <20181126111526.56340-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
References: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently Linux automatically enables ATS (Address Translation Service)
for any device that supports it (and IOMMU is turned on). ATS is used to
accelerate DMA access as the device can cache translations locally so
there is no need to do full translation on IOMMU side. However, as
pointed out in [1] ATS can be used to bypass IOMMU based security
completely by simply sending PCIe read/write transaction with AT
(Address Translation) field set to "translated".

To mitigate this modify the Intel IOMMU code so that it does not enable
ATS for any device that is marked as being untrusted. In case this turns
out to cause performance issues we may selectively allow ATS based on
user decision but currently use big hammer and disable it completely to
be on the safe side.

[1] https://www.repository.cam.ac.uk/handle/1810/274352

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 76e135ee9b19..c964315deddd 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1473,7 +1473,8 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 	if (info->pri_supported && !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
 		info->pri_enabled = 1;
 #endif
-	if (info->ats_supported && !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
+	if (!pdev->is_untrusted && info->ats_supported &&
+	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
 		domain_update_iotlb(info->domain);
 		info->ats_qdep = pci_ats_queue_depth(pdev);
-- 
2.19.1

