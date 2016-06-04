Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12065 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbcFDXdv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 4 Jun 2016 19:33:51 -0400
Date: Sun, 5 Jun 2016 07:32:13 +0800
From: kbuild test robot <lkp@intel.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v2 1/6] PCI: Add helpers to request/release memory and
 I/O regions
Message-ID: <201606050757.3lyBOdJT%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
In-Reply-To: <2a5ab5c7cdf2d068395a2c97c934c258ae8d58c0.1464795082.git.jthumshirn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[also build test ERROR on v4.7-rc1 next-20160603]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Johannes-Thumshirn/Introduce-pci_-request-release-_-mem-io-_regions/20160602-153400
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: mips-rt305x_defconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   In file included from lib/pci_iomap.c:6:0:
   include/linux/pci.h: In function 'pci_request_io_regions':
>> include/linux/pci.h:2021:9: error: implicit declaration of function 'pci_request_selected_regions' [-Werror=implicit-function-declaration]
     return pci_request_selected_regions(pdev,
            ^
>> include/linux/pci.h:2022:8: error: implicit declaration of function 'pci_select_bars' [-Werror=implicit-function-declaration]
           pci_select_bars(pdev, IORESOURCE_IO), name);
           ^
   include/linux/pci.h: In function 'pci_release_io_regions':
   include/linux/pci.h:2028:9: error: implicit declaration of function 'pci_release_selected_regions' [-Werror=implicit-function-declaration]
     return pci_release_selected_regions(pdev,
            ^
   include/linux/pci.h:2028:9: warning: 'return' with a value, in function returning void
   include/linux/pci.h: In function 'pci_release_mem_regions':
   include/linux/pci.h:2042:9: warning: 'return' with a value, in function returning void
     return pci_release_selected_regions(pdev,
            ^
   cc1: some warnings being treated as errors

vim +/pci_request_selected_regions +2021 include/linux/pci.h

  2015		return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) == PCI_DEV_FLAGS_ASSIGNED;
  2016	}
  2017	
  2018	static inline int
  2019	pci_request_io_regions(struct pci_dev *pdev, const char *name)
  2020	{
> 2021		return pci_request_selected_regions(pdev,
> 2022				    pci_select_bars(pdev, IORESOURCE_IO), name);
  2023	}
  2024	
  2025	static inline void

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--Kj7319i9nmIyA2yE
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
NcHGVWUAAA==

--Kj7319i9nmIyA2yE--
