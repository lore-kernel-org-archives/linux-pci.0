Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:44223 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab3IFRN2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 13:13:28 -0400
Received: by mail-yh0-f44.google.com with SMTP id f64so245618yha.31
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2013 10:13:27 -0700 (PDT)
Subject: [PATCH 00/14] _OSC simplification
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Date: Fri, 06 Sep 2013 11:13:24 -0600
Message-ID: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a long series of mostly minor changes with the goal of
simplifying the _OSC-related code and making the negotiation between
Linux and the platform more understandable.

My intent is that this doesn't change any behavior except for the text
in dmesg.

However, this restructuring does raise some questions in my mind, such
as the fact that we do not call pcie_no_aspm() to disable ASPM in two
cases where it seems like we might want to:

  1) When pcie_ports_disabled, e.g., when booting with
     "pcie_ports=compat".

  2) When Linux doesn't support all the required services, e.g., if
     compiled with ASPM support but not MSI support.

I haven't looked deeply, so maybe there are other constraints that
keep us from using ASPM in these cases.  In any case, this series
doesn't change any behavior in this regard.

Below are samples of the dmesg changes from this series.  Typical case
where we successfully get control of PCIe services:

  -acpi PNP0A08:00: Requesting ACPI _OSC control (0x1d)
  -acpi PNP0A08:00: ACPI _OSC control (0x1d) granted
  +acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
  +acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]

Failure case where the system has no _OSC method:

  -acpi PNP0A03:00: ACPI _OSC support notification failed, disabling PCIe ASPM
  -acpi PNP0A03:00: Unable to request _OSC control (_OSC support mask: 0x08)
  +acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
  +acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM

Linux only requests _OSC control of features as a group; if Linux
doesn't support *all* of those features, we don't request control of
any of them (per 415e12b237).  Here's an example booted with
"pci=nomsi":

  -acpi PNP0A08:00: Unable to request _OSC control (_OSC support mask: 0x0f)
  +acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments]
  +acpi PNP0A08:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]

Here's a system that doesn't grant OS control of the PCIe Capability.
This is another case where we don't want control of anything unless we
have control of the PCIe Capability:

  -acpi PNP0A08:00: Requesting ACPI _OSC control (0x1d)
  -acpi PNP0A08:00: ACPI _OSC request failed (AE_SUPPORT), returned control mask: 0x0d
  -acpi PNP0A08:00: ACPI _OSC control for PCIe not granted, disabling ASPM
  +acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
  +acpi PNP0A08:00: _OSC: platform does not support [PCIeCapability]
  +acpi PNP0A08:00: _OSC: not requesting control; platform does not support [PCIeCapability]
  +acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug PME AER PCIeCapability]
  +acpi PNP0A08:00: _OSC: platform willing to grant [PCIeHotplug PME AER]
  +acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM


This is based on a923874198 ("Merge tag 'pci-v3.12-changes' of
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci").

---

Bjorn Helgaas (14):
      ACPI: Write _OSC bit field definitions in hex
      ACPI: Rename OSC_QUERY_TYPE to OSC_QUERY_DWORD
      ACPI: Tidy acpi_run_osc() declarations
      ACPI: Remove unused OSC_PCI_NATIVE_HOTPLUG
      ACPI: Write OSC_PCI_CONTROL_MASKS like OSC_PCI_SUPPORT_MASKS
      PCI/ACPI: Name _OSC #defines more consistently
      PCI/ACPI: Drop unnecessary _OSC existence tests
      PCI/ACPI: Move _OSC stuff from acpi_pci_root_add() to negotiate_os_control()
      PCI/ACPI: Split _OSC "support" and "control" flags into separate variables
      PCI/ACPI: Run _OSC only once for OSPM feature support
      PCI/ACPI: Skip _OSC control tests if _OSC support call failed
      PCI/ACPI: Separate out _OSC "PCIe port services disabled" path
      PCI/ACPI: Separate out _OSC "we don't support enough services" path
      PCI/ACPI: Decode _OSC bitmasks symbolically


 drivers/acpi/apei/apei-base.c    |    6 -
 drivers/acpi/bus.c               |   18 +--
 drivers/acpi/pci_root.c          |  246 +++++++++++++++++++++++---------------
 drivers/pci/hotplug/acpi_pcihp.c |    2 
 drivers/pci/hotplug/shpchp.h     |    2 
 include/linux/acpi.h             |   81 ++++++-------
 6 files changed, 199 insertions(+), 156 deletions(-)
