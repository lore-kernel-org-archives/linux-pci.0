Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Feb 2016 15:22:55 +0100
Message-ID: <CAJZ5v0jN_7Y09NMrhhJmyKGqmtyHvnaDB+xb_ddtPLaVOQBXfg@mail.gmail.com>
Subject: [GIT PULL] Power management and ACPI fixes for v4.5-rc6
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
 pm+acpi-4.5-rc6

to receive power management and ACPI fixes for v4.5-rc6 with top-most
commit 1711fd9cf92f366d42da29b108746accd807789a

 Merge branches 'pm-devfreq' and 'acpi-pci'

on top of commit 81f70ba233d5f660e1ea5fe23260ee323af5d53a

 Linux 4.5-rc5

These are two reverts of recent PCI-related ACPI core changes (one
of which caused some systems to crash on boot and the other was
a cleanup on top of it) and a devfreq fix for Tegra.

Specifics:

 - Revert an ACPI core change related to IRQ management in PCI
   that introduced code relying on the use of kmalloc() which
   turned out to also run during early init when that's not
   available yet and caused some systems to crash on boot for
   this reason along with a cleanup on top of it (Rafael Wysocki).

 - Prevent devfreq from flooding the kernel log with useless
   messages on Tegra (which started to happen after some recent
   changes in the devfreq core) by fixing the driver to follow
   the documentation and the core's expectations in its ->target
   callback (Tomeu Vizoso).

Thanks!

---------------

Rafael J. Wysocki (2):
      Revert "ACPI / PCI: Simplify acpi_penalize_isa_irq()"
      Revert "ACPI, PCI, irq: remove interrupt count restriction"

Tomeu Vizoso (1):
      PM / devfreq: tegra: Set freq in rate callback

---------------

 drivers/acpi/pci_link.c         | 128 +++++++++++-----------------------------
 drivers/devfreq/tegra-devfreq.c |   2 +
 2 files changed, 36 insertions(+), 94 deletions(-)
