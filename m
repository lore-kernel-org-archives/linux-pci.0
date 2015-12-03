Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>, <lftan.linux@gmail.com>
Subject: [PATCH 0/3] fixes to support multi-functions device
Date: Thu, 3 Dec 2015 19:17:51 +0800
Message-ID: <1449141474-3378-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series of patch fixes the issues when work with multi-functions PCIe
devices. Host controller can't access to endpoint with non-zero devfn, due to
incorrect rootport devfn. It also add checking for TLP status and fix issue in
interrupt probing.

Tested on Ethernet adapter card with multi-functions enabled.

Ley Foon Tan (3):
  PCI: altera: fix incorrect devfn for requester ID
  PCI: altera: check TLP completion status
  PCI: altera: fix error when INTX is 4

 drivers/pci/host/pcie-altera.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

-- 
1.8.2.1

