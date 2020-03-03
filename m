Return-Path: <SRS0=1yZ1=4U=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BABC3F2D7
	for <linux-pci@archiver.kernel.org>; Tue,  3 Mar 2020 02:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EAC2467B
	for <linux-pci@archiver.kernel.org>; Tue,  3 Mar 2020 02:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCCCZL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:25:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:54186 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbgCCCZJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Mar 2020 21:25:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 18:25:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,509,1574150400"; 
   d="scan'208";a="233605699"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.244.172])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2020 18:25:08 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: [PATCH v2 5/6] ixgbe: Use pci_get_dsn()
Date:   Mon,  2 Mar 2020 18:25:04 -0800
Message-Id: <20200303022506.1792776-6-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.0.368.g28a2d05eebfb
In-Reply-To: <20200303022506.1792776-1-jacob.e.keller@intel.com>
References: <CABhMZUXJ_Omt-+fwa4Oz-Ly=J+NM8+8Ryv-Ad1u_bgEpDRH7RQ@mail.gmail.com>
 <20200303022506.1792776-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the open-coded implementation for reading the PCIe DSN with
pci_get_dsn().

The original code used a simple for-loop to read the bytes in order into
a buffer one byte at a time.

The pci_get_dsn() function returns the DSN as a u64, correctly ordering
the upper and lower 32 bit dwords. Simplify the display code by using
%016llX to display the u64 DSN.

This should have equivalent behavior on both Little and Big Endian
systems. The bus will have correctly ordered the dwords in the CPU
endian format, while pci_get_dsn() will correctly order the lower and
higher dwords into a u64.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index ccd852ad62a4..d733165c4a2e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -968,8 +968,8 @@ int ixgbe_fcoe_get_hbainfo(struct net_device *netdev,
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
-	int i, pos;
-	u8 buf[8];
+	u64 dsn;
+	int i;
 
 	if (!info)
 		return -EINVAL;
@@ -985,17 +985,11 @@ int ixgbe_fcoe_get_hbainfo(struct net_device *netdev,
 	/* Serial Number */
 
 	/* Get the PCI-e Device Serial Number Capability */
-	pos = pci_find_ext_capability(adapter->pdev, PCI_EXT_CAP_ID_DSN);
-	if (pos) {
-		pos += 4;
-		for (i = 0; i < 8; i++)
-			pci_read_config_byte(adapter->pdev, pos + i, &buf[i]);
-
+	dsn = pci_get_dsn(adapter->pdev);
+	if (dsn)
 		snprintf(info->serial_number, sizeof(info->serial_number),
-			 "%02X%02X%02X%02X%02X%02X%02X%02X",
-			 buf[7], buf[6], buf[5], buf[4],
-			 buf[3], buf[2], buf[1], buf[0]);
-	} else
+			 "%016llX", dsn);
+	else
 		snprintf(info->serial_number, sizeof(info->serial_number),
 			 "Unknown");
 
-- 
2.25.0.368.g28a2d05eebfb

