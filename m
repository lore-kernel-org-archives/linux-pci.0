Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:62224 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665Ab3LFATn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2013 19:19:43 -0500
Received: by mail-oa0-f54.google.com with SMTP id h16so19218724oag.41
        for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2013 16:19:42 -0800 (PST)
Subject: [PATCH 0/2] Bridge window discovery and setup fixes
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Thu, 05 Dec 2013 17:19:39 -0700
Message-ID: <20131206001333.27659.59935.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are small fixes the way we discover and program PCI-PCI bridge
apertures.

The first (preventing bus conflicts) was found by Jason Gunthorpe.
We wrote 0xf0 to the I/O base/limit registers, which enables the
aperture.  For arches that emulate the bridge config space, this
causes the emulation to open a window we didn't expect.

The second keeps us from inadvertently clearing bits in the bridge
Secondary Status register while programming the I/O aperture.  We
don't really use those status bits, but it doesn't seem like a good
thing to clear them when we didn't intend to.

---

Bjorn Helgaas (2):
      PCI: Prevent bus conflicts while checking for bridge apertures
      PCI: Stop clearing bridge Secondary Status when setting up I/O aperture

 drivers/pci/setup-bus.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)
