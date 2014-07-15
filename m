Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:47870 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbaGOW4l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jul 2014 18:56:41 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so86896ieb.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2014 15:56:40 -0700 (PDT)
Subject: [PATCH 0/2] Fix GPL v2 license string typos
To: linux-pci@vger.kernel.org, Simon Horman <horms@verge.net.au>,
	Will Deacon <will.deacon@arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <treding@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
Date: Tue, 15 Jul 2014 16:56:38 -0600
Message-ID: <20140715225503.22578.32174.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thierry posted similar patches for tegra and mvebu.  These change the rest
of the occurrences in drivers/pci from:

  -MODULE_LICENSE("GPLv2");
  +MODULE_LICENSE("GPL v2");

---

Bjorn Helgaas (2):
      PCI: generic: Fix GPL v2 license string typo
      PCI: rcar: Fix GPL v2 license string typo


 drivers/pci/host/pci-host-generic.c |    2 +-
 drivers/pci/host/pcie-rcar.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
