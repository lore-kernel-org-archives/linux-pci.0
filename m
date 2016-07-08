Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Fri, 8 Jul 2016 11:30:57 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Peter Wu <peter@lekensteyn.nl>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Dave Airlie <airlied@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/nouveau/acpi: fix lockup with PCIe runtime PM
Message-ID: <20160708083057.GZ23527@lahna.fi.intel.com>
References: <20160707233827.2100-1-peter@lekensteyn.nl>
 <20160707233827.2100-5-peter@lekensteyn.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160707233827.2100-5-peter@lekensteyn.nl>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 08, 2016 at 01:38:27AM +0200, Peter Wu wrote:
> Since "PCI: Add runtime PM support for PCIe ports", the parent PCIe port
> can be runtime-suspended which disables power resources via ACPI. This
> is incompatible with DSM, resulting in a GPU device which is still in D3
> and locks up the kernel on resume (on a Clevo P651RA, GTX965M).
> 
> Mirror the behavior of Windows 8 and newer[1] (as observed via an AMLi
> debugger trace) and stop using the DSM functions for D3cold when power
> resources are available on the parent PCIe port.
> 
> pci_d3cold_disable() is not used because on some machines, the old DSM
> method is broken. On a Lenovo T440p (GT 730M) memory and disk corruption
> would occur, but that is fixed with this patch[2].

Fair enough.

>  [1]: https://msdn.microsoft.com/windows/hardware/drivers/bringup/firmware-requirements-for-d3cold
>  [2]: https://github.com/Bumblebee-Project/bbswitch/issues/78#issuecomment-223549072
> 
>  v2: simply check directly for _PR3. Added affected machines.
> 
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>

One nitpick below but otherwise looks reasonable to me.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

BTW, thanks for doing this :)

> ---
>  drivers/gpu/drm/nouveau/nouveau_acpi.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> index ad273ad..38a6445 100644
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
> @@ -212,9 +213,26 @@ static const struct vga_switcheroo_handler nouveau_dsm_handler = {
>  	.get_client_id = nouveau_dsm_get_client_id,
>  };
>  
> +/* Firmware supporting Windows 8 or later do not use _DSM to put the device into
> + * D3cold, they instead rely on disabling power resources on the parent. */

You should follow standard block comment style here.

> +static bool nouveau_pr3_present(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
> +	struct acpi_device *parent_adev;
> +
> +	if (!parent_pdev)
> +		return false;
> +
> +	parent_adev = ACPI_COMPANION(&parent_pdev->dev);
> +	if (!parent_adev)
> +		return false;
> +
> +	return acpi_has_method(parent_adev->handle, "_PR3");
> +}
