Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170504092151.88646-1-andriy.shevchenko@linux.intel.com>
References: <20170504092151.88646-1-andriy.shevchenko@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 4 May 2017 23:20:08 -0700
Message-ID: <CAPcyv4jzD0MEBRNTwTokVzgdDWas682ArUjRAGT1hp=QRE8Pjg@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: Switch to use generic UUID API
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
        tpmdd-devel@lists.sourceforge.net, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-input@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>, linux-pci@vger.kernel.org,
        USB list <linux-usb@vger.kernel.org>,
        alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 4, 2017 at 2:21 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> acpi_evaluate_dsm() and friends take a pointer to a raw buffer of 16
> bytes. Instead we convert them to use uuid_le type. At the same time we
> convert current users.
>
> acpi_str_to_uuid() becomes useless after the conversion and it's safe to
> get rid of it.
>
> The conversion fixes a potential bug in int340x_thermal as well since
> we have to use memcmp() on binary data.
>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
[..]
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 0f7982a1caaf..bd3e45ede056 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -74,11 +74,11 @@ struct nfit_table_prev {
>         struct list_head flushes;
>  };
>
> -static u8 nfit_uuid[NFIT_UUID_MAX][16];
> +static uuid_le nfit_uuid[NFIT_UUID_MAX];
>
> -const u8 *to_nfit_uuid(enum nfit_uuids id)
> +const uuid_le *to_nfit_uuid(enum nfit_uuids id)
>  {
> -       return nfit_uuid[id];
> +       return &nfit_uuid[id];
>  }
>  EXPORT_SYMBOL(to_nfit_uuid);
>
> @@ -207,7 +207,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>         u32 offset, fw_status = 0;
>         acpi_handle handle;
>         unsigned int func;
> -       const u8 *uuid;
> +       const uuid_le *uuid;
>         int rc, i;
>
>         func = cmd;
> @@ -394,7 +394,7 @@ int nfit_spa_type(struct acpi_nfit_system_address *spa)
>         int i;
>
>         for (i = 0; i < NFIT_UUID_MAX; i++)
> -               if (memcmp(to_nfit_uuid(i), spa->range_guid, 16) == 0)
> +               if (!uuid_le_cmp_pp(to_nfit_uuid(i), (uuid_le *)spa->range_guid))

What is _cmp_pp? Why not _compare?

Other than that, looks ok to me.
