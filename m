Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:5873 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756086AbdELCAy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2017 22:00:54 -0400
From: Song Xiaowei <songxiaowei@hisilicon.com>
To: <bhelgaas@google.com>, <kishon@ti.com>, <jingoohan1@gmail.com>,
        <arnd@arndb.de>, <tn@semihalf.com>, <keith.busch@intel.com>,
        <niklas.cassel@axis.com>, <dhdang@apm.com>,
        <liudongdong3@huawei.com>
CC: <puck.chen@hisilicon.com>, <songxiaowei@hisilicon.com>,
        <guodong.xu@linaro.org>, <wangbinghui@hisilicon.com>,
        <suzhuangluan@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH 2/2] defconfig: PCI: Enable  Kirin PCIe defconfig
Date: Fri, 12 May 2017 09:51:05 +0800
Message-ID: <20170512015105.32653-2-songxiaowei@hisilicon.com>
In-Reply-To: <20170512015105.32653-1-songxiaowei@hisilicon.com>
References: <20170512015105.32653-1-songxiaowei@hisilicon.com>
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
