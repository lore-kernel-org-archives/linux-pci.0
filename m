Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC v1 00/25] Optimize irq flow handler
Date: Wed, 20 May 2015 17:59:48 +0800
Message-Id: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an patch set to optimize irq flow handler. It could be split
into three part.
1) Patch 1-12 get rid of redundant looking up of irq_desc and irq_data
   when we already had an pointer to corresponding irq_desc in irq
   flow handler. This part should be pretty safe.
2) Patch 13 is a perparation patch.
3) Patch 14-25 should be merge into one big fat patch, which kills
   the first parameter 'irq' of irq_flow_handler_t. I hope I have
   made all needed changes, but there are still some handler missed.
   After the conversion, there are only about 20 irq handlers which
   really access the irq number. This part is still in early stage
   and may cause building failures.

Please comment on whether we should be go on with the third part to
kill 'irq' of irq_flow_handler_t.

Thanks!
Gerry

Jiang Liu (25):
  ARM, irq: Use irq_desc_get_xxx() to avoid redundant lookup of
    irq_desc
  avr32, irq: Use irq_desc_get_xxx() to avoid redundant lookup of
    irq_desc
  MIPS, irq: Use irq_desc_get_xxx() to avoid redundant lookup of
    irq_desc
  powerpc, irq: Use irq_desc_get_xxx() to avoid redundant lookup of
    irq_desc
  gpio: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
  pinctrl: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
  irqchip: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
  mfd: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
  ipu: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
  sh: intc: Use irq_desc_get_xxx() to avoid redundant lookup of
    irq_desc
  keystone, irq: Use irq_data_get_xxx() to avoid redundant lookup of
    irq_data
  spmi: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
  genirq: Kill the parameter 'irq' of kstat_incr_irqs_this_cpu()
  genirq: Kill the first parameter 'irq' of irq_flow_handler_t
  genirq: Kill the first parameter 'irq' of irq_flow_handler_t
  genirq: Kill the first parameter 'irq' of irq_flow_handler_t
  genirq: Kill the first parameter 'irq' of irq_flow_handler_t
  genirq: Kill the first parameter 'irq' of irq_flow_handler_t
  genirq: Kill the first parameter 'irq' of irq_flow_handler_t
  genirq: Kill the first parameter 'irq' of irq_flow_handler_t
  genirq: Kill the first parameter 'irq' of irq_flow_handler_t
  genirq: Kill the first parameter 'irq' of irq_flow_handler_t
  genirq: Kill the first parameter 'irq' of irq_flow_handler_t
  genirq: Kill the first parameter 'irq' of irq_flow_handler_t
  genirq: Kill the first parameter 'irq' of irq_flow_handler_t

 arch/alpha/kernel/irq.c                         |    2 +-
 arch/arm/common/it8152.c                        |    2 +-
 arch/arm/common/locomo.c                        |    5 +--
 arch/arm/common/sa1111.c                        |    6 ++--
 arch/arm/include/asm/hardware/it8152.h          |    2 +-
 arch/arm/include/asm/mach/irq.h                 |    4 +--
 arch/arm/mach-dove/irq.c                        |    5 +--
 arch/arm/mach-footbridge/isa-irq.c              |    4 +--
 arch/arm/mach-gemini/gpio.c                     |    2 +-
 arch/arm/mach-imx/3ds_debugboard.c              |    2 +-
 arch/arm/mach-imx/mach-mx31ads.c                |    2 +-
 arch/arm/mach-iop13xx/msi.c                     |    2 +-
 arch/arm/mach-lpc32xx/irq.c                     |    4 +--
 arch/arm/mach-omap1/fpga.c                      |    2 +-
 arch/arm/mach-omap2/prm_common.c                |    2 +-
 arch/arm/mach-pxa/balloon3.c                    |    3 +-
 arch/arm/mach-pxa/cm-x2xx-pci.c                 |    4 +--
 arch/arm/mach-pxa/lpd270.c                      |    3 +-
 arch/arm/mach-pxa/pcm990-baseboard.c            |    1 +
 arch/arm/mach-pxa/viper.c                       |    3 +-
 arch/arm/mach-pxa/zeus.c                        |    3 +-
 arch/arm/mach-rpc/ecard.c                       |    2 +-
 arch/arm/mach-s3c64xx/common.c                  |    8 ++---
 arch/arm/mach-sa1100/neponset.c                 |    2 +-
 arch/arm/plat-orion/gpio.c                      |    4 +--
 arch/avr32/mach-at32ap/extint.c                 |    2 +-
 arch/avr32/mach-at32ap/pio.c                    |    4 +--
 arch/blackfin/kernel/ipipe.c                    |    4 +--
 arch/c6x/platforms/megamod-pic.c                |    3 +-
 arch/m68k/amiga/amiints.c                       |    8 ++---
 arch/m68k/coldfire/intc-5272.c                  |    4 +--
 arch/m68k/include/asm/mac_via.h                 |    2 +-
 arch/m68k/mac/baboon.c                          |    2 +-
 arch/m68k/mac/oss.c                             |    4 +--
 arch/m68k/mac/psc.c                             |    3 +-
 arch/m68k/mac/via.c                             |    6 ++--
 arch/mips/alchemy/common/irq.c                  |    4 +--
 arch/mips/alchemy/devboards/bcsr.c              |    3 +-
 arch/mips/ath25/ar2315.c                        |    4 +--
 arch/mips/ath25/ar5312.c                        |    4 +--
 arch/mips/ath79/irq.c                           |   11 ++++---
 arch/mips/cavium-octeon/octeon-irq.c            |   12 ++++---
 arch/mips/include/asm/netlogic/common.h         |    4 +--
 arch/mips/jz4740/gpio.c                         |    2 +-
 arch/mips/netlogic/common/smp.c                 |    4 +--
 arch/mips/pci/pci-ar2315.c                      |    4 +--
 arch/mips/pci/pci-ar71xx.c                      |    4 +--
 arch/mips/pci/pci-ar724x.c                      |    4 +--
 arch/mips/pci/pci-rt3883.c                      |    5 +--
 arch/mips/ralink/irq.c                          |    4 +--
 arch/powerpc/include/asm/qe_ic.h                |   23 ++++++--------
 arch/powerpc/include/asm/tsi108_pci.h           |    2 +-
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c  |    4 ++-
 arch/powerpc/platforms/52xx/media5200.c         |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c       |    4 +--
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c    |    2 +-
 arch/powerpc/platforms/85xx/common.c            |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c        |    2 +-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c |    3 +-
 arch/powerpc/platforms/86xx/pic.c               |    2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c         |    2 +-
 arch/powerpc/platforms/cell/axon_msi.c          |    4 +--
 arch/powerpc/platforms/cell/interrupt.c         |    3 +-
 arch/powerpc/platforms/cell/spider-pic.c        |    2 +-
 arch/powerpc/platforms/chrp/setup.c             |    2 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c   |    2 +-
 arch/powerpc/platforms/embedded6xx/mvme5100.c   |    2 +-
 arch/powerpc/platforms/pseries/setup.c          |    2 +-
 arch/powerpc/sysdev/ge/ge_pic.c                 |    2 +-
 arch/powerpc/sysdev/mpic.c                      |    2 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c              |    4 +--
 arch/powerpc/sysdev/tsi108_pci.c                |    2 +-
 arch/powerpc/sysdev/uic.c                       |    4 +--
 arch/powerpc/sysdev/xics/xics-common.c          |    2 +-
 arch/powerpc/sysdev/xilinx_intc.c               |    2 +-
 arch/sh/boards/mach-se/7343/irq.c               |    4 +--
 arch/sh/boards/mach-se/7722/irq.c               |    3 +-
 arch/sh/boards/mach-se/7724/irq.c               |    3 +-
 arch/sh/boards/mach-x3proto/gpio.c              |    4 +--
 arch/sh/cchips/hd6446x/hd64461.c                |    2 +-
 arch/sparc/kernel/leon_kernel.c                 |    2 +-
 arch/sparc/kernel/leon_pci_grpci1.c             |    2 +-
 arch/sparc/kernel/leon_pci_grpci2.c             |    2 +-
 arch/tile/kernel/pci_gx.c                       |    4 +--
 arch/unicore32/kernel/irq.c                     |    3 +-
 arch/x86/kernel/irq_64.c                        |    2 +-
 arch/x86/lguest/boot.c                          |    2 +-
 drivers/dma/ipu/ipu_irq.c                       |    8 +++--
 drivers/gpio/gpio-altera.c                      |    6 ++--
 drivers/gpio/gpio-bcm-kona.c                    |    4 +--
 drivers/gpio/gpio-davinci.c                     |    3 +-
 drivers/gpio/gpio-dwapb.c                       |    4 +--
 drivers/gpio/gpio-ep93xx.c                      |    5 +--
 drivers/gpio/gpio-intel-mid.c                   |    2 +-
 drivers/gpio/gpio-lynxpoint.c                   |    2 +-
 drivers/gpio/gpio-mpc8xxx.c                     |    2 +-
 drivers/gpio/gpio-msic.c                        |    2 +-
 drivers/gpio/gpio-msm-v2.c                      |    2 +-
 drivers/gpio/gpio-mvebu.c                       |    4 +--
 drivers/gpio/gpio-mxc.c                         |   10 +++---
 drivers/gpio/gpio-mxs.c                         |    4 +--
 drivers/gpio/gpio-omap.c                        |    4 +--
 drivers/gpio/gpio-pl061.c                       |    2 +-
 drivers/gpio/gpio-pxa.c                         |    2 +-
 drivers/gpio/gpio-sa1100.c                      |    4 +--
 drivers/gpio/gpio-tegra.c                       |    6 ++--
 drivers/gpio/gpio-timberdale.c                  |    7 +++--
 drivers/gpio/gpio-tz1090.c                      |    4 +--
 drivers/gpio/gpio-vf610.c                       |    4 +--
 drivers/gpio/gpio-zynq.c                        |    4 +--
 drivers/gpu/ipu-v3/ipu-common.c                 |    8 ++---
 drivers/irqchip/exynos-combiner.c               |    8 ++---
 drivers/irqchip/irq-armada-370-xp.c             |    2 +-
 drivers/irqchip/irq-bcm7038-l1.c                |    2 +-
 drivers/irqchip/irq-bcm7120-l2.c                |    2 +-
 drivers/irqchip/irq-brcmstb-l2.c                |    6 ++--
 drivers/irqchip/irq-dw-apb-ictl.c               |    6 ++--
 drivers/irqchip/irq-gic.c                       |    6 ++--
 drivers/irqchip/irq-imgpdc.c                    |    5 +--
 drivers/irqchip/irq-keystone.c                  |    3 +-
 drivers/irqchip/irq-metag-ext.c                 |    3 +-
 drivers/irqchip/irq-metag.c                     |    3 +-
 drivers/irqchip/irq-mips-gic.c                  |    2 +-
 drivers/irqchip/irq-mmp.c                       |    3 +-
 drivers/irqchip/irq-orion.c                     |    4 +--
 drivers/irqchip/irq-s3c24xx.c                   |    3 +-
 drivers/irqchip/irq-sunxi-nmi.c                 |    4 +--
 drivers/irqchip/irq-tb10x.c                     |    4 +--
 drivers/irqchip/irq-versatile-fpga.c            |    6 ++--
 drivers/irqchip/irq-vic.c                       |    2 +-
 drivers/irqchip/spear-shirq.c                   |    4 +--
 drivers/mfd/asic3.c                             |    2 +-
 drivers/mfd/ezx-pcap.c                          |    4 +--
 drivers/mfd/htc-egpio.c                         |    2 +-
 drivers/mfd/jz4740-adc.c                        |    2 +-
 drivers/mfd/max8997-irq.c                       |    8 ++---
 drivers/mfd/mt6397-core.c                       |    8 ++---
 drivers/mfd/pm8921-core.c                       |    2 +-
 drivers/mfd/t7l66xb.c                           |    4 +--
 drivers/mfd/tc6393xb.c                          |    4 +--
 drivers/mfd/twl6030-irq.c                       |    2 +-
 drivers/mfd/ucb1x00-core.c                      |    4 +--
 drivers/pci/host/pci-keystone-dw.c              |   15 ++++-----
 drivers/pci/host/pci-keystone.c                 |    7 +++--
 drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c       |    2 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c        |    2 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c      |    4 +--
 drivers/pinctrl/intel/pinctrl-intel.c           |    4 +--
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c   |    6 ++--
 drivers/pinctrl/nomadik/pinctrl-nomadik.c       |   14 ++++-----
 drivers/pinctrl/pinctrl-amd.c                   |    7 +++--
 drivers/pinctrl/pinctrl-at91.c                  |    4 +--
 drivers/pinctrl/pinctrl-coh901.c                |    7 +++--
 drivers/pinctrl/pinctrl-rockchip.c              |    7 +++--
 drivers/pinctrl/pinctrl-single.c                |    4 +--
 drivers/pinctrl/pinctrl-st.c                    |   10 +++---
 drivers/pinctrl/qcom/pinctrl-msm.c              |    6 ++--
 drivers/pinctrl/samsung/pinctrl-exynos.c        |   12 +++----
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c       |   26 ++++++++--------
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c       |   32 +++++++++----------
 drivers/pinctrl/sirf/pinctrl-sirf.c             |    7 +++--
 drivers/pinctrl/spear/pinctrl-plgpio.c          |    2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c           |    7 +++--
 drivers/sh/intc/core.c                          |    4 +--
 drivers/sh/intc/virq.c                          |   17 +++++-----
 drivers/spmi/spmi-pmic-arb.c                    |    6 ++--
 include/linux/irq.h                             |   16 +++++-----
 include/linux/irqdesc.h                         |    9 ++++--
 include/linux/irqhandler.h                      |    2 +-
 kernel/irq/chip.c                               |   38 ++++++++++-------------
 kernel/irq/handle.c                             |    6 ++--
 kernel/irq/internals.h                          |    2 +-
 kernel/irq/irqdesc.c                            |    4 +--
 173 files changed, 420 insertions(+), 398 deletions(-)

-- 
1.7.10.4

