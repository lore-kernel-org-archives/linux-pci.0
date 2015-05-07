Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 7 May 2015 23:11:15 +0200
Message-ID: <CAJZ5v0iPW-DhwDyM1pZ=hG_sZeh3yMzh+T-Ej9k6uDpAXiBsUw@mail.gmail.com>
Subject: [GIT PULL] Power management and ACPI fixes for 4.1-rc3
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.1-rc3

to receive power management and ACPI fixes for v4.1-rc3 with
top-most commit 9a5d9315e41cc0dfc97a3b0a8e222d30566cf3fe

 Merge branches 'acpi-resources', 'acpi-battery', 'acpi-doc' and 'acpi-pnp'

on top of commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22

 Linux 4.1-rc2

These include three regression fixes (PCI resources management, ACPI/PNP
device enumeration, ACPI SBS on MacBook) and two ACPI documentation fixes
related to GPIO.

Specifics:

 - Fix for a PCI resources management regression introduced during
   the 4.0 cycle and related to the handling of ACPI resources'
   Producer/Consumer flags that turn out to be useless (Jiang Liu).

 - Fix for a MacBook regression related to the Smart Battery Subsystem
   (SBS) driver causing various problems (stalls on boot, failure to
   detect or report battery) to happen and introduced during the 3.18
   cycle (Chris Bainbridge).

 - Fix for an ACPI/PNP device enumeration regression introduced during
   the 3.16 cycle caused by failing to include two PNP device IDs into
   the list of IDs that PNP device objects need to be created for
   (Witold Szczeponik).

 - Fixes for two minor mistakes in the ACPI GPIO properties
   documentation (Antonio Ospite, Rafael J Wysocki).

Thanks!


---------------

Antonio Ospite (1):
      ACPI / documentation: fix a sentence about GPIO resources

Chris Bainbridge (1):
      ACPI / SBS: Add 5 us delay to fix SBS hangs on MacBook

Jiang Liu (1):
      x86/PCI/ACPI: Make all resources except [io 0xcf8-0xcff]
available on PCI bus

Rafael J. Wysocki (1):
      ACPI / documentation: Fix ambiguity in the GPIO properties document

Witold Szczeponik (1):
      ACPI / PNP: add two IDs to list for PNPACPI device enumeration

---------------

 Documentation/acpi/enumeration.txt     |  2 +-
 Documentation/acpi/gpio-properties.txt |  6 +++---
 arch/x86/pci/acpi.c                    | 24 ++++++++++++++++++++++--
 drivers/acpi/acpi_pnp.c                |  2 ++
 drivers/acpi/resource.c                |  2 +-
 drivers/acpi/sbshc.c                   | 22 ++++++++++++++++++++++
 6 files changed, 51 insertions(+), 7 deletions(-)
