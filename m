Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 0/4] ACPI / bind: Simplify child devices lookup
Date: Mon, 25 Nov 2013 01:09:30 +0100
Message-ID: <2610478.KxPMyuOMok@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

The following series of four patches (on top of current linux-pm.git/bleeding-edge)
rework child device lookup in drivers/acpi/glue.c and related things:

[1/4] ACPI / bind: Simplify child device lookup
[2/4] PCI/ ACPI: Use acpi_find_child_device() for child device lookup
[3/4] ACPI / bind: Redefine acpi_get_child()
[4/4] ACPI / bind: Redefine acpi_preset_companion()

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
