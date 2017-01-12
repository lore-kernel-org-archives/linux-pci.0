Return-Path: <SRS0=x9XS=Y2=lunn.ch=andrew@kernel.org>
Return-Path: <SRS0=x9XS=Y2=lunn.ch=andrew@kernel.org>
Date: Thu, 12 Jan 2017 16:24:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
Message-ID: <20170112152420.GK13033@lunn.ch>
References: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
 <20170111220235.GP14532@bhelgaas-glaptop.roam.corp.google.com>
 <9f48e2a8-e1e0-e3db-af48-12297f8521f2@kleine-koenig.org>
 <20170112150310.GA5746@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170112150310.GA5746@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

>   pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
>   pci 0000:02:00.0: reg 0x10: [mem 0xe8000000-0xe81fffff 64bit]
>   pci 0000:02:00.0: reg 0x30: [mem 0xe8200000-0xe820ffff pref]
>   pci 0000:02:00.0: of_irq_parse_pci() failed with rc=134
>   pci 0000:02:00.0: BAR 0: assigned [mem 0xe0000000-0xe01fffff 64bit]
>   pci 0000:02:00.0: BAR 0: error updating (0xe0000004 != 0xffffffff)
>   pci 0000:02:00.0: BAR 0: error updating (high 0x000000 != 0xffffffff)
> 
> 3) No idea what the of_irq_parse_pci() issue is.

134 is 0x86.

Could it be:

#define PCIBIOS_DEVICE_NOT_FOUND        0x86

pci-mvebu.c will return this in a few places, mvebu_pcie_wr_conf(),
mvebu_pcie_rd_conf().

Could this be

rc = pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);

It looks like pci_read_config_byte() is expected to return a real
errno value, and maybe it is returning PCIBIOS_DEVICE_NOT_FOUND?

      Andrew
