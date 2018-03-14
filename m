Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbeCNNa3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 09:30:29 -0400
Subject: [PATCH v2 0/2] PCI: Update quirk timing
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@redhat.com>,
        Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
        Andreas Noever <andreas.noever@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Mar 2018 08:30:26 -0500
Message-ID: <152103417018.167541.3290752859388672112.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a minor update of a patch I posted earlier [1] when Paul
reported an unreasonably long time spent in PCI quirks during boot
[2].  This doesn't fix the slow quirks, but might help find them.

We previously printed the time taken by each quirk if "initcall_debug"
was specified.  With these patches, we'll print it even without
"initcall_debug" if the quirk takes longer than 10ms.

I did notice one quirk (quirk_apple_poweroff_thunderbolt()) in the
suspend path that sleeps for 300ms, so this will probably make suspend
noisier on Apple systems.

[1] https://lkml.kernel.org/r/20171228212723.GB211339@bhelgaas-glaptop.roam.corp.google.com
[2] https://lkml.kernel.org/r/44cada166e42007d27b4c3e3aa0744d7@molgen.mpg.de

---

Bjorn Helgaas (2):
      PCI: Report quirk timings with pci_info() instead of pr_debug()
      PCI: Report quirks that take more than 10ms


 drivers/pci/quirks.c |   24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)
