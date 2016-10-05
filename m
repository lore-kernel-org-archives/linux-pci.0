Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:6081 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751634AbcJEAd0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Oct 2016 20:33:26 -0400
Date: Wed, 5 Oct 2016 08:33:11 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org
Subject: [pci:pci/host-cleanups-wip 91/95]
 drivers/pci/host/pci-rcar-gen2.c:215:8: error: too few arguments to function
 'rcar_pci_readl'
Message-ID: <201610050810.iXjbyfdl%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-cleanups-wip
head:   ee559fc5aa013976c4415dbd9c14107b6eebaa10
commit: 3aa03100213456f92786b4c1da302257d6e33e4c [91/95] PCI: rcar-gen2: Add register accessors
config: arm-shmobile_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 3aa03100213456f92786b4c1da302257d6e33e4c
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/pci/host/pci-rcar-gen2.c: In function 'rcar_pci_writel':
>> drivers/pci/host/pci-rcar-gen2.c:117:12: warning: passing argument 1 of 'iowrite32' makes integer from pointer without a cast [-Wint-conversion]
     iowrite32(rcar->reg + offset, val);
               ^~~~
   In file included from arch/arm/include/asm/io.h:451:0,
                    from include/linux/io.h:25,
                    from drivers/pci/host/pci-rcar-gen2.c:17:
   include/asm-generic/io.h:615:19: note: expected 'u32 {aka unsigned int}' but argument is of type 'void *'
    #define iowrite32 iowrite32
                      ^
>> include/asm-generic/io.h:616:20: note: in expansion of macro 'iowrite32'
    static inline void iowrite32(u32 value, volatile void __iomem *addr)
                       ^~~~~~~~~
>> drivers/pci/host/pci-rcar-gen2.c:117:32: warning: passing argument 2 of 'iowrite32' makes pointer from integer without a cast [-Wint-conversion]
     iowrite32(rcar->reg + offset, val);
                                   ^~~
   In file included from arch/arm/include/asm/io.h:451:0,
                    from include/linux/io.h:25,
                    from drivers/pci/host/pci-rcar-gen2.c:17:
   include/asm-generic/io.h:615:19: note: expected 'volatile void *' but argument is of type 'u32 {aka unsigned int}'
    #define iowrite32 iowrite32
                      ^
>> include/asm-generic/io.h:616:20: note: in expansion of macro 'iowrite32'
    static inline void iowrite32(u32 value, volatile void __iomem *addr)
                       ^~~~~~~~~
   drivers/pci/host/pci-rcar-gen2.c: In function 'rcar_pci_setup':
>> drivers/pci/host/pci-rcar-gen2.c:79:27: warning: passing argument 1 of 'rcar_pci_readl' makes pointer from integer without a cast [-Wint-conversion]
    #define RCAR_USBCTR_REG   (RCAR_AHBPCI_PCICOM_OFFSET + 0x34)
                              ^
>> drivers/pci/host/pci-rcar-gen2.c:215:23: note: in expansion of macro 'RCAR_USBCTR_REG'
     val = rcar_pci_readl(RCAR_USBCTR_REG) & ~RCAR_USBCTR_DIRPD;
                          ^~~~~~~~~~~~~~~
   drivers/pci/host/pci-rcar-gen2.c:110:12: note: expected 'struct rcar_pci *' but argument is of type 'int'
    static u32 rcar_pci_readl(struct rcar_pci *rcar, u32 offset)
               ^~~~~~~~~~~~~~
>> drivers/pci/host/pci-rcar-gen2.c:215:8: error: too few arguments to function 'rcar_pci_readl'
     val = rcar_pci_readl(RCAR_USBCTR_REG) & ~RCAR_USBCTR_DIRPD;
           ^~~~~~~~~~~~~~
   drivers/pci/host/pci-rcar-gen2.c:110:12: note: declared here
    static u32 rcar_pci_readl(struct rcar_pci *rcar, u32 offset)
               ^~~~~~~~~~~~~~

vim +/rcar_pci_readl +215 drivers/pci/host/pci-rcar-gen2.c

    11	 * published by the Free Software Foundation.
    12	 */
    13	
    14	#include <linux/delay.h>
    15	#include <linux/init.h>
    16	#include <linux/interrupt.h>
  > 17	#include <linux/io.h>
    18	#include <linux/kernel.h>
    19	#include <linux/of_address.h>
    20	#include <linux/of_pci.h>
    21	#include <linux/pci.h>
    22	#include <linux/platform_device.h>
    23	#include <linux/pm_runtime.h>
    24	#include <linux/sizes.h>
    25	#include <linux/slab.h>
    26	
    27	/* AHB-PCI Bridge PCI communication registers */
    28	#define RCAR_AHBPCI_PCICOM_OFFSET	0x800
    29	
    30	#define RCAR_PCIAHB_WIN1_CTR_REG	(RCAR_AHBPCI_PCICOM_OFFSET + 0x00)
    31	#define RCAR_PCIAHB_WIN2_CTR_REG	(RCAR_AHBPCI_PCICOM_OFFSET + 0x04)
    32	#define RCAR_PCIAHB_PREFETCH0		0x0
    33	#define RCAR_PCIAHB_PREFETCH4		0x1
    34	#define RCAR_PCIAHB_PREFETCH8		0x2
    35	#define RCAR_PCIAHB_PREFETCH16		0x3
    36	
    37	#define RCAR_AHBPCI_WIN1_CTR_REG	(RCAR_AHBPCI_PCICOM_OFFSET + 0x10)
    38	#define RCAR_AHBPCI_WIN2_CTR_REG	(RCAR_AHBPCI_PCICOM_OFFSET + 0x14)
    39	#define RCAR_AHBPCI_WIN_CTR_MEM		(3 << 1)
    40	#define RCAR_AHBPCI_WIN_CTR_CFG		(5 << 1)
    41	#define RCAR_AHBPCI_WIN1_HOST		(1 << 30)
    42	#define RCAR_AHBPCI_WIN1_DEVICE		(1 << 31)
    43	
    44	#define RCAR_PCI_INT_ENABLE_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x20)
    45	#define RCAR_PCI_INT_STATUS_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x24)
    46	#define RCAR_PCI_INT_SIGTABORT		(1 << 0)
    47	#define RCAR_PCI_INT_SIGRETABORT	(1 << 1)
    48	#define RCAR_PCI_INT_REMABORT		(1 << 2)
    49	#define RCAR_PCI_INT_PERR		(1 << 3)
    50	#define RCAR_PCI_INT_SIGSERR		(1 << 4)
    51	#define RCAR_PCI_INT_RESERR		(1 << 5)
    52	#define RCAR_PCI_INT_WIN1ERR		(1 << 12)
    53	#define RCAR_PCI_INT_WIN2ERR		(1 << 13)
    54	#define RCAR_PCI_INT_A			(1 << 16)
    55	#define RCAR_PCI_INT_B			(1 << 17)
    56	#define RCAR_PCI_INT_PME		(1 << 19)
    57	#define RCAR_PCI_INT_ALLERRORS (RCAR_PCI_INT_SIGTABORT		| \
    58					RCAR_PCI_INT_SIGRETABORT	| \
    59					RCAR_PCI_INT_SIGRETABORT	| \
    60					RCAR_PCI_INT_REMABORT		| \
    61					RCAR_PCI_INT_PERR		| \
    62					RCAR_PCI_INT_SIGSERR		| \
    63					RCAR_PCI_INT_RESERR		| \
    64					RCAR_PCI_INT_WIN1ERR		| \
    65					RCAR_PCI_INT_WIN2ERR)
    66	
    67	#define RCAR_AHB_BUS_CTR_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x30)
    68	#define RCAR_AHB_BUS_MMODE_HTRANS	(1 << 0)
    69	#define RCAR_AHB_BUS_MMODE_BYTE_BURST	(1 << 1)
    70	#define RCAR_AHB_BUS_MMODE_WR_INCR	(1 << 2)
    71	#define RCAR_AHB_BUS_MMODE_HBUS_REQ	(1 << 7)
    72	#define RCAR_AHB_BUS_SMODE_READYCTR	(1 << 17)
    73	#define RCAR_AHB_BUS_MODE		(RCAR_AHB_BUS_MMODE_HTRANS |	\
    74						RCAR_AHB_BUS_MMODE_BYTE_BURST |	\
    75						RCAR_AHB_BUS_MMODE_WR_INCR |	\
    76						RCAR_AHB_BUS_MMODE_HBUS_REQ |	\
    77						RCAR_AHB_BUS_SMODE_READYCTR)
    78	
  > 79	#define RCAR_USBCTR_REG			(RCAR_AHBPCI_PCICOM_OFFSET + 0x34)
    80	#define RCAR_USBCTR_USBH_RST		(1 << 0)
    81	#define RCAR_USBCTR_PCICLK_MASK		(1 << 1)
    82	#define RCAR_USBCTR_PLL_RST		(1 << 2)
    83	#define RCAR_USBCTR_DIRPD		(1 << 8)
    84	#define RCAR_USBCTR_PCIAHB_WIN2_EN	(1 << 9)
    85	#define RCAR_USBCTR_PCIAHB_WIN1_256M	(0 << 10)
    86	#define RCAR_USBCTR_PCIAHB_WIN1_512M	(1 << 10)
    87	#define RCAR_USBCTR_PCIAHB_WIN1_1G	(2 << 10)
    88	#define RCAR_USBCTR_PCIAHB_WIN1_2G	(3 << 10)
    89	#define RCAR_USBCTR_PCIAHB_WIN1_MASK	(3 << 10)
    90	
    91	#define RCAR_PCI_ARBITER_CTR_REG	(RCAR_AHBPCI_PCICOM_OFFSET + 0x40)
    92	#define RCAR_PCI_ARBITER_PCIREQ0	(1 << 0)
    93	#define RCAR_PCI_ARBITER_PCIREQ1	(1 << 1)
    94	#define RCAR_PCI_ARBITER_PCIBP_MODE	(1 << 12)
    95	
    96	#define RCAR_PCI_UNIT_REV_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x48)
    97	
    98	struct rcar_pci {
    99		struct device *dev;
   100		void __iomem *reg;
   101		struct resource mem_res;
   102		struct resource *cfg_res;
   103		unsigned busnr;
   104		int irq;
   105		unsigned long window_size;
   106		unsigned long window_addr;
   107		unsigned long window_pci;
   108	};
   109	
   110	static u32 rcar_pci_readl(struct rcar_pci *rcar, u32 offset)
   111	{
   112		return ioread32(rcar->reg + offset);
   113	}
   114	
   115	static void rcar_pci_writel(struct rcar_pci *rcar, u32 offset, u32 val)
   116	{
 > 117		iowrite32(rcar->reg + offset, val);
   118	}
   119	
   120	/* PCI configuration space operations */
   121	static void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
   122					       int where)
   123	{
   124		struct pci_sys_data *sys = bus->sysdata;
   125		struct rcar_pci *rcar = sys->private_data;
   126		int slot, val;
   127	
   128		if (sys->busnr != bus->number || PCI_FUNC(devfn))
   129			return NULL;
   130	
   131		/* Only one EHCI/OHCI device built-in */
   132		slot = PCI_SLOT(devfn);
   133		if (slot > 2)
   134			return NULL;
   135	
   136		/* bridge logic only has registers to 0x40 */
   137		if (slot == 0x0 && where >= 0x40)
   138			return NULL;
   139	
   140		val = slot ? RCAR_AHBPCI_WIN1_DEVICE | RCAR_AHBPCI_WIN_CTR_CFG :
   141			     RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG;
   142	
   143		rcar_pci_writel(rcar, RCAR_AHBPCI_WIN1_CTR_REG, val);
   144		return rcar->reg + (slot >> 1) * 0x100 + where;
   145	}
   146	
   147	/* PCI interrupt mapping */
   148	static int rcar_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
   149	{
   150		struct pci_sys_data *sys = dev->bus->sysdata;
   151		struct rcar_pci *rcar = sys->private_data;
   152		int irq;
   153	
   154		irq = of_irq_parse_and_map_pci(dev, slot, pin);
   155		if (!irq)
   156			irq = rcar->irq;
   157	
   158		return irq;
   159	}
   160	
   161	#ifdef CONFIG_PCI_DEBUG
   162	/* if debug enabled, then attach an error handler irq to the bridge */
   163	
   164	static irqreturn_t rcar_pci_err_irq(int irq, void *pw)
   165	{
   166		struct rcar_pci *rcar = pw;
   167		u32 status = rcar_pci_read(rcar, RCAR_PCI_INT_STATUS_REG);
   168	
   169		if (status & RCAR_PCI_INT_ALLERRORS) {
   170			dev_err(rcar->dev, "error irq: status %08x\n", status);
   171	
   172			/* clear the error(s) */
   173			rcar_pci_writel(rcar, RCAR_PCI_INT_STATUS_REG,
   174					status & RCAR_PCI_INT_ALLERRORS);
   175			return IRQ_HANDLED;
   176		}
   177	
   178		return IRQ_NONE;
   179	}
   180	
   181	static void rcar_pci_setup_errirq(struct rcar_pci *rcar)
   182	{
   183		int ret;
   184		u32 val;
   185	
   186		ret = devm_request_irq(rcar->dev, rcar->irq, rcar_pci_err_irq,
   187				       IRQF_SHARED, "error irq", rcar);
   188		if (ret) {
   189			dev_err(rcar->dev, "cannot claim IRQ for error handling\n");
   190			return;
   191		}
   192	
   193		val = rcar_pci_readl(rcar, RCAR_PCI_INT_ENABLE_REG);
   194		val |= RCAR_PCI_INT_ALLERRORS;
   195		rcar_pci_writel(rcar, RCAR_PCI_INT_ENABLE_REG, val);
   196	}
   197	#else
   198	static inline void rcar_pci_setup_errirq(struct rcar_pci *rcar) { }
   199	#endif
   200	
   201	/* PCI host controller setup */
   202	static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
   203	{
   204		struct rcar_pci *rcar = sys->private_data;
   205		u32 val;
   206		int ret;
   207	
   208		pm_runtime_enable(rcar->dev);
   209		pm_runtime_get_sync(rcar->dev);
   210	
   211		val = rcar_pci_readl(rcar, RCAR_PCI_UNIT_REV_REG);
   212		dev_info(rcar->dev, "PCI: bus%u revision %x\n", sys->busnr, val);
   213	
   214		/* Disable Direct Power Down State and assert reset */
 > 215		val = rcar_pci_readl(RCAR_USBCTR_REG) & ~RCAR_USBCTR_DIRPD;
   216		val |= RCAR_USBCTR_USBH_RST | RCAR_USBCTR_PLL_RST;
   217		rcar_pci_writel(rcar, RCAR_USBCTR_REG, val);
   218		udelay(4);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--LQksG6bCIzRHxTLp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
fwjSnDXW6QMObSIIUhysdGxE3OPtx/enl9fXx4+/bm8X/vz5Lv//m0S+f17px4v99Le77x/X
9z8v78+f/z2dB7TKlAf1SkbIqR5Obzfi96frs8r1+dL+avJX1qJXZZb+x+X1h/yPHkh0Rkjs
5/PLtZfqx8f16fLZJXx7+c+o4XX3Vge2R0rFBhExfwl21A6xCoDhR4OIyVOfa5qVCgJ0gw1f
isJBZ5xm9gvHAZqdFuA6S73wdwMkDvDU0VQ0OTj2gvHQdvSHvhq2j5jlAEOXGiGPSr5vqgwB
HL3g2OxNhe2LtNALHs30zLOH87ranEcwxQllJDqOmbKGYMwbWfgp0OHl+XLtpxvvjL4VLLRb
piToZakbwgP+fW6IwNip6yqwTF0m6eA9V0cHAUFr+r1YWEO7oyGPJoEnG+H50/bL7vSRu7g+
wjSa6ljiA7VaO6ELF3nP6SHAXU2H8BcL45Q/2oFxpKrjCplw9QCmnj4UJ8e2p3aYNfvRmvY4
WPK0DOxbQCxvpvvJdkcrV6+My7sxZ2B+1kMEptmt5gPwtNpHzOXhGNlBIcCFyQ3hgjNhi1g5
wcq02LH7IDAz7k4Etib6Zvj4dvl4bLa4nh+RUfL8YHvAZWoL8D3jDkQAY2fnh5VnnBQH4Xm2
ieXTapUujBulRBRIndohKuT1r0McFsbhUghjPUS5cBZFCF6A1pgsz7OFNYdK3TRPTOca4d57
zLSdKoCJPyVgGYdb4ybn3rtrECasQaScATf6bRah76TOhEE3r4+ff2DGZFFhea5xegnHG1lN
jBCk3gaqiA7gDR239haplzcp6f3f5e3y/mcnEI5FkYKi8zpAE9fHBNMOUHLlP+qynq6yMClU
kvkIKIuEBt+1d5oHHi+fT5dXsnq50vvuoQg7XS58x7h9pK7tr6briWhk5Z9kwyNr+Xl9Oj/V
a0wtt7fico/QLj46y6/u8MfT0wI4C+uh1BIApu8Ihl4DDGEVWi5GMAs4rxzCDgtgi9OD0VIL
VtIByvWAHDZAeWhNHaB8pLYdoFZfqtfKn0eVv7jLbLZfSULRvAMJf37+eX17+bzckaJp0x73
bnKw/CyPeIFr956j3b7RwXX4vdpnpLXi68XCX0CSekumKlBdr6+f9DxQrkqX1+uPu/fLv2/H
zj7/UhYq3PJ5Mz3Xbj8ef/xBVmkTveJhy8iDRU9tUH8g1fJ5W+zFvyyvq2XZd09VpuTmlZ8j
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
Y5W7N5oK44s+2N//HxMROiSspwEA

--LQksG6bCIzRHxTLp--
