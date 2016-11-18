Return-Path: <rjwysocki@gmail.com>
Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1479460951-49281-2-git-send-email-liudongdong3@huawei.com>
References: <1479460951-49281-1-git-send-email-liudongdong3@huawei.com> <1479460951-49281-2-git-send-email-liudongdong3@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 Nov 2016 23:00:00 +0100
Message-ID: <CAJZ5v0gMg6=ueeZz-PcNvuUW5ht=r8vn-gEru-2Cbx7HDCf+jA@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] PCI/ACPI: Provide acpi_get_rc_resources() for
 ARM64 platform
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>, wangzhou1@hisilicon.com,
	Pratyush Anand Thakur <pratyush.anand@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jon Masters <jcm@redhat.com>,
	gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
	Hanjun Guo <hanjun.guo@linaro.org>, linuxarm@huawei.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 18, 2016 at 10:22 AM, Dongdong Liu <liudongdong3@huawei.com> wrote:
> The acpi_get_rc_resources() is used to get the RC register address that can
> not be described in MCFG. It takes the _HID&segment to look for and outputs
> the RC address resource. Use PNP0C02 devices to describe such RC address
> resource. Use _UID to match segment to tell which root bus the PNP0C02
> resource belong to.
>
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/pci/pci-acpi.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h      |  4 +++
>  2 files changed, 75 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index d966d47..3557e3a 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -29,6 +29,77 @@
>         0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d
>  };
>
> +#ifdef CONFIG_ARM64
> +static int acpi_get_rc_addr(struct acpi_device *adev, struct resource *res)

Why can't it return a resource pointer?

> +{
> +       struct resource_entry *entry;
> +       struct list_head list;
> +       unsigned long flags;
> +       int ret;
> +
> +       INIT_LIST_HEAD(&list);
> +       flags = IORESOURCE_MEM;
> +       ret = acpi_dev_get_resources(adev, &list,
> +                                    acpi_dev_filter_resource_type_cb,
> +                                    (void *) flags);
> +       if (ret < 0) {
> +               dev_err(&adev->dev,

The dev_err() log level is quite excessive here IMO.  Why is the
message useful to users at all?  IOW, what is the user supposed to do
if this message is present in the log?

> +                       "failed to parse _CRS method, error code %d\n", ret);
> +               return ret;
> +       } else if (ret == 0) {
> +               dev_err(&adev->dev,
> +                       "no IO and memory resources present in _CRS\n");

Same here.

> +               return -EINVAL;
> +       }
> +
> +       entry = list_first_entry(&list, struct resource_entry, node);
> +       *res = *entry->res;
> +       acpi_dev_free_resource_list(&list);
> +       return 0;
> +}
> +
> +static acpi_status acpi_match_rc(acpi_handle handle, u32 lvl, void *context,
> +                                void **retval)
> +{
> +       u16 *segment = context;
> +       unsigned long long uid;
> +       acpi_status status;
> +
> +       status = acpi_evaluate_integer(handle, "_UID", NULL, &uid);
> +       if (ACPI_FAILURE(status) || uid != *segment)
> +               return AE_CTRL_DEPTH;
> +
> +       *(acpi_handle *)retval = handle;
> +       return AE_CTRL_TERMINATE;
> +}
> +

Please add a kerneldoc comment describing acpi_get_rc_resources().

> +int acpi_get_rc_resources(const char *hid, u16 segment, struct resource *res)
> +{
> +       struct acpi_device *adev;
> +       acpi_status status;
> +       acpi_handle handle;
> +       int ret;
> +
> +       status = acpi_get_devices(hid, acpi_match_rc, &segment, &handle);
> +       if (ACPI_FAILURE(status)) {
> +               pr_err("Can't find _HID %s device", hid);

Same here.

> +               return -ENODEV;
> +       }
> +
> +       ret = acpi_bus_get_device(handle, &adev);
> +       if (ret)
> +               return ret;
> +
> +       ret = acpi_get_rc_addr(adev, res);
> +       if (ret) {
> +               dev_err(&adev->dev, "can't get RC resource");

Same here.

> +               return ret;
> +       }
> +
> +       return 0;
> +}

It looks like this function could return the resource pointer just
fine.  What's the problem with that?

> +#endif
> +
>  phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
>  {
>         acpi_status status = AE_NOT_EXIST;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4518562..17ffa38 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -356,4 +356,8 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
>  }
>  #endif
>
> +#ifdef CONFIG_ARM64
> +int acpi_get_rc_resources(const char *hid, u16 segment, struct resource *res);
> +#endif

Doesn't that depend on ACPI too?

> +
>  #endif /* DRIVERS_PCI_H */
> --

Thanks,
Rafael
