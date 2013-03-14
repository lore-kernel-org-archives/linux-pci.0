Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:46749 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757660Ab3CNMlh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2013 08:41:37 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so2114449obc.13
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2013 05:41:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bug-55211-41252@https.bugzilla.kernel.org/>
References: <bug-55211-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 14 Mar 2013 06:41:16 -0600
Message-ID: <CAErSpo5tVJd6-1s15524Qai-pZGed-XaOPFHn2EiY-qvYiAugg@mail.gmail.com>
Subject: Fwd: [Bug 55211] New: pci_disable_link_state PCIE_LINK_STATE_L0S no
 longer disables ASPM for ath5k
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

---------- Forwarded message ----------
From:  <bugzilla-daemon@bugzilla.kernel.org>
Date: Thu, Mar 14, 2013 at 4:04 AM
Subject: [Bug 55211] New: pci_disable_link_state PCIE_LINK_STATE_L0S
no longer disables ASPM for ath5k
To: bhelgaas@google.com


https://bugzilla.kernel.org/show_bug.cgi?id=55211

           Summary: pci_disable_link_state PCIE_LINK_STATE_L0S no longer
                    disables ASPM for ath5k
           Product: Drivers
           Version: 2.5
    Kernel Version: 3.8.0
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
        AssignedTo: drivers_pci@kernel-bugs.osdl.org
        ReportedBy: roman.yepishev@gmail.com
        Regression: Yes


This bug report is based on investigation for
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1137513

I have an old Acer Aspire One AOA150 netbook which has a BIOS that does not
disable ASPM for ath5k wireless device, 168c:001c, Atheros Communications Inc.
AR242x / AR542x PCI-Express adapter.

2 years ago in 6ccf15a1a76d2ff915cdef6ae4d12d0170087118 ath5k driver got this:

   pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S);

The card was working fine until Ubuntu raring 13.04 switched to 3.8 and the
same symptoms that were fixed by the commit above started to appear - random
md5 generator instead of file downloads, SSH disconnects, etc. The card had
LnkCtl: ASPM L0s L1 Enabled; according to lspci in 3.8+ while it had ASPM
disabled in kernels <= 3.7.

I have tested all the available builds of 3.8 mainline kernel and found that it
was introduced early in 3.8 series. Then I did a bisect between 3.7 and 3.8 and
found that the first bad commit is:

commit 8c33f51df406e1a1f7fa4e9b244845b7ebd61fa6
Author: Taku Izumi <izumi.taku@jp.fujitsu.com>
Date:   Tue Oct 30 15:27:13 2012 +0900

    PCI/ACPI: Request _OSC control before scanning PCI root bus

    This patch moves up the code block to request _OSC control in order to
    separate ACPI work and PCI work in acpi_pci_root_add().

    Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I see the following in dmesg:
[    0.145833] pci_root PNP0A08:00: ACPI _OSC support notification failed,
disabling PCIe ASPM
[    0.145840] pci_root PNP0A08:00: Unable to request _OSC control (_OSC
support mask: 0x08)
...
[    0.181256] ACPI _OSC control for PCIe not granted, disabling ASPM

So it looks like it is actually doing something, yet ASPM remains enabled
causing the card to malfunction during data transfers.

--
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
