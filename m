Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45352 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbbJLVWP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 12 Oct 2015 17:22:15 -0400
Date: Tue, 13 Oct 2015 05:21:23 +0800
From: kbuild test robot <lkp@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] PCI: pciehp: Queue power work requests in dedicated
 function
Message-ID: <201510130546.Iddntrqh%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444677013-3836-1-git-send-email-linux@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Guenter,

[auto build test WARNING on pci/next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Guenter-Roeck/PCI-pciehp-Queue-power-work-requests-in-dedicated-function/20151013-031144
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/pci/hotplug/pciehp_ctrl.c:207:6: sparse: symbol 'pciehp_queue_power_work' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
