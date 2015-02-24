Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40426 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbbBXIdL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Feb 2015 03:33:11 -0500
Received: by pdev10 with SMTP id v10so31841999pde.7
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2015 00:33:11 -0800 (PST)
Subject: [PATCH v12 02/21] PCI: Print PF SR-IOV resource that contains all
 VF(n) BAR space
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
	gwshan@linux.vnet.ibm.com
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 24 Feb 2015 02:33:09 -0600
Message-ID: <20150224083309.32124.29690.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

When we size VF BAR0, VF BAR1, etc., from the SR-IOV Capability of a PF, we
learn the alignment requirement and amount of space consumed by a single
VF.  But when VFs are enabled, *each* of the NumVFs consumes that amount of
space, so the total size of the PF resource is "VF BAR size * NumVFs".

Add a printk of the total space consumed by the VFs corresponding to what
we already do for normal non-IOV BARs.

No functional change; new message only.

[bhelgaas: split out into its own patch]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index c4c33ead03bc..05f9d97e4175 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -372,6 +372,8 @@ found:
 			goto failed;
 		}
 		res->end = res->start + resource_size(res) * total - 1;
+		dev_info(&dev->dev, "VF(n) BAR%d space: %pR (contains BAR%d for %d VFs)\n",
+			 i, res, i, total);
 		nres++;
 	}
 

