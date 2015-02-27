Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 27 Feb 2015 09:06:19 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH pci] PCI: pci_bus_max_busnr() can be static
Message-ID: <20150227010619.GA43777@lkp-sb04.lkp.intel.com>
References: <201502270911.8Duq6eJc%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201502270911.8Duq6eJc%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

drivers/pci/pci.c:111:15: sparse: symbol 'pci_bus_max_busnr' was not declared. Should it be static?

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2abac8f..51b24f3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -108,7 +108,7 @@ static bool pcie_ari_disabled;
  * Given a PCI bus, returns the highest PCI bus number present in the set
  * including the given PCI bus and its list of child PCI buses.
  */
-unsigned char pci_bus_max_busnr(struct pci_bus *bus)
+static unsigned char pci_bus_max_busnr(struct pci_bus *bus)
 {
 	struct pci_bus *tmp;
 	unsigned char max, n;
