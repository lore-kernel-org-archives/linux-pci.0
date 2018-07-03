Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56822 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbeGCBp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jul 2018 21:45:58 -0400
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PCI <linux-pci@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Subject: Coccinelle report for drivers/pci/
Message-ID: <7db07760-49fe-e94b-62fc-556ba02c8e9e@codeaurora.org>
Date: Mon, 2 Jul 2018 21:45:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


I ran coccinelle on drivers/pci directory of 4.18-rc3. I think this report needs some
attention from individual contributors to figure out which one is real which one is false
positive. devm stuff looked real to me.

make coccicheck MODE=report M=drivers/pci/

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

drivers/pci//endpoint/functions/pci-epf-test.c:166:7-14: WARNING opportunity for kmemdup
drivers/pci//hotplug/pnv_php.c:278:7-14: WARNING opportunity for kmemdup
drivers/pci//controller/dwc/pcie-qcom.c:703:1-3: WARNING: PTR_ERR_OR_ZERO can be used
drivers/pci//controller/pci-tegra.c:1132:1-3: WARNING: PTR_ERR_OR_ZERO can be used
drivers/pci//controller/dwc/pcie-kirin.c:141:1-3: WARNING: PTR_ERR_OR_ZERO can be used
drivers/pci//controller/dwc/pcie-kirin.c:177:1-3: WARNING: PTR_ERR_OR_ZERO can be used
drivers/pci//controller/dwc/pci-exynos.c:95:1-3: WARNING: PTR_ERR_OR_ZERO can be used
drivers/pci//controller/pcie-mediatek.c:441:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem
drivers/pci//probe.c:2828:1-6: WARNING: invalid free of devm_ allocated data
drivers/pci//probe.c:586:1-6: WARNING: invalid free of devm_ allocated data
drivers/pci//controller/pci-hyperv.c:1687:31-33: ERROR: reference preceded by free on line 1668
drivers/pci//hotplug/pnv_php.c:159:2-13: ERROR: probable double put.
drivers/pci/pci.c:5316:6-12: WARNING: Comparison to bool
drivers/pci/pci.c:5332:7-13: WARNING: Comparison to bool
drivers/pci/hotplug/cpqphp_core.c:734:1-11: WARNING: Assignment of bool to 0/1
drivers/pci/controller/pcie-altera.c:142:2-15: code aligned with following code on line 144
drivers/pci/hotplug/pciehp_pci.c:67:5-7: Unneeded variable: "rc". Return "0" on line 110
drivers/pci/hotplug/pcihp_skeleton.c:98:5-11: Unneeded variable: "retval". Return "0" on line 106
drivers/pci/hotplug/pcihp_skeleton.c:84:5-11: Unneeded variable: "retval". Return "0" on line 92
drivers/pci/hotplug/pcihp_skeleton.c:201:5-11: Unneeded variable: "retval". Return "0" on line 210
drivers/pci/hotplug/pcihp_skeleton.c:171:5-11: Unneeded variable: "retval". Return "0" on line 180
drivers/pci/hotplug/pcihp_skeleton.c:186:5-11: Unneeded variable: "retval". Return "0" on line 195
drivers/pci/hotplug/pcihp_skeleton.c:156:5-11: Unneeded variable: "retval". Return "0" on line 165
drivers/pci/hotplug/pcihp_skeleton.c:137:5-11: Unneeded variable: "retval". Return "0" on line 150
drivers/pci/hotplug/pcihp_skeleton.c:112:5-11: Unneeded variable: "retval". Return "0" on line 131
drivers/pci/hotplug/shpchp_pci.c:66:5-7: Unneeded variable: "rc". Return "0" on line 86


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
