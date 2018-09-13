Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 01/10] PCI: Do not skip power managed bridges in pci_enable_wake()
Date: Thu, 13 Sep 2018 16:33:39 +0200
Message-ID: <153688100.j3IOAyprJL@aspire.rjw.lan>
In-Reply-To: <20180913143322.77953-2-mika.westerberg@linux.intel.com>
References: <20180913143322.77953-1-mika.westerberg@linux.intel.com> <20180913143322.77953-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, September 13, 2018 4:33:13 PM CEST Mika Westerberg wrote:
> Commit baecc470d5fd ("PCI / PM: Skip bridges in pci_enable_wake()")
> changed pci_enable_wake() so that all bridges are skipped when wakeup is
> enabled (or disabled) with the reasoning that bridges can only signal
> wakeup on behalf of their subordinate devices.
> 
> However, there are bridges that can signal wakeup itself. For example
> PCIe downstream and root ports supporting hotplug may signal wakeup upon
> hotplug event.
> 
> For this reason change pci_enable_wake() so that it skips all bridges
> except those that we power manage (->bridge_d3 is set). Those are the
> ones that can go into low power states and may need to signal wakeup.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pci.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 29ff9619b5fa..1af6f1887986 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2133,10 +2133,13 @@ static int __pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable
>  	int ret = 0;
>  
>  	/*
> -	 * Bridges can only signal wakeup on behalf of subordinate devices,
> -	 * but that is set up elsewhere, so skip them.
> +	 * Bridges that are not power-manageable directly only signal
> +	 * wakeup on behalf of subordinate devices which is set up
> +	 * elsewhere, so skip them. However, bridges that are
> +	 * power-manageable may signal wakeup for themselves (for example,
> +	 * on a hotplug event) and they need to be covered here.
>  	 */
> -	if (pci_has_subordinate(dev))
> +	if (!pci_power_manageable(dev))
>  		return 0;
>  
>  	/* Don't do the same thing twice in a row for one device. */
> 

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
