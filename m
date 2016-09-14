Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
Date: Wed, 14 Sep 2016 16:47:24 -0600
From: Jon Derrick <jonathan.derrick@intel.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [pci:pci/host-vmd 2/4] arch/x86/pci/vmd.c:674:6: error:
 'PCI_IRQ_MSIX' undeclared
Message-ID: <20160914224723.GA1894@localhost.localdomain>
References: <201609150417.nlp7t2XD%fengguang.wu@intel.com>
 <20160914204701.GA1591@localhost.localdomain>
 <20160914223016.GH16581@localhost>
 <20160914225049.GC16556@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160914225049.GC16556@localhost.localdomain>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 14, 2016 at 06:50:49PM -0400, Keith Busch wrote:
> On Wed, Sep 14, 2016 at 05:30:16PM -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 14, 2016 at 02:47:02PM -0600, Jon Derrick wrote:
> > > Fortunately these symbols are resolved as of v4.8-rc4
> > 
> > Can you point me to the commit that adds them?  I don't really want to
> > rebase all my branches to -rc4, but maybe I should.  I'm pretty
> > unsophisticated in my git usage.
> 
> If it's easier to get it from the pci repo, the commit is also currently
> in your 'for-linus' branch:
> 
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=4fe0d154880bb6eb833cbe84fa6f385f400f0b9c

Thanks Keith! Just tested and it looks like that was all that was needed
