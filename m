Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37632 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbbE2XjU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2015 19:39:20 -0400
MIME-Version: 1.0
Date: Sat, 30 May 2015 01:39:19 +0200
Message-ID: <CAJZ5v0i5Z5rn49Qk33Ygnriu_UWeeoeMxe01UGbX86ov+8H8YQ@mail.gmail.com>
Subject: [GIT PULL] PCI / ACPI fix for 4.1-rc6
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-pci-4.1-rc6

to receive a fix for the ACPI PCI host bridge initialization code
as commit dc4fdaf0e4839109169d8261814813816951c75f

 PCI / ACPI: Do not set ACPI companions for host bridges with parents

on top of commit ba155e2d21f6bf05de86a78dbe5bfd8757604a65

 Linux 4.1-rc5

This fixes a bug uncovered by a recent driver core change that
modified the implementation of the ACPI_COMPANION_SET() macro to
strictly rely on its second argument to be either NULL or a valid
pointer to struct acpi_device.

As it turns out, pcibios_root_bridge_prepare() on x86 and ia64
works with the assumption that the only code path calling
pci_create_root_bus() is pci_acpi_scan_root() and therefore
the sysdata argument passed to it will always match the
expectations of pcibios_root_bridge_prepare().  That need not
be the case, however, and in particular it is not the case for
the Xen pcifront driver that passes a pointer to its own private
data strcture as sysdata to pci_scan_bus_parented() which then
passes it to pci_create_root_bus() and it ends up being used
incorrectly by pcibios_root_bridge_prepare().

Thanks!


---------------

Rafael J. Wysocki (1):
      PCI / ACPI: Do not set ACPI companions for host bridges with parents

---------------

 arch/ia64/pci/pci.c | 13 ++++++++++---
 arch/x86/pci/acpi.c | 13 ++++++++++---
 2 files changed, 20 insertions(+), 6 deletions(-)
