Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33586 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbHCEO4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2015 00:14:56 -0400
Received: by igbpg9 with SMTP id pg9so64525581igb.0
        for <linux-pci@vger.kernel.org>; Sun, 02 Aug 2015 21:14:56 -0700 (PDT)
Date: Sun, 2 Aug 2015 23:14:51 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jarod Wilson <jarod@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/pciehp: bail on bogus pcie reads from removed devices
Message-ID: <20150803041451.GA11144@google.com>
References: <1437495930-7723-1-git-send-email-jarod@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1437495930-7723-1-git-send-email-jarod@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 21, 2015 at 12:25:30PM -0400, Jarod Wilson wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=99841
> 
> Seems like a read of all 1's from a register of a device that has gone
> away should be taken as a sign that the device has gone away.
> Section 6.2.10 of the PCIE spec (v4.0, rev 0.3, Feb 19, 2014) suggests as
> much with this snippet:
> 
> |IMPLEMENTATION NOTE
> |Data Value of All 1’s
> |Many platforms, including those supporting RP Extensions for DPC, can
> |return a data value of all 1’s to software when an error is associated
> |with a PCI Express Configuration, I/O, or Memory Read Request. During DPC,
> |the Downstream Port discards Requests destined for the Link and completes
> |them with an error (i.e., either with an Unsupported Request (UR) or
> |Completer Abort (CA) Completion Status). By ending a series of MMIO or
> |configuration space operations with a read to an address with a known
> |data value not equal to all 1’s, software may determine if a Completer
> |has been removed or DPC has been triggered.
> 
> I'm not sure the above is directly relevant to this case, but the same
> principle (reading all 1's means the device is probably gone) seems to
> hold.
> 
> This is based on part of a debugging patch Bjorn posted in the referenced
> bugzilla, and its required to make the HP ZBook G2 I've got here not barf
> when disconnecting a thunderbolt ethernet adapter and corrupt memory.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: linux-pci@vger.kernel.org
> Signed-off-by: Jarod Wilson <jarod@redhat.com>

Hi Jarod,

I think there are two issues here:

  1) pciehp doesn't handle all 1's correctly
  2) use-after-free of hotplug_slot

This patch is for the first issue.  I think it's correct, but I still
have a question or two.   I attached an updated version of the patch
and changelog.

Here's the path I think we're taking: 03:03.0 receives pciehp
interrupt for removal (link down and card not present), and we call
pciehp_unconfigure_device() for 05:00.0 and everything downstream from
it.  Part of this is removing 06:00.0.  I expected this would use this
path:

  pcie_port_remove_service            # .remove method for 06:00.0
    dev_printk("unloading service driver ...")
    pciehp_remove                     # hpdriver_portdrv.remove
      pciehp_release_ctrl
        pcie_shutdown_notification
          pcie_disable_notification
            pcie_write_cmd
              pcie_do_write_cmd(..., true)    # wait
                pcie_wait_cmd
                  pcie_poll_cmd
                    read PCI_EXP_SLTSTA        # would get 0xffff
                read PCI_EXPT_SLTCTL        # would get 0xffff

so I added checks for ~0 data in pcie_poll_cmd() and
pcie_do_write_cmd().

But the dmesg log shows that we were in pcie_isr(), and I don't
understand yet how we got there.  Can you help figure that out?  Maybe
put a dump_stack() in pcie_isr() or something?


OK, now for the second issue.  I think we have a lifetime issue with
the hotplug_slot structure.

  pcie_port_remove_service            # .remove method
    "unloading service driver ..."
    pciehp_remove                     # hpdriver_portdrv.remove
      cleanup_slot
        pci_hp_deregister(ctrl->slot->hotplug_slot)
          hotplug->release
            release_slot              # hotplug->release
              ctrl_dbg("release_slot: physical_slot = 9")
              kfree(hotplug_slot->ops)
              kfree(hotplug_slot->info)
              kfree(hotplug_slot)     # <--- FREE
          pci_slot->hotplug = NULL
          pci_destroy_slot
            kobject_put(pci_slot->kobj)
      pciehp_release_ctrl
        pcie_shutdown_notification
          pcie_disable_notification
            pcie_write_cmd
            ...

      pcie_isr                                # not sure how we got here
        ctrl_info("Latch open on Slot(%s)", slot_name(slot))  # <--- USE

I haven't chased this down completely either, but I'm pretty sure
we're looking at ctrl->slot->hotplug_slot to get the name after we've
already freed it, and this accounts for the garbage slot names we
print.

This seems like a pretty serious problem as well, but I don't
understand it well enough to propose a fix.

I suspect both of these issues affect all the hotplug drivers, not
just pciehp.

Bjorn


commit b24e231a9e846f0420746a56cea7a48b41f3798b
Author: Jarod Wilson <jarod@redhat.com>
Date:   Tue Jul 21 12:25:30 2015 -0400

    PCI: pciehp: Handle invalid data when reading from non-existent devices
    
    It's platform-dependent, but an MMIO read to a non-existent PCI device
    generally returns data with all bits set.  This happens when the host
    bridge or Root Complex times out waiting for a response from the device and
    fabricates return data to complete the CPU's read.
    
    One example, reported in the bugzilla below, involved this hierarchy:
    
      pci 0000:00:1c.0: PCI bridge to [bus 02-3a] Root Port
      pci 0000:02:00.0: PCI bridge to [bus 03-0a] Upstream Port
      pci 0000:03:03.0: PCI bridge to [bus 05-07] Downstream Port
      pci 0000:05:00.0: PCI bridge to [bus 06-07] Thunderbolt Upstream Port
      pci 0000:06:00.0: PCI bridge to [bus 07]    Thunderbolt Downstream Port
      pci 0000:07:00.0: BCM57762 NIC
    
    Unplugging the Thunderbolt switch and the NIC below it resulted in this:
    
      pciehp 0000:03:03.0: Surprise Removal
      tg3 0000:07:00.0: tg3_abort_hw timed out, TX_MODE_ENABLE will not clear MAC_TX_MODE=ffffffff
      pciehp 0000:06:00.0: unloading service driver pciehp
      pciehp 0000:06:00.0: pcie_isr: intr_loc 11f
      pciehp 0000:06:00.0: Switch interrupt received
      pciehp 0000:06:00.0: Latch open on Slot
      pciehp 0000:06:00.0: Attention button interrupt received
      pciehp 0000:06:00.0: Button pressed on Slot
      pciehp 0000:06:00.0: Presence/Notify input change
      pciehp 0000:06:00.0: Card present on Slot
      pciehp 0000:06:00.0: Power fault interrupt received
      pciehp 0000:06:00.0: Data Link Layer State change
      pciehp 0000:06:00.0: Link Up event
    
    The pciehp driver correctly noticed that the Thunderbolt switch (05:00.0
    and 06:00.0) and NIC (07:00.0) had been removed, and it called their driver
    remove methods.
    
    Since the NIC was already gone, tg3 received 0xffffffff when it tried to
    read from the device.  The resulting timeout is a tg3 issue and not of
    interest here.
    
    Similarly, since the 06:00.0 Thunderbolt switch was already gone,
    pcie_isr() received 0xffff when it tried to read PCI_EXP_SLTSTA, and pciehp
    thought that was valid status showing that many events had happened: the
    latch had been opened, the attention button had been pressed, a card was
    now present, and the link was now up.  These are all wrong, of course, but
    pciehp went on to try to power up and enumerate devices below the
    non-existent bridge:
    
      pciehp 0000:06:00.0: PCI slot - powering on due to button press
      pciehp 0000:06:00.0: Surprise Insertion
      pci 0000:07:00.0 id reading try 50 times with interval 20 ms to get ffffffff
    
    [bhelgaas: changelog, also check in pcie_poll_cmd() & pcie_do_write_cmd()]
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=99841
    Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
    Signed-off-by: Jarod Wilson <jarod@redhat.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index daf54be..8f3d3cf 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -111,6 +111,12 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 
 	while (true) {
 		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+		if (slot_status == (u16) ~0) {
+			ctrl_info(ctrl, "%s: no response from device\n",
+				  __func__);
+			return 0;
+		}
+
 		if (slot_status & PCI_EXP_SLTSTA_CC) {
 			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
 						   PCI_EXP_SLTSTA_CC);
@@ -186,6 +192,11 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	pcie_wait_cmd(ctrl);
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	if (slot_ctrl == (u16) ~0) {
+		ctrl_info(ctrl, "%s: no response from device\n", __func__);
+		goto out;
+	}
+
 	slot_ctrl &= ~mask;
 	slot_ctrl |= (cmd & mask);
 	ctrl->cmd_busy = 1;
@@ -201,6 +212,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	if (wait)
 		pcie_wait_cmd(ctrl);
 
+out:
 	mutex_unlock(&ctrl->ctrl_lock);
 }
 
@@ -542,6 +554,11 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	intr_loc = 0;
 	do {
 		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &detected);
+		if (detected == (u16) ~0) {
+			ctrl_info(ctrl, "%s: no response from device\n",
+				  __func__);
+			return IRQ_HANDLED;
+		}
 
 		detected &= (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
 			     PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
