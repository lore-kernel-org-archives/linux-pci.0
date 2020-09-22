Return-Path: <SRS0=cLGU=C7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60019C2D0E2
	for <linux-pci@archiver.kernel.org>; Tue, 22 Sep 2020 20:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA0B23600
	for <linux-pci@archiver.kernel.org>; Tue, 22 Sep 2020 20:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgIVU7r (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Sep 2020 16:59:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:18525 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVU7n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 16:59:43 -0400
IronPort-SDR: kufgDhAoszBOpk6FDOZ06iLfRddZNxakdQnhSfWUMNE1vnEKXaPf+sUJcGAfG2EYX03OCgA0yx
 mbBq1SgOzp+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="178786775"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="178786775"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 13:54:43 -0700
IronPort-SDR: hMGzXnr7sdnP8MVr8OUKm40bacifIWF1ItaAxo6j505XngtLs4c5NhP0HTdGvWuDOkKUEnbW+x
 mjtaJAveU9fg==
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="510718948"
Received: from fkhoshne-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.255.230.168])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 13:54:43 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v9 4/5] PCI/portdrv: Remove redundant pci_aer_available() check in DPC enable logic
Date:   Tue, 22 Sep 2020 13:54:31 -0700
Message-Id: <e4f72276c8bd363a97b747f4a806c27fcf49ca28.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

In DPC service enable logic, check for
services & PCIE_PORT_SERVICE_AER implies pci_aer_available()
is true. So there is no need to explicitly check it again.

Also, passing pcie_ports=dpc-native in kernel command line
implies DPC needs to be enabled in native mode irrespective
of AER ownership status. So checking for pci_aer_available()
without checking for pcie_ports status is incorrect.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/portdrv_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 2c0278f0fdcc..e257a2ca3595 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -252,7 +252,6 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 * permission to use AER.
 	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-	    pci_aer_available() &&
 	    (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
 		services |= PCIE_PORT_SERVICE_DPC;
 
-- 
2.17.1

