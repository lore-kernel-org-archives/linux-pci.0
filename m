Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:40772 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbcJIPBX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 9 Oct 2016 11:01:23 -0400
Message-ID: <1476025280.11323.355.camel@linux.intel.com>
Subject: Re: [PATCH v2] x86/platform/intel-mid: Retrofit pci_platform_pm_ops
 ->get_state hook
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>
Date: Sun, 09 Oct 2016 18:01:20 +0300
In-Reply-To: <63b7393731a5708dbbf107055e3fd9801c3c00b3.1476007467.git.lukas@wunner.de>
References: <63b7393731a5708dbbf107055e3fd9801c3c00b3.1476007467.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2016-10-09 at 14:46 +0200, Lukas Wunner wrote:
> Commit cc7cc02bada8 ("PCI: Query platform firmware for device power
> state") augmented struct pci_platform_pm_ops with a ->get_state hook
> and
> implemented it for acpi_pci_platform_pm, the only pci_platform_pm_ops
> existing till v4.7.
> 
> However v4.8 introduced another pci_platform_pm_ops for Intel Mobile
> Internet Devices with commit 5823d0893ec2 ("x86/platform/intel-mid:
> Add
> Power Management Unit driver").  It is missing the ->get_state hook,
> which is fatal since pci_set_platform_pm() enforces its presence.
> 
> Retrofit mid_pci_platform_pm with the missing callback to fix the
> breakage.
> 

+Ingo.

I guess it should go via tip/x86/urgent tree.


> Cc: x86@kernel.org
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Acked-and-tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.co
> m>
> ---
> Changes v1 -> v2:
> - Cast return value of intel_mid_pci_get_power_state() to
>   (__force pci_power_t) to avoid "sparse -D__CHECK_ENDIAN__" warning.
> 
>  arch/x86/include/asm/intel-mid.h  |  1 +
>  arch/x86/platform/intel-mid/pwr.c | 19 +++++++++++++++++++
>  drivers/pci/pci-mid.c             |  6 ++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/arch/x86/include/asm/intel-mid.h
> b/arch/x86/include/asm/intel-mid.h
> index 9d6b097..4511c10 100644
> --- a/arch/x86/include/asm/intel-mid.h
> +++ b/arch/x86/include/asm/intel-mid.h
> @@ -17,6 +17,7 @@
>  
>  extern int intel_mid_pci_init(void);
>  extern int intel_mid_pci_set_power_state(struct pci_dev *pdev,
> pci_power_t state);
> +extern pci_power_t intel_mid_pci_get_power_state(struct pci_dev
> *pdev);
>  
>  #define INTEL_MID_PWR_LSS_OFFSET	4
>  #define INTEL_MID_PWR_LSS_TYPE		(1 << 7)
> diff --git a/arch/x86/platform/intel-mid/pwr.c
> b/arch/x86/platform/intel-mid/pwr.c
> index c901a34..cae8d9b 100644
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
> +
> +	id = intel_mid_pwr_get_lss_id(pdev);
> +	if (id < 0)
> +		return PCI_UNKNOWN;
> +
> +	reg = (id * LSS_PWS_BITS) / 32;
> +	bit = (id * LSS_PWS_BITS) % 32;
> +	power = mid_pwr_get_state(pwr, reg);
> +	return (__force pci_power_t)((power >> bit) & 3);
> +}
> +
>  int intel_mid_pwr_get_lss_id(struct pci_dev *pdev)
>  {
>  	int vndr;
> diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
> index c878aa7..a8b52dc 100644
> --- a/drivers/pci/pci-mid.c
> +++ b/drivers/pci/pci-mid.c
> @@ -29,6 +29,11 @@ static int mid_pci_set_power_state(struct pci_dev
> *pdev, pci_power_t state)
>  	return intel_mid_pci_set_power_state(pdev, state);
>  }
>  
> +static pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
> +{
> +	return intel_mid_pci_get_power_state(pdev);
> +}
> +
>  static pci_power_t mid_pci_choose_state(struct pci_dev *pdev)
>  {
>  	return PCI_D3hot;
> @@ -52,6 +57,7 @@ static bool mid_pci_need_resume(struct pci_dev *dev)
>  static struct pci_platform_pm_ops mid_pci_platform_pm = {
>  	.is_manageable	= mid_pci_power_manageable,
>  	.set_state	= mid_pci_set_power_state,
> +	.get_state	= mid_pci_get_power_state,
>  	.choose_state	= mid_pci_choose_state,
>  	.sleep_wake	= mid_pci_sleep_wake,
>  	.run_wake	= mid_pci_run_wake,

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
