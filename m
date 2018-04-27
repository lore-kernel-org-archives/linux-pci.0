Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758069AbeD0TWJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Apr 2018 15:22:09 -0400
Date: Fri, 27 Apr 2018 14:22:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
Message-ID: <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
References: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Lukas, Sinan]

Hi Paul,

Thanks for the report!

On Thu, Apr 26, 2018 at 12:17:53PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Lenovo X60t, during resume from ACPI suspend and during shutdown, the
> message below is shown in the logs.
> 
>     pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038 (issued
> 65284 msec ago)

This is an Intel root port:

  00:1c.0 PCI bridge: Intel Corporation NM10/ICH7 Family PCI Express Port 1 (rev 02) (prog-if 00 [Normal decode])

and probably has the CF118 erratum (see
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3461a068661c
for details).  I bet if you changed "msecs" in pcie_wait_cmd() to 30000
you'd see a 30 second delay during shutdown because we write a command to
tell the port not to generate any more hotplug interrupts, and we wait for
that command to complete, but the port never tells us it has completed.

Lukas reported a similar issue in
https://lkml.kernel.org/r/20180112104929.GA10599@wunner.de, which we sort
of worked around by assuming that Thunderbolt controllers never support
that "command complete" interrupt (see
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=493fb50e958c)

Sinan mooted the idea of using a "no-wait" path of sending the "don't
generate hotplug interrupts" command.  I think we should work on this
idea a little more.  If we're shutting down the whole system, I can't
believe there's much value in *anything* we do in the pciehp_remove()
path.

Maybe we should just get rid of pciehp_remove() (and probably
pcie_port_remove_service() and the other service driver remove methods)
completely.  That dates from when the service drivers could be modules that
could be potentially unloaded, but unloading them hasn't been possible for
years.

As far as the resume path, my guess is that in pciehp_resume(), we
write a command to enable interrupts, then it looks like we get a
PCI_EXP_SLTSTA_DLLSC "Link Up" interrupt, and apparently we issue
another command.  Not sure exactly what's going on here.

Could you try the following patch?  The idea is to (1) do nothing on
shutdown, so you should see no message and no delay, and (2) collect
more information about the resume path.


diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 332b723ff9e6..99751cc52968 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -260,14 +260,6 @@ static int pciehp_probe(struct pcie_device *dev)
 	return -ENODEV;
 }
 
-static void pciehp_remove(struct pcie_device *dev)
-{
-	struct controller *ctrl = get_service_data(dev);
-
-	cleanup_slot(ctrl);
-	pciehp_release_ctrl(ctrl);
-}
-
 #ifdef CONFIG_PM
 static int pciehp_suspend(struct pcie_device *dev)
 {
@@ -305,7 +297,6 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
 	.service	= PCIE_PORT_SERVICE_HP,
 
 	.probe		= pciehp_probe,
-	.remove		= pciehp_remove,
 
 #ifdef	CONFIG_PM
 	.suspend	= pciehp_suspend,
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 18a42f8f5dc5..c3a9c47ed061 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -113,7 +113,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 	return 0;	/* timeout */
 }
 
-static void pcie_wait_cmd(struct controller *ctrl)
+static void pcie_wait_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 {
 	unsigned int msecs = pciehp_poll_mode ? 2500 : 1000;
 	unsigned long duration = msecs_to_jiffies(msecs);
@@ -155,10 +155,13 @@ static void pcie_wait_cmd(struct controller *ctrl)
 	 * don't change those bits, e.g., commands that merely enable
 	 * interrupts.
 	 */
-	if (!rc)
-		ctrl_info(ctrl, "Timeout on hotplug command %#06x (issued %u msec ago)\n",
+	if (!rc) {
+		ctrl_info(ctrl, "Timeout on hotplug command %#06x (issued %u msec ago), new command %#06x/mask %#06x\n",
 			  ctrl->slot_ctrl,
-			  jiffies_to_msecs(jiffies - ctrl->cmd_started));
+			  jiffies_to_msecs(jiffies - ctrl->cmd_started),
+			  cmd, mask);
+		dump_stack();
+	}
 }
 
 static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
@@ -172,7 +175,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	/*
 	 * Always wait for any previous command that might still be in progress
 	 */
-	pcie_wait_cmd(ctrl);
+	pcie_wait_cmd(ctrl, cmd, mask);
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
 	if (slot_ctrl == (u16) ~0) {
@@ -193,7 +196,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	 * indicating completion of the above issued command.
 	 */
 	if (wait)
-		pcie_wait_cmd(ctrl);
+		pcie_wait_cmd(ctrl, cmd, mask);
 
 out:
 	mutex_unlock(&ctrl->ctrl_lock);
