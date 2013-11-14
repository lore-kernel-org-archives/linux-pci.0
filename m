Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 14 Nov 2013 11:44:07 +0900
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
Subject: Re: [PATCH 1/2] ACPI: Eliminate the DEVICE_ACPI_HANDLE() macro
Message-ID: <20131114024407.GB9899@kroah.com>
References: <3268437.YsusHvklcv@vostro.rjw.lan>
 <1803808.ghCmmaO2Cj@vostro.rjw.lan>
 <5216191.8B6uiYXXe4@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5216191.8B6uiYXXe4@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 14, 2013 at 12:26:00AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since DEVICE_ACPI_HANDLE() is now literally identical to
> ACPI_HANDLE(), replace it with the latter everywhere and drop its
> definition from include/acpi.h.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
