Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34460 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932092AbdBHIqz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2017 03:46:55 -0500
Received: by mail-pg0-f67.google.com with SMTP id v184so14598182pgv.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Feb 2017 00:46:29 -0800 (PST)
Date: Wed, 8 Feb 2017 00:46:26 -0800
From: Yinghai Lu <yinghai@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: pciehp is broken from 4.10-rc1
Message-ID: <20170208084624.GA13086@linux-siqj.site>
References: <20170204081254.GA29595@wunner.de>
 <20170204185607.GA29957@wunner.de>
 <CAE9FiQUuFJHMScyFgnHbs5r-SzTiRiBZ2JcpUYJhg0ft75-OBQ@mail.gmail.com>
 <20170204233443.GA234@wunner.de>
 <CAE9FiQW5SQsQfRCz9sor4kufogTRVpHXekPHSi8MSi46mvXGLQ@mail.gmail.com>
 <20170205073454.GA253@wunner.de>
 <20170206204249.GA679@wunner.de>
 <CAE9FiQXSmB6Cs55nFtdw3rRrVrivwpDGNTwLwYtvWCEe4nsuHg@mail.gmail.com>
 <20170207060811.GA791@wunner.de>
 <CAE9FiQUxAfzLvd1icaJr=i8n_cQs5PL2q3y3PW9HYpaaPq8zZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQUxAfzLvd1icaJr=i8n_cQs5PL2q3y3PW9HYpaaPq8zZw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 07, 2017 at 10:08:13AM -0800, Yinghai Lu wrote:
> On Mon, Feb 6, 2017 at 10:08 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > Please retry with a stock v4.10-rc7 kernel and report back if the issue
> > persists.
> 
> sca05-0a81fd7f:~ # echo 1 > /sys/bus/pci/slots/7/power
> [  470.356464] pciehp 0000:73:00.0:pcie004: pciehp_get_power_status:
> SLOTCTRL a8 value read 17f1
> [  470.366662] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010
> from Slot Status
> [  470.375339] pciehp 0000:73:00.0:pcie004: pciehp_power_on_slot:
> SLOTCTRL a8 write cmd 0
> [  470.384199] pciehp 0000:73:00.0:pcie004: __pciehp_link_set: lnk_ctrl = 40
> [  470.391789] pciehp 0000:73:00.0:pcie004: pciehp_green_led_blink:
> SLOTCTRL a8 write cmd 200
> [  470.391966] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010
> from Slot Status
> [  470.428791] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010
> from Slot Status
> [  472.428147] pciehp 0000:73:00.0:pcie004: Data Link Layer Link
> Active not set in 1000 msec
> [  473.944158] pci 0000:74:00.0 id reading try 50 times with interval
> 20 ms to get ffffffff
> [  473.953209] pciehp 0000:73:00.0:pcie004: pciehp_check_link_status:
> lnk_status = 5001
> [  473.961861] pciehp 0000:73:00.0:pcie004: link training error: status 0x5001
> [  473.969642] pciehp 0000:73:00.0:pcie004: Failed to check link status
> [  473.970721] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010
> from Slot Status
> [  473.970818] pciehp 0000:73:00.0:pcie004: pciehp_power_off_slot:
> SLOTCTRL a8 write cmd 400
> [  475.000272] pciehp 0000:73:00.0:pcie004: pciehp_green_led_off:
> SLOTCTRL a8 write cmd 300
> [  475.000880] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010
> from Slot Status
> [  475.017879] pciehp 0000:73:00.0:pcie004:
> pciehp_set_attention_status: SLOTCTRL a8 write cmd 40
> [  475.018386] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010
> from Slot Status
> -bash: echo: write error: Operation not permitted

Following change could make it work:

---
 drivers/pci/hotplug/pciehp_ctrl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_ctrl.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_ctrl.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_ctrl.c
@@ -89,17 +89,17 @@ static int board_added(struct slot *p_sl
 	struct controller *ctrl = p_slot->ctrl;
 	struct pci_bus *parent = ctrl->pcie->port->subordinate;
 
+	pm_runtime_get_sync(&ctrl->pcie->port->dev);
 	if (POWER_CTRL(ctrl)) {
 		/* Power on slot */
 		retval = pciehp_power_on_slot(p_slot);
 		if (retval)
-			return retval;
+			goto err_exit;
 	}
 
 	pciehp_green_led_blink(p_slot);
 
 	/* Check link training status */
-	pm_runtime_get_sync(&ctrl->pcie->port->dev);
 	retval = pciehp_check_link_status(ctrl);
 	if (retval) {
 		ctrl_err(ctrl, "Failed to check link status\n");

after that change will get:

sca05-0a81fd7f:~ # echo 1 > /sys/bus/pci/slots/7/power 
[  300.949937] pci_hotplug: power_write_file: power = 1
[  300.955502] pciehp 0000:73:00.0:pcie004: pciehp_get_power_status: SLOTCTRL a8 value read 17f1
[  300.982557] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010 from Slot Status
[  300.991171] pciehp 0000:73:00.0:pcie004: pciehp_power_on_slot: SLOTCTRL a8 write cmd 0
[  301.000033] pciehp 0000:73:00.0:pcie004: pciehp_green_led_blink: SLOTCTRL a8 write cmd 200
[  301.009274] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010 from Slot Status
[  301.662172] pciehp 0000:73:00.0:pcie004: pciehp_check_link_active: lnk_status = f083
[  301.670827] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0108 from Slot Status
[  301.679376] pciehp 0000:73:00.0:pcie004: Slot(7): Link Up
[  301.685463] pciehp 0000:73:00.0:pcie004: Slot(7): Link Up event ignored; already powering on
[  301.685508] pciehp 0000:73:00.0:pcie004: pciehp_check_link_active: lnk_status = f083
[  302.005967] pciehp 0000:73:00.0:pcie004: pciehp_check_link_status: lnk_status = f083
[  302.014859] pci 0000:74:00.0: [15b3:1003] type 00 class 0x0c0600
...

that means in commit 68db9bc8 changelog about power on does not need D0
-----
  Even turning on slot power doesn't seem
  to require the port to be in D0, at least the PCIe spec doesn't say so
  and I confirmed that by testing with a Thunderbolt controller.
-----
may not stand on this silicon.

Thanks

Yinghai
