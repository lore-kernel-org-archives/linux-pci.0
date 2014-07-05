Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:55498 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbaGEQ1L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 5 Jul 2014 12:27:11 -0400
Received: by mail-ie0-f176.google.com with SMTP id at1so2266653iec.7
        for <linux-pci@vger.kernel.org>; Sat, 05 Jul 2014 09:27:11 -0700 (PDT)
Date: Sat, 5 Jul 2014 10:27:08 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Guo Chao <yan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: don't UNSET valid resources when reassign fails
Message-ID: <20140705162708.GA6247@google.com>
References: <1403179096-12113-1-git-send-email-yan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403179096-12113-1-git-send-email-yan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 19, 2014 at 07:58:16PM +0800, Guo Chao wrote:
> Commit bd064f0a sets IORESOURCE_UNSET flag if resources can not be
> assgined. Part of these changes breaks resource assignment.
> 
> If resource is too big, PCI core assgins basic part first and
> extends (reassigns) it to include optional part (notably SR-IOV resources).
> In this case, IORESOURCE_UNSET should not be set if resource is properly
> assigned before reassigning. Otherwise, these resources are never updated
> to hardware and we will see errors like this:
> 
> 	pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
> 	pci 0003:00:00.0: Error enabling bridge (-22), continuing
> 
> Signed-off-by: Guo Chao <yan@linux.vnet.ibm.com>

I propose the following simpler patch.  Can you verify that it works for
you?


commit 57ece376a3b9e013277032f473197052f1144142
Author: Guo Chao <yan@linux.vnet.ibm.com>
Date:   Thu Jul 3 18:30:29 2014 -0600

    PCI: Keep original resource if we fail to expand it
    
    If we have space assigned to a resource, we try to expand the resource
    (e.g., to accommodate SR-IOV resources), and the expansion attempt fails,
    we should keep the original assignment.
    
    After bd064f0a231a ("PCI: Mark resources as IORESOURCE_UNSET if we can't
    assign them"), we left the resource marked IORESOURCE_UNSET when the
    expansion failed, even if it had originally been set.  That caused errors
    like this:
    
      pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
      pci 0003:00:00.0: Error enabling bridge (-22), continuing
    
    Fix this by restoring the original flags when reassignment fails.
    
    [bhelgaas: reworked to simplify, changelog]
    Fixes: bd064f0a231a ("PCI: Mark resources as IORESOURCE_UNSET if we can't assign them")
    Signed-off-by: Guo Chao <yan@linux.vnet.ibm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: stable@vger.kernel.org	# v3.15+

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index caed1ce6facd..9faebcfeec4d 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -320,9 +320,11 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
 			resource_size_t min_align)
 {
 	struct resource *res = dev->resource + resno;
+	unsigned long flags;
 	resource_size_t new_size;
 	int ret;
 
+	flags = res->flags;
 	res->flags |= IORESOURCE_UNSET;
 	if (!res->parent) {
 		dev_info(&dev->dev, "BAR %d: can't reassign an unassigned resource %pR\n",
@@ -339,7 +341,12 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
 		dev_info(&dev->dev, "BAR %d: reassigned %pR\n", resno, res);
 		if (resno < PCI_BRIDGE_RESOURCES)
 			pci_update_resource(dev, resno);
+	} else {
+		res->flags = flags;
+		dev_info(&dev->dev, "BAR %d: %pR (failed to expand by %#llx)\n",
+			 resno, res, addsize);
 	}
+
 	return ret;
 }
 
