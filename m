Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5AFC43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 16:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BF2217D9
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 16:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfBSQzE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:55:04 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:8791 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfBSQzD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Feb 2019 11:55:03 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id D0AAC13F8DE;
        Tue, 19 Feb 2019 17:54:43 +0100 (CET)
To:     MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: WIP: PCIe on MSM8998
Message-ID: <c97b6f4e-4b4c-027f-5a0b-80b3f7054177@free.fr>
Date:   Tue, 19 Feb 2019 17:54:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

Next up: PCIe

WIP changes on top of next-20190213:

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f9a922fdae75..1152d11f081e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -970,6 +970,80 @@
 			};
 		};
 
+		phy@1c06000 {
+			compatible = "qcom,msm8996-qmp-pcie-phy";
+			reg = <0x1c06000 0x1000>;
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+				<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				<&gcc GCC_PCIE_CLKREF_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref";
+
+			vdda-phy-supply = <&vreg_l1a_0p875>;
+			vdda-pll-supply = <&vreg_l2a_1p2>;
+
+			resets = <&gcc GCC_PCIE_PHY_BCR>,
+				<&gcc GCC_PCIE_PHY_COM_BCR>,
+				<&gcc GCC_PCIE_PHY_NOCSR_COM_PHY_BCR>;
+			reset-names = "phy", "common", "cfg";
+
+			pciephy: lane@35000 {
+				reg = <0x1c07000 0x200>, <0x1c07200 0x200>, <0x1c07400 0x200>;
+				#phy-cells = <0>;
+
+				clock-output-names = "pcie_0_pipe_clk_src";
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+				clock-names = "pipe0";
+				resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+				reset-names = "lane0";
+			};
+		};
+
+		pcie0: pci@1b000000 {
+			compatible = "qcom,pcie-msm8996";
+			reg =	<0x1b000000 0xf1d>,
+				<0x1b000f20 0xa8>,
+				<0x1c00000 0x2000>,
+				<0x1b100000 0x100000>;
+			reg-names = "dbi", "elbi", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			power-domains = <&gcc PCIE_0_GDSC>;
+
+			phys = <&pciephy>;
+			phy-names = "pciephy";
+
+			ranges =
+			/*** downstream I/O ***/
+			<0x01000000 0x0 0x1b200000 0x1b200000 0x0 0x100000>,
+			/*** non-prefetchable memory ***/
+			<0x02000000 0x0 0x1b300000 0x1b300000 0x0 0xd00000>;
+
+			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 135 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 136 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 138 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 139 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_AUX_CLK>;
+			clock-names = "pipe", "bus_master", "bus_slave", "cfg", "aux";
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			reg = <0x17a00000 0x10000>,       /* GICD */
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





Current situation: HANG + REBOOT :-)
Probably some silly typo in an address in my DT. Investigating...

# modprobe phy-qcom-qmp
REMAP: PA=0c010000 VA=ffffff8010005000 SIZE=18c
REMAP: PA=0c010200 VA=ffffff801000d200 SIZE=128
REMAP: PA=0c010400 VA=ffffff801002d400 SIZE=200
REMAP: PA=0c010c00 VA=ffffff8010035c00 SIZE=20c
REMAP: PA=0c010600 VA=ffffff8010051600 SIZE=128
REMAP: PA=0c010800 VA=ffffff8010053800 SIZE=200
qcom-qmp-phy c010000.phy: PHY pcs_misc-reg not used
qcom-qmp-phy c010000.phy: Registered Qcom-QMP phy
[    CLK_BASE + 6b004] = 00282000
REMAP: PA=01c00000 VA=ffffff8010b72000 SIZE=2000
REMAP: PA=01c06000 VA=ffffff8010055000 SIZE=1000
REMAP: PA=1b000000 VA=ffffff801005d000 SIZE=f1d
REMAP: PA=01c07000 VA=ffffff8010065000 SIZE=200
REMAP: PA=1b000f20 VA=ffffff801006df20 SIZE=a8
REMAP: PA=01c07200 VA=ffffff8010075200 SIZE=200
[    CLK_BASE + 6b004] = a0282001
REMAP: PA=01c07400 VA=ffffff801007d400 SIZE=200
qcom-qmp-phy 1c06000.phy: PHY pcs_misc-reg not used
qcom-qmp-phy 1c06000.phy: Registered Qcom-QMP phy
[    CLK_BASE + 6b004] = 00282000
REMAP: PA=01c00000 VA=ffffff8010d02000 SIZE=2000
REMAP: PA=1b000000 VA=ffffff801005d000 SIZE=f1d
REMAP: PA=1b000f20 VA=ffffff801006df20 SIZE=a8
qcom-pcie 1b000000.pci: 1b000000.pci supply vdda not found, using dummy regulator
qcom-pcie 1b000000.pci: 1b000000.pci supply vddpe-3v3 not found, using dummy regulator
qcom-qmp-phy 1c06000.phy: Initializing QMP phy
[    CLK_BASE + 6f000] = 00000001
[    CLK_BASE + 6f014] = 00000001
[    CLK_BASE + 6f00c] = 00000001
[    CLK_BASE + 6f00c] = 00000000
[    CLK_BASE + 6f014] = 00000000
[    CLK_BASE + 6f000] = 00000000
[    CLK_BASE + 6f004] = 80000001
[    CLK_BASE + 6b010] = 80008001
[    CLK_BASE + 8800c] = 80000001
[    PCIE_DBI + 00404] = 0000000b
[    PCIE_DBI + 00034] = 0000001c
[    PCIE_DBI + 00038] = 00000010
[    PCIE_DBI + 00174] = 00000033
[    PCIE_DBI + 00194] = 00000006
[    PCIE_DBI + 000c8] = 00000042
[    PCIE_DBI + 00128] = 00000000
[    PCIE_DBI + 00144] = 000000ff
[    PCIE_DBI + 00148] = 0000001f
[    PCIE_DBI + 00178] = 00000001
[    PCIE_DBI + 0019c] = 00000001
[    PCIE_DBI + 0018c] = 00000000
[    PCIE_DBI + 00184] = 0000000a
[    PCIE_DBI + 0000c] = 00000009
[    PCIE_DBI + 000d0] = 00000082
[    PCIE_DBI + 000e4] = 00000003
[    PCIE_DBI + 000e0] = 00000055
[    PCIE_DBI + 000dc] = 00000055
[    PCIE_DBI + 00054] = 00000000
[    PCIE_DBI + 00050] = 0000001a
[    PCIE_DBI + 0004c] = 0000000a
[    PCIE_DBI + 00174] = 00000033
[    PCIE_DBI + 0003c] = 00000002
[    PCIE_DBI + 00040] = 0000001f
[    PCIE_DBI + 000ac] = 00000004
[    PCIE_DBI + 00078] = 0000000b
[    PCIE_DBI + 00084] = 00000016
[    PCIE_DBI + 00090] = 00000028
[    PCIE_DBI + 0010c] = 00000000
[    PCIE_DBI + 00108] = 00000080
[    PCIE_DBI + 00010] = 00000001
[    PCIE_DBI + 0001c] = 00000031
[    PCIE_DBI + 00020] = 00000001
[    PCIE_DBI + 00014] = 00000002
[    PCIE_DBI + 00018] = 00000000
[    PCIE_DBI + 00024] = 0000002f
[    PCIE_DBI + 00028] = 00000019
[    PCIE_DBI + 000c4] = 00000015
[    PCIE_DBI + 00070] = 0000000f
[    PCIE_DBI + 00048] = 0000000f
[    PCIE_DBI + 00074] = 00000019
[    PCIE_DBI + 00038] = 00000010
[    PCIE_DBI + 00178] = 00000000
[    PCIE_DBI + 000c4] = 00000040
[    PCIE_DBI + 00400] = 0000000a
[    PCIE_DBI + 00408] = 0000000b
[    CLK_BASE + 6b018] = 80004001
[    PCIE_DBI + 00068] = 00000045
[    PCIE_DBI + 00094] = 00000006
[    01c07200 + 00110] = 0000001c
[    01c07200 + 000d8] = 00000001
[    01c07200 + 000dc] = 00000000
[    01c07200 + 000e0] = 000000db
[    01c07200 + 00120] = 00000018
[    01c07200 + 0001c] = 00000004
[    01c07200 + 00010] = 00000004
[    01c07200 + 00048] = 0000004b
[    01c07200 + 0011c] = 00000014
[    01c07200 + 00118] = 00000019
[    01c07400 + 00058] = 0000004c
[    01c07400 + 000a0] = 00000000
[    01c07400 + 000a4] = 00000001
[    01c07400 + 000a8] = 00000005
[    01c07400 + 00054] = 00000005
[    01c07400 + 00004] = 00000002
[    01c07400 + 0006c] = 00000000
[    01c07400 + 00060] = 000000a3
[    01c07400 + 00028] = 0000000e
[    01c07400 + 00004] = 00000003
[    01c07400 + 00000] = 00000000
[    01c07400 + 00008] = 0000000a
qcom-pcie 1b000000.pci: host bridge /soc/pci@1b000000 ranges:
qcom-pcie 1b000000.pci: Parsing ranges property...
qcom-pcie 1b000000.pci:    IO 0x1b200000..0x1b2fffff -> 0x1b200000
qcom-pcie 1b000000.pci:   MEM 0x1b300000..0x1bffffff -> 0x1b300000
REMAP: PA=1b100000 VA=ffffff8011400000 SIZE=80000
REMAP: PA=1b180000 VA=ffffff8011500000 SIZE=80000
[    CLK_BASE + 6b014] = 80000001
[    CLK_BASE + 6b00c] = 80004221
[    CLK_BASE + 6b008] = 8000c221
[   PCIE_PARF + 00040] = 00000000
[   PCIE_PARF + 00168] = 00000000
[   PCIE_PARF + 00000] = 00000000
[   PCIE_PARF + 00174] = 00000010
[   PCIE_PARF + 001a8] = 80000000
dw_pcie_read: addr=ffffff801005d710 size=4
Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
Modules linked in: phy_qcom_qmp
CPU: 2 PID: 101 Comm: kworker/2:1 Tainted: G S                5.0.0-rc6-next-20190213 #13
Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
Workqueue: events deferred_probe_work_func
pstate: 60000005 (nZCv daif -PAN -UAO)
pc : dw_pcie_read+0x90/0x110
lr : dw_pcie_read+0x38/0x110
sp : ffffff801120ba10
x29: ffffff801120ba10 x28: 0000000000000000 
x27: ffffffc098ab9d80 x26: ffffffc0a5cd46b8 
x25: ffffffc0a5cd46b8 x24: ffffff8010a18000 
x23: ffffffc0a5cd4400 x22: 0000000000000000 
x21: ffffff801120ba64 x20: 0000000000000004 
x19: ffffff801005d710 x18: ffffffffffffffff 
x17: 0000000000000000 x16: 0000000000000000 
x15: ffffff8010a18508 x14: 0720072007200720 
x13: 0720072007200720 x12: 0720072007200720 
x11: 0720072007200720 x10: 0720072007200720 
x9 : 0720072007200720 x8 : 000000000000017b 
x7 : 0720072007200720 x6 : ffffffc0f843bf00 
x5 : 0000000000000000 x4 : 0000000000000000 
x3 : 0000000000000001 x2 : d73a0bc4b3dd9300 
x1 : 0000000000000000 x0 : 0000000000000003 
Process kworker/2:1 (pid: 101, stack limit = 0x(____ptrval____))
Call trace:
 dw_pcie_read+0x90/0x110
 __dw_pcie_read_dbi+0x70/0xa0
 dw_pcie_setup+0x60/0x160
 dw_pcie_setup_rc+0x38/0x360
 qcom_pcie_host_init+0xbc/0x160
 dw_pcie_host_init+0x248/0x510
 qcom_pcie_probe+0x20c/0x250
 platform_drv_probe+0x50/0xa0
 really_probe+0x20c/0x2c0
 driver_probe_device+0x58/0x100
 __device_attach_driver+0x90/0xd0
 bus_for_each_drv+0x64/0xd0
 __device_attach+0xd8/0x140
 device_initial_probe+0x10/0x20
 bus_probe_device+0x90/0xa0
 deferred_probe_work_func+0x74/0xb0
 process_one_work+0x1e0/0x320
 worker_thread+0x40/0x450
 kthread+0x118/0x120
 ret_from_fork+0x10/0x20
Code: a94153f3 f94013f5 a8c37bfd d65f03c0 (b9400273) 
---[ end trace f9304c55055774a4 ]---
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:    (detected by 3, t=5252 jiffies, g=-567, q=4)
rcu: All QSes seen, last rcu_preempt kthread activity 5236 (4294903741-4294898505), jiffies_till_next_fqs=1, root ->qsmask 0x0
swapper/3       R  running task        0     0      1 0x00000008
Call trace:
 dump_backtrace+0x0/0x150
 show_stack+0x14/0x20
 sched_show_task+0x104/0x140
 rcu_sched_clock_irq+0x8c0/0x930
 update_process_times+0x2c/0x60
 tick_sched_handle.isra.5+0x30/0x50
 tick_sched_timer+0x54/0xb0
 __hrtimer_run_queues+0x120/0x1c0
 hrtimer_interrupt+0xdc/0x250
 arch_timer_handler_virt+0x28/0x40
 handle_percpu_devid_irq+0x94/0x150
 generic_handle_irq+0x24/0x40
 __handle_domain_irq+0x84/0xf0
 gic_handle_irq+0x90/0x1ac
 el1_irq+0xb8/0x180
 arch_cpu_idle+0x1c/0x30
 default_idle_call+0x1c/0x38
 do_idle+0xc4/0x160
 cpu_startup_entry+0x20/0x30
 secondary_start_kernel+0x178/0x1c0
rcu: rcu_preempt kthread starved for 5236 jiffies! g-567 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R    0    10      2 0x00000008
Call trace:
 __switch_to+0x174/0x1e0
 __schedule+0x1cc/0x4c0
 schedule+0x2c/0x80
 schedule_timeout+0x8c/0x3a0
 rcu_gp_kthread+0x4b4/0x840
 kthread+0x118/0x120
 ret_from_fork+0x10/0x20
