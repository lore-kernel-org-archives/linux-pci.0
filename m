Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        "D . J . Bernstein" <djb@cr.yp.to>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 01/10] PCI: Do not skip power managed bridges in pci_enable_wake()
Date: Tue, 11 Sep 2018 10:47:55 +0200
Message-ID: <6060673.ioIVnQPhoN@aspire.rjw.lan>
In-Reply-To: <20180906155020.51700-2-mika.westerberg@linux.intel.com>
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com> <20180906155020.51700-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, September 6, 2018 5:50:11 PM CEST Mika Westerberg wrote:
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
>  drivers/pci/pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 29ff9619b5fa..074f3f0253f9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2134,9 +2134,11 @@ static int __pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable
>  
>  	/*
>  	 * Bridges can only signal wakeup on behalf of subordinate devices,
> -	 * but that is set up elsewhere, so skip them.
> +	 * but that is set up elsewhere, so skip them. With the exception
> +	 * of bridges that we power manage. These can signal wake for
> +	 * example on a hotplug event.
>  	 */

I would change the comment even more, to something like:

"Bridges that are not power-manageable directly only signal wakeup on behalf
of subordinate devices which is set up elsewhere, so skip them.  However,
bridges that are power-manageable may signal wakeup for themselves (for example,
on a hotplug event) and they need to be covered here."

> -	if (pci_has_subordinate(dev))
> +	if (!pci_power_manageable(dev))
>  		return 0;
>  
>  	/* Don't do the same thing twice in a row for one device. */
> 
