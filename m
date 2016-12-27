Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36476 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752214AbcL0UFD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2016 15:05:03 -0500
Received: by mail-yw0-f170.google.com with SMTP id a10so175303332ywa.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Dec 2016 12:05:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bug-189731-41252@https.bugzilla.kernel.org/>
References: <bug-189731-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 27 Dec 2016 14:04:41 -0600
Message-ID: <CAErSpo7UV-CYdaR7ZF2CMPoVpKcj_9KHuo_jE4E=35Ou6AwSGA@mail.gmail.com>
Subject: Fwd: [Bug 189731] New: Thunderbolt 3 (USB-C) to Thunderbolt 2
 adapter[05ac:1657] doesn't work at all
To: Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        AceLan Kao <acelan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

---------- Forwarded message ----------
From:  <bugzilla-daemon@bugzilla.kernel.org>
Date: Tue, Dec 6, 2016 at 1:25 AM
Subject: [Bug 189731] New: Thunderbolt 3 (USB-C) to Thunderbolt 2
adapter[05ac:1657] doesn't work at all
To: bhelgaas@google.com


https://bugzilla.kernel.org/show_bug.cgi?id=189731

            Bug ID: 189731
           Summary: Thunderbolt 3 (USB-C) to Thunderbolt 2
                    adapter[05ac:1657] doesn't work at all
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.9-rc8
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: acelan@gmail.com
        Regression: No

Created attachment 246931
  --> https://bugzilla.kernel.org/attachment.cgi?id=246931&action=edit
dmesg.log

I use an Apple thunderbolt 3 to thunderbolt 2 adapter to connect Dell XPS 9360
and Apple thunderbolt monitor, but it doesn't work.
The monitor doesn't power on nor flicker at all.
(I've verified the adapter by MBP and the monitor, it works well)

The dmesg shows the adapter is connected before powering up, and then
unplug/re-plug the adapter.
