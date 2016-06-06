Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53375 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbcFFIOT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Jun 2016 04:14:19 -0400
Date: Mon, 6 Jun 2016 10:14:16 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/6] PCI: Add helpers to request/release memory and
 I/O regions
Message-ID: <20160606081416.qjv5hoqjfo2dmpov@c203.arch.suse.de>
References: <2a5ab5c7cdf2d068395a2c97c934c258ae8d58c0.1464795082.git.jthumshirn@suse.de>
 <201606050757.3lyBOdJT%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201606050757.3lyBOdJT%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 05, 2016 at 07:32:13AM +0800, kbuild test robot wrote:
> Hi,
> 
> [auto build test ERROR on jkirsher-next-queue/dev-queue]
> [also build test ERROR on v4.7-rc1 next-20160603]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Johannes-Thumshirn/Introduce-pci_-request-release-_-mem-io-_regions/20160602-153400
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
> config: mips-rt305x_defconfig (attached as .config)
> compiler: mips-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=mips 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from lib/pci_iomap.c:6:0:
>    include/linux/pci.h: In function 'pci_request_io_regions':
> >> include/linux/pci.h:2021:9: error: implicit declaration of function 'pci_request_selected_regions' [-Werror=implicit-function-declaration]
>      return pci_request_selected_regions(pdev,
>             ^
> >> include/linux/pci.h:2022:8: error: implicit declaration of function 'pci_select_bars' [-Werror=implicit-function-declaration]
>            pci_select_bars(pdev, IORESOURCE_IO), name);
>            ^
>    include/linux/pci.h: In function 'pci_release_io_regions':
>    include/linux/pci.h:2028:9: error: implicit declaration of function 'pci_release_selected_regions' [-Werror=implicit-function-declaration]
>      return pci_release_selected_regions(pdev,
>             ^
>    include/linux/pci.h:2028:9: warning: 'return' with a value, in function returning void
>    include/linux/pci.h: In function 'pci_release_mem_regions':
>    include/linux/pci.h:2042:9: warning: 'return' with a value, in function returning void
>      return pci_release_selected_regions(pdev,
>             ^
>    cc1: some warnings being treated as errors
> 
> vim +/pci_request_selected_regions +2021 include/linux/pci.h
> 
>   2015		return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) == PCI_DEV_FLAGS_ASSIGNED;
>   2016	}
>   2017	
>   2018	static inline int
>   2019	pci_request_io_regions(struct pci_dev *pdev, const char *name)
>   2020	{
> > 2021		return pci_request_selected_regions(pdev,
> > 2022				    pci_select_bars(pdev, IORESOURCE_IO), name);
>   2023	}
>   2024	
>   2025	static inline void
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Problem got addressed, waiting for an reply from Dick Kenedy on the lpfc patch
before re-submission,

Thanks for reporting,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
