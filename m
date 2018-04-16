Return-Path: <SRS0=NmO7=HF=gmail.com=hkallweit1@kernel.org>
Return-Path: <SRS0=NmO7=HF=gmail.com=hkallweit1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] PCI: add two more values for PCIe
 Max_Read_Request_Size and initially use them in r8169 network driver
Message-ID: <00f1255f-acf0-4760-c20f-0b78bda44645@gmail.com>
Date: Mon, 16 Apr 2018 21:35:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

In r8169 network driver I stumbled across a magic number translating
to PCI MRRS size 4K. The PCI core is still missing constants for
values 2K and 4K (as defined in PCI standard).

So let's add these two constants and use the 4K constant in r8169.

Second patch depends on the first one, therefore both patches
preferrably should go through either PCI or netdev tree.

Heiner Kallweit (2):
  PCI: add two more values for PCIe Max_Read_Request_Size
  r8169: replace magic numbers with PCI MRRS constant

 drivers/net/ethernet/realtek/r8169.c | 39 ++++++++++++++--------------
 include/uapi/linux/pci_regs.h        |  2 ++
 2 files changed, 21 insertions(+), 20 deletions(-)

-- 
2.17.0
