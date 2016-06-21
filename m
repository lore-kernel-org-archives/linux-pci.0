Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160606230706.20936.13086.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160606230706.20936.13086.stgit@bhelgaas-glaptop2.roam.corp.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Jun 2016 12:41:31 +0200
Message-ID: <CAMuHMdVgLfTD-BjRZ+gVKgYE8dkDZzQ6DnYtkUs+jVPthJsEdQ@mail.gmail.com>
Subject: Re: [PATCH v1 19/25] PCI: rcar Gen2: Request host bridge window resources
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Rob Herring <robh@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	rfi@lists.rocketboards.org, linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tanmay Inamdar <tinamdar@apm.com>, Ray Jui <rjui@broadcom.com>,
	linux-tegra@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, Jun 7, 2016 at 1:07 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Request host bridge window resources so they appear in ioport_resource and
> iomem_resource and are reflected in /proc/ioports and /proc/iomem.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-rcar-gen2.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index 9980a4b..617a6b2 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -194,6 +194,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
>         struct rcar_pci_priv *priv = sys->private_data;
>         void __iomem *reg = priv->reg;
>         u32 val;
> +       int ret;
>
>         pm_runtime_enable(priv->dev);
>         pm_runtime_get_sync(priv->dev);
> @@ -275,6 +276,9 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
>         /* Add PCI resources */
>         pci_add_resource(&sys->resources, &priv->io_res);
>         pci_add_resource(&sys->resources, &priv->mem_res);
> +       ret = devm_request_pci_bus_resources(priv->dev, &sys->resources);
> +       if (ret < 0)
> +               return ret;
>
>         /* Setup bus number based on platform device id / of bus-range */
>         sys->busnr = priv->busnr;

This patch (commit 1bd019707b7c9249d34c5d348f1ef75eb4d83e89 in pci/next)
broke PCI on r8a7791/koelsch. Dmesg differences are:

 pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
-pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
-pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
-pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
-pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
-pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
-pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
-pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
-pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
-pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
-pci 0000:00:01.0: supports D1 D2
-pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
-pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
-pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
-pci 0000:00:02.0: supports D1 D2
-pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
-PCI: bus0: Fast back to back transfers disabled
-pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
-pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
-pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
+pci-rcar-gen2 ee090000.pci: resource collision: [io
0xee080000-0xee0810ff] conflicts with PCI IO [io  0x0000-0xfffff]

and:

 pci-rcar-gen2 ee0d0000.pci: PCI: bus0 revision 11
-pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
-pci_bus 0001:01: root bus resource [io  0xee0c0000-0xee0c10ff]
-pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0c10ff]
-pci_bus 0001:01: No busn resource found for root bus, will use [bus 01-ff]
-pci 0001:01:00.0: [1033:0000] type 00 class 0x060000
-pci 0001:01:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
-pci 0001:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
-pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310
-pci 0001:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
-pci 0001:01:01.0: supports D1 D2
-pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
-pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320
-pci 0001:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
-pci 0001:01:02.0: supports D1 D2
-pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
-PCI: bus1: Fast back to back transfers disabled
-pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
-pci 0001:01:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
-pci 0001:01:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
+pci-rcar-gen2 ee0d0000.pci: resource collision: [io
0xee0c0000-0xee0c10ff] conflicts with PCI IO [io  0x0000-0xfffff]

# cat /proc/iomem
30000000-37ffffff : /pcie@fe000000
38000000-3fffffff : /pcie@fe000000
40000000-6fffffff : System RAM
  40008000-40a1c15b : Kernel code
  40e00000-40e9ea97 : Kernel data
e6060000-e606024f : /pfc@e6060000
e60b0000-e60b0424 : /i2c@e60b0000
e6150000-e6150fff : /clock-controller@e6150000
e61f0000-e61f0013 : /thermal@e61f0000
e61f0100-e61f0137 : /thermal@e61f0000
e6530000-e653003f : /i2c@e6530000
e6590000-e65900ff : /usb@e6590000
e6590100-e65901ff : /usb-phy@e6590100
e65a0000-e65a00ff : /dma-controller@e65a0000
e65b0000-e65b00ff : /dma-controller@e65b0000
e6700000-e671ffff : /dma-controller@e6700000
e6720000-e673ffff : /dma-controller@e6720000
e6b10000-e6b1002b : /spi@e6b10000
e6e20000-e6e20063 : /spi@e6e20000
e6e60000-e6e6003f : e6e60000.serial
e6e68000-e6e6803f : e6e68000.serial
e6ef1000-e6ef1fff : /video@e6ef1000
ec500000-ec500fff : scu
ec540000-ec540fff : ssiu
ec541000-ec54127f : ssi
ec5a0000-ec5a00ff : adg
ec700000-ec70ffff : /dma-controller@ec700000
ec720000-ec72ffff : /dma-controller@ec720000
ec740000-ec7401ff : audmapp
ee090000-ee090bff : /pci@ee090000
ee0d0000-ee0d0bff : /pci@ee0d0000
ee300000-ee301fff : /sata@ee300000
ee700000-ee7003ff : /ethernet@ee700000
fe000000-fe07ffff : /pcie@fe000000
fe200000-fe3fffff : /pcie@fe000000
fe928000-fe92ffff : /vsp1@fe928000
fe930000-fe937fff : /vsp1@fe930000
fe938000-fe93ffff : /vsp1@fe938000
fe980000-fe9902ff : /jpeg-codec@fe980000
feb00000-feb3ffff : du
feb90000-feb9001b : lvds.0
# cat /proc/ioports
00000000-000fffff : /pcie@fe000000
#

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
