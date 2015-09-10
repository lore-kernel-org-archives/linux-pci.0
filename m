Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52795 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736AbbIJNAP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Sep 2015 09:00:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1Za1SM-0000dJ-CL
	for linux-pci@vger.kernel.org; Thu, 10 Sep 2015 15:00:12 +0200
Received: from 192.107.155.4 ([192.107.155.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2015 15:00:02 +0200
Received: from faj6816 by 192.107.155.4 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2015 15:00:02 +0200
To: linux-pci@vger.kernel.org
From: Frank Jenner <faj6816@rit.edu>
Subject: Multiple MSIs on ARM imx6q
Date: Thu, 10 Sep 2015 12:55:10 +0000 (UTC)
Message-ID: <loom.20150910T144529-230@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I'm trying to develop a driver for a PCIe device which utilizes multiple
MSIs (up to the full 32 allowable), but I cannot seem to enable more than
one when calling pci_enable_msi_range(). The host platform uses a Freescale
i.MX 6Quad ARM SoC and is running the "linux-fslc_4.1" kernel (from the
Yocto project).

With some investigation, I believe that this limitation is stemming from
arch_setup_msi_irqs() in drivers/pci/msi.c where there is an early return
with the comment "If an architecture wants to support multiple MSI, it needs
to override arch_setup_msi_irqs()". There appears to be no such override for
ARM.

My first question then, is:

1.) Are multiple MSIs simply not yet supported on ARM as of 4.1?

Both MSIs and ARM have been around for a while, and I doubt I'm the only
person who ever wanted to use multiple MSIs on ARM, so I can't help but
think maybe I'm overlooking something. I ran into a similar question
(http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/016858.html), but
as that was 5+ years ago, I'm wondering whether the situation has since changed.

Unfortunately, even if I work around the arch_setup_msi_irqs() limitation
(which I've done by trying out patches 448141 and 448142 from
http://patchwork.ozlabs.org/project/linux-pci/list/) and break through to
the assign_irq() function in drivers/pci/host/pcie-designware.c, I still
cannot allocate all 32 MSIs that my device reports.

It appears that one of the bits in the msi_irq_in_use bitmap is already set
prior to my driver requesting any MSIs, meaning there aren't enough free
slots for the 32 MSIs I am requesting, and causing the function to fail with
-ENOSPC. Based on the output from /proc/interrupts, I believe that the PCIe
PME service driver is consuming one of the 32 available MSI slots. Thus, my
second question is:

2.) Is it possible to leverage all 32 MSIs while still using PCIe PME?

I tried using the kernel command line argument pcie_pme=nomsi, but that
appeared to disable all MSIs for the device rather than just making the PME
service driver use some other mechanism.

Thank you.

