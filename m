Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:46294 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbaBZTJE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 14:09:04 -0500
Received: by mail-ig0-f176.google.com with SMTP id uy17so2856179igb.3
        for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2014 11:09:02 -0800 (PST)
Subject: [PATCH 0/4] i2o: Use pci_bus_alloc_resource()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Markus Lidel <Markus.Lidel@shadowconnect.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 26 Feb 2014 12:08:59 -0700
Message-ID: <20140226190306.9616.30567.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

i20 currently uses pci_find_parent_resource() followed by
allocate_resource() to allocate PCI space.  The problem is that this won't
work reliably because before we allocate the space, we don't know its
address, and therefore we can't find the parent resource.  Even if we know
the *type* of space we want, in some cases there are multiple possibilities
(root buses with multiple apertures to them, prefetchable or
non-prefetchable apertures, etc.)

This changes it to use pci_bus_alloc_resource(), which takes care of those
details.

This also fixes some things that look like copy/paste errors, e.g., trying
to allocate an I/O space with 1MB alignment.

I don't have hardware to test these changes, but I don't think these
allocation paths actually worked before, this shouldn't be any worse than
what we have today.

---

Bjorn Helgaas (4):
      i2o: Fix I/O space allocation copy/paste error
      i2o: Fix I/O space alignment requirement
      i2o: Refactor i2o_iop_systab_set() PCI space allocation
      i2o: Use pci_bus_alloc_resource(), not allocate_resource() directly


 drivers/message/i2o/iop.c |   85 ++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 43 deletions(-)
