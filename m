Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:31337 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753988AbcJGVAM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 17:00:12 -0400
Message-ID: <1475873734.11323.324.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] x86/platform/intel-mid: Retrofit
 pci_platform_pm_ops ->get_power hook
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, x86@kernel.org
Date: Fri, 07 Oct 2016 23:55:34 +0300
In-Reply-To: <ecb5d8669fd795fc52845f6c901e5aa26c86c452.1475733022.git.lukas@wunner.de>
References: <cover.1475733022.git.lukas@wunner.de>
         <ecb5d8669fd795fc52845f6c901e5aa26c86c452.1475733022.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2016-10-06 at 08:24 +0200, Lukas Wunner wrote:
> Commit cc7cc02bada8 ("PCI: Query platform firmware for device power
> state") augmented struct pci_platform_pm_ops with a ->get_power hook
> and
> implemented it for acpi_pci_platform_pm, the only pci_platform_pm_ops
> existing till v4.7.
> 
> However v4.8 introduced another pci_platform_pm_ops for Intel Mobile
> Internet Devices with commit 5823d0893ec2 ("x86/platform/intel-mid:
> Add
> Power Management Unit driver").  It is missing the ->get_power hook,
> which is fatal since pci_set_platform_pm() enforces its presence.
> 
> Retrofit mid_pci_platform_pm with the missing callback to fix the
> breakage.

Check comments below.

> --- a/arch/x86/platform/intel-mid/pwr.c
> +++ b/arch/x86/platform/intel-mid/pwr.c
> @@ -260,6 +260,25 @@ int intel_mid_pci_set_power_state(struct pci_dev
> *pdev, pci_power_t state)
>  }
>  EXPORT_SYMBOL_GPL(intel_mid_pci_set_power_state);
>  
> +pci_power_t intel_mid_pci_get_power_state(struct pci_dev *pdev)
> +{
> +	struct mid_pwr *pwr = midpwr;
> +	int id, reg, bit;
> +	u32 power;
> +
> +	if (!pwr || !pwr->available)
> +		return PCI_UNKNOWN;

I'm not sure it's a right value. In arch/x86/pci/intel_mid_pci.c we
assign D3hot to PMCSR for all devices. I dunno how to proceed here,
though your case works for me.

> +
> +	id = intel_mid_pwr_get_lss_id(pdev);
> +	if (id < 0)
> +		return PCI_UNKNOWN;

Similar here, not all PCI devices are using PWRMU (or P-Unit, which
support is absent) and might be AON, or be controllable via PMCSR only.

> +
> +	reg = (id * LSS_PWS_BITS) / 32;
> +	bit = (id * LSS_PWS_BITS) % 32;
> +	power = mid_pwr_get_state(pwr, reg);
> +	return (power >> bit) & 3;

Don't add sparse warnings:

        return (__force pci_power_t)((power >> bit) & 3);

> +}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
