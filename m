Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56956 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755713AbaCEATT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Mar 2014 19:19:19 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Use pci_device_is_present()
Date: Wed, 05 Mar 2014 01:34:29 +0100
Message-ID: <4033818.pd6BkAIJKt@vostro.rjw.lan>
In-Reply-To: <20140304082358.GV5018@intel.com>
References: <1505390.MlpMqG8COu@vostro.rjw.lan> <20140304082358.GV5018@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, March 04, 2014 10:23:58 AM Mika Westerberg wrote:
> On Mon, Mar 03, 2014 at 01:19:25AM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Make the ACPI-based PCI hotplug (ACPIPHP) code use
> > pci_device_is_present() for checking if devices are present instead
> > of open coding the same thing.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
