Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db3on0115.outbound.protection.outlook.com ([157.55.234.115]:42601
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753254AbbKXPCc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2015 10:02:32 -0500
From: Ramon Fried <ramon.fried@tandemg.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: PCIe endpoint generic driver
Date: Tue, 24 Nov 2015 15:02:28 +0000
Message-ID: <AM2PR02MB06897BD3549D017DCF17FE36E8060@AM2PR02MB0689.eurprd02.prod.outlook.com>
References: <AM2PR02MB06895C98FE39F8BB6D958389E8060@AM2PR02MB0689.eurprd02.prod.outlook.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E162C98EA@lhreml503-mbs>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E162C98EA@lhreml503-mbs>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > Hi.
> > Sorry for the noob question :)
> > I'm currently developing a PCIe endpoint driver for a board that runs 
> > Linux.
> > The board will be used as an expansion PCIe card for x86 PC's.
> > Is there any guidelines, documentation related to PCI endpoint drivers 
> > for Linux kernel ?

> Hi Ramon
>
> Have you looked at
> http://lxr.free-electrons.com/source/Documentation/PCI/pci.txt
>?
>
> Regards
>
> Gab

Hi Gab, you misunderstood my driver type.
This is not a host driver, that I'm writing, but the actual endpoint driver. Then Linux is on the PCIe board.

> > I didn't find any, and I guess that I'm left with a platform driver.
> > 
> > If indeed the platform driver is the way to go, are there any 
> > implementations upstream I can look at ?
> > 
> > Thanks !
> > Ramon. 
