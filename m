Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751882AbdFSWSD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Jun 2017 18:18:03 -0400
Date: Mon, 19 Jun 2017 17:17:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wong Vee Khee <vee.khee.wong@ni.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org, jhearn@ni.com,
        Ram.Amrani@cavium.com, hui.chun.ong@ni.com, shhuiw@foxmail.com,
        rajatja@google.com, linux-pci@vger.kernel.org,
        keith.busch@intel.com, jonathan.yong@intel.com
Subject: Re: [RESEND PATCH v3] pci-sysfs: Make PCI bridge attribute visible
 in sysfs
Message-ID: <20170619221758.GC554@bhelgaas-glaptop.roam.corp.google.com>
References: <1496310186-42222-1-git-send-email-vee.khee.wong@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496310186-42222-1-git-send-email-vee.khee.wong@ni.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 01, 2017 at 05:43:06PM +0800, Wong Vee Khee wrote:
> From: vwong <vee.khee.wong@ni.com>
> 
>  In this commit, we are exposing PCIe bridges attributes
>  such as secondary bus number, subordinate bus number,
>  max link speed and link width, current link speed and
>  link width to sysfs located in /sys/bus/pci/devices/...
> 
>  Part of the reasons we are doing this rather than getting
>  these information through parsing lspci is due to the fact
>  that accessing PCIe link information via lspci require root
>  privilege.
> 
>  This changes also allow clients to get PCIe bridges information
>  easily because lspci list out all PCIe devices.
> 
> Signed-off-by: Wong Vee Khee <vee.khee.wong@ni.com>
> Signed-off-by: Hui Chun Ong <hui.chun.ong@ni.com>

Applied to pci/enumeration for v4.13, thanks!

> ---
> v3: Update commit message to be more explicit
> v2: Remove error checking on LNKCAP
>     Add define of PCI_LNKCAP_SLS_8_0GB
> ---
>  drivers/pci/pci-sysfs.c       | 197 +++++++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/pci_regs.h |   1 +
>  2 files changed, 194 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 31e9961..a2ada91 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -154,6 +154,127 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(resource);
>  
> +static ssize_t max_link_speed_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	u32 linkcap;
> +	int err;
> +	const char *speed;
> +
> +	err = pcie_capability_read_dword(pci_dev, PCI_EXP_LNKCAP, &linkcap);
> +
> +	if (!err) {
> +		switch (linkcap & PCI_EXP_LNKCAP_SLS) {
> +		case PCI_EXP_LNKCAP_SLS_8_0GB:
> +			speed = "8 GT/s";
> +			break;
> +		case PCI_EXP_LNKCAP_SLS_5_0GB:
> +			speed = "5 GT/s";
> +			break;
> +		case PCI_EXP_LNKCAP_SLS_2_5GB:
> +			speed = "2.5 GT/s";
> +			break;
> +		default:
> +			speed = "Unknown speed";
> +		}
> +
> +		return sprintf(buf, "%s\n", speed);
> +	}
> +
> +	return -EINVAL;
> +}
> +static DEVICE_ATTR_RO(max_link_speed);
> +
> +static ssize_t max_link_width_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	u32 linkcap;
> +	int err;
> +
> +	err = pcie_capability_read_dword(pci_dev, PCI_EXP_LNKCAP, &linkcap);
> +
> +	return err ? -EINVAL : sprintf(
> +		buf, "%u\n", (linkcap & PCI_EXP_LNKCAP_MLW) >> 4);
> +}
> +static DEVICE_ATTR_RO(max_link_width);
> +
> +static ssize_t current_link_speed_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	u16 linkstat;
> +	int err;
> +	const char *speed;
> +
> +	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
> +
> +	if (!err) {
> +		switch (linkstat & PCI_EXP_LNKSTA_CLS) {
> +		case PCI_EXP_LNKSTA_CLS_8_0GB:
> +			speed = "8 GT/s";
> +			break;
> +		case PCI_EXP_LNKSTA_CLS_5_0GB:
> +			speed = "5 GT/s";
> +			break;
> +		case PCI_EXP_LNKSTA_CLS_2_5GB:
> +			speed = "2.5 GT/s";
> +			break;
> +		default:
> +			speed = "Unknown speed";
> +		}
> +
> +		return sprintf(buf, "%s\n", speed);
> +	}
> +
> +	return -EINVAL;
> +}
> +static DEVICE_ATTR_RO(current_link_speed);
> +
> +static ssize_t current_link_width_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	u16 linkstat;
> +	int err;
> +
> +	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
> +
> +	return err ? -EINVAL : sprintf(
> +		buf, "%u\n",
> +		(linkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT);
> +}
> +static DEVICE_ATTR_RO(current_link_width);
> +
> +static ssize_t secondary_bus_number_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	u8 sec_bus;
> +	int err;
> +
> +	err = pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
> +
> +	return err ? -EINVAL : sprintf(buf, "%u\n", sec_bus);
> +}
> +static DEVICE_ATTR_RO(secondary_bus_number);
> +
> +static ssize_t subordinate_bus_number_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	u8 sub_bus;
> +	int err;
> +
> +	err = pci_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
> +
> +	return err ? -EINVAL : sprintf(buf, "%u\n", sub_bus);
> +}
> +static DEVICE_ATTR_RO(subordinate_bus_number);
> +
>  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
> @@ -629,12 +750,17 @@ static struct attribute *pci_dev_attrs[] = {
>  	NULL,
>  };
>  
> -static const struct attribute_group pci_dev_group = {
> -	.attrs = pci_dev_attrs,
> +static struct attribute *pci_bridge_attrs[] = {
> +	&dev_attr_subordinate_bus_number.attr,
> +	&dev_attr_secondary_bus_number.attr,
> +	NULL,
>  };
>  
> -const struct attribute_group *pci_dev_groups[] = {
> -	&pci_dev_group,
> +static struct attribute *pcie_dev_attrs[] = {
> +	&dev_attr_current_link_speed.attr,
> +	&dev_attr_current_link_width.attr,
> +	&dev_attr_max_link_width.attr,
> +	&dev_attr_max_link_speed.attr,
>  	NULL,
>  };
>  
> @@ -1557,6 +1683,57 @@ static umode_t pci_dev_hp_attrs_are_visible(struct kobject *kobj,
>  	return a->mode;
>  }
>  
> +static umode_t pci_bridge_attrs_are_visible(struct kobject *kobj,
> +					    struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pci_is_bridge(pdev))
> +		return a->mode;
> +
> +	return 0;
> +}
> +
> +static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
> +					  struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pci_is_pcie(pdev))
> +		return a->mode;
> +
> +	return 0;
> +}
> +
> +static const struct attribute_group pci_dev_group = {
> +	.attrs = pci_dev_attrs,
> +};
> +
> +const struct attribute_group *pci_dev_groups[] = {
> +	&pci_dev_group,
> +	NULL,
> +};
> +
> +static const struct attribute_group pci_bridge_group = {
> +	.attrs = pci_bridge_attrs,
> +};
> +
> +const struct attribute_group *pci_bridge_groups[] = {
> +	&pci_bridge_group,
> +	NULL,
> +};
> +
> +static const struct attribute_group pcie_dev_group = {
> +	.attrs = pcie_dev_attrs,
> +};
> +
> +const struct attribute_group *pcie_dev_groups[] = {
> +	&pcie_dev_group,
> +	NULL,
> +};
> +
>  static struct attribute_group pci_dev_hp_attr_group = {
>  	.attrs = pci_dev_hp_attrs,
>  	.is_visible = pci_dev_hp_attrs_are_visible,
> @@ -1592,12 +1769,24 @@ static struct attribute_group pci_dev_attr_group = {
>  	.is_visible = pci_dev_attrs_are_visible,
>  };
>  
> +static struct attribute_group pci_bridge_attr_group = {
> +	.attrs = pci_bridge_attrs,
> +	.is_visible = pci_bridge_attrs_are_visible,
> +};
> +
> +static struct attribute_group pcie_dev_attr_group = {
> +	.attrs = pcie_dev_attrs,
> +	.is_visible = pcie_dev_attrs_are_visible,
> +};
> +
>  static const struct attribute_group *pci_dev_attr_groups[] = {
>  	&pci_dev_attr_group,
>  	&pci_dev_hp_attr_group,
>  #ifdef CONFIG_PCI_IOV
>  	&sriov_dev_attr_group,
>  #endif
> +	&pci_bridge_attr_group,
> +	&pcie_dev_attr_group,
>  	NULL,
>  };
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index d56bb00..c22d3eb 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -517,6 +517,7 @@
>  #define  PCI_EXP_LNKCAP_SLS	0x0000000f /* Supported Link Speeds */
>  #define  PCI_EXP_LNKCAP_SLS_2_5GB 0x00000001 /* LNKCAP2 SLS Vector bit 0 */
>  #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
> +#define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
>  #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
>  #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
>  #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
> -- 
> 2.7.4
> 
