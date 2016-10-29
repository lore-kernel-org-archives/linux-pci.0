Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 29 Oct 2016 02:58:51 +0200
Message-ID: <CAJZ5v0g3+QAGPG17+JNekqapk_YHNXQ-_067Vde5qXfJkGUu-A@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v4.9-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.9-rc3

with top-most commit 21e2d9d5292f8a5cd1aa4e63891437589d233d35

 Merge branches 'acpica-fixes', 'acpi-pci-fixes' and 'acpi-apei-fixes'

on top of commit 07d9a380680d1c0eb51ef87ff2eab5c994949e69

 Linux 4.9-rc2

to receive ACPI fixes for v4.9-rc3.

These fix recent ACPICA regressions, an older PCI IRQ management
regression, and an incorrect return value of a function in the APEI
code.

Specifics:

 - Fix three ACPICA issues related to the interpreter locking and
   introduced by recent changes in that area (Lv Zheng).

 - Fix a PCI IRQ management regression introduced during the 4.7
   cycle and related to the configuration of shared IRQs on systems
   with an ISA bus (Sinan Kaya).

 - Fix up a return value of one function in the APEI code (Punit
   Agrawal).

Thanks!


---------------

Lv Zheng (3):
      ACPICA: Dispatcher: Fix order issue of method termination
      ACPICA: Dispatcher: Fix an unbalanced lock exit path in
acpi_ds_auto_serialize_method()
      ACPICA: Dispatcher: Fix interpreter locking around
acpi_ev_initialize_region()

Punit Agrawal (1):
      ACPI / APEI: Fix incorrect return value of ghes_proc()

Sinan Kaya (3):
      ACPI/PCI/IRQ: assign ISA IRQ directly during early boot stages
      ACPI/PCI: pci_link: penalize SCI correctly
      ACPI/PCI: pci_link: Include PIRQ_PENALTY_PCI_USING for ISA IRQs

---------------

 arch/x86/kernel/acpi/boot.c    |  1 +
 drivers/acpi/acpica/dsinit.c   | 11 +++-------
 drivers/acpi/acpica/dsmethod.c | 50 +++++++++++++++++++-----------------------
 drivers/acpi/acpica/dswload2.c |  2 --
 drivers/acpi/acpica/evrgnini.c |  3 +++
 drivers/acpi/acpica/nsload.c   |  2 ++
 drivers/acpi/apei/ghes.c       |  2 +-
 drivers/acpi/pci_link.c        | 38 ++++++++++++++++++--------------
 include/linux/acpi.h           |  1 +
 9 files changed, 54 insertions(+), 56 deletions(-)
