Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:3622 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751576AbeFHPpq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jun 2018 11:45:46 -0400
Date: Fri, 8 Jun 2018 23:44:49 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH pci] PCI/AER: aer_isr() can be static
Message-ID: <20180608154449.GA27070@xian>
References: <201806082323.j7tfjHHX%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201806082323.j7tfjHHX%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Fixes: 8079c81ec306 ("PCI/AER: Hoist aerdrv.c, aer_inject.c up to drivers/pci/pcie/")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 aer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d84cc11..a2e8838 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1035,7 +1035,7 @@ static int get_e_source(struct aer_rpc *rpc, struct aer_err_source *e_src)
  *
  * Invoked, as DPC, when root port records new detected error
  */
-void aer_isr(struct work_struct *work)
+static void aer_isr(struct work_struct *work)
 {
 	struct aer_rpc *rpc = container_of(work, struct aer_rpc, dpc_handler);
 	struct aer_err_source uninitialized_var(e_src);
