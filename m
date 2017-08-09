Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lv Zheng <lv.zheng@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 0/3] ACPI: Initialize GPEs before the initial namespace scan
Date: Thu, 10 Aug 2017 00:29:12 +0200
Message-ID: <12346760.yAFCnkEgf6@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

This is exceptional for at least two reasons.

First, we need it now to work around boot problems on multiple platforms
already seen in the field (which are shipping products).

Second, the ACPICA changes in this series are kind of Linux-specific, because
they are related to how Linux carries out the initialization of devices, which
very well may be different from what the other OSes using ACPICA do.

For these reasons, I'd like to make the following ACPICA changes in Linux
only for the time being and then decide whether or not to take them into
the upstream.  If there are major concerns about that, please let me know.

The issue at hand is that some platforms with Thunderbolt controllers won't
boot if there are any Thunderbolt devices connected to them at boot time (if
the devices are connected later, everything works as expected).  That turns
out to be related to a complicated sequence of events involving the platform
firmware which needs to happen in exactly the right order at the right time
for things to work and that requires GPEs to be enabled before enumerating
the PCI bus.

The first patch changes ACPICA to check the status of runtime GPEs before
enabling them for the first time in order to avoid missing events (that
is key for edge-triggered GPEs) and to process them early enough.

The second one makes it possible to change the ordering of initialization
between GPEs and devices, and the third one actually changes that ordering.

The patches are based on Mika's work, so kudos to him.

Thanks,
Rafael

