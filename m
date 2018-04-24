Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:51202 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751678AbeDXErj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Apr 2018 00:47:39 -0400
Date: Tue, 24 Apr 2018 12:47:34 +0800
From: kbuild test robot <lkp@intel.com>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: [RFC PATCH] PCI/AER/DPC: pcie_do_fatal_recovery() can be static
Message-ID: <20180424044734.GA16123@lkp-ne02>
References: <1524496993-29799-9-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524496993-29799-9-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Fixes: 3d7db543cb99 ("PCI/AER/DPC: Align FATAL error handling for AER and DPC")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 err.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 99d52a0..9d8d7ef 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -273,7 +273,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 	return result_data.result;
 }
 
-pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev, int severity)
+static pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev, int severity)
 {
 	struct pci_dev *udev;
 	struct pci_bus *parent;
