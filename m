Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:57338 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750778AbbCSIYu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2015 04:24:50 -0400
Date: Thu, 19 Mar 2015 09:24:46 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: [PATCH] PCI: mvebu: add suspend/resume support
Message-ID: <20150319092446.468ab397@free-electrons.com>
In-Reply-To: <20150317151501.GC3368@io.lakedaemon.net>
References: <1426604145-12335-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20150317151501.GC3368@io.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Cooper,

On Tue, 17 Mar 2015 15:15:01 +0000, Jason Cooper wrote:

> > diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> > index 1309cfb..1ab8635 100644
> > --- a/drivers/pci/host/pci-mvebu.c
> > +++ b/drivers/pci/host/pci-mvebu.c
> > @@ -129,6 +129,7 @@ struct mvebu_pcie_port {
> >  	size_t memwin_size;
> >  	phys_addr_t iowin_base;
> >  	size_t iowin_size;
> > +	u32 saved_pcie_stat;
> 
> nit:  It's already in the pcie port struct, why not just call it saved_state?

Well the "stat" does not mean "state", but refers to the register being
saved in this field. The register is called: PCIE_STAT_OFF. Hence the
name saved_pcie_stat. But I'm fine with changing this to some other
name, I really don't care :)

> Either way,
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
