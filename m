Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ww0-f74.google.com ([74.125.82.74]:36858 "EHLO
	mail-ww0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab2ARAe7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2012 19:34:59 -0500
Received: by wgbgn7 with SMTP id gn7so111302wgb.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2012 16:34:58 -0800 (PST)
Subject: [PATCH 0/4] add struct pci_host_bridge
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Tue, 17 Jan 2012 17:34:57 -0700
Message-ID: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series adds a struct pci_host_bridge to track generic host bridge
information like the bus numbers and resources available behind the
host bridge.

The first use is to use the subordinate bus range to fix a problem in
scanning behind bridges.  Currently, we'll try to scan a bus number
that may not even be reachable via the current host bridge.  This
can break devices because we assign the wrong resources to them
(details in 3/3 changelog).

This is intended for linux-next, not for the current merge window.

---

Bjorn Helgaas (4):
      PCI: log bridge reconfiguration information
      PCI: add struct pci_host_bridge and pci_scan_host_bridge()
      PCI: restrict subordinate buses to those reachable via host bridge
      x86/PCI: use pci_create_host_bridge() so PCI core knows subordinate buses


 arch/x86/pci/acpi.c |    6 ++--
 drivers/pci/probe.c |   83 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h |   20 ++++++++++++
 3 files changed, 106 insertions(+), 3 deletions(-)
