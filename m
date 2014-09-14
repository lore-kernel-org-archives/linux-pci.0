Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, SpacemanSpiff <a818958@trbvm.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
	Alex Deucher <alexdeucher@gmail.com>,
	"Jose P." <lbdkmjdf@sharklasers.com>
Subject: Re: [PATCH 0/2] PCI: Ignore hotplug events for dual GPU systems
Date: Sun, 14 Sep 2014 20:04:40 +0200
Message-ID: <1434331.0IZIM5O2Ci@vostro.rjw.lan>
In-Reply-To: <20140911222022.16809.57079.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20140911222022.16809.57079.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, September 11, 2014 04:23:54 PM Bjorn Helgaas wrote:
> These are intended to resolve problems on dual GPU systems where the radeon
> driver becomes unusable because of problems suspending or resuming a GPU.
> When the GPU is powered off, we may get hotplug remove events, and we 
> would normally unbind the driver and destroy the pci_dev.  But in this
> case, the radeon and nouveau drivers expect to remain bound to the device
> because it isn't really removable, and they may power it back on later.
> 
> Links to the bug reports in the patch changelogs.
> 
> I would like to get these into v3.17 if they seem reasonable.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for both.

> ---
> 
> Bjorn Helgaas (2):
>       PCI: Add pci_ignore_hotplug() to ignore hotplug events for a device
>       ACPIPHP / radeon / nouveau: Remove acpi_bus_no_hotplug()
> 
> 
>  drivers/acpi/bus.c                           |   10 ----------
>  drivers/gpu/drm/nouveau/nouveau_acpi.c       |   16 ++--------------
>  drivers/gpu/drm/nouveau/nouveau_drm.c        |    1 +
>  drivers/gpu/drm/radeon/radeon_atpx_handler.c |   16 ++--------------
>  drivers/gpu/drm/radeon/radeon_drv.c          |    1 +
>  drivers/pci/hotplug/acpiphp_glue.c           |   16 ++++++----------
>  drivers/pci/hotplug/pciehp_hpc.c             |   12 ++++++++++++
>  include/acpi/acpi_bus.h                      |    4 +---
>  include/linux/pci.h                          |    6 ++++++
>  9 files changed, 31 insertions(+), 51 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
