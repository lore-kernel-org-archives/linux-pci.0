Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56370 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeINT7Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Sep 2018 15:59:25 -0400
Date: Fri, 14 Sep 2018 15:44:20 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCHv2 2/3] PCI: mvebu: Convert to PCI emulated bridge config
 space
Message-ID: <20180914144420.GD30658@n2100.armlinux.org.uk>
References: <20180912154831.2220-1-thomas.petazzoni@bootlin.com>
 <20180912154831.2220-3-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180912154831.2220-3-thomas.petazzoni@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 12, 2018 at 05:48:30PM +0200, Thomas Petazzoni wrote:
> This commit convers the pci-mvebu driver to use the recently
> introduced pci-bridge-emul logic, that helps emulating a root port PCI
> bridge configuration space.
> 
> It has been tested on Armada GP XP, with a E1000E NIC.

I think this needs commentry explaining the "FIXME":

> -	case PCISWCAP_EXP_DEVCTL:
> +	case PCI_EXP_DEVCTL:
>  		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL) &
>  				 ~(PCI_EXP_DEVCTL_URRE | PCI_EXP_DEVCTL_FERE |
>  				   PCI_EXP_DEVCTL_NFERE | PCI_EXP_DEVCTL_CERE);
> -		*value |= bridge->pcie_devctl;
> +		/* FIXME */
> +		*value |= bridge->pcie_conf.devctl;
>  		break;

otherwise it's likely to end up remaining there.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
