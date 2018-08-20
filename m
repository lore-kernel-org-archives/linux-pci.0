Return-Path: <SRS0=Hy8D=LD=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=Hy8D=LD=intel.com=keith.busch@kernel.org>
Date: Mon, 20 Aug 2018 10:32:10 -0600
From: Keith Busch <keith.busch@intel.com>
To: poza@codeaurora.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
	Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
Message-ID: <20180820163210.GA16275@localhost.localdomain>
References: <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
 <20180819021922.GE128050@bhelgaas-glaptop.roam.corp.google.com>
 <fe891b63-12c7-61ab-a59a-ae24ad766754@kernel.org>
 <ab5cb5b277f1c1c1362ef597ca7b8c6a2cd32cdf.camel@kernel.crashing.org>
 <908ff33ded8f31830f95a8889d8540f1@codeaurora.org>
 <5027d857bb59edfd33442003aa618ece1bc9cd52.camel@kernel.crashing.org>
 <b2e2ac5c92d8a91d00606754d1046578@codeaurora.org>
 <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
 <20180820155325.GA16148@localhost.localdomain>
 <b88127708aa9322371c69c5094fcb0f5@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b88127708aa9322371c69c5094fcb0f5@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 20, 2018 at 09:43:48PM +0530, poza@codeaurora.org wrote:
> On 2018-08-20 21:23, Keith Busch wrote:
> > On Mon, Aug 20, 2018 at 09:22:27PM +1000, Benjamin Herrenschmidt wrote:
> > > The main problem with unplug/replug (as I mentioned earlier) is that
> > > it
> > > just does NOT work for storage controllers (or similar type of
> > > devices). The links between the storage controller and the mounted
> > > filesystems is lost permanently, you'll most likely have to reboot the
> > > machine.
> > 
> > You probably shouldn't mount raw storage devices if they can be hot
> > added/removed. There are device mappers for that! :)
> > 
> > And you can't just change DPC device removal. A DPC event triggers
> > the link down, and that will trigger pciehp to disconnect the subtree
> > anyway. Having DPC do it too just means you get the same behavior with
> > or without enabling STLCTL.DLLSC.
> 
> Hi Keith,
> 
> what about the bridges which are not hotplug capable ?

That would have to mean SLTCTL.DLSSC isn't enabled. The point was to
make DPC control behave the same regardless of slot control.
