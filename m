Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Apr 2017 14:35:41 +0200
Message-ID: <CAJZ5v0gD9-p++50Z1oG2P5Q_=y2vVPEdaNHPU2YZviAsP5xZ6A@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v4.11-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.11-rc6

with top-most commit dc752d54fd3a69c882d24133810edeb22dda2d0d

 Merge branch 'acpi-scan-fixes'

on top of commit a71c9a1c779f2499fb2afc0553e543f18aff6edf

 Linux 4.11-rc5

to receive an ACPI fix for v4.11-rc6.

This fixes a core device enumeration code change made in 4.10, in
order to address a reported issue, that went too far.

Specifics:

 - Refine the check for the existence of _HID in find_child_checks()
   so that it doesn't trigger for device objects with device IDs
   made up by the kernel (Rafael Wysocki).

Thanks!

---------------

Rafael J. Wysocki (1):
      ACPI / scan: Prefer devices without _HID for _ADR matching

---------------

 drivers/acpi/glue.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
