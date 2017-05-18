Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Song Xiaowei <songxiaowei@hisilicon.com>
To: <bhelgaas@google.com>, <kishon@ti.com>, <jingoohan1@gmail.com>,
        <arnd@arndb.de>, <tn@semihalf.com>, <keith.busch@intel.com>,
        <niklas.cassel@axis.com>, <dhdang@apm.com>,
        <liudongdong3@huawei.com>
CC: <puck.chen@hisilicon.com>, <songxiaowei@hisilicon.com>,
        <guodong.xu@linaro.org>, <wangbinghui@hisilicon.com>,
        <suzhuangluan@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: [Patch v3 3/3] defconfig: PCI: Enable  Kirin PCIe defconfig
Date: Thu, 18 May 2017 15:45:35 +0800
Message-ID: <20170518074535.20635-2-songxiaowei@hisilicon.com>
In-Reply-To: <20170518074535.20635-1-songxiaowei@hisilicon.com>
References: <20170518074535.20635-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
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
