Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36796 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbdJSHdJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2017 03:33:09 -0400
Date: Thu, 19 Oct 2017 09:33:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [Update][PATCH v2 01/12] PM / core: Add NEVER_SKIP and
 SMART_PREPARE driver flags
Message-ID: <20171019073315.GB20787@kroah.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
 <1998650.Q52BuGQTI4@aspire.rjw.lan>
 <11013815.Nxk07oyMGD@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11013815.Nxk07oyMGD@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 19, 2017 at 01:17:31AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The motivation for this change is to provide a way to work around
> a problem with the direct-complete mechanism used for avoiding
> system suspend/resume handling for devices in runtime suspend.
> 
> The problem is that some middle layer code (the PCI bus type and
> the ACPI PM domain in particular) returns positive values from its
> system suspend ->prepare callbacks regardless of whether the driver's
> ->prepare returns a positive value or 0, which effectively prevents
> drivers from being able to control the direct-complete feature.
> Some drivers need that control, however, and the PCI bus type has
> grown its own flag to deal with this issue, but since it is not
> limited to PCI, it is better to address it by adding driver flags at
> the core level.
> 
> To that end, add a driver_flags field to struct dev_pm_info for flags
> that can be set by device drivers at the probe time to inform the PM
> core and/or bus types, PM domains and so on on the capabilities and/or
> preferences of device drivers.  Also add two static inline helpers
> for setting that field and testing it against a given set of flags
> and make the driver core clear it automatically on driver remove
> and probe failures.
> 
> Define and document two PM driver flags related to the direct-
> complete feature: NEVER_SKIP and SMART_PREPARE that can be used,
> respectively, to indicate to the PM core that the direct-complete
> mechanism should never be used for the device and to inform the
> middle layer code (bus types, PM domains etc) that it can only
> request the PM core to use the direct-complete mechanism for
> the device (by returning a positive value from its ->prepare
> callback) if it also has been requested by the driver.
> 
> While at it, make the core check pm_runtime_suspended() when
> setting power.direct_complete so that it doesn't need to be
> checked by ->prepare callbacks.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
