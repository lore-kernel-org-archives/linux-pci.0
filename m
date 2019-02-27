Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687A4C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 15:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFE52183F
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 15:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfB0PbW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:31:22 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:44137 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730136AbfB0PbW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Feb 2019 10:31:22 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 9FF5413F89A;
        Wed, 27 Feb 2019 16:31:00 +0100 (CET)
Subject: Re: WIP: PCIe on MSM8998
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
References: <c97b6f4e-4b4c-027f-5a0b-80b3f7054177@free.fr>
Message-ID: <fb5f2b94-34b7-d021-7ac9-832b08138ad4@free.fr>
Date:   Wed, 27 Feb 2019 16:31:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c97b6f4e-4b4c-027f-5a0b-80b3f7054177@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/02/2019 17:54, Marc Gonzalez wrote:

> Next up: PCIe
> WIP changes on top of next-20190213:

FTR, this is just a work-in-progress status, not a formal submission.
(For anyone wanting to test)

I cherry-picked "phy: qcom: qmp: Add SDM845 PCIe QMP PHY support"
then I applied the following diff:

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f9a922fdae75..deeb616ff6f3 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -606,6 +606,101 @@
 			#thermal-sensor-cells = <1>;
 		};
 
+		pcie0: pci@1c00000 {
+			compatible = "qcom,pcie-msm8996";
+			reg-names =
+				"parf",
+				"dbi",
+				"elbi",
+				"config";
+			reg =
+				<0x01c00000 0x2000>,
+				<0x1b000000 0xf1d>,
+				<0x1b000f20 0xa8>,
+				<0x1b100000 0x100000>;
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			power-domains = <&gcc PCIE_0_GDSC>;
+
+			num-lanes = <1>;
+			phy-names = "pciephy";
+			phys = <&pciephy>;
+
+			ranges =
+			/*** downstream I/O ***/
+			<0x01000000 0x0 0x1b200000 0x1b200000 0x0 0x100000>,
+			/*** non-prefetchable memory ***/
+			<0x02000000 0x0 0x1b300000 0x1b300000 0x0 0xd00000>;
+
+			#interrupt-cells = <1>;
+			interrupt-names = "msi";
+			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map =
+				<0 0 0 1 &intc 0 135 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+				<0 0 0 2 &intc 0 136 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+				<0 0 0 3 &intc 0 138 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+				<0 0 0 4 &intc 0 139 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clock-names =
+				"pipe",
+				"bus_master",
+				"bus_slave",
+				"cfg",
+				"aux";
+			clocks =
+				<&gcc GCC_PCIE_0_PIPE_CLK>,
+				<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				<&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				<&gcc GCC_PCIE_0_AUX_CLK>;
+
+			/* PCIe Fundamental Reset */
+			perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+		};
+
+		phy@1c06000 {
+			compatible = "qcom,msm8998-qmp-pcie-phy";
+			reg = <0x01c06000 0x18c>;
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clock-names =
+				"aux",
+				"cfg_ahb",
+				"ref";
+			clocks =
+				<&gcc GCC_PCIE_PHY_AUX_CLK>,
+				<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				<&gcc GCC_PCIE_CLKREF_CLK>;
+
+			vdda-phy-supply = <&vreg_l1a_0p875>;
+			vdda-pll-supply = <&vreg_l2a_1p2>;
+
+			reset-names =
+				"phy",
+				"common",
+				"cfg";
+			resets =
+				<&gcc GCC_PCIE_PHY_BCR>,
+				<&gcc GCC_PCIE_PHY_COM_BCR>,
+				<&gcc GCC_PCIE_PHY_NOCSR_COM_PHY_BCR>;
+
+			pciephy: lane@1c06800 {
+				reg = <0x01c06200 0x128>, <0x01c06400 0x1fc>, <0x01c06800 0x20c>;
+				#phy-cells = <0>;
+
+				clock-names = "pipe0";
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+				clock-output-names = "pcie_0_pipe_clk_src";
+			};
+		};
+
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
 			reg = <0x1f40000 0x20000>;
diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index 3cbabbb8bd9a..cdd97c840b07 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -2161,7 +2161,7 @@ static struct clk_branch gcc_pcie_0_mstr_axi_clk = {
 
 static struct clk_branch gcc_pcie_0_pipe_clk = {
 	.halt_reg = 0x6b018,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x6b018,
 		.enable_mask = BIT(0),
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index c5ca4a217439..ae2752a60105 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1297,6 +1297,31 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
 	.no_pcs_sw_reset	= true,
 };
 
+static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
+	.type			= PHY_TYPE_PCIE,
+	.nlanes			= 1,
+
+	.serdes_tbl		= sdm845_pcie_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sdm845_pcie_serdes_tbl),
+	.tx_tbl			= sdm845_pcie_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sdm845_pcie_tx_tbl),
+	.rx_tbl			= sdm845_pcie_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sdm845_pcie_rx_tbl),
+	.pcs_tbl		= sdm845_pcie_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sdm845_pcie_pcs_tbl),
+	.clk_list		= msm8996_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(msm8996_phy_clk_l),
+	.reset_list		= msm8996_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= pciephy_regs_layout,
+
+	.start_ctrl             = SERDES_START | PCS_START,
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.mask_com_pcs_ready	= PCS_READY,
+};
+
 static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
 	.type                   = PHY_TYPE_USB3,
 	.nlanes                 = 1,
@@ -2029,6 +2054,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,msm8996-qmp-usb3-phy",
 		.data = &msm8996_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,msm8998-qmp-pcie-phy",
+		.data = &msm8998_pciephy_cfg,
 	}, {
 		.compatible = "qcom,msm8998-qmp-ufs-phy",
 		.data = &sdm845_ufsphy_cfg,



Booting Linux on physical CPU 0x0000000000 [0x51af8014]
Linux version 5.0.0-rc6-next-20190213 (mgonzalez@venus) (gcc version 7.3.1 20180425 [linaro-7.3-2018.05 revision d29120a424ecfbc167ef90065c0eeb7f91977701] (Linaro GCC 7.3-2018.05)) #93 SMP PREEMPT Wed Feb 27 16:24:12 CET 2019
Machine model: Qualcomm Technologies, Inc. MSM8998 v1 MTP
On node 0 totalpages: 1026752
  DMA32 zone: 8192 pages used for memmap
  DMA32 zone: 0 pages reserved
  DMA32 zone: 509696 pages, LIFO batch:63
  Normal zone: 8079 pages used for memmap
  Normal zone: 517056 pages, LIFO batch:63
psci: probing for conduit method from DT.
psci: PSCIv1.0 detected in firmware.
psci: Using standard PSCI v0.2 function IDs
psci: MIGRATE_INFO_TYPE not supported.
psci: SMC Calling Convention v1.0
random: get_random_bytes called from start_kernel+0xa4/0x43c with crng_init=0
percpu: Embedded 20 pages/cpu @(____ptrval____) s43480 r8192 d30248 u81920
pcpu-alloc: s43480 r8192 d30248 u81920 alloc=20*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
Detected VIPT I-cache on CPU0
CPU features: detected: GIC system register CPU interface
CPU features: detected: Kernel page table isolation (KPTI)
Built 1 zonelists, mobility grouping on.  Total pages: 1010481
Kernel command line: loglevel=0 androidboot.bootdevice=1da4000.ufshc androidboot.serialno=53733c35 androidboot.baseband=apq mdss_mdp.panel=1:hdmi:16
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
software IO TLB: mapped [mem 0xfbfff000-0xfffff000] (64MB)
Memory: 3947848K/4107008K available (3646K kernel code, 306K rwdata, 960K rodata, 6272K init, 1169K bss, 159160K reserved, 0K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
rcu: Preemptible hierarchical RCU implementation.
rcu:    RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
        Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
GICv3: Distributor has no Range Selector support
GICv3: no VLPI support, no direct LPI support
GICv3: CPU0: found redistributor 0 region 0:0x0000000017b00000
ITS: No ITS available, not enabling LPIs
arch_timer: cp15 and mmio timer(s) running at 19.20MHz (virt/virt).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
Console: colour dummy device 80x25
printk: console [tty0] enabled
Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=76800)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
*** VALIDATE proc ***
ASID allocator initialised with 32768 entries
rcu: Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
Detected VIPT I-cache on CPU1
GICv3: CPU1: found redistributor 1 region 0:0x0000000017b20000
CPU1: Booted secondary processor 0x0000000001 [0x51af8014]
Detected VIPT I-cache on CPU2
GICv3: CPU2: found redistributor 2 region 0:0x0000000017b40000
CPU2: Booted secondary processor 0x0000000002 [0x51af8014]
Detected VIPT I-cache on CPU3
GICv3: CPU3: found redistributor 3 region 0:0x0000000017b60000
CPU3: Booted secondary processor 0x0000000003 [0x51af8014]
Detected VIPT I-cache on CPU4
CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
CPU features: Unsupported CPU feature variation detected.
GICv3: CPU4: found redistributor 100 region 0:0x0000000017b80000
CPU4: Booted secondary processor 0x0000000100 [0x51af8001]
Detected VIPT I-cache on CPU5
CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU5: 0x00000000101122
GICv3: CPU5: found redistributor 101 region 0:0x0000000017ba0000
CPU5: Booted secondary processor 0x0000000101 [0x51af8001]
Detected VIPT I-cache on CPU6
CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU6: 0x00000000101122
GICv3: CPU6: found redistributor 102 region 0:0x0000000017bc0000
CPU6: Booted secondary processor 0x0000000102 [0x51af8001]
Detected VIPT I-cache on CPU7
CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU7: 0x00000000101122
GICv3: CPU7: found redistributor 103 region 0:0x0000000017be0000
CPU7: Booted secondary processor 0x0000000103 [0x51af8001]
smp: Brought up 1 node, 8 CPUs
SMP: Total of 8 processors activated.
CPU features: detected: 32-bit EL0 Support
CPU features: detected: CRC32 instructions
CPU: All CPU(s) started at EL1
alternatives: patching kernel code
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
futex hash table entries: 2048 (order: 5, 131072 bytes)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
vdso: 2 pages (1 code @ (____ptrval____), 1 data @ (____ptrval____))
DMA: preallocated 256 KiB pool for atomic allocations
vgaarb: loaded
clocksource: Switched to clocksource arch_sys_counter
s1: supplied by vph_pwr
s2: supplied by vph_pwr
NET: Registered protocol family 2
s3: supplied by vph_pwr
s3: Bringing 0uV into 1352000-1352000uV
s4: supplied by vph_pwr
s4: Bringing 0uV into 1800000-1800000uV
s5: supplied by vph_pwr
s5: Bringing 0uV into 1904000-1904000uV
tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes)
s6: supplied by vph_pwr
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
s7: supplied by vph_pwr
s7: Bringing 0uV into 900000-900000uV
s8: supplied by vph_pwr
s9: supplied by vph_pwr
s10: supplied by vph_pwr
s11: supplied by vph_pwr
s12: supplied by vph_pwr
s13: supplied by vph_pwr
l1: supplied by s7
l1: Bringing 0uV into 880000-880000uV
TCP: Hash tables configured (established 32768 bind 32768)
l2: supplied by s3
l2: Bringing 0uV into 1200000-1200000uV
l3: supplied by s7
UDP hash table entries: 2048 (order: 4, 65536 bytes)
l3: Bringing 0uV into 1000000-1000000uV
UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
l4: supplied by s7
l5: supplied by s7
NET: Registered protocol family 1
l5: Bringing 0uV into 800000-800000uV
PCI: CLS 0 bytes, default 64
l6: supplied by s5
l6: Bringing 0uV into 1808000-1808000uV
l7: supplied by s5
l7: Bringing 0uV into 1800000-1800000uV
l8: supplied by s3
l8: Bringing 0uV into 1200000-1200000uV
l9: Bringing 0uV into 1808000-1808000uV
l10: Bringing 0uV into 1808000-1808000uV
l11: supplied by s7
l11: Bringing 0uV into 1000000-1000000uV
l12: supplied by s5
l12: Bringing 0uV into 1800000-1800000uV
l13: Bringing 0uV into 1808000-1808000uV
l14: supplied by s5
l14: Bringing 0uV into 1880000-1880000uV
l15: supplied by s5
l15: Bringing 0uV into 1800000-1800000uV
l16: Bringing 0uV into 2704000-2704000uV
l17: supplied by s3
l17: Bringing 0uV into 1304000-1304000uV
l18: Bringing 0uV into 2704000-2704000uV
l19: Bringing 0uV into 3008000-3008000uV
l20: Bringing 0uV into 2960000-2960000uV
l21: Bringing 0uV into 2960000-2960000uV
l22: Bringing 0uV into 2864000-2864000uV
l23: Bringing 0uV into 3312000-3312000uV
l24: Bringing 0uV into 3088000-3088000uV
l25: Bringing 0uV into 3104000-3104000uV
l26: supplied by s3
l26: Bringing 0uV into 1200000-1200000uV
l27: supplied by s7
l28: Bringing 0uV into 3008000-3008000uV
lvs1: supplied by s4
lvs2: supplied by s4
bob: supplied by vph_pwr
bob: Bringing 0uV into 3312000-3312000uV
workingset: timestamp_bits=62 max_order=20 bucket_order=0
qcom-qmp-phy 1c06000.phy: Registered Qcom-QMP phy
qcom-qmp-phy c010000.phy: Registered Qcom-QMP phy
qcom-pcie 1c00000.pci: 1c00000.pci supply vdda not found, using dummy regulator
qcom-pcie 1c00000.pci: 1c00000.pci supply vddpe-3v3 not found, using dummy regulator
qcom-pcie 1c00000.pci: host bridge /soc/pci@1c00000 ranges:
qcom-pcie 1c00000.pci: Parsing ranges property...
qcom-pcie 1c00000.pci:    IO 0x1b200000..0x1b2fffff -> 0x1b200000
qcom-pcie 1c00000.pci:   MEM 0x1b300000..0x1bffffff -> 0x1b300000
qcom_ep_reset_assert: ENTER reset=ffffffc0f8dd2460
qcom_ep_reset_deassert: ENTER reset=ffffffc0f8dd2460
qcom-pcie 1c00000.pci: Link up
qcom-pcie 1c00000.pci: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0x1b200000-0x1b2fffff])
pci_bus 0000:00: root bus resource [mem 0x1b300000-0x1bffffff]
pci_bus 0000:00: scanning bus
pci 0000:00:00.0: [17cb:0105] type 01 class 0x060400
pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
pci 0000:00:00.0: PME# supported from D0 D3hot
pci 0000:00:00.0: PME# disabled
pci_bus 0000:00: fixups for bus
pci 0000:00:00.0: scanning [bus 01-ff] behind bridge, pass 0
pci_bus 0000:01: scanning bus
pci 0000:01:00.0: [1969:1083] type 00 class 0x020000
pci 0000:01:00.0: reg 0x10: [mem 0x1b300000-0x1b33ffff 64bit]
pci 0000:01:00.0: reg 0x18: [io  0x1000-0x107f]
pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:01:00.0: PME# disabled
pci_bus 0000:01: fixups for bus
pci_bus 0000:01: bus scan returning with max=01
pci 0000:00:00.0: scanning [bus 01-ff] behind bridge, pass 1
pci_bus 0000:00: bus scan returning with max=ff
pci 0000:00:00.0: BAR 8: assigned [mem 0x1b300000-0x1b3fffff]
pci 0000:00:00.0: BAR 0: assigned [mem 0x1b400000-0x1b400fff 64bit]
pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:01:00.0: BAR 0: assigned [mem 0x1b300000-0x1b33ffff 64bit]
pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x107f]
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:00.0:   bridge window [mem 0x1b300000-0x1b3fffff]
pcieport 0000:00:00.0: assign IRQ: got 0
pcieport 0000:00:00.0: Signaling PME with IRQ 19
aer 0000:00:00.0:pcie002: AER enabled with IRQ 19
pci 0000:01:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
msm_serial c1b0000.serial: msm_serial: detected port #0
msm_serial c1b0000.serial: uartclk = 1843200
c1b0000.serial: ttyMSM0 at MMIO 0xc1b0000 (irq = 18, base_baud = 115200) is a MSM
msm_serial: console setup on port #0
printk: console [ttyMSM0] enabled
msm_serial: driver initialized
atl1c 0000:01:00.0: assign IRQ: got 0
atl1c 0000:01:00.0: enabling device (0000 -> 0002)
atl1c 0000:01:00.0: enabling bus mastering
atl1c 0000:01:00.0: version 1.0.1.1-NAPI
NET: Registered protocol family 17
l9: supplied by bob
l10: supplied by bob
l13: supplied by bob
l16: supplied by bob
l18: supplied by bob
l19: supplied by bob
l20: supplied by bob
l21: supplied by bob
l22: supplied by bob
l23: supplied by bob
l24: supplied by bob
l25: supplied by bob
l28: supplied by bob
Freeing unused kernel memory: 6272K


# lspci -vvv >foo
pcilib: sysfs_read_vpd: read failed: Input/output error

# cat foo
00:00.0 PCI bridge: Qualcomm Device 0105 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at 1b400000 (64-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
        I/O behind bridge: 00001000-00001fff [size=4K]
        Memory behind bridge: 1b300000-1b3fffff [size=1M]
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [empty]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/32 Maskable+ 64bit+
                Address: 00000000fbfff000  Data: 0000
                Masking: fffffffe  Pending: 00000000
        Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd-
                         AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
                         AtomicOpsCtl: ReqEn- EgressBlck-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
                RootCmd: CERptEn+ NFERptEn+ FERptEn+
                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
        Capabilities: [148 v1] Transaction Processing Hints
                No steering table available
        Capabilities: [1dc v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=70us PortTPowerOnTime=0us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=70us LTR1.2_Threshold=0ns
                L1SubCtl2: T_PwrOn=10us
        Kernel driver in use: pcieport

01:00.0 Ethernet controller: Qualcomm Atheros AR8151 v2.0 Gigabit Ethernet (rev c0)
        Subsystem: Qualcomm Atheros AR8151 v2.0 Gigabit Ethernet
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 1b300000 (64-bit, non-prefetchable) [size=256K]
        Region 2: I/O ports at 1000 [size=128]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 4096 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                        ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset- SlotPowerLimit 0.000W
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [6c] Vital Product Data
                Not readable
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [180 v1] Device Serial Number ff-18-e3-90-72-d3-42-ff
        Kernel driver in use: atl1c
