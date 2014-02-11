Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:45307 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbaBKAUB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2014 19:20:01 -0500
Received: by mail-ig0-f171.google.com with SMTP id uy17so7751902igb.4
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2014 16:20:00 -0800 (PST)
Date: Mon, 10 Feb 2014 17:19:58 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Aaron Lu <aaron.lu@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/11] ACPI / hotplug / PCI: Updates on top of changes
 merged recently
Message-ID: <20140211001958.GB12851@google.com>
References: <2217793.001RY6hKlo@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2217793.001RY6hKlo@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 27, 2014 at 01:37:17AM +0100, Rafael J. Wysocki wrote:
> Hi All,
> 
> ACPIPHP can be simplified a bit on top of some PCI and ACPI changes merged
> recently and the following series of patches implements those simplifications:
> 
> [1/11] Fix up two kerneldoc comments in acpiphp_glue.c.
> [2/11] Get rid of an unnecessary label in register_slot().
> [3/11] Drop acpiphp_bus_trim() and use acpi_bus_trim() instead of it directly.
> [4/11] Move the acpi_bus_get_device() call out of acpiphp_no_hotplug().
> [5/11] Store struct acpi_device pointers instead of ACPI handles in struct acpiphp_context.
> [6/11] Drop acpiphp_bus_add() (which has only one user).
> [7/11] Drop crit_sect mutexes (that are redundant).
> [8/11] Clean up the usage of the slot variable in hotplug_event().
> [9/11] Drop dev_in_slot() and rework disable_slot() to walk bus->devices directly.
> [10/11] Use acpi_handle_debug() in hotplug_event() instead of open-coded stuff.
> [11/11] Drop handle argument from the member functions of struct acpi_dock_ops.

I assume you'll handle all these through your tree, Rafael.  Let me know if
you need me to do anything.

Bjorn

> All of that is relateively straightforward, but I have some more intrusive changes
> on top of it in the works.  They will be posted separately later this week.
> 
> Thanks!
> 
> -- 
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
