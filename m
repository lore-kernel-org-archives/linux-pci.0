Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 17 Dec 2017 20:34:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 198171] New: [AMD][X399]
 Inconsistent PCIe lane linking count]
Message-ID: <20171218023431.GB14941@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Fri, 15 Dec 2017 22:24:36 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bugzilla.pci@gmail.com
Subject: [Bug 198171] New: [AMD][X399] Inconsistent PCIe lane linking count

https://bugzilla.kernel.org/show_bug.cgi?id=198171

            Bug ID: 198171
           Summary: [AMD][X399] Inconsistent PCIe lane linking count
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.15-rc3
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: barry@grussling.com
        Regression: No

I have an AMD Threadripper system with an MSI X399 gaming carbon pro
motherboard and a 1900X CPU.  When it boots, sometimes one of my cards (Intel
X550 NIC) initializes X1 link trained and sometimes it link trains at X4.  I
have tried this card in various other (Intel based) systems and not experienced
this issue.

I am uncertain if this is a Bios issue, PCIe driver issue, or something else. 
I am running the latest MB bios revision (V16 as of this writing).

In general, it seems like cold boots come up with a X1 width for the LnkSta and
warm reboots come up with X4 width for the LnkSta.  This is not absolute
though, as I have observed both inversions.

I will attach complete outputs but here are the highlights:
$ diff x550.{good,bad}
31c31
<               LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
---
>               LnkSta: Speed 8GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
>               BWMgmt- ABWMgmt-

Note that LnkCap always reports x4.

$ diff lspci.all.{good,bad}                                                     
[00:03.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 1453 (prog-if 00
[Normal decode])]
295c295
<               LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
---
>               LnkSta: Speed 8GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
>               BWMgmt+ ABWMgmt-

[0b:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS3008
PCI-Express Fusion-MPT SAS-3 (rev 02)]
1414c1414
<               HeaderLog: 04000001 0000200f 0b070000 b4456d62
---
>               HeaderLog: 04000001 0000210f 0b070000 119631a9

[0c:00.0 Ethernet controller: Intel Corporation Ethernet Controller 10G X550T
(rev 01)]
1454c1454
<               LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
---
>               LnkSta: Speed 8GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
>               BWMgmt- ABWMgmt-

[0c:00.1 Ethernet controller: Intel Corporation Ethernet Controller 10G X550T
(rev 01)]
1529c1529
<               LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
---
>               LnkSta: Speed 8GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
>               BWMgmt- ABWMgmt-


This system is new and the video card that is currently in it requires the AMD
DC patch set that was accepted in the 4.15-rc1 cycle.  As such, I have no prior
data for this configuration.  I am open to installing another video card and
trying older kernel versions if it would help.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----

There are some native host bridge drivers that do things with link
training, but you're using the ACPI host bridge driver, which doesn't
touch that, and the PCI core itself doesn't do anything in that area
either.

My guess is there something in the BIOS that is responsible for the
difference.

Bjorn
