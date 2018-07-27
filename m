Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389210AbeG0Vtx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Jul 2018 17:49:53 -0400
Date: Fri, 27 Jul 2018 15:26:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Jain <rajatja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mayurkumar.patel@intel.com, rajatxjain@gmail.com,
        Richard Hughes <rhughes@redhat.com>,
        Carlos Garnacho <cgarnach@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pali Rohar <pali.rohar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andy Whitcroft <apw@canonical.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH v2] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
Message-ID: <20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com>
References: <20180508230148.121852-1-rajatja@google.com>
 <20180510233912.96454-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180510233912.96454-1-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, Richard, Carlos, Pali, Takashi, Andy, Colin for question
about how to expose ASPM power management in sysfs]

On Thu, May 10, 2018 at 04:39:12PM -0700, Rajat Jain wrote:
> ...
> And some suggestions from Bjorn here:
> https://www.spinics.net/lists/linux-pci/msg60541.html
> 
> This patch picks up one of the suggestion, to remove the
> CONFIG_PCIEASPM_DEBUG and thus make the code always
> avilable. This provides control to userspace to control
> ASPM on a per slot / device basis using sysfs interface.

TL;DR: When CONFIG_PCIEASPM_DEBUG=y, Linux makes ASPM control files
       visible in sysfs, associated with the upstream end (e.g., Root
       Port) of a link.  Should these files be associated with the
       downstream end (e.g., NIC, GPU, etc) instead?

I think we do need to make ASPM control files visible in sysfs, as
this patch does.  But I have a question about exactly *how* we want to
do this.  I had planned to merge this patch for v4.19, but I think
I'll postpone it until we figure this out.

ASPM is a power management feature of a PCIe link, and it affects the
devices on both ends of that link.  The upstream end (closest to the
CPU) is typically a Root Port, and the downstream end is typically an
Endpoint (e.g., a GPU, NIC, or NVMe device).  For example, my laptop
has these devices:

  00:1c.2 Intel Root Port to [bus 04]
  04:00.0 Intel 8260 Wireless NIC

There's a PCIe link between these two devices, and if both ends
support it, ASPM reduces power usage when the NIC is idle.  The
hardware reduces power usage automatically; the kernel only needs to
configure ASPM.

ASPM affects performance as well as power, so we have knobs to control
the tradeoff.  Starting with the big hammers, we currently have:

  - Kernel build-time setting (CONFIG_PCIEASPM_PERFORMANCE, etc).
    Requires kernel rebuild and reboot.

  - "pcie_aspm=X" kernel boot parameter.  Can only enable/disable and
    requires a reboot.

  - /sys/module/pcie_aspm/parameters/policy file.  At any time, root
    can set the system-wide ASPM policy to one of these settings:

      + highest performance, highest power consumption
      + moderate power saving at cost of some performance
      + aggressive power saving at cost of more performance
      + use whatever setting BIOS configured

  - Many /sys/devices/pci0000:00/0000:00:1c.2/power/link_state files.
    At any time, root can set the ASPM policy to one of the above
    settings, but for individual devices.  Currently these files are
    only available when CONFIG_PCIEASPM_DEBUG=y (Red Hat does not
    enable this, but Ubuntu does).

The patch below changes it so these /sys/devices/.../link_state files
*always* exist, regardless of CONFIG_PCIEASPM_DEBUG.

The question is where those sysfs files should be.  Currently they are
associated with the device at the *upstream* end of the link.  In the
example above, they're associated with the Root Port:

  /sys/devices/pci0000:00/0000:00:1c.2/power/link_state

I don't know if that's the right place, or if they should be
associated with the device at the *downstream* end of the link, i.e.,
04:00.0.  The downstream end might be better because:

  - It's easier to associate the downstream end with a device the user
    cares about, e.g., a NIC, GPU, etc.  This is mostly a user-
    interface issue.

  - A link can lead to a multi-function device, and the spec allows
    those functions to have different ASPM settings (see PCIe r4.0,
    sec 5.4.1).  With the sysfs files at the upstream end of the link,
    we have no way to configure those functions individually.

Any thoughts?

> ...
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index b12e28b3d8f9..089b9f559d88 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -46,14 +46,6 @@ config PCIEASPM
>  
>  	  When in doubt, say Y.
>  
> -config PCIEASPM_DEBUG
> -	bool "Debug PCI Express ASPM"
> -	depends on PCIEASPM
> -	default n
> -	help
> -	  This enables PCI Express ASPM debug support. It will add per-device
> -	  interface to control ASPM.
> -
>  choice
>  	prompt "Default ASPM policy"
>  	default PCIEASPM_DEFAULT
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index c687c817b47d..8ffc13d42baa 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1161,7 +1161,6 @@ static int pcie_aspm_get_policy(char *buffer, const struct kernel_param *kp)
>  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
>  	NULL, 0644);
>  
> -#ifdef CONFIG_PCIEASPM_DEBUG
>  static ssize_t link_state_show(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
> @@ -1264,7 +1263,6 @@ void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
>  		sysfs_remove_file_from_group(&pdev->dev.kobj,
>  			&dev_attr_clk_ctl.attr, power_group);
>  }
> -#endif
>  
>  static int __init pcie_aspm_disable(char *str)
>  {
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
