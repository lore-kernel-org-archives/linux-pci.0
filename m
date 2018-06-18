Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934807AbeFRWVC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jun 2018 18:21:02 -0400
Date: Mon, 18 Jun 2018 16:21:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH v3 3/3] PCI: Introduce the disable_acs_redir parameter
Message-ID: <20180618162100.3619575e@t450s.home>
In-Reply-To: <20180618193636.16210-4-logang@deltatee.com>
References: <20180618193636.16210-1-logang@deltatee.com>
        <20180618193636.16210-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 18 Jun 2018 13:36:36 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> In order to support P2P traffic on a segment of the PCI hierarchy,
> we must be able to disable the ACS redirect bits for select
> PCI bridges. The bridges must be selected before the devices are
> discovered by the kernel and the IOMMU groups created. Therefore,
> a kernel command line parameter is created to specify devices
> which must have their ACS bits disabled.
> 
> The new parameter takes a list of devices separated by a semicolon.
> Each device specified will have it's ACS redirect bits disabled.
> This is similar to the existing 'resource_alignment' parameter and just
> like it we also create a sysfs bus attribute which can be used to
> read the parameter. Writing the parameter is not supported
> as it would require forcibly hot plugging the affected device as
> well as all devices whose IOMMU groups might change.

Why do we need a sysfs attribute for this if it's static, can't we just
see it in /proc/cmdline?  Seems to be a fair bit of overhead to support
for as little as we can do with it.

> The ACS Request P2P Request Redirect, P2P Completion Redirect and P2P
> Egress Control bits are disabled which is sufficient to always allow
> passing P2P traffic uninterrupted. The bits are set after the kernel
> (optionally) enables the ACS bits itself. It is also done regardless of
> whether the kernel sets the bits or not seeing some BIOS firmware is known
> to set the bits on boot.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |   9 +++
>  drivers/pci/pci.c                               | 103 +++++++++++++++++++++++-
>  2 files changed, 110 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d45285e1ab6a..2ec36e258bb0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3190,6 +3190,15 @@
>  				Adding the window is slightly risky (it may
>  				conflict with unreported devices), so this
>  				taints the kernel.
> +		disable_acs_redir=<pci_dev>[; ...]
> +				Specify one or more PCI devices (in the format
> +				specified above) separated by semicolons.
> +				Each device specified will have the PCI ACS
> +				redirect capabilities forced off which will
> +				allow P2P traffic between devices through
> +				bridges without forcing it upstream. Note:
> +				this removes isolation between devices and
> +				will make the IOMMU groups less granular.
>  
>  	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
>  			Management.
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6fbad0492461..eb85bf507398 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2982,6 +2982,92 @@ void pci_request_acs(void)
>  	pci_acs_enable = 1;
>  }
>  
> +#define DISABLE_ACS_REDIR_PARAM_SIZE COMMAND_LINE_SIZE
> +static char disable_acs_redir_param[DISABLE_ACS_REDIR_PARAM_SIZE] = {0};

Hmm, wouldn't this be initialized to zero anyway?  I'm surprised
resource alignment is already wasting this sort of space vs dynamically
allocating, I'm not sure it's a good example to follow.

> +static DEFINE_SPINLOCK(disable_acs_redir_lock);
> +
> +static ssize_t pci_set_disable_acs_redir_param(const char *buf, size_t count)
> +{
> +	if (count > DISABLE_ACS_REDIR_PARAM_SIZE - 1)
> +		count = DISABLE_ACS_REDIR_PARAM_SIZE - 1;
> +	spin_lock(&disable_acs_redir_lock);
> +	strncpy(disable_acs_redir_param, buf, count);
> +	disable_acs_redir_param[count] = '\0';
> +	spin_unlock(&disable_acs_redir_lock);
> +	return count;
> +}
> +
> +static ssize_t pci_disable_acs_redir_show(struct bus_type *bus, char *buf)
> +{
> +	size_t count;
> +
> +	spin_lock(&disable_acs_redir_lock);
> +	count = snprintf(buf, PAGE_SIZE, "%s\n", disable_acs_redir_param);
> +	spin_unlock(&disable_acs_redir_lock);
> +	return count;
> +}
> +
> +static BUS_ATTR(disable_acs_redir, 0444, pci_disable_acs_redir_show, NULL);
> +
> +static int __init pci_disable_acs_redir_sysfs_init(void)
> +{
> +	return bus_create_file(&pci_bus_type, &bus_attr_disable_acs_redir);
> +}
> +late_initcall(pci_disable_acs_redir_sysfs_init);
> +
> +/**
> + * pci_disable_acs_redir - disable ACS redirect capabilities
> + * @dev: the PCI device
> + *
> + * For only devices specified in the disable_acs_redir parameter.
> + */
> +static void pci_disable_acs_redir(struct pci_dev *dev)
> +{
> +	int ret = 0;
> +	const char *p;
> +	int pos;
> +	u16 ctrl;
> +
> +	spin_lock(&disable_acs_redir_lock);
> +
> +	p = disable_acs_redir_param;
> +	while (*p) {
> +		ret = pci_dev_str_match(dev, p, &p);
> +		if (ret < 0) {
> +			pr_info_once("PCI: Can't parse disable_acs_redir parameter: %s\n",
> +				     disable_acs_redir_param);
> +
> +			break;
> +		} else if (ret == 1) {
> +			/* Found a match */
> +			break;
> +		}
> +
> +		if (*p != ';' && *p != ',') {
> +			/* End of param or invalid format */
> +			break;
> +		}
> +		p++;
> +	}
> +	spin_unlock(&disable_acs_redir_lock);
> +
> +	if (ret != 1)
> +		return;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> +	if (!pos)
> +		return;
> +
> +	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> +
> +	/* P2P Request & Completion Redirect */
> +	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
> +
> +	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> +
> +	pci_info(dev, "disabled ACS redirect\n");
> +}

Seems that too much is taken from the dynamic resource alignment that
doesn't necessarily apply to a read-only, commandline-only, device
discovery-only option.  I don't think we need locking, I don't think we
need a massive static buffer, ideally perhaps even no buffer, just a
pointer to commandline.  Thanks,

Alex

> +
>  /**
>   * pci_std_enable_acs - enable ACS on devices using standard ACS capabilites
>   * @dev: the PCI device
> @@ -3021,12 +3107,22 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>  void pci_enable_acs(struct pci_dev *dev)
>  {
>  	if (!pci_acs_enable)
> -		return;
> +		goto disable_acs_redir;
>  
>  	if (!pci_dev_specific_enable_acs(dev))
> -		return;
> +		goto disable_acs_redir;
>  
>  	pci_std_enable_acs(dev);
> +
> +disable_acs_redir:
> +	/*
> +	 * Note: pci_disable_acs_redir() must be called even if
> +	 * ACS is not enabled by the kernel because the firmware
> +	 * may have unexpectedly set the flags. So if we are told
> +	 * to disable it, we should always disable it after setting
> +	 * the kernel's default preferences.
> +	 */
> +	pci_disable_acs_redir(dev);
>  }
>  
>  static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
> @@ -5966,6 +6062,9 @@ static int __init pci_setup(char *str)
>  				pcie_bus_config = PCIE_BUS_PEER2PEER;
>  			} else if (!strncmp(str, "pcie_scan_all", 13)) {
>  				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
> +			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
> +				pci_set_disable_acs_redir_param(str + 18,
> +					strlen(str + 18));
>  			} else {
>  				printk(KERN_ERR "PCI: Unknown option `%s'\n",
>  						str);
