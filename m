Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qw0-f74.google.com ([209.85.216.74]:36163 "EHLO
	mail-qw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948Ab2ARAsq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2012 19:48:46 -0500
Received: by qadb12 with SMTP id b12so612526qad.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2012 16:48:45 -0800 (PST)
Subject: [PATCH] allow host bridges with no io/mem apertures
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Date: Tue, 17 Jan 2012 17:41:16 -0700
Message-ID: <20120118004027.1089.93781.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch changes what we do when we don't find any apertures in
a PCI host bridge _CRS.  Previously, we assumed something in _CRS
parsing or in _CRS itself was broken, so we gave the root bus
the default resources (all of I/O port and MMIO space).

But I think this is wrong because there are often host bridges that
correctly have no apertures, e.g., they lead to things like Intel
Uncore "devices" that have no BARs.

This is intended for linux-next, not for the current merge window.

---

Bjorn Helgaas (1):
      x86/PCI: don't fall back to defaults if _CRS has no apertures


 arch/x86/pci/acpi.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)
