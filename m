Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751199AbeEVNLh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 May 2018 09:11:37 -0400
Subject: [PATCH v1] MIPS: PCI: Use dev_printk()
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date: Tue, 22 May 2018 08:11:36 -0500
Message-ID: <152699466671.162686.1029992586935534102.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use dev_printk() to follow style of other arches.

I'll merge via the PCI tree unless there are objections.

---

Bjorn Helgaas (1):
      MIPS: PCI: Use dev_printk() when possible


 arch/mips/pci/pci-legacy.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)
