Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 30 Jan 2017 14:34:18 +0000
From: Jason Cooper <jason@lakedaemon.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: mvebu: Handle changes to the bridge windows while
 enabled
Message-ID: <20170130143418.GB25924@io.lakedaemon.net>
References: <20161212183020.GA30274@obsidianresearch.com>
 <20170111183055.GD14532@bhelgaas-glaptop.roam.corp.google.com>
 <20170128211728.GJ20550@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <20170128211728.GJ20550@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Gregory CLEMENT <gregory.clement@free-electrons.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Sat, Jan 28, 2017 at 03:17:28PM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 11, 2017 at 12:30:55PM -0600, Bjorn Helgaas wrote:
> > On Mon, Dec 12, 2016 at 11:30:20AM -0700, Jason Gunthorpe wrote:
> > > The PCI core will write to the bridge window config multiple times
> > > while they are enabled. This can lead to mbus failures like:
> > > 
> > >  mvebu_mbus: cannot add window '4:e8', conflicts with another window
> > >  mvebu-pcie mbus:pex@e0000000: Could not create MBus window at [mem 0xe0000000-0xe00fffff]: -22
> > > 
> > > For me this is happening during a hotplug cycle. The PCI core is
> > > not changing the values, just writing them twice while active.
> > > 
> > > The patch addresses the general case of any change to an active window,
> > > but not atomically. The code is slightly refactored so io and mem
> > > can share more of the window logic.
> > 
> > Looks good to me, but I'm waiting for an ack from Thomas or Jason (listed
> > as maintainers and already cc'd).
> 
> Ping, Thomas, Jason C?
> 
> > > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > > ---
> > >  drivers/pci/host/pci-mvebu.c | 101 +++++++++++++++++++++++++------------------
> > >  1 file changed, 60 insertions(+), 41 deletions(-)

Sorry, been on travel and I think Thomas is on holiday.

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
