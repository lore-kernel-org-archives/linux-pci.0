Return-Path: <SRS0=HZd4=LD=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=HZd4=LD=kernel.crashing.org=benh@kernel.org>
Message-ID: <cf6de256280be7a2948db6dd2b5bfae92e70e12f.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Keith Busch <keith.busch@intel.com>
Cc: poza@codeaurora.org, Sinan Kaya <okaya@kernel.org>,
        Bjorn Helgaas
 <helgaas@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
        Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Tue, 21 Aug 2018 07:05:52 +1000
In-Reply-To: <20180820155325.GA16148@localhost.localdomain>
References: <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
	 <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
	 <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
	 <20180819021922.GE128050@bhelgaas-glaptop.roam.corp.google.com>
	 <fe891b63-12c7-61ab-a59a-ae24ad766754@kernel.org>
	 <ab5cb5b277f1c1c1362ef597ca7b8c6a2cd32cdf.camel@kernel.crashing.org>
	 <908ff33ded8f31830f95a8889d8540f1@codeaurora.org>
	 <5027d857bb59edfd33442003aa618ece1bc9cd52.camel@kernel.crashing.org>
	 <b2e2ac5c92d8a91d00606754d1046578@codeaurora.org>
	 <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
	 <20180820155325.GA16148@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2018-08-20 at 09:53 -0600, Keith Busch wrote:
> On Mon, Aug 20, 2018 at 09:22:27PM +1000, Benjamin Herrenschmidt wrote:
> > The main problem with unplug/replug (as I mentioned earlier) is that it
> > just does NOT work for storage controllers (or similar type of
> > devices). The links between the storage controller and the mounted
> > filesystems is lost permanently, you'll most likely have to reboot the
> > machine.
> 
> You probably shouldn't mount raw storage devices if they can be hot
> added/removed. There are device mappers for that! :)

This is not about hot adding/removing, it's about error recovery.

> And you can't just change DPC device removal. A DPC event triggers
> the link down, and that will trigger pciehp to disconnect the subtree
> anyway. Having DPC do it too just means you get the same behavior with
> or without enabling STLCTL.DLLSC.

This is wrong. EEH can trigger a link down to and we don't remove the
subtree in that case. We allow the drivers to recover.

Ben.
