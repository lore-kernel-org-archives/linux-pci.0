Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:43772 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbbAURJa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jan 2015 12:09:30 -0500
Received: by mail-oi0-f50.google.com with SMTP id h136so4860635oig.9
        for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2015 09:09:30 -0800 (PST)
Date: Wed, 21 Jan 2015 11:09:27 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH] pci: Use hot-plug capable for testing presence on
Message-ID: <20150121170927.GA13072@google.com>
References: <1419275223-14602-1-git-send-email-keith.busch@intel.com>
 <20150116203330.GJ29776@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150116203330.GJ29776@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 16, 2015 at 02:33:30PM -0600, Bjorn Helgaas wrote:
> [+cc Rajat]
> 
> On Mon, Dec 22, 2014 at 12:07:03PM -0700, Keith Busch wrote:
> > The PCI-e Base specifically says Hot-Plug Surprise capability is for
> > removal only, but pciehp checked this to determine if it should handle a
> > slot event on device add. Lots of platform's pcie slots don't advertise
> > support for surprise removal, but are perfectly capable of handling
> > hot-add, so checking surprise removal is not appropriate.
> > 
> > This patch checks the Hot-Plug Capable bit in the slot capabilities to
> > determine if the detected presence on is a reliable event instead of
> > Hot-Plug Surprise.
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> 
> This seems reasonable to me, and I applied it to pci/hotplug for v3.20.

After our follow-up discussion, I replaced this patch with the following.
If anybody objects, let me know.

commit dc0c25c0ee9f92ba1872fdda9c2a0014611cf722
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Jan 21 10:28:07 2015 -0600

    PCI: pciehp: Handle surprise add even if surprise removal isn't supported
    
    The PCIe spec (r3.0, sec 7.8.9) says Hot-Plug Surprise indicates support
    for surprise *removal*, but pciehp checked this to determine if it should
    handle presence detect interrupts for device *addition*.
    
    Allow surprise device addition even if the slot doesn't advertise support
    for surprise removal.
    
    Keith has a platform with slots for front-loading SFF devices.  The slots
    do not have attention buttons and do not support surprise removal, but they
    do have presence detect.  In that case, we still want to use presence
    detect for device addition.
    
    Keith's original patch handled surprise insertions only if Hot-Plug Capable
    is set.  I think that test is superfluous because pciehp only claims slots
    that advertise Hot-Plug Capable (see get_port_device_capability()).
    
    Link: http://lkml.kernel.org/r/1419275223-14602-1-git-send-email-keith.busch@intel.com
    Based-on-patch-by: Keith Busch <keith.busch@intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index ff32e85e1de6..f052e951b23e 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -532,8 +532,6 @@ static void interrupt_event_handler(struct work_struct *work)
 		pciehp_green_led_off(p_slot);
 		break;
 	case INT_PRESENCE_ON:
-		if (!HP_SUPR_RM(ctrl))
-			break;
 		ctrl_dbg(ctrl, "Surprise Insertion\n");
 		handle_surprise_event(p_slot);
 		break;
