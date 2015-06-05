Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34159 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908AbbFEAX6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 20:23:58 -0400
Received: by pdbki1 with SMTP id ki1so41118108pdb.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2015 17:23:57 -0700 (PDT)
Message-ID: <1433463773.7208.0.camel@axtens.net>
Subject: Re: [RFT v2 00/48] Refine irq interfaces to reduce number of
 parameters
From: Daniel Axtens <dja@axtens.net>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Date: Fri, 05 Jun 2015 10:22:53 +1000
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-w2KIXocCJZqJNRjHtefS"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-w2KIXocCJZqJNRjHtefS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gerry,

You seem to be missing the links where I can grab this patch set from,
as indicated below. Is there somewhere I can pull this from to make it a
bit easier for me to build?

(Sorry if I've missed this elsewhere in the thread!)

Thanks in advance,
Daniel

On Thu, 2015-06-04 at 12:13 +0800, Jiang Liu wrote:
> Many irq core interfaces pass both 'struct irq_desc *desc' and 'int irq'
> to identify an irq. But that's a little overhead, either 'irq_desc' or
> 'irq' could identify an irq. We could get 'irq_desc' from 'irq' by
> irq_to_desc() and get 'irq' from 'irq_desc' through irq_desc->irq_data.ir=
q.
> So this patch set aims to reduce number of parameters of irq related
> interfaces by passing in either 'irq' or 'irq_desc" but not both.
> Hope this helps to simplify interfaces and improve performance.
>=20
> This patch set is based the patch set to refine struct irq_data, which
> has been posted at:
Here
>=20
> The patch set could be split into five parts:
> 1) Patch 1-2 is following-on cleanup work for=20
> 2) Patch 3-14 optimize irq handlers by avoiding redundant calling of=20
>    irq_to_desc() when we already have a pointer to corresponding irq_desc=
.
> 3) Patch 15-20 reduce number of parameters of irq core functions.
> 4) Patch 21-34 prepare for killing the first parameter 'irq' of
>    irq_flow_handler_t
> 5) Patch 35-48 kill the first parameter 'irq' of irq_flow_handler_t.
>    All these patches should be combined as one big patch to support
>    bisecting, they have been split for easy review only.
>=20
> With all these patches applied, a tree-wide 'grep -R "struct irq_desc" *'
> shows that there are only four functions left who take both 'irq' and
> 'irq_desc' as parameters:
> kernel/irq/manage.c:__setup_irq(unsigned int irq, struct irq_desc *desc, =
struct irqaction *new)
> kernel/irq/debug.h:static inline void print_irq_desc(unsigned int irq, st=
ruct irq_desc *desc)
> kernel/irq/irqdesc.c:static void desc_set_defaults(unsigned int irq, stru=
ct irq_desc *desc, int node,
> kernel/irq/irqdesc.c:static void irq_insert_desc(unsigned int irq, struct=
 irq_desc *desc)
>=20
> They are all pretty safe, it's a good sign that we have done a clean
> conversion. Thomas suggested to use coci scripts verify conversion result=
,
> it's a little hard for me and will ask for help from Julia later.
>=20
> You may get the patch set from:
Here

> The patch set passes Fengguang's 0day test suites as below. And tests
> with other platforms and configurations will be appreciated:)
> ----------------------------------------------------------
> configs tested: 95
>=20
> alpha                               defconfig
> parisc                            allnoconfig
> parisc                         b180_defconfig
> parisc                        c3000_defconfig
> parisc                              defconfig
> i386                   randconfig-a0-06031710
> i386                   randconfig-a1-06031710
> x86_64                             acpi-redef
> x86_64                           allyesdebian
> x86_64                                nfsroot
> x86_64                            allnoconfig
> x86_64                                   rhel
> sh                                allnoconfig
> sh                          rsk7269_defconfig
> sh                  sh7785lcr_32bit_defconfig
> sh                            titan_defconfig
> ia64                             alldefconfig
> ia64                              allnoconfig
> ia64                                defconfig
> powerpc                           allnoconfig
> powerpc                             defconfig
> powerpc                       ppc64_defconfig
> i386                             alldefconfig
> i386                             allmodconfig
> i386                              allnoconfig
> i386                                defconfig
> mips                              allnoconfig
> mips                      fuloong2e_defconfig
> mips                                   jz4740
> mips                                     txx9
> x86_64                     randconfig-i0-0603
> x86_64                     randconfig-i1-0603
> sparc                               defconfig
> sparc64                           allnoconfig
> sparc64                             defconfig
> microblaze                      mmu_defconfig
> microblaze                    nommu_defconfig
> i386                       randconfig-i0-0603
> i386                       randconfig-i1-0603
> i386                             allyesconfig
> blackfin                BF526-EZBRD_defconfig
> blackfin                BF533-EZKIT_defconfig
> blackfin            BF561-EZKIT-SMP_defconfig
> blackfin                  TCM-BF537_defconfig
> cris                 etrax-100lx_v2_defconfig
> i386                       randconfig-n0-0603
> i386                       randconfig-n1-0603
> x86_64                                    lkp
> arm                               allnoconfig
> arm                         at91_dt_defconfig
> arm                                  at_hdmac
> arm                                    ep93xx
> arm                       imx_v6_v7_defconfig
> arm                                  iop-adma
> arm                          marzen_defconfig
> arm                          prima2_defconfig
> arm                                    sa1100
> arm                                   samsung
> arm                                        sh
> arm                       spear13xx_defconfig
> m68k                          amiga_defconfig
> m68k                       m5475evb_defconfig
> m68k                          multi_defconfig
> x86_64                           allmodconfig
> x86_64               randconfig-x000-06031659
> x86_64               randconfig-x001-06031659
> x86_64               randconfig-x002-06031659
> x86_64               randconfig-x003-06031659
> x86_64               randconfig-x004-06031659
> x86_64               randconfig-x005-06031659
> x86_64               randconfig-x006-06031659
> x86_64               randconfig-x007-06031659
> x86_64               randconfig-x008-06031659
> x86_64               randconfig-x009-06031659
> i386                       randconfig-r0-0603
> i386                       randconfig-r1-0603
> avr32                      atngw100_defconfig
> avr32                     atstk1006_defconfig
> frv                                 defconfig
> mn10300                     asb2364_defconfig
> openrisc                    or1ksim_defconfig
> tile                         tilegx_defconfig
> um                             i386_defconfig
> um                           x86_64_defconfig
> i386                 randconfig-x000-06031736
> i386                 randconfig-x001-06031736
> i386                 randconfig-x002-06031736
> i386                 randconfig-x003-06031736
> i386                 randconfig-x004-06031736
> i386                 randconfig-x005-06031736
> i386                 randconfig-x006-06031736
> i386                 randconfig-x007-06031736
> i386                 randconfig-x008-06031736
> i386                 randconfig-x009-06031736
> x86_64                 randconfig-x0-06031736
>=20
> Thanks!
> Gerry
>=20
> Jiang Liu (48):
>   genirq: Clean up outdated comments related to include/linux/irqdesc.h
>   genirq: Kill never used irq_node()
>   MIPS, irq: Use irq_desc_get_xxx() to avoid redundant lookup of
>     irq_desc
>   powerpc, irq: Use irq_desc_get_xxx() to avoid redundant lookup of
>     irq_desc
>   gpio: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
>   pinctrl: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
>   avr32, irq: Use irq_desc_get_xxx() to avoid redundant lookup of
>     irq_desc
>   mfd: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
>   ARM, irq: Use irq_desc_get_xxx() to avoid redundant lookup of
>     irq_desc
>   irqchip: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
>   ipu: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
>   sh: intc: Use irq_desc_get_xxx() to avoid redundant lookup of
>     irq_desc
>   keystone, irq: Use irq_data_get_xxx() to avoid redundant lookup of
>     irq_data
>   spmi: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
>   genirq: Kill the parameter 'irq' of kstat_incr_irqs_this_cpu()
>   genirq: Introduce helper irq_desc_get_irq()
>   genirq: Kill the parameter 'irq' of check_irq_resend()
>   genirq: Kill the parameter 'irq' of note_interrupt()
>   genirq: Change prototypes of register_irq_proc() and friends
>   genirq: Kill the parameter 'irq' of setup_affinity()
>   ARM, irq: Prepare for killing the first parameter 'irq' of
>     irq_flow_handler_t
>   blackfin, irq: Prepare for killing the first parameter 'irq' of
>     irq_flow_handler_t
>   c6x, irq: Prepare for killing the first parameter 'irq' of
>     irq_flow_handler_t
>   m68k, irq: Prepare for killing the first parameter 'irq' of
>     irq_flow_handler_t
>   mips, irq: Prepare for killing the first parameter 'irq' of
>     irq_flow_handler_t
>   powerpc, irq: Prepare for killing the first parameter 'irq' of
>     irq_flow_handler_t
>   sh, irq: Prepare for killing the first parameter 'irq' of
>     irq_flow_handler_t
>   unicore32, irq: Prepare for killing the first parameter 'irq' of
>     irq_flow_handler_t
>   ipu: Prepare for killing the first parameter 'irq' of
>     irq_flow_handler_t
>   gpio: Prepare for killing the first parameter 'irq' of
>     irq_flow_handler_t
>   irqchip: Prepare for killing the first parameter 'irq' of
>     irq_flow_handler_t
>   mfd: Prepare for killing the first parameter 'irq' of
>     irq_flow_handler_t
>   PCI/keystone: Prepare for killing the first parameter 'irq' of
>     irq_flow_handler_t
>   pinctrl: Prepare for killing the first parameter 'irq' of
>     irq_flow_handler_t
>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>   genirq, arm: Kill the first parameter 'irq' of irq_flow_handler_t
>   genirq, blackfin: Kill the first parameter 'irq' of
>     irq_flow_handler_t
>   genirq, powerpc: Kill the first parameter 'irq' of irq_flow_handler_t
>   genirq, mips: Kill the first parameter 'irq' of irq_flow_handler_t
>   genirq, m68k: Kill the first parameter 'irq' of irq_flow_handler_t
>   genirq, x86: Kill the first parameter 'irq' of irq_flow_handler_t
>   genirq, sh: Kill the first parameter 'irq' of irq_flow_handler_t
>   genirq, arch: Kill the first parameter 'irq' of irq_flow_handler_t
>   genirq, pinctrl: Kill the first parameter 'irq' of irq_flow_handler_t
>   genirq, gpio: Kill the first parameter 'irq' of irq_flow_handler_t
>   genirq, irqchip: Kill the first parameter 'irq' of irq_flow_handler_t
>   genirq, mfd: Kill the first parameter 'irq' of irq_flow_handler_t
>   genirq, drivers: Kill the first parameter 'irq' of irq_flow_handler_t
>=20
>  arch/alpha/kernel/irq.c                         |    2 +-
>  arch/arm/common/it8152.c                        |    2 +-
>  arch/arm/common/locomo.c                        |   13 ++---
>  arch/arm/common/sa1111.c                        |    6 +--
>  arch/arm/include/asm/hardware/it8152.h          |    2 +-
>  arch/arm/include/asm/mach/irq.h                 |    4 +-
>  arch/arm/mach-dove/irq.c                        |    5 +-
>  arch/arm/mach-footbridge/isa-irq.c              |    4 +-
>  arch/arm/mach-gemini/gpio.c                     |    2 +-
>  arch/arm/mach-imx/3ds_debugboard.c              |    2 +-
>  arch/arm/mach-imx/mach-mx31ads.c                |    2 +-
>  arch/arm/mach-iop13xx/msi.c                     |    2 +-
>  arch/arm/mach-lpc32xx/irq.c                     |    4 +-
>  arch/arm/mach-netx/generic.c                    |    2 +-
>  arch/arm/mach-omap1/fpga.c                      |    2 +-
>  arch/arm/mach-omap2/prm_common.c                |    2 +-
>  arch/arm/mach-pxa/balloon3.c                    |    5 +-
>  arch/arm/mach-pxa/cm-x2xx-pci.c                 |    4 +-
>  arch/arm/mach-pxa/lpd270.c                      |    6 +--
>  arch/arm/mach-pxa/pcm990-baseboard.c            |    5 +-
>  arch/arm/mach-pxa/viper.c                       |    8 ++-
>  arch/arm/mach-pxa/zeus.c                        |    8 ++-
>  arch/arm/mach-rpc/ecard.c                       |    2 +-
>  arch/arm/mach-s3c24xx/bast-irq.c                |    3 +-
>  arch/arm/mach-s3c64xx/common.c                  |    8 +--
>  arch/arm/mach-sa1100/neponset.c                 |    2 +-
>  arch/arm/plat-orion/gpio.c                      |    4 +-
>  arch/avr32/mach-at32ap/extint.c                 |    2 +-
>  arch/avr32/mach-at32ap/pio.c                    |    4 +-
>  arch/blackfin/include/asm/irq_handler.h         |    4 +-
>  arch/blackfin/kernel/ipipe.c                    |    4 +-
>  arch/blackfin/mach-bf537/ints-priority.c        |    8 ++-
>  arch/blackfin/mach-common/ints-priority.c       |    8 ++-
>  arch/c6x/platforms/megamod-pic.c                |    9 ++--
>  arch/m68k/amiga/amiints.c                       |    8 +--
>  arch/m68k/coldfire/intc-5272.c                  |    4 +-
>  arch/m68k/include/asm/irq.h                     |    3 +-
>  arch/m68k/include/asm/mac_via.h                 |    2 +-
>  arch/m68k/mac/baboon.c                          |    2 +-
>  arch/m68k/mac/oss.c                             |    4 +-
>  arch/m68k/mac/psc.c                             |    3 +-
>  arch/m68k/mac/via.c                             |    6 +--
>  arch/mips/alchemy/common/irq.c                  |    4 +-
>  arch/mips/alchemy/devboards/bcsr.c              |    3 +-
>  arch/mips/ath25/ar2315.c                        |    4 +-
>  arch/mips/ath25/ar5312.c                        |    4 +-
>  arch/mips/ath79/irq.c                           |   11 ++--
>  arch/mips/cavium-octeon/octeon-irq.c            |   12 +++--
>  arch/mips/include/asm/netlogic/common.h         |    4 +-
>  arch/mips/jz4740/gpio.c                         |    2 +-
>  arch/mips/netlogic/common/smp.c                 |    4 +-
>  arch/mips/pci/pci-ar2315.c                      |    4 +-
>  arch/mips/pci/pci-ar71xx.c                      |    4 +-
>  arch/mips/pci/pci-ar724x.c                      |    4 +-
>  arch/mips/pci/pci-rt3883.c                      |    8 ++-
>  arch/mips/ralink/irq.c                          |    4 +-
>  arch/powerpc/include/asm/qe_ic.h                |   23 ++++----
>  arch/powerpc/include/asm/tsi108_pci.h           |    2 +-
>  arch/powerpc/platforms/512x/mpc5121_ads_cpld.c  |    4 +-
>  arch/powerpc/platforms/52xx/media5200.c         |    2 +-
>  arch/powerpc/platforms/52xx/mpc52xx_gpt.c       |    4 +-
>  arch/powerpc/platforms/82xx/pq2ads-pci-pic.c    |    2 +-
>  arch/powerpc/platforms/85xx/common.c            |    2 +-
>  arch/powerpc/platforms/85xx/mpc85xx_cds.c       |    5 +-
>  arch/powerpc/platforms/85xx/mpc85xx_ds.c        |    2 +-
>  arch/powerpc/platforms/85xx/socrates_fpga_pic.c |    4 +-
>  arch/powerpc/platforms/86xx/pic.c               |    2 +-
>  arch/powerpc/platforms/8xx/m8xx_setup.c         |    2 +-
>  arch/powerpc/platforms/cell/axon_msi.c          |    4 +-
>  arch/powerpc/platforms/cell/interrupt.c         |    3 +-
>  arch/powerpc/platforms/cell/spider-pic.c        |    2 +-
>  arch/powerpc/platforms/chrp/setup.c             |    2 +-
>  arch/powerpc/platforms/embedded6xx/hlwd-pic.c   |    5 +-
>  arch/powerpc/platforms/embedded6xx/mvme5100.c   |    2 +-
>  arch/powerpc/platforms/pseries/setup.c          |    2 +-
>  arch/powerpc/sysdev/ge/ge_pic.c                 |    2 +-
>  arch/powerpc/sysdev/ge/ge_pic.h                 |    2 +-
>  arch/powerpc/sysdev/mpic.c                      |    2 +-
>  arch/powerpc/sysdev/qe_lib/qe_ic.c              |    4 +-
>  arch/powerpc/sysdev/tsi108_pci.c                |    2 +-
>  arch/powerpc/sysdev/uic.c                       |    4 +-
>  arch/powerpc/sysdev/xics/xics-common.c          |    2 +-
>  arch/powerpc/sysdev/xilinx_intc.c               |    2 +-
>  arch/sh/boards/mach-se/7343/irq.c               |    4 +-
>  arch/sh/boards/mach-se/7722/irq.c               |    4 +-
>  arch/sh/boards/mach-se/7724/irq.c               |    4 +-
>  arch/sh/boards/mach-x3proto/gpio.c              |    4 +-
>  arch/sh/cchips/hd6446x/hd64461.c                |    2 +-
>  arch/sparc/kernel/leon_kernel.c                 |    2 +-
>  arch/sparc/kernel/leon_pci_grpci1.c             |    2 +-
>  arch/sparc/kernel/leon_pci_grpci2.c             |    2 +-
>  arch/tile/kernel/pci_gx.c                       |    4 +-
>  arch/unicore32/kernel/irq.c                     |    5 +-
>  arch/x86/kernel/irq_32.c                        |   13 +++--
>  arch/x86/kernel/irq_64.c                        |    2 +-
>  arch/x86/lguest/boot.c                          |    2 +-
>  drivers/dma/ipu/ipu_irq.c                       |    8 +--
>  drivers/gpio/gpio-altera.c                      |    6 +--
>  drivers/gpio/gpio-bcm-kona.c                    |    4 +-
>  drivers/gpio/gpio-davinci.c                     |    3 +-
>  drivers/gpio/gpio-dwapb.c                       |    4 +-
>  drivers/gpio/gpio-ep93xx.c                      |    5 +-
>  drivers/gpio/gpio-intel-mid.c                   |    2 +-
>  drivers/gpio/gpio-lynxpoint.c                   |    2 +-
>  drivers/gpio/gpio-mpc8xxx.c                     |    2 +-
>  drivers/gpio/gpio-msic.c                        |    2 +-
>  drivers/gpio/gpio-msm-v2.c                      |    2 +-
>  drivers/gpio/gpio-mvebu.c                       |    4 +-
>  drivers/gpio/gpio-mxc.c                         |   10 ++--
>  drivers/gpio/gpio-mxs.c                         |    4 +-
>  drivers/gpio/gpio-omap.c                        |    4 +-
>  drivers/gpio/gpio-pl061.c                       |    2 +-
>  drivers/gpio/gpio-pxa.c                         |    2 +-
>  drivers/gpio/gpio-sa1100.c                      |    5 +-
>  drivers/gpio/gpio-tegra.c                       |    6 +--
>  drivers/gpio/gpio-timberdale.c                  |    7 +--
>  drivers/gpio/gpio-tz1090.c                      |    4 +-
>  drivers/gpio/gpio-vf610.c                       |    4 +-
>  drivers/gpio/gpio-zynq.c                        |    4 +-
>  drivers/gpu/ipu-v3/ipu-common.c                 |    8 +--
>  drivers/irqchip/exynos-combiner.c               |    8 +--
>  drivers/irqchip/irq-armada-370-xp.c             |    5 +-
>  drivers/irqchip/irq-bcm7038-l1.c                |    2 +-
>  drivers/irqchip/irq-bcm7120-l2.c                |    2 +-
>  drivers/irqchip/irq-brcmstb-l2.c                |    7 +--
>  drivers/irqchip/irq-dw-apb-ictl.c               |    6 +--
>  drivers/irqchip/irq-gic.c                       |    6 +--
>  drivers/irqchip/irq-imgpdc.c                    |    5 +-
>  drivers/irqchip/irq-keystone.c                  |    6 +--
>  drivers/irqchip/irq-metag-ext.c                 |    3 +-
>  drivers/irqchip/irq-metag.c                     |    3 +-
>  drivers/irqchip/irq-mips-gic.c                  |    2 +-
>  drivers/irqchip/irq-mmp.c                       |    3 +-
>  drivers/irqchip/irq-orion.c                     |    4 +-
>  drivers/irqchip/irq-s3c24xx.c                   |    6 +--
>  drivers/irqchip/irq-sunxi-nmi.c                 |    4 +-
>  drivers/irqchip/irq-tb10x.c                     |    4 +-
>  drivers/irqchip/irq-versatile-fpga.c            |    6 +--
>  drivers/irqchip/irq-vic.c                       |    2 +-
>  drivers/irqchip/spear-shirq.c                   |    4 +-
>  drivers/mfd/asic3.c                             |    2 +-
>  drivers/mfd/ezx-pcap.c                          |    4 +-
>  drivers/mfd/htc-egpio.c                         |    2 +-
>  drivers/mfd/jz4740-adc.c                        |    2 +-
>  drivers/mfd/max8997-irq.c                       |    8 +--
>  drivers/mfd/mt6397-core.c                       |    8 +--
>  drivers/mfd/pm8921-core.c                       |    2 +-
>  drivers/mfd/t7l66xb.c                           |    4 +-
>  drivers/mfd/tc6393xb.c                          |    4 +-
>  drivers/mfd/twl6030-irq.c                       |    2 +-
>  drivers/mfd/ucb1x00-core.c                      |    4 +-
>  drivers/pci/host/pci-keystone-dw.c              |   15 +++---
>  drivers/pci/host/pci-keystone.c                 |    7 +--
>  drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c       |    2 +-
>  drivers/pinctrl/intel/pinctrl-baytrail.c        |    2 +-
>  drivers/pinctrl/intel/pinctrl-cherryview.c      |    4 +-
>  drivers/pinctrl/intel/pinctrl-intel.c           |    4 +-
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c   |    6 +--
>  drivers/pinctrl/nomadik/pinctrl-nomadik.c       |   14 +++--
>  drivers/pinctrl/pinctrl-adi2.c                  |    3 +-
>  drivers/pinctrl/pinctrl-amd.c                   |    8 +--
>  drivers/pinctrl/pinctrl-at91.c                  |    4 +-
>  drivers/pinctrl/pinctrl-coh901.c                |    7 +--
>  drivers/pinctrl/pinctrl-rockchip.c              |    8 +--
>  drivers/pinctrl/pinctrl-single.c                |    4 +-
>  drivers/pinctrl/pinctrl-st.c                    |   10 ++--
>  drivers/pinctrl/qcom/pinctrl-msm.c              |    6 +--
>  drivers/pinctrl/samsung/pinctrl-exynos.c        |   12 ++---
>  drivers/pinctrl/samsung/pinctrl-s3c24xx.c       |   26 ++++-----
>  drivers/pinctrl/samsung/pinctrl-s3c64xx.c       |   32 ++++++-----
>  drivers/pinctrl/sirf/pinctrl-sirf.c             |    7 +--
>  drivers/pinctrl/spear/pinctrl-plgpio.c          |    2 +-
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c           |    7 +--
>  drivers/sh/intc/core.c                          |    4 +-
>  drivers/sh/intc/virq.c                          |   18 ++++---
>  drivers/spmi/spmi-pmic-arb.c                    |    6 +--
>  include/linux/irq.h                             |   20 ++++---
>  include/linux/irqdesc.h                         |   12 +++--
>  include/linux/irqhandler.h                      |    2 +-
>  include/linux/irqnr.h                           |    6 ---
>  kernel/irq/chip.c                               |   44 +++++++--------
>  kernel/irq/handle.c                             |    8 +--
>  kernel/irq/internals.h                          |   29 +++++-----
>  kernel/irq/irqdesc.c                            |    6 +--
>  kernel/irq/manage.c                             |   66 ++++++++++++-----=
------
>  kernel/irq/pm.c                                 |   12 ++---
>  kernel/irq/proc.c                               |   16 +++---
>  kernel/irq/resend.c                             |    4 +-
>  kernel/irq/spurious.c                           |   33 ++++++------
>  189 files changed, 543 insertions(+), 565 deletions(-)
>=20




--=-w2KIXocCJZqJNRjHtefS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVcOvnAAoJEPC3R3P2I92Fop0QANdkJ03T2ufU6dt1t8GE/3IC
Qjtz/7z/5W8MZlrL9+0J5CiPNJq7qoI1PTlQojTf1kixRofQPSi3t4gfCpp6onFJ
5Vh3e0PhKMVFJkwhJkXZf2ZmcKk4grAi1laee3szUum/48OUrSHbKf4SZypynLDr
qIK3gZTNtwVg5zdKfEIsMF/UpvweBPiyPmHkgniE8io/ICZFwWj1jydign6u27as
Y7vzMJWNXT0phutJJqklfWmivKYGCbWl3AFrtmIPHNaCX4u6I+5VjUtQgSUJKtZp
Hx01gFQYriZ+gRdFfcu5ItN9GXNFYNkZss7Z0b4CUkOAX4nspzAIn1ABUmz0W+ou
MP3holyCnZVt/7HcNh92KNB0BGdTtHfa38LzieU3KTE7FeMtk+O/84O2hYdjT7+v
IMnkFUoM4w+xHus6zzzl2Wiaucihwslg2x5nycKtwEPZ3e748KuAIy9yuNvtyxur
T/o6PceOOCW6N370+O+jgyIHeHkkinGojwNG5CEGuRMXonj/+dJGuUzoCOAjGKbg
vDeC7yO/EXqfwC6SSK/Sz4zgMkXxqPT7q+zQvS3Rtg6o/BWC3/CFJdIXAlX/8suJ
Yo5RqUBsgjrHob+ym3pUJNM9M8sW/QR1TssH9O+HQMPMWtQCOgQ4j0DCreO5bfN4
I67fzhG2k6z+DG/K+MLT
=o5N3
-----END PGP SIGNATURE-----

--=-w2KIXocCJZqJNRjHtefS--

