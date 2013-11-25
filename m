Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5292C158.7090508@intel.com>
Date: Mon, 25 Nov 2013 11:17:44 +0800
From: Aaron Lu <aaron.lu@intel.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/4] ACPI / bind: Simplify child devices lookup
References: <2610478.KxPMyuOMok@vostro.rjw.lan>
In-Reply-To: <2610478.KxPMyuOMok@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/25/2013 08:09 AM, Rafael J. Wysocki wrote:
> Hi,
> 
> The following series of four patches (on top of current linux-pm.git/bleeding-edge)
> rework child device lookup in drivers/acpi/glue.c and related things:
> 
> [1/4] ACPI / bind: Simplify child device lookup
> [2/4] PCI/ ACPI: Use acpi_find_child_device() for child device lookup
> [3/4] ACPI / bind: Redefine acpi_get_child()
> [4/4] ACPI / bind: Redefine acpi_preset_companion()
> 
> Thanks!
> 

Reviewed-by: Aaron Lu <aaron.lu@intel.com>
Tested-by: Aaron Lu <aaron.lu@intel.com> #for ATA binding
