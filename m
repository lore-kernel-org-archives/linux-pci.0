Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <81be86fdeb4b8cc496daf668833a3b5ee66428e9.camel@linux.intel.com>
Subject: Re: [PATCH v7 10/12] PCI: Document return value of
 pci_scan_bridge() and pci_scan_bridge_extend()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date: Thu, 17 May 2018 14:44:48 +0300
In-Reply-To: <20180517092903.43701-11-mika.westerberg@linux.intel.com>
References: <20180517092903.43701-1-mika.westerberg@linux.intel.com>
         <20180517092903.43701-11-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-05-17 at 12:29 +0300, Mika Westerberg wrote:
> It is not immediately clear what the two functions actually return so
> add kernel-doc comment explaining it a bit better.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/probe.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index cd28ab122748..a0c48aa1c42f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -999,6 +999,8 @@ static unsigned int
> pci_scan_child_bus_extend(struct pci_bus *bus,
>   * already configured by the BIOS and after we are done with all of
>   * them, we proceed to assigning numbers to the remaining buses in
>   * order to avoid overlaps between old and new bus numbers.
> + *
> + * Return: New subordinate number covering all buses behind this
> bridge.
>   */
>  static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev
> *dev,
>  				  int max, unsigned int
> available_buses,
> @@ -1231,6 +1233,8 @@ static int pci_scan_bridge_extend(struct pci_bus
> *bus, struct pci_dev *dev,
>   * already configured by the BIOS and after we are done with all of
>   * them, we proceed to assigning numbers to the remaining buses in
>   * order to avoid overlaps between old and new bus numbers.
> + *
> + * Return: New subordinate number covering all buses behind this
> bridge.
>   */
>  int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int
> max, int pass)
>  {

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
