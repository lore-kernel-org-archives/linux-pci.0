Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
        intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-input@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] ACPI: Switch to use generic UUID API
In-Reply-To: <20170504092151.88646-1-andriy.shevchenko@linux.intel.com>
References: <20170504092151.88646-1-andriy.shevchenko@linux.intel.com>
Date: Thu, 04 May 2017 12:37:27 +0300
Message-ID: <87d1bpotd4.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 04 May 2017, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> diff --git a/drivers/gpu/drm/i915/intel_acpi.c b/drivers/gpu/drm/i915/intel_acpi.c
> index eb638a1e69d2..72bfe6ceadf8 100644
> --- a/drivers/gpu/drm/i915/intel_acpi.c
> +++ b/drivers/gpu/drm/i915/intel_acpi.c
> @@ -15,13 +15,9 @@ static struct intel_dsm_priv {
>  	acpi_handle dhandle;
>  } intel_dsm_priv;
>  
> -static const u8 intel_dsm_guid[] = {
> -	0xd3, 0x73, 0xd8, 0x7e,
> -	0xd0, 0xc2,
> -	0x4f, 0x4e,
> -	0xa8, 0x54,
> -	0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c
> -};
> +static const uuid_le intel_dsm_guid =
> +	UUID_LE(0x7ed873d3, 0xc2d0, 0x4e4f,
> +		0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
>  
>  static char *intel_dsm_port_name(u8 id)
>  {
> @@ -80,7 +76,7 @@ static void intel_dsm_platform_mux_info(void)
>  	int i;
>  	union acpi_object *pkg, *connector_count;
>  
> -	pkg = acpi_evaluate_dsm_typed(intel_dsm_priv.dhandle, intel_dsm_guid,
> +	pkg = acpi_evaluate_dsm_typed(intel_dsm_priv.dhandle, &intel_dsm_guid,
>  			INTEL_DSM_REVISION_ID, INTEL_DSM_FN_PLATFORM_MUX_INFO,
>  			NULL, ACPI_TYPE_PACKAGE);
>  	if (!pkg) {
> @@ -118,7 +114,7 @@ static bool intel_dsm_pci_probe(struct pci_dev *pdev)
>  	if (!dhandle)
>  		return false;
>  
> -	if (!acpi_check_dsm(dhandle, intel_dsm_guid, INTEL_DSM_REVISION_ID,
> +	if (!acpi_check_dsm(dhandle, &intel_dsm_guid, INTEL_DSM_REVISION_ID,
>  			    1 << INTEL_DSM_FN_PLATFORM_MUX_INFO)) {
>  		DRM_DEBUG_KMS("no _DSM method for intel device\n");
>  		return false;

The drm/i915 hunk above is

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

and acked for merging via whichever tree is suitable.


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Technology Center
