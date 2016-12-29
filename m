Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752906AbcL2SIX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Dec 2016 13:08:23 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 5114520465
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2016 18:08:21 +0000 (UTC)
Received: from localhost (unknown [69.55.156.165])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4CAE20462
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2016 18:08:19 +0000 (UTC)
Date: Thu, 29 Dec 2016 12:08:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Subject: PCI open regressions
Message-ID: <20161229180818.GA19266@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm trying to clean out the PCI bugzilla and make sure things don't
languish there without attention.  The following regressions are still
open.

190861  v4.8-rc1  Keyboard & mouse unresponsive after locking screen
  https://bugzilla.kernel.org/show_bug.cgi?id=190861

  Bisected to 006d44e49a25 ("PCI: Add runtime PM support for PCIe ports")
  Mika Westerberg <mika.westerberg@linux.intel.com>

189361  v4.2  PCIe packet switch enumeration
  https://bugzilla.kernel.org/show_bug.cgi?id=189361

  Awaiting testing on v4.9.  Possibly related to d0751b98dfa3 ("PCI:
  Add dev->has_secondary_link to track downstream PCIe links"), which
  appeared in v4.2-rc1, or b35b1df5e6c2 ("PCI: Tolerate hierarchies
  with no Root Port"), which appeared in v4.2-rc8.

117191  v4.3  BAR allocation problems
  https://bugzilla.kernel.org/show_bug.cgi?id=117191

  Meelis reports issues on both sparc and x86.  Wonder why we haven't
  seen more reports of this if it affects x86.

102311  v4.1  ASPM: ASMEDA asm1062 not working
  https://bugzilla.kernel.org/show_bug.cgi?id=102311

  Bisected to 387d37577fdd ("PCI: Don't clear ASPM bits when the FADT
  declares it's unsupported"), which appeared in v4.1-rc1.

  https://bugzilla.kernel.org/show_bug.cgi?id=189951 also bisected to
  387d37577fdd.

  https://patchwork.ozlabs.org/patch/690339/ is a proposed patch, but I
  have some reservations about it.

 96261  v4.0-rc1  Non-prefetchable BARs not allowed in prefetchable windows
  https://bugzilla.kernel.org/show_bug.cgi?id=96261

  This may be legal in PCIe hierarchies because memory transactions
  include explicit lengths.  The current behavior causes problems at
  least on sparc (but this isn't really arch-specific).

  Yinghai proposed some patches, but Ben objected to them.

 85311  v3.17-rc6  PCI dmesg spam when opening lid
  https://bugzilla.kernel.org/show_bug.cgi?id=85311

  Dmesg spam on resume, e.g., "BAR 6: [??? 0x00000000 flags 0x2] has
  bogus alignment" messages.

  Partly fixed by 63e22924f5dc ("PCI: Mark shadow copy of VGA ROM as
  IORESOURCE_PCI_FIXED").  Other messages remain.

 81431  v3.16  pci=realloc fails to modify bridge windows
  https://bugzilla.kernel.org/show_bug.cgi?id=81431

  Resource assignment problem in unusual configuration.  Bisected to
  5b28541552ef ("PCI: Restrict 64-bit prefetchable bridge windows to
  64-bit resources"), which appeared in v3.16-rc1.

  Not sure whether it's feasible to fix this.

 42606  v2.6.36  I/O range not assigned
  https://bugzilla.kernel.org/show_bug.cgi?id=42606

  I proposed a quirk to disable _CRS on Supermicro X8DTH-i/6/iF/6F,
  which is probably sufficient to resolve this bug.
