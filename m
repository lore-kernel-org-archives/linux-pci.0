Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 14 Nov 2013 11:43:48 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aaron Lu <aaron.lu@intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Lan Tianyu <tianyu.lan@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 2/2] ACPI / bind: Use (put|get)_device() on ACPI device
 objects too
Message-ID: <20131114024348.GA9899@kroah.com>
References: <3268437.YsusHvklcv@vostro.rjw.lan>
 <1803808.ghCmmaO2Cj@vostro.rjw.lan>
 <9712243.It8gvaRCs0@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9712243.It8gvaRCs0@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 14, 2013 at 12:26:47AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> When associating a "physical" device with an ACPI device object
> acpi_bind_one() only uses get_device() to increment the reference
> counter of the former, but there is no reason not to do that with
> the latter too.  Among other things, that may help to avoid
> use-after-free when an ACPI device object is freed without calling
> acpi_unbind_one() for all "physical" devices associated with it
> (that only can happen in buggy code, but then it's better if the
> kernel doesn't crash as a result of a bug).
> 
> For this reason, modify acpi_bind_one() to apply get_device() to
> the ACPI device object too and update acpi_unbind_one() to drop
> that reference using put_device() as appropriate.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
