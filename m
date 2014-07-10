Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:42837 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbaGJPr5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jul 2014 11:47:57 -0400
Received: by mail-la0-f52.google.com with SMTP id gl10so954378lab.25
        for <linux-pci@vger.kernel.org>; Thu, 10 Jul 2014 08:47:55 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 10 Jul 2014 16:47:55 +0100
Message-ID: <CAFJTrDt146269JkQ7eRcgGxk=4EEQ2XK+Rbe11Y+6URr=LQzrA@mail.gmail.com>
Subject: [PATCH RFC] Added code to ensure hot-added PCI devices are given an
 IRQ on rescan
From: Matthew Minter <matthew_minter@xyratex.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some boards which contain physically hot-pluggable PCIe slots such as
8639 connectors can hot-add devices simply by connecting them while up
and writing to /sys/bus/pci/rescan.

This probes the device and loads a driver. However when a device is
added in this way it is not given an interrupt. Irqs seem to be passed
by the PCI BIOS, or emulated PCI BIOS in the case of non x86 arches
and so these hot-added cards naturally do not get one.

This means that when a device is added in this way, unless the device
and driver use only MSI/MSI-X it will try to request irq vector 0
which does not end well. To prevent this I have added a check for an
empty irq vector and use pdev_fixup_irq to set one at run time if one
has not been provided. This is done inside an unlikely block in order
to make negligible the performance impact on the normal PCI device
adding code path, this should not be a performance critical area
anyway as devices are not often added.

I have looked into instead modifying the rescan code however this
would be a less effective solution as there is no convenient way there
to run code between device probing and the driver loading and so would
need a significant redesign.

If anyone has any suggestions or feedback on this patch, or a better
way to solve this issue should there be one, I would be very grateful.

In addition I have only had the opportunity to test this code on non
x86 platforms so if anyone has a x86 or AMD64 PC with physical hot-add
capability I would be very appreciative if you could try running this.

Best regards,
Matthew

drivers/pci/bus.c | 11 +++++++++++
drivers/pci/setup-irq.c | 2 +-
include/linux/pci.h | 2 ++
3 files changed, 14 insertions(+), 1 deletion(-)

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
