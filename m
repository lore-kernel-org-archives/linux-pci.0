Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 18 Nov 2015 12:40:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Josef Bacik <jbacik@fb.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, bhelgaas@google.com, shli@fb.com,
	kernel-team@fb.com, Matthew Garrett <mjg59@coreos.com>
Subject: Re: [PATCH] pci: completely disable aspm if it's unsupported
Message-ID: <20151118184038.GA4462@localhost>
References: <1447856703-2566-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447856703-2566-1-git-send-email-jbacik@fb.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Matthew]

Hi Josef,

On Wed, Nov 18, 2015 at 09:25:03AM -0500, Josef Bacik wrote:
> We have some hardware that takes about 30 seconds to setup common clocks for
> ASPM, but our bios'es don't actually allow ASPM.  It seems we had this thing in
> place where we would disable ASPM after the pci bus probe so that we would make
> sure that pre pcie 1.1 devices would be properly skipped during initialization.
> This is because the mechanism to disable ASPM doesn't actually disable the
> setting up of the link state stuff, it just keeps us from changing the link
> state after the fact.  So instead make it so that when we call pcie_no_aspm()
> that we disable ASPM completley, that is we skip setting up the link state and
> everything.  This way we avoid the costly setup for a feature we cannot support
> in the first place and we also make sure we are safe from future tampering with
> the ASPM link state.  Thanks,

Can you clarify what your BIOS does?  I assume it's an x86 ACPI BIOS.
Does it enable ASPM before handing off to the OS?  Does it set the
ACPI_FADT_NO_ASPM bit? (ACPI spec 5.0, sec 5.2.9.3)

You're changing the _OSC failure path.  Why does _OSC fail?  I know
there is some sort of unresolved problem there
(https://bugzilla.kernel.org/show_bug.cgi?id=94661); maybe you're
tripping over that?

It seems like you're proposing to reverse what Matthew just did with
387d37577fdd ("PCI: Don't clear ASPM bits when the FADT declares it's
unsupported").

Bjorn

> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
>  drivers/acpi/pci_root.c | 22 +++++-----------------
>  drivers/pci/pcie/aspm.c |  1 +
>  2 files changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 393706a..00e164a 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -419,7 +419,7 @@ out:
>  }
>  EXPORT_SYMBOL(acpi_pci_osc_control_set);
>  
> -static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
> +static void negotiate_os_control(struct acpi_pci_root *root)
>  {
>  	u32 support, control, requested;
>  	acpi_status status;
> @@ -456,7 +456,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>  	if (ACPI_FAILURE(status)) {
>  		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
>  			 acpi_format_exception(status));
> -		*no_aspm = 1;
> +		pcie_no_aspm();
>  		return;
>  	}
>  
> @@ -495,22 +495,14 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>  			 * intact and prevent the OS from touching it.
>  			 */
>  			dev_info(&device->dev, "FADT indicates ASPM is unsupported, using BIOS configuration\n");
> -			*no_aspm = 1;
> +			pcie_no_aspm();
>  		}
>  	} else {
>  		decode_osc_control(root, "OS requested", requested);
>  		decode_osc_control(root, "platform willing to grant", control);
>  		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
>  			acpi_format_exception(status));
> -
> -		/*
> -		 * We want to disable ASPM here, but aspm_disabled
> -		 * needs to remain in its state from boot so that we
> -		 * properly handle PCIe 1.1 devices.  So we set this
> -		 * flag here, to defer the action until after the ACPI
> -		 * root scan.
> -		 */
> -		*no_aspm = 1;
> +		pcie_no_aspm();
>  	}
>  }
>  
> @@ -522,7 +514,6 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  	int result;
>  	struct acpi_pci_root *root;
>  	acpi_handle handle = device->handle;
> -	int no_aspm = 0;
>  	bool hotadd = system_state != SYSTEM_BOOTING;
>  
>  	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
> @@ -581,7 +572,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  
>  	root->mcfg_addr = acpi_pci_root_get_mcfg_addr(handle);
>  
> -	negotiate_os_control(root, &no_aspm);
> +	negotiate_os_control(root);
>  
>  	/*
>  	 * TBD: Need PCI interface for enumeration/configuration of roots.
> @@ -604,9 +595,6 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  		goto remove_dmar;
>  	}
>  
> -	if (no_aspm)
> -		pcie_no_aspm();
> -
>  	pci_acpi_add_bus_pm_notifier(device);
>  	if (device->wakeup.flags.run_wake)
>  		device_set_run_wake(root->bus->bridge, true);
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 317e355..5f84af2 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -954,6 +954,7 @@ void pcie_no_aspm(void)
>  	if (!aspm_force) {
>  		aspm_policy = POLICY_DEFAULT;
>  		aspm_disabled = 1;
> +		aspm_support_enabled = false;
>  	}
>  }
>  
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
