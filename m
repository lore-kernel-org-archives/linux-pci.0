Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbeEVNKJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 May 2018 09:10:09 -0400
Subject: [PATCH v1 0/3] xtensa/PCI: Trivial cleanup
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Date: Tue, 22 May 2018 08:10:07 -0500
Message-ID: <152699456050.162480.13521209483758803324.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove some dead code, make things static, use dev_printk() to follow style
of other arches.

I'll merge these via the PCI tree unless there are objections.

---

Bjorn Helgaas (3):
      xtensa/PCI: Remove dead code
      xtensa/PCI: Make variables static
      xtensa/PCI: Use dev_printk() when possible


 arch/xtensa/include/asm/pci.h |    2 -
 arch/xtensa/kernel/pci.c      |   69 ++---------------------------------------
 2 files changed, 4 insertions(+), 67 deletions(-)
