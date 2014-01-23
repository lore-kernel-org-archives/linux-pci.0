Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:30904 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbaAWFwU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2014 00:52:20 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZU00B4CAZ7BYB0@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 23 Jan 2014 14:52:19 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: =?ISO-8859-1?Q?'Bj=F8rn_Erik_Nilsen'?= <ben@datarespons.no>
Cc: linux-pci@vger.kernel.org, 'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	'Harro Haan' <hrhaan@gmail.com>, 'Marek Vasut' <marex@denx.de>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <25.15.01844.D5C20E25@epmailin6.samsung.com>
In-reply-to: <25.15.01844.D5C20E25@epmailin6.samsung.com>
Subject: Re: designware/imx6: question regarding MSI
Date: Thu, 23 Jan 2014 14:52:19 +0900
Message-id: <000201cf17ff$47025bf0$d50713d0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, January 23, 2014 5:39 AM, Jingoo Han wrote:
> 
> I’m currently playing with MSI support in pci-imx6.c using Harro Haan’s patch [*].
> 
> Are there any technical reasons why dw_pcie_msi_init cannot be called from dw_msi_setup_irq? Or rather,
> why it should not?

No, there is no special reason.
The patch (call dw_pcie_msi_init from dw_msi_setup_irq) would be
good. Thank you for your effort.

Mohit, Pratyush,
If you have different opinions, please let us know. :-)

Best regards,
Jingoo Han

> 
> I’m asking because I have a hotplug scenario where this little hack (call dw_pcie_msi_init from
> dw_msi_setup_irq) fixes a problem with MSI. I therefore need to understand whether it is a sensible
> hack or just crap, and more importantly; how it can be fixed properly.
> 
> Scenario:
> 
> (remove endpoints)
> # echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
> # echo 1 > /sys/bus/pci/devices/0000:01:00.1/remove
> 
> # take fpga in and out of reset (this will mess up the configuration space of the bridge)
> 
> (reset bridge)
> # echo 1 > /sys/bus/pci/devices/0000:00:00.0/reset
> 
> (rescan bus)
> # echo 1 > /sys/bus/pci/rescan
> 
> At this point everything works fine except MSI. With above mention hack it works like a charm.
> 
> I would be grateful if someone could shed light on this. I might have missed some important details.
> 
> 
> Best regards,
> Bjørn Erik Nilsen
> 
> [*]
> 
> From: Harro Haan <hrhaan@gmail.com>
> Date: Thu, 5 Dec 2013 14:06:37 +0100
> Subject: [PATCH 2/2] PCI: imx6: add support for MSI

