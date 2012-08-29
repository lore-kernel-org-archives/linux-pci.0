Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:62896 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752070Ab2H2H2t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Aug 2012 03:28:49 -0400
Received: by lagy9 with SMTP id y9so243668lag.19
        for <linux-pci@vger.kernel.org>; Wed, 29 Aug 2012 00:28:47 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 29 Aug 2012 00:28:47 -0700
Message-ID: <CAErSpo73r3yzzndUek-NJ3d0pDKtg8zTrnjk4ihudBE5gngBAA@mail.gmail.com>
Subject: PCI mini-summit notes
From: Bjorn Helgaas <bhelgaas@google.com>
To: ksummit-2012-discuss
	<ksummit-2012-discuss@lists.linux-foundation.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We held a PCI mini-summit on Aug 28 in San Diego in conjunction with
Kernel Summit and the Linux Plumbers Conference.  I want to thank
everybody who participated.  We had a good discussion and I really
appreciate all the input and ideas everybody provided.

My summary of the major discussions we had is below.

Bjorn



Host bridge hotplug

    There's a lot of interest in this functionality, mostly on x86 using
    ACPI-mediated hotplug.

    The acpiphp driver handles both host bridge and PCI device hotplug.  We
    believe these should be separated.

    Host bridge hotplug requires IOAPIC and DMAR hotplug with proper sequencing
    (started before PCI enumeration and removed after PCI drivers are removed).
    On x86, we think this should happen naturally if we add this support to the
    ACPI pci_root.c driver.  We do need some tweaks to x86 IOAPIC init and
    IOMMU drivers.

    We'd like a sysfs interface to this, and it's not clear what form
    it should take.  One way is to add hooks in the PCI side, e.g.,
    /sys/devices/.../pci_bus/remove.  This has the advantage of looking the
    same across all architectures, but it doesn't map well to firmware
    interfaces and it's not obvious how to deal with hot-adds, when the pci_bus
    doesn't exist yet.  Another way would be to have them connected to the host
    bridge and its enclosing scope, e.g., /sys/devices/.../PNP0A08:00/remove
    and /sys/devices/.../LNXSYBUS:00/rescan.  This is architecture-specific but
    has the advantage of matching the logical system topology.

Hot Plug Issues

    We know we have locking issues and races in the PCI device hotplug area.
    We have some pending patches to address these.  They may be merged for 3.7
    or 3.8.

    We still have some device setup being done by initcalls, and obviously this
    doesn't work for hot-added devices.  We've fixed some of these areas, but
    there are a few more to do.

    What about CONFIG_HOTPLUG?  We didn't discuss this in the mini-summit,
    but it was raised on the ksummit-discuss list.

SR-IOV Management

    Currently drivers implement module parameters like "max_vfs".  This means
    all devices claimed by the driver get the same number of VFs, and you can't
    change anything without unloading and reloading the driver.

    Consensus that we should try to implement a knob for this in sysfs so it
    can be generic (not in each driver) and set individually for each device.

SR-IOV Implementation Issues

    VFs of a single device can appear on several "virtual" buses as well as on
    the PF's bus.  The virtual buses are not connected to an upstream bridge,
    so typical code that iterates over bus->devices lists misses these VFs.

    We had several ideas for fixing this, but the right answer is not
    obvious yet.

PCI Device Resources

    We've been moving more resource management from architecture code into
    the core.  For example, the core now supports host bridge address
    translation.  However, this exposes inconsistencies in how we decide
    whether a BAR contains a valid address.  We may need a new pcibios
    interface to handle special cases here.

    We plan to continue moving this code out of architectures so that,
    for example, pci_claim_resource() is done consistently in the core.

    In the longer term, we'd like to pull pcibios_assign_resources() into
    the core as well, along with the flags that tell us to either pay attention
    to or ignore what firmware has done.

    We've had patches circulating that do reassignment of bus numbers to make
    space for hot-added devices.  We're very concerned about the safety of this
    because we fear that ACPI AML, DMAR tables, and other firmware may assume
    that bus/device/function addresses stay constant.

Max Payload Size

    MPS is a knob that can improve performance but has to be set consistently
    on all communicating devices.  We have code to do this, but were burned in
    the past by defective devices, so it's currently turned off.  We have
    quirks for those devices, and we hope to try turning this on again in the
    3.7 merge window.

    There are also potential issues when hot-adding a device that requires
    something other than the current MPS setting.  This needs to be
    investigated more.
