Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 12 Jul 2017 10:55:50 +0200
From: Wim ten Have <wim.ten.have@oracle.com>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4] PCI: Add Extended Tags quirk for Broadcom HT2100
 Root Port
Message-ID: <20170712105550.6007fa06.wim.ten.have@oracle.com>
In-Reply-To: <1499832255-9845-1-git-send-email-okaya@codeaurora.org>
References: <1499832255-9845-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, Wim ten Have <wim.ten.have@oracle.com>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 12 Jul 2017 00:04:14 -0400
Sinan Kaya <okaya@codeaurora.org> wrote:

> All PCIe devices are expected to be able to handle 8-bit tags.
> 'commit 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")'
> enabled extended tags for all devices based on the spec direction.
> 
> The Broadcom HT2100 seems to be having issues with handling
> 8-bit tags. Mark it as broken.
> 
> If a device with extended tags quirk is found, disable extended tags for
> all devices in the tree assuming peer-to-peer is possible.
> 
> The pci_walk_bus() in the quirk handles all devices we've already
> enumerated, and all devices we'll enumerate in the future are handled in
> pci_configure_device().
> 
> Reported-by: Wim ten Have <wim.ten.have@oracle.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1467674
> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

  Problem seems fixed with this one.

  Tested-by: Wim ten Have <wim.ten.have@oracle.com>

[    0.000000] Linux version 4.12.0-rc5+ (wtenhave@hagen) (gcc version 6.3.1 20161221 (Red Hat 6.3.1-1) (GCC) ) #1 SMP Wed Jul 12 09:59:10 CEST 2017
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.12.0-rc5+ root=/dev/mapper/fedora_hagen-root ro rd.lvm.lv=fedora_hagen/root rd.lvm.lv=fedora_hagen/swap audit=0
	...
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Dell Inc. PowerEdge SC1435/0H313M, BIOS 2.2.5 03/21/2008
[    0.000000] tsc: Fast TSC calibration using PIT
	...
[    0.517737] PCI host bridge to bus 0000:00
[    0.517937] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.518131] pci_bus 0000:00: root bus resource [io  0xd000-0xefff window]
[    0.518326] pci_bus 0000:00: root bus resource [io  0x0d00-0x0fff window]
[    0.518521] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.518856] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xf1ffffff window]
[    0.519192] pci_bus 0000:00: root bus resource [mem 0xefb00000-0xefffffff window]
[    0.519522] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff window]
[    0.519859] pci_bus 0000:00: root bus resource [bus 00-fd]
[    0.520067] pci 0000:00:01.0: [1166:0036] type 01 class 0x060400
[    0.520101] pci 0000:00:01.0: Enabling HT MSI Mapping
[    0.520350] pci 0000:00:01.0: System wakeup disabled by ACPI
[    0.520583] pci 0000:00:02.0: [1166:0205] type 00 class 0x060000
[    0.520676] pci 0000:00:02.1: [1166:0214] type 00 class 0x01018a
[    0.520691] pci 0000:00:02.1: reg 0x10: [io  0x01f0-0x01f7]
[    0.520700] pci 0000:00:02.1: reg 0x14: [io  0x03f4-0x03f7]
[    0.520708] pci 0000:00:02.1: reg 0x18: [io  0x0170-0x0177]
[    0.520716] pci 0000:00:02.1: reg 0x1c: [io  0x0374-0x0377]
[    0.520725] pci 0000:00:02.1: reg 0x20: [io  0x08c0-0x08cf]
[    0.520743] pci 0000:00:02.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.520947] pci 0000:00:02.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.521140] pci 0000:00:02.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.521335] pci 0000:00:02.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.521596] pci 0000:00:02.2: [1166:0234] type 00 class 0x060100
[    0.521712] pci 0000:00:03.0: [1166:0223] type 00 class 0x0c0310
[    0.521727] pci 0000:00:03.0: reg 0x10: [mem 0xefbed000-0xefbedfff]
[    0.521736] pci 0000:00:03.0: reg 0x14: [io  0xd000-0xd0ff]
[    0.521853] pci 0000:00:03.1: [1166:0223] type 00 class 0x0c0310
[    0.521868] pci 0000:00:03.1: reg 0x10: [mem 0xefbee000-0xefbeefff]
[    0.521877] pci 0000:00:03.1: reg 0x14: [io  0xd400-0xd4ff]
[    0.521989] pci 0000:00:03.2: [1166:0223] type 00 class 0x0c0320
[    0.522005] pci 0000:00:03.2: reg 0x10: [mem 0xefbef000-0xefbeffff]
[    0.522013] pci 0000:00:03.2: reg 0x14: [io  0xd800-0xd8ff]
[    0.522078] pci 0000:00:03.2: supports D1 D2
[    0.522079] pci 0000:00:03.2: PME# supported from D0 D1 D2 D3hot
[    0.522139] pci 0000:00:04.0: [1002:515e] type 00 class 0x030000
[    0.522154] pci 0000:00:04.0: reg 0x10: [mem 0xe0000000-0xe7ffffff pref]
[    0.522163] pci 0000:00:04.0: reg 0x14: [io  0xdc00-0xdcff]
[    0.522172] pci 0000:00:04.0: reg 0x18: [mem 0xefbf0000-0xefbfffff]
[    0.522204] pci 0000:00:04.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.522231] pci 0000:00:04.0: supports D1 D2
[    0.522276] pci 0000:00:07.0: [1166:0140] type 01 class 0x060400
[    0.522280] pci 0000:00:07.0: Extended Tag handling is broken
[    0.522508] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.522564] pci 0000:00:08.0: [1166:0142] type 01 class 0x060400
[    0.522567] pci 0000:00:08.0: Extended Tag handling is broken
[    0.522797] pci 0000:00:08.0: PME# supported from D0 D3hot D3cold
[    0.522824] pci 0000:00:08.0: System wakeup disabled by ACPI
[    0.523058] pci 0000:00:09.0: [1166:0144] type 01 class 0x060400
[    0.523061] pci 0000:00:09.0: Extended Tag handling is broken
[    0.523288] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.523316] pci 0000:00:09.0: System wakeup disabled by ACPI
[    0.523541] pci 0000:00:0a.0: [1166:0142] type 01 class 0x060400
[    0.523544] pci 0000:00:0a.0: Extended Tag handling is broken
[    0.523773] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    0.523799] pci 0000:00:0a.0: System wakeup disabled by ACPI
[    0.524032] pci 0000:00:0b.0: [1166:0144] type 01 class 0x060400
[    0.524035] pci 0000:00:0b.0: Extended Tag handling is broken
[    0.524261] pci 0000:00:0b.0: PME# supported from D0 D3hot D3cold
[    0.524330] pci 0000:00:18.0: [1022:1200] type 00 class 0x060000
[    0.524389] pci 0000:00:18.1: [1022:1201] type 00 class 0x060000
[    0.524443] pci 0000:00:18.2: [1022:1202] type 00 class 0x060000
[    0.524492] pci 0000:00:18.3: [1022:1203] type 00 class 0x060000
[    0.524543] pci 0000:00:18.4: [1022:1204] type 00 class 0x060000
[    0.524594] pci 0000:00:19.0: [1022:1200] type 00 class 0x060000
[    0.524650] pci 0000:00:19.1: [1022:1201] type 00 class 0x060000
[    0.524701] pci 0000:00:19.2: [1022:1202] type 00 class 0x060000
[    0.524752] pci 0000:00:19.3: [1022:1203] type 00 class 0x060000
[    0.524806] pci 0000:00:19.4: [1022:1204] type 00 class 0x060000
[    0.524944] pci 0000:03:0d.0: [1166:0104] type 01 class 0x060400
[    0.525022] pci 0000:03:0e.0: [1166:024b] type 00 class 0x01018f
[    0.525033] pci 0000:03:0e.0: reg 0x10: [io  0xecb0-0xecb7]
[    0.525039] pci 0000:03:0e.0: reg 0x14: [io  0xeca0-0xeca3]
[    0.525045] pci 0000:03:0e.0: reg 0x18: [io  0xecb8-0xecbf]
[    0.525051] pci 0000:03:0e.0: reg 0x1c: [io  0xeca4-0xeca7]
[    0.525056] pci 0000:03:0e.0: reg 0x20: [io  0xece0-0xecef]
[    0.525062] pci 0000:03:0e.0: reg 0x24: [mem 0xefdfe000-0xefdfffff]
[    0.525068] pci 0000:03:0e.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.525135] pci 0000:00:01.0: PCI bridge to [bus 03-04]
[    0.525330] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[    0.525332] pci 0000:00:01.0:   bridge window [mem 0xefc00000-0xefdfffff]
[    0.525391] pci 0000:03:0d.0: PCI bridge to [bus 04]
[    0.525620] pci 0000:00:07.0: PCI bridge to [bus 05]
[    0.525862] pci 0000:01:00.0: [14e4:1659] type 00 class 0x020000
[    0.525885] pci 0000:01:00.0: reg 0x10: [mem 0xefef0000-0xefefffff 64bit]
[    0.525985] pci 0000:01:00.0: PME# supported from D3hot D3cold
[    0.528889] pci 0000:00:08.0: PCI bridge to [bus 01]
[    0.529097] pci 0000:00:08.0:   bridge window [mem 0xefe00000-0xefefffff]
[    0.529153] pci 0000:02:00.0: [14e4:1659] type 00 class 0x020000
[    0.529176] pci 0000:02:00.0: reg 0x10: [mem 0xefff0000-0xefffffff 64bit]
[    0.529281] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.531883] pci 0000:00:09.0: PCI bridge to [bus 02]
[    0.532084] pci 0000:00:09.0:   bridge window [mem 0xeff00000-0xefffffff]
[    0.532129] pci 0000:00:0a.0: PCI bridge to [bus 06]
[    0.532350] pci 0000:00:0b.0: PCI bridge to [bus 07]
	...
[    3.714744] tg3 0000:01:00.0 eth0: Tigon3 [partno(BCM95721) rev 4201] (PCI Express) MAC address 00:22:19:27:cd:f8
[    3.714746] tg3 0000:01:00.0 eth0: attached PHY is 5750 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[    3.714748] tg3 0000:01:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    3.714750] tg3 0000:01:00.0 eth0: dma_rwctrl[76180000] dma_mask[64-bit]
	...
[    4.034593] tg3 0000:02:00.0 eth1: Tigon3 [partno(BCM95721) rev 4201] (PCI Express) MAC address 00:22:19:27:cd:f9
[    4.034747] tg3 0000:02:00.0 eth1: attached PHY is 5750 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[    4.034896] tg3 0000:02:00.0 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    4.035030] tg3 0000:02:00.0 eth1: dma_rwctrl[76180000] dma_mask[64-bit]

> ---
>  drivers/pci/pci.h    |  1 +
>  drivers/pci/probe.c  | 35 ++++++++++++++++++++++++++++++-----
>  drivers/pci/quirks.c | 19 +++++++++++++++++++
>  include/linux/pci.h  |  1 +
>  4 files changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index f8113e5..7153c92 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -239,6 +239,7 @@ enum pci_bar_type {
>  	pci_bar_mem64,		/* A 64-bit memory BAR */
>  };
>  
> +int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
>  bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
>  				int crs_timeout);
>  int pci_setup_device(struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 19c8950..bc067fb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1684,22 +1684,47 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
>  	 */
>  }
>  
> -static void pci_configure_extended_tags(struct pci_dev *dev)
> +int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
>  {
> +	struct pci_host_bridge *host;
>  	u32 dev_cap;
>  	int ret;
> +	u16 ctl;
>  
>  	if (!pci_is_pcie(dev))
> -		return;
> +		return 0;
>  
>  	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &dev_cap);
>  	if (ret)
> -		return;
> +		return 0;
> +
> +	if (!(dev_cap & PCI_EXP_DEVCAP_EXT_TAG))
> +		return 0;
> +
> +	ret = pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &ctl);
> +	if (ret)
> +		return 0;
> +
> +	host = pci_find_host_bridge(dev->bus);
> +	if (!host)
> +		return 0;
>  
> -	if (dev_cap & PCI_EXP_DEVCAP_EXT_TAG)
> +	if (host->broken_ext_tags) {
> +		if (ctl & PCI_EXP_DEVCTL_EXT_TAG) {
> +			dev_info(&dev->dev, "disabling Extended Tags\n");
> +			pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
> +						   PCI_EXP_DEVCTL_EXT_TAG);
> +		}
> +		return 0;
> +	}
> +	if (!(ctl & PCI_EXP_DEVCTL_EXT_TAG)) {
> +		dev_info(&dev->dev, "enabling Extended Tags\n");
>  		pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
>  					 PCI_EXP_DEVCTL_EXT_TAG);
> +	}
> +	return 0;
>  }
> +EXPORT_SYMBOL(pci_configure_extended_tags);
>  
>  static void pci_configure_device(struct pci_dev *dev)
>  {
> @@ -1707,7 +1732,7 @@ static void pci_configure_device(struct pci_dev *dev)
>  	int ret;
>  
>  	pci_configure_mps(dev);
> -	pci_configure_extended_tags(dev);
> +	pci_configure_extended_tags(dev, NULL);
>  
>  	memset(&hpp, 0, sizeof(hpp));
>  	ret = pci_get_hp_params(dev, &hpp);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 085fb78..b5dc99c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4664,3 +4664,22 @@ static void quirk_intel_no_flr(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
> +
> +static void quirk_exttags_completer(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> +
> +	if (!bridge)
> +		return;
> +
> +	bridge->broken_ext_tags = 1;
> +	dev_info(&pdev->dev, "Extended Tag handling is broken\n");
> +
> +	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140,
> +			quirk_exttags_completer);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0142,
> +			quirk_exttags_completer);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0144,
> +			quirk_exttags_completer);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8039f9f..2b22c3e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -441,6 +441,7 @@ struct pci_host_bridge {
>  	void *release_data;
>  	struct msi_controller *msi;
>  	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
> +	unsigned int broken_ext_tags:1;
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
>  			const struct resource *res,



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
