Return-Path: <SRS0=z17J=LE=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=z17J=LE=kernel.crashing.org=benh@kernel.org>
Message-ID: <277b7056aa7af8e98d5cd912838e582783943aa9.camel@kernel.crashing.org>
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
Date: Wed, 22 Aug 2018 07:14:32 +1000
In-Reply-To: <20180821143751.GA18477@localhost.localdomain>
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
	 <20180821143751.GA18477@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-08-21 at 08:37 -0600, Keith Busch wrote:
> > 
> > >      so if there is a way to figure out that in absence of pcihp, if DPC 
> > > is being used to support hotplug then we fall back to original DPC 
> > > mechanism (which is remove devices)
> > 
> > Not exactly. If the presence detect change indicates it was a hotplug
> > event rather.
> 
> The actions associated with error recovery will trigger link state changes
> for a lot of existing hardware. PCIEHP currently does the same removal
> sequence for both link state change (DLLSC) and presence detect change
> (PDC) events.
> 
> It sounds like you want pciehp to do nothing on the DLLSC events that it
> currently handles, and instead do the board removal only on PDC.  If that
> is the case, is the desire to not remove devices downstream a permanently
> disabled link, or does that responsibility fall onto some other component?

I think there need to be some coordination between pciehb and DPC on
link state change yes.

We could still remove the device if recovery fails. For example on EEH
we have a threshold and if a device fails more than N times within the
last M minutes (I don't remember the exact numbers and I'm not in front
of the code right now) we give up.

Also under some circumstances, the link will change as a result of the
error handling doing a hot reset.

For example, if the error happens in a parent bridge and that gets
reset, the entire hierarchy underneath does too.

We need to save/restore the state of all bridges and devices (BARs
etc...) below that.

Cheers,
Ben.
