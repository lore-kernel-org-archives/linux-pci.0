Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] PCI / ACPI / PM: Fix propagation of wakeup settings to bridges
Date: Fri, 21 Jul 2017 14:36:44 +0200
Message-ID: <3116391.JNS1F4DjTg@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

The device wakeup code in pci-acpi.c currently has a (theoretical) problem that
it can disable wakeup for a bridge prematurely in some obscure conditions.

This is described in some more detail in the changelog of patch [3/3] and it
has been there for quite a while, so it's nothing new, but it would be good
to fix it at last and hence this series.

Patches [1/3] and [2/3] are mostly preparatory, although the former may be
regarded as a fix by itself and the latter is a cleanup.

Thanks,
Rafael

