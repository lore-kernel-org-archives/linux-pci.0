Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33371 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932833AbbDITMj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2015 15:12:39 -0400
Received: by oblw8 with SMTP id w8so146796125obl.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2015 12:12:39 -0700 (PDT)
Date: Thu, 9 Apr 2015 14:12:35 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] pci.txt: clarify vendor ID policy
Message-ID: <20150409191235.GI30967@google.com>
References: <1427704341-14125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427704341-14125-1-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 30, 2015 at 10:32:34AM +0200, Michael S. Tsirkin wrote:
> Top of include/linux/pci_ids.h says:
> 	Do not add new entries to this file unless the definitions
> 	are shared between multiple drivers.
> on the other hand, Documentation/PCI/pci.txt seems to imply that all
> vendor IDs should be added in include/linux/pci_ids.h.
> 
> Clarify text pci.txt to avoid the apparent contradiction.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied to pci/misc for v4.1 in the following form.  Thanks!


commit b3d3d4d67569ad726530d8de3d7aa334c7e7465b
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Mon Mar 30 10:32:34 2015 +0200

    PCI: Clarify policy for vendor IDs in pci.txt
    
    Clarify pci.txt so it matches the "do not add new entries unless they are
    sahred between multiple drivers" comment in include/linux/pci_ids.h.
    
    [bhelgaas: changelog, strengthen language]
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/Documentation/PCI/pci.txt b/Documentation/PCI/pci.txt
index 9518006f6675..123881f62219 100644
--- a/Documentation/PCI/pci.txt
+++ b/Documentation/PCI/pci.txt
@@ -564,14 +564,14 @@ to be handled by platform and generic code, not individual drivers.
 8. Vendor and device identifications
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-One is not required to add new device ids to include/linux/pci_ids.h.
-Please add PCI_VENDOR_ID_xxx for vendors and a hex constant for device ids.
+Do not add new device or vendor IDs to include/linux/pci_ids.h unless they
+are shared across multiple drivers.  You can add private definitions in
+your driver if they're helpful, or just use plain hex constants.
 
-PCI_VENDOR_ID_xxx constants are re-used. The device ids are arbitrary
-hex numbers (vendor controlled) and normally used only in a single
-location, the pci_device_id table.
+The device IDs are arbitrary hex numbers (vendor controlled) and normally used
+only in a single location, the pci_device_id table.
 
-Please DO submit new vendor/device ids to pciids.sourceforge.net project.
+Please DO submit new vendor/device IDs to http://pciids.sourceforge.net/.
 
 
 
