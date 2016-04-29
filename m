Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, linaro-acpi@lists.linaro.org,
	linux-pci@vger.kernel.org, will.deacon@arm.com,
	okaya@codeaurora.org, wangyijing@huawei.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>, rafael@kernel.org,
	ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com,
	Bjorn Helgaas <helgaas@kernel.org>, msalter@redhat.com,
	Liviu.Dudau@arm.com, mw@semihalf.com, jcm@redhat.com,
	jchandra@broadcom.com, linux-kernel@vger.kernel.org,
	hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com,
	jiang.liu@linux.intel.com
Subject: Re: [PATCH V6 02/13] pci, acpi: Provide generic way to assign bus domain number.
Date: Sat, 30 Apr 2016 00:50:11 +0200
Message-ID: <1964262.h2oIOhyNUf@wuerfel>
In-Reply-To: <1614997.P8lXtkpXQq@wuerfel>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com> <20160428150815.GB15598@localhost> <1614997.P8lXtkpXQq@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 28 April 2016 17:34:10 Arnd Bergmann wrote:
> On Thursday 28 April 2016 10:12:12 Bjorn Helgaas wrote:
> > Right, we don't have a good mechanism for passing more info into
> > pci_create_root_bus().  Maybe the caller could fill in a struct so we
> > have a chance to extend it without having to change all the existing
> > callers.
> > 
> > I wonder if there's a design pattern we can copy, e.g., would
> > something like the scsi_host_alloc(), scsi_add_host(),
> > scsi_scan_host() model work here?
> 
> Yes, I think that is a good idea in general. Especially
> now that we have separate the ARM code from pci_common_init_dev
> and pci_sys_data, that can help with cleanups in the other drivers
> as well.
> 
> I see two common variations in other subsystems: some use a
> special alloc() function that you pass the size of the private
> data into, while others just expect you to embed a structure
> inside of the driver specific one allocate that separately to
> have the generic registration function fill out the common fields.
> 
> I have a slight preference for the second, but they are really
> the same thing basically.

I've tried this out now, and will follow up with a separate patch
series. Overall, I think it works out well, though I haven't gotten
to the point of actually saving code yet. I've converted two
drivers for demonstration.

	Arnd
