Return-Path: <SRS0=uSZ2=LE=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=uSZ2=LE=intel.com=keith.busch@kernel.org>
Date: Tue, 21 Aug 2018 08:37:51 -0600
From: Keith Busch <keith.busch@intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: poza@codeaurora.org, Sinan Kaya <okaya@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
	Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
Message-ID: <20180821143751.GA18477@localhost.localdomain>
References: <fe891b63-12c7-61ab-a59a-ae24ad766754@kernel.org>
 <ab5cb5b277f1c1c1362ef597ca7b8c6a2cd32cdf.camel@kernel.crashing.org>
 <908ff33ded8f31830f95a8889d8540f1@codeaurora.org>
 <5027d857bb59edfd33442003aa618ece1bc9cd52.camel@kernel.crashing.org>
 <b2e2ac5c92d8a91d00606754d1046578@codeaurora.org>
 <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
 <a149d9657ca83b41c724b0ddd319c6fb@codeaurora.org>
 <512e0e11c3ba462c1d033f8b0e768fa27489731c.camel@kernel.crashing.org>
 <ad23b16cf7ff1f3b51961fda59533892@codeaurora.org>
 <2742bdba5ae8ccc420234b6e6b0224919367ed4c.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2742bdba5ae8ccc420234b6e6b0224919367ed4c.camel@kernel.crashing.org>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 21, 2018 at 04:06:30PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2018-08-21 at 10:44 +0530, poza@codeaurora.org wrote:
> > 
> > Ok Let me summarize the so far discussed things.
> > 
> > It would be nice if we all (Bjorn, Keith, Ben, Sinan) can hold consensus 
> > on this.
> > 
> > 1) Right now AER and DPC both calls pcie_do_fatal_recovery(), I majorly 
> > see DPC as error handling and recovery agent rather than being used for 
> > hotplug.
> >     so in my opinion, both AER and DPC should have same error handling 
> > and recovery mechanism
> 
> Yes.
>
> >     so if there is a way to figure out that in absence of pcihp, if DPC 
> > is being used to support hotplug then we fall back to original DPC 
> > mechanism (which is remove devices)
> 
> Not exactly. If the presence detect change indicates it was a hotplug
> event rather.

The actions associated with error recovery will trigger link state changes
for a lot of existing hardware. PCIEHP currently does the same removal
sequence for both link state change (DLLSC) and presence detect change
(PDC) events.

It sounds like you want pciehp to do nothing on the DLLSC events that it
currently handles, and instead do the board removal only on PDC.  If that
is the case, is the desire to not remove devices downstream a permanently
disabled link, or does that responsibility fall onto some other component?
