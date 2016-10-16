Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35789 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbcJPIOA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Oct 2016 04:14:00 -0400
Received: by mail-io0-f172.google.com with SMTP id i202so160180411ioi.2
        for <linux-pci@vger.kernel.org>; Sun, 16 Oct 2016 01:13:59 -0700 (PDT)
MIME-Version: 1.0
From: Vecu Bosseur <vecu.bosseur@gmail.com>
Date: Sun, 16 Oct 2016 10:13:58 +0200
Message-ID: <CACivvv2MkD-QSmkt1yPzz9Lx1Lax5pQtc+W9_F0WM5LPziLvAQ@mail.gmail.com>
Subject: [REGRESSION, bisect] Bug introduced within Linux 4.6 merge window,
 affecting at least x86_64 platform.
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

It is more than 6 monthes I suffer from an unknown bug which seemed to
be a DRM or otherwise graphical bug affecting Linux 4.6-rcX on x86_64
platform. (unable to test on 32-bit platform)

For some unclear reason my AMD/ATI Radeon TURKS video card was not
initialized properly by those newer kernel versions.

I investigated hardly and found a "shallow" bug introduced by a commit
pair (sic.) :

cfeb8139a1fbbbae3f1e986133f4e9e7833eeac4
Merge branch 'pci/host-hv' into next

and

30b5b8808c12bcd947dd474980482561b69c1bcb
PCI: Restore inclusion of pci/hotplug Kconfig

I bet though this bug was hiding another real "deeper" bug, which proved right.
Here follows my findings :

In the end, I found that the real first bad commit for the bug we are
talking about is :

[0c0e0736acad4e76e718456c75d78ad95eea0011] PCI: Set ROM shadow
location in arch code, not in PCI core

I already opened a ticket for this as bug #175391 on bugzilla.kernel.org
( https://bugzilla.kernel.org/show_bug.cgi?id=175391 )
and advise you to read it in its entirety.

Since I first suffered from it while using Ubuntu with "Mainline PPA
Kernel", I also reported it as bug #1627496 on bugs.launchpad.net .
( https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1627496 )

Since I fed plenty of details on bugzilla, I won't copy/paste them
here, obviously.

Any comment or suggestion much appreciated.

In hope this helps.

Sincerely,
Valentin QUEQUET
