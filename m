Return-Path: <SRS0=vJbf=MA=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=vJbf=MA=intel.com=keith.busch@kernel.org>
Date: Tue, 18 Sep 2018 16:11:42 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Sinan Kaya <okaya@kernel.org>, Thomas Tai <thomas.tai@oracle.com>,
	"poza@codeaurora.org" <poza@codeaurora.org>,
	Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 15/20] PCI/pciehp: Fix powerfault detection order
Message-ID: <20180918221141.GA26372@localhost.localdomain>
References: <20180905203546.21921-1-keith.busch@intel.com>
 <20180905203546.21921-16-keith.busch@intel.com>
 <20180906193657.GH214747@bhelgaas-glaptop.roam.corp.google.com>
 <20180906195047.GD31024@localhost.localdomain>
 <20180907165352.GA250890@bhelgaas-glaptop.roam.corp.google.com>
 <20180907200332.GB250890@bhelgaas-glaptop.roam.corp.google.com>
 <20180907201819.GA1341@localhost.localdomain>
 <20180918214650.GG13616@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180918214650.GG13616@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 18, 2018 at 02:46:50PM -0700, Bjorn Helgaas wrote:
> On Fri, Sep 07, 2018 at 02:18:19PM -0600, Keith Busch wrote:
> > On Fri, Sep 07, 2018 at 03:03:32PM -0500, Bjorn Helgaas wrote:
> > > I applied this to for-linus with the following changelog.  Let me know
> > > if I didn't understand this correctly.  I changed the comment in
> > > pciehp_power_on_slot() so it doesn't say "sticky" to avoid confusion
> > > with the PCI spec concept of sticky register bits (ROS, RWS, RW1CS).
> > 
> > Perfect! Thanks for queueing this up. I'll drop this one from the rest
> > of the series, which will need at least a v3 to fix a dumb mistake in
> > pointed out in review, and I'll get the order to better sense (or maybe
> > split into independent patch sets).
> 
> Are you still planning a v3?  I really want to get this in for v4.20
> and I think there's probably some integration to be done with Lukas'
> series (which I haven't applied yet either).
> 
> I rebased my branches to v4.19-rc4 to avoid a merge conflict Lukas
> pointed out.

I'll send something out today, and I think I'll split it into multiple
independent sets.

I had to trim down what this is trying to accomplish due to existing
deadlocking bugs I've found in testing: there are several circular
dependencies on tasks holding the single pci_rescan_remove_lock. I don't
think I'll be able to fix that in time for 4.20, but I'll send the parts
that I believe are an improvement that don't break anything else.
