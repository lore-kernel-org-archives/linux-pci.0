Return-Path: <SRS0=EwSf=FO=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=EwSf=FO=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <151908203999.37696.12678235610905422348.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908203999.37696.12678235610905422348.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Feb 2018 10:31:51 +0100
Message-ID: <CAJZ5v0hys5UY69H=ARHA-EsmH-CVqTQNSQciktDQ=nVBEKJHqQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PCI: Add PCIe port runtime suspend details
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	Mathias Nyman <mathias.nyman@intel.com>, Linux PM <linux-pm@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Peter Wu <peter@lekensteyn.nl>, Qipeng Zha <qipeng.zha@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andreas Noever <andreas.noever@gmail.com>,
	Dave Airlie <airlied@gmail.com>, Qi Zheng <qi.zheng@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 20, 2018 at 12:14 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Add details about how we decide whether we can put a PCI bridge in D3.
> 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend") added this
> support to reduce power consumption on Intel Sunrise Point and Broxton
> platforms.
>
> In some cases we don't use D3 for bridges even when it should work, simply
> because it's impractical to test the configuration, or we tripped over some
> possible hardware issue on older platforms.  Links to discussion of the
> PCIe port runtime power management patches, which includes mention of these
> issues, are below.
>
> No functional change.
>
> Link: v1: https://lkml.kernel.org/r/1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com
> Link: v2: https://lkml.kernel.org/r/1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com
> Link: v3: https://lkml.kernel.org/r/1460628268-16204-1-git-send-email-mika.westerberg@linux.intel.com
> Link: v4: https://lkml.kernel.org/r/1461578004-129094-1-git-send-email-mika.westerberg@linux.intel.com
> Link: v5: https://lkml.kernel.org/r/1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com
> Link: v6: https://lkml.kernel.org/r/1464855435-32960-1-git-send-email-mika.westerberg@linux.intel.com
> Link: https://lkml.kernel.org/r/2858019.9TUCWsDpTB@aspire.rjw.lan
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci.c |   19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f6a4dd10d9b0..75db77cf3f8f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2260,6 +2260,13 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  {
>         unsigned int year;
>
> +       /*
> +        * In principle we should be able to put conventional PCI bridges
> +        * into D3.  We only support it for PCIe because (a) we want to
> +        * save power on new (2015 and newer) SoCs that can enter deep
> +        * low-power states only if PCIe Root Ports are in D3 and (b) we
> +        * don't want to risk regressions on older hardware.
> +        */
>         if (!pci_is_pcie(bridge))
>                 return false;
>
> @@ -2276,6 +2283,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>                  * hotplug ports handled by firmware in System Management Mode
>                  * may not be put into D3 by the OS (Thunderbolt on non-Macs).
>                  * For simplicity, disallow in general for now.
> +                *
> +                * Per PCIe r4.0, sec 6.7.3.4, if the form factor requires
> +                * wake support, a hot-plug capable Downstream Port must
> +                * support generation of a wakeup event on hot-plug events
> +                * that occur when the system is in a sleep state or the
> +                * Port is in device state D1, D2, or D3hot.  Therefore, it
> +                * might be possible to use D3 even for hot-plug Ports, but
> +                * for now we do not.
>                  */
>                 if (bridge->is_hotplug_bridge)
>                         return false;
> @@ -2285,7 +2300,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>
>                 /*
>                  * It should be safe to put PCIe ports from 2015 or newer
> -                * to D3.
> +                * to D3.  We have vague reports of possible hardware
> +                * issues when putting older PCIe ports into D3.  See
> +                * changelog.
>                  */
>                 if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) &&
>                     year >= 2015) {
>
