Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5297F7C9.6090303@intel.com>
Date: Fri, 29 Nov 2013 10:11:21 +0800
From: Lan Tianyu <tianyu.lan@intel.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Aaron Lu <aaron.lu@intel.com>, Toshi Kani <toshi.kani@hp.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-ide@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] ACPI / bind: Use struct acpi_device pointers instead
 of ACPI handles
References: <4501334.ovACrGogrl@vostro.rjw.lan>
In-Reply-To: <4501334.ovACrGogrl@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013年11月29日 08:36, Rafael J. Wysocki wrote:
> Hi,
> 
> Now that we store a pointer to struct acpi_device as the ACPI companion in
> struct device, the code making associations between "physical" devices and
> ACPI device objects can be modified to work with struct acpi_device pointers
> instead of ACPI handles too.  The first two of the following patches make these
> changes and the third one is just a related cleanup.
> 
> [1/3] ACPI / bind: Replace .find_device in struct acpi_bus_type with .find_companion
> [2/3] ACPI / bind: Modify acpi_bind_one() to take a struct acpi_device pointer as
>       the second argument.
> [3/3] ACPI / bind: Move acpi_get_child() to ide-acpi.c which is the only remaining
>       user of that function.
> 

Test usb/ACPI bind part, it works normally.

Tested-by: Lan Tianyu <tianyu.lan@intel.com>

> The patches are on top of linux-pm.git/linux-next.  Please let me know if you see
> any problems in them.
> 
> Thanks!
> 


-- 
Best regards
Tianyu Lan
