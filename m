Return-Path: <SRS0=O1ob=KB=infradead.org=willy@kernel.org>
Return-Path: <SRS0=O1ob=KB=infradead.org=willy@kernel.org>
Date: Tue, 17 Jul 2018 14:46:03 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Martin Mares <mj@ucw.cz>, Logan Gunthorpe <logang@deltatee.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
	Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: lspci: Display path to device
Message-ID: <20180717214603.GB1771@bombadil.infradead.org>
References: <20180717170204.30470-1-logang@deltatee.com>
 <20180717203900.GA1771@bombadil.infradead.org>
 <20180717210053.GB128988@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180717210053.GB128988@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 17, 2018 at 04:00:53PM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 17, 2018 at 01:39:00PM -0700, Matthew Wilcox wrote:
> > The Nehalem system makes an interesting testcase because it exposes some
> > registers in fake PCIe devices that aren't behind the root ports.  eg:
> > 
> > ff:06.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory Controller Channel 2 Thermal Control Registers (rev 04)
> 
> I think these appear as conventional PCI devices; at least the ones
> I've seen, e.g., [1], don't have a PCIe capability, so I think it
> makes sense that they're not behind a root port.
> 
> [1] https://bugzilla5.redhat.com/attachment.cgi?id=433169

Oh, I don't think we're doing anything wrong with how we're displaying
them or what we're doing with what the system presents to us.  My only
point was that this is a good test-case for code which assumes that all
PCI devices lie under a PCIe root port.  At one point during development,
my code reported that device up there as

/06.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory Controller Channel 2 Thermal Control Registers (rev 04)

but since I had that system available to test with, I spotted that problem
and made it present that device as ff:06.3 (both with and without -P).
