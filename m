Return-Path: <SRS0=kwQm=EE=free-electrons.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=kwQm=EE=free-electrons.com=thomas.petazzoni@kernel.org>
Date: Tue, 9 Jan 2018 16:39:18 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Jason
 Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement
 <gregory.clement@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>,
 Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>,
 linux-arm-kernel@lists.infradead.org, Antoine Tenart
 <antoine.tenart@free-electrons.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@free-electrons.com>, Victor Gu <xigu@marvell.com>
Subject: Re: [PATCH v2 3/7] PCI: aardvark: set host and device to the same
 MAX payload size
Message-ID: <20180109163918.5e46c1a1@windsurf.lan>
In-Reply-To: <20171005173102.GR25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
	<20170928125838.11887-4-thomas.petazzoni@free-electrons.com>
	<20171005173102.GR25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

On Thu, 5 Oct 2017 12:31:02 -0500, Bjorn Helgaas wrote:
> On Thu, Sep 28, 2017 at 02:58:34PM +0200, Thomas Petazzoni wrote:
> > From: Victor Gu <xigu@marvell.com>
> > 
> > Since the Aardvark does not implement a PCIe root bus,   
> 
> What exactly do you mean by "does not implement a PCIe root bus"?  I
> assume there is still a hierarchy of PCI buses, and I assume the
> hierarchy has a top-most ("root") bus.
> 
> Maybe there's no Root Port?  There are other systems that don't have
> Root Ports, and we've made changes to accommodate that, e.g.,
> 
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=1b8a6079015f

I'm trying to get back (finally) to this topic. Unfortunately, your
branch has been rebased, and this commit no longer exists. Do you have
an updated pointer about what you suggest to use for systems that don't
have Root Ports ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
