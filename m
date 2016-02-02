Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54895 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756930AbcBBTUc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Feb 2016 14:20:32 -0500
Subject: [PATCH 0/3] PCI: Clean up warnings
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org
Date: Tue, 02 Feb 2016 13:20:28 -0600
Message-ID: <20160202191658.7887.28475.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm on a quest to clean up compiler warnings in drivers/pci.  I'd like to
be able to treat warnings as errors, at least for the 0day build robot.

---

Bjorn Helgaas (3):
      PCI: Check device_attach() return value always
      PCI/PME: Remove redundant port lookup
      PCI/PME: Restructure pcie_pme_suspend() to prevent compiler warning


 drivers/pci/bus.c      |    7 ++++++-
 drivers/pci/pcie/pme.c |   11 ++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)
