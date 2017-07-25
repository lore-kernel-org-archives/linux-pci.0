Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42341 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750980AbdGYMpc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jul 2017 08:45:32 -0400
Date: Tue, 25 Jul 2017 15:45:27 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] ACPI / PM: Split acpi_device_wakeup()
Message-ID: <20170725124527.GR2369@lahna.fi.intel.com>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan>
 <3408475.MC8krXn0zk@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3408475.MC8krXn0zk@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 21, 2017 at 02:40:49PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> To prepare for a subsequent change and make the code somewhat easier
> to follow, do the following in the ACPI device wakeup handling code:
> 
>  * Replace wakeup.flags.enabled under struct acpi_device with
>    wakeup.enable_count as that will be necessary going forward.
> 
>    For now, wakeup.enable_count is not allowed to grow beyond 1,
>    so the current behavior is retained.
> 
>  * Split acpi_device_wakeup() into acpi_device_wakeup_enable()
>    and acpi_device_wakeup_disable() and modify the callers of
>    it accordingly.
> 
>  * Introduce a new acpi_wakeup_lock mutex to protect the wakeup
>    enabling/disabling code from races in case it is executed
>    more than once in parallel for the same device (which may
>    happen for bridges theoretically).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
