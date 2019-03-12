Return-Path: <SRS0=lIFx=RP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0588C43381
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 16:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C3B2054F
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 16:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfCLQAS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:00:18 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:57133 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfCLQAS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Mar 2019 12:00:18 -0400
Received: from [192.168.108.8] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 258F913F8FC;
        Tue, 12 Mar 2019 16:59:55 +0100 (CET)
Subject: Re: WIP: PCIe on MSM8998
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <c97b6f4e-4b4c-027f-5a0b-80b3f7054177@free.fr>
 <fb5f2b94-34b7-d021-7ac9-832b08138ad4@free.fr>
Message-ID: <6041e92f-4dbf-c6ce-d92a-220fc8239acb@free.fr>
Date:   Tue, 12 Mar 2019 16:59:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <fb5f2b94-34b7-d021-7ac9-832b08138ad4@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27/02/2019 16:31, Marc Gonzalez wrote:

> FTR, this is just a work-in-progress status, not a formal submission.

I still can't get the ethernet card to play ball. As soon as I set the link up,
the system hangs a few seconds, then reboots.

Here are the relevant DT nodes:
(There's probably an error or 12 lurking in there)

		anoc1_smmu: arm,smmu@1680000 {
			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
			reg = <0x01680000 0x10000>;
			#iommu-cells = <0>;

			#global-interrupts = <0>;
			interrupts =
				<GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
				<GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
				<GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
				<GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
				<GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
				<GIC_SPI 369 IRQ_TYPE_EDGE_RISING>;

		};

		pcie0: pci@1c00000 {
			compatible = "qcom,pcie-msm8996";
			reg-names =
				"parf",
				"dbi",
				"elbi",
				"config";
			reg =
				<0x01c00000 0x2000>,
				<0x1b000000 0xf1d>,
				<0x1b000f20 0xa8>,
				<0x1b100000 0x100000>;
			device_type = "pci";
			linux,pci-domain = <0>;
			bus-range = <0x00 0xff>;
			#address-cells = <3>;
			#size-cells = <2>;
			power-domains = <&gcc PCIE_0_GDSC>;

			num-lanes = <1>;
			phy-names = "pciephy";
			phys = <&pciephy>;

			ranges =
			/*** downstream I/O ***/
			<0x01000000 0x0 0x1b200000 0x1b200000 0x0 0x100000>,
			/*** non-prefetchable memory ***/
			<0x02000000 0x0 0x1b300000 0x1b300000 0x0 0xd00000>;

			#interrupt-cells = <1>;
			interrupt-names = "msi";
			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
			interrupt-map-mask = <0 0 0 0x7>;
			interrupt-map =
				<0 0 0 1 &intc 0 135 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
				<0 0 0 2 &intc 0 136 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
				<0 0 0 3 &intc 0 138 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
				<0 0 0 4 &intc 0 139 IRQ_TYPE_LEVEL_HIGH>; /* int_d */

			clock-names =
				"pipe",
				"bus_master",
				"bus_slave",
				"cfg",
				"aux";
			clocks =
				<&gcc GCC_PCIE_0_PIPE_CLK>,
				<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
				<&gcc GCC_PCIE_0_SLV_AXI_CLK>,
				<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
				<&gcc GCC_PCIE_0_AUX_CLK>;

			iommu-map = <0 &anoc1_smmu 0 1>;
			iommu-map-mask = <0>;

			/* PCIe Fundamental Reset */
			perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
		};

		phy@1c06000 {
			compatible = "qcom,msm8998-qmp-pcie-phy";
			reg = <0x01c06000 0x18c>;
			#clock-cells = <1>;
			#address-cells = <1>;
			#size-cells = <1>;
			ranges;

			clock-names =
				"aux",
				"cfg_ahb",
				"ref";
			clocks =
				<&gcc GCC_PCIE_PHY_AUX_CLK>,
				<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
				<&gcc GCC_PCIE_CLKREF_CLK>;

			vdda-phy-supply = <&vreg_l1a_0p875>;
			vdda-pll-supply = <&vreg_l2a_1p2>;

			reset-names =
				"phy",
				"common",
				"cfg";
			resets =
				<&gcc GCC_PCIE_PHY_BCR>,
				<&gcc GCC_PCIE_PHY_COM_BCR>,
				<&gcc GCC_PCIE_PHY_NOCSR_COM_PHY_BCR>;

			pciephy: lane@1c06800 {
				reg = <0x01c06200 0x128>, <0x01c06400 0x1fc>, <0x01c06800 0x20c>;
				#phy-cells = <0>;

				clock-names = "pipe0";
				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
				clock-output-names = "pcie_0_pipe_clk_src";
			};
		};



And here's the boot log, augmented with some custom stack dumps:
https://pastebin.ubuntu.com/p/2PYTtnBfPV/


What stands out:

pci 0000:01:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)

OF: /soc/pci@1c00000: iommu-map, using mask 00000000, rid-base: 00000000, out-base: 00000000, length: 00000001, rid: 00000000 -> 00000000
OF: /soc/pci@1c00000: iommu-map, using mask 00000000, rid-base: 00000000, out-base: 00000000, length: 00000001, rid: 00000100 -> 00000000
OF: /soc/pci@1c00000: iommu-map, using mask 00000000, rid-base: 00000000, out-base: 00000000, length: 00000001, rid: 00000000 -> 00000000
	(no idea what "out-base" is supposed to be set to)

atl1c 0000:01:00.0: Adding to iommu group 0
atl1c 0000:01:00.0: assign IRQ: got 0

iommu_map | iommu_map_sg | iommu_dma_alloc | __iommu_alloc_attrs | dma_alloc_attrs | atl1c_open | __dev_open | __dev_change_flags | dev_change_flags | devinet_ioctl | inet_ioctl | sock_ioctl | do_vfs_ioctl | ksys_ioctl | __arm64_sys_ioctl |

iommu_map | __iommu_dma_map | iommu_dma_map_page | __iommu_map_page | atl1c_alloc_rx_buffer | atl1c_configure | atl1c_up | atl1c_open | __dev_open | __dev_change_flags | dev_change_flags | devinet_ioctl | inet_ioctl | sock_ioctl | do_vfs_ioctl |

iommu_map | __iommu_dma_map | iommu_dma_map_page | __iommu_map_page | atl1c_alloc_rx_buffer | atl1c_configure | atl1c_up | atl1c_common_task | process_one_work | worker_thread | kthread | ret_from_fork |


In case anyone spots any glaring mistake...

Regards.
