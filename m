Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 19 Oct 2015 17:29:33 +0800
From: kbuild test robot <lkp@intel.com>
To: Ley Foon Tan <lftan@altera.com>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
	lftan.linux@gmail.com, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH] pci:host: altera_pcie_fixups() can be static
Message-ID: <20151019092933.GA19329@lkp-nex05>
References: <201510191737.ufAp63BH%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445242768-4423-4-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 pcie-altera.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index b5e7bc2..45f03e3 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -114,7 +114,7 @@ static void altera_pcie_fixup_res(struct pci_dev *dev)
 	}
 }
 
-void altera_pcie_fixups(struct pci_bus *bus)
+static void altera_pcie_fixups(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
