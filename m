Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56581 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755501AbbDUPPZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2015 11:15:25 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH] ia64/PCI: Treat all host bridge Address Space Descriptors (even consumers) as windows
Date: Tue, 21 Apr 2015 17:40:05 +0200
Message-ID: <8894432.G9pvVBipeX@vostro.rjw.lan>
In-Reply-To: <20150420233055.20866.87460.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150420233055.20866.87460.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, April 20, 2015 06:30:55 PM Bjorn Helgaas wrote:
> Prior to c770cb4cb505 ("PCI: Mark invalid BARs as unassigned"), if we tried
> to claim a PCI BAR but could not find an upstream bridge window that
> matched it, we complained but still allowed the device to be enabled.
> 
> c770cb4cb505 broke devices that previously worked (mptsas and igb in the
> case Tony reported, but it could be any devices) because it marks those
> BARs as IORESOURCE_UNSET, which makes pci_enable_device() complain and
> return failure:
> 
>   igb 0000:81:00.0: can't enable device: BAR 0 [mem size 0x00020000] not assigned
>   igb: probe of 0000:81:00.0 failed with error -22
> 
> The underlying cause is an ACPI Address Space Descriptor for a PCI host
> bridge window that is marked as "consumer".  This is a firmware defect:
> resources that are produced on the downstream side of a bridge should be
> marked "producer".  But rejecting these BARs that we previously allowed is
> a functionality regression, and firmware has not used the producer/consumer
> bit consistently, so we can't rely on it anyway.
> 
> Stop checking the producer/consumer bit, and assume all bridge Address
> Space Descriptors are for bridge windows.
> 
> Note that this change does not affect I/O Port or Fixed Location I/O Port
> Descriptors, which are commonly used for the [io 0x0cf8-0x0cff] config
> access range.  That range is a "consumer" range and should not be treated
> as a window.
> 
> Fixes: c770cb4cb505 ("PCI: Mark invalid BARs as unassigned")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96961
> Reported-and-tested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

