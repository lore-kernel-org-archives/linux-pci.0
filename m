Return-Path: <SRS0=lVmX=KD=networkplumber.org=stephen@kernel.org>
Return-Path: <SRS0=lVmX=KD=networkplumber.org=stephen@kernel.org>
Date: Thu, 19 Jul 2018 10:36:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
 kys@microsoft.com, linux-pci@vger.kernel.org, Stephen Hemminger
 <sthemmin@microsoft.com>
Subject: Re: [PATCH] PCI: hv: support reporting serial number as slot
 information
Message-ID: <20180719103602.61ec8727@xeon-e3>
In-Reply-To: <20180719165858.GA22716@red-moon>
References: <20180612164037.10672-1-sthemmin@microsoft.com>
	<20180704160834.GB12996@red-moon>
	<20180711134908.GF188359@bhelgaas-glaptop.roam.corp.google.com>
	<20180713143819.14da12b1@xeon-e3>
	<20180719165858.GA22716@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Thu, 19 Jul 2018 17:58:59 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> > Thanks,
> > Stephen
> > 
> > 
> > 
> > PS: it is  nuisance that when the PCI support was moved to
> > drivers/pci/controllers it was not done in a way  that git correctly
> > tracked the rename. Therefore all the commit history was broken :-(  
> 
> Sorry about that.
> 
> Isn't "git log --follow" enough for this purpose ?
> 
> Thanks,
> Lorenzo

Your right --follow works, I will figure out how to make that
the default in .gitconfig
