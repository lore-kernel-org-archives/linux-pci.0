Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 11 Jul 2017 14:58:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V3 1/2] PCI: Add Extended Tags quirk for Broadcom HT2100
 Root Port
Message-ID: <20170711195853.GA14614@bhelgaas-glaptop.roam.corp.google.com>
References: <1499786735-25782-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1499786735-25782-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, wim.ten.have@oracle.com,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 11, 2017 at 11:25:33AM -0400, Sinan Kaya wrote:
> All PCIe devices are expected to be able to handle 8-bit tags.
> 'commit 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")'
> enabled extended tags for all devices based on the spec direction.
> 
> The Broadcom HT2100 seems to be having issues with handling
> 8-bit tags. Mark it as broken.
> 
> Reported-by: Wim ten Have <wim.ten.have@oracle.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1467674
> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/quirks.c | 12 ++++++++++++
>  include/linux/pci.h  |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 085fb78..073d5dd 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4664,3 +4664,15 @@ static void quirk_intel_no_flr(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
> +
> +static void quirk_exttags_completer(struct pci_dev *pdev)
> +{
> +	/* This device cannot handle 256 tags as a completer */
> +	pdev->broken_exttags_completer = 1;

I think we should print something here as a clue to the user.

Wim, how did you find this problem originally?  Seems like it could
have been a hassle to track down.  I wonder if we should log a message
in pci_configure_extended_tags() when we change the setting (either to
enable or disable).  Maybe something in dmesg would have made it
easier to find the problem.

> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140,
> +			quirk_exttags_completer);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0142,
> +			quirk_exttags_completer);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0144,
> +			quirk_exttags_completer);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8039f9f..0b9f42d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -376,6 +376,7 @@ struct pci_dev {
>  	unsigned int	irq_managed:1;
>  	unsigned int	has_secondary_link:1;
>  	unsigned int	non_compliant_bars:1;	/* broken BARs; ignore them */
> +	unsigned int	broken_exttags_completer:1;

I think maybe we should put this bit in struct pci_host_bridge.  Then
the quirk could be something like this:

  static void quirk_ext_tags_broken(struct pci_dev *pdev)
  {
    struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);

    bridge->broken_ext_tags = 1;
    dev_info(&pdev->dev, "Extended Tag handling is broken\n");

    pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
  }

and we could keep the current strategy of calling
pci_configure_extended_tags() from pci_configure_device(), slightly
modified like this:

  void pci_configure_extended_tags(struct pci_dev *dev, void *ign)
  {
    u32 cap;
    u16 ctl;
    int ret;
    struct pci_host_bridge *host;

    if (!pci_is_pcie(dev))
      return;

    ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
    if (ret)
      return;

    if (!(cap & PCI_EXP_DEVCAP_EXT_TAG))
      return;

    ret = pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &ctl);
    if (ret)
      return;

    host = pci_find_host_bridge(dev->bus);
    if (host->broken_ext_tags && (ctl & PCI_EXP_DEVCTL_EXT_TAG)) {
      dev_info(&dev->dev, "disabling Extended Tags\n");
      pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
                                 PCI_EXP_DEVCTL_EXT_TAG);
      return;
    }

    if (!(ctl & PCI_EXP_DEVCTL_EXT_TAG)) {
      dev_info(&dev->dev, "enabling Extended Tags\n");
      pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
                               PCI_EXP_DEVCTL_EXT_TAG);
    }
  }

I'm trying to avoid pci_walk_bus() because it's such a minefield as
far as hot-added devices.  I don't think we can avoid one in the
quirk, to turn off extended tags for any devices we've already found,
but I think we *can* avoid adding more in
pcie_bus_configure_settings().

>  	pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has been called */
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
