Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:30485 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbeHMLvo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Aug 2018 07:51:44 -0400
Date: Mon, 13 Aug 2018 17:09:29 +0800
From: kbuild test robot <lkp@intel.com>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: Re: [PATCH 4/4] PCI: xilinx-nwl: Add method to
 setup_platform_service_irq hook
Message-ID: <201808131647.wzxWvkIy%fengguang.wu@intel.com>
References: <1533915580-31805-5-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1533915580-31805-5-git-send-email-bharat.kumar.gogada@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bharat,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on v4.18 next-20180810]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bharat-Kumar-Gogada/Add-support-to-register-platform-service-IRQ/20180813-144216
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/pci/controller/pcie-xilinx-nwl.c:823:5: sparse: symbol 'nwl_setup_service_irqs' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
