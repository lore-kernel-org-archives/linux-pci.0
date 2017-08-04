Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
Subject: [PATCH v2 0/2] PCI: rcar-pcie: Fix memory leak
Date: Fri,  4 Aug 2017 12:32:53 +0900
Message-Id: <20170804033255.27171-1-harunobu.kurokawa.dn@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When no PCIe card is inserted, there is a memory leak as
pci_free_resource_list is not called before returning.

v2:
 separate the patch to two files.

Harunobu Kurokawa (1):
  PCI: rcar-pcie: Fix memory leak when no PCIe card is inserted

Lorenzo Pieralisi (1):
  PCI: rcar: Fix error exit path

 drivers/pci/host/pcie-rcar.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.9.2
