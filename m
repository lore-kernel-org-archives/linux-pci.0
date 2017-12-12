Return-Path: <SRS0=hqxK=DI=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=hqxK=DI=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 12 Dec 2017 18:07:31 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: keystone: fix interrupt-controller-node lookup
Message-ID: <20171212180731.GA22805@red-moon>
References: <20171117133831.1300-1-johan@kernel.org>
 <20171211102955.GK5672@localhost>
 <20171211104233.GB3225@red-moon>
 <20171212172537.GB53955@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171212172537.GB53955@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 12, 2017 at 11:25:37AM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 11, 2017 at 10:42:33AM +0000, Lorenzo Pieralisi wrote:
> > On Mon, Dec 11, 2017 at 11:29:55AM +0100, Johan Hovold wrote:
> > > On Fri, Nov 17, 2017 at 02:38:31PM +0100, Johan Hovold wrote:
> > > > Fix child-node lookup during initialisation which was using the wrong
> > > > OF-helper and ended up searching the whole device tree depth-first
> > > > starting at the parent rather than just matching on its children.
> > > > 
> > > > To make things worse, the parent pci node could end up being prematurely
> > > > freed as of_find_node_by_name() drops a reference to its first argument.
> > > > Any matching child interrupt-controller node was also leaked.
> > > > 
> > > > Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
> > > > Cc: stable <stable@vger.kernel.org>     # 3.18
> > > > Acked-by: Murali Karicheri <m-karicheri2@ti.com>
> > > > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > > ---
> > > > 
> > > > v2
> > > >  - amend commit message and mention explicitly that of_find_node_by_name()
> > > >    drops a reference to the start node
> > > >  - add Murali's and Lorenzo's acks
> > > 
> > > This one hasn't shown up in linux-next, so sending a reminder to make
> > > sure it doesn't fall between the cracks.
> > 
> > Hi Johan,
> > 
> > yes it is in the list of fixes to be sent upstream - I was about to
> > ask Bjorn to apply it.
> 
> Is this something that needs to be merged for v4.15?  If so, I need to
> be able to defend it to Linus as being a critical fix.  If the issue
> been around for 3 years (v3.18 was tagged Dec 7 2014), that requires
> pretty "clear and present danger."
> 
> From the commit log, I see a sub-optimal search (not critical), a
> possible use-after-free (could conceivably be critical if people are
> tripping over this, but would need more specifics about that), and a
> leak (not critical).
> 
> Given what I can see now, my inclination would be for Lorenzo to queue
> it for v4.16, which would still get in linux-next soonish.

It is fine by me and I think, as already mentioned, that the stable
tag is dubious so I will probably drop it.

Lorenzo
