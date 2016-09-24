Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v2 2/5] PCI: Query platform firmware for device power state
Date: Sat, 24 Sep 2016 02:46:23 +0200
Message-ID: <2060566.Y1NLRuZWTn@vostro.rjw.lan>
In-Reply-To: <492d4d62ae1b3a95570babe9608d8ea971b62585.1474130360.git.lukas@wunner.de>
References: <cover.1474130360.git.lukas@wunner.de> <492d4d62ae1b3a95570babe9608d8ea971b62585.1474130360.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday, September 18, 2016 05:39:20 AM Lukas Wunner wrote:
> Usually the most accurate way to determine a PCI device's power state is
> to read its PM Control & Status Register.  There are two cases however
> when this is not an option:  If the device doesn't have the PM
> capability at all, or if it is in D3cold (in which case its config space
> is inaccessible).
> 
> In both cases, we can alternatively query the platform firmware for its
> opinion on the device's power state.  To facilitate this, augment struct
> pci_platform_pm_ops with a ->get_power callback and implement it for
> acpi_pci_platform_pm (the only pci_platform_pm_ops existing so far).
> 
> It is used by a forthcoming commit to let pci_update_current_state()
> recognize D3cold.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> 
> Changes since v1:
> * In acpi_pci_get_power_state(), only check for ACPI_STATE_UNKNOWN
>   instead of ACPI_STATE_D0 and ACPI_STATE_D3_COLD.
> * Move the change to pci_update_current_state() to new patch [3/5].
> 
>  drivers/pci/pci-acpi.c | 22 ++++++++++++++++++++++
>  drivers/pci/pci.c      | 10 ++++++++--
>  drivers/pci/pci.h      |  3 +++
>  3 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 9a033e8..d966d47 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -452,6 +452,27 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  	return error;
>  }
>  
> +static pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> +	static const pci_power_t state_conv[] = {
> +		[ACPI_STATE_D0]      = PCI_D0,
> +		[ACPI_STATE_D1]      = PCI_D1,
> +		[ACPI_STATE_D2]      = PCI_D2,
> +		[ACPI_STATE_D3_HOT]  = PCI_D3hot,
> +		[ACPI_STATE_D3_COLD] = PCI_D3cold,
> +	};
> +	int state;
> +
> +	if (!adev || !acpi_device_power_manageable(adev))
> +		return PCI_UNKNOWN;
> +
> +	if (acpi_device_get_power(adev, &state) || state == ACPI_STATE_UNKNOWN)
> +		return PCI_UNKNOWN;
> +
> +	return state_conv[state];
> +}
> +
>  static bool acpi_pci_can_wakeup(struct pci_dev *dev)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> @@ -534,6 +555,7 @@ static bool acpi_pci_need_resume(struct pci_dev *dev)
>  static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
>  	.is_manageable = acpi_pci_power_manageable,
>  	.set_state = acpi_pci_set_power_state,
> +	.get_state = acpi_pci_get_power_state,
>  	.choose_state = acpi_pci_choose_state,
>  	.sleep_wake = acpi_pci_sleep_wake,
>  	.run_wake = acpi_pci_run_wake,
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 72a9d3a..6ea0d2d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -552,8 +552,9 @@ static const struct pci_platform_pm_ops *pci_platform_pm;
>  
>  int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
>  {
> -	if (!ops->is_manageable || !ops->set_state || !ops->choose_state ||
> -	    !ops->sleep_wake || !ops->run_wake || !ops->need_resume)
> +	if (!ops->is_manageable || !ops->set_state  || !ops->get_state ||
> +	    !ops->choose_state  || !ops->sleep_wake || !ops->run_wake  ||
> +	    !ops->need_resume)
>  		return -EINVAL;
>  	pci_platform_pm = ops;
>  	return 0;
> @@ -570,6 +571,11 @@ static inline int platform_pci_set_power_state(struct pci_dev *dev,
>  	return pci_platform_pm ? pci_platform_pm->set_state(dev, t) : -ENOSYS;
>  }
>  
> +static inline pci_power_t platform_pci_get_power_state(struct pci_dev *dev)
> +{
> +	return pci_platform_pm ? pci_platform_pm->get_state(dev) : PCI_UNKNOWN;
> +}
> +
>  static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
>  {
>  	return pci_platform_pm ?
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 194521b..4518562 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -42,6 +42,8 @@ int pci_probe_reset_function(struct pci_dev *dev);
>   *
>   * @set_state: invokes the platform firmware to set the device's power state
>   *
> + * @get_state: queries the platform firmware for a device's current power state
> + *
>   * @choose_state: returns PCI power state of given device preferred by the
>   *                platform; to be used during system-wide transitions from a
>   *                sleeping state to the working state and vice versa
> @@ -62,6 +64,7 @@ int pci_probe_reset_function(struct pci_dev *dev);
>  struct pci_platform_pm_ops {
>  	bool (*is_manageable)(struct pci_dev *dev);
>  	int (*set_state)(struct pci_dev *dev, pci_power_t state);
> +	pci_power_t (*get_state)(struct pci_dev *dev);
>  	pci_power_t (*choose_state)(struct pci_dev *dev);
>  	int (*sleep_wake)(struct pci_dev *dev, bool enable);
>  	int (*run_wake)(struct pci_dev *dev, bool enable);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
