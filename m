Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 20 Jan 2016 14:22:43 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
Subject: Re: [PATCH V3 11/21] pci, acpi: Move ACPI host bridge device
 companion assignment to core code.
Message-ID: <20160120142243.GB13437@red-moon>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-12-git-send-email-tn@semihalf.com>
 <20160119160224.GD5276@red-moon>
 <569F6D67.5000000@semihalf.com>
 <20160120123849.GA13437@red-moon>
 <569F8E38.5030101@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <569F8E38.5030101@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 20, 2016 at 02:40:08PM +0100, Tomasz Nowicki wrote:

[...]

> >>>>+	/* Root bridge device needs to be sure of parent ACPI type */
> >>>>+	ACPI_COMPANION_SET(&device->dev, device);
> >>>
> >>>I do not understand why the code above is needed, can you elaborate
> >>>please ?
> >>>
> >>
> >>This makes sure that device->dev can be identified as ACPI device,
> >>so we can use to_acpi_device_node() and assign companion safely
> >>below.
> >
> >I do not follow. If you refer to the fwnode handle type, that is
> >already set by ACPI core code (before acpi_pci_root_add() is called,
> >in acpi_init_device_object()).
> 
> acpi_init_device_object() sets ACPI fwnode handle type only for
> "device", but not for "device->dev" which is what is passed as an
> argument to pci_create_root_bus().
> 
> Without ACPI_COMPANION_SET(&device->dev, device) here, no one can be
> sure if we have ACPI device in pci_create_root_bus().

Ok, got it. The question is whether this should be done in ACPI
core instead (is there a reason why it should *not* be done ?), but I
now understand your point.

Thanks,
Lorenzo
