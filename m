Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:4307 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab3KEXcD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2013 18:32:03 -0500
Message-ID: <1383694061.1847.13.camel@misato.fc.hp.com>
Subject: Re: [Update][PATCH 1/6] ACPI / scan: Start matching drivers after
 trying scan handlers
From: Toshi Kani <toshi.kani@hp.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Date: Tue, 05 Nov 2013 16:27:41 -0700
In-Reply-To: <2151922.M630KK6nC3@vostro.rjw.lan>
References: <5839747.7HXXGHmMBd@vostro.rjw.lan>
	 <2970389.SeMGM45Qln@vostro.rjw.lan> <2151922.M630KK6nC3@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-11-04 at 14:30 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> ACPI scan handlers should always be attached to struct acpi_device
> objects before any ACPI drivers, but there is a window during which
> a driver may be attached to a struct acpi_device before checking if
> there is a matching scan handler.  Namely, that will happen if an
> ACPI driver module is loaded during acpi_bus_scan() right after
> the first namespace walk is complete and before the given device
> is processed by the second namespace walk.
> 
> To prevent that from happening, set the match_driver flags of
> struct acpi_device objects right before running device_attach()
> for them in acpi_bus_device_attach().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi

