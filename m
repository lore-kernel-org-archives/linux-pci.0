Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Xiaowei Song <songxiaowei@hisilicon.com>
To: <guodong.xu@linaro.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>
CC: <songxiaowei@hisilicon.com>, <suzhuangluan@hisilicon.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 3/3] ARM4: defconfig: Enable  Kirin PCIe
Date: Mon, 19 Jun 2017 18:08:34 +0800
Message-ID: <20170619100834.43321-4-songxiaowei@hisilicon.com>
In-Reply-To: <20170619100834.43321-1-songxiaowei@hisilicon.com>
References: <20170619100834.43321-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Cc: Guodong Xu <guodong.xu@linaro.org>
Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
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
