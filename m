Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:35807 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbbJWKsU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 06:48:20 -0400
Date: Fri, 23 Oct 2015 18:47:46 +0800
From: kbuild test robot <lkp@intel.com>
To: Hannes Reinecke <hare@suse.de>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [RFC PATCH] pci: pci_vpd_pci22_size can be static
Message-ID: <20151023104746.GA118189@lkp-hsx03>
References: <201510231810.RlZ52VfY%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445591396-95395-1-git-send-email-hare@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 access.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 3a49b14..41d86f6 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -495,7 +495,7 @@ static int pci_vpd_f0_dev_check(struct pci_dev *dev)
  * @old_size:	current assumed size, also maximum allowed size
  *
  */
-size_t
+static size_t
 pci_vpd_pci22_size(struct pci_dev *dev, size_t old_size)
 {
 	loff_t off = 0;
