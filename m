Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo01.seg.att.com ([209.65.160.76]:54294 "EHLO
	nbfkord-smmo01.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750996AbaGaOg4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jul 2014 10:36:56 -0400
Date: Thu, 31 Jul 2014 15:24:07 +0100
From: Edward Cree <ecree@solarflare.com>
To: <linux-pci@vger.kernel.org>
CC: Alexander Duyck <alexander.h.duyck@intel.com>,
	Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
In-Reply-To: <53DA3180.5040302@solarflare.com>
Message-ID: <alpine.LFD.2.03.1407311500570.16821@solarflare.com>
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make a driver_max_VFs of 0 mean 0, instead of total_VFs as previously.
Initialise driver_max_VFs to total_VFs instead of 0.

Signed-off-by: Edward Cree <ecree@solarflare.com>
---
Only existing callers are ixgbe and igb, and neither passes 0, so this
doesn't break existing users.
---
 drivers/pci/iov.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index cb6f247..fb51467 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -381,7 +381,7 @@ found:
        iov->pos = pos;
        iov->nres = nres;
        iov->ctrl = ctrl;
-       iov->total_VFs = total;
+       iov->driver_max_VFs = iov->total_VFs = total;
        iov->offset = offset;
        iov->stride = stride;
        iov->pgsz = pgsz;
@@ -686,9 +686,6 @@ int pci_sriov_get_totalvfs(struct pci_dev *dev)
        if (!dev->is_physfn)
                return 0;

-       if (dev->sriov->driver_max_VFs)
-               return dev->sriov->driver_max_VFs;
-
-       return dev->sriov->total_VFs;
+       return dev->sriov->driver_max_VFs;
 }
 EXPORT_SYMBOL_GPL(pci_sriov_get_totalvfs);
--
1.7.11.7
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
