Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 25 Jul 2017 15:44:10 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/3] PCI / PM: Skip bridges in pci_enable_wake()
Message-ID: <20170725124410.GQ2369@lahna.fi.intel.com>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan>
 <1895122.yvmCHzQO3z@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1895122.yvmCHzQO3z@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 21, 2017 at 02:38:08PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> PCI bridges only have a reason to generate wakeup signals on behalf
> of devices below them, so avoid preparing bridges for wakeup directly
> in pci_enable_wake().
> 
> Also drop the pci_has_subordinate() check from pci_pm_default_resume()
> as this will be done by pci_enable_wake() itself now.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
