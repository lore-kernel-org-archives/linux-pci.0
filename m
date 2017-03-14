Return-Path: <SRS0=zx5Q=2X=intel.com=adrian.hunter@kernel.org>
Return-Path: <SRS0=zx5Q=2X=intel.com=adrian.hunter@kernel.org>
Subject: Re: [PATCH] PCI: For d3_delay and d3cold_delay, zero means zero
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20170314130305.GH8232@bhelgaas-glaptop.roam.corp.google.com>
 <1489497718-4099-1-git-send-email-adrian.hunter@intel.com>
Cc: linux-pci <linux-pci@vger.kernel.org>, linux-pm
 <linux-pm@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukas Wunner <lukas@wunner.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <04a3c82b-7adb-adf4-52ed-3067413a2f4a@intel.com>
Date: Tue, 14 Mar 2017 15:23:50 +0200
MIME-Version: 1.0
In-Reply-To: <1489497718-4099-1-git-send-email-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Forgot to put this is V2, sorry.  It has changes to the commit message as
requested.

On 14/03/17 15:21, Adrian Hunter wrote:
> msleep() still sleeps 1 jiffy even when told to sleep for zero
> milliseconds. That can end up being 1-2 milliseconds or more. In the cases
> of d3_delay and d3cold_delay, that unnecessarily increases suspend and/or
> resume latencies.
> 
> So, do not sleep at all for the respective cases of d3_delay is zero or
> d3cold_delay is zero.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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
> 
