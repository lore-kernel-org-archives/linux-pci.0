Return-Path: <SRS0=Hy8D=LD=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=Hy8D=LD=intel.com=keith.busch@kernel.org>
Date: Mon, 20 Aug 2018 16:13:51 -0600
From: Keith Busch <keith.busch@intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sinan Kaya <okaya@kernel.org>, poza@codeaurora.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
	Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
Message-ID: <20180820221351.GA16932@localhost.localdomain>
References: <5027d857bb59edfd33442003aa618ece1bc9cd52.camel@kernel.crashing.org>
 <b2e2ac5c92d8a91d00606754d1046578@codeaurora.org>
 <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
 <20180820155325.GA16148@localhost.localdomain>
 <cf6de256280be7a2948db6dd2b5bfae92e70e12f.camel@kernel.crashing.org>
 <6aa71d74-e4dc-c627-1496-981278388bce@kernel.org>
 <20180820213544.GA16805@localhost.localdomain>
 <0193e0c5a52d8f2e93958f0683f3acc81cef2bc9.camel@kernel.crashing.org>
 <fd538f20-0754-f127-ceb9-693fec90b4af@kernel.org>
 <44195c0d7159ce4cd01b660002b2f5af5d53678b.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44195c0d7159ce4cd01b660002b2f5af5d53678b.camel@kernel.crashing.org>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 21, 2018 at 08:04:46AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2018-08-20 at 18:02 -0400, Sinan Kaya wrote:
> > On 8/20/2018 5:53 PM, Benjamin Herrenschmidt wrote:
> > > > > Hotplug driver removes the devices on link down events and re-enumerates
> > > > > on insertion.
> > > > > 
> > > > > I am trying to separate fatal error handling from hotplug.
> > > > 
> > > > I'll try to take a look. We can't always count on pciehp to do the
> > > > removal when a removal occurs, though. The PCIe specification contains
> > > > an implementation note that DPC may be used in place of hotplug surprise.
> > > 
> > > Can't you use the presence detect to differenciate ?
> > > 
> > > Also, I don't have the specs at hand right now, but does the hotplug
> > > brigde have a way to "latch' the change in presence detect so we can
> > > see if it has transitioned even if it's back on ?
> > 
> > There is only presence detect change and link layer change. No actual
> > state information.
> 
> It does latch that it has changed tho right ? So if presence detect
> hasn't changed, we can assume it's an error and not an unplug ?
> 
> We could discriminate that way to reduce the risk of doing a recovery
> without unbind on something that was actually removed and replaced.

There might be some potential here.

There actualy is a Slot Status Presence Detect State (PDS), but it isn't
latched. The link and presence change (PDC) are latched.

A potential problem may be a PDC event handling observes PDS set to the
last known state if the remove + add happens fast enough, and then no
action is taken in the current implementation.

The DPC capability learned from such issues, and they will latch the
status until acknowledged so those sorts of races are not possible.

But anyway, maybe we can change pciehp to ignore PDS and always
re-enumerate when PDC is observed, and that may very well simplify a lot
of this.
