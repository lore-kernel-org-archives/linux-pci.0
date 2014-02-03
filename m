Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49083 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbaBCKiH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 3 Feb 2014 05:38:07 -0500
Date: Mon, 3 Feb 2014 12:45:11 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aaron Lu <aaron.lu@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v3 0/7] ACPI / hotplug / PCI: Consolidation of ACPIPHP
 with ACPI core device hotplug
Message-ID: <20140203104511.GR18029@intel.com>
References: <2217793.001RY6hKlo@vostro.rjw.lan>
 <1693151.2qrLZHyp0o@vostro.rjw.lan>
 <1519631.YS65c9Af2C@vostro.rjw.lan>
 <5157096.hCmU2aoKCT@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5157096.hCmU2aoKCT@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 02, 2014 at 06:11:19PM +0100, Rafael J. Wysocki wrote:
> As stated in the message at http://marc.info/?l=linux-acpi&m=139135963030012&w=4 ,
> patch [1/6] was actaully wrong and the whole patchset had to be reworked for that
> reason.  What follows is an entirely new version:
> 
> [1/7] Add a new function to ACPICA allowing a callback to be executed under the
>       namespace mutex after calling acpi_ns_get_attached_data().
> 
> [2/7] Use the new ACPICA's function to fix a couple of potential races related
>       to ACPI notifies.
> 
> [3/7] Same as [2/6] above.
> [4/7] Same as [3/6] above, rebased.
> [5/7] Same as [4/6] above.
> [6/7] Same as [5/6] above.
> [7/7] Dispatch ACPI hotplug notifications for "core" devices and PCI from
>       acpi_bus_notify().  This actually is different from [6/6] above, although
>       it serves the same purpose.
> 

On Intel NUC and DZ77RE-75K,

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
