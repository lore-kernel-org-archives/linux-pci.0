Return-Path: <SRS0=uFxo=EC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB658C4363A
	for <linux-pci@archiver.kernel.org>; Tue, 27 Oct 2020 02:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914C520872
	for <linux-pci@archiver.kernel.org>; Tue, 27 Oct 2020 02:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408766AbgJ0C5S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Oct 2020 22:57:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:23078 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408622AbgJ0C5R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 22:57:17 -0400
IronPort-SDR: ghEaewmGwiyrHAt+mbJ2p08RsyQopMW1CcuE6JansBGaJ86rDpaAMLz0HtbNFstK0CP8uKRGFO
 qWnG0A8P+zQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="185753256"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="185753256"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 19:57:16 -0700
IronPort-SDR: N26GHuD3IgSfoKuPgtwNEZAV7nch5YMHENxpHmTHI1g6aYWxQ2O6PgscC2WjfQmYJf1JJh1ITH
 HW51O6pcwV7A==
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="322772469"
Received: from dhrubajy-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.53])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 19:57:15 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        knsathya@kernel.org
Subject: [PATCH v11 1/5] PCI: Conditionally initialize host bridge native_* members
Date:   Mon, 26 Oct 2020 19:57:04 -0700
Message-Id: <fcbe8a624166a1101a755edfef44a185d32ff493.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If CONFIG_PCIEPORTBUS is not enabled in kernel then initialing
struct pci_host_bridge PCIe specific native_* members to "1" is
incorrect. So protect the PCIe specific member initialization
with CONFIG_PCIEPORTBUS.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/probe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4289030b0fff..756fa60ca708 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -588,12 +588,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	 * may implement its own AER handling and use _OSC to prevent the
 	 * OS from interfering.
 	 */
+#ifdef CONFIG_PCIEPORTBUS
 	bridge->native_aer = 1;
 	bridge->native_pcie_hotplug = 1;
-	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = 1;
-	bridge->native_ltr = 1;
 	bridge->native_dpc = 1;
+#endif
+	bridge->native_ltr = 1;
+	bridge->native_shpc_hotplug = 1;
 
 	device_initialize(&bridge->dev);
 }
-- 
2.17.1

