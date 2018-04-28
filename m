Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:5056 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751310AbeD1WwZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Apr 2018 18:52:25 -0400
Date: Sun, 29 Apr 2018 06:52:03 +0800
From: kbuild test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: kbuild-all@01.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/9] PCI: Add new helper for allocating irq domain for
 INTx
Message-ID: <201804290648.Bggca0DD%fengguang.wu@intel.com>
References: <1524817367-239076-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
In-Reply-To: <1524817367-239076-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Shawn,

I love your patch! Yet something to improve:

[auto build test ERROR on pci/next]
[also build test ERROR on v4.17-rc2 next-20180426]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shawn-Lin/Add-new-helper-to-allocate-irq-domain-for-hosts/20180429-053656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: i386-alldefconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from arch/x86//kernel/cpu/mtrr/main.c:46:0:
   include/linux/pci.h: In function 'pci_alloc_intx_irqd':
>> include/linux/pci.h:1510:11: error: implicit declaration of function 'irq_domain_add_linear'; did you mean 'irq_domain_get_of_node'? [-Werror=implicit-function-declaration]
     domain = irq_domain_add_linear(intc, PCI_NUM_INTX,
              ^~~~~~~~~~~~~~~~~~~~~
              irq_domain_get_of_node
>> include/linux/pci.h:1510:9: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     domain = irq_domain_add_linear(intc, PCI_NUM_INTX,
            ^
   cc1: some warnings being treated as errors

vim +1510 include/linux/pci.h

  1466	
  1467	/**
  1468	 * pci_alloc_intx_irqd() - PCI helper for allocating INTx irq domain
  1469	 * @dev: device associated with the PCI controller.
  1470	 * @host: pointer to host specific data struct
  1471	 * @general_xlate: flag for whether use pci_irqd_intx_xlate() helper
  1472	 * @intx_domain_ops: pointer to driver specific struct irq_domain_ops
  1473	 * @local_intc: pointer to driver specific interrupt controller node
  1474	 *
  1475	 * A simple helper for drivers to allocate irq domain for INTx. If
  1476	 * intx_domain_ops is NULL, use pci_intx_domain_ops by defalut. And if
  1477	 * local_intc is present, then use it firstly, otherwise, fallback to get
  1478	 * interrupt controller node from @dev.
  1479	 *
  1480	 * Returns valid pointer of struct irq_domain on success, or PTR_ERR(-EINVAL)
  1481	 * if failure occurred.
  1482	 */
  1483	static __maybe_unused struct irq_domain *pci_alloc_intx_irqd(struct device *dev,
  1484					void *host, bool general_xlate,
  1485					const struct irq_domain_ops *intx_domain_ops,
  1486					struct device_node *local_intc)
  1487	{
  1488		struct device_node *intc = local_intc;
  1489		struct irq_domain *domain;
  1490		const struct irq_domain_ops *irqd_ops;
  1491		bool need_put = false;
  1492	
  1493		if (!intc) {
  1494			intc = of_get_next_child(dev->of_node, NULL);
  1495			if (!intc) {
  1496				dev_err(dev, "missing child interrupt-controller node\n");
  1497				return ERR_PTR(-EINVAL);
  1498			}
  1499			need_put = true;
  1500		}
  1501	
  1502		if (intx_domain_ops) {
  1503			irqd_ops = intx_domain_ops;
  1504		} else {
  1505			if (general_xlate)
  1506				pci_intx_domain_ops.xlate = &pci_irqd_intx_xlate;
  1507			irqd_ops = &pci_intx_domain_ops;
  1508		}
  1509	
> 1510		domain = irq_domain_add_linear(intc, PCI_NUM_INTX,
  1511					       irqd_ops, host);
  1512		if (!domain) {
  1513			dev_err(dev, "failed to get a INTx IRQ domain\n");
  1514			if (need_put)
  1515				of_node_put(intc);
  1516			return ERR_PTR(-EINVAL);
  1517		}
  1518	
  1519		return domain;
  1520	}
  1521	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--5mCyUwZo2JvN/JJP
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
aJjYSP0f9HfkuEeWAAA=

--5mCyUwZo2JvN/JJP--
