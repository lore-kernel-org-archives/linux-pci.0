Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:20793 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbaHOCvU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Aug 2014 22:51:20 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>,
	"Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH 3/3] xen/MSI: Retrieve MSI msg from cached msi_desc->msg
Date: Fri, 15 Aug 2014 11:14:37 +0800
Message-ID: <1408072477-10008-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We had cached the MSI msg in __write_msi_msg(),
so we should retrieve the cached MSI msg directly,
not to access the MSI address/data hardware registers
again.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: xen-devel@lists.xenproject.org
---
 arch/x86/pci/xen.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 4656099..7a74404 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -228,7 +228,7 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		return 1;
 
 	list_for_each_entry(msidesc, &dev->msi_list, list) {
-		read_msi_msg(msidesc, &msg);
+		get_cached_msi_msg(msidesc, &msg);
 		pirq = MSI_ADDR_EXT_DEST_ID(msg.address_hi) |
 			((msg.address_lo >> MSI_ADDR_DEST_ID_SHIFT) & 0xff);
 		if (msg.data != XEN_PIRQ_MSI_DATA ||
-- 
1.7.1

