Return-Path: <SRS0=z17J=LE=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=z17J=LE=kernel.crashing.org=benh@kernel.org>
Message-ID: <5d69daf9918878b95b6df3265fc4c3d5b52f9baa.camel@kernel.crashing.org>
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
Date: Wed, 22 Aug 2018 09:06:57 +1000
In-Reply-To: <20180821220456.GC18612@localhost.localdomain>
References: <908ff33ded8f31830f95a8889d8540f1@codeaurora.org>
	 <5027d857bb59edfd33442003aa618ece1bc9cd52.camel@kernel.crashing.org>
	 <b2e2ac5c92d8a91d00606754d1046578@codeaurora.org>
	 <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
	 <a149d9657ca83b41c724b0ddd319c6fb@codeaurora.org>
	 <512e0e11c3ba462c1d033f8b0e768fa27489731c.camel@kernel.crashing.org>
	 <ad23b16cf7ff1f3b51961fda59533892@codeaurora.org>
	 <2742bdba5ae8ccc420234b6e6b0224919367ed4c.camel@kernel.crashing.org>
	 <20180821143751.GA18477@localhost.localdomain>
	 <277b7056aa7af8e98d5cd912838e582783943aa9.camel@kernel.crashing.org>
	 <20180821220456.GC18612@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-08-21 at 16:04 -0600, Keith Busch wrote:
> > I think there need to be some coordination between pciehb and DPC on
> > link state change yes.
> > 
> > We could still remove the device if recovery fails. For example on EEH
> > we have a threshold and if a device fails more than N times within the
> > last M minutes (I don't remember the exact numbers and I'm not in front
> > of the code right now) we give up.
> > 
> > Also under some circumstances, the link will change as a result of the
> > error handling doing a hot reset.
> > 
> > For example, if the error happens in a parent bridge and that gets
> > reset, the entire hierarchy underneath does too.
> > 
> > We need to save/restore the state of all bridges and devices (BARs
> > etc...) below that.
> 
> That's not good enough. You'd at least need to check SLTSTS.PDC on all
> bridge DSP's beneath the parent *before* you try to restore the state
> of devices beneath them. Those races are primarily why DPC currently
> removes and reenumerates instead, because that's not something that can
> be readily coordinated today.

It can be probably done by a simple test & skip as you go down
restoring state, then handling the removals after the dance is
complete.

Cheers,
Ben.
