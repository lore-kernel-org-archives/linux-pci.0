Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 11 Jan 2013 22:37:59 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Toshi Kani <toshi.kani@hp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	Myron Stowe <myron.stowe@redhat.com>,
	Yijing Wang <wangyijing0307@gmail.com>,
	Jiang Liu <liuj97@gmail.com>
Subject: Re: [PATCH 1/16] ACPI: Separate adding ACPI device objects from
 probing ACPI drivers
Message-ID: <20130111203759.GC13897@intel.com>
References: <8498184.VilrUmatxI@vostro.rjw.lan>
 <23002897.6xbQGtPaGy@vostro.rjw.lan>
 <20130111200046.GB13897@intel.com>
 <2859994.arbXorpfaz@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2859994.arbXorpfaz@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 11, 2013 at 09:31:43PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: ACPI / scan: Fix check of device_attach() return value.
> 
> Since device_attach() returns 1 on success and 0 on failure,
> the check against its return value in acpi_bus_device_attach()
> should be reveresed.  Make it so.

Not sure if it matters but it returns 0 if no device was bound to a driver
and -ENODEV in case of error. If we only want to terminate in case of
error, following might be better.

	} else if (device_attach(&device->dev) < 0) {
