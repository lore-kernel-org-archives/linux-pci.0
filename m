Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	catalin.marinas@arm.com, linaro-acpi@lists.linaro.org,
	linux-pci@vger.kernel.org, will.deacon@arm.com,
	okaya@codeaurora.org, wangyijing@huawei.com,
	Tomasz Nowicki <tn@semihalf.com>, rafael@kernel.org,
	ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, msalter@redhat.com,
	Liviu.Dudau@arm.com, jcm@redhat.com, mw@semihalf.com,
	jchandra@broadcom.com, linux-kernel@vger.kernel.org,
	hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com,
	jiang.liu@linux.intel.com
Subject: Re: [PATCH V6 02/13] pci, acpi: Provide generic way to assign bus domain number.
Date: Thu, 28 Apr 2016 17:34:10 +0200
Message-ID: <1614997.P8lXtkpXQq@wuerfel>
In-Reply-To: <20160428150815.GB15598@localhost>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com> <20160427173118.GA26653@red-moon> <20160428150815.GB15598@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 28 April 2016 10:12:12 Bjorn Helgaas wrote:
> On Wed, Apr 27, 2016 at 06:31:29PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Apr 27, 2016 at 11:44:53AM -0500, Bjorn Helgaas wrote:
> > > On Wed, Apr 27, 2016 at 12:17:58PM +0100, Lorenzo Pieralisi wrote:
> > > > On Tue, Apr 26, 2016 at 09:26:49PM -0500, Bjorn Helgaas wrote:
> > > > > On Fri, Apr 15, 2016 at 07:06:37PM +0200, Tomasz Nowicki wrote:
> 
> 
> > > Today we call pci_bus_assign_domain_nr() from the PCI core (from
> > > pci_create_root_bus()).  This is only implemented for
> > > PCI_DOMAINS_GENERIC, but even so, it fiddles around to figure out
> > > whether to get the domain from DT or to assign a new one.
> > > 
> > > That seems backwards to me.  The host bridge drivers already know
> > > where the domain should come from (ACPI _SEG, DT, etc.) and in the
> > > long term, I think they should be responsible for looking up or
> > > assigning a domain number *before* they call pci_create_root_bus().
> > 
> > Yes, the question still is how pci_create_root_bus() can get that
> > value (I am pretty certain this was heavily debated in the past, which
> > does not mean we can't give it another try).
> 
> Right, we don't have a good mechanism for passing more info into
> pci_create_root_bus().  Maybe the caller could fill in a struct so we
> have a chance to extend it without having to change all the existing
> callers.
> 
> I wonder if there's a design pattern we can copy, e.g., would
> something like the scsi_host_alloc(), scsi_add_host(),
> scsi_scan_host() model work here?

Yes, I think that is a good idea in general. Especially
now that we have separate the ARM code from pci_common_init_dev
and pci_sys_data, that can help with cleanups in the other drivers
as well.

I see two common variations in other subsystems: some use a
special alloc() function that you pass the size of the private
data into, while others just expect you to embed a structure
inside of the driver specific one allocate that separately to
have the generic registration function fill out the common fields.

I have a slight preference for the second, but they are really
the same thing basically.

	Arnd
