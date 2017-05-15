Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:6302 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759323AbdEOGfL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2017 02:35:11 -0400
From: Song Xiaowei <songxiaowei@hisilicon.com>
To: <bhelgaas@google.com>, <kishon@ti.com>, <jingoohan1@gmail.com>,
        <arnd@arndb.de>, <tn@semihalf.com>, <keith.busch@intel.com>,
        <niklas.cassel@axis.com>, <dhdang@apm.com>,
        <liudongdong3@huawei.com>
CC: <puck.chen@hisilicon.com>, <songxiaowei@hisilicon.com>,
        <guodong.xu@linaro.org>, <wangbinghui@hisilicon.com>,
        <suzhuangluan@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH 3/3] defconfig: PCI: Enable  Kirin PCIe defconfig
Date: Mon, 15 May 2017 14:27:45 +0800
Message-ID: <20170515062745.70082-3-songxiaowei@hisilicon.com>
In-Reply-To: <20170515062745.70082-1-songxiaowei@hisilicon.com>
References: <20170515062745.70082-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Cc: Guodong Xu <guodong.xu@linaro.org>
Signed-off-by: Song Xiaowei <songxiaowei@hisilicon.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7c48028ec64a..d56d8f1062ab 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -71,6 +71,7 @@ CONFIG_PCI_XGENE=y
 CONFIG_PCI_LAYERSCAPE=y
 CONFIG_PCI_HISI=y
 CONFIG_PCIE_QCOM=y
+CONFIG_PCIE_KIRIN=y
 CONFIG_PCIE_ARMADA_8K=y
 CONFIG_ARM64_VA_BITS_48=y
 CONFIG_SCHED_MC=y
-- 
2.11.GIT
