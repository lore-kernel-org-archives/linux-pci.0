Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0085.outbound.protection.outlook.com ([104.47.38.85]:49912
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751451AbcE0H3P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2016 03:29:15 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Wenrui Li <wenrui.li@rock-chips.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Shawn Lin" <shawn.lin@rock-chips.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rob Herring" <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] pci: Add PCIe driver for Rockchip Soc
Date: Fri, 27 May 2016 07:13:29 +0000
Message-ID: <8520D5D51A55D047800579B094147198258AF22F@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com>
 <1463740156-7148-1-git-send-email-shawn.lin@rock-chips.com>
 <9836736.6VjP1ug4kE@wuerfel> <5747EDC9.2080603@rock-chips.com>
In-Reply-To: <5747EDC9.2080603@rock-chips.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> >
> >> +
> >> +static int rockchip_pcie_rd_other_conf(struct rockchip_pcie_port *pp,
> >> +				       struct pci_bus *bus, u32 devfn,
> >> +				       int where, int size, u32 *val)
> >> +{
> >> +	u32 busdev;
> >> +
> >> +	busdev = PCIE_ECAM_ADDR(bus->number, PCI_SLOT(devfn),
> >> +				PCI_FUNC(devfn), where);
> >> +
> >> +	if (busdev & (size - 1)) {
> >> +		*val = 0;
> >> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> >> +	}
> >> +
> >> +	if (size == 4) {
> >> +		*val = readl(pp->reg_base + busdev);
> >> +	} else if (size == 2) {
> >> +		*val = readw(pp->reg_base + busdev);
> >> +	} else if (size == 1) {
> >> +		*val = readb(pp->reg_base + busdev);
> >> +	} else {
> >> +		*val = 0;
> >> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> >> +	}
> >> +	return PCIBIOS_SUCCESSFUL;
> >> +}
> >> +
> >
> > This looks like the normal ECAM operations, you could just call those.
> 
> I read ECAM reference code, I found it not support ioremap config space
> for each bus individually on 64-bit systems. Our soc is 64-bit system,
> and bus0 config space base address is 0xfda00000, bus1 base address is
> 0xf8100000. So I think it is not normal ECAM operations, I do not know
> if I have understood correctly?
> 
Hi,

I think Arnd was suggesting to use generic config read/write calls, pci_generic_config_read/pci_generic_config_write
which does above functionality.

Bharat 
