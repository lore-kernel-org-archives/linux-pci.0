Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] ACPI / PCI / PM: Delay resuming runtine-suspended devices during system-suspend
Date: Mon, 24 Feb 2014 00:18:22 +0100
Message-ID: <1853950.oxM3KDpyLu@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

The PCI bus type and the ACPI PM domain resume runtime-suspended devices during
their .prepare() callbacks, which is suboptimal.

One problem caused by that is increasing the time of system suspend if there
are many runtime-suspended devices to resume during it (because the .prepare()
callbacks are executed sequentially).

The following two patches are intended to improve that one aspect slightly
in those two subsystems.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
