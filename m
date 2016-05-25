Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Wed, 25 May 2016 16:55:35 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Peter Wu <peter@lekensteyn.nl>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Dave Airlie <airlied@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/nouveau/acpi: fix lockup with PCIe runtime PM
Message-ID: <20160525135535.GN1789@lahna.fi.intel.com>
References: <1464130381-4797-1-git-send-email-peter@lekensteyn.nl>
 <1464130381-4797-5-git-send-email-peter@lekensteyn.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464130381-4797-5-git-send-email-peter@lekensteyn.nl>
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 25, 2016 at 12:53:01AM +0200, Peter Wu wrote:
> Since "PCI: Add runtime PM support for PCIe ports", the parent PCIe port
> can be runtime-suspended which disables power resources via ACPI. This
> is incompatible with DSM, resulting in a GPU device which is still in D3
> and locks up the kernel on resume.
> 
> Mirror the behavior of Windows 8 and newer[1] (as observed via an AMLi
> debugger trace) and stop using the DSM functions for D3cold when power
> resources are available on the parent PCIe port.
> 
>  [1]: https://msdn.microsoft.com/windows/hardware/drivers/bringup/firmware-requirements-for-d3cold
> 
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> ---
>  drivers/gpu/drm/nouveau/nouveau_acpi.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> index df9f73e..e469df7 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> @@ -46,6 +46,7 @@ static struct nouveau_dsm_priv {
>  	bool dsm_detected;
>  	bool optimus_detected;
>  	bool optimus_flags_detected;
> +	bool optimus_skip_dsm;
>  	acpi_handle dhandle;
>  	acpi_handle rom_handle;
>  } nouveau_dsm_priv;
> @@ -212,8 +213,26 @@ static const struct vga_switcheroo_handler nouveau_dsm_handler = {
>  	.get_client_id = nouveau_dsm_get_client_id,
>  };
>  
> +/* Firmware supporting Windows 8 or later do not use _DSM to put the device into
> + * D3cold, they instead rely on disabling power resources on the parent. */
> +static bool nouveau_pr3_present(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
> +	struct acpi_device *ad;

Nit: please call this adev instead of ad.

> +
> +	if (!parent_pdev)
> +		return false;
> +
> +	ad = ACPI_COMPANION(&parent_pdev->dev);
> +	if (!ad)
> +		return false;
> +
> +	return ad->power.flags.power_resources;

Is this sufficient to tell if the parent device has _PR3? I thought it
returns true if it has power resources in general, not necessarily _PR3.

Otherwise this looks okay to me.
