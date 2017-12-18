Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 17 Dec 2017 20:23:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 198181] New: BUG at
 drivers/pci/msi.c:352 when unplugging a sysfs authorized thunderbolt 3 dock]
Message-ID: <20171218022357.GA14941@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Sun, 17 Dec 2017 15:04:51 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bugzilla.pci@gmail.com
Subject: [Bug 198181] New: BUG at drivers/pci/msi.c:352 when unplugging a sysfs
	authorized thunderbolt 3 dock

https://bugzilla.kernel.org/show_bug.cgi?id=198181

            Bug ID: 198181
           Summary: BUG at drivers/pci/msi.c:352 when unplugging a sysfs
                    authorized thunderbolt 3 dock
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.14.4
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: nheart@gmail.com
                CC: bhelgaas@google.com
        Regression: No

Created attachment 261219
  --> https://bugzilla.kernel.org/attachment.cgi?id=261219&action=edit
dmesg output

Hey,

I have a CalDigit TS3 Lite Thunderbolt 3 Dock that I use with a Dell Alienware
13.

When plugged in, the dock works fine, except no USB devices are recognized.
After some googling I found that I need to authorize it access to the dock via
sysfs https://lkml.org/lkml/2017/5/18/848

After I run echo 1 > /sys/bus/thunderbolt/devices/0-1/authorized

I can take full use of the dock, however if I unplug it, I face a kernel bug
at:

drivers/pci/msi.c:352 (dmesg attached). 

This is the free_msi_irqs function, but I don't understand the code. Any
explanation/help suggestions?

Cheers,

Nick

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
