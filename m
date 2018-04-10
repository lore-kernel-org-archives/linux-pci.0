Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752919AbeDJNZB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Apr 2018 09:25:01 -0400
Subject: [PATCH v1 0/2] microblaze/PCI: Remove unused code
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2018 08:24:59 -0500
Message-ID: <152336656418.18958.17017091754578447948.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove some unused microblaze PCI code.

I can merge these via PCI if you like, Michal.  I have some related
changes coming for some sparc resource claim issues.  Or it's fine if
you pick them up.

---

Bjorn Helgaas (2):
      microblaze/PCI: Remove pcibios_finish_adding_to_bus() dead code
      microblaze/PCI: Remove pcibios_claim_one_bus() dead code


 arch/microblaze/include/asm/pci.h |    4 --
 arch/microblaze/pci/pci-common.c  |   61 -------------------------------------
 2 files changed, 65 deletions(-)
