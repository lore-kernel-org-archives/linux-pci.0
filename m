Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170504092151.88646-1-andriy.shevchenko@linux.intel.com>
References: <20170504092151.88646-1-andriy.shevchenko@linux.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 4 May 2017 08:51:28 -0500
Message-ID: <CAErSpo7HEdb_vV8EC6pddA+VTDo-wTSEz+Z5XUpDkQmjwcihNw@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: Switch to use generic UUID API
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        tpmdd-devel@lists.sourceforge.net,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
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
        Zhang Rui <rui.zhang@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 4, 2017 at 4:21 AM, Andy Shevchenko
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

For the drivers/pci parts:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/acpi/acpi_extlog.c                         | 10 +++---
>  drivers/acpi/bus.c                                 | 29 ++--------------
>  drivers/acpi/nfit/core.c                           | 40 +++++++++++-----------
>  drivers/acpi/nfit/nfit.h                           |  3 +-
>  drivers/acpi/utils.c                               |  4 +--
>  drivers/char/tpm/tpm_crb.c                         |  9 +++--
>  drivers/char/tpm/tpm_ppi.c                         | 20 +++++------
>  drivers/gpu/drm/i915/intel_acpi.c                  | 14 +++-----
>  drivers/gpu/drm/nouveau/nouveau_acpi.c             | 20 +++++------
>  drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c     |  9 +++--
>  drivers/hid/i2c-hid/i2c-hid.c                      |  9 +++--
>  drivers/iommu/dmar.c                               | 11 +++---
>  drivers/mmc/host/sdhci-pci-core.c                  |  9 +++--
>  drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c | 15 ++++----
>  drivers/pci/pci-acpi.c                             | 11 +++---
>  drivers/pci/pci-label.c                            |  4 +--
>  drivers/thermal/int340x_thermal/int3400_thermal.c  |  8 ++---
>  drivers/usb/dwc3/dwc3-pci.c                        |  6 ++--
>  drivers/usb/host/xhci-pci.c                        |  9 +++--
>  drivers/usb/misc/ucsi.c                            |  2 +-
>  drivers/usb/typec/typec_wcove.c                    |  4 +--
>  include/acpi/acpi_bus.h                            |  9 ++---
>  include/linux/acpi.h                               |  4 +--
>  include/linux/pci-acpi.h                           |  2 +-
>  sound/soc/intel/skylake/skl-nhlt.c                 |  7 ++--
>  tools/testing/nvdimm/test/iomap.c                  |  2 +-
>  tools/testing/nvdimm/test/nfit.c                   |  2 +-
>  27 files changed, 116 insertions(+), 156 deletions(-)
>
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 502ea4dc2080..69d6140b6afa 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -182,17 +182,17 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>
>  static bool __init extlog_get_l1addr(void)
>  {
> -       u8 uuid[16];
> +       uuid_le uuid;
>         acpi_handle handle;
>         union acpi_object *obj;
>
> -       acpi_str_to_uuid(extlog_dsm_uuid, uuid);
> -
> +       if (uuid_le_to_bin(extlog_dsm_uuid, &uuid))
> +               return false;
>         if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
>                 return false;
> -       if (!acpi_check_dsm(handle, uuid, EXTLOG_DSM_REV, 1 << EXTLOG_FN_ADDR))
> +       if (!acpi_check_dsm(handle, &uuid, EXTLOG_DSM_REV, 1 << EXTLOG_FN_ADDR))
>                 return false;
> -       obj = acpi_evaluate_dsm_typed(handle, uuid, EXTLOG_DSM_REV,
> +       obj = acpi_evaluate_dsm_typed(handle, &uuid, EXTLOG_DSM_REV,
>                                       EXTLOG_FN_ADDR, NULL, ACPI_TYPE_INTEGER);
>         if (!obj) {
>                 return false;
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 784bda663d16..e8130a4873e9 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -196,42 +196,19 @@ static void acpi_print_osc_error(acpi_handle handle,
>         pr_debug("\n");
>  }
>
> -acpi_status acpi_str_to_uuid(char *str, u8 *uuid)
> -{
> -       int i;
> -       static int opc_map_to_uuid[16] = {6, 4, 2, 0, 11, 9, 16, 14, 19, 21,
> -               24, 26, 28, 30, 32, 34};
> -
> -       if (strlen(str) != 36)
> -               return AE_BAD_PARAMETER;
> -       for (i = 0; i < 36; i++) {
> -               if (i == 8 || i == 13 || i == 18 || i == 23) {
> -                       if (str[i] != '-')
> -                               return AE_BAD_PARAMETER;
> -               } else if (!isxdigit(str[i]))
> -                       return AE_BAD_PARAMETER;
> -       }
> -       for (i = 0; i < 16; i++) {
> -               uuid[i] = hex_to_bin(str[opc_map_to_uuid[i]]) << 4;
> -               uuid[i] |= hex_to_bin(str[opc_map_to_uuid[i] + 1]);
> -       }
> -       return AE_OK;
> -}
> -EXPORT_SYMBOL_GPL(acpi_str_to_uuid);
> -
>  acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
>  {
>         acpi_status status;
>         struct acpi_object_list input;
>         union acpi_object in_params[4];
>         union acpi_object *out_obj;
> -       u8 uuid[16];
> +       uuid_le uuid;
>         u32 errors;
>         struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
>
>         if (!context)
>                 return AE_ERROR;
> -       if (ACPI_FAILURE(acpi_str_to_uuid(context->uuid_str, uuid)))
> +       if (uuid_le_to_bin(context->uuid_str, &uuid))
>                 return AE_ERROR;
>         context->ret.length = ACPI_ALLOCATE_BUFFER;
>         context->ret.pointer = NULL;
> @@ -241,7 +218,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
>         input.pointer = in_params;
>         in_params[0].type               = ACPI_TYPE_BUFFER;
>         in_params[0].buffer.length      = 16;
> -       in_params[0].buffer.pointer     = uuid;
> +       in_params[0].buffer.pointer     = (u8 *)&uuid;
>         in_params[1].type               = ACPI_TYPE_INTEGER;
>         in_params[1].integer.value      = context->rev;
>         in_params[2].type               = ACPI_TYPE_INTEGER;
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
>                         return i;
>         return -1;
>  }
> @@ -1400,7 +1400,7 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
>         struct acpi_device *adev, *adev_dimm;
>         struct device *dev = acpi_desc->dev;
>         unsigned long dsm_mask;
> -       const u8 *uuid;
> +       const uuid_le *uuid = to_nfit_uuid(NFIT_DEV_DIMM);
>         int i;
>         int family = -1;
>
> @@ -1596,7 +1596,7 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
>  static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
>  {
>         struct nvdimm_bus_descriptor *nd_desc = &acpi_desc->nd_desc;
> -       const u8 *uuid = to_nfit_uuid(NFIT_DEV_BUS);
> +       const uuid_le *uuid = to_nfit_uuid(NFIT_DEV_BUS);
>         struct acpi_device *adev;
>         int i;
>
> @@ -3036,19 +3036,19 @@ static __init int nfit_init(void)
>         BUILD_BUG_ON(sizeof(struct acpi_nfit_control_region) != 80);
>         BUILD_BUG_ON(sizeof(struct acpi_nfit_data_region) != 40);
>
> -       acpi_str_to_uuid(UUID_VOLATILE_MEMORY, nfit_uuid[NFIT_SPA_VOLATILE]);
> -       acpi_str_to_uuid(UUID_PERSISTENT_MEMORY, nfit_uuid[NFIT_SPA_PM]);
> -       acpi_str_to_uuid(UUID_CONTROL_REGION, nfit_uuid[NFIT_SPA_DCR]);
> -       acpi_str_to_uuid(UUID_DATA_REGION, nfit_uuid[NFIT_SPA_BDW]);
> -       acpi_str_to_uuid(UUID_VOLATILE_VIRTUAL_DISK, nfit_uuid[NFIT_SPA_VDISK]);
> -       acpi_str_to_uuid(UUID_VOLATILE_VIRTUAL_CD, nfit_uuid[NFIT_SPA_VCD]);
> -       acpi_str_to_uuid(UUID_PERSISTENT_VIRTUAL_DISK, nfit_uuid[NFIT_SPA_PDISK]);
> -       acpi_str_to_uuid(UUID_PERSISTENT_VIRTUAL_CD, nfit_uuid[NFIT_SPA_PCD]);
> -       acpi_str_to_uuid(UUID_NFIT_BUS, nfit_uuid[NFIT_DEV_BUS]);
> -       acpi_str_to_uuid(UUID_NFIT_DIMM, nfit_uuid[NFIT_DEV_DIMM]);
> -       acpi_str_to_uuid(UUID_NFIT_DIMM_N_HPE1, nfit_uuid[NFIT_DEV_DIMM_N_HPE1]);
> -       acpi_str_to_uuid(UUID_NFIT_DIMM_N_HPE2, nfit_uuid[NFIT_DEV_DIMM_N_HPE2]);
> -       acpi_str_to_uuid(UUID_NFIT_DIMM_N_MSFT, nfit_uuid[NFIT_DEV_DIMM_N_MSFT]);
> +       uuid_le_to_bin(UUID_VOLATILE_MEMORY, &nfit_uuid[NFIT_SPA_VOLATILE]);
> +       uuid_le_to_bin(UUID_PERSISTENT_MEMORY, &nfit_uuid[NFIT_SPA_PM]);
> +       uuid_le_to_bin(UUID_CONTROL_REGION, &nfit_uuid[NFIT_SPA_DCR]);
> +       uuid_le_to_bin(UUID_DATA_REGION, &nfit_uuid[NFIT_SPA_BDW]);
> +       uuid_le_to_bin(UUID_VOLATILE_VIRTUAL_DISK, &nfit_uuid[NFIT_SPA_VDISK]);
> +       uuid_le_to_bin(UUID_VOLATILE_VIRTUAL_CD, &nfit_uuid[NFIT_SPA_VCD]);
> +       uuid_le_to_bin(UUID_PERSISTENT_VIRTUAL_DISK, &nfit_uuid[NFIT_SPA_PDISK]);
> +       uuid_le_to_bin(UUID_PERSISTENT_VIRTUAL_CD, &nfit_uuid[NFIT_SPA_PCD]);
> +       uuid_le_to_bin(UUID_NFIT_BUS, &nfit_uuid[NFIT_DEV_BUS]);
> +       uuid_le_to_bin(UUID_NFIT_DIMM, &nfit_uuid[NFIT_DEV_DIMM]);
> +       uuid_le_to_bin(UUID_NFIT_DIMM_N_HPE1, &nfit_uuid[NFIT_DEV_DIMM_N_HPE1]);
> +       uuid_le_to_bin(UUID_NFIT_DIMM_N_HPE2, &nfit_uuid[NFIT_DEV_DIMM_N_HPE2]);
> +       uuid_le_to_bin(UUID_NFIT_DIMM_N_MSFT, &nfit_uuid[NFIT_DEV_DIMM_N_MSFT]);
>
>         nfit_wq = create_singlethread_workqueue("nfit");
>         if (!nfit_wq)
> diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
> index 58fb7d68e04a..2f233b28709f 100644
> --- a/drivers/acpi/nfit/nfit.h
> +++ b/drivers/acpi/nfit/nfit.h
> @@ -18,7 +18,6 @@
>  #include <linux/libnvdimm.h>
>  #include <linux/ndctl.h>
>  #include <linux/types.h>
> -#include <linux/uuid.h>
>  #include <linux/acpi.h>
>  #include <acpi/acuuid.h>
>
> @@ -237,7 +236,7 @@ static inline struct acpi_nfit_desc *to_acpi_desc(
>         return container_of(nd_desc, struct acpi_nfit_desc, nd_desc);
>  }
>
> -const u8 *to_nfit_uuid(enum nfit_uuids id);
> +const uuid_le *to_nfit_uuid(enum nfit_uuids id);
>  int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, void *nfit, acpi_size sz);
>  void acpi_nfit_shutdown(void *data);
>  void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event);
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 27d0dcfcf47d..bbe8a950e508 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -625,7 +625,7 @@ acpi_status acpi_evaluate_lck(acpi_handle handle, int lock)
>   * some old BIOSes do expect a buffer or an integer etc.
>   */
>  union acpi_object *
> -acpi_evaluate_dsm(acpi_handle handle, const u8 *uuid, u64 rev, u64 func,
> +acpi_evaluate_dsm(acpi_handle handle, const uuid_le *uuid, u64 rev, u64 func,
>                   union acpi_object *argv4)
>  {
>         acpi_status ret;
> @@ -674,7 +674,7 @@ EXPORT_SYMBOL(acpi_evaluate_dsm);
>   * functions. Currently only support 64 functions at maximum, should be
>   * enough for now.
>   */
> -bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, u64 rev, u64 funcs)
> +bool acpi_check_dsm(acpi_handle handle, const uuid_le *uuid, u64 rev, u64 funcs)
>  {
>         int i;
>         u64 mask = 0;
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index b917b9d5f710..f789f7e5a17d 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -27,10 +27,9 @@
>
>  #define ACPI_SIG_TPM2 "TPM2"
>
> -static const u8 CRB_ACPI_START_UUID[] = {
> -       /* 0000 */ 0xAB, 0x6C, 0xBF, 0x6B, 0x63, 0x54, 0x14, 0x47,
> -       /* 0008 */ 0xB7, 0xCD, 0xF0, 0x20, 0x3C, 0x03, 0x68, 0xD4
> -};
> +static const uuid_le crb_acpi_start_uuid =
> +       UUID_LE(0x6BBF6CAB, 0x5463, 0x4714,
> +               0xB7, 0xCD, 0xF0, 0x20, 0x3C, 0x03, 0x68, 0xD4);
>
>  enum crb_defaults {
>         CRB_ACPI_START_REVISION_ID = 1,
> @@ -266,7 +265,7 @@ static int crb_do_acpi_start(struct tpm_chip *chip)
>         int rc;
>
>         obj = acpi_evaluate_dsm(chip->acpi_dev_handle,
> -                               CRB_ACPI_START_UUID,
> +                               &crb_acpi_start_uuid,
>                                 CRB_ACPI_START_REVISION_ID,
>                                 CRB_ACPI_START_INDEX,
>                                 NULL);
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index 692a2c6ae036..7cf682426361 100644
> --- a/drivers/char/tpm/tpm_ppi.c
> +++ b/drivers/char/tpm/tpm_ppi.c
> @@ -32,20 +32,16 @@
>  #define PPI_VS_REQ_START       128
>  #define PPI_VS_REQ_END         255
>
> -static const u8 tpm_ppi_uuid[] = {
> -       0xA6, 0xFA, 0xDD, 0x3D,
> -       0x1B, 0x36,
> -       0xB4, 0x4E,
> -       0xA4, 0x24,
> -       0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53
> -};
> +static const uuid_le tpm_ppi_uuid =
> +       UUID_LE(0x3DDDFAA6, 0x361B, 0x4EB4,
> +               0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53);
>
>  static inline union acpi_object *
>  tpm_eval_dsm(acpi_handle ppi_handle, int func, acpi_object_type type,
>              union acpi_object *argv4)
>  {
>         BUG_ON(!ppi_handle);
> -       return acpi_evaluate_dsm_typed(ppi_handle, tpm_ppi_uuid,
> +       return acpi_evaluate_dsm_typed(ppi_handle, &tpm_ppi_uuid,
>                                        TPM_PPI_REVISION_ID,
>                                        func, argv4, type);
>  }
> @@ -107,7 +103,7 @@ static ssize_t tpm_store_ppi_request(struct device *dev,
>          * is updated with function index from SUBREQ to SUBREQ2 since PPI
>          * version 1.1
>          */
> -       if (acpi_check_dsm(chip->acpi_dev_handle, tpm_ppi_uuid,
> +       if (acpi_check_dsm(chip->acpi_dev_handle, &tpm_ppi_uuid,
>                            TPM_PPI_REVISION_ID, 1 << TPM_PPI_FN_SUBREQ2))
>                 func = TPM_PPI_FN_SUBREQ2;
>
> @@ -268,7 +264,7 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
>                 "User not required",
>         };
>
> -       if (!acpi_check_dsm(dev_handle, tpm_ppi_uuid, TPM_PPI_REVISION_ID,
> +       if (!acpi_check_dsm(dev_handle, &tpm_ppi_uuid, TPM_PPI_REVISION_ID,
>                             1 << TPM_PPI_FN_GETOPR))
>                 return -EPERM;
>
> @@ -341,12 +337,12 @@ void tpm_add_ppi(struct tpm_chip *chip)
>         if (!chip->acpi_dev_handle)
>                 return;
>
> -       if (!acpi_check_dsm(chip->acpi_dev_handle, tpm_ppi_uuid,
> +       if (!acpi_check_dsm(chip->acpi_dev_handle, &tpm_ppi_uuid,
>                             TPM_PPI_REVISION_ID, 1 << TPM_PPI_FN_VERSION))
>                 return;
>
>         /* Cache PPI version string. */
> -       obj = acpi_evaluate_dsm_typed(chip->acpi_dev_handle, tpm_ppi_uuid,
> +       obj = acpi_evaluate_dsm_typed(chip->acpi_dev_handle, &tpm_ppi_uuid,
>                                       TPM_PPI_REVISION_ID, TPM_PPI_FN_VERSION,
>                                       NULL, ACPI_TYPE_STRING);
>         if (obj) {
> diff --git a/drivers/gpu/drm/i915/intel_acpi.c b/drivers/gpu/drm/i915/intel_acpi.c
> index eb638a1e69d2..72bfe6ceadf8 100644
> --- a/drivers/gpu/drm/i915/intel_acpi.c
> +++ b/drivers/gpu/drm/i915/intel_acpi.c
> @@ -15,13 +15,9 @@ static struct intel_dsm_priv {
>         acpi_handle dhandle;
>  } intel_dsm_priv;
>
> -static const u8 intel_dsm_guid[] = {
> -       0xd3, 0x73, 0xd8, 0x7e,
> -       0xd0, 0xc2,
> -       0x4f, 0x4e,
> -       0xa8, 0x54,
> -       0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c
> -};
> +static const uuid_le intel_dsm_guid =
> +       UUID_LE(0x7ed873d3, 0xc2d0, 0x4e4f,
> +               0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
>
>  static char *intel_dsm_port_name(u8 id)
>  {
> @@ -80,7 +76,7 @@ static void intel_dsm_platform_mux_info(void)
>         int i;
>         union acpi_object *pkg, *connector_count;
>
> -       pkg = acpi_evaluate_dsm_typed(intel_dsm_priv.dhandle, intel_dsm_guid,
> +       pkg = acpi_evaluate_dsm_typed(intel_dsm_priv.dhandle, &intel_dsm_guid,
>                         INTEL_DSM_REVISION_ID, INTEL_DSM_FN_PLATFORM_MUX_INFO,
>                         NULL, ACPI_TYPE_PACKAGE);
>         if (!pkg) {
> @@ -118,7 +114,7 @@ static bool intel_dsm_pci_probe(struct pci_dev *pdev)
>         if (!dhandle)
>                 return false;
>
> -       if (!acpi_check_dsm(dhandle, intel_dsm_guid, INTEL_DSM_REVISION_ID,
> +       if (!acpi_check_dsm(dhandle, &intel_dsm_guid, INTEL_DSM_REVISION_ID,
>                             1 << INTEL_DSM_FN_PLATFORM_MUX_INFO)) {
>                 DRM_DEBUG_KMS("no _DSM method for intel device\n");
>                 return false;
> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> index 39468c218027..faea23276d4a 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> @@ -60,15 +60,13 @@ bool nouveau_is_v1_dsm(void) {
>  }
>
>  #ifdef CONFIG_VGA_SWITCHEROO
> -static const char nouveau_dsm_muid[] = {
> -       0xA0, 0xA0, 0x95, 0x9D, 0x60, 0x00, 0x48, 0x4D,
> -       0xB3, 0x4D, 0x7E, 0x5F, 0xEA, 0x12, 0x9F, 0xD4,
> -};
> +static const uuid_le nouveau_dsm_muid =
> +       UUID_LE(0x9D95A0A0, 0x0060, 0x4D48,
> +               0xB3, 0x4D, 0x7E, 0x5F, 0xEA, 0x12, 0x9F, 0xD4);
>
> -static const char nouveau_op_dsm_muid[] = {
> -       0xF8, 0xD8, 0x86, 0xA4, 0xDA, 0x0B, 0x1B, 0x47,
> -       0xA7, 0x2B, 0x60, 0x42, 0xA6, 0xB5, 0xBE, 0xE0,
> -};
> +static const uuid_le nouveau_op_dsm_muid =
> +       UUID_LE(0xA486D8F8, 0x0BDA, 0x471B,
> +               0xA7, 0x2B, 0x60, 0x42, 0xA6, 0xB5, 0xBE, 0xE0);
>
>  static int nouveau_optimus_dsm(acpi_handle handle, int func, int arg, uint32_t *result)
>  {
> @@ -86,7 +84,7 @@ static int nouveau_optimus_dsm(acpi_handle handle, int func, int arg, uint32_t *
>                 args_buff[i] = (arg >> i * 8) & 0xFF;
>
>         *result = 0;
> -       obj = acpi_evaluate_dsm_typed(handle, nouveau_op_dsm_muid, 0x00000100,
> +       obj = acpi_evaluate_dsm_typed(handle, &nouveau_op_dsm_muid, 0x00000100,
>                                       func, &argv4, ACPI_TYPE_BUFFER);
>         if (!obj) {
>                 acpi_handle_info(handle, "failed to evaluate _DSM\n");
> @@ -138,7 +136,7 @@ static int nouveau_dsm(acpi_handle handle, int func, int arg)
>                 .integer.value = arg,
>         };
>
> -       obj = acpi_evaluate_dsm_typed(handle, nouveau_dsm_muid, 0x00000102,
> +       obj = acpi_evaluate_dsm_typed(handle, &nouveau_dsm_muid, 0x00000102,
>                                       func, &argv4, ACPI_TYPE_INTEGER);
>         if (!obj) {
>                 acpi_handle_info(handle, "failed to evaluate _DSM\n");
> @@ -259,7 +257,7 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out
>         if (!acpi_has_method(dhandle, "_DSM"))
>                 return;
>
> -       supports_mux = acpi_check_dsm(dhandle, nouveau_dsm_muid, 0x00000102,
> +       supports_mux = acpi_check_dsm(dhandle, &nouveau_dsm_muid, 0x00000102,
>                                       1 << NOUVEAU_DSM_POWER);
>         optimus_funcs = nouveau_dsm_get_optimus_functions(dhandle);
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c
> index e3e2f5e83815..cc95b8150a86 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c
> @@ -81,10 +81,9 @@ mxm_shadow_dsm(struct nvkm_mxm *mxm, u8 version)
>  {
>         struct nvkm_subdev *subdev = &mxm->subdev;
>         struct nvkm_device *device = subdev->device;
> -       static char muid[] = {
> -               0x00, 0xA4, 0x04, 0x40, 0x7D, 0x91, 0xF2, 0x4C,
> -               0xB8, 0x9C, 0x79, 0xB6, 0x2F, 0xD5, 0x56, 0x65
> -       };
> +       static uuid_le muid =
> +               UUID_LE(0x4004A400, 0x917D, 0x4CF2,
> +                       0xB8, 0x9C, 0x79, 0xB6, 0x2F, 0xD5, 0x56, 0x65);
>         u32 mxms_args[] = { 0x00000000 };
>         union acpi_object argv4 = {
>                 .buffer.type = ACPI_TYPE_BUFFER,
> @@ -105,7 +104,7 @@ mxm_shadow_dsm(struct nvkm_mxm *mxm, u8 version)
>          * unless you pass in exactly the version it supports..
>          */
>         rev = (version & 0xf0) << 4 | (version & 0x0f);
> -       obj = acpi_evaluate_dsm(handle, muid, rev, 0x00000010, &argv4);
> +       obj = acpi_evaluate_dsm(handle, &muid, rev, 0x00000010, &argv4);
>         if (!obj) {
>                 nvkm_debug(subdev, "DSM MXMS failed\n");
>                 return false;
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 8daa8ce64ebb..f83bd717cdd5 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -872,10 +872,9 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
>  static int i2c_hid_acpi_pdata(struct i2c_client *client,
>                 struct i2c_hid_platform_data *pdata)
>  {
> -       static u8 i2c_hid_guid[] = {
> -               0xF7, 0xF6, 0xDF, 0x3C, 0x67, 0x42, 0x55, 0x45,
> -               0xAD, 0x05, 0xB3, 0x0A, 0x3D, 0x89, 0x38, 0xDE,
> -       };
> +       static uuid_le i2c_hid_guid =
> +               UUID_LE(0x3CDFF6F7, 0x4267, 0x4555,
> +                       0xAD, 0x05, 0xB3, 0x0A, 0x3D, 0x89, 0x38, 0xDE);
>         union acpi_object *obj;
>         struct acpi_device *adev;
>         acpi_handle handle;
> @@ -884,7 +883,7 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
>         if (!handle || acpi_bus_get_device(handle, &adev))
>                 return -ENODEV;
>
> -       obj = acpi_evaluate_dsm_typed(handle, i2c_hid_guid, 1, 1, NULL,
> +       obj = acpi_evaluate_dsm_typed(handle, &i2c_hid_guid, 1, 1, NULL,
>                                       ACPI_TYPE_INTEGER);
>         if (!obj) {
>                 dev_err(&client->dev, "device _DSM execution failed\n");
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index cbf7763d8091..420d51b286ad 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1808,10 +1808,9 @@ IOMMU_INIT_POST(detect_intel_iommu);
>   * for Directed-IO Architecture Specifiction, Rev 2.2, Section 8.8
>   * "Remapping Hardware Unit Hot Plug".
>   */
> -static u8 dmar_hp_uuid[] = {
> -       /* 0000 */    0xA6, 0xA3, 0xC1, 0xD8, 0x9B, 0xBE, 0x9B, 0x4C,
> -       /* 0008 */    0x91, 0xBF, 0xC3, 0xCB, 0x81, 0xFC, 0x5D, 0xAF
> -};
> +static uuid_le dmar_hp_uuid =
> +       UUID_LE(0xD8C1A3A6, 0xBE9B, 0x4C9B,
> +               0x91, 0xBF, 0xC3, 0xCB, 0x81, 0xFC, 0x5D, 0xAF);
>
>  /*
>   * Currently there's only one revision and BIOS will not check the revision id,
> @@ -1824,7 +1823,7 @@ static u8 dmar_hp_uuid[] = {
>
>  static inline bool dmar_detect_dsm(acpi_handle handle, int func)
>  {
> -       return acpi_check_dsm(handle, dmar_hp_uuid, DMAR_DSM_REV_ID, 1 << func);
> +       return acpi_check_dsm(handle, &dmar_hp_uuid, DMAR_DSM_REV_ID, 1 << func);
>  }
>
>  static int dmar_walk_dsm_resource(acpi_handle handle, int func,
> @@ -1843,7 +1842,7 @@ static int dmar_walk_dsm_resource(acpi_handle handle, int func,
>         if (!dmar_detect_dsm(handle, func))
>                 return 0;
>
> -       obj = acpi_evaluate_dsm_typed(handle, dmar_hp_uuid, DMAR_DSM_REV_ID,
> +       obj = acpi_evaluate_dsm_typed(handle, &dmar_hp_uuid, DMAR_DSM_REV_ID,
>                                       func, NULL, ACPI_TYPE_BUFFER);
>         if (!obj)
>                 return -ENODEV;
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 92fc3f7c538d..262b8c320d7c 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -404,10 +404,9 @@ struct intel_host {
>         bool    d3_retune;
>  };
>
> -const u8 intel_dsm_uuid[] = {
> -       0xA5, 0x3E, 0xC1, 0xF6, 0xCD, 0x65, 0x1F, 0x46,
> -       0xAB, 0x7A, 0x29, 0xF7, 0xE8, 0xD5, 0xBD, 0x61,
> -};
> +const uuid_le intel_dsm_uuid =
> +       UUID_LE(0xF6C13EA5, 0x65CD, 0x461F,
> +               0xAB, 0x7A, 0x29, 0xF7, 0xE8, 0xD5, 0xBD, 0x61);
>
>  static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
>                        unsigned int fn, u32 *result)
> @@ -416,7 +415,7 @@ static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
>         int err = 0;
>         size_t len;
>
> -       obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), intel_dsm_uuid, 0, fn, NULL);
> +       obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &intel_dsm_uuid, 0, fn, NULL);
>         if (!obj)
>                 return -EOPNOTSUPP;
>
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
> index e13aa064a8e9..02842fe7f1d0 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
> @@ -29,10 +29,9 @@ enum _dsm_rst_type {
>         HNS_ROCE_RESET_FUNC     = 0x7,
>  };
>
> -const u8 hns_dsaf_acpi_dsm_uuid[] = {
> -       0x1A, 0xAA, 0x85, 0x1A, 0x93, 0xE2, 0x5E, 0x41,
> -       0x8E, 0x28, 0x8D, 0x69, 0x0A, 0x0F, 0x82, 0x0A
> -};
> +const uuid_le hns_dsaf_acpi_dsm_uuid =
> +       UUID_LE(0x1A85AA1A, 0xE293, 0x415E,
> +               0x8E, 0x28, 0x8D, 0x69, 0x0A, 0x0F, 0x82, 0x0A);
>
>  static void dsaf_write_sub(struct dsaf_device *dsaf_dev, u32 reg, u32 val)
>  {
> @@ -151,7 +150,7 @@ static void hns_dsaf_acpi_srst_by_port(struct dsaf_device *dsaf_dev, u8 op_type,
>         argv4.package.elements = obj_args;
>
>         obj = acpi_evaluate_dsm(ACPI_HANDLE(dsaf_dev->dev),
> -                               hns_dsaf_acpi_dsm_uuid, 0, op_type, &argv4);
> +                               &hns_dsaf_acpi_dsm_uuid, 0, op_type, &argv4);
>         if (!obj) {
>                 dev_warn(dsaf_dev->dev, "reset port_type%d port%d fail!",
>                          port_type, port);
> @@ -434,7 +433,7 @@ static phy_interface_t hns_mac_get_phy_if_acpi(struct hns_mac_cb *mac_cb)
>         argv4.package.elements = &obj_args,
>
>         obj = acpi_evaluate_dsm(ACPI_HANDLE(mac_cb->dev),
> -                               hns_dsaf_acpi_dsm_uuid, 0,
> +                               &hns_dsaf_acpi_dsm_uuid, 0,
>                                 HNS_OP_GET_PORT_TYPE_FUNC, &argv4);
>
>         if (!obj || obj->type != ACPI_TYPE_INTEGER)
> @@ -474,7 +473,7 @@ int hns_mac_get_sfp_prsnt_acpi(struct hns_mac_cb *mac_cb, int *sfp_prsnt)
>         argv4.package.elements = &obj_args,
>
>         obj = acpi_evaluate_dsm(ACPI_HANDLE(mac_cb->dev),
> -                               hns_dsaf_acpi_dsm_uuid, 0,
> +                               &hns_dsaf_acpi_dsm_uuid, 0,
>                                 HNS_OP_GET_SFP_STAT_FUNC, &argv4);
>
>         if (!obj || obj->type != ACPI_TYPE_INTEGER)
> @@ -565,7 +564,7 @@ hns_mac_config_sds_loopback_acpi(struct hns_mac_cb *mac_cb, bool en)
>         argv4.package.elements = obj_args;
>
>         obj = acpi_evaluate_dsm(ACPI_HANDLE(mac_cb->dsaf_dev->dev),
> -                               hns_dsaf_acpi_dsm_uuid, 0,
> +                               &hns_dsaf_acpi_dsm_uuid, 0,
>                                 HNS_OP_SERDES_LP_FUNC, &argv4);
>         if (!obj) {
>                 dev_warn(mac_cb->dsaf_dev->dev, "set port%d serdes lp fail!",
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 001860361434..eb612123e0dd 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -24,10 +24,9 @@
>   * The UUID is defined in the PCI Firmware Specification available here:
>   * https://www.pcisig.com/members/downloads/pcifw_r3_1_13Dec10.pdf
>   */
> -const u8 pci_acpi_dsm_uuid[] = {
> -       0xd0, 0x37, 0xc9, 0xe5, 0x53, 0x35, 0x7a, 0x4d,
> -       0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d
> -};
> +const uuid_le pci_acpi_dsm_uuid =
> +       UUID_LE(0xe5c937d0, 0x3553, 0x4d7a,
> +               0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d);
>
>  #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
>  static int acpi_get_rc_addr(struct acpi_device *adev, struct resource *res)
> @@ -680,7 +679,7 @@ void acpi_pci_add_bus(struct pci_bus *bus)
>         if (!pci_is_root_bus(bus))
>                 return;
>
> -       obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), pci_acpi_dsm_uuid, 3,
> +       obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_uuid, 3,
>                                 RESET_DELAY_DSM, NULL);
>         if (!obj)
>                 return;
> @@ -745,7 +744,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>         if (bridge->ignore_reset_delay)
>                 pdev->d3cold_delay = 0;
>
> -       obj = acpi_evaluate_dsm(handle, pci_acpi_dsm_uuid, 3,
> +       obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_uuid, 3,
>                                 FUNCTION_DELAY_DSM, NULL);
>         if (!obj)
>                 return;
> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
> index 51357377efbc..a2c04229f1dc 100644
> --- a/drivers/pci/pci-label.c
> +++ b/drivers/pci/pci-label.c
> @@ -172,7 +172,7 @@ static int dsm_get_label(struct device *dev, char *buf,
>         if (!handle)
>                 return -1;
>
> -       obj = acpi_evaluate_dsm(handle, pci_acpi_dsm_uuid, 0x2,
> +       obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_uuid, 0x2,
>                                 DEVICE_LABEL_DSM, NULL);
>         if (!obj)
>                 return -1;
> @@ -212,7 +212,7 @@ static bool device_has_dsm(struct device *dev)
>         if (!handle)
>                 return false;
>
> -       return !!acpi_check_dsm(handle, pci_acpi_dsm_uuid, 0x2,
> +       return !!acpi_check_dsm(handle, &pci_acpi_dsm_uuid, 0x2,
>                                 1 << DEVICE_LABEL_DSM);
>  }
>
> diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
> index 9413c4abf0b9..c0eb3bb19b23 100644
> --- a/drivers/thermal/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
> @@ -23,7 +23,7 @@ enum int3400_thermal_uuid {
>         INT3400_THERMAL_MAXIMUM_UUID,
>  };
>
> -static u8 *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] = {
> +static const char *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] = {
>         "42A441D6-AE6A-462b-A84B-4A8CE79027D3",
>         "3A95C389-E4B8-4629-A526-C52C88626BAE",
>         "97C68AE7-15FA-499c-B8C9-5DA81D606E0A",
> @@ -141,10 +141,10 @@ static int int3400_thermal_get_uuids(struct int3400_thermal_priv *priv)
>                 }
>
>                 for (j = 0; j < INT3400_THERMAL_MAXIMUM_UUID; j++) {
> -                       u8 uuid[16];
> +                       uuid_le u;
>
> -                       acpi_str_to_uuid(int3400_thermal_uuids[j], uuid);
> -                       if (!strncmp(uuid, objb->buffer.pointer, 16)) {
> +                       uuid_le_to_bin(int3400_thermal_uuids[j], &u);
> +                       if (!uuid_le_cmp(*(uuid_le *)objb->buffer.pointer), u) {
>                                 priv->uuid_bitmap |= (1 << j);
>                                 break;
>                         }
> diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
> index a15ec71d0423..6b5284ec76df 100644
> --- a/drivers/usb/dwc3/dwc3-pci.c
> +++ b/drivers/usb/dwc3/dwc3-pci.c
> @@ -56,7 +56,7 @@ struct dwc3_pci {
>         struct platform_device *dwc3;
>         struct pci_dev *pci;
>
> -       u8 uuid[16];
> +       uuid_le uuid;
>
>         unsigned int has_dsm_for_pm:1;
>  };
> @@ -118,7 +118,7 @@ static int dwc3_pci_quirks(struct dwc3_pci *dwc)
>
>                 if (pdev->device == PCI_DEVICE_ID_INTEL_BXT ||
>                                 pdev->device == PCI_DEVICE_ID_INTEL_BXT_M) {
> -                       acpi_str_to_uuid(PCI_INTEL_BXT_DSM_UUID, dwc->uuid);
> +                       uuid_le_to_bin(PCI_INTEL_BXT_DSM_UUID, &dwc->uuid);
>                         dwc->has_dsm_for_pm = true;
>                 }
>
> @@ -288,7 +288,7 @@ static int dwc3_pci_dsm(struct dwc3_pci *dwc, int param)
>         tmp.type = ACPI_TYPE_INTEGER;
>         tmp.integer.value = param;
>
> -       obj = acpi_evaluate_dsm(ACPI_HANDLE(&dwc->pci->dev), dwc->uuid,
> +       obj = acpi_evaluate_dsm(ACPI_HANDLE(&dwc->pci->dev), &dwc->uuid,
>                         1, PCI_INTEL_BXT_FUNC_PMU_PWR, &argv4);
>         if (!obj) {
>                 dev_err(&dwc->pci->dev, "failed to evaluate _DSM\n");
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 7b86508ac8cf..93b4f0de9418 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -210,13 +210,12 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  #ifdef CONFIG_ACPI
>  static void xhci_pme_acpi_rtd3_enable(struct pci_dev *dev)
>  {
> -       static const u8 intel_dsm_uuid[] = {
> -               0xb7, 0x0c, 0x34, 0xac, 0x01, 0xe9, 0xbf, 0x45,
> -               0xb7, 0xe6, 0x2b, 0x34, 0xec, 0x93, 0x1e, 0x23,
> -       };
> +       static const uuid_le intel_dsm_uuid =
> +               UUID_LE(0xac340cb7, 0xe901, 0x45bf,
> +                       0xb7, 0xe6, 0x2b, 0x34, 0xec, 0x93, 0x1e, 0x23);
>         union acpi_object *obj;
>
> -       obj = acpi_evaluate_dsm(ACPI_HANDLE(&dev->dev), intel_dsm_uuid, 3, 1,
> +       obj = acpi_evaluate_dsm(ACPI_HANDLE(&dev->dev), &intel_dsm_uuid, 3, 1,
>                                 NULL);
>         ACPI_FREE(obj);
>  }
> diff --git a/drivers/usb/misc/ucsi.c b/drivers/usb/misc/ucsi.c
> index 07397bddefa3..49e32ffbe59f 100644
> --- a/drivers/usb/misc/ucsi.c
> +++ b/drivers/usb/misc/ucsi.c
> @@ -61,7 +61,7 @@ static int ucsi_acpi_cmd(struct ucsi *ucsi, struct ucsi_control *ctrl)
>
>         ucsi->data->ctrl.raw_cmd = ctrl->raw_cmd;
>
> -       obj = acpi_evaluate_dsm(ACPI_HANDLE(ucsi->dev), uuid.b, 1, 1, NULL);
> +       obj = acpi_evaluate_dsm(ACPI_HANDLE(ucsi->dev), &uuid, 1, 1, NULL);
>         if (!obj) {
>                 dev_err(ucsi->dev, "%s: failed to evaluate _DSM\n", __func__);
>                 return -EIO;
> diff --git a/drivers/usb/typec/typec_wcove.c b/drivers/usb/typec/typec_wcove.c
> index d5a7b21fa3f1..5ce93e0a15ca 100644
> --- a/drivers/usb/typec/typec_wcove.c
> +++ b/drivers/usb/typec/typec_wcove.c
> @@ -118,7 +118,7 @@ static int wcove_typec_func(struct wcove_typec *wcove,
>         tmp.type = ACPI_TYPE_INTEGER;
>         tmp.integer.value = param;
>
> -       obj = acpi_evaluate_dsm(ACPI_HANDLE(wcove->dev), uuid.b, 1, func,
> +       obj = acpi_evaluate_dsm(ACPI_HANDLE(wcove->dev), &uuid, 1, func,
>                                 &argv4);
>         if (!obj) {
>                 dev_err(wcove->dev, "%s: failed to evaluate _DSM\n", __func__);
> @@ -314,7 +314,7 @@ static int wcove_typec_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> -       if (!acpi_check_dsm(ACPI_HANDLE(&pdev->dev), uuid.b, 0, 0x1f)) {
> +       if (!acpi_check_dsm(ACPI_HANDLE(&pdev->dev), &uuid, 0, 0x1f)) {
>                 dev_err(&pdev->dev, "Missing _DSM functions\n");
>                 return -ENODEV;
>         }
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 197f3fffc9a7..0682942d6a76 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -61,13 +61,14 @@ bool acpi_ata_match(acpi_handle handle);
>  bool acpi_bay_match(acpi_handle handle);
>  bool acpi_dock_match(acpi_handle handle);
>
> -bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, u64 rev, u64 funcs);
> -union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const u8 *uuid,
> +bool acpi_check_dsm(acpi_handle handle, const uuid_le *uuid, u64 rev, u64 funcs);
> +union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const uuid_le *uuid,
>                         u64 rev, u64 func, union acpi_object *argv4);
>
>  static inline union acpi_object *
> -acpi_evaluate_dsm_typed(acpi_handle handle, const u8 *uuid, u64 rev, u64 func,
> -                       union acpi_object *argv4, acpi_object_type type)
> +acpi_evaluate_dsm_typed(acpi_handle handle, const uuid_le *uuid, u64 rev,
> +                       u64 func, union acpi_object *argv4,
> +                       acpi_object_type type)
>  {
>         union acpi_object *obj;
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 137e4a3d89c5..66d135003780 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -39,6 +39,7 @@
>  #include <linux/dynamic_debug.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/uuid.h>
>
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
> @@ -457,7 +458,6 @@ struct acpi_osc_context {
>         struct acpi_buffer ret;         /* free by caller if success */
>  };
>
> -acpi_status acpi_str_to_uuid(char *str, u8 *uuid);
>  acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
>
>  /* Indexes into _OSC Capabilities Buffer (DWORDs 2 & 3 are device-specific) */
> @@ -741,7 +741,7 @@ static inline bool acpi_driver_match_device(struct device *dev,
>  }
>
>  static inline union acpi_object *acpi_evaluate_dsm(acpi_handle handle,
> -                                                  const u8 *uuid,
> +                                                  const uuid_le *uuid,
>                                                    int rev, int func,
>                                                    union acpi_object *argv4)
>  {
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 7a4e83a8c89c..917a6ad0f24d 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -105,7 +105,7 @@ static inline void acpiphp_remove_slots(struct pci_bus *bus) { }
>  static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
>  #endif
>
> -extern const u8 pci_acpi_dsm_uuid[];
> +extern const uuid_le pci_acpi_dsm_uuid;
>  #define DEVICE_LABEL_DSM       0x07
>  #define RESET_DELAY_DSM                0x08
>  #define FUNCTION_DELAY_DSM     0x09
> diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
> index e3f06672fd6d..b95f659dced5 100644
> --- a/sound/soc/intel/skylake/skl-nhlt.c
> +++ b/sound/soc/intel/skylake/skl-nhlt.c
> @@ -21,8 +21,9 @@
>  #include "skl.h"
>
>  /* Unique identification for getting NHLT blobs */
> -static u8 OSC_UUID[16] = {0x6E, 0x88, 0x9F, 0xA6, 0xEB, 0x6C, 0x94, 0x45,
> -                               0xA4, 0x1F, 0x7B, 0x5D, 0xCE, 0x24, 0xC5, 0x53};
> +static uuid_le osc_uuid =
> +       UUID_LE(0xA69F886E, 0x6CEB, 0x4594,
> +               0xA4, 0x1F, 0x7B, 0x5D, 0xCE, 0x24, 0xC5, 0x53);
>
>  struct nhlt_acpi_table *skl_nhlt_init(struct device *dev)
>  {
> @@ -37,7 +38,7 @@ struct nhlt_acpi_table *skl_nhlt_init(struct device *dev)
>                 return NULL;
>         }
>
> -       obj = acpi_evaluate_dsm(handle, OSC_UUID, 1, 1, NULL);
> +       obj = acpi_evaluate_dsm(handle, &osc_uuid, 1, 1, NULL);
>         if (obj && obj->type == ACPI_TYPE_BUFFER) {
>                 nhlt_ptr = (struct nhlt_resource_desc  *)obj->buffer.pointer;
>                 nhlt_table = (struct nhlt_acpi_table *)
> diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
> index 64cae1a5deff..f190f22c53dd 100644
> --- a/tools/testing/nvdimm/test/iomap.c
> +++ b/tools/testing/nvdimm/test/iomap.c
> @@ -370,7 +370,7 @@ acpi_status __wrap_acpi_evaluate_object(acpi_handle handle, acpi_string path,
>  }
>  EXPORT_SYMBOL(__wrap_acpi_evaluate_object);
>
> -union acpi_object * __wrap_acpi_evaluate_dsm(acpi_handle handle, const u8 *uuid,
> +union acpi_object * __wrap_acpi_evaluate_dsm(acpi_handle handle, const uuid_le *uuid,
>                 u64 rev, u64 func, union acpi_object *argv4)
>  {
>         union acpi_object *obj = ERR_PTR(-ENXIO);
> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index c2187178fb13..145f6ee0234f 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -1559,7 +1559,7 @@ static unsigned long nfit_ctl_handle;
>  union acpi_object *result;
>
>  static union acpi_object *nfit_test_evaluate_dsm(acpi_handle handle,
> -               const u8 *uuid, u64 rev, u64 func, union acpi_object *argv4)
> +               const uuid_le *uuid, u64 rev, u64 func, union acpi_object *argv4)
>  {
>         if (handle != &nfit_ctl_handle)
>                 return ERR_PTR(-ENXIO);
> --
> 2.11.0
>
