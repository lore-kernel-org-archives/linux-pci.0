Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 06/15] Add comment about why 32-bit read/modify/write
 isn't safe.
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
Date: Fri, 02 Sep 2016 10:54:44 -0500
Message-ID: <20160902155444.8650.28870.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


---
 drivers/pci/host/pcie-rockchip.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index ea75f35..c0c3ad5 100644
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
