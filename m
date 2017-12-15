Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 15 Dec 2017 02:55:29 +0100
Message-ID: <CAJZ5v0gH4q9QygVhgh=etcdsQeGGSUDiY7PJ6k7BBZ6GRciQsQ@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v4.15-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.15-rc4

with top-most commit 3487972d7fa6c5143951436ada5933dcf0ec659d

 PM / sleep: Avoid excess pm_runtime_enable() calls in device_resume()

on top of commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36

 Linux 4.15-rc3

to receive a power management fix for 4.15-rc4.

This fixes an issue in two recent commits that may cause
pm_runtime_enable() to be called for too many times for some
devices during the "thaw" transition belonging to hibernation.

Thanks!


---------------

Rafael J. Wysocki (1):
      PM / sleep: Avoid excess pm_runtime_enable() calls in device_resume()

---------------

 drivers/acpi/device_pm.c  |  2 +-
 drivers/base/power/main.c | 15 +++++++++++++++
 drivers/pci/pci-driver.c  |  2 +-
 include/linux/pm.h        |  1 +
 4 files changed, 18 insertions(+), 2 deletions(-)
