Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43226 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754415Ab2FTT4A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 Jun 2012 15:56:00 -0400
Subject: [PATCH] pci: 64bit resource fix in setup-res.c
From: Nikhil P Rao <nikhil.rao@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Nikhil P Rao <nikhil.rao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Jun 2012 12:56:00 -0700
Message-ID: <1340222160.77018.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

size parameter of _pci_assign_resource() needs to be
of type resource_size_t rather than int

Signed-off-by: Nikhil P Rao <nikhil.rao@intel.com>
---
 drivers/pci/setup-res.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index eea85da..9f6bbec 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -206,7 +206,8 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 	return ret;
 }
 
-static int _pci_assign_resource(struct pci_dev *dev, int resno, int size, resource_size_t min_align)
+static int _pci_assign_resource(struct pci_dev *dev, int resno,
+		resource_size_t size, resource_size_t min_align)
 {
 	struct resource *res = dev->resource + resno;
 	struct pci_bus *bus;
-- 
1.7.1



