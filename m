Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mario Limonciello <mario_limonciello@dell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans De Goede <hdegoede@redhat.com>
Subject: [PATCH 0/6] ACPI / PM: Suspend-to-idle rework to deal with spurious ACPI wakeups
Date: Thu, 08 Jun 2017 02:00:40 +0200
Message-ID: <8918199.uo13RZ8hZk@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

This series is a replacement for commit eed4d47efe95 (ACPI / sleep: Ignore
spurious SCI wakeups from suspend-to-idle) which is still there in 4.12-rc4 but
will be reverted shortly, because it triggered issues on quite a few systems.

The last patch in the series is a counterpart of the above commit with a few
modifications, mostly to avoid affecting suspend-to-RAM and to reorder messages
printed to kernel logs to make them somewhat less confusing.

The previous patches are pre-requisite changes plus some cleanups.  The major
ones are [1-2/6] and [4/6] that are really needed for things to work as expected
after [6/6].

In addition to that, this patch from Hans: https://patchwork.kernel.org/patch/9762815/
is needed for USB wakeup on Bay Trail and Cherry Trail systems to work in general.

Thanks,
Rafael

