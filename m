Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 6/9] Add comment about why 32-bit read/modify/write isn't
 safe.
To: Shawn Lin <shawn.lin@rock-chips.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Date: Thu, 01 Sep 2016 11:44:43 -0500
Message-ID: <20160901164443.14195.13483.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160901163758.14195.15725.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160901163758.14195.15725.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


---
 drivers/pci/host/pcie-rockchip.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 17612e5..33bf2e1 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -282,6 +282,11 @@ static int rockchip_pcie_wr_own_conf(struct rockchip_pcie *rockchip,
 
 	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
 
+	/*
+	 * N.B. This read/modify/write isn't safe in general because it can
+	 * corrupt RW1C bits in adjacent registers.  But the hardware
+	 * doesn't support smaller writes.
+	 */
 	tmp = readl(rockchip->apb_base + PCIE_RC_CONFIG_BASE + offset) & mask;
 	tmp |= val << ((where & 0x3) * 8);
 	writel(tmp, rockchip->apb_base + PCIE_RC_CONFIG_BASE + offset);
