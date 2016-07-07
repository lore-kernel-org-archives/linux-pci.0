Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 Jul 2016 01:43:50 +0200
Message-ID: <CAJZ5v0hDSZGX90hxkACwC0DktD-_Baq=+DDkR7_zv8464iHG-Q@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v4.7-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.7-rc7

to receive ACPI fixes for v4.7-rc7 with top-most commit
b6d90158c935d4a22e56f41647b479ab5ea449d4

 Merge branches 'acpica-fixes', 'acpi-pci-fixes' and 'acpi-debug-fixes'

on top of commit a99cde438de0c4c0cecc1d1af1a55a75b10bfdef

 Linux 4.7-rc6

All of these fix recent regressions in ACPICA, in the ACPI PCI IRQ
management code and in the ACPI AML debugger.

Specifics:

 - Fix a lock ordering issue in ACPICA introduced by a recent commit
   that attempted to fix a deadlock in the dynamic table loading code
   which in turn appeared after changes related to the handling of
   module-level AML also made in this cycle (Lv Zheng).

 - Fix a recent regression in the ACPI IRQ management code that may
   cause PCI drivers to be unable to register an IRQ if that IRQ
   happens to be shared with a device on the ISA bus, like the
   parallel port, by reverting one commit entirely and restoring the
   previous behavior in two other places (Sinan Kaya).

 - Fix a recent regression in the ACPI AML debugger introduced by
   the commit that removed incorrect usage of IS_ERR_VALUE() from
   multiple places (Lv Zheng).

Thanks!

---------------

Lv Zheng (2):
      ACPICA: Namespace: Fix namespace/interpreter lock ordering
      ACPI / debugger: Fix regression introduced by IS_ERR_VALUE() removal

Sinan Kaya (3):
      ACPI,PCI,IRQ: factor in PCI possible
      Revert "ACPI, PCI, IRQ: remove redundant code in acpi_irq_penalty_init()"
      ACPI,PCI,IRQ: separate ISA penalty calculation

---------------

 arch/x86/pci/acpi.c           |  1 +
 drivers/acpi/acpi_dbg.c       |  4 +--
 drivers/acpi/acpica/nsload.c  |  7 ++++-
 drivers/acpi/acpica/nsparse.c |  9 ++-----
 drivers/acpi/pci_link.c       | 63 ++++++++++++++++++++++++++++++++-----------
 include/acpi/acpi_drivers.h   |  1 +
 6 files changed, 60 insertions(+), 25 deletions(-)
