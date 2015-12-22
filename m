Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Simon Horman <horms@verge.net.au>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	<linux-pci@vger.kernel.org>, <linux-sh@vger.kernel.org>
Subject: [PATCH 0/2] drivers/pci: use builtin_platform_driver in renesas
Date: Mon, 21 Dec 2015 19:59:07 -0500
Message-ID: <1450745949-23882-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These two commits are extracted from what was a larger series[1] of
demodularization in PCI host code that was bool Kconfig.

With the other commits, there was some mixed opinions whether we
should make it explicitly non-modular or move towards making it
functionally working as a tristate in order to reduce the size of
built-in code for multi-platform kernels.

However with the renesas changes, there was no ".remove" and no
"module_exit" code stripped out ; it is just a straight 1:1 mapping
of the modular macros onto what they become in the non-modular case
anyway -- meaning the runtime remains unchanged.

Given that, and the several Ack rec'd, it makes sense to at least
get these two in and out of my queue while we consider what to do
with the other PCI host code drivers that do have some modularity
already coded into them.

Build testing was done on pci/next, using an ARCH=arm allmodconfig
and then explicitly building the files changed in this series.  

Paul.
---

[1] https://lkml.kernel.org/r/1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Paul Gortmaker (2):
  drivers/pci: make host/pcie-rcar.c explicitly non-modular
  drivers/pci: make host/pci-rcar-gen2.c explicitly non-modular

 drivers/pci/host/pci-rcar-gen2.c | 12 +++---------
 drivers/pci/host/pcie-rcar.c     | 11 ++++-------
 2 files changed, 7 insertions(+), 16 deletions(-)

-- 
2.6.1
