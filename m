Return-Path: <SRS0=w1cP=EM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B52C55178
	for <linux-pci@archiver.kernel.org>; Fri,  6 Nov 2020 00:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B71BB2075A
	for <linux-pci@archiver.kernel.org>; Fri,  6 Nov 2020 00:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbgKFAPr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:15:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:23065 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732925AbgKFAPV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 19:15:21 -0500
IronPort-SDR: rnXmH+9GpWkXVP2g/0Cul04O8DBN8+ELUkOrepBdxXhY5tHOLNiVJHmVGisYdpLfn79wf9yzXx
 r4Kxdhd9U6fQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="148759558"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="148759558"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 16:15:20 -0800
IronPort-SDR: HQQzm1/acZexAvJm1iNRVnf7Ci21Agq5Kt0TTZj/m3gKzTvxBi/A+Wsu0pp58mwwIoONMqrQWE
 ntSvJLS77tig==
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="529621757"
Received: from gabriels-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.209.37.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 16:15:20 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v10 16/16] PCI/AER: Add RCEC AER error injection support
Date:   Thu,  5 Nov 2020 16:14:44 -0800
Message-Id: <20201106001444.667232-17-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201106001444.667232-1-sean.v.kelley@intel.com>
References: <20201106001444.667232-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Root Complex Event Collectors (RCEC) appear as peers to Root Ports and may
also have the AER capability.

Add RCEC support to the AER error injection driver.

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-15-seanvk.dev@oregontracks.org
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer_inject.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index c2cbf425afc5..767f8859b99b 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -333,8 +333,11 @@ static int aer_inject(struct aer_error_inj *einj)
 	if (!dev)
 		return -ENODEV;
 	rpdev = pcie_find_root_port(dev);
+	/* If Root Port not found, try to find an RCEC */
+	if (!rpdev)
+		rpdev = dev->rcec;
 	if (!rpdev) {
-		pci_err(dev, "Root port not found\n");
+		pci_err(dev, "Neither Root Port nor RCEC found\n");
 		ret = -ENODEV;
 		goto out_put;
 	}
-- 
2.29.2

