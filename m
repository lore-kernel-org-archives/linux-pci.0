Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 14 Mar 2017 15:04:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: For d3_delay and d3cold_delay, zero means zero
Message-ID: <20170314200411.GE26264@bhelgaas-glaptop.roam.corp.google.com>
References: <20170314130305.GH8232@bhelgaas-glaptop.roam.corp.google.com>
 <1489497718-4099-1-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489497718-4099-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 14, 2017 at 03:21:58PM +0200, Adrian Hunter wrote:
> msleep() still sleeps 1 jiffy even when told to sleep for zero
> milliseconds. That can end up being 1-2 milliseconds or more. In the cases
> of d3_delay and d3cold_delay, that unnecessarily increases suspend and/or
> resume latencies.
> 
> So, do not sleep at all for the respective cases of d3_delay is zero or
> d3cold_delay is zero.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Applied with Rafael's ack to pci/pm for v4.12, thanks!

> ---
>  drivers/pci/pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7904d02ffdb9..9779483f81fd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -66,7 +66,8 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
>  	if (delay < pci_pm_d3_delay)
>  		delay = pci_pm_d3_delay;
>  
> -	msleep(delay);
> +	if (delay)
> +		msleep(delay);
>  }
>  
>  #ifdef CONFIG_PCI_DOMAINS
> @@ -827,7 +828,8 @@ static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
>  		 * because have already delayed for the bridge.
>  		 */
>  		if (dev->runtime_d3cold) {
> -			msleep(dev->d3cold_delay);
> +			if (dev->d3cold_delay)
> +				msleep(dev->d3cold_delay);
>  			/*
>  			 * When powering on a bridge from D3cold, the
>  			 * whole hierarchy may be powered on into
> -- 
> 1.9.1
> 
