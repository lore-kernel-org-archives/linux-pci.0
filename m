Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755596AbdLOUwv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Dec 2017 15:52:51 -0500
Date: Fri, 15 Dec 2017 14:52:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: John Strader <strader.john@code.jackst.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Quirk - broken_intx_masking - Ceton InfiniTV4
Message-ID: <20171215205244.GA30595@bhelgaas-glaptop.roam.corp.google.com>
References: <92a65068-60b2-c1a8-9e17-ac41fe3c5c93@code.jackst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <92a65068-60b2-c1a8-9e17-ac41fe3c5c93@code.jackst.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 14, 2017 at 05:12:59AM -0800, John Strader wrote:
> Submitting a device for quirk_broken_intx_masking, as requested by
> modinfo for vfio-pci "nointxmask" parameter.
> 
> The device is a Ceton InfiniTV4 [1b7c:0004].  I can confirm that this
> device operates correctly with vfio when passed the nointxmask
> parameter.  I can also confirm that applying quirk_broken_intx_masking
> via drivers/pci/quirks.c in a custom compiled kernel also works.  I no
> longer compile the custom kernel and seem to have misplaced the patch,
> so I won't bother remaking a one-liner, but it was of the standard form:
> 
> DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004,
>                         quirk_broken_intx_masking);

Thanks for your report!  I applied the patch below to pci/virtualization
for v4.16.

commit 7f50dcad8de026d7533a0d1295a27d843ce965aa
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Dec 15 14:51:44 2017 -0600

    PCI: Mark Ceton InfiniTV4 INTx masking as broken
    
    PCI_COMMAND_INTX_DISABLE is writable on the Ceton InfiniTV4, indicating
    that the device supports disabling the INTx# signal, but it apparently
    doesn't work.
    
    Mark the device so we know we can't use PCI_COMMAND_INTX_DISABLE to disable
    its interrupts.
    
    Link: https://lkml.kernel.org/r/92a65068-60b2-c1a8-9e17-ac41fe3c5c93@code.jackst.com
    Reported-by: John Strader <strader.john@code.jackst.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 10684b17d0bd..bb9737ec64b5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3215,6 +3215,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x0030,
 			quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
 			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004, /* Ceton InfiniTV4 */
+			quirk_broken_intx_masking);
 
 /*
  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
