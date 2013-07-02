Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:37147 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750832Ab3GBEml (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jul 2013 00:42:41 -0400
Message-ID: <51D25A13.9060006@st.com>
Date: Tue, 2 Jul 2013 10:11:55 +0530
From: Pratyush Anand <pratyush.anand@st.com>
MIME-Version: 1.0
To: Sean Cross <xobs@kosagi.com>, Arnd Bergmann <arnd@arndb.de>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Jingoo Han <jg1.han@samsung.com>
Cc: "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/4] PCI: Add driver for i.MX6 PCI Express
References: <1372662947-27160-1-git-send-email-xobs@kosagi.com> <1372662947-27160-4-git-send-email-xobs@kosagi.com> <51D15513.7020101@st.com> <2E3BDF14016345FA887E3BACAE05DADA@kosagi.com>
In-Reply-To: <2E3BDF14016345FA887E3BACAE05DADA@kosagi.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/2/2013 9:16 AM, Sean Cross wrote:
>> >I may be wrong, but from these offset it seems to me that it is SNPS
>> >controller. If yes, then please go through comments of
>> >"[PATCH V1-10 0/4] PCIe support for Samsung Exynos5440 SoC"
> Exynos5440 appears to use the same port logic controller.  However, the PHYs are different.  I'm not exactly certain which comments you want me to notice in that series of patchsets, but I see references to splitting Exynos-specific code into its own project.  Based on that, it seems like the best approach would be to:
>
>      1) Move Exynos code into its own file, say, pcie-exynos.c.  This would leave only Synopsys-specific ATC code in pcie-designware.c
>      2) Rename generic exynos functions to reflect the fact that they're designware-generic functions.
>      3) Have pcie-imx.c reference this generic designware ATC code.
>
> I'll rework the patch and re-submit it following these three changes.

Correct, Exactly these steps has to be done. But, Mohit might be doing 
similar work, so it would be better to get consensus on what has to be done.

IMO, there should be three categories of functions. May be arnd can 
comment if we can do even something better.

Group I: Initially, These functions should remain in pcie-designware.c 
(offcourse by changing exynos tag to dw). Latter on, we can see if some 
of them can even be moved to common pci layer.

sys_to_pcie
cfg_read
cfg_write
dw_pcie_prog_viewport_cfg0
dw_pcie_prog_viewport_cfg1
dw_pcie_prog_viewport_mem_outbound
dw_pcie_prog_viewport_io_outbound
dw_pcie_rd_other_conf
dw_pcie_wr_other_conf
dw_pcie_setup
dw_pcie_valid_config
dw_pcie_rd_conf
dw_pcie_wd_conf
dw_pcie_scan_bus
dw_pcie_map_irq
dw_pcie_setup_rc
add_pcie_port (after a bit of generalization)
dw_pcie_probe
dw_pcie_remove


Group II: These functions should still remain as dummy in 
pcie-designware.c , and should be classified as __week. So, each 
implementer of designware controller say Exynos/SPEAr/imx will have to 
define their own function to super-seed default dummy definitions.

dw_readl_rc
dw_writel_rc
dw_pcie_rd_own_conf
dw_pcie_wr_own_conf
dw_pcie_link_up
dw_pcie_host_init (will contain all platform specific and phy 
initialization)

Group III: Functions specific to Exynos, which should move to pcie-exynos.c

exynos_pcie_sideband_dbi_w_mode
exynos_pcie_sideband_dbi_r_mode
exynos_pcie_assert_core_reset
exynos_pcie_deassert_core_reset
exynos_pcie_assert_phy_reset
exynos_pcie_deassert_phy_reset
exynos_pcie_init_phy
exynos_pcie_assert_reset
exynos_pcie_establish_link


@Mohit, See if you have BW then please take it further.

arnd, are exynos patches applied to any branch of arm-soc git tree?

Regards
Pratyush





