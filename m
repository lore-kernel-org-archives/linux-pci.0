Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145C2C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 12:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E962082E
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 12:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbfDJMfC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:35:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:53389 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730517AbfDJMfC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 08:35:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 05:35:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="159914093"
Received: from scymds02.sc.intel.com ([10.82.195.37])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2019 05:35:01 -0700
Received: from scvm10.sc.intel.com (scvm10.sc.intel.com [10.82.195.27])
        by scymds02.sc.intel.com
        with ESMTP id x3ACZ1em016541;
        Wed, 10 Apr 2019 05:35:01 -0700
Received: from scvm10.sc.intel.com (localhost [127.0.0.1])
        by scvm10.sc.intel.com with ESMTP id x3ACZ1bE027447;
        Wed, 10 Apr 2019 05:35:01 -0700
Subject: [PATCH for-next 2/2] IB/hfi1: Make Unsupported Request error
 non-fatal
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     bhelgaas@google.com
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>, dledford@redhat.com,
        Kamenee Arumugam <kamenee.arumugam@intel.com>
Date:   Wed, 10 Apr 2019 05:35:01 -0700
Message-ID: <20190410123455.26818.49424.stgit@scvm10.sc.intel.com>
In-Reply-To: <20190410123253.26818.37261.stgit@scvm10.sc.intel.com>
References: <20190410123253.26818.37261.stgit@scvm10.sc.intel.com>
User-Agent: StGit/0.17.1-18-g2e886-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kamenee Arumugam <kamenee.arumugam@intel.com>

For hfi1, the unsupported request error is not considered a fatal
error. When the PCIe advanced error reporting capability (AER) is
configured to report unsupported requests as fatal, the system will
hang on this error.

Set Unsupported Request Error bit in Uncorrectable Error Mask
register to disable error reporting to the PCIe root complex.

Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Kamenee Arumugam <kamenee.arumugam@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/pcie.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index c96d193..a033e28 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -114,6 +114,7 @@ int hfi1_pcie_init(struct hfi1_devdata *dd)
 	}
 
 	pci_set_master(pdev);
+	pcie_aer_set_dword(pdev, PCI_ERR_UNCOR_MASK, PCI_ERR_UNC_UNSUP);
 	(void)pci_enable_pcie_error_reporting(pdev);
 	return 0;
 

