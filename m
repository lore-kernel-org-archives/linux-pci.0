Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 14 May 2018 08:32:22 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6 04/12] PCI: Make pciehp_is_native() stricter
Message-ID: <20180514053222.GD32438@lahna.fi.intel.com>
References: <20180510182844.77349-1-mika.westerberg@linux.intel.com>
 <20180510182844.77349-5-mika.westerberg@linux.intel.com>
 <20180510195149.GB29276@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180510195149.GB29276@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 10, 2018 at 09:51:49PM +0200, Lukas Wunner wrote:
> On Thu, May 10, 2018 at 09:28:36PM +0300, Mika Westerberg wrote:
> > +	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
> > +	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
> >  		return false;
> 
> Hm, any reason not to use "if (!bridge->is_hotplug_bridge)" ?

That can be set for non-native PCIe bridges. For example acpiphp sets it
in some cases. Here we read the capability directly to make sure we are
really dealing with native PCIe hotplug.
