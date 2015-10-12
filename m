Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:33433 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbbJLVWu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 12 Oct 2015 17:22:50 -0400
Date: Tue, 13 Oct 2015 05:21:23 +0800
From: kbuild test robot <lkp@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH] PCI: pciehp: pciehp_queue_power_work() can be static
Message-ID: <20151012212123.GA19544@athens>
References: <201510130546.Iddntrqh%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444677013-3836-1-git-send-email-linux@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 pciehp_ctrl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index ef96a1d..e27a9e2 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -204,7 +204,7 @@ static void pciehp_power_thread(struct work_struct *work)
 	kfree(info);
 }
 
-void pciehp_queue_power_work(struct slot *p_slot, int req)
+static void pciehp_queue_power_work(struct slot *p_slot, int req)
 {
 	struct power_work_info *info;
 
