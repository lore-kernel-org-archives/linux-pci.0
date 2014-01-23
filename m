Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:51935 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750969AbaAWHSL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2014 02:18:11 -0500
Date: Thu, 23 Jan 2014 12:21:04 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Jingoo Han <jg1.han@samsung.com>,
	=?iso-8859-1?Q?'Bj=F8rn?= Erik Nilsen' <ben@datarespons.no>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	'Harro Haan' <hrhaan@gmail.com>, 'Marek Vasut' <marex@denx.de>
Subject: Re: designware/imx6: question regarding MSI
Message-ID: <20140123065104.GA26318@pratyush-vbox>
References: <25.15.01844.D5C20E25@epmailin6.samsung.com>
 <000201cf17ff$47025bf0$d50713d0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <000201cf17ff$47025bf0$d50713d0$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 23, 2014 at 01:52:19PM +0800, Jingoo Han wrote:
> On Thursday, January 23, 2014 5:39 AM, Jingoo Han wrote:
> > 
> > I’m currently playing with MSI support in pci-imx6.c using Harro Haan’s patch [*].
> > 
> > Are there any technical reasons why dw_pcie_msi_init cannot be called from dw_msi_setup_irq? Or rather,
> > why it should not?
> 
> No, there is no special reason.
> The patch (call dw_pcie_msi_init from dw_msi_setup_irq) would be
> good. Thank you for your effort.
> 
> Mohit, Pratyush,
> If you have different opinions, please let us know. :-)

dw_msi_setup_irq will be called for each function which needs msi
assignment. However, dw_pcie_msi_init should be called only once. So,
in my opinion calling dw_pcie_msi_init from dw_msi_setup_irq would not
be the best option.

@Bjørn, can you help us with tracing calling sequence of
dw_pcie_setup & dw_pcie_scan_bus. I think when you do "reset bridge",
it will call dw_pcie_setup and when you do "rescan bus", it will call
dw_pcie_scan_bus. If yes, then you can move dw_pcie_msi_init to
dw_pcie_setup.

Regards
Pratyush

> 
> Best regards,
> Jingoo Han
> 
> > 
> > I’m asking because I have a hotplug scenario where this little hack (call dw_pcie_msi_init from
> > dw_msi_setup_irq) fixes a problem with MSI. I therefore need to understand whether it is a sensible
> > hack or just crap, and more importantly; how it can be fixed properly.
> > 
> > Scenario:
> > 
> > (remove endpoints)
> > # echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
> > # echo 1 > /sys/bus/pci/devices/0000:01:00.1/remove
> > 
> > # take fpga in and out of reset (this will mess up the configuration space of the bridge)
> > 
> > (reset bridge)
> > # echo 1 > /sys/bus/pci/devices/0000:00:00.0/reset
> > 
> > (rescan bus)
> > # echo 1 > /sys/bus/pci/rescan
> > 
> > At this point everything works fine except MSI. With above mention hack it works like a charm.
> > 
> > I would be grateful if someone could shed light on this. I might have missed some important details.
> > 
> > 
> > Best regards,
> > Bjørn Erik Nilsen
> > 
> > [*]
> > 
> > From: Harro Haan <hrhaan@gmail.com>
> > Date: Thu, 5 Dec 2013 14:06:37 +0100
> > Subject: [PATCH 2/2] PCI: imx6: add support for MSI
