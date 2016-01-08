Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53291 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755099AbcAHPx6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jan 2016 10:53:58 -0500
Subject: [PATCH 0/2] PCI: dra7xx: Mark driver broken and remove
To: Kishon Vijay Abraham I <kishon@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@arm.linux.org.uk>,
	Tony Lindgren <tony@atomide.com>, linux-pci@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
	Suman Anna <s-anna@ti.com>,
	linux-arm-kernel@lists.infradead.org
Date: Fri, 08 Jan 2016 09:53:55 -0600
Message-ID: <20160108153427.32755.63673.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The dra7xx driver in the mainline tree doesn't work because of a device
reset issue.  I intend to send the first patch (Richard's change to mark it
BROKEN) to Linus now for inclusion in v4.4.

We can talk about including the second patch (to remove the driver
altogether) in v4.5 (unless the reset issue is resolved, of course).

---

Bjorn Helgaas (1):
      PCI: dra7xx: Remove non-working driver

Richard Cochran (1):
      PCI: dra7xx: Mark driver as broken


 Documentation/devicetree/bindings/pci/ti-pci.txt |   62 --
 MAINTAINERS                                      |    8 
 drivers/pci/host/Kconfig                         |    9 
 drivers/pci/host/Makefile                        |    1 
 drivers/pci/host/pci-dra7xx.c                    |  571 ----------------------
 5 files changed, 651 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/ti-pci.txt
 delete mode 100644 drivers/pci/host/pci-dra7xx.c
