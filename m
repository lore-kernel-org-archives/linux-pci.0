Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1492408237-16598-1-git-send-email-vee.khee.wong@ni.com>
References: <1492408237-16598-1-git-send-email-vee.khee.wong@ni.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 17 Apr 2017 10:41:42 -0500
Message-ID: <CAErSpo5R+Fy+be06tg0sQtvaR=6QzqJn5k1M=NE=tPgDzNnUAA@mail.gmail.com>
Subject: Re: [PATCH] pci-sysfs: Make PCI bridge attribute visible in sysfs
To: Wong Vee Khee <vee.khee.wong@ni.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Rajat Jain <rajatja@google.com>, shhuiw@foxmail.com,
        hui.chun.ong@ni.com, jonathan.yong@intel.com,
        Ram.Amrani@cavium.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 17, 2017 at 12:50 AM, Wong Vee Khee <vee.khee.wong@ni.com> wrote:
> From: vwong <vee.khee.wong@ni.com>
>
> Export the PCIe link attributes of PCI bridges to sysfs.

This needs justification for *why* we should export these via sysfs.

Some of these things, e.g., secondary/subordinate bus numbers, are
already visible to non-privileged users via "lspci -v".

> Signed-off-by: Wong Vee Khee <vee.khee.wong@ni.com>
> Signed-off-by: Hui Chun Ong <hui.chun.ong@ni.com>
> ---
>  drivers/pci/pci-sysfs.c       | 197 +++++++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/pci_regs.h |   4 +
>  2 files changed, 197 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 25d010d..a218c43 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -154,6 +154,127 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(resource);
>
> +static ssize_t max_link_speed_show(struct device *dev,
> +                                  struct device_attribute *attr, char *buf)
> +{
> +       struct pci_dev *pci_dev = to_pci_dev(dev);
> +       u32 linkcap;
> +       int err;
> +       const char *speed;
> +
> +       err = pcie_capability_read_dword(pci_dev, PCI_EXP_LNKCAP, &linkcap);
> +
> +       if (!err && linkcap) {

  if (err)
    return -EINVAL;

I don't think there's a reason to test "linkcap" here.  Per spec, zero
is not a valid value of LNKCAP, so if we got a zero, I think showing
"Unknown speed" would be fine.

> +               switch (linkcap & PCI_EXP_LNKCAP_MLS) {
> +               case PCI_EXP_LNKCAP_MLS_8_0GB:
> +                       speed = "8 GT/s";
> +                       break;
> +               case PCI_EXP_LNKCAP_MLS_5_0GB:
> +                       speed = "5 GT/s";
> +                       break;
> +               case PCI_EXP_LNKCAP_MLS_2_5GB:
> +                       speed = "2.5 GT/s";
> +                       break;
> +               default:
> +                       speed = "Unknown speed";
> +               }
> +
> +               return sprintf(buf, "%s\n", speed);
> +       }
> +
> +       return -EINVAL;
> +}
> +static DEVICE_ATTR_RO(max_link_speed);
> +
> +static ssize_t max_link_width_show(struct device *dev,
> +                                  struct device_attribute *attr, char *buf)
> +{
> +       struct pci_dev *pci_dev = to_pci_dev(dev);
> +       u32 linkcap;
> +       int err;
> +
> +       err = pcie_capability_read_dword(pci_dev, PCI_EXP_LNKCAP, &linkcap);
> +
> +       return err ? -EINVAL : sprintf(
> +               buf, "%u\n", (linkcap & PCI_EXP_LNKCAP_MLW) >> 4);

  if (err)
    return -EINVAL;

  return sprintf(...);

> +}
> +static DEVICE_ATTR_RO(max_link_width);
> +
> +static ssize_t current_link_speed_show(struct device *dev,
> +                                      struct device_attribute *attr, char *buf)
> +{
> +       struct pci_dev *pci_dev = to_pci_dev(dev);
> +       u16 linkstat;
> +       int err;
> +       const char *speed;
> +
> +       err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
> +
> +       if (!err && linkstat) {

See max_link_speed above.

> +               switch (linkstat & PCI_EXP_LNKSTA_CLS) {
> +               case PCI_EXP_LNKSTA_CLS_8_0GB:
> +                       speed = "8 GT/s";
> +                       break;
> +               case PCI_EXP_LNKSTA_CLS_5_0GB:
> +                       speed = "5 GT/s";
> +                       break;
> +               case PCI_EXP_LNKSTA_CLS_2_5GB:
> +                       speed = "2.5 GT/s";
> +                       break;
> +               default:
> +                       speed = "Unknown speed";
> +               }
> +
> +               return sprintf(buf, "%s\n", speed);
> +       }
> +
> +       return -EINVAL;
> +}
> +static DEVICE_ATTR_RO(current_link_speed);
> +
> +static ssize_t current_link_width_show(struct device *dev,
> +                                      struct device_attribute *attr, char *buf)
> +{
> +       struct pci_dev *pci_dev = to_pci_dev(dev);
> +       u16 linkstat;
> +       int err;
> +
> +       err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
> +
> +       return err ? -EINVAL : sprintf(
> +               buf, "%u\n",
> +               (linkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT);
> +}
> +static DEVICE_ATTR_RO(current_link_width);
> +
> +static ssize_t secondary_bus_number_show(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        char *buf)
> +{
> +       struct pci_dev *pci_dev = to_pci_dev(dev);
> +       u8 sec_bus;
> +       int err;
> +
> +       err = pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);

There is already a /sys/devices/pciDDDD:BB/DDDD:BB:dd.f/<secondary>/
directory and a .../pci_bus/ directory that looks like it is the
secondary bus.  Is that enough?

If we also need this file, I would like it to do something sensible
when there is no secondary bus.  Maybe that is exposing the bus
numbers directly, or maybe it is something else.  I tend to think that
if you just want the register contents, lspci is enough, and if you
need something in sysfs, it should be a little more digested, e.g.,
the existing subdirectory.

It'd be helpful to know something about how you want to use this.

> +       return err ? -EINVAL : sprintf(buf, "%u\n", sec_bus);
> +}
> +static DEVICE_ATTR_RO(secondary_bus_number);
> +
> +static ssize_t subordinate_bus_number_show(struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          char *buf)
> +{
> +       struct pci_dev *pci_dev = to_pci_dev(dev);
> +       u8 sub_bus;
> +       int err;
> +
> +       err = pci_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
> +
> +       return err ? -EINVAL : sprintf(buf, "%u\n", sub_bus);
> +}
> +static DEVICE_ATTR_RO(subordinate_bus_number);
> +
>  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>                              char *buf)
>  {
> @@ -602,12 +723,17 @@ static struct attribute *pci_dev_attrs[] = {
>         NULL,
>  };
>
> -static const struct attribute_group pci_dev_group = {
> -       .attrs = pci_dev_attrs,
> +static struct attribute *pci_bridge_attrs[] = {
> +       &dev_attr_subordinate_bus_number.attr,
> +       &dev_attr_secondary_bus_number.attr,
> +       NULL,
>  };
>
> -const struct attribute_group *pci_dev_groups[] = {
> -       &pci_dev_group,
> +static struct attribute *pcie_dev_attrs[] = {
> +       &dev_attr_current_link_speed.attr,
> +       &dev_attr_current_link_width.attr,
> +       &dev_attr_max_link_width.attr,
> +       &dev_attr_max_link_speed.attr,
>         NULL,
>  };
>
> @@ -1540,6 +1666,57 @@ static umode_t pci_dev_hp_attrs_are_visible(struct kobject *kobj,
>         return a->mode;
>  }
>
> +static umode_t pci_bridge_attrs_are_visible(struct kobject *kobj,
> +                                           struct attribute *a, int n)
> +{
> +       struct device *dev = kobj_to_dev(kobj);
> +       struct pci_dev *pdev = to_pci_dev(dev);
> +
> +       if (!pci_is_bridge(pdev))
> +               return 0;

  if (pci_is_bridge(pdev))
    return a->mode;

  return 0;

I think it's easier to read without the negation.  Possibly that's
just my personal preference :)

> +
> +       return a->mode;
> +}
> +
> +static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
> +                                         struct attribute *a, int n)
> +{
> +       struct device *dev = kobj_to_dev(kobj);
> +       struct pci_dev *pdev = to_pci_dev(dev);
> +
> +       if (pci_find_capability(pdev, PCI_CAP_ID_EXP) == 0)

Use pci_is_pcie().

> +               return 0;
> +
> +       return a->mode;
> +}
> +
> +static const struct attribute_group pci_dev_group = {
> +       .attrs = pci_dev_attrs,
> +};
> +
> +const struct attribute_group *pci_dev_groups[] = {
> +       &pci_dev_group,
> +       NULL,
> +};
> +
> +static const struct attribute_group pci_bridge_group = {
> +       .attrs = pci_bridge_attrs,
> +};
> +
> +const struct attribute_group *pci_bridge_groups[] = {
> +       &pci_bridge_group,
> +       NULL,
> +};
> +
> +static const struct attribute_group pcie_dev_group = {
> +       .attrs = pcie_dev_attrs,
> +};
> +
> +const struct attribute_group *pcie_dev_groups[] = {
> +       &pcie_dev_group,
> +       NULL,
> +};
> +
>  static struct attribute_group pci_dev_hp_attr_group = {
>         .attrs = pci_dev_hp_attrs,
>         .is_visible = pci_dev_hp_attrs_are_visible,
> @@ -1574,12 +1751,24 @@ static struct attribute_group pci_dev_attr_group = {
>         .is_visible = pci_dev_attrs_are_visible,
>  };
>
> +static struct attribute_group pci_bridge_attr_group = {
> +       .attrs = pci_bridge_attrs,
> +       .is_visible = pci_bridge_attrs_are_visible,
> +};
> +
> +static struct attribute_group pcie_dev_attr_group = {
> +       .attrs = pcie_dev_attrs,
> +       .is_visible = pcie_dev_attrs_are_visible,
> +};
> +
>  static const struct attribute_group *pci_dev_attr_groups[] = {
>         &pci_dev_attr_group,
>         &pci_dev_hp_attr_group,
>  #ifdef CONFIG_PCI_IOV
>         &sriov_dev_attr_group,
>  #endif
> +       &pci_bridge_attr_group,
> +       &pcie_dev_attr_group,
>         NULL,
>  };
>
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 634c9c4..b1770dc 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -517,6 +517,10 @@
>  #define  PCI_EXP_LNKCAP_SLS    0x0000000f /* Supported Link Speeds */
>  #define  PCI_EXP_LNKCAP_SLS_2_5GB 0x00000001 /* LNKCAP2 SLS Vector bit 0 */
>  #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
> +#define  PCI_EXP_LNKCAP_MLS    0x0000000f /* Maximum Link Speeds */
> +#define  PCI_EXP_LNKCAP_MLS_2_5GB 0x00000001 /* LNKCAP2 SLS Vector bit 0 */
> +#define  PCI_EXP_LNKCAP_MLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
> +#define  PCI_EXP_LNKCAP_MLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */

Rather than adding these _MLS_ symbols as duplicates of _SLS_, please
just add one SLS_8_0GB symbol.

The _SLS_ names are an artifact of the fact that prior to PCIe r3.0,
this field was the "Supported Link Speeds" field.  PCIe 3.0 renamed it
to "Max Link Speed" and added the "Supported Link Speeds Vector" in
the new Link Capabilities 2 register.

>  #define  PCI_EXP_LNKCAP_MLW    0x000003f0 /* Maximum Link Width */
>  #define  PCI_EXP_LNKCAP_ASPMS  0x00000c00 /* ASPM Support */
>  #define  PCI_EXP_LNKCAP_L0SEL  0x00007000 /* L0s Exit Latency */
> --
> 2.7.4
>
