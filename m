Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:45000 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578AbbKXPSo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2015 10:18:44 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Ramon Fried <ramon.fried@tandemg.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: PCIe endpoint generic driver
Date: Tue, 24 Nov 2015 15:18:32 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E162C9A21@lhreml503-mbs>
References: <AM2PR02MB06895C98FE39F8BB6D958389E8060@AM2PR02MB0689.eurprd02.prod.outlook.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E162C98EA@lhreml503-mbs>
 <AM2PR02MB06897BD3549D017DCF17FE36E8060@AM2PR02MB0689.eurprd02.prod.outlook.com>
In-Reply-To: <AM2PR02MB06897BD3549D017DCF17FE36E8060@AM2PR02MB0689.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org]
> On Behalf Of Ramon Fried
> Sent: 24 November 2015 15:02
> To: linux-pci@vger.kernel.org
> Subject: RE: PCIe endpoint generic driver
> 
> > > Hi.
> > > Sorry for the noob question :)
> > > I'm currently developing a PCIe endpoint driver for a board that runs
> > > Linux.
> > > The board will be used as an expansion PCIe card for x86 PC's.
> > > Is there any guidelines, documentation related to PCI endpoint drivers
> > > for Linux kernel ?
> 
> > Hi Ramon
> >
> > Have you looked at
> > http://lxr.free-electrons.com/source/Documentation/PCI/pci.txt
> >?
> >
> > Regards
> >
> > Gab
> 
> Hi Gab, you misunderstood my driver type.
> This is not a host driver, that I'm writing, but the actual endpoint driver.
> Then Linux is on the PCIe board.

Hi Ramon, I understood your driver type.
I think you misunderstood the Documentation.
Host Bridges are under drivers/pci/host and none of them use pci_register_driver() API.

pci_register_driver() is actually for endpoints. Please read the link above again.

> 
> > > I didn't find any, and I guess that I'm left with a platform driver.
> > >
> > > If indeed the platform driver is the way to go, are there any
> > > implementations upstream I can look at ?
> > >
> > > Thanks !
> > > Ramon.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
