Return-Path: <SRS0=uSZ2=LE=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=uSZ2=LE=intel.com=keith.busch@kernel.org>
Date: Tue, 21 Aug 2018 16:33:03 -0600
From: Keith Busch <keith.busch@intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: poza@codeaurora.org, Sinan Kaya <okaya@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
	Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
Message-ID: <20180821223303.GA19320@localhost.localdomain>
References: <5027d857bb59edfd33442003aa618ece1bc9cd52.camel@kernel.crashing.org>
 <b2e2ac5c92d8a91d00606754d1046578@codeaurora.org>
 <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
 <a149d9657ca83b41c724b0ddd319c6fb@codeaurora.org>
 <512e0e11c3ba462c1d033f8b0e768fa27489731c.camel@kernel.crashing.org>
 <ad23b16cf7ff1f3b51961fda59533892@codeaurora.org>
 <2742bdba5ae8ccc420234b6e6b0224919367ed4c.camel@kernel.crashing.org>
 <20180821143751.GA18477@localhost.localdomain>
 <277b7056aa7af8e98d5cd912838e582783943aa9.camel@kernel.crashing.org>
 <20180821220456.GC18612@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180821220456.GC18612@localhost.localdomain>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 21, 2018 at 04:04:56PM -0600, Keith Busch wrote:
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

A picture of a real scenario to go with the above comments:

                    ----------------
  --------          |              |
  |      |       -------        -------       --------------
  |  RP  | <---> | USP | SWITCH | DSP | <---> | END DEVICE |
  |      |       ------         -------       --------------
  --------          |              |
                    ----------------

The downstream port (DSP) is hotplug capable, and the root port (RP)
has DPC enabled.

Lets say you hot swap END DEVICE at a time with an inflight posted
transaction such that the RP triggers a CTO, starting a DPC event.
If you treat the RP's DPC event as just "error handling" and restore
the state after containment is released, we are in undefined behavior
because of the mistaken idententy of the device below the SWITCH DSP.

Re-enumerating the topology is easy since it has no races like that. I
understand re-enumeration is problematic for some scenarios, so if we
really need to avoid re-enumeration except when absolutely necessary,
it should be possible if we can detangle the necessary coordination
between the port service drivers.
