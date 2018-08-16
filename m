Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54198 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbeHPWPf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Aug 2018 18:15:35 -0400
Date: Thu, 16 Aug 2018 22:15:15 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        teika kazura <teika@gmx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PCI / ACPI / PM: Resume all bridges on suspend-to-RAM
Message-ID: <20180816191515.GM2343@lahna.fi.intel.com>
References: <6401388.2t0qD3iTOr@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6401388.2t0qD3iTOr@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2018 at 12:56:46PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 26112ddc254c (PCI / ACPI / PM: Resume bridges w/o drivers on
> suspend-to-RAM) attempted to fix a functional regression resulting
> from commit c62ec4610c40 (PM / core: Fix direct_complete handling
> for devices with no callbacks) by resuming PCI bridges without
> drivers (that is, "parallel PCI" ones) during system-wide suspend if
> the target system state is not ACPI S0 (working state).
> 
> That turns out insufficient, however, as it is reported that, at
> least in one case, the platform firmware gets confused if a PCIe
> root port is suspended before entering the ACPI S3 sleep state.
> 
> For this reason, drop the driver check from acpi_pci_need_resume()
> and resume all bridges (including PCIe ports with drivers) during
> system-wide suspend if the target system state is not ACPI S0.
> 
> [If the target system state is ACPI S0, it means suspend-to-idle
>  and the platform firmware is not going to be invoked to actually
>  suspend the system, so there is no need to resume the bridges in
>  that case.]
> 
> Fixes: c62ec4610c40 (PM / core: Fix direct_complete handling for devices with no callbacks)
> Reported-by: teika kazura <teika@gmx.com>
> Tested-by: teika kazura <teika@gmx.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200675
> Cc: 4.15+ <stable@vger.kernel.org> # 4.15+: 26112ddc254c (PCI / ACPI / PM: Resume bridges ...)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
