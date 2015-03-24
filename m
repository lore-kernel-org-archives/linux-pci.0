Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48257 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309AbbCXOQ2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Mar 2015 10:16:28 -0400
Date: Tue, 24 Mar 2015 22:16:21 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH pci] PCI: pci_host_assign_domain_nr() can be static
Message-ID: <20150324141621.GA47322@lkp-sb04>
References: <201503242214.tdp6GlHv%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201503242214.tdp6GlHv%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 host-bridge.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index c78f4d0..6c2ca7c 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -217,7 +217,7 @@ static int pci_assign_domain_nr(struct device *dev)
 #endif
 #endif
 
-void pci_host_assign_domain_nr(struct pci_host_bridge *host)
+static void pci_host_assign_domain_nr(struct pci_host_bridge *host)
 {
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	host->domain = pci_assign_domain_nr(host->dev.parent);
