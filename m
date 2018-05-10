Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 10 May 2018 21:51:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6 04/12] PCI: Make pciehp_is_native() stricter
Message-ID: <20180510195149.GB29276@wunner.de>
References: <20180510182844.77349-1-mika.westerberg@linux.intel.com>
 <20180510182844.77349-5-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180510182844.77349-5-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 10, 2018 at 09:28:36PM +0300, Mika Westerberg wrote:
> +	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
> +	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
>  		return false;

Hm, any reason not to use "if (!bridge->is_hotplug_bridge)" ?

Thanks,

Lukas
