Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 10 May 2018 21:44:33 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6 03/12] PCI: Request control of native PCIe hotplug
 only if supported
Message-ID: <20180510194433.GA29276@wunner.de>
References: <20180510182844.77349-1-mika.westerberg@linux.intel.com>
 <20180510182844.77349-4-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180510182844.77349-4-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 10, 2018 at 09:28:35PM +0300, Mika Westerberg wrote:
> +
> +#ifdef CONFIG_HOTPLUG_PCI_PCIE
> +#define pciehp_available()	true
> +#else
> +#define pciehp_available()	false
> +#endif
> +

More succinctly,

#define pciehp_available() IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE)

(Or use that directly instead of defining an additional macro.)

Thanks,

Lukas
