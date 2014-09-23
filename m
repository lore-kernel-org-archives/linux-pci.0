Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:54904 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaIWFIc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 01:08:32 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v3 7/9] MSI/powerpc: Use __read_msi_msg() instead of read_msi_msg()
Date: Tue, 23 Sep 2014 13:27:28 +0800
Message-ID: <1411450050-1510-8-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1411450050-1510-1-git-send-email-wangyijing@huawei.com>
References: <1411450050-1510-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Read_msi_msg() only be called in rtas_setup_msi_irqs(),
use __read_msi_msg() instead of read_msi_msg for
simplification.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/pseries/msi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 18ff462..dae71df 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -485,7 +485,7 @@ again:
 		irq_set_msi_desc(virq, entry);
 
 		/* Read config space back so we can restore after reset */
-		read_msi_msg(virq, &msg);
+		__read_msi_msg(entry, &msg);
 		entry->msg = msg;
 	}
 
-- 
1.7.1

