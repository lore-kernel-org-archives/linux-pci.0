Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:58556 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754276AbeDZIyJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Apr 2018 04:54:09 -0400
Date: Thu, 26 Apr 2018 16:53:07 +0800
From: kbuild test robot <lkp@intel.com>
To: James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc: kbuild-all@01.org, Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: Add pci_bus_specific_read_dev_vendor_id() to
 workaround PCI switch specific issues prior to accessing newly added
 endpoint
Message-ID: <201804261643.iN9WvomQ%fengguang.wu@intel.com>
References: <16461819-82a1-8122-4a30-842f9a078988@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
In-Reply-To: <16461819-82a1-8122-4a30-842f9a078988@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi James,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pci/next]
[also build test ERROR on v4.17-rc2 next-20180426]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/James-Puthukattukaran/PCI-SUpport-to-workaround-bus-level-HW-issues/20180426-092305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: alpha-allnoconfig (attached as .config)
compiler: alpha-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

All errors (new ones prefixed by >>):

   drivers/pci/probe.o: In function `pci_bus_read_dev_vendor_id':
>> (.text+0x201c): undefined reference to `pci_bus_specific_read_dev_vendor_id'
   (.text+0x2044): undefined reference to `pci_bus_specific_read_dev_vendor_id'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--pWyiEgJYm5f9v55/
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
pMDE8iF6lP8DiO6iSOs7AAA=

--pWyiEgJYm5f9v55/--
