Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Kumar Gala <galak@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v3 0/3] pci: remove msi_controller registration API
Date: Tue, 28 Feb 2017 15:31:13 +0100
Message-Id: <1488292276-11106-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>,
 Jason Cooper <jason@lakedaemon.net>, Hanna Hawa <hannah@marvell.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This small patch series aims at removing the small msi_controller
registration API implemented in drivers/of/of_pci.c.

In order to do so, it moves the last two users of this API to the
generic MSI support:

 - The pci-aardvark driver is moved to use the generic MSI
   support. This driver is both the provider of the MSI capability and
   the consumer of this capability.

 - The pci-mvebu driver is cleaned up from using the msi_controller
   registration API. This driver is only consuming MSI capabilies from
   another driver (irq-armada-370-xp) which was migrated to the
   generic MSI support some time ago. Therefore, this patch is simply
   removing dead code.

Finally, the last commit removed the now unused API.

Changes between v2 and v3 are described in each individual patch.

Thanks,

Thomas

Thomas Petazzoni (3):
  pci: pci-aardvark: move to MSI handling using generic MSI support
  pci: pci-mvebu: remove useless MSI enabling code
  of: pci: remove unused MSI controller helpers

 drivers/of/of_pci.c             |  45 -----------
 drivers/pci/host/pci-aardvark.c | 173 ++++++++++++++++------------------------
 drivers/pci/host/pci-mvebu.c    |  17 ----
 include/linux/of_pci.h          |  11 ---
 4 files changed, 67 insertions(+), 179 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
