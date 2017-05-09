Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v1] ACPI: Switch to use generic UUID API
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
        intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-input@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20170504092151.88646-1-andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
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
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <59117C5F.1080007@linux.intel.com>
Date: Tue, 9 May 2017 11:22:55 +0300
MIME-Version: 1.0
In-Reply-To: <20170504092151.88646-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 7b86508ac8cf..93b4f0de9418 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -210,13 +210,12 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>   #ifdef CONFIG_ACPI
>   static void xhci_pme_acpi_rtd3_enable(struct pci_dev *dev)
>   {
> -	static const u8 intel_dsm_uuid[] = {
> -		0xb7, 0x0c, 0x34, 0xac,	0x01, 0xe9, 0xbf, 0x45,
> -		0xb7, 0xe6, 0x2b, 0x34, 0xec, 0x93, 0x1e, 0x23,
> -	};
> +	static const uuid_le intel_dsm_uuid =
> +		UUID_LE(0xac340cb7, 0xe901, 0x45bf,
> +			0xb7, 0xe6, 0x2b, 0x34, 0xec, 0x93, 0x1e, 0x23);
>   	union acpi_object *obj;
>
> -	obj = acpi_evaluate_dsm(ACPI_HANDLE(&dev->dev), intel_dsm_uuid, 3, 1,
> +	obj = acpi_evaluate_dsm(ACPI_HANDLE(&dev->dev), &intel_dsm_uuid, 3, 1,
>   				NULL);
>   	ACPI_FREE(obj);
>   }

For the xhci part above:

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>


