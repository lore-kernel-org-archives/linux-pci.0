Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 26 Jan 2016 10:23:00 -0800
From: "Veal, Bryan E." <bryan.e.veal@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	"Derrick, Jonathan" <jonathan.derrick@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
Message-ID: <20160126182259.GA15260@intel.com>
Reply-To: bryan.e.veal@intel.com
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
 <20160115181938.GA5296@localhost>
 <8D943B239464E04C9184454D8B3F5CFF0ABF18EC@ORSMSX101.amr.corp.intel.com>
 <20160115220631.GA14080@localhost>
 <20160119153822.GA3979@localhost.localdomain>
 <20160119160220.GA22059@infradead.org>
 <20160120204308.GD7973@localhost>
 <20160126164609.GC15979@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160126164609.GC15979@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 26, 2016 at 08:46:09AM -0800, Christoph Hellwig wrote:
> On Wed, Jan 20, 2016 at 02:43:08PM -0600, Bjorn Helgaas wrote:
> > I saw responses from Keith and Bryan, and I hope they answer your
> > questions.  As far as I can tell, the VMD driver is grossly similar to
> > other host bridge drivers we've already merged, and I don't think we
> > have public specs for all of them.
> > 
> > Unless you have further concerns, I'm going to ask Linus to pull this
> > tomorrow, along with the rest of the PCI changes for v4.5.
> 
> I still think it's a bad idea to merge something odd like this without
> a good explanation or showing what devices can actually sit under it.
> 
> But you're the maintainer in the end..

Any PCIe devices and and bridges should work with existing upstream
drivers. The only exceptions would be anything depndent on INTx or IO
ports.
