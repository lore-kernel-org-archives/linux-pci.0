Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:48512 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751293AbdL1Q14 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Dec 2017 11:27:56 -0500
Date: Fri, 29 Dec 2017 00:27:08 +0800
From: kbuild test robot <lkp@intel.com>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: [RFC PATCH] PCI/DPC/AER: pci_find_dpc_dev() can be static
Message-ID: <20171228162708.GA58636@lkp-ib04>
References: <1514370022-4431-3-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1514370022-4431-3-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Fixes: fc0212127f27 ("PCI/DPC/AER: Address Concurrency between AER and DPC")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 pcie-dpc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index e7ced58..68296ec 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -88,7 +88,7 @@ static int find_dpc_dev_iter(struct device *device, void *data)
 	return 0;
 }
 
-struct device *pci_find_dpc_dev(struct pci_dev *pdev)
+static struct device *pci_find_dpc_dev(struct pci_dev *pdev)
 {
 	struct device *dev = NULL;
 
