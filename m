Return-Path: <SRS0=yohJ=HF=davemloft.net=davem@kernel.org>
Return-Path: <SRS0=yohJ=HF=davemloft.net=davem@kernel.org>
Date: Mon, 16 Apr 2018 18:55:18 -0400 (EDT)
Message-Id: <20180416.185518.1020006266147417608.davem@davemloft.net>
To: hkallweit1@gmail.com
Cc: bhelgaas@google.com, helgaas@kernel.org, nic_swsd@realtek.com,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] PCI: add two more values for PCIe
 Max_Read_Request_Size and initially use them in r8169 network driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <00f1255f-acf0-4760-c20f-0b78bda44645@gmail.com>
References: <00f1255f-acf0-4760-c20f-0b78bda44645@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Mon, 16 Apr 2018 21:35:42 +0200

> In r8169 network driver I stumbled across a magic number translating
> to PCI MRRS size 4K. The PCI core is still missing constants for
> values 2K and 4K (as defined in PCI standard).
> 
> So let's add these two constants and use the 4K constant in r8169.
> 
> Second patch depends on the first one, therefore both patches
> preferrably should go through either PCI or netdev tree.

Series applied, thank you.
