Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54520 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab2KEUU7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 5 Nov 2012 15:20:59 -0500
From: Donald Dutile <ddutile@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	yinghai@kernel.org, davem@davemloft.net, ddutile@redhat.com
Subject: [PATCH 8/8] ixgbe: change totalvfs to match support in driver
Date: Mon,  5 Nov 2012 15:20:41 -0500
Message-Id: <1352146841-64458-9-git-send-email-ddutile@redhat.com>
In-Reply-To: <1352146841-64458-1-git-send-email-ddutile@redhat.com>
References: <1352146841-64458-1-git-send-email-ddutile@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 ixgbe claims it supports 64 VFs in its SRIOV capability
 structure, but the driver only supports 63.  Adjust it
 so sysfs sriov configuration checking will check with
 the proper totalvf value.

Note: This is part of a 4-part patch set that demonstrates
      how a PF driver can enable its VF devices via sysfs.
      The final patch will be submitted by Intel via
      the linux-net mailing list.

Signed-off-by: Donald Dutile <ddutile@redhat.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 5d868e4..69e0cff 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7273,6 +7273,7 @@ static int __devinit ixgbe_probe(struct pci_dev *pdev,
 	ixgbe_init_mbx_params_pf(hw);
 	memcpy(&hw->mbx.ops, ii->mbx_ops, sizeof(hw->mbx.ops));
 	ixgbe_enable_sriov(adapter);
+	pci_sriov_set_totalvfs(pdev, 63);
 
 #endif
 	netdev->features = NETIF_F_SG |
-- 
1.7.10.2.552.gaa3bb87

