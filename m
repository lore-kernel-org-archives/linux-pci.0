Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6 03/12] PCI: Request control of native PCIe hotplug only if supported
Date: Tue, 15 May 2018 11:10:57 +0200
Message-ID: <2629152.NiZ8Vka3U6@aspire.rjw.lan>
In-Reply-To: <20180510194433.GA29276@wunner.de>
References: <20180510182844.77349-1-mika.westerberg@linux.intel.com> <20180510182844.77349-4-mika.westerberg@linux.intel.com> <20180510194433.GA29276@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, May 10, 2018 9:44:33 PM CEST Lukas Wunner wrote:
> On Thu, May 10, 2018 at 09:28:35PM +0300, Mika Westerberg wrote:
> > +
> > +#ifdef CONFIG_HOTPLUG_PCI_PCIE
> > +#define pciehp_available()	true
> > +#else
> > +#define pciehp_available()	false
> > +#endif
> > +
> 
> More succinctly,
> 
> #define pciehp_available() IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE)
> 
> (Or use that directly instead of defining an additional macro.)

Right and I would do the latter.

Thanks,
Rafael

