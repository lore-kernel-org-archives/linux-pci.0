Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 22 Jun 2017 10:39:37 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/6] ACPI / PM: Consolidate device wakeup settings code
Message-ID: <20170622073937.GR629@lahna.fi.intel.com>
References: <12296383.UdE5HVtyng@aspire.rjw.lan>
 <4424061.UyS4hGnq0F@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4424061.UyS4hGnq0F@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 19, 2017 at 11:33:52PM +0200, Rafael J. Wysocki wrote:
> -#ifdef CONFIG_PM_SLEEP
> -/**
> - * acpi_pm_device_sleep_wake - Enable or disable device to wake up the system.
> - * @dev: Device to enable/desible to wake up the system from sleep states.
> - * @enable: Whether to enable or disable @dev to wake up the system.
> - */
> -int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
> +int acpi_pm_device_wakeup(struct device *dev, bool enable)

Can we call it acpi_pm_device_enable_wakeup() and then provide
corresponding acpi_pm_device_disable_wakeup()? I find those easier to
understand than acpi_pm_device_wakeup() that sounds like the device
should be woken up now.
