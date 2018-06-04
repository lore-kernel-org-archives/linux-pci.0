Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 4 Jun 2018 12:49:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v1 0/2] PCI: shpchp: Minor fixes
Message-ID: <20180604174924.GB30381@bhelgaas-glaptop.roam.corp.google.com>
References: <152791788214.257724.13044360353832574147.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152791788214.257724.13044360353832574147.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 02, 2018 at 12:41:59AM -0500, Bjorn Helgaas wrote:
> An AMD POGO check in shpchp incorrectly included any device with device ID
> 0x7458, no matter what the vendor.
> 
> Also, use pci_info() instead of dbg() for messages related to OSHP.
> They're important enough that they should appear in dmesg.
> 
> I intend to include these along with Mika's shpchp updates.
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI: shpchp: Use dev_printk() for OSHP-related messages
>       PCI: shpchp: Fix AMD POGO identification
> 
> 
>  drivers/pci/hotplug/acpi_pcihp.c  |   13 ++++++-------
>  drivers/pci/hotplug/shpchp_ctrl.c |    8 ++++----
>  2 files changed, 10 insertions(+), 11 deletions(-)

I applied these with reviewed-by from Mika and Rafael to pci/hotplug for
v4.18.
