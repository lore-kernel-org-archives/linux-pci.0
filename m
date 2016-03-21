Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ce586f6668ea9b86d41d982e6e916b52abe6e2c4.1458475382.git.lukas@wunner.de>
References: <cc23dc43ce25142f1b097a73c17bbcdada3f964d.1458475382.git.lukas@wunner.de>
 <ce586f6668ea9b86d41d982e6e916b52abe6e2c4.1458475382.git.lukas@wunner.de>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Mon, 21 Mar 2016 19:38:49 +0100
Message-ID: <CAMxnaaXPUUnSCTpJ=tESqJYfhoU3TTKdkXXNDLqL7=vfBc5vpw@mail.gmail.com>
Subject: Re: [PATCH 3/3] thunderbolt: Support 1st gen Light Ridge controller
To: Lukas Wunner <lukas@wunner.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 20, 2016 at 1:57 PM, Lukas Wunner <lukas@wunner.de> wrote:
> Built into:
> iMac12,1       2011  21.5"
> iMac12,2       2011  27"
> Macmini5,1     2011  i5 2.3 GHz
> Macmini5,2     2011  i5 2.5 GHz
> Macmini5,3     2011  i7 2.0 GHz
> MacBookPro8,1  2011  13"
> MacBookPro8,2  2011  15"
> MacBookPro8,3  2011  17"
> MacBookPro9,1  2012  15"
> MacBookPro9,2  2012  13"
>
> Light Ridge (CV82524) was the very first copper Thunderbolt controller,
> introduced 2010 alongside its fiber-optic cousin Light Peak (CVL2510).
> Consequently the chip suffers from some teething troubles:
>
> MSI is broken for hotplug signaling on the downstream bridges: The chip
> just never sends an interrupt. It requests 32 MSIs for each of its six
> bridges and the pcieport driver only allocates one per bridge. However
> I've verified that even if 32 MSIs are allocated there's no interrupt
> on hotplug. The only option is thus to disable MSI, which is also what
> OS X does. Apparently all Thunderbolt chips up to revision 1 of Cactus
> Ridge 4C are plagued by this issue so quirk those as well.
>
> The chip supports a maximum hop_count of 32, unlike its successors
> which support only 12. Fixup ring_interrupt_active() to cope with
> values >= 32.
>
> Another peculiarity is that the chip supports a maximum of 13 ports
> whereas its successors support 12. However the additional port (#5)
> seems to be unusable as reading its TB_CFG_PORT config space results
> in TB_CFG_ERROR_INVALID_CONFIG_SPACE. Add a quirk to mark the port
> disabled on the root switch, assuming that's necessary on all Macs
> using this chip.
>
> Cc: Andreas Noever <andreas.noever@gmail.com>
> Tested-by: Lukas Wunner <lukas@wunner.de> [MacBookPro9,1]
> Tested-by: William Brown <william@blackhats.net.au> [MacBookPro8,2]
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/quirks.c         | 29 ++++++++++++++++++++++++++++-
>  drivers/thunderbolt/eeprom.c |  5 +++++
>  drivers/thunderbolt/nhi.c    | 11 +++++++++--
>  drivers/thunderbolt/switch.c |  3 ++-
>  4 files changed, 44 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b584ddf..b1ff270 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3185,6 +3185,29 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
>                                PCI_CLASS_DISPLAY_VGA, 8, quirk_no_pm_reset);
>
> +/*
> + * Thunderbolt controllers with broken MSI hotplug signaling:
> + * Entire 1st generation (Light Ridge, Eagle Ridge, Light Peak) and part
> + * of the 2nd generation (Cactus Ridge 4C up to revision 1, Port Ridge).
> + */
> +static void quirk_thunderbolt_hotplug_msi(struct pci_dev *pdev)
> +{
> +       if (pdev->is_hotplug_bridge &&
> +           (pdev->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C ||
> +            pdev->revision <= 1))
> +               pdev->no_msi = 1;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LIGHT_RIDGE,
> +                       quirk_thunderbolt_hotplug_msi);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EAGLE_RIDGE,
> +                       quirk_thunderbolt_hotplug_msi);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LIGHT_PEAK,
> +                       quirk_thunderbolt_hotplug_msi);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
> +                       quirk_thunderbolt_hotplug_msi);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PORT_RIDGE,
> +                       quirk_thunderbolt_hotplug_msi);
> +
>  #ifdef CONFIG_ACPI
>  /*
>   * Apple: Shutdown Cactus Ridge Thunderbolt controller.
> @@ -3267,7 +3290,8 @@ static void quirk_apple_wait_for_thunderbolt(struct pci_dev *dev)
>         if (!nhi)
>                 goto out;
>         if (nhi->vendor != PCI_VENDOR_ID_INTEL
> -                   || (nhi->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
> +                   || (nhi->device != PCI_DEVICE_ID_INTEL_LIGHT_RIDGE &&
> +                       nhi->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
>                         nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI)
>                     || nhi->subsystem_vendor != 0x2222
>                     || nhi->subsystem_device != 0x1111)
> @@ -3279,6 +3303,9 @@ out:
>         pci_dev_put(sibling);
>  }
>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
> +                              PCI_DEVICE_ID_INTEL_LIGHT_RIDGE,
> +                              quirk_apple_wait_for_thunderbolt);
> +DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
>                                PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>                                quirk_apple_wait_for_thunderbolt);
>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
> diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
> index 47e56e8..0c052e2 100644
> --- a/drivers/thunderbolt/eeprom.c
> +++ b/drivers/thunderbolt/eeprom.c
> @@ -388,6 +388,11 @@ int tb_drom_read(struct tb_switch *sw)
>                 sw->ports[4].link_nr = 1;
>                 sw->ports[3].dual_link_port = &sw->ports[4];
>                 sw->ports[4].dual_link_port = &sw->ports[3];
> +
> +               /* Port 5 is inaccessible on this gen 1 controller */
> +               if (sw->config.device_id == PCI_DEVICE_ID_INTEL_LIGHT_RIDGE)
> +                       sw->ports[5].disabled = true;
> +
>                 return 0;
>         }
>
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index 36be23b..9c15344 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -37,7 +37,8 @@ static int ring_interrupt_index(struct tb_ring *ring)
>   */
>  static void ring_interrupt_active(struct tb_ring *ring, bool active)
>  {
> -       int reg = REG_RING_INTERRUPT_BASE + ring_interrupt_index(ring) / 32;
> +       int reg = REG_RING_INTERRUPT_BASE +
> +                 ring_interrupt_index(ring) / 32 * 4;
>         int bit = ring_interrupt_index(ring) & 31;
>         int mask = 1 << bit;
>         u32 old, new;
> @@ -564,7 +565,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         /* cannot fail - table is allocated bin pcim_iomap_regions */
>         nhi->iobase = pcim_iomap_table(pdev)[0];
>         nhi->hop_count = ioread32(nhi->iobase + REG_HOP_COUNT) & 0x3ff;
> -       if (nhi->hop_count != 12)
> +       if (nhi->hop_count != 12 && nhi->hop_count != 32)
>                 dev_warn(&pdev->dev, "unexpected hop count: %d\n",
>                          nhi->hop_count);
>         INIT_WORK(&nhi->interrupt_work, nhi_interrupt_work);
> @@ -638,6 +639,12 @@ static struct pci_device_id nhi_ids[] = {
>         {
>                 .class = PCI_CLASS_SYSTEM_OTHER << 8, .class_mask = ~0,
>                 .vendor = PCI_VENDOR_ID_INTEL,
> +               .device = PCI_DEVICE_ID_INTEL_LIGHT_RIDGE,
> +               .subvendor = 0x2222, .subdevice = 0x1111,
> +       },
> +       {
> +               .class = PCI_CLASS_SYSTEM_OTHER << 8, .class_mask = ~0,
> +               .vendor = PCI_VENDOR_ID_INTEL,
>                 .device = PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>                 .subvendor = 0x2222, .subdevice = 0x1111,
>         },
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index c6270f0..1e116f5 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -370,7 +370,8 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, u64 route)
>                 tb_sw_warn(sw, "unknown switch vendor id %#x\n",
>                            sw->config.vendor_id);
>
> -       if (sw->config.device_id != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
> +       if (sw->config.device_id != PCI_DEVICE_ID_INTEL_LIGHT_RIDGE &&
> +           sw->config.device_id != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
>             sw->config.device_id != PCI_DEVICE_ID_INTEL_PORT_RIDGE)
>                 tb_sw_warn(sw, "unsupported switch device id %#x\n",
>                            sw->config.device_id);
> --
> 2.8.0.rc3
>

Acked-by: Andreas Noever <andreas.noever@gmail.com>
(Whole series)


Nice Work!
