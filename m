Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f178.google.com ([209.85.213.178]:42524 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeDXTbP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Apr 2018 15:31:15 -0400
Received: by mail-yb0-f178.google.com with SMTP id j69-v6so3374387ybg.9
        for <linux-pci@vger.kernel.org>; Tue, 24 Apr 2018 12:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <bug-199473-41252@https.bugzilla.kernel.org/>
In-Reply-To: <bug-199473-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Apr 2018 19:31:03 +0000
Message-ID: <CAErSpo4BOD3V7pgR75Gm7dYqvXYq1QfChjj16Jn1QgSK1W=Drw@mail.gmail.com>
Subject: Fwd: [Bug 199473] New: pcieport does not scan devices behind PEX
 switch, while resources are allocated
To: janpieter.sollie@dommel.be
Cc: linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for the report!

I don't understand exactly what the issue is yet.  You attached lspci
output from v4.14.27 and v4.17-rc1.  The v4.17-rc1 output shows several
devices (4b:00, 4c:00, 4f:00) below the PEX switch, while the v4.14.27
output shows only the 4f:00 devices.

Is the problem that v4.14.27 doesn't find the 4b:00 and 4c:00 devices?
Does v4.17-rc1 work correctly?

If v4.17-rc1 works but v4.14.27 does not, it's probably a question of
working with your distro to see if they can (1) identify some change that
fixed things, and (2) backport that change to the distro kernel.

The Broadcom driver you attached at comment #4 shouldn't be related to this
problem.  Device enumeration is performed by the PCI core and doesn't
require any additional drivers.  I didn't look at the Broadcom driver, so I
don't know what it does.  The PEX switch does include an endpoint
(42:00.1); it's possible the driver is for some functionality provided by
that endpoint.

---------- Forwarded message ---------
From: <bugzilla-daemon@bugzilla.kernel.org>
Date: Mon, Apr 23, 2018 at 12:20 AM
Subject: [Bug 199473] New: pcieport does not scan devices behind PEX
switch, while resources are allocated
To: <bhelgaas@google.com>


https://bugzilla.kernel.org/show_bug.cgi?id=199473

             Bug ID: 199473
            Summary: pcieport does not scan devices behind PEX switch,
                     while resources are allocated
            Product: Drivers
            Version: 2.5
     Kernel Version: 4.17-rc1
           Hardware: x86-64
                 OS: Linux
               Tree: Mainline
             Status: NEW
           Severity: normal
           Priority: P1
          Component: PCI
           Assignee: drivers_pci@kernel-bugs.osdl.org
           Reporter: janpieter.sollie@dommel.be
         Regression: No

Created attachment 275511
   --> https://bugzilla.kernel.org/attachment.cgi?id=275511&action=edit
dmesg stable kernel

pcieport assigns the PEX 8619 pcie expander switch ports, but does not scan
them for additional objects behind the ports. only 1 device is added @ pci
region 4f.  Workaround for getting all devices online: while pc is on,
remove
the card, reinsert it at a slot before the working device, and make a cold
start.
It would be nice if the pcie switches are scanned properly.

--
You are receiving this mail because:
You are watching the assignee of the bug.
