Return-Path: <SRS0=3Sc0=LN=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=3Sc0=LN=kernel.crashing.org=benh@kernel.org>
Message-ID: <fa27712ea85297f5294da007c3532038abb50b42.camel@kernel.crashing.org>
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
Date: Thu, 30 Aug 2018 14:26:02 +1000
In-Reply-To: <20180830000100.GA5841@localhost.localdomain>
References: <b2e2ac5c92d8a91d00606754d1046578@codeaurora.org>
	 <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
	 <a149d9657ca83b41c724b0ddd319c6fb@codeaurora.org>
	 <512e0e11c3ba462c1d033f8b0e768fa27489731c.camel@kernel.crashing.org>
	 <ad23b16cf7ff1f3b51961fda59533892@codeaurora.org>
	 <2742bdba5ae8ccc420234b6e6b0224919367ed4c.camel@kernel.crashing.org>
	 <20180821143751.GA18477@localhost.localdomain>
	 <277b7056aa7af8e98d5cd912838e582783943aa9.camel@kernel.crashing.org>
	 <20180821220456.GC18612@localhost.localdomain>
	 <5d69daf9918878b95b6df3265fc4c3d5b52f9baa.camel@kernel.crashing.org>
	 <20180830000100.GA5841@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2018-08-29 at 18:01 -0600, Keith Busch wrote:
> On Wed, Aug 22, 2018 at 09:06:57AM +1000, Benjamin Herrenschmidt wrote:
> > It can be probably done by a simple test & skip as you go down
> > restoring state, then handling the removals after the dance is
> > complete.
> 
> I tested on a variety of hardware, and there are mixed results. The spec
> captures the crux of the problem with checking PDC (7.5.3.11):
> 
>   Note that the in-band presence detect mechanism requires that power be
>   applied to an adapter for its presence to be detected. Consequently,
>   form factors that require a power controller for hot-plug must implement
>   a physical pin presence detect mechanism.
> 
> Many slots don't implement power controllers, so a secondary bus reset
> always triggers a PDC. We can't really ignore PDC during fatal error
> handling since hot plugs are the types of actions that often trigger
> fatal errors..
> 
> Does it sound okay to trust PDC anyway? It's no worse than what would
> happen currently, and it doesn't affect non-hotplug slots.

I think so.

As you say, it's not worse and worst case, we try the recovery and
fail, which can then lead to an unplug if we wish to do so. No biggie.

Cheers,
Ben,
