Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] PCI: rockchip: assert PERST# in S3
Date: Thu, 12 Oct 2017 13:52:17 -0700
Message-Id: <20171012205220.130048-1-briannorris@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Brian Norris <briannorris@chromium.org>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Rajat Jain <rajatja@google.com>,
 Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

This patch series should mostly be self-descriptive, but it's motivated by the
fact that I've found differing requirements from PCIe endpoint makers regarding
the state of PERST# when in system suspend (S3). Additionally, some existing
boards are not especially well suited for holding PERST# low in S3 (e.g., the
pin is driven by a non-PMU GPIO, so it's hard or impossible to keep it
asserted). So the solution is...give it a device tree property!

Brian

Brian Norris (3):
  Documentation/devicetree: Add pcie-reset-suspend property
  of/pci: Add of_pci_get_pcie_reset_suspend() to parse
    pcie-reset-suspend
  PCI: rockchip: Support configuring PERST# state via DT

 Documentation/devicetree/bindings/pci/pci.txt | 11 +++++++++++
 drivers/of/of_pci.c                           | 25 +++++++++++++++++++++++++
 drivers/pci/host/pcie-rockchip.c              |  7 +++++++
 include/linux/of_pci.h                        |  7 +++++++
 4 files changed, 50 insertions(+)

-- 
2.15.0.rc0.271.g36b669edcc-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
