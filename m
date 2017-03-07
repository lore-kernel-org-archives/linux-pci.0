Return-Path: <SRS0=n2Am=2Q=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=n2Am=2Q=free.fr=slash.tmp@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 linux-usb <linux-usb@vger.kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
From: Mason <slash.tmp@free.fr>
Subject: Implementing MSI support on my platform
Message-ID: <7c792694-f2ec-6aeb-440d-ae8ac27cb2d3@free.fr>
Date: Tue, 7 Mar 2017 17:47:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

Hello,

As suggested by Marc, I'm trying to adapt
  drivers/pci/host/pcie-altera-msi.c
to my platform.


Here are my changes to the existing driver:

diff --git a/drivers/pci/host/pcie-altera-msi.c b/drivers/pci/host/pcie-altera-msi.c
index 4e5d628e8cd4..914cd26b2a53 100644
--- a/drivers/pci/host/pcie-altera-msi.c
+++ b/drivers/pci/host/pcie-altera-msi.c
@@ -18,6 +18,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#define DEBUG 42
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/init.h>
@@ -31,7 +32,11 @@
 
 #define MSI_STATUS             0x0
 #define MSI_ERROR              0x4
+#if 0
 #define MSI_INTMASK            0x8
+#else
+#define MSI_INTMASK            0x20
+#endif
 
 #define MAX_MSI_VECTORS                32
 
@@ -51,12 +56,19 @@ struct altera_msi {
 static inline void msi_writel(struct altera_msi *msi, const u32 value,
                              const u32 reg)
 {
+       printk("%s: reg=%u val=0x%x\n", __func__, reg, value);
        writel_relaxed(value, msi->csr_base + reg);
 }
 
 static inline u32 msi_readl(struct altera_msi *msi, const u32 reg)
 {
+#if 0
        return readl_relaxed(msi->csr_base + reg);
+#else
+       u32 val = readl_relaxed(msi->csr_base + reg);
+       printk("%s: reg=%u val=0x%x\n", __func__, reg, val);
+       return val;
+#endif
 }
 
 static void altera_msi_isr(struct irq_desc *desc)
@@ -68,14 +80,19 @@ static void altera_msi_isr(struct irq_desc *desc)
        u32 bit;
        u32 virq;
 
+       printk("%s: ENTER\n", __func__);
        chained_irq_enter(chip, desc);
        msi = irq_desc_get_handler_data(desc);
        num_of_vectors = msi->num_of_vectors;
 
        while ((status = msi_readl(msi, MSI_STATUS)) != 0) {
                for_each_set_bit(bit, &status, msi->num_of_vectors) {
+#if 0
                        /* Dummy read from vector to clear the interrupt */
                        readl_relaxed(msi->vector_base + (bit * sizeof(u32)));
+#else
+                       msi_writel(msi, bit, MSI_STATUS);
+#endif
 
                        virq = irq_find_mapping(msi->inner_domain, bit);
                        if (virq)
@@ -103,7 +120,11 @@ static void altera_msi_isr(struct irq_desc *desc)
 static void altera_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
        struct altera_msi *msi = irq_data_get_irq_chip_data(data);
+#if 0
        phys_addr_t addr = msi->vector_phy + (data->hwirq * sizeof(u32));
+#else
+       phys_addr_t addr = 0x8000000 + 0x2e07c;
+#endif
 
        msg->address_lo = lower_32_bits(addr);
        msg->address_hi = upper_32_bits(addr);
@@ -247,6 +268,7 @@ static int altera_msi_probe(struct platform_device *pdev)
                return PTR_ERR(msi->csr_base);
        }
 
+#if 0
        res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
                                           "vector_slave");
        msi->vector_base = devm_ioremap_resource(&pdev->dev, res);
@@ -256,6 +278,10 @@ static int altera_msi_probe(struct platform_device *pdev)
        }
 
        msi->vector_phy = res->start;
+#else
+       msi->vector_base = (void *)0xdeedbeef;
+       msi->vector_phy = 0xdeadbeef;
+#endif
 
        if (of_property_read_u32(np, "num-vectors", &msi->num_of_vectors)) {
                dev_err(&pdev->dev, "failed to parse the number of vectors\n");
@@ -276,6 +302,8 @@ static int altera_msi_probe(struct platform_device *pdev)
        irq_set_chained_handler_and_data(msi->irq, altera_msi_isr, msi);
        platform_set_drvdata(pdev, msi);
 
+       printk("%s: res=%pr irq=%d ret=%d\n", __func__, res, msi->irq, ret);
+
        return 0;
 
 err:



Here are the relevant DT nodes:

		msi0: msi@2e080 {
			compatible = "altr,msi-1.0";
			reg = <0x2e080 0x40>;
			reg-names = "csr";
			interrupt-parent = <&irq0>;
			interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
			msi-controller;
			num-vectors = <32>;
		};

		pcie@50000000 {
			compatible = "sigma,smp8759-pcie";
			reg = <0x50000000 0x8000000>;
			device_type = "pci";
			bus-range = <0x0 0x7f>;
			#size-cells = <2>;
			#address-cells = <3>;
			#interrupt-cells = <1>;
				/* BUS_ADDRESS(3)  CPU_PHYSICAL(1)  SIZE(2) */
			ranges = <0x02000000 0x0 0x8000000  0x58000000  0x0 0x8000000>;
			msi-parent = <&msi0>;
		};



Here are the relevant boot-time logs I see:

[    0.392199] altera_msi_probe: res=[mem 0x0002e080-0x0002e0bf flags 0x200] irq=22 ret=0
...
[    0.993868] OF: PCI: host bridge /soc/pcie@50000000 ranges:
[    0.999582] OF: PCI: Parsing ranges property...
[    1.004250] OF: PCI:   MEM 0x58000000..0x5fffffff -> 0x08000000
[    1.011770] pci_tango 50000000.pcie: ECAM at [mem 0x50000000-0x57ffffff] for [bus 00-7f]
[    1.020190] pci_tango 50000000.pcie: PCI host bridge to bus 0000:00
[    1.026604] pci_bus 0000:00: root bus resource [bus 00-7f]
[    1.032226] pci_bus 0000:00: root bus resource [mem 0x58000000-0x5fffffff] (bus address [0x08000000-0x0fffffff])
[    1.042553] pci_bus 0000:00: scanning bus
[    1.046708] pci 0000:00:00.0: [1105:0024] type 01 class 0x048000
[    1.052861] pci 0000:00:00.0: calling tango_pcie_fixup_class+0x0/0x10
[    1.059441] tango_config_write: bus=0 where=16 size=4 val=0xffffffff
[    1.065924] tango_config_write: bus=0 where=16 size=4 val=0x4
[    1.071797] tango_config_write: bus=0 where=20 size=4 val=0xffffffff
[    1.078278] tango_config_write: bus=0 where=20 size=4 val=0x0
[    1.084155] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit]
[    1.091074] tango_config_write: bus=0 where=56 size=4 val=0xfffff800
[    1.097554] tango_config_write: bus=0 where=56 size=4 val=0x0
[    1.103445] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x40
[    1.109765] tango_config_write: bus=0 where=82 size=2 val=0x84
[    1.115744] pci 0000:00:00.0: supports D1 D2
[    1.120130] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
[    1.126261] tango_config_write: bus=0 where=124 size=2 val=0xe008
[    1.132479] pci 0000:00:00.0: PME# disabled
[    1.136780] tango_config_write: bus=0 where=2096 size=4 val=0x10000000
[    1.143435] tango_config_write: bus=0 where=2064 size=4 val=0x0
[    1.149477] tango_config_write: bus=0 where=2052 size=4 val=0x0
[    1.155658] pci_bus 0000:00: fixups for bus
[    1.159966] tango_config_write: bus=0 where=62 size=2 val=0x21
[    1.165926] tango_config_write: bus=0 where=4 size=2 val=0x140
[    1.171884] tango_config_write: bus=0 where=12 size=1 val=0x10
[    1.177841] PCI: bus0: Fast back to back transfers disabled
[    1.183539] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
[    1.190372] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.198513] tango_config_write: bus=0 where=62 size=2 val=0x1
[    1.204384] tango_config_write: bus=0 where=24 size=4 val=0x0
[    1.210252] tango_config_write: bus=0 where=62 size=2 val=0x1
[    1.216122] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
[    1.222951] tango_config_write: bus=0 where=62 size=2 val=0x1
[    1.228819] tango_config_write: bus=0 where=6 size=2 val=0xffff
[    1.234940] pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-7f] (conflicts with (null) [bus 00-7f])
[    1.245879] tango_config_write: bus=0 where=24 size=4 val=0xff0100
[    1.252187] pci_bus 0000:01: scanning bus
[    1.256355] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
[    1.262509] tango_config_write: bus=1 where=16 size=4 val=0xffffffff
[    1.268994] tango_config_write: bus=1 where=16 size=4 val=0x4
[    1.274868] tango_config_write: bus=1 where=20 size=4 val=0xffffffff
[    1.281353] tango_config_write: bus=1 where=20 size=4 val=0x0
[    1.287227] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
[    1.294154] tango_config_write: bus=1 where=24 size=4 val=0xffffffff
[    1.300638] tango_config_write: bus=1 where=24 size=4 val=0x0
[    1.306513] tango_config_write: bus=1 where=28 size=4 val=0xffffffff
[    1.312996] tango_config_write: bus=1 where=28 size=4 val=0x0
[    1.318870] tango_config_write: bus=1 where=32 size=4 val=0xffffffff
[    1.325352] tango_config_write: bus=1 where=32 size=4 val=0x0
[    1.331226] tango_config_write: bus=1 where=36 size=4 val=0xffffffff
[    1.337708] tango_config_write: bus=1 where=36 size=4 val=0x0
[    1.343582] tango_config_write: bus=1 where=48 size=4 val=0xfffff800
[    1.350065] tango_config_write: bus=1 where=48 size=4 val=0x0
[    1.355953] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x40
[    1.362293] tango_config_write: bus=1 where=114 size=2 val=0x86
[    1.368352] tango_config_write: bus=1 where=146 size=2 val=0x7
[    1.374370] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    1.380591] tango_config_write: bus=1 where=84 size=2 val=0x8008
[    1.386723] pci 0000:01:00.0: PME# disabled
[    1.391041] tango_config_write: bus=1 where=272 size=4 val=0x0
[    1.396999] tango_config_write: bus=1 where=260 size=4 val=0x0
[    1.403081] tango_config_write: bus=1 where=176 size=2 val=0x0
[    1.409043] tango_config_write: bus=0 where=144 size=2 val=0x8
[    1.415001] tango_config_write: bus=0 where=144 size=2 val=0x28
[    1.429675] pci_bus 0000:01: fixups for bus
[    1.433978] tango_config_write: bus=1 where=4 size=2 val=0x140
[    1.439937] tango_config_write: bus=1 where=12 size=1 val=0x10
[    1.445893] PCI: bus1: Fast back to back transfers disabled
[    1.451588] pci_bus 0000:01: bus scan returning with max=01
[    1.457285] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    1.464027] tango_config_write: bus=0 where=26 size=1 val=0x1
[    1.469896] tango_config_write: bus=0 where=62 size=2 val=0x1
[    1.475764] pci_bus 0000:00: bus scan returning with max=01
[    1.481460] pci 0000:00:00.0: fixup irq: got 0
[    1.486018] pci 0000:00:00.0: assigning IRQ 00
[    1.490574] tango_config_write: bus=0 where=60 size=1 val=0x0
[    1.496467] pci 0000:01:00.0: fixup irq: got 20
[    1.501113] pci 0000:01:00.0: assigning IRQ 20
[    1.505670] tango_config_write: bus=1 where=60 size=1 val=0x14
[    1.511630] tango_config_write: bus=0 where=28 size=2 val=0xe0f0
[    1.517760] tango_config_write: bus=0 where=28 size=2 val=0x0
[    1.523628] tango_config_write: bus=0 where=36 size=4 val=0xffe0fff0
[    1.530107] tango_config_write: bus=0 where=36 size=4 val=0x0
[    1.535992] pci 0000:00:00.0: BAR 0: assigned [mem 0x58000000-0x58ffffff 64bit]
[    1.543436] tango_config_write: bus=0 where=4 size=2 val=0x140
[    1.549391] tango_config_write: bus=0 where=16 size=4 val=0x8000004
[    1.555782] tango_config_write: bus=0 where=20 size=4 val=0x0
[    1.561654] tango_config_write: bus=0 where=4 size=2 val=0x140
[    1.567612] pci 0000:00:00.0: BAR 8: assigned [mem 0x59000000-0x590fffff]
[    1.574534] pci 0000:01:00.0: BAR 0: assigned [mem 0x59000000-0x59001fff 64bit]
[    1.581977] tango_config_write: bus=1 where=4 size=2 val=0x140
[    1.587932] tango_config_write: bus=1 where=16 size=4 val=0x9000004
[    1.594326] tango_config_write: bus=1 where=20 size=4 val=0x0
[    1.600196] tango_config_write: bus=1 where=4 size=2 val=0x140
[    1.606153] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.611236] tango_config_write: bus=0 where=48 size=4 val=0xffff
[    1.617365] tango_config_write: bus=0 where=28 size=2 val=0xf0
[    1.623319] tango_config_write: bus=0 where=48 size=4 val=0x0
[    1.629188] pci 0000:00:00.0:   bridge window [mem 0x59000000-0x590fffff]
[    1.636105] tango_config_write: bus=0 where=32 size=4 val=0x9000900
[    1.642496] tango_config_write: bus=0 where=44 size=4 val=0x0
[    1.648363] tango_config_write: bus=0 where=36 size=4 val=0xfff0
[    1.654491] tango_config_write: bus=0 where=40 size=4 val=0x0
[    1.660358] tango_config_write: bus=0 where=44 size=4 val=0x0
[    1.666224] tango_config_write: bus=0 where=62 size=2 val=0x1
[    1.672142] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
[    1.678364] tango_config_write: bus=0 where=4 size=2 val=0x142
[    1.684325] tango_config_write: bus=0 where=136 size=2 val=0x2810
[    1.690549] pcieport 0000:00:00.0: enabling bus mastering
[    1.696068] tango_config_write: bus=0 where=4 size=2 val=0x146
[    1.702028] tango_config_write: bus=0 where=82 size=2 val=0x84
[    1.708045] msi_readl: reg=32 val=0xffffffff
[    1.712429] msi_writel: reg=32 val=0xffffffff
[    1.716907] altera-msi 2e080.msi: msi#0 address_hi 0x0 address_lo 0x802e07c
[    1.724001] tango_config_write: bus=0 where=82 size=2 val=0x84
[    1.729957] tango_config_write: bus=0 where=84 size=4 val=0x802e07c
[    1.736348] tango_config_write: bus=0 where=88 size=4 val=0x0
[    1.742215] tango_config_write: bus=0 where=92 size=2 val=0x0
[    1.748096] tango_config_write: bus=0 where=4 size=2 val=0x546
[    1.754052] tango_config_write: bus=0 where=82 size=2 val=0x85
[    1.760131] altera-msi 2e080.msi: msi#0 address_hi 0x0 address_lo 0x802e07c
[    1.767214] tango_config_write: bus=0 where=82 size=2 val=0x85
[    1.773160] tango_config_write: bus=0 where=84 size=4 val=0x802e07c
[    1.779542] tango_config_write: bus=0 where=88 size=4 val=0x0
[    1.785399] tango_config_write: bus=0 where=92 size=2 val=0x0
[    1.791303] tango_config_write: bus=0 where=138 size=2 val=0x20
[    1.797351] tango_config_write: bus=0 where=156 size=2 val=0x0
[    1.803308] tango_config_write: bus=0 where=2096 size=4 val=0x10000000
[    1.809966] tango_config_write: bus=0 where=2064 size=4 val=0x0
[    1.816009] tango_config_write: bus=0 where=2052 size=4 val=0x0
[    1.822059] tango_config_write: bus=0 where=136 size=2 val=0x281f
[    1.828278] tango_config_write: bus=0 where=2092 size=4 val=0x7
[    1.834324] aer 0000:00:00.0:pcie002: service driver aer loaded
[    1.840481] pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x7e0
[    1.847238] pci 0000:01:00.0: enabling device (0140 -> 0142)
[    1.853023] tango_config_write: bus=1 where=4 size=2 val=0x142
[    1.858989] quirk_usb_handoff_xhci: ioremap(0x59000000, 8192)
[    1.864873] xhci_find_next_ext_cap: offset=0x500
[    1.869606] val = 0x1000401
...
[    1.983798] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.990375] ehci-pci: EHCI PCI platform driver
[    1.995024] xhci_hcd 0000:01:00.0: enabling bus mastering
[    2.000472] tango_config_write: bus=1 where=4 size=2 val=0x146
[    2.006355] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    2.011635] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    2.024640] xhci_find_next_ext_cap: offset=0x500
[    2.029291] val = 0x1000401
[    2.032106] xhci_find_next_ext_cap: offset=0x510
[    2.036758] val = 0x3000502
[    2.039561] xhci_find_next_ext_cap: offset=0x510
[    2.044210] val = 0x3000502
[    2.047020] xhci_find_next_ext_cap: offset=0x524
[    2.051666] val = 0x2000702
[    2.054476] xhci_find_next_ext_cap: offset=0x524
[    2.059122] val = 0x2000702
[    2.061932] xhci_find_next_ext_cap: offset=0x540
[    2.066577] val = 0x4c0
[    2.069029] xhci_find_next_ext_cap: offset=0x550
[    2.073674] val = 0xa
[    2.075958] xhci_find_next_ext_cap: offset=0x510
[    2.080604] val = 0x3000502
[    2.083414] xhci_find_next_ext_cap: offset=0x524
[    2.088059] val = 0x2000702
[    2.090880] xhci_hcd 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x00000010
[    2.099377] xhci_hcd 0000:01:00.0: enabling Mem-Wr-Inval
[    2.104722] tango_config_write: bus=1 where=4 size=2 val=0x156
[    2.110602] tango_config_write: bus=1 where=146 size=2 val=0x7
[    2.116538] msi_readl: reg=32 val=0xffffffff
[    2.120837] msi_writel: reg=32 val=0xffffffff
[    2.125265] msi_readl: reg=32 val=0xffffffff
[    2.129563] msi_writel: reg=32 val=0xffffffff
[    2.133976] msi_readl: reg=32 val=0xffffffff
[    2.138273] msi_writel: reg=32 val=0xffffffff
[    2.142663] altera-msi 2e080.msi: msi#1 address_hi 0x0 address_lo 0x802e07c
[    2.149672] altera-msi 2e080.msi: msi#2 address_hi 0x0 address_lo 0x802e07c
[    2.156679] altera-msi 2e080.msi: msi#3 address_hi 0x0 address_lo 0x802e07c
[    2.163688] tango_config_write: bus=1 where=146 size=2 val=0xc007
[    2.169857] tango_config_write: bus=1 where=4 size=2 val=0x546
[    2.175731] tango_config_write: bus=1 where=146 size=2 val=0x8007
[    2.181869] altera-msi 2e080.msi: msi#1 address_hi 0x0 address_lo 0x802e07c
[    2.188911] altera-msi 2e080.msi: msi#2 address_hi 0x0 address_lo 0x802e07c
[    2.195942] altera-msi 2e080.msi: msi#3 address_hi 0x0 address_lo 0x802e07c
[    2.203146] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.209982] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.217251] usb usb1: Product: xHCI Host Controller
[    2.222160] usb usb1: Manufacturer: Linux 4.9.7-1-rc2 xhci-hcd
[    2.228028] usb usb1: SerialNumber: 0000:01:00.0
[    2.233153] hub 1-0:1.0: USB hub found
[    2.236974] hub 1-0:1.0: 4 ports detected
[    2.241291] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    2.246566] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    2.300870] xhci_hcd 0000:01:00.0: Host took too long to start, waited 16000 microseconds.
[    2.309196] xhci_hcd 0000:01:00.0: startup error -19
[    2.314197] xhci_hcd 0000:01:00.0: USB bus 2 deregistered
[    2.319648] xhci_hcd 0000:01:00.0: remove, state 1
[    2.324481] usb usb1: USB disconnect, device number 1
[    2.329944] tango_config_write: bus=1 where=146 size=2 val=0x7
[    2.335827] tango_config_write: bus=1 where=4 size=2 val=0x146
[    2.341714] msi_readl: reg=32 val=0xffffffff
[    2.346033] msi_writel: reg=32 val=0xfffffffd
[    2.350451] msi_readl: reg=32 val=0xfffffffd
[    2.354751] msi_writel: reg=32 val=0xfffffff9
[    2.359160] msi_readl: reg=32 val=0xfffffff9
[    2.363458] msi_writel: reg=32 val=0xfffffff1
[    2.367940] xhci_hcd 0000:01:00.0: USB bus 1 deregistered
[    2.373407] tango_config_write: bus=1 where=4 size=2 val=0x142
[    2.379518] usbcore: registered new interface driver usb-storage
[    2.386612] tangox-wdt 1fd00.watchdog: SMP86xx/SMP87xx watchdog registered
[    2.394077] sdhci: Secure Digital Host Controller Interface driver
[    2.400317] sdhci: Copyright(c) Pierre Ossman
[    2.404716] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.410751] NET: Registered protocol family 17
[    2.415307] Registering SWP/SWPB emulation handler
[    2.435762] Freeing unused kernel memory: 10240K (c0600000 - c1000000)


# /usr/sbin/lspci -v
00:00.0 PCI bridge: Sigma Designs, Inc. Device 0024 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Memory at 58000000 (64-bit, non-prefetchable) [size=16M]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 09000000-090fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Capabilities: [50] MSI: Enable+ Count=1/4 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Root Port (Slot-), MSI 03
        Capabilities: [100] Virtual Channel
        Capabilities: [800] Advanced Error Reporting
        Kernel driver in use: pcieport

01:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Controller (rev 03) (prog-if 30 [XHCI])
        Flags: fast devsel, IRQ 20
        Memory at 59000000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [50] Power Management version 3
        Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
        Capabilities: [90] MSI-X: Enable- Count=8 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [150] Latency Tolerance Reporting



# cat /proc/interrupts 
            CPU0       CPU1       
  19:       2728        631     GIC-0  29 Edge      twd
  20:        471          0      irq0   1 Level     serial
  25:          0          0  Altera PCIe MSI   0 Edge      aerdrv
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts
IPI2:        414       1190  Rescheduling interrupts
IPI3:          0         34  Function call interrupts
IPI4:          0          0  CPU stop interrupts
IPI5:          1          0  IRQ work interrupts
IPI6:          0          0  completion interrupts
 Err:          0


altera_msi_probe reported virq=22 for my platform interrupt 55,
thus no error, right? I expected interrupt 55 to appear in the
/proc/interrupts output. Is it hidden because of the chaining?

Nothing happens when I plug a USB Flash drive, but I suppose
that is expected given:

[    2.241291] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    2.246566] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    2.300870] xhci_hcd 0000:01:00.0: Host took too long to start, waited 16000 microseconds.
[    2.309196] xhci_hcd 0000:01:00.0: startup error -19
[    2.314197] xhci_hcd 0000:01:00.0: USB bus 2 deregistered
[    2.319648] xhci_hcd 0000:01:00.0: remove, state 1
[    2.324481] usb usb1: USB disconnect, device number 1


I suppose I need to figure out why.
Did anyone spot something obviously wrong?

Regards.
