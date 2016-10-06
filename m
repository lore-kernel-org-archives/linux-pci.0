Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:42905 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbcJFGYe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2016 02:24:34 -0400
Message-Id: <cover.1475733022.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 6 Oct 2016 08:24:29 +0200
Subject: [PATCH 0/1] x86/platform/intel-mid: Retrofit pci_platform_pm_ops
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, x86@kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Somehow it went completely under my radar that v4.8 added another
struct pci_platform_pm_ops for Intel Mobile Internet Devices.

There's a commit queued for v4.9 on Bjorn's pci/pm branch which adds
a mandatory ->get_power hook to pci_platform_pm_ops and implements
it for acpi_pci_platform_pm, but not mid_pci_platform_pm.

The following patch fixes that.  It's not a build issue, the missing
hook in mid_pci_platform_pm only becomes a problem at runtime.

@Andy: Could you look over this and provide an ack?  I do not have
an Intel MID so I was only able to compile-test the patch.

The ->get_power hook is currently only called to update a device's
current_state after resume (both at runtime and after system sleep)
and after changing its power state using the platform in
pci_platform_power_transition().  The result of the ->get_power hook
is ignored unless it's D3cold.  Since intel-mid PCI devices can only
be suspended to D3hot, the return value is irrelevant on this platform,
the hook just needs to be present to make pci_set_platform_pm() happy.

If you want to test the patch, you need to apply it either on Bjorn's
pci/pm branch or linux-next:
http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/pm

Thanks,

Lukas

Lukas Wunner (1):
  x86/platform/intel-mid: Retrofit pci_platform_pm_ops ->get_power hook

 arch/x86/include/asm/intel-mid.h  |  1 +
 arch/x86/platform/intel-mid/pwr.c | 19 +++++++++++++++++++
 drivers/pci/pci-mid.c             |  6 ++++++
 3 files changed, 26 insertions(+)

-- 
2.9.3

