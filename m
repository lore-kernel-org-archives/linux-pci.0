Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:53200 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbaIETBE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Sep 2014 15:01:04 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: keystone: update to support multiple pci ports
Date: Fri, 05 Sep 2014 21:00:19 +0200
Message-ID: <3654923.JrIGV2dJ70@wuerfel>
In-Reply-To: <540A0212.6060303@ti.com>
References: <1409938782-31460-1-git-send-email-m-karicheri2@ti.com> <7260053.FoBVhTXVfj@wuerfel> <540A0212.6060303@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 05 September 2014 14:33:54 Murali Karicheri wrote:
> > This looks like it's a shared register of some sort that doesn't
> > really belong into the registers of a particular port. Could it
> > be that it's actually for the PHY?
> >
> This a shared device configuration register between the two ports the 
> desciption states it is bootstrap configuration of the PCIe module as 
> Endpoint or Root complex and Not Phy. Hope below text will help.

Ok. Why do you want to have this user-selectable though? Can't it
just be set by the boot loader before starting Linux?

	Arnd

> Table 3-23 Device Configuration Register (DEVCFG)
> 
> 
> PCIESSMODE[1:0] 00b PCIESSMODE is used to control the
> functionality of PCIESS module out of
> reset. This MMR output is connected to
> DEVTYPE input of PCIESS
> (Changes from
> Nysh) : Note that in Nysh this value came
> from a bootstrap pin.
> 00 : Endpoint
> 01 : Legacy Endpoint
> 10 : Rootcomplex
> 11 : Reserved
> PCIESS_1_MODE[1:0
> ]
> 00b PCIESSMODE is used to control the
> functionality of PCIE_1 module out of
> reset. This MMR output is connected to
> DEVTYPE input of PCIE_1
> 00 : Endpoint
> 01 : Legacy Endpoint
> 10 : Rootcomplex
> 11 : Reserv
> 

