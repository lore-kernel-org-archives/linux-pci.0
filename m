Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1499260748-21860-1-git-send-email-okaya@codeaurora.org>
References: <1499260748-21860-1-git-send-email-okaya@codeaurora.org>
From: Jike Song <albcamus@gmail.com>
Date: Fri, 7 Jul 2017 13:04:16 +0800
Message-ID: <CANE52Ki_B0pitpyNMBjrtEJBX6Cspe8-m3hZuEFCWuBN2osh-g@mail.gmail.com>
Subject: Re: [PATCH] PCI: Do not enable extended tags on pre-dated (v1.x)
 systems
To: Sinan Kaya <okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 wim.ten.have@oracle.com, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 5, 2017 at 9:19 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> According to extended tags ECN document, all PCIe receivers are expected
> to support extended tags support. It should be safe to enable extended
> tags on endpoints without checking compatibility.
>
> This assumption seems to be working fine except for the legacy systems.
> The ECN has been written against PCIE spec version 2.0. Therefore, we need
> to exclude all version 1.0 devices from this change as there is HW out
> there that can't handle extended tags.
>
> Note that the default value of Extended Tags Enable bit is implementation
> specific. Therefore, we are clearing the bit by default when incompatible
> HW is found without assuming that value is zero.
>
> Reported-by: Wim ten Have <wim.ten.have@oracle.com>
> Link: https://pcisig.com/sites/default/files/specification_documents/ECN_Extended_Tag_Enable_Default_05Sept2008_final.pdf
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1467674
> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
> Tested-by: Wim ten Have <wim.ten.have@oracle.com>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/probe.c | 52 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 19c8950..5e39013 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1684,21 +1684,58 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
>          */
>  }
>
> -static void pci_configure_extended_tags(struct pci_dev *dev)
> +static bool pcie_bus_exttags_supported(struct pci_bus *bus)
> +{
> +       bool exttags_supported = true;
> +       struct pci_dev *bridge;
> +       int rc;
> +       u16 flags;
> +
> +       bridge = bus->self;
> +       while (bridge) {
> +               if (pci_is_pcie(bridge)) {
> +                       rc = pcie_capability_read_word(bridge, PCI_EXP_FLAGS,
> +                                                      &flags);
> +                       if (!rc && ((flags & PCI_EXP_FLAGS_VERS) < 2)) {
> +                               exttags_supported = false;
> +                               break;
> +                       }
> +               }
> +               if (!bridge->bus->parent)
> +                       break;
> +               bridge = bridge->bus->parent->self;
> +       }
> +
> +       return exttags_supported;
> +}
> +
> +static int pcie_bus_configure_exttags(struct pci_dev *dev, void *data)
>  {
>         u32 dev_cap;
>         int ret;
> +       bool supported;
>
>         if (!pci_is_pcie(dev))
> -               return;
> +               return 0;
>
>         ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &dev_cap);
>         if (ret)
> -               return;
> +               return 0;
>
> -       if (dev_cap & PCI_EXP_DEVCAP_EXT_TAG)
> -               pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
> -                                        PCI_EXP_DEVCTL_EXT_TAG);
> +       if (dev_cap & PCI_EXP_DEVCAP_EXT_TAG) {
> +               supported = pcie_bus_exttags_supported(dev->bus);
> +

Maybe checking the version of this endpoint at first? Do you expect a
v1 endpoint
to be working under v2+ ports?

-- 
Thanks,
Jike

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
