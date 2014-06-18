Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Simone Gotti <simone.gotti@gmail.com>
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Narendra_K@Dell.com
Subject: [PATCH 0/1] ACPI / PCI:  Fix "Operation not permitted" error reading sysfs acpi_index and label files.
Date: Wed, 18 Jun 2014 16:51:16 +0200
Message-Id: <1403103077-17589-1-git-send-email-simone.gotti@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi everyone,

starting from kernel 3.14 I noticed that the on board interfaces names on a Dell
PowerEdge E420 where renamed (by udev net_id internal) from eno1/eno2 to
enp2s0f0/enp2s0f1.

The root cause is that reading from the exported sysfs informations (acpi_index
and label) from drivers/pci/pci-label.c returns an "Operation not permitted"
error.

This machine supports PCI firmware specification 3.1 so the acpi methods are
preferred over the smbios one.

Debugging the problem I noticed that the call to the _DSM method returned the
second element with ACPI_TYPE_BUFFER type instead of ACPI_TYPE_STRING as
expected. The commit that forced this check is:

commit 1d0fcef732832432aee47cb75bf4a2cb3107be64 Author: Jiang Liu
<jiang.liu@linux.intel.com> Date:   Thu Dec 19 20:38:13 2013 +0800

    ACPI / PCI: replace open-coded _DSM code with helper functions

Previously the elements' types weren't checked and an ACPI_TYPE_BUFFER for the
second element was accepted.

The disassembled _DSM acpi method uses the ASL Unicode() macro that returns an
unicode string contained in a buffer.

Additionaly I noticed that an ascii string (as it should be the one of type
ACPI_TYPE_STRING) will be wrongly converted to utf8 from
dsm_label_utf16s_to_utf8s as it expects an utf16 string (I reproduced this
problem with a modified DSDT that returned an acpi string as label).

I don't have the PCI firmware specification so I don't know if an Unicode string
is correct or the bios is not compliant but I'm assuming this is possible. If
so, the following patch tries to fix this.


Thanks a lot.


Simone Gotti (1):
  Fix "Operation not permitted" error reading sysfs acpi_index and label
    files.

 drivers/pci/pci-label.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.0.0

