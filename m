Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:57239 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbbE0VKB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 17:10:01 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v0 00/13] PCI: Static Enumeration
Date: Wed, 27 May 2015 20:58:38 +0000
Message-ID: <f10f623e0316433abe30420d68f73e33@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Background
----------

On many architectures, PCI devices are enumerated by the BIOS prior to
the kernel booting. This is a problem if a PCI device is powered on
after the PCI subsystem has scanned the various root complexes. Whereas
PCI Hotplug devices have memory ranges reserved for them ahead of time,
no such facility exists for bridges or other endpoints.

Proposed in the upcoming patches is a mechanism similar to "static
enumeration". Via the kcmdline, the user can forcibly set secondary and
subordinate values for buses, overriding any values that the BIOS may
have set. This allows newly discovered bridges to fit into an existing
PCI tree, without causing conflicting numbers nor renumbering existing
bridges.

Next, the patches allow the user to forcibly set the memory behind a
bridge, again overriding any values the BIOS had set. This is needed to
reserve space for newly discovered endpoints' MMIO regions. The patches
employ a first-fit algorithm to pack those new MMIO BARs into the
reserved space.


Configuration
-------------

The kcmdline syntax for static enumeration is as follows:

  pci=enum=<args1>;<args2...>

Where each <arg> has the form:

  <device>@<option><option2...>

Where <device> is a PCI device described by:

  <domain>:<bus>:<slot>.<func>

And <option> is any combination of:

  B<secondary>-<subordinate>  - force secondary and subordinate bus numbers
  M<start>-<stop>  - set memory behind a bridge

All values are in hexadecimal.


Testing
-------

These patches have been tested on an x86 system that boots directly from
NVRAM. After booting to a command line, additional PCI devices were
powered. Next, a rescan was forced by echoing 1 to /sys/bus/pci/rescan;
the kernel found the new bridges and devices.


Issues
------

There are three known limitations to these patches:
  1. This only works with 32-bit PCI devices; it does not handle 64-bit
     addresses.
  2. It only works with non pre-fetched memory regions.
  3. The root filesystem must be on a non-PCI device. Reenumeration
     occurs during system initialization, prior to loading any devices.
     If an initrd normally mounts the real root filesystem from a PCI
     device, that device's addresses could change as a result of
     enumeration.


FAQs
----

Q1: Doesn't PCI Hotplug already solve this problem?
A1: From what I can tell, the existing PCI Hotplug infrastructure only
    works with PCI endpoints; it has no way to handle hot adding a
    bridge, and then later on hot adding an endpoint.

    Static enumeration can also be used in cases where the memory
    behind a bridge needs to be changed due to faulty hardware.

Q2: Why do bus numbers need to be reenumerated?
A2: Consider a bus "A", with secondary bus number 1), has two child
    buses, "B" and "C". Suppose that "B" has no grandchild buses, so
    let its bus range is [2-2]. Likewise, "C" also has no grandchild
    buses, so its bus range is [3-3]. Therefore, "A"'s bus range is
    [1-3]. Let a new bridge "D" be hot added under "B". This bridge's
    bus needs to be within its parent's bus range, but "B" has no
    space for it. If "B" were to be dynamically resized to [2-3], then
    "C"'s bus number would now be invalid.

    Any existing process that was talking to devices on "C" would need
    to be handle this sudden change in enumeration. Changes ripple
    throughout the PCI tree, as that "A" would also need to be resized.
    Obviously, this has lots of issues.

    An alternative approach, and one taken in the patches here, is to
    pre-reserve bus numbers ahead of time. If prior to user processes
    running, the kernel reads the static enumeration profile and
    changes "B"'s range to [2-3]. It can then automatically adjust "C"
    to [4-4] and thus "A" to [1-4]. Now, when bus "D" becomes active,
    it can claim bus range [3-3] without affecting any other bus.

Q3: Wouldn't the same argument of reenumerating bus numbers also apply
    to the memory window behind bridges?
A3: Yes, it would. The later patches handle this.

Q4: Why create another kernel parameter, when "pci=hpmemsize=" already
    exists?
A4: "hpmemsize" sets all bridges' memory; it does not set individual
    bridge sizes. It also does not set bus numbers.

Q5: Why use kernel parameters to specify the static enumeration profile?
A5: Because resources are allocated prior to loading drivers,
    enumeration changes must occur in drivers/pci/probe.c. The kernel
    can only access the profile from a location that does not require
    any device drivers. As such, the kernel command line fulfills these
    requirements. An additional advantage of the command line is the
    ease of disabling a profile in case of misconfiguration.

Jason Tang (13):
      PCI: Set bus's device name later
      PCI: Use child bus's number instead of max
      PCI: Add Kconfig option PCI_STATIC_ENUMERATION
      PCI: Track subordinate values in struct pci_bus
      PCI: Specify static enumeration on kcmdline
      PCI: Set secondary and subordinate bus numbers
      PCI: Calculate child's bus number based upon enumeration
      PCI: Statically specify bus memory regions
      PCI: Adjust upstream bridge memories to match static enumeration
      PCI: Invalidate resources conflicting with bridge memories
      PCI: Reassign device's MMIO BARs
      PCI: Keep searching upstream for enclosing bus
      PCI: Don't adjust settings for statically enumerated devices

 Documentation/kernel-parameters.txt |   11 +
 drivers/pci/Kconfig                 |   12 +
 drivers/pci/Makefile                |    2 +
 drivers/pci/pci.c                   |    2 +
 drivers/pci/pci.h                   |   43 +++
 drivers/pci/pci_static_enum.c       |  559 +++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c                 |   45 ++-
 include/linux/pci.h                 |    7 +
 8 files changed, 675 insertions(+), 6 deletions(-)

