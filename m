Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52550 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752152AbdFSVpv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 17:45:51 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/6] PM: Unify the handling of device wakeup settings
Date: Mon, 19 Jun 2017 23:31:58 +0200
Message-ID: <12296383.UdE5HVtyng@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

The handling of device wakeup settings, especially in the ACPI core and the PCI
bus type, depends on whether it is about system wakeup from sleep states or
remote wakeup in the working state (runtime).  However, that distinction is
mostly based on the ACPI concept of "wakeup" and "runtime" GPEs, which is
somewhat artificial, because the underlying hardware mechanism is basically
the same in both cases.

Moreover, suspend-to-idle is now supported as a sleep state and wakeup from it
is based on exactly the same hardware capabilities as the working-state
(runtime) remote wakeup.

The following patch series removes that distinction and unifies the handling of
device wakeup settings between system sleep and runtime.  It also fixes one
issue related to wakeup signaling through PCI bridges.

[1/6]: Get rid of the "runtime wakeup" concept from the ACPI core.
[2/6]: Unify device wakeup settings code paths in the ACPI core.
[3-4/6]: Unify device wakeup settings code paths in the PCI bus type code.
[5/6]: Fix wakeup-related issue with bridges in the PCI bus type code.
[6/6]: Get rid of the "runtime wakeup" concept from the driver core.

The series is based on current linux-next and will be made available for
testing in the linux-pm.git tree in a couple of days.

Thanks,
Rafael
